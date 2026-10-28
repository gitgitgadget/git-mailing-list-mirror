Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793226302;
	b=1dnp3o6XpKA5l7P7n+T9Oc0WPVHHe3KIY0gRgt3bM8/MM8841wMFVb4ffzC4QS9LQove
	 twDwji1IR2hP9HNEMzwUIv+wTibcelrP1rB/FH/xzXSM54PMntYLr+w4/sFphG0A8Xfjv
	 UOgrpzAf29dY/+RLoW9JLAAa0xS+gPdVeGsTRrHwfec6+WHkdBHVilFtj+MSeyUXKX1oJ
	 ANnCdDuIkKM2LOCCu9S2TJCR90mXf0sg54nWd263a2W1s2Gg9bFSIjkHqITLfqFhYR97T
	 2ZVH89q0vLiOBmVxw9s3Rsu8fE9+JR+ErbK5WQNp4tpmrSrso3VYISib2agHaoLlFRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793226302;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Kzfro+znvouxL+DSiae8OrDdSbuwiOv0XzNf1zQrw7A=;
	b=e8aXwhDc9uV0g3/1HgL0+OJZTRgTRDdVJfdAiQdUO1x2PXIy77Hpi5jOAyP+5SNlFNBo
	 xMQn/lgaTTVvq3Kj7EJE53EDtyb6hmM0IdCCoVS46La/t4BsvDoHwgaT1jOK2WA40IJwI
	 PJqW7jEi9DjcAeyRwEs6paKG697AI9v/YNt+9A5MmL0jLcCnN9GU6RfhWfCYTSnHv4miQ
	 ahd5ufQwEUlX7XDQRK4E8KEmRRq72HPeI8uXmRZCZKPc7Ne4mrOsTem0Ykc7ZuARSsNAl
	 c1NkcwVgVQrWXG5t8PJvxq9JQBrgB8XAcfr1mgHQlbBAFXS8q2KKnPd5FIvi1irfKJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=n7X+2JkB;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=bVuDGTeA;
	arc=none smtp.remote-ip=103.168.172.152
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B44606A31A
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 22:25:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02B44606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=n7X+2JkB;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=bVuDGTeA
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4D54314000CC
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 18:25:01 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Wed, 28 Oct 2026 18:25:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1793226301;
	 x=1793312701; bh=Kzfro+znvouxL+DSiae8OrDdSbuwiOv0XzNf1zQrw7A=; b=
	n7X+2JkBQuiBSqVZGOPDP23QtbmIIxd8QlJxU+mtPjpmQTAWp62D7Jagz5dZswuJ
	L7IQuJ1nPItUCHWY4n6RWLTorhYK6XfU7u6yK41TLyAYYSLhNTla+PZBBqZ9elHs
	uT2tezcHAtL0fcCDJXXz7oRmPF3oFMsUZsvKyiNLli331JnwbqBytOO/q8ykxDBH
	qXGa0XAJ2c2Cc0HeA6mQlR0RLw+f+Bl2jqkOQwOX+u41o0Ue14oH7OfqK6I3ZtTi
	hrnNNl4MPGP225KddfFZRNgUzVOR2OC4ncE/6EULWiOIdPEkkn2OXjS+AryIX0Nv
	E4voj5jJEb2OJ82jmd2+Jw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793226301; x=
	1793312701; bh=Kzfro+znvouxL+DSiae8OrDdSbuwiOv0XzNf1zQrw7A=; b=b
	VuDGTeAfIEJJauKXlv07FWDm7G/LY+PfMDvKcGf4d4eHWh9ui4kYJ01lBVUAO1GW
	sda/XP1bOwgpi5WMDYBVJipqoMZYzVfV+E5IIRgFs5728aRsBGC+87TUW0hAR7Z6
	4Ha1YExHKd/xAO4YXA0u+A9IK79LbQDXf9fQExS6RJ/zNk4+KH4Hi/ql3l+UyQK9
	f1piVUbrNhO9YPVcZMg6nz+K0gF1TQ+hvQZscYB+/csLYxSiv4b1qOq94HvhVTpI
	17kkYsyDhpXfQvNxrNeBVCuWYrEZDb1TsY4aU/xBTNPRiKcB1mmNR4sjUhWr0Y7O
	+RtGqwofA6GNbaFmrJ4Ng==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793226301; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:dZRVknp8R88M+NdGz5C0rXAovEpcFwEbsw+0W5VW/1DVaKa
	ametXoi7SOVR5SEBQ6/6LjAZTt3A0PEL+rx+pL9KCILAOeG2zUUuI5iA4HsF75W1
	XsEVVKk3B3B+cyvEwFGoiuwPAYxLngxOviP9I8+cnSgKevPuSm9ZW5cknRzNAkK7
	jliTbY6oScX68ykeKcXsN1kN2WAQBR3EuzXCuLU/WBgIpd0FS1S6ADVFLG0zRI1E
	pUtuXEeIgO1oBO6bPFqmEwFARy9pUw2Bw1soeMcY7B6u3+8JLwlFy27RTIvBqx7j
	dO+EJ6PHcSJrh31xrf0IAOCe2TtKpLCcI+u8hvw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to,
	user-agent;
