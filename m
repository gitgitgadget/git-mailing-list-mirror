Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.155
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795215367;
	b=SYWm6Z3Pmolp3twh5Lkn5S0Ku0LKI65JznZ+D/4WnRliU6iHHAkSs43c85rwhxy21G7+
	 sTgELLBvtn6vzfhfZyykZtME56Af3vypTODbOMrgwy2OKWcNBK4C8O4Oj/QCLFuOd6Tg6
	 O/IVxqnCIbOlCryE3gFQxDr029pLbrJJGPDOoGvzYNIRNItuFveKiZsefeJGt8/YmkN7d
	 z77BlnxtMVHIwz2Oi5P3uwsrSaucj7BKKLYrhGRrv3vV727Tm+cRmc0KqE/B1yUQKtHlW
	 +g7lKLxq6QFGUpW+Dz3nf/Qh1UInLSdJ7ojIcGBHM+Cm8clOtMjFWaQdnarmEUATC+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795215367;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=h1K3fuVh/iDFYuQG4jlfz5quhJ6rro7oWq2YVWDhq7s=;
	b=eL2uj3tI00NNrU/Z3UXBuduIRR/a0w9uWT7TbE/dau64AU3SlM0mIObybWtJ8TzJpkhF
	 9Ay8nNcS4S9HklluGofB0KO19kNkaRwRZYLKGmh4HmnOxesSJEz52TwYcAJDhzoMDWakc
	 A88zkffu/GMqoK0sqSY91rz+zIxvC5aGk901AMkx5HF4bOs8aQ0GB/80GlV685O0z2xAy
	 2fX+kdGcFEYYFG/TRFgulbbfxDEZV4HNru4g14maU/Qe3oQlP4cXJ9dWhMhuDR0W7ZDcn
	 ryALip/8DueIncK0JJ15H5O4RvIs0Fa1Zp2lEfkXrQ/i1HlrLyMDl9TBrslF7pzFTeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=WUoT3LzU;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="pOcUxzV/";
	arc=none smtp.remote-ip=103.168.172.155
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE148606A6AB
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 22:56:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE148606A6AB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=WUoT3LzU;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=pOcUxzV/
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A11BC140019A
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 17:56:05 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Fri, 20 Nov 2026 17:56:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795215365; x=1795301765; bh=h1K3fuVh/i
	DFYuQG4jlfz5quhJ6rro7oWq2YVWDhq7s=; b=WUoT3LzUPrcqYWX59SiEgblXm+
	2iPxvz8TZldLZam7hiqV6k1W2fe/le3iDeRTF7kN1cGqgKnejz7cqxSZO4MAIdSN
	tVsFe7RhYSCOOqvKgEjliobg28+OXSNCHqshtVLm/zYKxwKCRB4ynigUu9rzj/Za
	EQmxdgWQgnH1BX+dYZWnlznPj4NwkVzMwTjsu97KuSOWvqHa60X0hFdZ+mpggKgS
	TH/grLS1XhnAweXPq6siRRFNMu/Jz0hrwaolFKXbfCVNJWdAhs0Cv83GGV+djfl0
	kQgnK7ftUqzVo93pANy/gsXIC3n50CtVbxFdRmLPoFCvkAmgevbTmxFVidVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795215365; x=1795301765; bh=h1K3fuVh/iDFYuQG4jlfz5quhJ6rro7oWq2
	YVWDhq7s=; b=pOcUxzV/PxsDqfNZ6x/7lAeu0GLglbk/p6fdzVFt+NDjeY+Ss3o
	1CEm6lAOuzsrOuTyfPqJqUio3ZGIl81P6MU7fdh4+dvb8t0rqNIwFDpEHfeyjITz
	G3Zx8VyzLgUpY6KMqpqi/OIJFcMz1MdqgsLhCE6pGcSVgHew/jPTFGY+M66dtQ61
	hrCZDHSetJgFCq3mpel8E5PbWeixZ5ImPwfACspXq2qn95KEOsckB1pnrUiWHXE6
	vg5n6plKMnMP3aLZklgUuT8m9eACJB9FujEZMyWyBz3+G2F/ZtTPbm5Ol/zUxRGN
	et0Ko4Aa35fFAL/WSrevQcBeof6rKXlHHJQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795215365; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:gaIdY5Jin6R8RF21JsOd2AuyW23h+6YUszIAnNkIozwLXdW
	AzZmB3ZdPg8OqB7lcDvSaXGpTNKQQTdXfhx0+QsDsvZNphJkwNEvhqfgQLtVuk2k
	IBKHe2e5tSI65TJ/ojL93OoPOymgTWTqrFYe1bbmrpOCiA7oMzxvzL3TCEfD7/ZT
	iCEODBnj2WgdpEE2QJfW8KHgZA/d0743FgP1qzDj8HH6/TGfrPGpTREwpZTjRBVk
	xPTMLWNK+I1DRmo8k5V5ljvZ0L0vaiXhD9/vPvq5un36hlMIyJWRufHMzexaEHE/
	wg9qn6DXxSRoFYcK8hZCtA6eQTX49rEc37w+k0w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:LMB9jRvSnCR61K0+DeZNdP3eIpIFBE9cOEev/NKSZW8=:tA+YSIWIknAq5wvXOMcdINIC/faeX/SM+Yu7LH6cMp4=;
