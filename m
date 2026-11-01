Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793500239;
	b=5hqqVWukPWiMcZDTCKPilrQTEUti4mmY2j0Fj2Yt8B+IHYySQiBihZYuEvPomAkncYwp
	 XR+EhHfVIlHzr+WlcXodrbcsM1X62C+xiWkyYzK4Jk/XWCEXOGaN3pKN8TfrTZ9072spT
	 UMEIEUQ3e0oyd3iHUyxtweGtbmQQt/UVHXXFEVjiwgvjcjeactxebtihD8Gqy/lDrAVG9
	 ZZxVd2rIL8Hc63czwwUOANeGnIgiQW1E5uoxQc8DW0u0hf/1WE2Tncn+PTuwIE/Uwmg1Y
	 P2PeZxbfUee/8iB4ahNjAqIsOa2eWian8+L+ZzWrDXL3AZnW93zRxzA8N3GI0HOPR3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793500239;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=zpYkRVn5RABzhA6iswIN0zEyNbhpJB6+Q36w6Zn54JQ=;
	b=BfjpGR15tqxMa8Ny6N/0P/6uJYxnqZuMC+eAHho5Q5gQdkFfkkgx+xgCP43HT3CM6+Bu
	 knLfjs/VJw4fnkf1kO8xz7nr+2LAVivUn5ruRC21XCE4wiqcu5ib3Jb7wQlxIqrw/ipVO
	 LYujXPcVJkReXctC1QhXKFIDzFG8flint4BiUePLWQgORIJ6tOBcjCy4OBpZX/WdjBfZa
	 HcWry4lcMJCJFEaqLTRNBCouGS2t2suEDJrMs7AYF4tXuId+GAGfqYCYR5q2NPawk7RKq
	 AZZLmw1X/eqCf2V4sZK4nMAadqy+Tmr9UandzfJPOUCwwym5harg9ZYkjQaKJBFSiNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=k7goua3r;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b="MUu/5Q3V";
	arc=none smtp.remote-ip=103.168.172.148
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF2B606A324
	for <git@vger.kernel.org>; Sun,  1 Nov 2026 02:30:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3CF2B606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=k7goua3r;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=MUu/5Q3V
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 6FD82EC059B
	for <git@vger.kernel.org>; Sat, 31 Oct 2026 22:30:37 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Sat, 31 Oct 2026 22:30:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793500237; x=1793586637; bh=zpYkRVn5RA
	BzhA6iswIN0zEyNbhpJB6+Q36w6Zn54JQ=; b=k7goua3r0l5nSWQVJ2i45Unz+9
	81CdVnVnHl3VLJNTuQZAMrK8+qYCHhtA/3rzDIVt2YR4o+UpS0qFvOM739mfbUE4
	afRHEJAbQlefJMJZCL/yzyT/OWbhANz5sJW9Bz0QB2lZ4fCwEVjnW4egOEiCvrIM
	UIAF7cueFn4kXzaGeib7xsCjKYQ7jAioNNAR8lSLrj40GJVpJWDJpfLtrQZYAKkG
	Tbmzu3XcA0+/NfjyWjJ99aRxsD9Lcw00FhGXLG4R9uOCwxN9FCnSIpy08LuLO6ul
	japs53qtZCwIbrrBHpP9FJpeS5uuWVs9Bk3TU0Ov4OenlHIW2YJUnx8uyiIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793500237; x=1793586637; bh=zpYkRVn5RABzhA6iswIN0zEyNbhpJB6+Q36
	w6Zn54JQ=; b=MUu/5Q3VMYmgTBo5mtDXeiF2PbdgfUhCpgn7uMAtecFq88s/vGm
	yylzvBNpg+sRIAGIv3Fq//n9Ldzy+/lzYb7yII1lcGESof/edfyj5hX6H8igQczN
	SpIR3z3AZmP2WN8rkTnIIR4tm0DPd3HN0vOV2EF+9P6QwCNWZM49Mg8uFnnYmnoD
	r6h/F++PSqktA4SDgiqYwXLQzC9+2pCWuqATrd1gMwv8Ut/lvd0/+TMBYz8e0jAW
	No645Ib4HjMtT2nTbZ0I4xPUjKnOnb/sKQTB0YhRUyP4P35JkpQHhFurvH/UZzE/
	tHLJqX3fJboOr4hxwB6OiRJ8fqzPHiXharA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793500237; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:RV+PaZQke5CGE+HF8oRQoKsrMMJQQw9S6IgjWw85ULFAJUa
	Luuj8Mk+XC5T5a9xyB8U7g8h6K1gSNZfdyETajSAn0tVHttOEYo/cB1LkfwrXGg+
	pfyMlM9kzLFe6+c0hebGqzb3wm/Hiu5XIWnn9xgHPvYp6TklP+pjUydDGgPfolFM
	6+jedHwxReHi1AOMIOaZnWpLZ26s8hM1aonb3Hy4cufO7mJ3WEF866Soe25RvvxS
	aU/+3/nX/8Ntd3xAsmIGAEIQPxOL8GB/swPlmlpeBVssh03WflG8k90uiy2imjOY
	TrUjZNmKHxHhh1ySYCcutUGeCn5qb9zSV43wYjA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:b6kI3u1ufIkXKHgsleJV3jo155815Iz7c8FjxbmoPds=:Lgf+524yC2KebJGiJFJrGnjBjCVOuN4EoMhNUqxTxlA=;
