Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65C21F92E
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 15:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758642164; cv=none; b=q5sHFc2OYNiG6GOykHM44A/gvAtZoGlsRpmQ8q+pXqsovHqG8nS3HiPLiYBl6DL9D2BLco6XSKlQ7aUrY7oSOn8SUHh9dLzJixXp+Pd0lcR+40+TbxGUtdA1cDGqTQAmb60ItqjOl29+r6WOixxgugabUEXCnTcoPX/XQPXtM/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758642164; c=relaxed/simple;
	bh=qDER7T0ZrappJftH5qWl65UZi1WkMFSXdV2m+5FdWwE=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iHTyj8tkiIa9qUNNmZpbqOvD13XvWhB8NQAWsNoE/OhUhjoqFB1oXSUMA0agIuggs3HrC6LZIB5XdE7R9GIvM9tYOqQPOmEaCYbvPmEc3B2p5ZI4Lga8gtivhKZjzEtvVTiFNKG3wh2Gm25k/OSVTjJmv/PxpgpB6AcIRmJbvfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fTdehHcX; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fTdehHcX"
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-5a6afdbc4f4so128643137.1
        for <git@vger.kernel.org>; Tue, 23 Sep 2025 08:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758642161; x=1759246961; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=SiIZ6HknEKk11lq8bN/MFud2456ixwpHU+GNjuKDEM4=;
        b=fTdehHcXF6bld2JT0On+Xz5lcsDIlBHTSyQnzfnuxCQSi1YwGEBFrUztWYLoOvkhRH
         +tNiwWzKfn13hKUufkxPxaWKm/pTpOkg1otrTJ827Tf7XIPj3oP33hX4LOhNPUDSgvp1
         a/9VV92JV+15f5Q186R/SuX6HKJnVqd0ZkHJm0EsHDuzHtgXPGJ5Hf6fWAUoz00zDyvV
         fSUcdxUA28aFdcZD8OzOOc9gW0IK43w6i6yg+srYXQ5QmtOCraP0ECLvGIRDhhBeJNkp
         MhXJd07n6p+6fWyYSmaanogUPdZKDbCiwvaGFTyu5IWKwc6uHn0sIsWncuORQdm2+isq
         ryQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758642161; x=1759246961;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SiIZ6HknEKk11lq8bN/MFud2456ixwpHU+GNjuKDEM4=;
        b=K4htqdDSDn63Eyoamyqu0GO0WSiQpPN0H7e3SPdywedHucJBrSHz1v29HfYD/c0Urz
         FREtW9BSH93m5A3L6NG2gx70yXMrsvPSNwHmCir0ngBwhFE4NVggjLBh0Sc5kWxw2IDi
         ANEBYPTCB5C3+1824UHpDS+DJvCl0pMPMM+6dTzD+ygJUe26dbwDweJ+dTV317FvgwVj
         Xw09/IldZtsLdPzpndJNJWAh0sNz4L1VzQ15KimXoJXrM6tgDnj1cLS/m0uz/9zFdmS+
         GHypTQunmeCR94AYfJPoYbTQzI6Un63A9brOrcluZjqaOIMi6jZ518QA0nu5RPCuKmbW
         LkAg==
X-Gm-Message-State: AOJu0YwiIeMsBWMM/9TDkDYp6LutenH7x+6aXx/ARzxwr1k7INiT6zfe
	IQ88zVOKJlB4gi7RvEjh/93z9TmUw8HhwwnyXeLCDPRSxz8ffOjdPrwzv/agbR0V/mMZ/i2ozo3
	7cOSIsev7afhV9l1GIGPM3/YWGpykD0afYpSt
X-Gm-Gg: ASbGncs8FPmf0rYAd59VgyPg88Mg6Ob/DVdPnADLyYNNypUJIdF8Warek68XDTkER1h
	JPfv3xUZaSd2K6LEkMGYM8hUTGgXx0IpejGsaxVwqJNJ/WFqBxCOmfiN3tsgEgom4q7WCoUBXgI
	kI2av3AzhWOS293JLB0ev5HeQgD64Vk3cMUakCLL1n2a6yrGTGIJsSkt/bNVOur4NVgpLwKWkux
	2tBhxRBSjEHyPSZaw==
