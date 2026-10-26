Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793048803;
	b=LWxWypxdTAPH1dW1oLmsl6CFPqeuGLfWlud4GcL7FOQNAZSR6d07sap27WLmvgKqxj3e
	 +6FQLt+E67oEgyxM4Ueiu5pHJ8UsaXxWi+0+E7qyGc16IiHoQvwHrOtRG9ZJDAn9JoZsZ
	 v3Ylf8pQxKzD8NPEEdT/sZVuk3E8rUfj9PSQMOfeQju2EFjJ0t0cgBI0royrrFxnGex7J
	 VgWvphpEZF5pq4Buq2LogWeW+XYW+60mFlBcY/LfQja67MrNiWKIWj9Mp4zeqOSFbPiME
	 72cnxrHQLV7sevERCvRXaOrIFOY2QDRR6OkVamUFecpDsjgMIKfLxzrac3AMztKLrfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793048803;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=MuPP28nUUGRHZmk961Z2fCwb2Cc2aeW5s5UqTfH4G8c=;
	b=W45tLlYrSd3GG4U/KJn270ToW+sj2l9Bci9kK0JoEzGkEXPKwMEor2Ke6mxrEeehaICv
	 gM7XTnlmYj9qwIzngQUTyXSvGMp9e0eh78HYF/28dkAI4gA88izsiym3UQeFgR9CmoKyo
	 wJnVv9Dt878fzp6l4vj7SXznXE3rPtpjUIOeKMFZKcNqXlEIXKfp1azW9XFhSRTZ/uW/b
	 zHrTH45+escdWnh0ZZuznmMht4BqTxdR+r34fVAGx79HjSWgi2InFvPDvwWXBdcHCnll7
	 q2tXZTqYerq5IhkMJ1ca8WX+R3kS2uQ+OOSIqWB5y8LStagBmhIrppweL/Rv9BSabiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=UZPI41LE;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=U7nJ2aAl;
	arc=none smtp.remote-ip=103.168.172.149
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F8E606A31A
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 21:06:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1F8E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=UZPI41LE;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=U7nJ2aAl
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id F3444EC0A49
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 17:06:41 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Mon, 26 Oct 2026 17:06:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793048801; x=1793135201; bh=MuPP28nUUG
	RHZmk961Z2fCwb2Cc2aeW5s5UqTfH4G8c=; b=UZPI41LEen5Ll6XnUHGKdtGoOH
	0KiicBiF4LQsJY/v+KF9zIBEN04V6NquXaXNvcjNx68MnZhctPckGGAGdvWtj77c
	bAMLEcltBgZsTDQdvm/DRlhaCECN0qD1YmwPk9AsgP39v54COmgEcC58san3W+NM
	7kkZykIft56HW0cCS5k1WaUYUUBbb0a7CysQt/2JzeH1jgJ0PMWYuVftQcvnIhcb
	QBS0n+gzSfVLfQ8hQg81WCtDthsBq0dXpTjm+SV7FMxaqQaAss2hX3cfpw7RYrVZ
	icqQwcTpFg4C9BSHqcHwqK10fS59QgZwIgPs4UBj4tpxaUh4qJMNZ6qftBmw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793048801; x=1793135201; bh=MuPP28nUUGRHZmk961Z2fCwb2Cc2aeW5s5U
	qTfH4G8c=; b=U7nJ2aAlDQZFdX3pdYjKgp3tJzkrr1LFqGe6cl3+1z1jUpa0zbp
	tO86+BnB4TlimWBdNAVjsvkH2EYDPWjD4h/b/fL6HKjtvP5YO+x9DumBwjrRYK79
	2Nz2DC+r2+eL6OKjJxI7R3JBd70Ni6AsZ9ZUFXDnokGStyUvN1E6wznkv47Uk2ZZ
	o5ElPAkmz1d62jH23DXSrO6KntFj+BbXPerrEyEAFjEzlVmcV46Hkh2dB5+YwyiX
	RlX+bTDTyjzxMWFJnPEgs8Z2EUauDOSrOOpMwiSUPWwn4vNSg528dPjvVaebQBtX
	kxTTeU6NoOkt2WeDW1Pya/f08ulEtbtnjLg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793048801; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:Swn0pPh4zW9F/pZ6Nxk5FRe5uoOTmQkoPuPKC1sQDXyNDnZ
	uyhjBVp6dtiGt7OIckD8RC5HMC7s5C7zMUM85tN3Wz3Weh91FC7nFiqh8a1SUcuO
	D7a7jaRDUxKHb84UG/ZYm41hQ0LOyC9dBa2ZQn1I/6ptO3M+yqjGvvhGVyEJgXg2
	5egvCw854p5jsJvmlrJcQteuki8idTJKnn02w7pBd1yAqDqyFgKgITja+9NgCfp/
	1apTJSOhLntwmsGWwflQ7911wqNrprnaWytM6Rtu+I+xHCw0aVQ6H7g2lV6sq/7A
	KP6Sh3y+wZLJ0KsQjs4F5sUPOpCVEqjH7n+vnTg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:tPThROZjJbNg60ciL/Fm90VmJ/7bGd4EYBMsq8aHOHo=:8UKx0kTUGnLGXfy9lvzY9BfVoVkz+DWCiij3TAaWoVY=;
X-ME-Sender: <xms:4cDfavAJgf3bpB8WNWVtLiVqPuQJDS6qQPrTlARIaHwC9Zml4TA9bw>
    <xme:4cDfapMckB9qY0lz6RI0z9rVcMn1hjxwgHfIBY592OG1QlOUmRdLgNi9EZW-CnS0j
    HCUHiyxGJW4xR1JRqyt4PdlnsR0KNV-KrEEuX7qWlODHZkmk--L4IKD>
