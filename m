Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804B15684
	for <git@vger.kernel.org>; Sun, 11 Feb 2024 23:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707695423; cv=none; b=fJNkGrWDERLezS7rQWwE0VjbIK3U8/VF4mF6ZM+aroeXhvNfF+6xE15tQoXbLj49Cur3Ai+uk4xEtNiJ5aptfb9ZI8FutC3RddBDUa8utW8n+3W2qIHGsaZKPil06+AUsLHxNPgaE4Kp8QXTclZNkIIy+Y9O1Mwva79tjNFXLas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707695423; c=relaxed/simple;
	bh=jU3XejOnt0oGynae53ciK9jB/lin39aZTdWtHSP6lb4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=hWchIKqnYze2Rn/TBVGL9xGCszJkCj8tgyVYaBtpvp55fPT99dwB4Rcju6gLp48VODYcd5GiC53m1a24BabT0RuR1I99JHjCwZ3sr9cxJlcG74pJZBE8xGil2hBUR6OaBcuNc+8ss3VgdFp6mVzLVpxm08SyPgX1FHriPhSmcSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z6thweIV; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z6thweIV"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3392b12dd21so1594395f8f.0
        for <git@vger.kernel.org>; Sun, 11 Feb 2024 15:50:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707695420; x=1708300220; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QG3C9ttUSvZldKfVHkkPjzrVRIONukSAJc9yKBhZXoI=;
        b=Z6thweIVtg8N43BBWLh0JbFoAsT7SArL7SDkX7b2fuBLjUutIAPot0ROpAHrLWqLNs
         25vkQHnUxbu2/HqOMC4b3wMuvgaKP9bTpfh6ddU26JyvCD0CY+PRYh4UBICyiyR4Rrgm
         jmXMe03xEuJ0WrvPOOFS41erUWLD9V1A5O6udKVz1TbGZ9Cok5Ms6X+VM2vsRE/zIAmU
         TB5ER9cIb5j+iQV8k9bq2qMkQsJZM53TC6sr/Ps3waRtcxIBHFtzPEc0cnPD9PrQw0Kf
         zFlbBkYpWhwitdTvllcpbtLFaE75adm8ll4EtEyJvoVMw4TefPNvLHGEtPH92xB7MiJO
         afgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707695420; x=1708300220;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QG3C9ttUSvZldKfVHkkPjzrVRIONukSAJc9yKBhZXoI=;
        b=Myd9GMDIeuRsc6tyJgg6cS1MKxo3MWLwYSUjsW/rvixOU4aByZ9YoaErfpos+IG3xs
         yrbHOkRjN2814ui2XdDLxroKYb5wtQjads7B4Bpj9fnpgrZWz2uvX/qtj3D/ORXH6uSL
         1ost96geTQTRZidIRSaHvKSfRZZa8zKr7oy0qgbGqvMWuBhfMBV3buiDVgGZFwr5LUwS
         f1CO2thMmci4y3JYzflZnG6IuFj7aC5hCcFBWur0xRYzMTuV5TrJg2rH3LkTIzzRbUYb
         zL/vleenObJwplJdkpwZAMabnGxoUnool5Yb9JYxiBUJs1iyO9lSUTA3Ymp7irSOQg3F
         9nZA==
X-Forwarded-Encrypted: i=1; AJvYcCVchb+X6UbQe8btFzmJ8YcYWmGO6ePSbukpMSjz2R0YbJu5s8TNm5fFxK2WgqM6j4lQotqjeGVQQdaKWKSTolHSZ4LC
X-Gm-Message-State: AOJu0YxJ4tmRzsJ67Z2Q6rdHHFpH4P9j9FHm737ODuplM8VUwWQBdviy
	zI9SfGyMyKYkP6bLqWaIvxG/zsklAPPpfeze2aUfObfxbx9Uc8wK
