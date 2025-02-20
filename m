Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E481FDE26
	for <git@vger.kernel.org>; Thu, 20 Feb 2025 14:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740062315; cv=none; b=CLMEhUtKa/pO4Se7zpIZxj3kYoGj0XOgTz1Hb2bJ3rT2RNOP1KjKVwj4LN7xQJU/Or4VeU0NF3XaIfevZh1Gfs6kkc5u8NPXG67fqcN3fXw6ODQ8xTWkWgbkFlQMC9m6m5Gv/61Wthxwcwpy9T1Acbq7uKKKv9m+P5OAteOyUTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740062315; c=relaxed/simple;
	bh=S1tP+z05TJLQejBbd5aH+mtjtJ6vtje00DqQTAMoHQE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I2PdMnEuZDm6kfVQWhP3k9qXOnyF1ZxunMuRE6XFM5XOCKlmCn3B8cUxCGHfnuhA1w+UgStiSzJScMXmYli98PeUdxJLwhPMKlW1/vAhZUvq6gjTUs2BGXmM312GVTZq0jkI59wSClmWfiyd6yel2tBsYKszyfNgNwY/fNiwUAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lmx6sSB5; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lmx6sSB5"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-438a39e659cso6794985e9.2
        for <git@vger.kernel.org>; Thu, 20 Feb 2025 06:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740062312; x=1740667112; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=69kHMxawDxr7KM0mrM1B/JX0eP8gtF+0fG7Or3sK+rQ=;
        b=lmx6sSB5sGafghiqoluiLYkjB+0FfN2SbOp1n58Im65jKTCsulwKHTOlit+bQyMSc1
         oTQyno6CEjnqajFpEIK0i5GSSTCjcXXJhDh/P5OZQ4mOF20Qfofpw2A22CDtYePrAPbF
         JiQzwrrlzabPskyiTQojVY5Kcs/nYakwbdlbCsLcnxrsJcTTq3LH4EkvUuetMpyf03Pv
         5I7Fz7/11OZuhxdbHNL4dvnkurMddRXFH0jG2LcBG4dv+8fmm4Qm/BTfO9uEd7AfFaxQ
         jKjrESekp6pZimVoh7NgTMoug8u8pyvcGATRCsxnqL8QqiOS0hjBMxR/eHqDr2uewBy2
         aPxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740062312; x=1740667112;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=69kHMxawDxr7KM0mrM1B/JX0eP8gtF+0fG7Or3sK+rQ=;
        b=mUIXsiaNbux5N6hnEjXtyLN4s9gI/f1IvEIeHIaMKUJGzWThc9UNVY/OhPfHvyB1fx
         EesjPecM8YIpDgm+aCsSCvNnD0pTmkVd30HhK9b5c/q6CX4NECil0Rfu4jE2n90AB+mc
         bhNfEkMkKdWmUsaq+QxdW1815OQN6BCFAotCeSsktFwAjjf9UqVxF52Sp3kzwekeADoN
         TRuVxtEsBcw6Z39CCeeGsgzLP6mv5gzeCxPsYhgsfmRc3sOVLMqegx0fClgWZS+sURqX
         qjH6bw49K2ILzKuO6/hHtA2GXKkmeieLpOrVVN6ciawf1SZLcZMl0YlYeKXRBadkgok9
         y2lg==
X-Forwarded-Encrypted: i=1; AJvYcCVMJLbRNzB+TIS+0F9tZEODioO3N97bxiKzh9oLJyLSh38UK3g08hDw7vLf4fMiKj4tZ4E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwehO8DtayeDTEQ4uL4VxbWmZH6G1f+dDp164niURIFrfajhZuU
	AEtuZ+91qbQA2tJ1S6T46ON10VnVIIPaF+685WNxLzqnwQUf5Ff+