X-ME-Sender: <xms:TaTmahJHel_uDQYjXvC6C6oBrfkZ-0v2T15AIk4EA2h5S5wLku3BkQ>
    <xme:TaTmag2w85rIkwJh0QEgzIzCv658hzTedQ8fFIM7zs3zozTjDlBSWoZZkpDqHTgpi
    lKkiHZrmllcQr_viXF-gEP0E7hEtxuRqbmb0djD5RCfsPYJEJIHdBQ>
X-ME-Received: <xmr:TaTmajj-rMRiWCSEfIgUVbBVSoRnTH4ihHPgGIN9uNI_8slvAm55tMPY4qn6vH9yOwLbcclJh1JieH_TkAo8QzCYPTadReBAmJOf>
X-ME-Proxy-Cause: dmFkZTFl41d9Fa3wYf/ShI8jTh+W+q/aR0M67oBiMIXMQA2Kr45J6pbJJ9+MmHGdJDWx/7
    LwZkLmvpBvgMEBGEPW74HkiKIHb54ZqsAuZ6gNtvbBh7L8ybzO6Xzsj6TbJhKqjD7suVsz
    1JtO6J6hVwkEwhgFf1ME7tKzWlhKvycjSz+GCnImMeeeQ/Tnd+PgHOpaRn8fMOuFTba/2i
    TcksUVepalghsnXPJ4Xw2Ce20dpwxpMq3Q1k+DbD1n+c8C+JbNEFGg+qvTSUdfn10N/k5f
    M1S02vsB6wzSpr4MlmQViLIHYcHrltGutf9zyzglpoDv+ZEU5vp/02VUvVcYz945Pg0DQw
    IsTWtP3HufFp3LDsJTqO5O/UhB5y8fAspW2eWfb+PYhmViG4rTLun5mkbuNKuyg0ua2XER
    uiKM4JolLkRxrTLbypmeJYoV4/9P4UvI5/jmI7bgAIzGSvylWZmiZKiCykVU1HUzLPB4bm
    uBs8/Uj/U6Tz+FpGBdiApba5mSMFEqTC+jrWlb4JDBs67XrAh8ruoqioUMPkv0eslzNjxN
    loD898xrA4KUHfp/sB0ddRGix4BqpLxUW0G0VLBMatIvFL6iwLyPY8N+e2VrNxn08bNplD
    crQEt1MR6VR2sPFvNJp42SmOH67EdvhfEXLYLF5AqxmRgMM+G4kOtCmMwe9w
X-ME-Proxy: <xmx:TaTmapX9m_nxpCSfxD2CwtUMLrtVyeBW9Nmmv11hFNHerrSg7dhTkg>
    <xmx:TaTmaqWlEM8O_wPMs_DCH4W3jjOFm-mP_zabUcd8W-sBgTVlEOERYg>
    <xmx:TaTmahjkNHhfF9idBbK8wZMGzNGlzvjVZssVm9hxgSayhzYl0DlkSA>
    <xmx:TaTmatYkm9cBrmxr6ppHD_SOLlNFB-3njptUc-Wptd34bJ4b-sps7w>
    <xmx:TaTmagvqPmoXYtp6UIv6XZwnyxkzegiwS63zfgQRkHccMzE8ekYG7Aae>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 31 Oct 2026 22:30:36 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Nakul V S via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Phillip Wood
 <phillip.wood123@gmail.com>,  Nakul V S <vsnakul@gmail.com>
Subject: Re: [PATCH v2] sequencer: refuse to pick or revert shallow boundary
 commits
In-Reply-To: <pull.2273.v2.git.1793455522168.gitgitgadget@gmail.com> (Nakul
	V. S. via GitGitGadget's message of "Sat, 31 Oct 2026 14:05:22 +0000")
References: <pull.2273.git.1792577381142.gitgitgadget@gmail.com>
	<pull.2273.v2.git.1793455522168.gitgitgadget@gmail.com>
Date: Sat, 31 Oct 2026 19:30:35 -0700
Message-ID: <xmqqwlqx1dx0.fsf@gitster.g>
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

"Nakul V S via GitGitGadget" <gitgitgadget@gmail.com> writes:

>     Changes since v1:
>     
>      * Also refuse cherry-pick and rebase (merge, interactive and --apply
>        backends), as suggested by Phillip.
>      * Check when the list of commits is built rather than in
>        do_pick_commit(), so a refused command leaves no state behind. Uses a
>        single shared helper.
>      * --allow-shallow-boundary is now accepted by cherry-pick as well, and
>        is saved across --continue.
>      * Dropped the option from the revert synopsis.
>      * rebase --autostash restores the user's changes if the rebase is
>        refused.

All of these sounds sensible.

>      * Rebased onto current master.

Was it necessary?  On which commit was the previous round based?
Has there been any changes that made it necessary to rebase since
then?

>     Not covered here: git commit --amend, and pick/revert lines typed into
>     the rebase todo by hand.

It is OK to start small and extend coverage step by step, as we are
making strict improvements.  Do we however have some vision on how
these would later be supported?

> +	else if (!strcmp(key, "options.allow-shallow-boundary"))
> +		opts->allow_shallow_boundary =
> +			git_config_bool_or_int(key, value, ctx->kvi, &error_flag);

Hmph, why not git_config_bool()?

Unlike commit.verbose or status.submodulesummary, I didn't expect
this to have anything more than a simple "yes we allow it" or "no
don't allow it" answer.  "all the other boolean neighbors somehow
use it" is an understandable answer, but I expect people to do
better than that.

Overall things seem to be in a good shape.  Except for tiny details
like this one.

Thanks.