X-Google-Smtp-Source: AGHT+IHbEzku800hLADxphbDW0p56I2HQjzK1j8k6ICC/6oVGQpoca7BjJEIJFgjDMN9wck9+YEbFZcBZHjxwyCh5nY=
X-Received: by 2002:a05:6102:1484:b0:522:b5e6:2f46 with SMTP id
 ada2fe7eead31-5a574fc4f8dmr1039272137.5.1758642161290; Tue, 23 Sep 2025
 08:42:41 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 23 Sep 2025 11:42:39 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 23 Sep 2025 11:42:39 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqo6r793iw.fsf@gitster.g>
References: <20250918-228-reftable-introduce-consistency-checks-v3-0-271af03eb34d@gmail.com>
 <20250918-228-reftable-introduce-consistency-checks-v3-3-271af03eb34d@gmail.com>
 <xmqqo6r793iw.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 23 Sep 2025 11:42:39 -0400
X-Gm-Features: AS18NWB8d5zTHMj0LY7bymxV2P6ftdHnK2Vn6FrKpOqQsCOPiM6yGd7DtQCaTWc
Message-ID: <CAOLa=ZTaLF9X+gqR1rhymfY5L=z8h0wsEQ-DW1Vi3LQe1Zd86w@mail.gmail.com>
Subject: Re: [PATCH v3 3/8] reftable: check for trailing newline in 'tables.list'
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, ps@pks.im, shejialuo@gmail.com
Content-Type: multipart/mixed; boundary="0000000000004fc5c3063f79c952"