Message-Instance: m=1; h=sha256:HjFAAGz14L/ic21LbgcAdv21o3LDPdz2EljR6fN7AiI=:B6A//lEmnmB4TtPSbhxLSAxYZxxzJxSTd2JJiQ8YSVQ=;
X-ME-Sender: <xms:PXbiavKDeYhs2WCEfkORIX2K0oD-Sn9r0adObuNylTRhSdrOG3JVSg>
    <xme:PXbiaqmRMnk0iRft__ZS9yxJW285otHOnCwb_G-z1ZhCMt60__TcOY_zwKTQFZUaX
    aE5gHNPRB6JWvpDKMhFLeUuOvKCglWz922ELuz7NralQqus3GLd7nw>
X-ME-Received: <xmr:PXbialHjrxOfn_JlPd64xDa5w9SISk-7PA-cJiUf4aFv8Tn27v6lCbO2BPGROTLl9S6nKLIP_lwpOL9cBQYQTlTLGPYTxkGGMtXO>
X-ME-Proxy-Cause: dmFkZTEy77JI3yMUjnnSKpyoaRwAeSC42RauNhSfjO9augZvAO7MKjljeiePPvCw6XRLpC
    6mdBZL1/yHnUMx4uqHp1iKYY9x44Ua2ziLmcT0sYP7v/HuavUJkrYPGBX5CgRKW5xyhUpo
    1AH2g94Qy2ce49FblPPYPZCfGbN5vRmLipA/vKzvQzLCiEMizZOdFclQKRAw9DE8YCWEff
    eXSqKLOuUDShclVn+WK3N1F28J88V2TLGEPz0/mh+Yt81NzUfsigHNTEXs/vY5ztqKMQZl
    S6AuiRdb1JpdLPmP+D4W0fxzS3JKgfIrtH4g9gEZeyZqPGEernQUFQqZnJCsI54XZHqdJC
    VLzattpbiLFFuFW+gnNW0WTUCPWaF5T1TXAwbAa6l18/PSt1W4YHoCWTZY1T4Il5Arap04
    zqJc3c4zCqAi8LizyqQWMd18UEOh9wISasMDnAre0MpHBvHrkObGEw3b73H+PwOMpG4X/Y
    tXzdmbduBjm9bAY8RKU+bkgs1oDDPaL/JDlkq5mEcuxZ4tMOZuEcM2tAKhQKu5gPzvlCOG
    7IKarHsnRBEWZRRf72qQVuLssv85T/ywxweGcGOgKkihccQBjjNOHn1uDld445cdQ1tfYQ
    yBCaSDsAiocC1ZjfRqOqw0CnpOIneJuyaSgUJgOLGuf2gGVlFqUhjhRj9kNg
X-ME-Proxy: <xmx:PXbiaiETlR2hKy-z_qz8GtxrJ8k-5grMNQ8wdk4CMM0pHV4905J_OQ>
    <xmx:PXbiaqNGdjKAzSkWxOI_2Lwi7qj9DsO5YbAZVRQh5K7xZslDR3GRxA>
    <xmx:PXbiapEGqEIK_yTd4IbfzmmKuICIpt6PACffZB5Q1e8STt9iw3iQyQ>
    <xmx:PXbiapMb8JBD-0bKcLe5zI5A1rxMWrNRivOgBdCQy4SlazOxk_XVUw>
    <xmx:PXbiaimJXoCrVWrQJKgQime_eiTQVLR6jGPzwtNshEbTaTl2QjtAz4iQ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Oct 2026 18:25:00 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Edson <edsonwasswa54@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3] builtin/diff-files: convert ad hoc option parsing to
 parse-options API
