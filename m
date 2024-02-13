Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788232868D
	for <git@vger.kernel.org>; Tue, 13 Feb 2024 10:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707821731; cv=none; b=J1OJLnFGLAuUzkWF+OFRDarzlK2QvaON8pVOEYM+6ERGZhm3AfoC9UEnXlKBVyZ3STXSQIUgXfzx5t7x97Po1IA3rp74CNQwCTwMZmB5P17nrx0Jp/ba04W4hzJ86pudmo86llbwww6+rVu6cmq1qV939Rj5ZuCc/5+nob3iOII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707821731; c=relaxed/simple;
	bh=qx8WHx2hpEDXZHCNEKgkG2DZJNGZU0qsshb6GU3EwBk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EArLcnX9qoeNE/3IadagL6hg6ulQQqPh//9Ham0Cgmd5mXq5SVuRpQU9f0Eexi9t/qIyfROmPWuyssxv3hBkKgmutmdfA5JtdTuzyebhGaArw4nMSOwOz6Cp0n3+492FtcH/SBbVMVWzMMS3Yi8gXGyEQtlRxzlGKcZJDb3YQzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R0zLDSME; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R0zLDSME"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4108cbd92b9so21766855e9.1
        for <git@vger.kernel.org>; Tue, 13 Feb 2024 02:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707821727; x=1708426527; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GcTWc1g6jpwQa6pNxWiw7E3W+7U4YFEYy4HHrf4vQws=;
        b=R0zLDSMEPRHh8ny2ZIROQZzcEIpNxJ1FAi8BVe1TdbJGziFer0C1sxzGjNyQpVbHjt
         tYaoGmw481Uott+DNUH5zjtzEXrMzbtbcGSr1Dvmp3MjvX9zFbgG9UT33PC36m0e5Ze5
         BMjpoOtBLkSnLa7Z+guaAVS8GsfUEqCwT8rqfFFAr+wGlZ+BvaQXxVA6K5DFHJsg2QWZ
         xGvVkfpCx2byRS/pkXrSV6T/FdIaFWGPkeVuqMut7SkR1vxmGLulukj1VlmNQCU63IZl
         ssWPuRL82CvzYUQktKhMBYAZST09cKJLeULCa53hytKZPPnDtgPzWRSoGTWmGec4W8te
         yd6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707821727; x=1708426527;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GcTWc1g6jpwQa6pNxWiw7E3W+7U4YFEYy4HHrf4vQws=;
        b=gx7SdIECoCbW20X0VB4ihkuI04aK/QJeCCLvFje+xozaR+Bq/mdJLEusLBl06oGPC1
         MfrY3JoNVy58pV8nGrltmzn6X32y+VXOaCWrbSHUKC66HvHWmx3DFPEuYwAT4wok0GrQ
         GJnNJPUuzKBimFLgp/LIvgsV0vDnoPJmlj+IYkmlTZSGAWF0JvyYP6FipBo9jFyWRFN6
         LupVUid3AYj08WzbDLve7HAnFctKlXDRDvfB1o5R2cczcXft8alNs+emibuT+bPL7Vct
         Rc48yV2XpjjGYaBaxxIUF3lqtN/xYjohuUNQkgryZiNsJ2jy7SS1dwsQU/Zv0X82OMX3
         y8HA==
X-Gm-Message-State: AOJu0YxxO2671qO8xnJBer6sOlZrP1ewWMM0igjqQaPTW3eTrpJCTKN9
	Ebm2TqsTLeOxVtAFQWJytwcu6sqeuFYyd2xTYlfYJnqb3VIIv9DA0YZu3JeQ
X-Google-Smtp-Source: AGHT+IGjtgIj/oZPEk1899bJVZVqNpqNnCaJaM1QOLiFDaFxUukqU/aN0WWI454qY80/EH6UmZBQ2g==
X-Received: by 2002:a05:600c:1d03:b0:40f:f891:d282 with SMTP id l3-20020a05600c1d0300b0040ff891d282mr8495368wms.18.1707821726446;
        Tue, 13 Feb 2024 02:55:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXnmcjiDtUlEUqiMyLkYyrZLmkhbiaXQlgY40pcLNGFMbh7pO1kD3XI6TQEhwdYm4UqMznSKt7D3AeEPQE3zI0mkMDUMpMn9VfWIDHDkWMH4lf2cRjI7GGDZOfgCTBx3qldzA==
Received: from ?IPV6:2a0a:ef40:62e:a901:d2c6:37ff:fef6:7b1? ([2a0a:ef40:62e:a901:d2c6:37ff:fef6:7b1])
        by smtp.googlemail.com with ESMTPSA id fs20-20020a05600c3f9400b00410232ffb2csm11405599wmb.25.2024.02.13.02.55.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Feb 2024 02:55:26 -0800 (PST)
