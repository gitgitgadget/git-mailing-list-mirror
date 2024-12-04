Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA57198848
	for <git@vger.kernel.org>; Wed,  4 Dec 2024 08:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733302223; cv=none; b=ciBc6MGsytyn8JGVwFKRtQ221Hk4gSli36sEFOlgHVLj6URdo6DEifpu3fCD7hgEoVzXVkUzGQg2nEuSe64mpex+5uPgKzH/GJ5aBYL7wYDddqo//9U0bi1p/Xb6kfsnkAY6660PHOQI2vrfxmQaYjGm0dpXcxJeTv3aRWiwzAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733302223; c=relaxed/simple;
	bh=7j09DC/2NtI1i6+O0Xoizzp4HlXTfBxlj7pEXJVVXjI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=UC/nvWL1Qo6fx9oRn/OYlaAyx69LJvhd1eElTxbavfZDRJD2c2Yg+/ckibzLIMG8Ezu4WbGLrdPOyV/DcxohW23DS+tPxWbpLE8QoRUD+uACYUePdnpDOKccYFrVuAvVha/KQHFiAhDsigQuepR0sC8z+aknYcP8P9hzXdleA84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K6OFwc76; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K6OFwc76"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-434a752140eso55027365e9.3
        for <git@vger.kernel.org>; Wed, 04 Dec 2024 00:50:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733302220; x=1733907020; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=p1qx0eXrjtIhQAFVSiJZOf0WlMlp0RSZ3dxIK7ZrGpA=;
        b=K6OFwc761R+mzfrg2Kt56LShy4eYAJI/IjE0iDzYwDOiYRJBG1A5B8D+X50lb6jbPQ
         TypfyC71klCWJqLOnTH+g4EuUoSP3GaIZLdDewL0d9i4y6r9p/UQ3O+Q0QKyV3zqkStP
         UFbcEmGAc38z6Cnq/VY1V8zREV+/R1u3Hbe2EwrHRuZbX3xpgPWfYDbq67X2MzS4pm9f
         LsnrTCuEnRYryhKMVHD6Zo1R42Y/vb5NszY+KqmFdpFsRD4fwGbpOzM7tlutjdLJ6bmz
         S3UvabsQk7v4Feyn40J3RlEGoEr2ZmNSXL5RyWfxKTGmVVt8tuXeDPG+l/Ay71F9nc58
         VglA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733302220; x=1733907020;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p1qx0eXrjtIhQAFVSiJZOf0WlMlp0RSZ3dxIK7ZrGpA=;
        b=uugLbj5Hq3+ivLLBmqQ+jLYccaBrvx1fzMBcGGvw2femWBgQ0/gBI4lVuPqwj2d906
         BmoUeHvN2CPp2mvQ4cahVYZ8epCuKT0jDny6SL9g9Iu98G9XaDp7pkz4zIm1tSRQhEBd
         iSJJa+ORPuGAXMKWGG8EdbnUf18rbBWVOj9KCI3TmHEGEURk7WSGUkNzYJDU6X3OqS7Z
         /CgPa+i8PaDrbvZ9akSNu9LoDTGVeRfXXjBfMXxfTsG9q55Igjn/w8n/rOMOnlIGfgM6
         aCYZdcwCat9YmO9l0+QmO7ONgc08Tq+I3tG+hwIi+XdUuRh9379ua+R771CVWDCDFdIg
         o63Q==
X-Gm-Message-State: AOJu0Yw2tdoJ0WU4a5fN5HhHw94v8jB3hJNRtd1pfaRSDEDQQ6sDPNW7
	rEyEPycrUgX5HPtOPTEY2n34f/6HCIDrBRxPQxrLXotkUiSIaITg
X-Gm-Gg: ASbGnctfRyKePHWCVIm7Kv5QApk09cvuH0/ocYSwlOHRkNk+usmb0XE0sSfiSxaUHGD
	VRGaBZovvgdTxmv9++g0UkUWizm3kUydIw798EbMj7tay7S8ejRdvTP/wO5thSPTU/TpjP8EPL/
	hmKXHd+DM7PiZVFXn/lLd0OqU1Rug/Y9C8+OchmP4GDXQZ98bMsjbegpQheoGe35EO0b0Hpz3wx
	5q62L1uxS4+/2PjfPC9S7LxkudGbZrDIR0qNBMH5cJ7+FcnDSPxjXxI5IVI1cXQTtVmTVjMADhA
	/jWCCIVx
X-Google-Smtp-Source: AGHT+IGZ+L8Fzx3V3yQ6vS9Vao4tlmGQs4cVncpYmYGpWNhNv3reqsWx9xa18n100RaF+fkpdg0zWw==
X-Received: by 2002:a05:600c:3b83:b0:434:a902:97cf with SMTP id 5b1f17b1804b1-434d09bf0edmr47808705e9.14.1733302219909;
        Wed, 04 Dec 2024 00:50:19 -0800 (PST)
