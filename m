Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.150
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793304593;
	b=ANMUWTyFhnzXB2nKS44SvPn716Xz9Ar3L3BR6Liog205+D9fYxkUlXiqVgQLcl4alsPJ
	 9jYclodoftpA+gTUon8LjVtKTXFfu9KRAkHefLRluAWFwNY5w0vujLWzm8iCl9/6aGJG+
	 vCztglvE/FoFVKiuC+opLnMMs9jIRcLm4HCds6WBdNcxNQxsMaKd4T6EL3WGphgfVfb2m
	 Y5e65eTcF3z35Yhfki9hFrNKV594MB4yaip2KZGLPsD8VJwKV5UrD3Y3tHZgh1h+7Y5Qf
	 /t5ypriv9vhyevXs0nFjqLF+mGX67fpmAqQY9jMGhMcMdr6pB/wmvMfP+fUvUcUS7Hw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793304593;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=MPnCcC5/SWk71eKRfVg27Mgklqo4P6Y6s2S9XV79mkg=;
	b=uJ/DwLmzHQeFX3MCSr1qsb2ZCIJUA8X54/UwzGuJGM/45DttlK2mFjCkGLls5sOMuFUS
	 ogCBfcr4f1F8dzHSPjt9N32eQir4F8euZpvFUxuDCi6rDDQKxX6ZbkXMvmhFvBe9CAUNB
	 JLyKGhNcT04lc4P0xpWay0bGa03+VSAwsEXnCnoGJ6ebF09iaXA2cC3D3OSC43AuPrjq3
	 8dKXjrieioakVvZTgG1dWgfWkv0pQ6KDFdIC80Tci86pcJBpCZtnXuJXTkN82Hxa9mXTO
	 RMU3CdN09qcenpypEY1TLi+7mS9bcvEnWQ8SrPIprtTCyIk7HWtG9BZUa3qmm/pcmPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=kwBPG2Q2;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=iUqn+d2X;
	arc=none smtp.remote-ip=202.12.124.150
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E405606A31A
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 20:09:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E405606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=kwBPG2Q2;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=iUqn+d2X
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id B909D1D000B9
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 16:09:51 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Thu, 29 Oct 2026 16:09:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793304591; x=1793390991; bh=MPnCcC5/SW
	k71eKRfVg27Mgklqo4P6Y6s2S9XV79mkg=; b=kwBPG2Q2d2zaz8wz8OlYz/xi9o
	jOBXAhDsw5gn8+WVdvPAeuwovOUlKqqzWAMsQPa0pLy/UGKPGJynglpgljSGQeD0
	PY8EESnzozud8T8z7nY2ouweU0EgwqqAAVpNgXffSLxVMiVn7hyTNQ+6NGDAMSVr
	2aUSGGIFNSASmUrHDqNqdlzY5SnJrhvT0kUdaVIa6Y9s0yLJKT3XaJeMZsHfTNET
	Xx7quM2ADl3TSJXb7dWYGDBa/vJVSdfyNIqWfR+Qd09SUDGTpNL2V4Sp7v3/PG12
	FUL46DDSdl8Iwg9RmSqju2figEe3IpIkyi0Zvh2PnBfOv3LsBCbsxdcLByug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793304591; x=1793390991; bh=MPnCcC5/SWk71eKRfVg27Mgklqo4P6Y6s2S
	9XV79mkg=; b=iUqn+d2XG4EsT5CzDJwEdQDsAalZJNZ9d/iHf6LpQTiCx/DksgM
	NSmiD/LvDS61co2qYYL8i0EI4DxMqQfL4oB7mWMPqo8cdUsXGZOsfx91VXlVHJmZ
	GS55cDLtNyBKiz256hrnX85ZoVzFwnLvG9Pm9q33+Lk/JMDwb6wyzJStKXlCKpbY
	ebdHGGY/a582iZtSy/uAsF88T0dAPxjaeXXM66TLWiZODSyHqzeXnwxSZXxZ+sqr
	CzGPLl48D+XezI58nC5A+iVjK7FNO4797kNZcfwfCOZux6PaG6r6O5BUjGXcB5m3
	KN8kVvrA+k916yNrB7iXFUpSTqMiNjPyO0A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793304591; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:giXE2dStKUl8A8fRcjpy9wgRmzdcvKHlpwUdyi1dwqyppgZ
	H+vq3PxfRJeriAO3Dk33ofVsFIBqhwZUiEnMxUIMlR2kCN6ghqCodaE+y+F1eOiC
	USDxue1U9XCIu482jhestTyqEq5as0h7vSpVWrOjYKP2AVln3/XNZf3QSM3X2MrX
	GlN9jNIrO4fuo9MpwZScIGVCGRn7hYv00TrkmVjvQsVWYzX1cHkkp8iyr9cyJUys
	QV2NH8qGp7vtBAybX82Ff2nLyG6DHjv0fH2vikFFVM0FJM7qBuruif1UFyW8lKPA
	5Dw+Xyjsa/MmM+H62pha49kN4NhzlCjaawcZ41A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:92t48pqIfX3UtrxybPHRh7UyHPVTVz5Bed2LKhhuUTw=:5qw3YlaOViZ1gk4dvq9tM9dAB5y6MIwF70ugV6lvBOA=;