Message-ID: <fd8874bb-8e45-4b39-986c-5a96ccf0747f@gmail.com>
Date: Tue, 13 Feb 2024 10:55:25 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2] unit-tests: do show relative file paths on
 non-Windows, too
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>,
 "Randall S. Becker" <rsbecker@nexbridge.com>
References: <xmqqttmf9y46.fsf@gitster.g>
 <6872b42d-8763-44dc-9502-2362d1ed80a7@gmail.com>
 <xmqqle7r9enn.fsf_-_@gitster.g>
 <c625239a-a847-475a-a228-9deb622c67bf@gmail.com> <xmqqsf1x486b.fsf@gitster.g>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqqsf1x486b.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/02/2024 22:41, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>>> There is a larger clean-up opportunity to drop the need for making a
>>> copy, which probably is worth doing, so I folded the above into this
>>> version.
>>
>> Ooh, that's nice. This version looks good, I found the code comments
>> very helpful
> 
> Thanks.
> 
> Judging from https://github.com/git/git/actions/runs/7878254534/job/21496314393#step:5:142
> I do not seen to have broken Windows with this change, so let's
> fast-track and merge it down to 'master' before -rc1.

I think it was only the MSVC that needed the paths munging which we 
don't test by default. I have tweaked our github actions to run those 
tests and they pass 
https://github.com/phillipwood/git/actions/runs/7885144920/job/21515922057#step:5:146

Best Wishes

Phillip