X-Gm-Gg: ASbGncuaG8QGOFUuBqCOw8Q2aEELgmyJBTtN3P/ImTgUbknsuraDhZpBjTNRt/qxppy
	WlI6bVVescpjG7fZt8sVV4XfCu2GbyS1DQPYnoGz8v0oEpzZw3De8m6wLQigeIskH0HCWA4xCz/
	KCw1P9mcIm+ijjpyRpX/QHMOFawe2HimQdkJdBagO9qh5zZQW3K1e4gb/KtXoCvhzQRUGlTnIgZ
	EuHD1ydSD9GfiaiW+jTT8uYVYjvfqA3+pHQUBpoHAn8d6VSOWWfCQYPnLLhwr3nH95iJAUYJ/br
	AlwD/ZGeLnNZu3qLY57hsmdx4CClqubBL7BDbLIKt0NRFx05bC+mu6NT8aGzaTvbXeDP6A==
X-Google-Smtp-Source: AGHT+IE2+AAhbAL8yxkYspD/njlVPd8aJGD+MV5TxB862PWN4YLNac2/7cS3EX+2sbFiEimDduaIdQ==
X-Received: by 2002:a05:600c:3493:b0:439:8e46:ee73 with SMTP id 5b1f17b1804b1-4398e46f160mr129382595e9.15.1740062311740;
        Thu, 20 Feb 2025 06:38:31 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:700:a501:27ae:70ed:9eda:7f80? ([2a0a:ef40:700:a501:27ae:70ed:9eda:7f80])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259f7998sm20521419f8f.82.2025.02.20.06.38.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 06:38:31 -0800 (PST)
Message-ID: <cf9d44d0-20ed-4d8f-84a3-1bf284075605@gmail.com>
Date: Thu, 20 Feb 2025 14:38:30 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 2/5] t/unit-tests: convert oid-array test to use clar
To: Seyi Kuforiji <kuforiji98@gmail.com>, git@vger.kernel.org
Cc: ps@pks.im, phillip.wood@dunelm.org.uk
References: <20250220082959.10854-1-kuforiji98@gmail.com>
 <20250220082959.10854-3-kuforiji98@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <20250220082959.10854-3-kuforiji98@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Seyi

On 20/02/2025 08:29, Seyi Kuforiji wrote:
> Adapt oid-array test script to clar framework by using clar assertions
> where necessary. Remove descriptions from macros to reduce
> redundancy, and move test input arrays to global scope for reuse across
> multiple test functions. Introduce `test_oid_array__initialize()` to
> explicitly initialize the hash algorithm.
> 
> These changes streamline the test suite, making individual tests
> self-contained and reducing redundant code.

I think these conversion look correct but once again we're losing 
valuable debugging information because we haven't added better 
assertions to clar.

>   	oid_array_for_each_unique(&input, add_to_oid_array, &actual);
> -	if (!check_uint(actual.nr, ==, expect.nr))
> -		return;
> -
> -	for (i = 0; i < actual.nr; i++) {
> -		if (!check(oideq(&actual.oid[i], &expect.oid[i])))
> -			test_msg("expected: %s\n       got: %s\n     index: %" PRIuMAX,
> -				 oid_to_hex(&expect.oid[i]), oid_to_hex(&actual.oid[i]),
> -				 (uintmax_t)i);
> -	}
> +	cl_assert_equal_i(actual.nr, expect.nr);
> +
> +	for (i = 0; i < actual.nr; i++)
> +		cl_assert(oideq(&actual.oid[i], &expect.oid[i]));

If this fails the poor person debugging it will have no idea why as 
there is now no indication of which two oids were being compared.

> -	if (!check_int(ret, <=, upper_bound) ||
> -	    !check_int(ret, >=, lower_bound))
> -		test_msg("oid query for lookup: %s", oid_to_hex(&oid_query));
> +	cl_assert(ret <= upper_bound);
> +	cl_assert(ret >= lower_bound);

This is another case where we could do with better assertions in clar