--0000000000004fc5c3063f79c952
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> diff --git a/reftable/basics.h b/reftable/basics.h
>> index 7d22f96261..019dfe6d7e 100644
>> --- a/reftable/basics.h
>> +++ b/reftable/basics.h
>> @@ -167,10 +167,11 @@ void free_names(char **a);
>>
>>  /*
>>   * Parse a newline separated list of names. `size` is the length of the buffer,
>> - * without terminating '\0'. Empty names are discarded. Returns a `NULL`
>> - * pointer when allocations fail.
>> + * without terminating '\0'. Empty names are discarded.
>> + *
>> + * Errors are assigned to the `err` variable.
>>   */
>> -char **parse_names(char *buf, int size);
>> +char **parse_names(char *buf, int size, int *err);
>>
>>  /* compares two NULL-terminated arrays of strings. */
>>  int names_equal(const char **a, const char **b);
>
> Makes sense.
>
>> diff --git a/reftable/stack.c b/reftable/stack.c
>> index f91ce50bcd..955be1edb6 100644
>> --- a/reftable/stack.c
>> +++ b/reftable/stack.c
>> @@ -109,11 +109,9 @@ static int fd_read_lines(int fd, char ***namesp)
>>  	}
>>  	buf[size] = 0;
>>
>> -	*namesp = parse_names(buf, size);
>> -	if (!*namesp) {
>> -		err = REFTABLE_OUT_OF_MEMORY_ERROR;
>> +	*namesp = parse_names(buf, size, &err);
>> +	if (!*namesp)
>>  		goto done;
>
> Nice.
>
>> diff --git a/t/unit-tests/u-reftable-basics.c b/t/unit-tests/u-reftable-basics.c
>> index a0471083e7..f77ec96429 100644
>> --- a/t/unit-tests/u-reftable-basics.c
>> +++ b/t/unit-tests/u-reftable-basics.c
>> @@ -9,6 +9,7 @@ license that can be found in the LICENSE file or at
>>  #include "unit-test.h"
>>  #include "lib-reftable.h"
>>  #include "reftable/basics.h"
>> +#include "reftable/reftable-error.h"
>>
>>  struct integer_needle_lesseq_args {
>>  	int needle;
>> @@ -79,14 +80,17 @@ void test_reftable_basics__names_equal(void)
>>  void test_reftable_basics__parse_names(void)
>>  {
>>  	char in1[] = "line\n";
>> -	char in2[] = "a\nb\nc";
>> -	char **out = parse_names(in1, strlen(in1));
>> +	char in2[] = "a\nb\nc\n";
>> +	int err = 0;
>> +	char **out = parse_names(in1, strlen(in1), &err);
>> +	cl_assert(err == 0);
>>  	cl_assert(out != NULL);
>>  	cl_assert_equal_s(out[0], "line");
>>  	cl_assert(!out[1]);
>>  	free_names(out);
>>
>> -	out = parse_names(in2, strlen(in2));
>> +	out = parse_names(in2, strlen(in2), &err);
>> +	cl_assert(err == 0);
>>  	cl_assert(out != NULL);
>>  	cl_assert_equal_s(out[0], "a");
>>  	cl_assert_equal_s(out[1], "b");
>
> Sensible.
>
>> @@ -95,10 +99,21 @@ void test_reftable_basics__parse_names(void)
>>  	free_names(out);
>>  }
>>
>> +void test_reftable_basics__parse_names_missing_newline(void)
>> +{
>> +	char in1[] = "line\nline2";
>> +	int err = 0;
>> +	char **out = parse_names(in1, strlen(in1), &err);
>> +	cl_assert(err == REFTABLE_FORMAT_ERROR);
>> +	cl_assert(out == NULL);
>> +}
>
> OK.
>
>>  void test_reftable_basics__parse_names_drop_empty_string(void)
>>  {
>>  	char in[] = "a\n\nb\n";
>> -	char **out = parse_names(in, strlen(in));
>> +	int err = 0;
>> +	char **out = parse_names(in, strlen(in), &err);
>> +	cl_assert(err ==  0);
>
> I'll drop an extra SP after == here (no need to resend only to fix
> this).
>

Ah! thanks for doing that. I'll patch it locally incase I need to
reroll!

Karthik

--0000000000004fc5c3063f79c952
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: b4d500de70de1d7b_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1qU3Yrd1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOSt6Qy9vQ1NVaVNCNzBTdW5hR2xvNlFmMjJ0bDB3Mgo3VmJrV3FaVkYx
enkvejVRWDRwS0d0RnhCWkphZ2hNbXJ2SDR5S1VWUUNkdkhTWm1LMWViZTBUbmJIZHRzeE1aCmhE
VWl6MkY4QzRQN3lQWUFkYVZJdzRHMUZ5c2Q5dVZQVzhsRFIyclRlUlA5a3E1N0FrVXUxUk9tL3ow
YnoyNFgKVm5sR0UyTVpYL2ZHL0Vxd1dRNmQ1elIrMWtCMXFvclV3MFg5cys0dnFCUzFpY2xKN3Vt
VDJPenFzNzErU1JOZQplcUFXMWQ4bzFRT3k5ZW5pNzErclgrQ2xDSFZKKzRydjhoNkJCNktxTG43
VmtYU2xTR1B0WWp4S0NYRk9oMHpvCjZhMWlxNTRMTXU4OEEzQjlsMXkrNW9Fd3RzMjRoRUdDQjVU
Q3hiazI4TVdtd2pXb0lVYUpVd0JWeHNyYS96UTYKQ1VVVTduWG85NHluVWlEL3lJeHZvalI4NUtm
cjlJQlZZZy83VE13aGF2MTJaMlpLMDZNWWI2YllPK3lRb0Zlago4ZEtHd3h0ZThqdS9BWEt4RFhh
a1QzUlo1a0VuOTluQ2toV3FoNGhYekw3Z3cxd0Qva3dHVEY1eHA1dm96NUFOCjJnM2lXdnJXTDZO
U2JDMFh5ZVQveW4zdFZVdFF5TWRqcldrdU1DRT0KPUY2S0oKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000004fc5c3063f79c952--
