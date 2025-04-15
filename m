Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFF1158858
	for <git@vger.kernel.org>; Tue, 15 Apr 2025 15:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744732328; cv=none; b=SUjrJqgfN0Sb0VIzUdYLyTFEJasuENcy27OeZsUE6XGGSt/MsVJYmsuXa44uK4H+brBLZhGCqELl7N3WaaeGqYo6+gKbGgbQskPx0FYSDLF4PucTKwQpApsBahyyMFkxWuWHV30JOlfHgKvttpC1H+hkdIuwnXv7AVuJHsdnKCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744732328; c=relaxed/simple;
	bh=q5pAT/NMGzyyNO7ZBeJYRib2CtO2Gt2K5IYr982iXBQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h3hZDtpwXC8z6CyMlqatRURBmqPdZhpdXE7tdZQqGW+UnD6HZeGcloC5YChf2w+PrxhHaNHwo0+JBi8/yAfbtQOXHl9GKV1krysY6MUr84biXG4DA3FbmNqG0EcE6fDUdJunnEpA4h9QjHzU1Pb11BbGMl0MLiX7N4y2jZ6GsZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AL/g0ahD; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AL/g0ahD"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43cf034d4abso63002885e9.3
        for <git@vger.kernel.org>; Tue, 15 Apr 2025 08:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744732325; x=1745337125; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+29D9qvuQztJlyVlZSBACJibhS2acp4B8s589ntj50g=;
        b=AL/g0ahD5L/Wlsu50TQ8SCuXRlebXwQeKCdk3CJucIvWJT7VYC17MMGDr663r4DKMR
         cPEdiFxeUfo1G8XRaYoRKaiOTmvCqVhMPWWwNaUfymddgispxEQF3DexZvVDUmieP4Qq
         JkQSRUtqc1jB2bSV2AvpuQ/mDKGj95WYSbOrv26Z1pis/o1jp765IVTfvk57lenzwhXb
         rP6QeVIcZrPyLNV6jbKGmi/KADFzJ95dJWK7763uTklonA3KsB3R7Pk5iShM12eNNRfa
         ToXApwyAWEb6z3k7fBsSRlpzeVZNhpF5yMf6xiDWsXskyXIeCOsiDmjjEu0Y7YeWb2NE
         1EYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744732325; x=1745337125;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+29D9qvuQztJlyVlZSBACJibhS2acp4B8s589ntj50g=;
        b=OqNok2kijXiAktRJfYbUWNoir/OWce1icLm6wa9LTYcEvuibRa1vATt/80GCa0Yczs
         DXQ9XXDYFCohjDBnNcsVbIHY1kUAbrjuK9bFt7DK5vxae5JNdeQGRbbnu4T+TH2hOuGJ
         mgyHS8RnpBXvdmgZ6t7v31lsUiE49IIqurEEGQnVms+OUGIGHIh/vIXQ3Msz6G8kgCqG
         6ds0Bba72N02jh+813F/NgZBMYkxka1kL7Zdtgrj93BCVirFv4tHntoO88rruJ8V17IQ
         0Qe3vDfVmLk5H6L4HPxDBs+A49Xgj/kIXtB0Hpn6c1e0cBXoUYPokvpeZYoPHVmP3TY9
         H79w==
X-Forwarded-Encrypted: i=1; AJvYcCXu+WPopQAbENsAKo+TE67FyZlNvFbuTrx4QbgP6t7lLaZ7yyYYtUCsq3UE98ACU0TryY0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz28a4vPy04OGzL014+AlDW1UXgMWa3CPjFmId+qkC8gXpJc3Jl
	lJwP9NJD/PYc0MvMrH2tWr9wFneMYHzLL7GZPACtR/PDBEZuXQZY
X-Gm-Gg: ASbGncvSbJgjZ/+E6sFqSLQugBm3CoG2TnvUIcnQe1h8kRF5cVSiB5Run5u7dq6ZyTA
	yZVHwdVn5aBIoBxu/WsCvwKYrV+TkK7+7nHRiekuQ8jGu1xqYeKdqB1t8yqsBo2BdU8ELXrcZPk
	m+eSc1Zf0QvrKpLAnfxpa8HHPod2BJzmkOa32JrgcXHLAIHwpKLVqjvW51NInv/RJWKwqxEr2cY
	reehneYYC5tjxwIWxQ8R0WYiZXUAZ+HhT+aVCHrL4OpxI/yhbQxzPCY6lhchq3Z3o8kNofJWv17
	cRQrzvCsG+6FmXjOsa18rDhO87x2L9j7cCkvpa7Ed1znyPZrSBfHDCITZ0Hz5Zxro1crjbo+zhf
	FNVE3LBB+w0J6/ZA3