X-Google-Smtp-Source: AGHT+IHawc1c/iz/4RqgxZ1n69V7rTsFO8sZSDprk5lRCpd9xFsBADUrtTbysjlIovG2NbNZj8++Gg==
X-Received: by 2002:adf:f4d0:0:b0:33b:4382:c50 with SMTP id h16-20020adff4d0000000b0033b43820c50mr3231940wrp.26.1707695419463;
        Sun, 11 Feb 2024 15:50:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUPBVCPpne5sY5BzW3kmeD0f7TfYPe8a1qIR088B7tmPgWVMLoo+DyEdald+nhwxnmcwF6PGFbh9CiyY+afg6HUkrq/t38DQ8QwueB4w9l4TeVykcZONO6Ue8LXL407ITSxQjP5fJsCk5bxXch/
Received: from gmail.com (77.red-88-14-198.dynamicip.rima-tde.net. [88.14.198.77])
        by smtp.gmail.com with ESMTPSA id by19-20020a056000099300b0033b79440fa9sm2913763wrb.111.2024.02.11.15.50.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Feb 2024 15:50:19 -0800 (PST)
Message-ID: <c44117e1-00fe-4d57-aa21-adb746f4d7b4@gmail.com>
Date: Mon, 12 Feb 2024 00:50:12 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] column: disallow negative padding
Content-Language: en-US
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Kristoffer Haugsbakk <code@khaugsbakk.name>, git@vger.kernel.org
Cc: Tiago Pascoal <tiago@pascoal.net>, Chris Torek <chris.torek@gmail.com>,
 Junio C Hamano <gitster@pobox.com>
References: <76688ed2cc20031d70823d9f5d214f42b3bd1409.1707501064.git.code@khaugsbakk.name>
 <1c959378cf495d7a3d70d0c7bdf08cc501ed6e5d.1707679627.git.code@khaugsbakk.name>
 <89d32a5f-b5ab-4773-bd9f-d33b4e348e15@gmail.com>