X-ME-Received: <xmr:4cDfakaXTwT5uRW-4R_0rxnfOjmtNb6m45KoE_Qb-kaeTCzvNiATf_A6e0LJFzU02Vq-op-_lTj3ZsPyPU0HUPphqmMX33aZJ34c>
X-ME-Proxy-Cause: dmFkZTGXe5+baH9eeiLLM5WHyi4YUPdmHZlaHwlhtfjZjJXLKcDkrwm/Af1zofTJjAuUf4
    z/aqamh1Nc5tH5QClM8yRVmF4q4avj8EvpI8ybMoXyeAdUVg00hooM2GS9kCwrqCjXXtOV
    yHFx/fxCnCZOTHrc22tS63UF8kUSiR72DlmpAMKiVG2xYW31gqYLdT+hsd+So3QP54/JJF
    zbj7PyTCJ3rcfv+v16g5jqdfjnpet+qzBiMfMxCC8C4XNHWWCZd2A2YS0JpiRLXF5nfi6m
    1uR1ujmtM/Mxqfe3IysOa/W4geFAxT+pEYdmqdfJ+91xGioQm3dwQlf8Ma2rFw70Mn3rZI
    dI6/ZiRjZtwzkRhGchOAGzwCs9IEJ4pkBe8EqKAkMMOlVzHkCjqfKkx5X1XQPcUuXZC+6n
    6I4SnMKFPDf/PY0xz5IGpRRlm1d/9Xr9gDkLn28R+giUqGF0dJk09qapRe3UQfoJwspErb
    CpIWfzoI/K5+Yw5w6ynoj28dWR6s9QqUUtdPjCRBbBsCFYzmdLyfZBAe8JIM1OEBs2UKJT
    YZy4YQ8nqm1tGJPJ5zRg32h/cVlOwMIKRxtfejwJlAWMlRQGhrurROjsEfz/w8XAwG2Yqk
    GDaJERmYCcocnjFsWpGOTnO+0iCg//diFL8PDwxGwBe4pUE3YxUFmIvpXJkw
X-ME-Proxy: <xmx:4cDfaou8QWT2IjYs92O1X1DUmjUjoq94pihbT2yd9oekk3De-RXydw>
    <xmx:4cDfamP4-3_kqXDQrWvpnnAPU9tFln3MDgGUcZdQh34G5Zcvaatyvw>
    <xmx:4cDfav7S5UPL0ROZYmgDckuXZZ7eg-q9C-GGrEd9VUr0hBYJtrNQ5Q>
    <xmx:4cDfasSAmzj1Tc7QW5tgtPHA8H0spYLvT-LkOZErwVqr2TFUgqX8nQ>
    <xmx:4cDfaknWB26iBJ47n9LCpS22h3EonfuV79uQ1pVYd7C7ic0AZXMzPygk>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Oct 2026 17:06:41 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Fien Dora <fiendora5@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,
  siddharthasthana31@gmail.com,  phillip.wood123@gmail.com
Subject: Re: [Outreachy PATCH] t1402: test --no-allow-onelevel option
 precedence
In-Reply-To: <20261026132525.45414-1-fiendora5@gmail.com> (Fien Dora's message
	of "Mon, 26 Oct 2026 14:25:25 +0100")
References: <20261026132525.45414-1-fiendora5@gmail.com>
Date: Mon, 26 Oct 2026 14:06:40 -0700
Message-ID: <xmqqfqxsp3xb.fsf@gitster.g>
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

Fien Dora <fiendora5@gmail.com> writes:

> Git allows later command-line options to override earlier ones.
> Added tests to verify that --no-allow-onelevel overrides
> --allow-onelevel and vice versa.

There are many other commands that take --[no-]foo options and a
later --no-foo overrides an earlier --foo (and vice versa), and most
of them do use the parse_options() API.  It probably is not worth
our brain cycles to add tests to cover all these other commands to
cover all these options that can be negated in a way similar to this
patch does for the ones based on parse_options().

What makes check-ref-format somewhat special is that it does not use
the parse_options() API to handle command line options, and instead
uses a handcrafted loop to parse them.  Covering the behaviour of
the command with tests may therefore make a bit more sense than all
the others.

> This ensures that the expected behavior is preserved if the
> argument-parsing code changes in the future.

So I would say that we need two changes to the log message:

 * The rationale should highlight why check-ref-format is special
   and deserves to have this pretty common "no- prefix negates"
   behaviour tested (i.e., it is a handcrafted parse loop); and

 * We have immediate plan to rewrite the option parsing logic (i.e.,
   not a vague "if we change it in the fiture").

to sell this change better.

Thanks.

>
> Signed-off-by: Fien Dora <fiendora5@gmail.com>
> ---
>  t/t1402-check-ref-format.sh | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/t/t1402-check-ref-format.sh b/t/t1402-check-ref-format.sh
> index 9dd64662b2..6036df0210 100755
> --- a/t/t1402-check-ref-format.sh
> +++ b/t/t1402-check-ref-format.sh
> @@ -74,6 +74,8 @@ invalid_ref 'heads/foo*/bar*' --refspec-pattern
>  ref='foo'
>  invalid_ref "$ref"
>  valid_ref "$ref" --allow-onelevel
> +invalid_ref "$ref" '--allow-onelevel --no-allow-onelevel'
> +valid_ref "$ref" '--no-allow-onelevel --allow-onelevel'
>  invalid_ref "$ref" --refspec-pattern
>  valid_ref "$ref" '--refspec-pattern --allow-onelevel'
>  invalid_ref "$ref" --normalize