X-ME-Sender: <xms:D6jjaqhFml_HJhLPECdfITHg3K82eUDEIrN647Z6Nqr-dBNXAjUQkA>
    <xme:D6jjaiBZU5m-mhPa0XPRgTqeY18-HLf3lHKwOQM1mxwuwbuI-87GdgVUsA-VXBi_R
    VyyRu4RxxxMqqJvp-RLIOSgrlTni-UPLGBPSQSPPdF8fsEJQ8Yej90>
X-ME-Received: <xmr:D6jjanHA-YGQPdBDnKkytIsPvOKXxcQ921lsYsm5LvtTD37q6shHEzmPz44K71tPEndW7Slco6UMv5CkIA3U9hulXEh74gIQgAkr>
X-ME-Proxy-Cause: dmFkZTGHDLWtRkcJQUxGu8hepBSA7VHr1z+7SEGVuwMGxCdxH6PtCjye6qP5uW46hgwZ90
    +9+V/BgFJIxz+iJQIQJs1u8POV4y0PDfbw1kKOY/NAAsFzanQlxBuFlR1kuMCY9WTK6Bav
    6zEBslq2PP1P6lNgIfR8RewavpTSSLpPGGLbxJE/7Jav+eH7AcPJ9fCxuOjHpL9Dhfy20X
    Ux+F2EbEY2A5m0tPOb0Oj12D5MXVPgCWyG41dpIwO9azJspzVipykKh9FCoD3UI/Tgpzdb
    RhnVpyXS00H7D9vwWGsDxByz5cEqvhZL0z/mSJXiVs7A0nlg73mf72krhT0/WMA4yiINZN
    Qcp1grBPFW5ubOEK7zcJOgvRF009Vc2b+3Mbjn6EnBCPBB1ujosR7bH25Gh3XLZfe3ba2F
    jE8s8CSVoOBQmdE8NFxkxJucl+dno9JEP2k2EOtCbZ2BFHare6RIrrlA9tq9adSRu9yP0v
    YLGte2m0AVDfE1jZ+tIexmvIYF7lbg6frvdHJCG5t9SGU/zY3cbKUm4KGHU4M+tc5h5e50
    R3ZQQKv7b8HBFlgShnngA+sbaZ0AeKovvAklVjQqGCAsRiKciscqDuGKoMkrxAykoPUP5u
    4KG3Nh/kt624TVO1MTtcS9AztrKuijsqMrAYGRNJ0Y/CF46WIX0DFTRQzvZw
X-ME-Proxy: <xmx:D6jjaiKEiPl4hCDsJ-gvhj-dFrjAGtyAAU8ndoeLINFtWhS1qXtF5w>
    <xmx:D6jjajkEcN7IqEuarjZEVv_HZJGwiXvA0aVZ_JIpMnaGsGQ0wbVB2A>
    <xmx:D6jjaiRQn_rQK2n_RWF93XKgmgUVv-aWAKEy7To2YTblCuSLoScfsw>
    <xmx:D6jjatKK8HidFPtEmbGVv-Smct-Xe9faYbIu2QFDADTF2lFeL8oXzg>
    <xmx:D6jjaul9FiWxkIW4PfNhUCwx_xV59gDifiIu85Ns0wdwh1rw9FDnmNzj>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Oct 2026 16:09:50 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Husain Sitamuwala via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Husain Sitamuwala <husainsitamuwala21@gmail.com>