X-Google-Smtp-Source: AGHT+IEHwdRQHsHVA/6mKKV32BIIlps9fblNt02p9cKIFjCmse+7ltvbaoCD4PweBkL52tT3i8wapA==
X-Received: by 2002:a05:600c:3d86:b0:43c:f87c:24d3 with SMTP id 5b1f17b1804b1-43f569710bdmr59091015e9.20.1744732324536;
        Tue, 15 Apr 2025 08:52:04 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f20626c19sm221163245e9.15.2025.04.15.08.52.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Apr 2025 08:52:04 -0700 (PDT)
Message-ID: <8e566ea1-5ff4-4854-a1dc-38626510c080@gmail.com>
Date: Tue, 15 Apr 2025 16:51:59 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 2/5] parse-options: introduce precision handling for
 `OPTION_INTEGER`
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Todd Zullinger <tmz@pobox.com>, =?UTF-8?Q?Ren=C3=A9_Scharfe?=
 <l.s.r@web.de>, =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
 Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>
References: <20250415-b4-pks-parse-options-integers-v2-0-ce07441a1f01@pks.im>
 <20250415-b4-pks-parse-options-integers-v2-2-ce07441a1f01@pks.im>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20250415-b4-pks-parse-options-integers-v2-2-ce07441a1f01@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Patrick

On 15/04/2025 13:14, Patrick Steinhardt wrote:
> 
> Improve the situation by introducing a new `precision` field into the
> structure. This field gets assigned automatically by `OPT_INTEGER_F()`
> and tracks the size of the passed value. Like this it becomes possible
> for the caller to pass arbitrarily-sized integers and the underlying
> logic knows to handle it correctly by doing range checks. Furthermore,
> convert the code to use `strtoimax()` intstead of `strtol()` so that we
> can also parse values larger than `LONG_MAX`.

Nice, this is a really useful improvement. I've left one comment below

