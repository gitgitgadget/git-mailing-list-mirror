Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFD42EC0A2
	for <git@vger.kernel.org>; Sat, 14 Mar 2026 18:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773514452; cv=pass; b=j5uOL9hJbRSNRh039g/F0JORUTjJFbu/UGM2DHIn8sbIV326ccvSYlt8VFGHEYEYAB91lm8G8lWbxqRx5x1f7hg4W6izlQfvL943gFuaSM+rPEXiJnnwRjx3uWbeOB5B0+A3BS/03dwaWQSQ+MB/eB7CFh+JiIRbWP1IPXjcScg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773514452; c=relaxed/simple;
	bh=1QFhuqQW8BOB7UilldUQVtJ8+PbLqQJl99X/pniWS3o=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Subject:Cc:From:
	 References:In-Reply-To; b=WpKOKBTHfIOv0aZ8ArsSeuTCIsWIDTewnMWEM3NiSGK3yr/iHG2Hv44smmU/yCRrWAth0MldyZP7Cv8WODyYsaXKdWwrXC6UHJU9fSVVK9/EfJputrwgjbz0czyF03W4EwkbuzYpnGveWKaebnH30Guiujo0cL2pYeAnd0KJhzw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ritovision.com; spf=pass smtp.mailfrom=ritovision.com; dkim=pass (1024-bit key) header.d=ritovision.com header.i=rito@ritovision.com header.b=UM6yBPmU; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ritovision.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ritovision.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ritovision.com header.i=rito@ritovision.com header.b="UM6yBPmU"
ARC-Seal: i=1; a=rsa-sha256; t=1773514445; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Hld6CDI798YePJwhC5k3iWrGh2yX5WGxOrBwTar5hcfX3tXFIi0cVogBsamvV9IxM6CRY8YagEyLYMazsGBR52HjYzgj+OdKhOkQzzXV/yG4Dx99x0dP+YAyfs/i8rNHHbtQ8yfdSeOag8EYByzBdg9kQReCYeFh5Icra3zlbJU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1773514445; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=1QFhuqQW8BOB7UilldUQVtJ8+PbLqQJl99X/pniWS3o=; 
	b=SCB80xJX3JV2bP9m1xDcOwcvPoRGtG3/G6EBZXjWPK7kpglX+Vv5QNwh0isJSWAfNVc4VfzSSgmzFAIWO4k0i7x9/JciMWWJOkVbe5FrL5kOVlEfiwrYlf1WU3WkfOqY1o9dIYHkF4ZnPFSxVk+YY+h6d1LjuSWH06T4/DFeNhc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=ritovision.com;
	spf=pass  smtp.mailfrom=rito@ritovision.com;
	dmarc=pass header.from=<rito@ritovision.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773514445;
	s=zmail; d=ritovision.com; i=rito@ritovision.com;
	h=Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Date:Message-Id:Message-Id:To:To:Subject:Subject:Cc:Cc:From:From:References:In-Reply-To:Reply-To;
	bh=1QFhuqQW8BOB7UilldUQVtJ8+PbLqQJl99X/pniWS3o=;
	b=UM6yBPmUhFSrtpp6d3NIkPdQ6LHn1P1xpwL6+IBrgDohYBz2B4axX1dHa6Ylo/sl
	285o4j8QgoprK9IHUO6oDvsng8YKDxpTVzjLElzhGwD2MaJL3Y7IIljPh1Ymq2uxiHX
	RpaUfJvbFSp05QIeIX58hZyulH0dOzPU+Hob/oDI=
Received: by mx.zohomail.com with SMTPS id 1773514444290976.635521354662;
	Sat, 14 Mar 2026 11:54:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 14 Mar 2026 14:54:01 -0400
Message-Id: <DH2QEESY177X.15A2VGNLZ6EIC@ritovision.com>
To: "Junio C Hamano" <gitster@pobox.com>, "Rito Rhymes"
 <rito@ritovision.com>
Subject: Re: GitGitGadget's website is responsive, how about kernel.org?
Cc: "Konstantin Ryabitsev" <konstantin@linuxfoundation.org>, "Johannes
 Schindelin" <Johannes.Schindelin@gmx.de>, <git@vger.kernel.org>
From: "Rito Rhymes" <rito@ritovision.com>
X-Mailer: aerc 0.21.0
References: <fbe96a44-2f97-4310-3e2e-34e5bd02d4a4@gmx.de>
 <20260313-loose-whale-of-speed-ccdbe2@lemur>
 <DH1OK0NDO2D5.1BKGX8J7KWW52@ritovision.com>
 <20260313-adventurous-lemon-unicorn-278ccc@lemur>
 <xmqqtsuj7mcf.fsf@gitster.g> <DH2ADSKXNCXG.2DM7T0NF5NH59@ritovision.com>
 <xmqqv7eywe4t.fsf@gitster.g>
In-Reply-To: <xmqqv7eywe4t.fsf@gitster.g>
X-ZohoMailClient: External

I see where you're coming from, Junio. I don't want to distract people,
and I guess there's also the matter of review fit, where not many people
here are inclined to contribute to websites, so there may be more
suitable venues for this elsewhere.

Konstantin, whatever venue you decide is cool with me.

Rito
