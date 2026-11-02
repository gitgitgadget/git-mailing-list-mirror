Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793611277;
	b=QsnSamuzGb9V6ZP0+U1eoVYuFe8aVhbKREyApeb133jXpwRQUIBmR7WKQThucc/MwAwQ
	 3pWn5HfYevxA8361sZCmANgOJle1cYoPQrajDFrSOKijIpuK9hQ3qfxtfn5Qr23Yc/sZF
	 gZCRlmTD9PUNJwmfhbkHDeGcYNAlzPIFfNdlc25ZMPjp1Nx+dVZK+S+DQOPqjPQh8XlnO
	 l5t+I60xwuwlXFeyWJxxigy+qoWib/9wXbNBH3dvczgjzLxm3j2+jVqrs2PSu+LFqzW2Q
	 uEXAdwqGWl9qasH0YIbpGUODl4TURluDm+GB09SBNLUOKjRJhdRchDuxsQlGI492xxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793611277;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=CvcvbiaiJVGmSoMW/XbTV0QbglBW7TkMaesUCjTWOfg=;
	b=aoJyPuouAeYeiCQesp3SCVgo4yL77HzzOGjpDzwccAN4PYZSF2pX7ITZmpkC1HFhIhxh
	 RP/DA1Ds0+HRFgZAV7gWAtsNWU95PIkAS2r22fB7t6Qruoba8PYMgLJd4n+e21PHi+fqT
	 ltOc6doh/N0EbO4jS9iqMDYshq3mO3W6B2K7+tXfNugEspW59qgAydgGmvY0nzAhcSEhT
	 1RMS1VURre4nUfkxvOLyFQOAGnPVDQN7q9pxwNggnMLTMynokYYzkFprTiDp2q2AN5nNK
	 UhwR59QF04We1+KhOYGyNXWS2K56FRf/iSEe9EV5PJNX7JQv41sFV0FC7hIjouy5L3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b="PNswPn9/";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=s5bGkmHg;
	arc=none smtp.remote-ip=202.12.124.149
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2DE606A326
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 09:21:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D2DE606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=PNswPn9/;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=s5bGkmHg
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 53C591D0004E
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 04:21:16 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Mon, 02 Nov 2026 04:21:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793611276; x=1793697676; bh=CvcvbiaiJV
	GmSoMW/XbTV0QbglBW7TkMaesUCjTWOfg=; b=PNswPn9//QcXG37zQkGttjDDEa
	YdztZhecGqWiZgX60u+X7E1cRIMnqe87eXdsi3djvRLn2olcf9fUdRYZBpu+xnb0
	O7CiWHGL6vzpHkNOWZlBheL+T2HHrJgh/T9UyJOSy71oIQbe7+qFD9GV5kVDOp0J
	zZqksUnxoArCLOvVvbhTj5tzg13SX6Y/ckSrjW5vvsWaxPTo27tf7VfOG8G8jCbA
	NJUUa12rKW2o5A/1190awLRgqifn6knBOM23dPRUwjV2taTJQd8jNv0hAy7PrnxN
	Q7VckN4w5pdNmKEbwgwL//iGmXWw63akS3C1HXpHTrywM2q7gr9XDkkRQA8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793611276; x=1793697676; bh=CvcvbiaiJVGmSoMW/XbTV0QbglBW7TkMaes
	UCjTWOfg=; b=s5bGkmHgrjEEny2FKzWqpHLCqK2uqQHQiBJAvepzNs3o6nol995
	cViC6iOyST6fZGQFH/OSV3SqfoIxw+SNI6xgkesl/CE4DHD6Ln42zVju+iDS0Rtk
	oQKuZXWnG1RFTJR4Vu0t+DOzOJUYqggTHw0xdGdX3rq4CICwRrEyZU4Xadd+2R69
	r2z5iA7wKawVRMHFAgj4Ncc4HrqjvRe/ul7Enp7U6Gb/xHX38/b6dcMd1kgZdvxY
	Z9Ap1lChaqDzAjb0dU/mxRPRH9mIt2oISA/BzjVBa8+IkNEtbPNr9hOx8+DD1Knv
	qi59DkpF2882Mo9Cm8lronM+E0imk5hEyOg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793611276; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:G8+hOVU0EXSHsNVVDcK1HEccd0mOIHHLvKjzl63gmXK0UW/
	wFKdUCLPzhD4oxqtkEAf1btiQGDL5Oj4vhQiBluK6jDM+nhXgYzJsRadurKfrcEc
	AZmXpaXlkMAahKS9X+8OARiCj+XMeGMhzSg8Pnthn9EgdzQVO+x3kYugncYCWWjb
	Mh02vOAgZhjNMeGW8aHPSvciLZmhq4FzVL9Bykr0VoWVTrGMdCq4qfTbiBa87qdB
	Gja9khfKfMsLKc7yf0u4kRObkvQBYrlKvcaEwMXnwoV98n8V1O2P1FVk7QWLy+B/
	3D997KzrNY6+aUOZIJt51Kv/oTl5gda/PEXITkw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:/JFAFEvyWDVTLYno7pp3JNATyaBOrIpuLaKzTlynGOg=:ZD/ux0cOcfJPljkB1eVHiI4gAPn0cjrPeRma/6oXzl0=;
