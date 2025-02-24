Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3960B24A06B
	for <git@vger.kernel.org>; Mon, 24 Feb 2025 10:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740391954; cv=none; b=NzxPZmAOwsRMjJnNSFVxziWyacxYrJcUsdIIbHJV+yV4ZtIjUewNJ5hPUoeW50tkr21htpUMrcISYbBD1ccVD1jbNdZU6NkjWcbcBTeYGx/hoH3Zm6+ScE5f0FduG7Fz6P9t2YYf/whiZLQp9lspcGizVmtYunMyUHPhlmmHGrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740391954; c=relaxed/simple;
	bh=IokIY66F/oXLE8nuprphYd150QS5+9dpTr7Wjr5hufg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=jFt/M3jeoPc9+iWuYvx7zzORS/WXxlbsF00IFBjZY4bFrDqDiAIVVfaqHL6dr4ZSUz1Q0JFcjKbbWXVn0c1gKK8oB0i0C+7IPDHjccQer7cp7M7+qn6Y3YzD6ab1R06yG3/kILWtyiqD9fhLaYDf+Wbmuge3E8kmxDpAAu6gFQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BB+d/9Ii; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BB+d/9Ii"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4398ec2abc2so36595585e9.1
        for <git@vger.kernel.org>; Mon, 24 Feb 2025 02:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740391950; x=1740996750; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fV5goECIvfntTsppzYyp4Dm/6TcS/MqNYDH0mbShSOk=;
        b=BB+d/9Iiin/QdofrWF/AM5Pni+o7ikbC+TCcP7co/tX1BDEEPuoMKd11EmmAa/TWqI
         /yG4zw7GF7d670TGnE3zVk/b/sobTmbHuY9YDZekw7EmFybVCZxSXzPV6MVRGwnY0Ser
         VUPlXPpw57df0tioF+UD1CxEZbwQA38I5rmjNiSPK0scSB8uF6B4rOxSIetX9RrU7Fi4
         Vm+wszqUhYXNZ2ZQcnWtkD1jslwQKQG/XcExzkdp4/ZwEeqvAOlvFrb51+zGODlUwNr1
         0DVtPJ24htzK2cW0+H7UDOMMO8FsTDg8WaEwoXNYkdIDhtzI+TO764aGyBxHZ3RI0Lv+
         zlxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740391950; x=1740996750;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fV5goECIvfntTsppzYyp4Dm/6TcS/MqNYDH0mbShSOk=;
        b=A575TEHEoKCwr3aijJNTd+6S4/TT/in5Jzriqaeg4LFrwbpCaIIj525YrhnwuXhkEq
         +JjbsxYpeCtQ0oaVZGgskZwf6OmZLimkpJXP9qSjQaEFpPG6DpIaCz+Kkpd+9Z1W8Rua
         8VT++YVkGaUegwMVKCuUboNa8SwsyG/ZriOoFTwmWEoPD5SP9Cyshk++pBJ2hGMcJaus
         Yj5wnpbYESMDlmwZ+R8wDEAPV/4CEUR7D6ANFGjdImoM8mYYBeppxLOx0Mqqfyphhw5A
         U8JP7MgC950S4cxfQ8oHdqynWd3F8utLrgpkpQHeg2x/vDTxKEj1J/I2Tp8NSMYprFCE
         qEfA==
X-Gm-Message-State: AOJu0YzRhJmMDgW662ZvbKZgYqoU5W+zflFvFuhXh8k9Xj8RzIDwFvuT
	3+1V0fM3SFrxmKEava9weo7f8y8DG/Av1X2bVU+PGqm3AAi5cC6y1qLnrORZmrw=
X-Gm-Gg: ASbGncsz15KFpPMv00c1Q413GTNpcZ8HJ4KQBOmlDhXkm+G+KCSHKtWYNmObV3er86n
	y8c9x6PtXtws05Aq8nln8R4vNdlLiP35QH1O71WjkDgiJxhs1ZWkt7HBpW0wjSN1NUJBPE6zZWN
	0m9TH0oiczuv7AC1jI1WHTN8thcR/9trd3sqE0luI8Bu68fidiVjalwSkZ5WVc0iW5pBX1g+59N
	yuC3vPFJpsSc9cUQWMVTulB2bpdv3GClGpBw/D11klLJTr9nbSLXrMZvseQ2UdzErMJIzKvERsW
	gUNM+8GGtzUufPJr8NTBEcLhA6Wrqr3sT7JK5tehTRT08/GCm/4V4g5mCww5Bbulu3cUqkLBRkd
	Uz4+v
