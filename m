Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793965197;
	b=CfhBUgXMPHa1pSyAByKjTJZKoHCFCyoCqORQpNSKttWtr93Cl/JjEpTyWYkVPk0r6aht
	 hVs9xxecB4iEbQZlg/YFRPPtU97LfOHb5Ovsgji+hV9d+la4cuZ0vuJZyLSoricf4O787
	 H5tPatE80w/uocWHeu2EqjgQvbsXg72Avy4O/bKfvOkFj70Ei57iuyLLSOpG+imV7X2D0
	 o5GHWGmcNCyeFHq1CQ0IrjMt0ETRZOnjq4ys4o6lNAQax5HMU21SGqGC9godjGY1PhodJ
	 h9NsiH9yMYmet+vOMb/bpDE1A/2eQIBkcOyl9MiBri/aRbtFkfo1x4pVMeAkFGnGJ4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793965197;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=d1c1Kg6tAb3mIq7oug6qeqAkcptl0gkGURvqnWGyRrk=;
	b=0/y6SyxMm8f9voBbx3HDUrJxxF0yFuavntLBSqQSHo+QR2UVMfMrQeSDBKC+n+In7Dbn
	 qWuheyW9IU85fYV1pb9TPfAq3ozwC1sJJ669rFZk0ACdBkms8idiJ6N4HBw5uQ4N8JduE
	 Gtm7Bql0S/LfLRD+cxKlnoi1cAEl5349EQ2cIMHVXdSSzYcWJRToXkKbqquXwh1oNw0Fg
	 4kLi7F9qr+H6DUQiMQ9bd2hBp76kbXMxPjw9ueJK01GLI8aAVH3jx5q1wbFaHi0XvBxTg
	 vtXPVhJTXUlyMsxkLcAZb8R2jv7x5i3ZRmw9mRhv9K0jGEMr34O6aubaz3NI9qKUNdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=yeyzfb4S;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=dOKAE95h;
	arc=none smtp.remote-ip=103.168.172.148
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0681606A900
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 11:39:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0681606A900
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=yeyzfb4S;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=dOKAE95h
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id B30D0EC020C
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 06:39:55 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Fri, 06 Nov 2026 06:39:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1793965195; x=1794051595; bh=d1c1Kg6tAb
	3mIq7oug6qeqAkcptl0gkGURvqnWGyRrk=; b=yeyzfb4ST0epDpm5RFiY/0tw9s
	d9N7VDW9aHKZf3qiBHYdlHmdXLnEgYehG+84x3vbfXzRsVGltwddnA734v+ZVEh4
	uNOwnygSZTyJAVWVt94bhl/KZz0SrTR0aOWGl1EcW6GuqZsKuWCMzwbFQLljF8rS
	vUP0l/hCvGUD1SXd5h1C/VkYSo+0tiDspVUBrqPWrHIIVifsEyUV+E73l23XV54a
	YbLFwjip0ujm2H+unyGpHXIDhVAc4j+x1loiQgqA0/FghnAGRbP6/8Q3q7ABAbVt
	vaHarUBf46UM8JmnGr0J3q7pNn7ta4b7Mq8JzoD8suuMazt8G1xU/pw7I8dw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793965195; x=1794051595; bh=d1c1Kg6tAb3mIq7oug6qeqAkcptl0gkGURv
	qnWGyRrk=; b=dOKAE95haooU00PDw+YjCRTwrRQZgK2Vouyjb0i2Yr6Yypcfp7k
	3rnZZpMg1dEosreUFbY4sg3V+7ENPFCDcgDxFspTETTaC76+1ZPYoihJMSfhZZ1+
	eWmKbvH/o9MzcQcNQcZ2mYvSzyys1fTDQ2lai1t4FQljKGHZSf60uMARqcpslFzn
	3J5QHVGznEkJTMFkBrJFVYIylnLwZU4gsaNdS9cfEyJoRErF4PGFa0kXZNykIZ9R
	ZkCJfonCcvbLS0x4k7yuZKbL7q7SD1xVjY75KVWex+3hqkKPu8DbOf8HmxQrN3ZY
	ZIeMFNY7ZadVL894Ck/tG40V3R2F7CbzR+w==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793965195; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:bM0r1wm8yzSRIdATt85gypqHH5oXaH3NWe3sUbrUYlgQ6lB
	DVc+zL9JF4+oj0qo2cuQhaYNyYNGq0sLzt4Ai5ghYa/WitoElORsjRrOxMAQvs0g
	ImC/1geJHSZidBIkV6+K9H37OTGS2FyTtzLG9lZARPTJjLPDhORbACGwisTL7uhS
	2pPjDOM2KJA6Ks8Oq4VMLW6Ww73sAKrbfwspsY0lz/G9haEoqsQiEkGvGxH3CmJZ
	VZDusHmxvVHbc2FJSh/m9zeAraeNmE3InAb92QQraN0s7ePBfEu6EVjk4QGNlEDz
	lCTULOS0jpIialQSLBp5SYQHN9Ou247tMa9aFHw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:vcWehdqKRYX6gcyxdlLeCgCeS11iczM49OYc9WzSZy8=:uazxuyZlCT9Tvupg92RKQ4G++vj04I83h8gfpBqvSKc=;
