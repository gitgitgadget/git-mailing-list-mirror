Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9224320C465
	for <git@vger.kernel.org>; Tue, 15 Apr 2025 15:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744732331; cv=none; b=oBXi7k23RSzKuQvNvKKiZBqvAgvS4NkvHDxIwRwhj/Pej7Nu/qxTZ8GZDSoN2XYVkUBv733cJU5Q/dEgmpTfFzZec23GxUsKmOKwZA5RoVJ+bARCT/iTj9w9ORiPLsTge0EovmHk1XYoDRRKt9i0jUlmnVwvhDDQVXWTlVm1nTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744732331; c=relaxed/simple;
	bh=bw0W7DAFiRiTyLvsm3oSjWJdKUsnpaAzGIh/X5GX0DU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R3zEZ3yiNrNeQFSQCo0klV5ZP0ZqlAB+1Y02Zk/J/jEmVtGVaoqVHRm324X5GZZqGyiB/+0QVLnsCKfbyUPJOPj4EjYy77ULA/BhGrNZTgbBm49Q3akM/z1RG2OhMJH5UJyR+ZvF0rfZOvjQ7xQSBfICXuvgC0iiMl5kdCaAjeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UQ2yu4Jt; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UQ2yu4Jt"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43d07ca6a80so27859035e9.1
        for <git@vger.kernel.org>; Tue, 15 Apr 2025 08:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744732328; x=1745337128; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RuLcAJAI1MCrP72lC34tQ0IyYJ1LJH2/sS6zZvlUZzo=;
        b=UQ2yu4JtjT19OdOqCRgu77oNpE7KhayyPxZmTB2pwRl+hb2hl/4K0koQSGOKqvI26B
         ykZ1VY/j1TBEXhVAKmaPIhbn/MY41lEeJvjIbHELOeQr//bo68qenS0T0dnqyCt6YZCs
         +29zIVrFcblGqKJSFqjhu3wu3i9fK8Svy85qNuRyqpWaSC29auqBTIkgl7517iTewbEr
         1ojrLJFgZKM00wEpog24xqbAnIKDWKRMvck/FQ1bkrpxhLf2CfDtUIsnKJwlu3r3CeG+
         fzVdWPgICV4lJgPhPkLPMWZCvbu6hzgoAuQy2/vy5A6N6o14vVf9mV03oWs2MTJtYvM2
         BeIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744732328; x=1745337128;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RuLcAJAI1MCrP72lC34tQ0IyYJ1LJH2/sS6zZvlUZzo=;
        b=Ou9JfnsG+rLlp5Sj7N2tyXVlwfuc5ZOpA9zU+nN8Fg2aveMi11z0X+iLxYpOGddgN2
         1ebwssxaYMiadaoTvV5XFKOTKM51vO28URNm6c22AIRoDdsis785Lu0L4HKfy3Jd4LO6
         Mp8yzHcPpUSiueiDaq4TTOa/LWrvaEVKpgkpja5vzCxEDXIxBM88ezXqOJmYaCd+oQaJ
         V8rpr6B7EecF9vx4fWlIOCz6VpCwcCGVGJbBYsZrOs6b5g0ioFUXIUsGGtCXJ3mUbUCy
         cQRlMGQj016NGeFAAd9KEXEahROc+H0DNfP1BEcGQ3RBWQML01VM9s30Ke+VtiCg0jSy
         WEgw==
X-Forwarded-Encrypted: i=1; AJvYcCU4vDCZXZVMaBwkfoAwOdsQIHUCBcX8X4c1Czt9uHHI4DGZnbbGhtMk9uyMpU41Fhixvgw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwczRjRgGbcHzDjwpj+CzP1C0qkTNyvT79Jw4QtmpJqswMPjPgP
	rljPwn6kD4oWR5oHv+CiTOrltxib7+b/PhlKPM17al04PGAsXgGI