>> Best Wishes
>>
>> Phillip
>>
>>> ------- >8 ------------- >8 ------------- >8 ------------- >8 -------
>>> There are compilers other than Visual C that want to show absolute
>>> paths.  Generalize the helper introduced by a2c5e294 (unit-tests: do
>>> show relative file paths, 2023-09-25) so that it can also work with
>>> a path that uses slash as the directory separator, and becomes
>>> almost no-op once one-time preparation finds out that we are using a
>>> compiler that already gives relative paths.  Incidentally, this also
>>> should do the right thing on Windows with a compiler that shows
>>> relative paths but with backslash as the directory separator (if
>>> such a thing exists and is used to build git).
>>> Reported-by: Randall S. Becker <rsbecker@nexbridge.com>
>>> Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>>> ---
>>>     * I found that the diff relative to the result of applying v1 was
>>>       easier to follow than the range-diff, so here it is.
>>>     diff --git c/t/unit-tests/test-lib.c w/t/unit-tests/test-lib.c
>>>     index 83c9eb8c59..66d6980ffb 100644
>>>     --- c/t/unit-tests/test-lib.c
>>>     +++ w/t/unit-tests/test-lib.c
>>>     @@ -64,34 +64,33 @@ static const char *make_relative(const char *location)
>>>      		 * prefix_len == 0 if the compiler gives paths relative
>>>      		 * to the root of the working tree.  Otherwise, we want
>>>      		 * to see that we did find the needle[] at a directory
>>>     -		 * boundary.
>>>     +		 * boundary.  Again we rely on that needle[] begins with
>>>     +		 * "t" followed by the directory separator.
>>>      		 */
>>>      		if (fspathcmp(needle, prefix + prefix_len) ||
>>>     -		    (prefix_len &&
>>>     -		     prefix[prefix_len - 1] != '/' &&
>>>     -		     prefix[prefix_len - 1] != '\\'))
>>>     +		    (prefix_len && prefix[prefix_len - 1] != needle[1]))
>>>      			die("unexpected suffix of '%s'", prefix);
>>>     -
>>>      	}
>>>          	/*
>>>     -	 * If our compiler gives relative paths and we do not need
>>>     -	 * to munge directory separator, we can return location as-is.
>>>     +	 * Does it not start with the expected prefix?
>>>     +	 * Return it as-is without making it worse.
>>>      	 */
>>>     -	if (!prefix_len && !need_bs_to_fs)
>>>     +	if (prefix_len && fspathncmp(location, prefix, prefix_len))
>>>      		return location;
>>>         -	/* Does it not start with the expected prefix? */
>>>     -	if (fspathncmp(location, prefix, prefix_len))
>>>     -		return location;
>>>     +	/*
>>>     +	 * If we do not need to munge directory separator, we can return
>>>     +	 * the substring at the tail of the location.
>>>     +	 */
>>>     +	if (!need_bs_to_fs)
>>>     +		return location + prefix_len;
>>>         -	strlcpy(buf, location + prefix_len, sizeof(buf));
>>>      	/* convert backslashes to forward slashes */
>>>     -	if (need_bs_to_fs) {
>>>     -		for (p = buf; *p; p++)
>>>     -			if (*p == '\\')
>>>     -				*p = '/';
>>>     -	}
>>>     +	strlcpy(buf, location + prefix_len, sizeof(buf));
>>>     +	for (p = buf; *p; p++)
>>>     +		if (*p == '\\')
>>>     +			*p = '/';
>>>      	return buf;
>>>      }
>>>        t/unit-tests/test-lib.c | 61
>>> +++++++++++++++++++++++++++++++----------
>>>    1 file changed, 47 insertions(+), 14 deletions(-)
>>> diff --git a/t/unit-tests/test-lib.c b/t/unit-tests/test-lib.c
>>> index 7bf9dfdb95..66d6980ffb 100644
>>> --- a/t/unit-tests/test-lib.c
>>> +++ b/t/unit-tests/test-lib.c
>>> @@ -21,12 +21,11 @@ static struct {
>>>    	.result = RESULT_NONE,
>>>    };
>>>    -#ifndef _MSC_VER
>>> -#define make_relative(location) location
>>> -#else
>>>    /*
>>>     * Visual C interpolates the absolute Windows path for `__FILE__`,
>>>     * but we want to see relative paths, as verified by t0080.
>>> + * There are other compilers that do the same, and are not for
>>> + * Windows.
>>>     */
>>>    #include "dir.h"
>>>    @@ -34,32 +33,66 @@ static const char *make_relative(const char
>>> *location)
>>>    {
>>>    	static char prefix[] = __FILE__, buf[PATH_MAX], *p;
>>>    	static size_t prefix_len;
>>> +	static int need_bs_to_fs = -1;
>>>    -	if (!prefix_len) {
>>> +	/* one-time preparation */
>>> +	if (need_bs_to_fs < 0) {
>>>    		size_t len = strlen(prefix);
>>> -		const char *needle = "\\t\\unit-tests\\test-lib.c";
>>> +		char needle[] = "t\\unit-tests\\test-lib.c";
>>>    		size_t needle_len = strlen(needle);
>>>    -		if (len < needle_len || strcmp(needle, prefix + len -
>>> needle_len))
>>> -			die("unexpected suffix of '%s'", prefix);
>>> +		if (len < needle_len)
>>> +			die("unexpected prefix '%s'", prefix);
>>> +
>>> +		/*
>>> +		 * The path could be relative (t/unit-tests/test-lib.c)
>>> +		 * or full (/home/user/git/t/unit-tests/test-lib.c).
>>> +		 * Check the slash between "t" and "unit-tests".
>>> +		 */
>>> +		prefix_len = len - needle_len;
>>> +		if (prefix[prefix_len + 1] == '/') {
>>> +			/* Oh, we're not Windows */
>>> +			for (size_t i = 0; i < needle_len; i++)
>>> +				if (needle[i] == '\\')
>>> +					needle[i] = '/';
>>> +			need_bs_to_fs = 0;
>>> +		} else {
>>> +			need_bs_to_fs = 1;
>>> +		}
>>>    -		/* let it end in a directory separator */
>>> -		prefix_len = len - needle_len + 1;
>>> +		/*
>>> +		 * prefix_len == 0 if the compiler gives paths relative
>>> +		 * to the root of the working tree.  Otherwise, we want
>>> +		 * to see that we did find the needle[] at a directory
>>> +		 * boundary.  Again we rely on that needle[] begins with
>>> +		 * "t" followed by the directory separator.
>>> +		 */
>>> +		if (fspathcmp(needle, prefix + prefix_len) ||
>>> +		    (prefix_len && prefix[prefix_len - 1] != needle[1]))
>>> +			die("unexpected suffix of '%s'", prefix);
>>>    	}
>>>    -	/* Does it not start with the expected prefix? */
>>> -	if (fspathncmp(location, prefix, prefix_len))
>>> +	/*
>>> +	 * Does it not start with the expected prefix?
>>> +	 * Return it as-is without making it worse.
>>> +	 */
>>> +	if (prefix_len && fspathncmp(location, prefix, prefix_len))
>>>    		return location;
>>>    -	strlcpy(buf, location + prefix_len, sizeof(buf));
>>> +	/*
>>> +	 * If we do not need to munge directory separator, we can return
>>> +	 * the substring at the tail of the location.
>>> +	 */
>>> +	if (!need_bs_to_fs)
>>> +		return location + prefix_len;
>>> +
>>>    	/* convert backslashes to forward slashes */
>>> +	strlcpy(buf, location + prefix_len, sizeof(buf));
>>>    	for (p = buf; *p; p++)
>>>    		if (*p == '\\')
>>>    			*p = '/';
>>> -
>>>    	return buf;
>>>    }
>>> -#endif
>>>      static void msg_with_prefix(const char *prefix, const char
>>> *format, va_list ap)
>>>    {