X-ME-Sender: <xms:i7ztarCrhtb-Pun5UoO_IAAlDpHCiobAFi-9wNiCaaPIR3_gqZOkMg>
    <xme:i7ztaoj6BZ9-ndsA6igDeabYD7672pqFR6RsdBtnZk1oJLXG-lXrxEJHlQeTeUxoO
    O2mLjPThBbllxieQG8JaC2OJ9zTNkox-DL4MgDyt3Woireu5sBI>
X-ME-Received: <xmr:i7ztarnp62fadK_254gm5OZpfaDYAno97sEam80KG2Ke5hl5JQPm9UWcWIKEbe6boigqhQ>
X-ME-Proxy-Cause: dmFkZTGoZxmbRAf0NtClVN5kchPnOh7Uhk9JDUbNiED2Lmv+UdstuMU3+/Mk3fVs0Y+lpN
    3M+9N5IggYasNBTHwIIeKMqUsno75webw4ZnHUZAChrdecV0XxUZ2zPMPGEAguHVQ8c1Al
    tIw6pjfB9VqVAL2rKDYQSzmebrT6w4WW8WC0ViqUWYsT52G5ggyWOCIsvId8YI7dVYrGsj
    iI43JXRTT/3gJovT9hdVEA3xVd0AlcBUZ7NxilClVN4q82voam/ijFREr3RhZW8kpCH64l
    r4AAd2QJMlhHLpvBX7rZxUj6lf+Oskt/Y4nkb1a/9b4/UoRsl8sgU0625c6OqsHmwCoLsA
    AApeWNkUgh+jBxMDhBldQqtJQCt3Vqbl12O2Xco/lmGH+oBiQ98nJ85VN9H9Hdi0+z49tr
    SRXqnBkNVWn4Y9mfUikSfz+yhP6mJSGzQBhxAQ/0jLx8NN7vOn2sI8Jz9YWUIPfZc2OEvi
    WOQylMEZSpLJejJG2m0ZAPK8IFCfyGKESMlFHrb4wvxLm6G5idYcS0W/YBrHei06kWcbvx
    /lrex+PvYFQE/g1pnT7CSCHOC0zXhNSZmBocfOEMPwR66of0UrN8PFtWf1wVIqx9cxA/4L
    Q7hv6xyswpzTAVFxDI7IivUYOx2Jl1xeGMeewHtSxqzCpwfs0FOU5I/oV9sA
X-ME-Proxy: <xmx:i7ztasrHGvEltLv8Ps1PzrWzeHYhCt2pOWAe_tMZw5ZLamBGs5dcuQ>
    <xmx:i7ztasHCX78_zXmLBCdNl78u2dGfuJDXXOtV3GXu1Yb8AnGk0H4TwA>
    <xmx:i7ztagygQbuY82Z8p1JAWydICCAl3UKhM0Dx_Jq7ZXoAi1dPxrC_fw>
    <xmx:i7ztapoAtytDCmGh1kneCsDKvSq3U8gVH1OIja0rD5kH_DJrzQ5Gew>
    <xmx:i7ztajERlpnOkyygLrn9dTGwHq9pwhjkMEwpt3gMEZlFWt7wLzb8Fd_q>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Nov 2026 06:39:54 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1d4cb40e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 6 Nov 2026 11:39:52 +0000 (UTC)
Date: Fri, 6 Nov 2026 12:39:49 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,
	"Mark C. Chu-Carroll" <markchucarroll@fastmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 02/12] rerere: convert flags into an enum
Message-ID: <au28e2L4LEMziCfI@pks.im>
References: <20261029-pks-rerere-subcommands-v2-0-07d5ba18e882@pks.im>
 <20261029-pks-rerere-subcommands-v2-2-07d5ba18e882@pks.im>
 <CAOLa=ZT6XJK_duCu5E+i-PxXzaCt-JUOsHAsTdysc7EYY3pBdg@mail.gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZT6XJK_duCu5E+i-PxXzaCt-JUOsHAsTdysc7EYY3pBdg@mail.gmail.com>

On Fri, Nov 06, 2026 at 05:51:13AM -0500, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > diff --git a/rerere.h b/rerere.h
> > index dd9da03d6db..f13790c5dcd 100644
> > --- a/rerere.h
> > +++ b/rerere.h
> > @@ -39,10 +33,27 @@ struct rerere_id {
> >  	int variant;
> >  };
> >
> > +enum rerere_flags {
> > +	/*
> > +	 * Auto-update the index with previously recorded resolutions. This can
> > +	 * be used to explicitly override "rerere.autoUpdate".
> > +	 */
> > +	RERERE_AUTOUPDATE = (1 << 0),
> > +
> > +	/* Reverse of RERERE_AUTOUPDATE. */
> > +	RERERE_NOAUTOUPDATE = (1 << 1),
> > +
> 
> Nit: From my understanding, RERERE_NOAUTOUPDATE outputs the conflict
> resolution information to the stderr instead of updating the index.
> Perhaps that's something to document?

Well, the fact that it prints to stderr is not specific to NOAUTOUPDATE.
We print messages in both cases, just at different times:

  - When `RERERE_AUTOUPDATE` is set we print the messages in
    `update_paths()`.

  - When `RERERE_NOAUTOUPDATE` is set (or `RERERE_AUTOUPDATE` is simply
    unset) then we print the message in `do_rerere_one_path()`.

The messages are different of course, but I don't really think that this
matters for the flag here. What we might want to say though is that we
don't update the index, but the working tree does get updated.

Will adapt, thanks.

Patrick