X-Google-Smtp-Source: AGHT+IFim2ZWSJ2tobX5lVBdw+i2E6MrY9uXRFc2F5IqrCjZicx6XvJlhdHOr6KhLPDXtkqtksHDpg==
X-Received: by 2002:a5d:59a3:0:b0:38f:470c:932e with SMTP id ffacd0b85a97d-38f6f03e319mr9758478f8f.29.1740391950082;
        Mon, 24 Feb 2025 02:12:30 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:700:a501:27ae:70ed:9eda:7f80? ([2a0a:ef40:700:a501:27ae:70ed:9eda:7f80])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439b02e425esm101038085e9.17.2025.02.24.02.12.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 02:12:29 -0800 (PST)
Message-ID: <1c34ccb8-fb6c-4101-a00f-29fc2fb89934@gmail.com>
Date: Mon, 24 Feb 2025 10:12:24 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 2/5] t/unit-tests: convert oid-array test to use clar
To: Seyi Chamber <kuforiji98@gmail.com>, phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, ps@pks.im
References: <20250220082959.10854-1-kuforiji98@gmail.com>
 <20250220082959.10854-3-kuforiji98@gmail.com>
 <cf9d44d0-20ed-4d8f-84a3-1bf284075605@gmail.com>
 <CAGedMtfgYzEBFe7_jghhJRHt5MXAesc+GfJXDDgP=BLg8LeRyg@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAGedMtfgYzEBFe7_jghhJRHt5MXAesc+GfJXDDgP=BLg8LeRyg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Seyi

On 24/02/2025 09:11, Seyi Chamber wrote:
> On Thu, 20 Feb 2025 at 15:38, Phillip Wood <phillip.wood123@gmail.com> wrote:
>>
>> Hi Seyi
>>
>> On 20/02/2025 08:29, Seyi Kuforiji wrote:
>>> Adapt oid-array test script to clar framework by using clar assertions
>>> where necessary. Remove descriptions from macros to reduce
>>> redundancy, and move test input arrays to global scope for reuse across
>>> multiple test functions. Introduce `test_oid_array__initialize()` to
>>> explicitly initialize the hash algorithm.
>>>
>>> These changes streamline the test suite, making individual tests
>>> self-contained and reducing redundant code.
>>
>> I think these conversion look correct but once again we're losing
>> valuable debugging information because we haven't added better
>> assertions to clear.
>>
> 
> I understand your concern about losing debugging information, but it
> is more beneficial to prioritize clarity and simplicity in unit tests.
> Unit tests should be short and easy, and adding extra debugging
> messages increases complexity, making them harder to maintain and
> read. The assertion failures already indicate where an issue occurs,
> allowing whoever is debugging to inspect the test inputs directly if
> needed.

If the test failure is on a CI run for a platform that the person 
debugging the failure does not have access to how are they going to do 
that? This is not a hypothetical concern as our CI runs the test suite 
on MacOs, Linux and Windows. Individual developers often only have 
access to one or to of those platforms. My experience of debugging CI 
test failures is that without decent diagnostic messages it is extremely 
difficult to figure out what went wrong if one does not have access to 
the platform where the test is failing.

> Assertion failures are rarely hit in real-world scenarios, and when
> they do occur, one can manually print values or use a debugger to
> investigate. This makes the additional debugging messages unnecessary
> in most cases.

This seems to be arguing that because we expect the tests to pass we 
don't need to worry about how difficult it is to debug them when they 
fail. I do not agree with that line of argument.

> The lack of explicit debugging output is not a
> significant issue in practice. Furthermore, there are plans to
> collaborate with Clar upstream to equip common assertions with the
> ability to print custom messages in a formatted string where an error
> occurs. This would allow our test to be simple and easy to read and
> also maintain some of our custom debug messages.

Have you got any more details about this please? We already have 
cl_failf() in our codebase.

Best Wishes

Phillip