X-ME-Sender: <xms:BdAAa9c-QtY2r2M45KUrry8SPWHiZ9_tSYNa8yy-3RCy0iAcNUxlRw>
    <xme:BdAAayrjr9D0q_jB-dzTtZD8m50JfOmmgC25EPHjll1F6sEOmZxcmK1C3345L8RtG
    9XA2KRErfU5Bh866S3uKhqELX27TFlz66GsBqkF4v4g0Eht4OTPmFp6>
X-ME-Received: <xmr:BdAAaz59MeyKPAX1dIQJDHFoR-_mZxXsh7E1a3IBJo41YbHnuRG-JyaLR1iQaqDLqcsjr4FWAlDawfMOScM3JNlRBmiYCts3ODX8>
X-ME-Proxy-Cause: dmFkZTE3Nux/uzs0CSVKanzC8zqlS4GKDQVHykSYcz4VHcSKDMo7C4HQsbB+s5aMQK+rEE
    hq0wJwmHAp+6cvOct5vWAPK6d26xKu4gsJ+jdRUp0pip5D///1g6vYAA6EnD2I0rxlMSYI
    8TUsyiMCw4O049AJiP5ZZj2Ya37zBVxWJDrGSZ/mEaPwiWCzXqQ9ZIy2zVWA1i5AONrK1i
    3uzziWWchu+YDp7p9JM9PThW3XTl01p+ax04G0gn2eVPFzc7kx1N5FQWS6VOoaChivzdST
    vHFBc82Fp3P3N5kqflwC01m9793TG8Lo+Thj6RTFU1GSp/oSRQIPcKr/uMjw1U9IyIismy
    o9gMuJvhLgaRgPs2ab6q2Xq01ZZ/RViDUUJndXJVMVmr1z8HzcKtmR6klFk5oihREURDnu
    doXEhQ7mbvZHhL8gZGBNSc5KWhALKcmY1oVpvNNnJdyJJ8ypg3h7GBIZow6aemw+jc7k1W
    q5c3m0bOqbthR0EFTLqf6IQObK7MQ1c15yTeZCjgEuJ83Iw8mE18yFUV0PvytLNdRpsPEp
    KdadJjZTvZMxWlO1Wo/W2hfaLp7EvgZAewQnslr71CaGiJhA2WjL67WsPtAvAv+Umt0/ER
    10NBst2TSsoxGoGf2OyVy+0KwL87ue1AUsiJbj96S/bATA8qKGeuiedrhhvA
X-ME-Proxy: <xmx:BdAAawqLiinncK9o0PZbDg9BAY1GMVvEoOOzRZRunWDrU8mOlK1Okw>
    <xmx:BdAAa9iqgWxQmUfaO177Khf-htN-Q6Ig-Vw4l0F_OHB12aAaGl620w>
    <xmx:BdAAayJPZYwpG7gkxqk3yb8fyBOhPXDWGUEDIQ1DfoiHL5CMNtQVwg>
    <xmx:BdAAa1BHZqmGwbJ3w8MF7WPiYPSxXPmLOcL3A-bIe_pS6EbGmFw-iQ>
    <xmx:BdAAa0irsRo4ZtrRkQZRJVryhXTePeqlql5tKEqfOUCaR6UQvWECwJ8x>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Nov 2026 17:56:05 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v4] doc: wrap emailed text to a maximum of 72 columns
In-Reply-To: <20261120224227.932-1-okhuomonajayi54@gmail.com> (Okhuomon
	Ajayi's message of "Fri, 20 Nov 2026 23:42:27 +0100")
References: <20261120110215.42209-1-okhuomonajayi54@gmail.com>
	<20261120224227.932-1-okhuomonajayi54@gmail.com>
Date: Fri, 20 Nov 2026 14:56:04 -0800
Message-ID: <xmqqzev3m7sr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Okhuomon Ajayi <okhuomonajayi54@gmail.com> writes:

> CodingGuidelines, SubmittingPatches, and ReviewingGuidelines do
> not say how long an emailed line should be, or that there should
> be paragraph breaks for readability.

Will queue.  Thanks.