> Note that we do not yet assert signedness of the passed variable, which
> is another source of bugs. This will be handled in a subsequent commit.
> 
> +		} else {
> +			value = strtoimax(arg, (char **)&s, 10);
> +			if (*s)
> +				return error(_("%s expects a numerical value"),
> +					     optname(opt, flags));

To catch overflow errors for arguments of intimax_t we need to do

	errno = 0
	value = strtoimax(arg, (Char **)&s, 10);
	if (errno || *s)
		return error(...)

to catch the error when we parse the string as the checks below only 
work for narrower types.

Best Wishes

Phillip

> +
> +		}
>   
> +		if (value < lower_bound || value > upper_bound)
> +			return error(_("value %"PRIdMAX" for %s not in range [%"PRIdMAX",%"PRIdMAX"]"),
> +				     value, optname(opt, flags), lower_bound, upper_bound);
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
>   		if (unset) {
>   			*(unsigned long *)opt->value = 0;
> diff --git a/parse-options.h b/parse-options.h
> index 997ffbee805..8d5f9c95f9c 100644
> --- a/parse-options.h
> +++ b/parse-options.h
> @@ -92,6 +92,10 @@ typedef int parse_opt_subcommand_fn(int argc, const char **argv,
>    * `value`::
>    *   stores pointers to the values to be filled.
>    *
> + * `precision`::
> + *   precision of the integer pointed to by `value`. Should typically be its
> + *   `sizeof()`.
> + *
>    * `argh`::
>    *   token to explain the kind of argument this option wants. Does not
>    *   begin in capital letter, and does not end with a full stop.
> @@ -151,6 +155,7 @@ struct option {
>   	int short_name;
>   	const char *long_name;
>   	void *value;
> +	size_t precision;
>   	const char *argh;
>   	const char *help;
>   
> @@ -214,6 +219,7 @@ struct option {
>   	.short_name = (s), \
>   	.long_name = (l), \
>   	.value = (v), \
> +	.precision = sizeof(*v), \
>   	.argh = N_("n"), \
>   	.help = (h), \
>   	.flags = (f), \
> diff --git a/t/helper/test-parse-options.c b/t/helper/test-parse-options.c
> index 997f55fd45b..b1275dfade4 100644
> --- a/t/helper/test-parse-options.c
> +++ b/t/helper/test-parse-options.c
> @@ -120,6 +120,7 @@ int cmd__parse_options(int argc, const char **argv)
>   	};
>   	struct string_list expect = STRING_LIST_INIT_NODUP;
>   	struct string_list list = STRING_LIST_INIT_NODUP;
> +	int16_t i16 = 0;
>   
>   	struct option options[] = {
>   		OPT_BOOL(0, "yes", &boolean, "get a boolean"),
> @@ -139,6 +140,7 @@ int cmd__parse_options(int argc, const char **argv)
>   		OPT_NEGBIT(0, "neg-or4", &boolean, "same as --no-or4", 4),
>   		OPT_GROUP(""),
>   		OPT_INTEGER('i', "integer", &integer, "get a integer"),
> +		OPT_INTEGER(0, "i16", &i16, "get a 16 bit integer"),
>   		OPT_INTEGER('j', NULL, &integer, "get a integer, too"),
>   		OPT_MAGNITUDE('m', "magnitude", &magnitude, "get a magnitude"),
>   		OPT_SET_INT(0, "set23", &integer, "set integer to 23", 23),
> @@ -210,6 +212,7 @@ int cmd__parse_options(int argc, const char **argv)
>   	}
>   	show(&expect, &ret, "boolean: %d", boolean);
>   	show(&expect, &ret, "integer: %d", integer);
> +	show(&expect, &ret, "i16: %"PRIdMAX, (intmax_t) i16);
>   	show(&expect, &ret, "magnitude: %lu", magnitude);
>   	show(&expect, &ret, "timestamp: %"PRItime, timestamp);
>   	show(&expect, &ret, "string: %s", string ? string : "(not set)");
> diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
> index 2fe3522305f..e3ca7a27738 100755
> --- a/t/t0040-parse-options.sh
> +++ b/t/t0040-parse-options.sh
> @@ -22,6 +22,7 @@ usage: test-tool parse-options <options>
>   
>       -i, --[no-]integer <n>
>                             get a integer
> +    --[no-]i16 <n>        get a 16 bit integer
>       -j <n>                get a integer, too
>       -m, --magnitude <n>   get a magnitude
>       --[no-]set23          set integer to 23
> @@ -136,6 +137,7 @@ test_expect_success 'OPT_MAGNITUDE() 3giga' '
>   cat >expect <<\EOF
>   boolean: 2
>   integer: 1729
> +i16: 0
>   magnitude: 16384
>   timestamp: 0
>   string: 123
> @@ -156,6 +158,7 @@ test_expect_success 'short options' '
>   cat >expect <<\EOF
>   boolean: 2
>   integer: 1729
> +i16: 9000
>   magnitude: 16384
>   timestamp: 0
>   string: 321
> @@ -167,7 +170,7 @@ file: prefix/fi.le
>   EOF
>   
>   test_expect_success 'long options' '
> -	test-tool parse-options --boolean --integer 1729 --magnitude 16k \
> +	test-tool parse-options --boolean --integer 1729 --i16 9000 --magnitude 16k \
>   		--boolean --string2=321 --verbose --verbose --no-dry-run \
>   		--abbrev=10 --file fi.le --obsolete \
>   		>output 2>output.err &&
> @@ -179,6 +182,7 @@ test_expect_success 'abbreviate to something longer than SHA1 length' '
>   	cat >expect <<-EOF &&
>   	boolean: 0
>   	integer: 0
> +	i16: 0
>   	magnitude: 0
>   	timestamp: 0
>   	string: (not set)
> @@ -253,6 +257,7 @@ test_expect_success 'superfluous value provided: cmdmode' '
>   cat >expect <<\EOF
>   boolean: 1
>   integer: 13
> +i16: 0
>   magnitude: 0
>   timestamp: 0
>   string: 123
> @@ -276,6 +281,7 @@ test_expect_success 'intermingled arguments' '
>   cat >expect <<\EOF
>   boolean: 0
>   integer: 2
> +i16: 0
>   magnitude: 0
>   timestamp: 0
>   string: (not set)
> @@ -343,6 +349,7 @@ cat >expect <<\EOF
>   Callback: "four", 0
>   boolean: 5
>   integer: 4
> +i16: 0
>   magnitude: 0
>   timestamp: 0
>   string: (not set)
> @@ -368,6 +375,7 @@ test_expect_success 'OPT_CALLBACK() and callback errors work' '
>   cat >expect <<\EOF
>   boolean: 1
>   integer: 23
> +i16: 0
>   magnitude: 0
>   timestamp: 0
>   string: (not set)
> @@ -447,6 +455,7 @@ test_expect_success 'OPT_NUMBER_CALLBACK() works' '
>   cat >expect <<\EOF
>   boolean: 0
>   integer: 0
> +i16: 0
>   magnitude: 0
>   timestamp: 0
>   string: (not set)
> @@ -783,4 +792,16 @@ test_expect_success 'magnitude with units but no numbers' '
>   	test_must_be_empty out
>   '
>   
> +test_expect_success 'i16 limits range' '
> +	test-tool parse-options --i16 32767 >out &&
> +	test_grep "i16: 32767" out &&
> +	test_must_fail test-tool parse-options --i16 32768 2>err &&
> +	test_grep "value 32768 for option .i16. not in range \[-32768,32767\]" err &&
> +
> +	test-tool parse-options --i16 -32768 >out &&
> +	test_grep "i16: -32768" out &&
> +	test_must_fail test-tool parse-options --i16 -32769 2>err &&
> +	test_grep "value -32769 for option .i16. not in range \[-32768,32767\]" err
> +'
> +
>   test_done
> 

