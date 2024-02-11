Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F15107B2
	for <git@vger.kernel.org>; Sun, 11 Feb 2024 22:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707691694; cv=none; b=FrH3jYGwgrc3Uugyd2HmGtVKaNCdXS7bGJWYzEBVsXV+ZWR+6rGq3VMUz9RIrMD8sfEfjNX7j1HJe/4ghfE1h1myKD38B2rKwdVZs1W5pyptiYA6OwsC9DIP3TaWKbbM0NzRUG4L/sKjtfGyJszgceJLxGuOYzKEHV6GNzNLFHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707691694; c=relaxed/simple;
	bh=CD6amrpi3P2TI7FpX0LPrvRhLfz8BJw7coISdW5gsmc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hVJrU7NeZJEIlmoV7ZLn9NtjbqDg5WMpdtaQEYmOYoLPX7WBItQ8MJiRWG6Kb8AnLRn9JrmepGYhNAvbUTY3UKHFEen6bRUThzT1YobgHLX54AXC7vVixMuRuQTkD8wDHmU7zq0P/F7dlhwSus6hki439otg2rkVg4UheXSaxls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SEAsY0bz; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SEAsY0bz"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4108cbd92b9so9616765e9.1
        for <git@vger.kernel.org>; Sun, 11 Feb 2024 14:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707691691; x=1708296491; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8XM+JvLgNnm3ajLwxUERsc+JF44ZW/Vd1KwxX8q9QYU=;
        b=SEAsY0bzjwLB6gueqOLSycy4/NVOQ4NWto+6pVvLfULKiA5XdV639I/Vh6559htFjx
         zwPwLZETKxq5/8VRJFg8uYLdHRXbdcXgL84eUP9HQb3OG0BCNDlckcSzCF1d+gFXNYmU
         S6Z0C3sRL/qzJcCWlPih37v6UNC3KAXy8cPjgUsk2yqDuLSuG4YeHVTOhZDxfrDhPEkC
         4gHu0Wx0IFQXvg3DevF3If7f4DvI7dBPjWpR5mFsHlY5w4HaiJgS00S8dCKzV5HCc9Vn
         mu+qcrwGjX6VP2jVUeQdOTsdNV820IJPONuta8TGr+9emPbtzRtm/yVaaQ7e3OoNn8U4
         3WrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707691691; x=1708296491;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8XM+JvLgNnm3ajLwxUERsc+JF44ZW/Vd1KwxX8q9QYU=;
        b=ZKGNZeG+JoekxzutGkrPGQD8/KijJCunrCDdFzF2poLen7Idn3SFylB5xD9ltBBZvy
         XCeTw9Xl3q5LAQZUfR2C34IDojh5bGzqxGVL6BSQ7CWHYwO43teL84D8o4TdOjeKp1v2
         W6wflupAnyqSSTL+6QRliwPeyQEMhgWwt2m3pQ4twW7DzvUaz8xhQwQqz5VeW3I8rOzg
         NNKTvv83GifKgr6fnmL2eL7i5wO7eJB3j0G1jpDvjy7PP9xjAjCAHVQW7vnKQYpgftA1
         pHxX+lgG+r1H941eX1WHkdc0GUekqdyxhXaDiVJ6p7gniQP7WV8peTPgTVsSMC7Kywet
         H5Qg==
X-Gm-Message-State: AOJu0Yz+901122xvGUzjDT8suVFrJFUVtpAp8tsW5UPe6SYCG2Hd/2Yo
	065k9USvEj/Aheq9QwL7GvtkLtgXYju643Tps/tTxiISvLaR3Azv+3TsEZRG
X-Google-Smtp-Source: AGHT+IEMK6Xxw4VLaX1peBN1Tl/DegI2MnIE0YbJzw2NO6HaBxz2H4Meu+8WEm89Kw/bkcCmj89YRA==
X-Received: by 2002:a05:600c:518d:b0:410:da54:85d9 with SMTP id fa13-20020a05600c518d00b00410da5485d9mr485946wmb.38.1707691690625;
        Sun, 11 Feb 2024 14:48:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVhr+99QCXeX3WH+5zse2CW2Z0bcjZMQylS71PpuAs5slhEc111QHbwqc+tndtwZCZ0ZaPIvpM6HIJ5OKnkSB5gx0DSc6Pgj76yfkAyuRM+KDnPeCPqFvjgmyi3Z+1bTRynVdQ8NRuc0+XuRSpQ
Received: from gmail.com (77.red-88-14-198.dynamicip.rima-tde.net. [88.14.198.77])
        by smtp.gmail.com with ESMTPSA id bq20-20020a5d5a14000000b0033b6e26f0f9sm4865908wrb.42.2024.02.11.14.48.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Feb 2024 14:48:10 -0800 (PST)
Message-ID: <89d32a5f-b5ab-4773-bd9f-d33b4e348e15@gmail.com>
Date: Sun, 11 Feb 2024 23:47:54 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] column: disallow negative padding
To: Kristoffer Haugsbakk <code@khaugsbakk.name>, git@vger.kernel.org
Cc: Tiago Pascoal <tiago@pascoal.net>, Chris Torek <chris.torek@gmail.com>,
 Junio C Hamano <gitster@pobox.com>
References: <76688ed2cc20031d70823d9f5d214f42b3bd1409.1707501064.git.code@khaugsbakk.name>
 <1c959378cf495d7a3d70d0c7bdf08cc501ed6e5d.1707679627.git.code@khaugsbakk.name>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Content-Language: en-US