> 
> 
>>>        oid_array_for_each_unique(&input, add_to_oid_array, &actual);
>>> -     if (!check_uint(actual.nr, ==, expect.nr))
>>> -             return;
>>> -
>>> -     for (i = 0; i < actual.nr; i++) {
>>> -             if (!check(oideq(&actual.oid[i], &expect.oid[i])))
>>> -                     test_msg("expected: %s\n       got: %s\n     index: %" PRIuMAX,
>>> -                              oid_to_hex(&expect.oid[i]), oid_to_hex(&actual.oid[i]),
>>> -                              (uintmax_t)i);
>>> -     }
>>> +     cl_assert_equal_i(actual.nr, expect.nr);
>>> +
>>> +     for (i = 0; i < actual.nr; i++)
>>> +             cl_assert(oideq(&actual.oid[i], &expect.oid[i]));
>>
>> If this fails the poor person debugging it will have no idea why as
>> there is now no indication of which two oids were being compared.
>>
>>> -     if (!check_int(ret, <=, upper_bound) ||
>>> -         !check_int(ret, >=, lower_bound))
>>> -             test_msg("oid query for lookup: %s", oid_to_hex(&oid_query));
>>> +     cl_assert(ret <= upper_bound);
>>> +     cl_assert(ret >= lower_bound);
>>
>> This is another case where we could do with better assertions in clar
>>
>>> -static void setup(void)
>>> +void test_oid_array__initialize(void)
>>>    {
>>>        /* The hash algo is used by oid_array_lookup() internally */
>>>        int algo = init_hash_algo();
>>> -     if (check_int(algo, !=, GIT_HASH_UNKNOWN))
>>> -             repo_set_hash_algo(the_repository, algo);
>>> +     cl_assert(algo != GIT_HASH_UNKNOWN);
>>
>> init_has_algo() in unit-test.c already does this.
>>
> 
> Thanks for spotting this! Will fix this in an updated patch.
>> Best Wishes
>>
>> Phillip
>>
>>
>>> +     repo_set_hash_algo(the_repository, algo);
>>>    }
>>>
>>> -int cmd_main(int argc UNUSED, const char **argv UNUSED)
>>> +static const char *arr_input[] = { "88", "44", "aa", "55" };
>>> +static const char *arr_input_dup[] = { "88", "44", "aa", "55",
>>> +                                    "88", "44", "aa", "55",
>>> +                                    "88", "44", "aa", "55" };
>>> +static const char *res_sorted[] = { "44", "55", "88", "aa" };
>>> +
>>> +void test_oid_array__enumerate_unique(void)
>>>    {
>>> -     const char *arr_input[] = { "88", "44", "aa", "55" };
>>> -     const char *arr_input_dup[] = { "88", "44", "aa", "55",
>>> -                                     "88", "44", "aa", "55",
>>> -                                     "88", "44", "aa", "55" };
>>> -     const char *res_sorted[] = { "44", "55", "88", "aa" };
>>> -     const char *nearly_55;
>>> +     TEST_ENUMERATION(arr_input, res_sorted);
>>> +}
>>> +
>>> +void test_oid_array__enumerate_duplicate(void)
>>> +{
>>> +     TEST_ENUMERATION(arr_input_dup, res_sorted);
>>> +}
>>> +
>>> +void test_oid_array__lookup(void)
>>> +{
>>> +     TEST_LOOKUP(arr_input, "55", 1, 1);
>>> +}
>>>
>>> -     if (!TEST(setup(), "setup"))
>>> -             test_skip_all("hash algo initialization failed");
>>> +void test_oid_array__lookup_non_existent(void)
>>> +{
>>> +     TEST_LOOKUP(arr_input, "33", INT_MIN, -1);
>>> +}
>>> +
>>> +void test_oid_array__lookup_duplicates(void)
>>> +{
>>> +     TEST_LOOKUP(arr_input_dup, "55", 3, 5);
>>> +}
>>>
>>> -     TEST_ENUMERATION(arr_input, res_sorted, "ordered enumeration");
>>> -     TEST_ENUMERATION(arr_input_dup, res_sorted,
>>> -                      "ordered enumeration with duplicate suppression");
>>> +void test_oid_array__lookup_non_existent_dup(void)
>>> +{
>>> +     TEST_LOOKUP(arr_input_dup, "66", INT_MIN, -1);
>>> +}
>>>
>>> -     TEST_LOOKUP(arr_input, "55", 1, 1, "lookup");
>>> -     TEST_LOOKUP(arr_input, "33", INT_MIN, -1, "lookup non-existent entry");
>>> -     TEST_LOOKUP(arr_input_dup, "55", 3, 5, "lookup with duplicates");
>>> -     TEST_LOOKUP(arr_input_dup, "66", INT_MIN, -1,
>>> -                 "lookup non-existent entry with duplicates");
>>> +void test_oid_array__lookup_almost_dup(void)
>>> +{
>>> +     const char *nearly_55;
>>>
>>>        nearly_55 = init_hash_algo() == GIT_HASH_SHA1 ?
>>>                        "5500000000000000000000000000000000000001" :
>>>                        "5500000000000000000000000000000000000000000000000000000000000001";
>>> -     TEST_LOOKUP(((const char *[]){ "55", nearly_55 }), "55", 0, 0,
>>> -                 "lookup with almost duplicate values");
>>> -     TEST_LOOKUP(((const char *[]){ "55", "55" }), "55", 0, 1,
>>> -                 "lookup with single duplicate value");
>>>
>>> -     return test_done();
>>> +     TEST_LOOKUP(((const char *[]){ "55", nearly_55 }), "55", 0, 0);
>>> +}
>>> +
>>> +void test_oid_array__lookup_single_dup(void)
>>> +{
>>> +     TEST_LOOKUP(((const char *[]){ "55", "55" }), "55", 0, 1);
>>>    }
>>
> 
> Thanks
> Seyi

