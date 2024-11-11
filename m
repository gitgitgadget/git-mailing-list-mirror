Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32532199939
	for <git@vger.kernel.org>; Mon, 11 Nov 2024 14:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731334726; cv=none; b=QpMkm06eogJzFhyQAQTM5BTyjln9tlALHICUp9Obwhtz7q1lv2wpBEQdRwMYsr5ectVP8K9oXSDqBlLtfjyR+C1UxMkEgPZJYKFGW8DtKvKpOf4Xz54oG4je15dUMS82Mz2JXWdDK3nBaHktaISXD34bNhSa90gFsyG+Re1rSvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731334726; c=relaxed/simple;
	bh=pIwBEwiE+Ou72Kin+nb2z4RdIBsdCz6SQ0+Cz6gOeSM=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QOL6OY9OHL8y30teyWNaPskdZ03Kltbl79BBlwm/Lv4gYGl1c9gpKHNcbfUHAm2rWMogVl1zgUjT5zYc3ijzwXujeFdzf0DzAAvbD0vFUBazOm/San7bRrf5a/OaMJbepiSY/kA3IXvccRjJCBVcVzgiPbrQBhrrW7ZzgIiyIDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mad-scientist.net; spf=pass smtp.mailfrom=mad-scientist.net; dkim=policy (768-bit key) header.d=mad-scientist.us header.i=@mad-scientist.us header.b=y94H04+5 reason="signing key too small"; arc=none smtp.client-ip=44.202.169.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mad-scientist.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mad-scientist.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=policy reason="signing key too small" (768-bit key) header.d=mad-scientist.us header.i=@mad-scientist.us header.b="y94H04+5"
Received: from eig-obgw-5005a.ext.cloudfilter.net ([10.0.29.234])
	by cmsmtp with ESMTPS
	id ATJptD2txiA19AVFWt6Yys; Mon, 11 Nov 2024 14:18:38 +0000
Received: from box5922.bluehost.com ([162.241.30.80])
	by cmsmtp with ESMTPS
	id AVFVtLV9ojcdmAVFVtcD30; Mon, 11 Nov 2024 14:18:37 +0000
X-Authority-Analysis: v=2.4 cv=DrWd+3/+ c=1 sm=1 tr=0 ts=6732123d
 a=u+82WREdhvUKZ7QTvcqjvQ==:117 a=u+82WREdhvUKZ7QTvcqjvQ==:17
 a=IkcTkHD0fZMA:10 a=VlfZXiiP6vEA:10 a=e_eVUG9BRDgA:10
 a=HUWKhlqP88nT-pA18xAA:9 a=QEXdDO2ut3YA:10 a=9XL2PSxQjqKr3s6xf5LH:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=mad-scientist.us; s=default; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:Reply-To:From:Subject:Message-ID:
	Sender:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=YdN2QuDoAsK0weYFISKiuOV0/mUfjKzpVOdbkfgj38I=; b=y94H04+58Pirh/QqHc4KGCIwo3
	UYZXreV/PKOOtIBMilCjMrZVSsF0uRW0D0vQvrXVI7G2mXjOPci/feDnAshQvRjJMRmBtBzw+Pl8B
	bV9aEhfw5RXQ1P0YSusQR15UA;
Received: from [160.231.28.5] (port=23746 helo=llin-psh13-dsa.dsone.3ds.com)
	by box5922.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <paul@mad-scientist.net>)
	id 1tAVFV-002lv0-06
	for git@vger.kernel.org;
	Mon, 11 Nov 2024 07:18:37 -0700
Message-ID: <99357763a692a0446624f59199fc91f683d2658f.camel@mad-scientist.net>
Subject: Re: [RFC PATCH v4 05/19] Makefile: use "generate-perl.sh" to
 massage Perl library
From: Paul Smith <paul@mad-scientist.net>
Reply-To: paul@mad-scientist.net
To: git@vger.kernel.org
Date: Mon, 11 Nov 2024 09:18:35 -0500
In-Reply-To: <ZzIQ8zENlz-0CZBX@pks.im>
References: <cover.1727881164.git.ps@pks.im>
	 <cover.1729771605.git.ps@pks.im>
	 <eddafe1cf8935fd25d107645168ace3f65e1064c.1729771605.git.ps@pks.im>
	 <6a608200-2dd5-4505-9e1d-1e161ae2896c@gmail.com> <ZzIQ8zENlz-0CZBX@pks.im>
Organization: Please remain calm--I may be mad but I am a professional!
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box5922.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mad-scientist.net
X-BWhitelist: no
X-Source-IP: 160.231.28.5
X-Source-L: No
X-Exim-ID: 1tAVFV-002lv0-06
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (llin-psh13-dsa.dsone.3ds.com) [160.231.28.5]:23746
X-Source-Auth: paul@mad-scientist.us
X-Email-Count: 1
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: bWFkc2NpZTE7bWFkc2NpZTE7Ym94NTkyMi5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfC4YoSgvgqjVrzG3b8lg4qvgZTKfFBkPRprse5NmM9+WMAfLetQbBw2TnHflTwYJPeE6DVTfrwl7w3ox9MkV5JahMoBB9Swwe2ui2kgf+nQrUdaCEY0Y
 7tw5YUlasqmxBykx4ydYCRwKktvhClyMiI8ZYIbeIu5vYS9/Etv0oTTdAHzb1u66cjGO5pQbryOwzW80atLtMsB8FJ3dH2ayDrY=

On Mon, 2024-11-11 at 15:13 +0100, Patrick Steinhardt wrote:
> > case "$OUTPUT" in
> > *.pm)
> > =C2=A0 dir=3D"$(dirname $OUTPUT)"
> > =C2=A0 if ! test -d "$dir"
> > =C2=A0 then
> > =C2=A0 mkdir -p "$dir"
> > =C2=A0 fi
> > =C2=A0=C2=A0=C2=A0=C2=A0 ;;
> > esac

This seems kind of complicated to me.  Why not just simply:

  case "$OUTPUT" in
    (*.pm) mkdir -p "$(dirname $OUTPUT)" ;;
  esac

There's no point in testing for existence of the directory before
invoking mkdir -p IMO.

Maybe the git environment has some rules about this?