Received: from gmail.com (231.red-88-14-48.dynamicip.rima-tde.net. [88.14.48.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385e32ee381sm12788747f8f.76.2024.12.04.00.50.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 00:50:19 -0800 (PST)
Message-ID: <4e60eedc-e4d9-423c-b2e7-f1c65bccc254@gmail.com>
Date: Wed, 4 Dec 2024 09:50:18 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] strvec: `strvec_splice()` to a statically initialized
 vector
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Git List <git@vger.kernel.org>, Patrick Steinhardt <ps@pks.im>
References: <37d0abbf-c703-481d-9f26-b237aac54c05@gmail.com>
 <5bea9f20-eb0d-409d-8f37-f20697d6ce14@gmail.com> <xmqqwmgf3nf3.fsf@gitster.g>
 <c949fea0-817b-45f9-b8b2-55e1cb55e915@gmail.com>
Content-Language: en-US
In-Reply-To: <c949fea0-817b-45f9-b8b2-55e1cb55e915@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 12/4/24 9:46 AM, Rubén Justo wrote:
> On Wed, Dec 04, 2024 at 04:41:36PM +0900, Junio C Hamano wrote:
>> This is queued as rj/strvec-splice-fix, and t/unit-tests/bin/unit-tests
>> dies of leaks under leak-check.
> 
> Right! We need this:
> 
> diff --git a/strvec.c b/strvec.c
> index 087c020f5b..b1e6c5d8cd 100644
> --- a/strvec.c
> +++ b/strvec.c
> @@ -66,6 +66,7 @@ void strvec_splice(struct strvec *array, size_t idx, size_t len,
>                         array->v = NULL;
>                 ALLOC_GROW(array->v, array->nr + (replacement_len - len) + 1,
>                            array->alloc);
> +               array->v[array->nr + 1] = NULL;

I mean:

+               array->v[array->nr + (replacement_len - len) + 1] = NULL;


>         }
>         for (size_t i = 0; i < len; i++)
>                 free((char *)array->v[idx + i]);
> 
> Sorry.  I'll re-roll later today.
> 
>>
>>
>>
>> $ t/unit-tests/bin/unit-tests
>> TAP version 13
>> # start of suite 1: ctype
>> ok 1 - ctype::isspace
>> ok 2 - ctype::isdigit
>> ok 3 - ctype::isalpha
>> ok 4 - ctype::isalnum
>> ok 5 - ctype::is_glob_special
>> ok 6 - ctype::is_regex_special
>> ok 7 - ctype::is_pathspec_magic
>> ok 8 - ctype::isascii
>> ok 9 - ctype::islower
>> ok 10 - ctype::isupper
>> ok 11 - ctype::iscntrl
>> ok 12 - ctype::ispunct
>> ok 13 - ctype::isxdigit
>> ok 14 - ctype::isprint
>> # start of suite 2: strvec
>> ok 15 - strvec::init
>> ok 16 - strvec::dynamic_init
>> ok 17 - strvec::clear
>> ok 18 - strvec::push
>> ok 19 - strvec::pushf
>> ok 20 - strvec::pushl
>> ok 21 - strvec::pushv
>> not ok 22 - strvec::splice_just_initialized_strvec
>>     ---
>>     reason: |
>>       String mismatch: (&vec)->v[i] != expect[i]
>>       'bar' != '(null)'
>>     at:
>>       file: 't/unit-tests/strvec.c'
>>       line: 97
>>       function: 'test_strvec__splice_just_initialized_strvec'
>>     ---
>> ok 23 - strvec::splice_with_same_size_replacement
>> ok 24 - strvec::splice_with_smaller_replacement
>> ok 25 - strvec::splice_with_bigger_replacement
>> ok 26 - strvec::splice_with_empty_replacement
>> ok 27 - strvec::splice_with_empty_original
>> ok 28 - strvec::splice_at_tail
>> ok 29 - strvec::replace_at_head
>> ok 30 - strvec::replace_at_tail
>> ok 31 - strvec::replace_in_between
>> ok 32 - strvec::replace_with_substring
>> ok 33 - strvec::remove_at_head
>> ok 34 - strvec::remove_at_tail
>> ok 35 - strvec::remove_in_between
>> ok 36 - strvec::pop_empty_array
>> ok 37 - strvec::pop_non_empty_array
>> ok 38 - strvec::split_empty_string
>> ok 39 - strvec::split_single_item
>> ok 40 - strvec::split_multiple_items
>> ok 41 - strvec::split_whitespace_only
>> ok 42 - strvec::split_multiple_consecutive_whitespaces
>> ok 43 - strvec::detach
>>
>> =================================================================
>> ==5178==ERROR: LeakSanitizer: detected memory leaks
>>
>> Direct leak of 192 byte(s) in 1 object(s) allocated from:
>>     #0 0x5600496ec825 in __interceptor_realloc (/usr/local/google/home/jch/w/git.git/t/unit-tests/bin/unit-tests+0x67825) (BuildId: 6efbef9c6f87bfa879e770b463031b396d4d5efe)
>>     #1 0x56004973b4cd in xrealloc /usr/local/google/home/jch/w/git.git/wrapper.c:140:8
>>     #2 0x560049714c6f in strvec_splice /usr/local/google/home/jch/w/git.git/strvec.c:67:3
>>     #3 0x5600496f0c1d in test_strvec__splice_just_initialized_strvec /usr/local/google/home/jch/w/git.git/t/unit-tests/strvec.c:96:2
>>     #4 0x5600496f627b in clar_run_test /usr/local/google/home/jch/w/git.git/t/unit-tests/clar/clar.c:315:3
>>     #5 0x5600496f46fa in clar_run_suite /usr/local/google/home/jch/w/git.git/t/unit-tests/clar/clar.c:412:3
>>     #6 0x5600496f43e1 in clar_test_run /usr/local/google/home/jch/w/git.git/t/unit-tests/clar/clar.c:608:4
>>     #7 0x5600496f4bdf in clar_test /usr/local/google/home/jch/w/git.git/t/unit-tests/clar/clar.c:651:11
>>     #8 0x5600496f787c in cmd_main /usr/local/google/home/jch/w/git.git/t/unit-tests/unit-test.c:42:8
>>     #9 0x5600496f793a in main /usr/local/google/home/jch/w/git.git/common-main.c:9:11
>>     #10 0x7f59ea91dc89 in __libc_start_call_main csu/../sysdeps/nptl/libc_start_call_main.h:58:16
>>
>> Direct leak of 48 byte(s) in 1 object(s) allocated from:
>>     #0 0x5600496ec640 in __interceptor_calloc (/usr/local/google/home/jch/w/git.git/t/unit-tests/bin/unit-tests+0x67640) (BuildId: 6efbef9c6f87bfa879e770b463031b396d4d5efe)
>>     #1 0x5600496f4cee in clar__fail /usr/local/google/home/jch/w/git.git/t/unit-tests/clar/clar.c:687:15
>>     #2 0x5600496f5f25 in clar__assert_equal /usr/local/google/home/jch/w/git.git/t/unit-tests/clar/clar.c:844:3
>>     #3 0x5600496f0db6 in test_strvec__splice_just_initialized_strvec /usr/local/google/home/jch/w/git.git/t/unit-tests/strvec.c:97:2
>>     #4 0x5600496f627b in clar_run_test /usr/local/google/home/jch/w/git.git/t/unit-tests/clar/clar.c:315:3
>>     #5 0x5600496f46fa in clar_run_suite /usr/local/google/home/jch/w/git.git/t/unit-tests/clar/clar.c:412:3
>>     #6 0x5600496f43e1 in clar_test_run /usr/local/google/home/jch/w/git.git/t/unit-tests/clar/clar.c:608:4
>>     #7 0x5600496f4bdf in clar_test /usr/local/google/home/jch/w/git.git/t/unit-tests/clar/clar.c:651:11
>>     #8 0x5600496f787c in cmd_main /usr/local/google/home/jch/w/git.git/t/unit-tests/unit-test.c:42:8
>>     #9 0x5600496f793a in main /usr/local/google/home/jch/w/git.git/common-main.c:9:11
>>     #10 0x7f59ea91dc89 in __libc_start_call_main csu/../sysdeps/nptl/libc_start_call_main.h:58:16
>>
>> Indirect leak of 18 byte(s) in 1 object(s) allocated from:
>>     #0 0x5600496ec3c6 in __interceptor_malloc (/usr/local/google/home/jch/w/git.git/t/unit-tests/bin/unit-tests+0x673c6) (BuildId: 6efbef9c6f87bfa879e770b463031b396d4d5efe)
>>     #1 0x7f59ea9964f9 in strdup string/strdup.c:42:15
>>     #2 0x296c6c756e28271f  (<unknown module>)
>>
>> Indirect leak of 4 byte(s) in 1 object(s) allocated from:
>>     #0 0x5600496ec3c6 in __interceptor_malloc (/usr/local/google/home/jch/w/git.git/t/unit-tests/bin/unit-tests+0x673c6) (BuildId: 6efbef9c6f87bfa879e770b463031b396d4d5efe)
>>     #1 0x7f59ea9964f9 in strdup string/strdup.c:42:15
>>
>> SUMMARY: LeakSanitizer: 262 byte(s) leaked in 4 allocation(s).