Subject: Re: [PATCH] check-ref-format: use parse-options API
In-Reply-To: <pull.2470.git.git.1793298807397.gitgitgadget@gmail.com> (Husain
	Sitamuwala via GitGitGadget's message of "Thu, 29 Oct 2026 18:33:27
	+0000")
References: <pull.2470.git.git.1793298807397.gitgitgadget@gmail.com>
Date: Thu, 29 Oct 2026 13:09:50 -0700
Message-ID: <xmqqh5i41d69.fsf@gitster.g>
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

"Husain Sitamuwala via GitGitGadget" <gitgitgadget@gmail.com>
writes:

Didn't I read very recently that somebody else was updating
check-ref-format?  Perhaps I am hallucinating.

Anyway.

>  static const char builtin_check_ref_format_usage[] =
> -"git check-ref-format [--normalize] [<options>] <refname>\n"
> -"   or: git check-ref-format --branch <branchname-shorthand>";
> +	"git check-ref-format [--normalize] [<options>] <refname>\n"
> +	"   or: git check-ref-format --branch <branchname-shorthand>";

What is this change about?  More importantly, is it sensible to have
this and ...

> +static const char * const builtin_check_ref_format_usages[] = {
> +	"git check-ref-format [--normalize] [<options>] <refname>",
> +	"   or: git check-ref-format --branch <branchname-shorthand>",
> +	NULL
> +};

... another variable with very similar and confusing name with very
similar contents?  How do we plan to pay for the cost maintaining
them in sync?  Do we even need both of them?

> @@ -58,13 +65,26 @@ int cmd_check_ref_format(int argc,
>  			 const char *prefix,
>  			 struct repository *repo UNUSED)
>  {
> -	int i;
>  	int normalize = 0;
>  	int flags = 0;
>  	const char *refname;
>  	char *to_free = NULL;
>  	int ret = 1;
>  
> +	struct option options[] = {
> +		OPT_BOOL(0, "normalize", &normalize,
> +			 N_("normalize refname")),
> +		OPT_BOOL(0, "print", &normalize,
> +			 N_("print normalized refname")),

As can be seen in the usage string and in the "git blame" output for
the code before this patch to parse "--print", which points at
a40e6fb67a (Change check_refname_format() to reject unnormalized
refnames, 2011-09-15), we still accept "--print" as a deprecated
synonym but we do not advertise it.  A good candidate for using
PARSE_OPT_HIDDEN, probably.

> +		OPT_BIT(0, "allow-onelevel", &flags,
> +			N_("allow one-level refnames"),
> +			REFNAME_ALLOW_ONELEVEL),
> +		OPT_BIT(0, "refspec-pattern", &flags,
> +			N_("allow refspec patterns"),
> +			REFNAME_REFSPEC_PATTERN),
> +		OPT_END()
> +	};

Do we want to barf when the user says

    $ git check-ref-format --no-print --no-normalize --no-refspec-pattern ...

by the way?  With the above, we suddenly start taking these options,
and I offhand do not know what the ramifications of doing so are.

>  	BUG_ON_NON_EMPTY_PREFIX(prefix);
>  
>  	show_usage_if_asked(argc, argv,

The call to show_usage_if_asked() is still here, which means

    $ git check-ref-format -h

is intercepted by this call and the control will never come back.

We will never reach parse_options() call below, so you lose 80% of
the value of using parse-options API, which is that you get the list
of options and its descriptions for free (well not free, you
carefully prepared them in the option[] array above, and they are
wasted).

> @@ -73,22 +93,13 @@ int cmd_check_ref_format(int argc,
>  	if (argc == 3 && !strcmp(argv[1], "--branch"))
>  		return check_ref_format_branch(argv[2]);
>  
> -	for (i = 1; i < argc && argv[i][0] == '-'; i++) {
> -		if (!strcmp(argv[i], "--normalize") || !strcmp(argv[i], "--print"))
> -			normalize = 1;
> -		else if (!strcmp(argv[i], "--allow-onelevel"))
> -			flags |= REFNAME_ALLOW_ONELEVEL;
> -		else if (!strcmp(argv[i], "--no-allow-onelevel"))
> -			flags &= ~REFNAME_ALLOW_ONELEVEL;
> -		else if (!strcmp(argv[i], "--refspec-pattern"))
> -			flags |= REFNAME_REFSPEC_PATTERN;
> -		else
> -			usage(builtin_check_ref_format_usage);
> -	}
> -	if (! (i == argc - 1))
> +	argc = parse_options(argc, argv, prefix, options,
> +			     builtin_check_ref_format_usages, 0);
> +
> +	if (argc != 1)
>  		usage(builtin_check_ref_format_usage);
>  
> -	refname = argv[i];
> +	refname = argv[0];
>  	if (normalize)
>  		refname = to_free = collapse_slashes(refname);
>  	if (check_refname_format(refname, flags))
>
> base-commit: 37b3475fb530c14109211faca33716a173db61ed