X-Gm-Gg: ASbGncuscyyxZUCn3GAusnoLk6TVni94cS1fOH57kNDz4QYS7ckAEt1V/WphiCr2f0j
	G3QxT9l/XUIsWJSrVBWQBUj7PaIqFScxcTXZp2xwMVs3RVg7/iGKCKo+m8b+bDt2hbgqusTAqqH
	n5iNcXamuaL8R1lHT3O0ONFqV4xi+cBTFQpfykVfy7Lz8COomTFGgKBiBcYv3CGMYyGTJ6diCCt
	ZLkyRIjabvWoYkb1LUxe2FSb0eXHJAkEo29Q26OZ1oQGCWRn4PMMH+SWLoH/8gJf5pXMHn7lY1/
	v6qTL/MrBfa9nvlB+VLcdkaFsdAMNtW6btk5fCX2zsiZKzuuE0PFCbFyf3GvEXbN8l01rR7ShOo
	XJ1vOa3AVCI9w5OU+QMmGuWV+GEA=
X-Google-Smtp-Source: AGHT+IHLkdel5zyLg+Lv5uLYy6fvbSSfDI3nh0gQ2wrW+6ScB+0kYLtCSlPsXJdNfTQP2RGlUIWGsw==
X-Received: by 2002:a05:600c:c87:b0:43d:abd:ad0e with SMTP id 5b1f17b1804b1-43f4aafa03amr105081065e9.18.1744732327492;
        Tue, 15 Apr 2025 08:52:07 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f20626c19sm221163245e9.15.2025.04.15.08.52.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Apr 2025 08:52:07 -0700 (PDT)
Message-ID: <35300426-32cc-4c0e-b0c3-edb2b2ed312f@gmail.com>
Date: Tue, 15 Apr 2025 16:52:02 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 4/5] parse-options: introduce `OPTION_UNSIGNED`
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Todd Zullinger <tmz@pobox.com>, =?UTF-8?Q?Ren=C3=A9_Scharfe?=
 <l.s.r@web.de>, =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
 Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>
References: <20250415-b4-pks-parse-options-integers-v2-0-ce07441a1f01@pks.im>
 <20250415-b4-pks-parse-options-integers-v2-4-ce07441a1f01@pks.im>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20250415-b4-pks-parse-options-integers-v2-4-ce07441a1f01@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Patrick

On 15/04/2025 13:14, Patrick Steinhardt wrote:
> We have two generic ways to parse integers in the "parse-options"
> subsytem:
> 
>    - `OPTION_INTEGER` parses a signed integer.
> 
>    - `OPTION_MAGNITUDE` parses an unsigned integer, but it also
>      interprets suffixes like "k" or "g".
> 
> Notably missing is a middle ground that parses unsigned integers without
> interpreting suffixes. Introduce a new `OPTION_UNSIGNED` option type to
> plug this gap. This option type will be used in subsequent commits.

I think this is a useful addition. I wonder about the way it handles 
negative values though. For types narrower than uintmax_t "-1" will be 
rejected but large negative values that parse as small positive numbers 
will be accepted. Perhaps we should explicitly reject strings starting 
with "-" as we do in git_parse_ulong() which is used by 
OPTION_MAGNITUDE. This patch also needs the fix from patch 2 to detect 
overflows for uintmax_t.

Best Wishes

Phillip