X-ME-Sender: <xms:DFboaixu4r4SjE3aGifh5wFHhyHH3eW4KxcXI0tpCycfRwuFI1HIXA>
    <xme:DFboalQxI9GekybBHm-sGsmrcFjdKj7bHCxqdrQvzDz0MJLbEnJBAGAdn2_LhqcYL
    GOuYhf_44E97rBVOwlU2SyF0-wpAenVyPBPl-b1BL9sEq3a0cd27co>
X-ME-Received: <xmr:DFboapWGp2kck1N-DXew893uI2KEfJRxMabXMfDEBgoag6tehwCjhlsboKQ9MKT6byVtO548DnQMh1Vu6PfkuIkSAbq8MaJWHskM>
X-ME-Proxy-Cause: dmFkZTG16K57ImCttynehSBBHpdk2cDJjnOCgpV3IuNoOJCmFxSiEowGsYKnTmPJkaHAvn
    +mmdMXLdEiyjvhxTkY7PcCEoLD1bl8cSYmDsKhfBSgDOLaV2zbZzYQXrojASQQlcttJRFF
    pHtmoZTbOEqgQPVx+X+jkbUquMuTf+hHQAPQnwjsPOJ0UbTdPHJQmmM8Mz4jZfuYY+ViPO
    PhVeIiO5IZyB+G96VctOBfn4Crbwk1tFArcXgvlxguxfGx8gaQQt+TL3NdxJqKCDnPpCzC
    kKTjlNKIeQqQ6NiwG04aVyGLBWazLqYA5+kC0ZO1BGAanceWQLrELqSsGmOB+ifBMpQwTL
    LPVVWa1xiQAU5RSiF72pXkj9iBUKdiL63DxixzDKZMZYUUgHlAkZWqcmx5mlX55KEnyha/
    WsGJAJABW8h9aHNfA8tuTJ2N4+y/ywAWBbXbmfGyy0RtKlml7hwxmGEolrRLrk/G7RK3vW
    HngTHtWZEeRsILFjl4kpqlQAEzYJRs+z9/b/Dz9mq1aGwilx3DDY/R8sBYyxgxyeER6qmG
    p4qEuvci5bidSxh1GQyB+hkUAL0elwEO4uZl9Yh+7+t3hSqTGViCKQVIB1fzp6nGsE1jj8
    5KHG/a622wY0+PCibPfk2BuXD6DbvyGBRfmBWWXJF27vo4g1f3HQjGcliZdQ
X-ME-Proxy: <xmx:DFboanY5up9z11KVthl08R9fBzW7bSKRKSU0my_W-e59TYoZPe687g>
    <xmx:DFboav2w80tq7quzXayGhu_jT_oDRmq7k-8PS9I9AgO9Q42r2u-TGQ>
    <xmx:DFboapj3lyWa4xNtB3IQu-3lC1pVVS0kpvvUSEXaWGGmSELL7STcsA>
    <xmx:DFboajYPMiJHnzoS5ODYkkH981X91vaFCNRYkvric-NfSmz0q7t2eg>
    <xmx:DFboag3Zx-A_T-m-6RgG_67S8r9axWIVIBCdRefY8k0egOPxa5l2FTMC>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Nov 2026 04:21:15 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>,  Harald
 Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v3] range-diff: add --matched-only to skip one-sided
 commits
In-Reply-To: <pull.2401.v3.git.git.1789458703432.gitgitgadget@gmail.com>
	(Harald Nordgren via GitGitGadget's message of "Tue, 15 Sep 2026
	07:51:43 +0000")
References: <pull.2401.git.git.1789144877632.gitgitgadget@gmail.com>
	<pull.2401.v3.git.git.1789458703432.gitgitgadget@gmail.com>
Date: Mon, 02 Nov 2026 01:21:14 -0800
Message-ID: <xmqqy0bblhbp.fsf@gitster.g>
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

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Harald Nordgren <haraldnordgren@gmail.com>
>
> Reviewing a range-diff often means scrolling past commits that were
> simply added or dropped, when only the ones that correspond between
> the two ranges are of interest.
>
> --left-only and --right-only already each suppress one of those
> one-sided groups, but they are defined as "only show this side" and
> so cannot be given together, which is exactly why show_range_diff()
> already rejected that combination. Give the "show only the commits
> that correspond on both sides" behavior its own name, --matched-only,
> instead of asking users to reach for a combination that errors out.
>
> Extend the existing '--left-only'/'--right-only' conflict check to
> also reject any combination with --matched-only, since all three
> narrow the output in ways that cannot be combined.
>
> Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
> ---
>     range-diff: add --matched-only to skip one-sided commits
>     
>     Add git range-diff --matched-only to only show commits that correspond
>     between the two ranges, skipping ones that were only added or only
>     removed.
>     
>     Changes in v2:
>     
>      * Update docs and commit message.
>      * Use die_for_incompatible_opt3.

This is more than 6 weeks old and looking at the archive, nobody
(including me) was really interested in the topic.  Anybody wants to
take a fresh look at the topic?

Unless we see some volunteers to give it a review in a few weeks, I
will discard the topic out of my tree, as 'seen' has been crowded
with topics that have been collecting dust without getting many
reviews.

Thanks.