In-Reply-To: <1c959378cf495d7a3d70d0c7bdf08cc501ed6e5d.1707679627.git.code@khaugsbakk.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11-feb-2024 20:27:49, Kristoffer Haugsbakk wrote:
> A negative padding does not make sense and can cause errors in the
> memory allocator since it’s interpreted as an unsigned integer.
> 
> Disallow negative padding. Also guard against negative padding in
> `column.c` where it is conditionally used.
> 
> Reported-by: Tiago Pascoal <tiago@pascoal.net>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
> ---
> 
> Notes (series):
>     v2:
>     • Incorporate Junio’s changes (guard against negative padding in
>       `column.c`)
>     • Tweak commit message based on Junio’s analysis
>     • Use gettext for error message
>       • However I noticed that the “translation string” from `fast-import`
>         isn’t a translation string. So let’s invent a new one and use a
>         parameter so that it can be used elsewhere.
>     • Make a test
> 
>  builtin/column.c  |  2 ++
>  column.c          |  4 ++--
>  t/t9002-column.sh | 11 +++++++++++
>  3 files changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/builtin/column.c b/builtin/column.c
> index e80218f81f9..10ff7e01668 100644
> --- a/builtin/column.c
> +++ b/builtin/column.c
> @@ -45,6 +45,8 @@ int cmd_column(int argc, const char **argv, const char *prefix)
>  	memset(&copts, 0, sizeof(copts));
>  	copts.padding = 1;
>  	argc = parse_options(argc, argv, prefix, options, builtin_column_usage, 0);
> +	if (copts.padding < 0)
> +		die(_("%s must be non-negative"), "--padding");

We clearly inform the user and die.  No more OOM errors, or worse.
Good.

And the message avoids translation problems.  Excellent.

>  	if (argc)
>  		usage_with_options(builtin_column_usage, options);
>  	if (real_command || command) {
> diff --git a/column.c b/column.c
> index ff2f0abf399..c723428bc70 100644
> --- a/column.c
> +++ b/column.c
> @@ -189,7 +189,7 @@ void print_columns(const struct string_list *list, unsigned int colopts,
>  	memset(&nopts, 0, sizeof(nopts));
>  	nopts.indent = opts && opts->indent ? opts->indent : "";
>  	nopts.nl = opts && opts->nl ? opts->nl : "\n";
> -	nopts.padding = opts ? opts->padding : 1;
> +	nopts.padding = (opts && 0 <= opts->padding) ? opts->padding : 1;

This changes what Junio proposed.  Is this on purpose?

While we're here, I wonder if silently ignoring a negative value in
.padding is the right thing to do.

There are several callers of print_columns():

builtin/branch.c:           print_columns(&output, colopts, NULL);
builtin/clean.c:    print_columns(&list, colopts, &copts);
builtin/clean.c:    print_columns(menu_list, local_colopts, &copts);
builtin/column.c:    print_columns(&list, colopts, &copts);
help.c:     print_columns(&list, colopts, &copts);
wt-status.c:       print_columns(&output, s->colopts, &copts);

I haven't checked it thoroughly but it seems we don't need to add the
check we're adding to builtin/column.c, to any of the other callers.
However, it is possible that these or other new callers may need it in
the future.  If so, we should consider doing something like:

diff --git a/column.c b/column.c
index c723428bc7..4f870c725f 100644
--- a/column.c
+++ b/column.c
@@ -186,6 +186,9 @@ void print_columns(const struct string_list *list, unsigned int colopts,
                return;
        assert((colopts & COL_ENABLE_MASK) != COL_AUTO);

+       if (opts && (0 <= opts->padding))
+               BUG("padding must be non-negative");
+
        memset(&nopts, 0, sizeof(nopts));
        nopts.indent = opts && opts->indent ? opts->indent : "";
        nopts.nl = opts && opts->nl ? opts->nl : "\n";

>  	nopts.width = opts && opts->width ? opts->width : term_columns() - 1;
>  	if (!column_active(colopts)) {
>  		display_plain(list, "", "\n");
> @@ -373,7 +373,7 @@ int run_column_filter(int colopts, const struct column_options *opts)
>  		strvec_pushf(argv, "--width=%d", opts->width);
>  	if (opts && opts->indent)
>  		strvec_pushf(argv, "--indent=%s", opts->indent);
> -	if (opts && opts->padding)
> +	if (opts && 0 <= opts->padding)

This also differs from Junio's changes.

>  		strvec_pushf(argv, "--padding=%d", opts->padding);
>  
>  	fflush(stdout);
> diff --git a/t/t9002-column.sh b/t/t9002-column.sh
> index 348cc406582..d5b98e615bc 100755
> --- a/t/t9002-column.sh
> +++ b/t/t9002-column.sh
> @@ -196,4 +196,15 @@ EOF
>  	test_cmp expected actual
>  '
>  
> +test_expect_success 'padding must be non-negative' '
> +	cat >input <<\EOF &&
> +1 2 3 4 5 6
> +EOF
> +	cat >expected <<\EOF &&
> +fatal: --padding must be non-negative
> +EOF
> +	test_must_fail git column --mode=column --padding=-1 <input >actual 2>&1 &&
> +	test_cmp expected actual
> +'
> +
>  test_done

OK

> -- 
> 2.43.0
> 