> -static void setup(void)
> +void test_oid_array__initialize(void)
>   {
>   	/* The hash algo is used by oid_array_lookup() internally */
>   	int algo = init_hash_algo();
> -	if (check_int(algo, !=, GIT_HASH_UNKNOWN))
> -		repo_set_hash_algo(the_repository, algo);
> +	cl_assert(algo != GIT_HASH_UNKNOWN);

init_has_algo() in unit-test.c already does this.

Best Wishes

Phillip


> +	repo_set_hash_algo(the_repository, algo);
>   }
>   
> -int cmd_main(int argc UNUSED, const char **argv UNUSED)
> +static const char *arr_input[] = { "88", "44", "aa", "55" };
> +static const char *arr_input_dup[] = { "88", "44", "aa", "55",
> +				       "88", "44", "aa", "55",
> +				       "88", "44", "aa", "55" };
> +static const char *res_sorted[] = { "44", "55", "88", "aa" };
> +
> +void test_oid_array__enumerate_unique(void)
>   {
> -	const char *arr_input[] = { "88", "44", "aa", "55" };
> -	const char *arr_input_dup[] = { "88", "44", "aa", "55",
> -					"88", "44", "aa", "55",
> -					"88", "44", "aa", "55" };
> -	const char *res_sorted[] = { "44", "55", "88", "aa" };
> -	const char *nearly_55;
> +	TEST_ENUMERATION(arr_input, res_sorted);
> +}
> +
> +void test_oid_array__enumerate_duplicate(void)
> +{
> +	TEST_ENUMERATION(arr_input_dup, res_sorted);
> +}
> +
> +void test_oid_array__lookup(void)
> +{
> +	TEST_LOOKUP(arr_input, "55", 1, 1);
> +}
>   
> -	if (!TEST(setup(), "setup"))
> -		test_skip_all("hash algo initialization failed");
> +void test_oid_array__lookup_non_existent(void)
> +{
> +	TEST_LOOKUP(arr_input, "33", INT_MIN, -1);
> +}
> +
> +void test_oid_array__lookup_duplicates(void)
> +{
> +	TEST_LOOKUP(arr_input_dup, "55", 3, 5);
> +}
>   
> -	TEST_ENUMERATION(arr_input, res_sorted, "ordered enumeration");
> -	TEST_ENUMERATION(arr_input_dup, res_sorted,
> -			 "ordered enumeration with duplicate suppression");
> +void test_oid_array__lookup_non_existent_dup(void)
> +{
> +	TEST_LOOKUP(arr_input_dup, "66", INT_MIN, -1);
> +}
>   
> -	TEST_LOOKUP(arr_input, "55", 1, 1, "lookup");
> -	TEST_LOOKUP(arr_input, "33", INT_MIN, -1, "lookup non-existent entry");
> -	TEST_LOOKUP(arr_input_dup, "55", 3, 5, "lookup with duplicates");
> -	TEST_LOOKUP(arr_input_dup, "66", INT_MIN, -1,
> -		    "lookup non-existent entry with duplicates");
> +void test_oid_array__lookup_almost_dup(void)
> +{
> +	const char *nearly_55;
>   
>   	nearly_55 = init_hash_algo() == GIT_HASH_SHA1 ?
>   			"5500000000000000000000000000000000000001" :
>   			"5500000000000000000000000000000000000000000000000000000000000001";
> -	TEST_LOOKUP(((const char *[]){ "55", nearly_55 }), "55", 0, 0,
> -		    "lookup with almost duplicate values");
> -	TEST_LOOKUP(((const char *[]){ "55", "55" }), "55", 0, 1,
> -		    "lookup with single duplicate value");
>   
> -	return test_done();
> +	TEST_LOOKUP(((const char *[]){ "55", nearly_55 }), "55", 0, 0);
> +}
> +
> +void test_oid_array__lookup_single_dup(void)
> +{
> +	TEST_LOOKUP(((const char *[]){ "55", "55" }), "55", 0, 1);
>   }