In-Reply-To: <89d32a5f-b5ab-4773-bd9f-d33b4e348e15@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 11/2/24 23:47, Rubén Justo wrote:
> On 11-feb-2024 20:27:49, Kristoffer Haugsbakk wrote:
>> A negative padding does not make sense and can cause errors in the
>> memory allocator since it’s interpreted as an unsigned integer.
>>
>> Disallow negative padding. Also guard against negative padding in
>> `column.c` where it is conditionally used.
>>
>> Reported-by: Tiago Pascoal <tiago@pascoal.net>
>> Helped-by: Junio C Hamano <gitster@pobox.com>
>> Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
>> ---
>>
>> Notes (series):
>>     v2:
>>     • Incorporate Junio’s changes (guard against negative padding in
>>       `column.c`)
>>     • Tweak commit message based on Junio’s analysis
>>     • Use gettext for error message
>>       • However I noticed that the “translation string” from `fast-import`
>>         isn’t a translation string. So let’s invent a new one and use a
>>         parameter so that it can be used elsewhere.
>>     • Make a test
>>
>>  builtin/column.c  |  2 ++
>>  column.c          |  4 ++--
>>  t/t9002-column.sh | 11 +++++++++++
>>  3 files changed, 15 insertions(+), 2 deletions(-)
>>
>> diff --git a/builtin/column.c b/builtin/column.c
>> index e80218f81f9..10ff7e01668 100644
>> --- a/builtin/column.c
>> +++ b/builtin/column.c
>> @@ -45,6 +45,8 @@ int cmd_column(int argc, const char **argv, const char *prefix)
>>  	memset(&copts, 0, sizeof(copts));
>>  	copts.padding = 1;
>>  	argc = parse_options(argc, argv, prefix, options, builtin_column_usage, 0);
>> +	if (copts.padding < 0)
>> +		die(_("%s must be non-negative"), "--padding");
> 
> We clearly inform the user and die.  No more OOM errors, or worse.
> Good.
> 
> And the message avoids translation problems.  Excellent.
> 
>>  	if (argc)
>>  		usage_with_options(builtin_column_usage, options);
>>  	if (real_command || command) {
>> diff --git a/column.c b/column.c
>> index ff2f0abf399..c723428bc70 100644
>> --- a/column.c
>> +++ b/column.c
>> @@ -189,7 +189,7 @@ void print_columns(const struct string_list *list, unsigned int colopts,
>>  	memset(&nopts, 0, sizeof(nopts));
>>  	nopts.indent = opts && opts->indent ? opts->indent : "";
>>  	nopts.nl = opts && opts->nl ? opts->nl : "\n";
>> -	nopts.padding = opts ? opts->padding : 1;
>> +	nopts.padding = (opts && 0 <= opts->padding) ? opts->padding : 1;
> 
> This changes what Junio proposed.  Is this on purpose?
> 
> While we're here, I wonder if silently ignoring a negative value in
> .padding is the right thing to do.
> 
> There are several callers of print_columns():
> 
> builtin/branch.c:           print_columns(&output, colopts, NULL);
> builtin/clean.c:    print_columns(&list, colopts, &copts);
> builtin/clean.c:    print_columns(menu_list, local_colopts, &copts);
> builtin/column.c:    print_columns(&list, colopts, &copts);
> help.c:     print_columns(&list, colopts, &copts);
> wt-status.c:       print_columns(&output, s->colopts, &copts);
> 
> I haven't checked it thoroughly but it seems we don't need to add the
> check we're adding to builtin/column.c, to any of the other callers.
> However, it is possible that these or other new callers may need it in
> the future.  If so, we should consider doing something like:
> 
> diff --git a/column.c b/column.c
> index c723428bc7..4f870c725f 100644
> --- a/column.c
> +++ b/column.c
> @@ -186,6 +186,9 @@ void print_columns(const struct string_list *list, unsigned int colopts,
>                 return;
>         assert((colopts & COL_ENABLE_MASK) != COL_AUTO);
> 
> +       if (opts && (0 <= opts->padding))

Oops.  Of course, I mean:
+       if (opts && (0 > opts->padding))

Sorry.

> +               BUG("padding must be non-negative");
> +
>         memset(&nopts, 0, sizeof(nopts));
>         nopts.indent = opts && opts->indent ? opts->indent : "";
>         nopts.nl = opts && opts->nl ? opts->nl : "\n";
> 
>>  	nopts.width = opts && opts->width ? opts->width : term_columns() - 1;
>>  	if (!column_active(colopts)) {
>>  		display_plain(list, "", "\n");
>> @@ -373,7 +373,7 @@ int run_column_filter(int colopts, const struct column_options *opts)
>>  		strvec_pushf(argv, "--width=%d", opts->width);
>>  	if (opts && opts->indent)
>>  		strvec_pushf(argv, "--indent=%s", opts->indent);
>> -	if (opts && opts->padding)
>> +	if (opts && 0 <= opts->padding)
> 
> This also differs from Junio's changes.
> 
>>  		strvec_pushf(argv, "--padding=%d", opts->padding);
>>  
>>  	fflush(stdout);
>> diff --git a/t/t9002-column.sh b/t/t9002-column.sh
>> index 348cc406582..d5b98e615bc 100755
>> --- a/t/t9002-column.sh
>> +++ b/t/t9002-column.sh
>> @@ -196,4 +196,15 @@ EOF
>>  	test_cmp expected actual
>>  '
>>  
>> +test_expect_success 'padding must be non-negative' '
>> +	cat >input <<\EOF &&
>> +1 2 3 4 5 6
>> +EOF
>> +	cat >expected <<\EOF &&
>> +fatal: --padding must be non-negative
>> +EOF
>> +	test_must_fail git column --mode=column --padding=-1 <input >actual 2>&1 &&
>> +	test_cmp expected actual
>> +'
>> +
>>  test_done
> 
> OK
> 
>> -- 
>> 2.43.0
>>