[1] 
https://lore.kernel.org/git/NYMqsJ7uttDzFT2OOEg5LLsxCSoQhTzqBs16KrMHGEKC7LzOAiYnYTEZavRQWqGH41UgjdwScwer7MssNzI7AEDHnD8GTBWvoBIqJ2e7D6g=@proton.me/

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>   parse-options.c               | 43 +++++++++++++++++++++++++++++++++++++++++++
>   parse-options.h               | 12 ++++++++++++
>   t/helper/test-parse-options.c |  4 +++-
>   t/t0040-parse-options.sh      | 18 +++++++++++++++++-
>   4 files changed, 75 insertions(+), 2 deletions(-)
> 
> diff --git a/parse-options.c b/parse-options.c
> index ae836c384c7..9670e46a679 100644
> --- a/parse-options.c
> +++ b/parse-options.c
> @@ -216,6 +216,49 @@ static enum parse_opt_result do_get_value(struct parse_opt_ctx_t *p,
>   			    optname(opt, flags));
>   		}
>   	}
> +	case OPTION_UNSIGNED:
> +	{
> +		uintmax_t upper_bound = UINTMAX_MAX >> (bitsizeof(uintmax_t) - CHAR_BIT * opt->precision);
> +		uintmax_t value;
> +
> +		if (unset) {
> +			value = 0;
> +		} else if (opt->flags & PARSE_OPT_OPTARG && !p->opt) {
> +			value = opt->defval;
> +		} else if (get_arg(p, opt, flags, &arg)) {
> +			return -1;
> +		} else if (!*arg) {
> +			return error(_("%s expects a numerical value"),
> +				     optname(opt, flags));
> +		} else {
> +			value = strtoumax(arg, (char **)&s, 10);
> +			if (*s)
> +				return error(_("%s expects a numerical value"),
> +					     optname(opt, flags));
> +		}
> +
> +		if (value > upper_bound)
> +			return error(_("value %"PRIuMAX" for %s exceeds %"PRIuMAX),
> +				     value, optname(opt, flags), upper_bound);
> +
> +		switch (opt->precision) {
> +		case 1:
> +			*(int8_t *)opt->value = value;
> +			return 0;
> +		case 2:
> +			*(int16_t *)opt->value = value;
> +			return 0;
> +		case 4:
> +			*(int32_t *)opt->value = value;
> +			return 0;
> +		case 8:
> +			*(int64_t *)opt->value = value;
> +			return 0;
> +		default:
> +			BUG("invalid precision for option %s",
> +			    optname(opt, flags));
> +		}
> +	}
>   	case OPTION_MAGNITUDE:
>   	{
>   		uintmax_t upper_bound = UINTMAX_MAX >> (bitsizeof(uintmax_t) - CHAR_BIT * opt->precision);
> diff --git a/parse-options.h b/parse-options.h
> index 4b561679581..20ea7d2ab13 100644
> --- a/parse-options.h
> +++ b/parse-options.h
> @@ -25,6 +25,7 @@ enum parse_opt_type {
>   	/* options with arguments (usually) */
>   	OPTION_STRING,
>   	OPTION_INTEGER,
> +	OPTION_UNSIGNED,
>   	OPTION_MAGNITUDE,
>   	OPTION_CALLBACK,
>   	OPTION_LOWLEVEL_CALLBACK,
> @@ -224,6 +225,16 @@ struct option {
>   	.help = (h), \
>   	.flags = (f), \
>   }
> +#define OPT_UNSIGNED_F(s, l, v, h, f) { \
> +	.type = OPTION_UNSIGNED, \
> +	.short_name = (s), \
> +	.long_name = (l), \
> +	.value = (v), \
> +	.precision = sizeof(*v), \
> +	.argh = N_("n"), \
> +	.help = (h), \
> +	.flags = (f), \
> +}
>   
>   #define OPT_END() { \
>   	.type = OPTION_END, \
> @@ -276,6 +287,7 @@ struct option {
>   #define OPT_CMDMODE(s, l, v, h, i)  OPT_CMDMODE_F(s, l, v, h, i, 0)
>   
>   #define OPT_INTEGER(s, l, v, h)     OPT_INTEGER_F(s, l, v, h, 0)
> +#define OPT_UNSIGNED(s, l, v, h)    OPT_UNSIGNED_F(s, l, v, h, 0)
>   #define OPT_MAGNITUDE(s, l, v, h) { \
>   	.type = OPTION_MAGNITUDE, \
>   	.short_name = (s), \
> diff --git a/t/helper/test-parse-options.c b/t/helper/test-parse-options.c
> index 46deb4317ef..0d559288d9c 100644
> --- a/t/helper/test-parse-options.c
> +++ b/t/helper/test-parse-options.c
> @@ -120,7 +120,7 @@ int cmd__parse_options(int argc, const char **argv)
>   	};
>   	struct string_list expect = STRING_LIST_INIT_NODUP;
>   	struct string_list list = STRING_LIST_INIT_NODUP;
> -	uint16_t m16 = 0;
> +	uint16_t m16 = 0, u16 = 0;
>   	int16_t i16 = 0;
>   
>   	struct option options[] = {
> @@ -142,6 +142,7 @@ int cmd__parse_options(int argc, const char **argv)
>   		OPT_GROUP(""),
>   		OPT_INTEGER('i', "integer", &integer, "get a integer"),
>   		OPT_INTEGER(0, "i16", &i16, "get a 16 bit integer"),
> +		OPT_UNSIGNED(0, "u16", &u16, "get a 16 bit unsigned integer"),
>   		OPT_INTEGER('j', NULL, &integer, "get a integer, too"),
>   		OPT_MAGNITUDE('m', "magnitude", &magnitude, "get a magnitude"),
>   		OPT_MAGNITUDE(0, "m16", &m16, "get a 16 bit magnitude"),
> @@ -215,6 +216,7 @@ int cmd__parse_options(int argc, const char **argv)
>   	show(&expect, &ret, "boolean: %d", boolean);
>   	show(&expect, &ret, "integer: %d", integer);
>   	show(&expect, &ret, "i16: %"PRIdMAX, (intmax_t) i16);
> +	show(&expect, &ret, "u16: %"PRIuMAX, (uintmax_t) u16);
>   	show(&expect, &ret, "magnitude: %lu", magnitude);
>   	show(&expect, &ret, "m16: %"PRIuMAX, (uintmax_t) m16);
>   	show(&expect, &ret, "timestamp: %"PRItime, timestamp);
> diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
> index 5f503b26cc8..9946e69f586 100755
> --- a/t/t0040-parse-options.sh
> +++ b/t/t0040-parse-options.sh
> @@ -23,6 +23,7 @@ usage: test-tool parse-options <options>
>       -i, --[no-]integer <n>
>                             get a integer
>       --[no-]i16 <n>        get a 16 bit integer
> +    --[no-]u16 <n>        get a 16 bit unsigned integer
>       -j <n>                get a integer, too
>       -m, --magnitude <n>   get a magnitude
>       --m16 <n>             get a 16 bit magnitude
> @@ -139,6 +140,7 @@ cat >expect <<\EOF
>   boolean: 2
>   integer: 1729
>   i16: 0
> +u16: 0
>   magnitude: 16384
>   m16: 0
>   timestamp: 0
> @@ -161,6 +163,7 @@ cat >expect <<\EOF
>   boolean: 2
>   integer: 1729
>   i16: 9000
> +u16: 5432
>   magnitude: 16384
>   m16: 32768
>   timestamp: 0
> @@ -173,7 +176,7 @@ file: prefix/fi.le
>   EOF
>   
>   test_expect_success 'long options' '
> -	test-tool parse-options --boolean --integer 1729 --i16 9000 --magnitude 16k \
> +	test-tool parse-options --boolean --integer 1729 --i16 9000 --u16 5432 --magnitude 16k \
>   		--m16 32k --boolean --string2=321 --verbose --verbose --no-dry-run \
>   		--abbrev=10 --file fi.le --obsolete \
>   		>output 2>output.err &&
> @@ -186,6 +189,7 @@ test_expect_success 'abbreviate to something longer than SHA1 length' '
>   	boolean: 0
>   	integer: 0
>   	i16: 0
> +	u16: 0
>   	magnitude: 0
>   	m16: 0
>   	timestamp: 0
> @@ -262,6 +266,7 @@ cat >expect <<\EOF
>   boolean: 1
>   integer: 13
>   i16: 0
> +u16: 0
>   magnitude: 0
>   m16: 0
>   timestamp: 0
> @@ -287,6 +292,7 @@ cat >expect <<\EOF
>   boolean: 0
>   integer: 2
>   i16: 0
> +u16: 0
>   magnitude: 0
>   m16: 0
>   timestamp: 0
> @@ -356,6 +362,7 @@ Callback: "four", 0
>   boolean: 5
>   integer: 4
>   i16: 0
> +u16: 0
>   magnitude: 0
>   m16: 0
>   timestamp: 0
> @@ -383,6 +390,7 @@ cat >expect <<\EOF
>   boolean: 1
>   integer: 23
>   i16: 0
> +u16: 0
>   magnitude: 0
>   m16: 0
>   timestamp: 0
> @@ -464,6 +472,7 @@ cat >expect <<\EOF
>   boolean: 0
>   integer: 0
>   i16: 0
> +u16: 0
>   magnitude: 0
>   m16: 0
>   timestamp: 0
> @@ -820,4 +829,11 @@ test_expect_success 'm16 limits range' '
>   	test_grep "value 65536 for option .m16. exceeds 65535" err
>   '
>   
> +test_expect_success 'u16 limits range' '
> +	test-tool parse-options --u16 65535 >out &&
> +	test_grep "u16: 65535" out &&
> +	test_must_fail test-tool parse-options --u16 65536 2>err &&
> +	test_grep "value 65536 for option .u16. exceeds 65535" err
> +'
> +
>   test_done
> 

