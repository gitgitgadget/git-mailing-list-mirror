Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F4D49656
	for <git@vger.kernel.org>; Tue, 25 Jun 2024 10:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719310482; cv=none; b=OZvgLn+GpNjPOo9n7BZXWr6bAiMeinDAC+DuSKMPkX0qTe1RZVZEEkEwbH2A0bshqT70ORySNAfYAuJxL96z2PTIn6u2ohrWRRnAB2GiRIRGoJZyv8J/pz8LLiUPQMoA8/HpJ71JTMWsWCjhOQ8plcHqr3dIVuwnO/pcmjD2Obg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719310482; c=relaxed/simple;
	bh=uTHkaSMx3gopxZ7M7lnqPTf9gzRdHbjiPN6bot9ME0o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sP/1wR4WoX//X0KsyQ1QXAJ+Si6ax/0g2Np76UyHrsp8pqSdUG3wYhv72uJje6+QFW3VhDqiTfMsgu+Xygn8epUr0moD2J/baB9+MxVDUwdXCmN5XKaCcOvvmVUIc+q0NVDKapTdLw1WhjaCi/NZV3ouljZD3/5xhQ+fQykKNAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RcaHzJGR; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RcaHzJGR"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3636c572257so4531666f8f.0
        for <git@vger.kernel.org>; Tue, 25 Jun 2024 03:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719310479; x=1719915279; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Fq6lUwHBPE4s7RvqIalIlmfnZ7WSc245lgpgLsFUt6Q=;
        b=RcaHzJGRoN027zhv8qpFJEZRBhaqM7I+w1IKqfuE/IsDWg+cdGiU/NqSWEqOx7BsY8
         9jBbduMiLBbkR/peoCizLVEFptLN121cPsCIv/lO7Pyc7zr+IjYIqMAfE0KdbpLbth79
         mrWLtwHsS86uTfn4jkeJ3QUDnz/RYhbjyhJLe+QyN3t9HDYGQcXt+/XGKR0HhUnKrtMh
         0lmVsmZqdRm2IegXmTSmDON//4MQbIfFgYyFlpJ/xegj793dRxpuSE8VDya9Ihzs/6Vt
         a/77yjrZhqgP95t2rEdfpczI3XSs2NogUmyWvByqW0REch44821i4ucg4JlWtHRl+5g7
         BsSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719310479; x=1719915279;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fq6lUwHBPE4s7RvqIalIlmfnZ7WSc245lgpgLsFUt6Q=;
        b=vhiRIWYuxzLQx4AuInsygDXyBJNYSzivno7IBIyJ2czvSaWhwkTpaJnPO1U4BS60df
         TJZTinl4nQjZJzeRSqjfOq9zQnPdwRPwGMNZANXGgqfjPV/97RDTaIAqDn8Ko1X8SRWU
         53R5EWBEiiSGVM9oKPGRr/96lxmygry8Rnmh2PoeRNJhauOVFquVf8eYvu+aF93uJx8w
         QRknvijLhMCZ/xJ5Jv/ouHSwzXfy8W+iFijP9+9uWoonH7zZ5ShWR8r4f3dsQfLECwW3
         WyyOmj8IYPZMbMHR2Gfay3Xk6YEa0aYEgAKZNM8CpQZRFQ520yOzwMvmSe0Ps+JjEc0q
         /qcQ==
X-Gm-Message-State: AOJu0Yx7fCGQU3fUnlIGRd5oPh8xWav03el1DI3yw4b45+2DEO8F90IU
	IIJXxUrzPtqkFJpCkksgVNC6Q5ZXXdCZ/fZfEMmY3VWFJ3lLAQJ1
X-Google-Smtp-Source: AGHT+IGpvFhpCr5iyAaT4PBk1u2rm/gl3lPONrLHJyT6+V+sGFOReUA/zxoY0NXuEGO/6FIilFu9cw==
X-Received: by 2002:a5d:518c:0:b0:360:75b1:77fb with SMTP id ffacd0b85a97d-366e946707bmr5739974f8f.8.1719310478539;
        Tue, 25 Jun 2024 03:14:38 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:64f:8901:d2c6:37ff:fef6:7b1? ([2a0a:ef40:64f:8901:d2c6:37ff:fef6:7b1])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3663ada128dsm12562002f8f.117.2024.06.25.03.14.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jun 2024 03:14:38 -0700 (PDT)
Message-ID: <827f6cea-2367-403f-ba8b-055c9c8a7259@gmail.com>
Date: Tue, 25 Jun 2024 11:14:37 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [GSoC][PATCH] t: migrate helper/test-oidmap.c to
 unit-tests/t-oidmap.c
To: Jonathan Nieder <jrnieder@gmail.com>,
 Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com,
 Christian Couder <chriscool@tuxfamily.org>,
 Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
 Josh Steadmon <steadmon@google.com>
References: <20240619175036.64291-1-shyamthakkar001@gmail.com>
 <ZnP6G6SSBynlBNUj@google.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <ZnP6G6SSBynlBNUj@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ghanshyam

On 20/06/2024 10:45, Jonathan Nieder wrote:
> Ghanshyam Thakkar wrote:
> 
>> helper/test-oidmap.c along with t0016-oidmap.sh test the oidmap.h
>> library which is built on top of hashmap.h to store arbitrary
>> datastructure (which must contain oidmap_entry, which is a wrapper
>> around object_id).