In-Reply-To: <20261028192647.976-1-edsonwasswa54@gmail.com> (Edson's message
	of "Wed, 28 Oct 2026 22:26:47 +0300")
References: <20261028170432.3524465-1-gitster@pobox.com>
	<20261028192647.976-1-edsonwasswa54@gmail.com>
Date: Wed, 28 Oct 2026 15:24:59 -0700
Message-ID: <xmqq4ie579ac.fsf@gitster.g>
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
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Edson <edsonwasswa54@gmail.com> writes:

> From: Wasswa Edson <edsonwasswa54@gmail.com>
>
> The cmd_diff_files() function manually parses --base, --ours, --theirs,
> and -q options using a hand-rolled loop with strcmp() calls. This is
> inconsistent with the rest of Git's codebase and lacks features provided
> by the parse-options API such as auto-generated help text, git completion
> support, and option abbreviation.
>
> Convert this to use the parse-options API by:
> - Adding option definitions using OPT_* macros
> - Removing the manual parsing loop
> - Using parse_options() for consistent argument handling
>
> The --base, --ours, and --theirs options use PARSE_OPT_NONEG to prevent
> negated forms (--no-base, etc.) which are not meaningful for merge stage
> selection. This follows the pattern used in builtin/checkout.c for similar
> stage selection options.
>
> This makes the code more maintainable and brings it in line with Git's
> coding standards.
>
> Signed-off-by: Wasswa Edson <edsonwasswa54@gmail.com>

Nicely described.

$ make DEVELOPER=YesPlease builtin/diff-files.o

is your friend.

>  
>  static const char diff_files_usage[] =
>  "git diff-files [-q] [-0 | -1 | -2 | -3 | -c | --cc] [<common-diff-options>] [<path>...]"
> @@ -48,19 +49,20 @@ int cmd_diff_files(int argc,
>  	prefix = precompose_argv_prefix(argc, argv, prefix);
>  
>  	argc = setup_revisions(argc, argv, &rev, NULL);
> -	while (1 < argc && argv[1][0] == '-') {
> -		if (!strcmp(argv[1], "--base"))
> -			rev.max_count = 1;
> -		else if (!strcmp(argv[1], "--ours"))
> -			rev.max_count = 2;
> -		else if (!strcmp(argv[1], "--theirs"))
> -			rev.max_count = 3;
> -		else if (!strcmp(argv[1], "-q"))
> -			options |= DIFF_SILENT_ON_REMOVED;
> -		else
> -			usage(diff_files_usage);
> -		argv++; argc--;
> -	}
> +
> +	struct option diff_files_options[] = {
> +		OPT_SET_INT_F(0, "base", &rev.max_count,
> +			      N_("show base version"), 1, PARSE_OPT_NONEG),
> +		OPT_SET_INT_F(0, "ours", &rev.max_count,
> +			      N_("show our version"), 2, PARSE_OPT_NONEG),
> +		OPT_SET_INT_F(0, "theirs", &rev.max_count,
> +			      N_("show their version"), 3, PARSE_OPT_NONEG),
> +		OPT_BIT('q', NULL, &options,
> +		       N_("be quiet"), DIFF_SILENT_ON_REMOVED),
> +		OPT_END()
> +	};

Move this a lot higher.

builtin/diff-files.c:53:9: error: ISO C90 forbids mixed declarations and code [-Werror=declaration-after-statement]
   53 |         struct option diff_files_options[] = {


> +	argc = parse_options(argc, argv, prefix, diff_files_options,
> +			     diff_files_usage, 0);

parse_options() takes a NULL-terminated array of constant strings,
but diff_files_usage is a single constant string.

builtin/diff-files.c:65:30: error: passing argument 5 of ‘parse_options’ from incompatible pointer type [-Wincompatible-pointer-types]
   65 |                              diff_files_usage, 0);
      |                              ^~~~~~~~~~~~~~~~
      |                              |
      |                              const char *
In file included from builtin/diff-files.c:17:
./parse-options.h:424:38: note: expected ‘const char * const*’ but argument is of type ‘const char *’
  424 |                   const char * const usagestr[],
      |                   ~~~~~~~~~~~~~~~~~~~^~~~~~~~~~

As I said in my earlier message, conversion of parse-options API
requires adjustment of usage string.

>  	if (!rev.diffopt.output_format)
>  		rev.diffopt.output_format = DIFF_FORMAT_RAW;
>  	rev.diffopt.rotate_to_strict = 1;
