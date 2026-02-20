Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D105E3EBF28
	for <git@vger.kernel.org>; Fri, 20 Feb 2026 10:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771583382; cv=none; b=kJUUM13XyiHXAR9uu58lNh6fl8Q0LGKoIOgxBXje4XXKQvNF2dZR39gtV5AK0i6Y/1xEYVutEah25sqX+Rmf+cWBxkjhQBH0xM9Wur3+eTctecJUf6Q6+vVIv8N0PgVAHZUf+ICb5QrRVjr2nTgL82DJDUEbSI1MwxqPpcGjVpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771583382; c=relaxed/simple;
	bh=3YWjTe+5FWkLWFpeuYVMH/fRrGWmFZOpICglSAX8KN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q9KouBfvFgq7/dZluNPxmDVHCBoaHE5xKG1oUgRM2FH6aP3xcmX8wtGwEZQUMC7Nf8vokVA8nkMt+8ZJZJK1AYzdOErDrNMxldMYQ+WXSR9dP+14s/qNY4o+LpbMtC2IdwVL5AhXlb/hDm9arWn7mH+hJXQ0skYHBE35TwuQW38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b=Gfm+Lfj0; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b="Gfm+Lfj0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1771583379; x=1772188179;
	i=oswald.buddenhagen@gmx.de;
	bh=3YWjTe+5FWkLWFpeuYVMH/fRrGWmFZOpICglSAX8KN4=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Gfm+Lfj0ElZisKbgT9ps6t95QGaSl00IvhcUpUGOJqHLUf/IQ+rWnB2h1bhvMbjS
	 4GT4YZWz94z5CIM/dwvk9iqDzDzmkj1vlmsLanH61GH+WkUqqGpWlNC2NCd1YfDEs
	 m3i9jph0FMSbvml+MhG7SdLCwB+VnK3q4iZangkVmlm4WkW7t9DjK5D3PKpjqYaAf
	 TIJ5LH4DzMNWeZ2DGS9o8GMvfvCmaidfRGZy5qAOGyzHa7PU9/Rt7hY8SLlaJfNot
	 a7KN1BigURDVX0+PhOVuj1ok30ypgNftZ3hNzv1nNapHnfUyt8wez1fAtlzelMKCO
	 zAedf5R8GhK52A/8vw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from ugly.fritz.box ([89.247.162.101]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MYeMj-1wGDi53pqd-00LlL1; Fri, 20
 Feb 2026 11:29:38 +0100
Received: by ugly.fritz.box (MasqMail 1.0.0, from userid 1000)
	id 1vtNlS-xxl-00; Fri, 20 Feb 2026 11:29:38 +0100
Date: Fri, 20 Feb 2026 11:29:38 +0100
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 05/17] refs: remove unused
 `refs_for_each_include_root_ref()`
Message-ID: <aZg3krJEqj3Vs76p@ugly.lan>
References: <20260220-pks-refs-for-each-unification-v1-0-17170bd99de1@pks.im>
 <20260220-pks-refs-for-each-unification-v1-5-17170bd99de1@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260220-pks-refs-for-each-unification-v1-5-17170bd99de1@pks.im>
X-Provags-ID: V03:K1:VnUO671B2QGtveSUaurYte6ZtIDbmv6jjR6vy8uR0I+Cza/UqO8
 gWEbmWPMkQ5pzTf77PBZllTJEOZs6jZyBKIVQlT6+iXYYcHoPSy5coPWpqpothYppSiluiN
 WzTTCG1Sm2J1rguz9xHiqfqpBYqiHGFo0Il0Tk4QU32BXqkZG4nTIdnkY63afzbqXgZvopu
 884ZDpdBCjpZW0AqAoFAg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:U5Uczw3SfdA=;+C+RcwO/eb+2ZiNry3KUuujk46l
 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
 ROkmyJsv+FNX9/4SE=
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 20, 2026 at 09:24:09AM +0100, Patrick Steinhardt wrote:
>Remove the unused `refs_for_each_include_root_ref()` function.
>
at first sight it would seem sensible to move this to the start of the=20
series to reduce churn.