I'm not really sure what the sentence is trying to say. I think it would 
be helpful to start the commit message with an introductory sentence 
explaining that the oidmap is currently tested via `test-tool` and this 
commit converts those tests to unit tests.

  These entries can be accessed by querying their
>> associated object_id.
>>
>> Migrate them to the unit testing framework for better performance,
>> concise code and better debugging. Along with the migration also plug
>> memory leaks and make the test logic independent for all the tests.

>> The migration removes 'put' tests from t0016, because it is used as
>> setup to all the other tests, so testing it separately does not yield
>> any benefit.

Thanks sounds sensible, thanks for explaining it in the commit message.

Overall the patch looks pretty good, I've left a couple of comments below.

>> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
>> Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
>> Signed-off-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
>> ---

>> diff --git a/t/unit-tests/t-oidmap.c b/t/unit-tests/t-oidmap.c
>> new file mode 100644
>> index 0000000000..9b98a3ed09
>> --- /dev/null
>> +++ b/t/unit-tests/t-oidmap.c
>> @@ -0,0 +1,165 @@
>> +#include "test-lib.h"
>> +#include "lib-oid.h"
>> +#include "oidmap.h"
>> +#include "hash.h"
>> +#include "hex.h"
>> +
>> +/*
>> + * elements we will put in oidmap structs are made of a key: the entry.oid
>> + * field, which is of type struct object_id, and a value: the name field (could
>> + * be a refname for example)
>> + */
>> +struct test_entry {
>> +	struct oidmap_entry entry;
>> +	char name[FLEX_ARRAY];
>> +};
>> +
>> +static const char *key_val[][2] = { { "11", "one" },
>> +				    { "22", "two" },
>> +				    { "33", "three" } };
>> +
>> +static int put_and_check_null(struct oidmap *map, const char *hex,
>> +			      const char *entry_name)
>> +{
>> +	struct test_entry *entry;
>> +
>> +	FLEX_ALLOC_STR(entry, name, entry_name);
>> +	if (get_oid_arbitrary_hex(hex, &entry->entry.oid))
>> +		return -1;

When writing unit tests it is important to make sure that they fail, 
rather than just return early if there is an error. There are a number 
of places like this that return early without calling one of the check() 
macros to make the test fail.

>> +	if (!check(oidmap_put(map, entry) == NULL))
>> +		return -1;
>> +	return 0;
>> +}
>> +
>> +static void setup(void (*f)(struct oidmap *map))
>> +{
>> +	struct oidmap map = OIDMAP_INIT;
>> +	int ret = 0;
>> +
>> +	for (size_t i = 0; i < ARRAY_SIZE(key_val); i++)
>> +		if ((ret = put_and_check_null(&map, key_val[i][0],
>> +					      key_val[i][1])))

Given there is only one caller I think it would be easier to see what is 
going on if the function body was just inlined into the loop here.

>> +			break;
>> +
>> +	if (!ret)
>> +		f(&map);
>> +	oidmap_free(&map, 1);
>> +}

The tests for replace, get, remove all look like faithful translations 
of the old script and are fine apart from some missing check() calls 
when get_oid_arbitrary_hex() fails.

>> +static int key_val_contains(struct test_entry *entry)
>> +{
>> +	/* the test is small enough to be able to bear O(n) */

It is good to think about that but I'm not sure we need a comment about 
it in a small test like this.

>> +	for (size_t i = 0; i < ARRAY_SIZE(key_val); i++) {
>> +		if (!strcmp(key_val[i][1], entry->name)) {
>> +			struct object_id oid;
>> +			if (get_oid_arbitrary_hex(key_val[i][0], &oid))
>> +				return -1;
>> +			if (oideq(&entry->entry.oid, &oid))
>> +				return 0;
>> +		}
>> +	}
>> +	return 1;
>> +}

So if we cannot construct the oid we return -1, if the oid matches we 
return 0 and if the oid does not match we return 1

>> +static void t_iterate(struct oidmap *map)
>> +{
>> +	struct oidmap_iter iter;
>> +	struct test_entry *entry;
>> +	int ret;
>> +
>> +	oidmap_iter_init(map, &iter);
>> +	while ((entry = oidmap_iter_next(&iter))) {
>> +		if (!check_int((ret = key_val_contains(entry)), ==, 0)) {
>> +			if (ret == -1)
>> +				return;
>> +			test_msg("obtained entry was not given in the input\n"
>> +				 "  name: %s\n   oid: %s\n",
>> +				 entry->name, oid_to_hex(&entry->entry.oid));

This checks that all of the expect objects are present, but does not 
check for duplicate objects. An alternative would be to build an array 
of all the entries, then sort it by oid and compare that to a sorted 
version of `key_val`. That is what the scripted version does. We don't 
have any helpers for comparing arrays so you'd need to do that by 
comparing each element in a loop.

>> +		}
>> +	}
>> +	check_int(hashmap_get_size(&map->map), ==, ARRAY_SIZE(key_val));

One could argue that this helps guard against duplicate entries but 
that's only true if we trust hashmap_get_size() so I think keeping this 
to check that hashmap_get_size() gives the correct size and changing the 
loop above would be better.

Thanks

Phillip

>> +}
>> +
>> +int cmd_main(int argc UNUSED, const char **argv UNUSED)
>> +{
>> +	TEST(setup(t_replace), "replace works");
>> +	TEST(setup(t_get), "get works");
>> +	TEST(setup(t_remove), "remove works");
>> +	TEST(setup(t_iterate), "iterate works");
>> +	return test_done();
>> +}
>> -- 
>> 2.45.2
>>
>>
> 

