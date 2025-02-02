Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8112611CBA
	for <git@vger.kernel.org>; Sun,  2 Feb 2025 11:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738494572; cv=none; b=YDFNR9zWuv/miYRdfBPonyRMc4n5eXIfGRNuPThHSvkCBndHrrpwWq8KU3N4vbDMMwImAk8YpvTrxZSgswF/q8HLA0SyJ5mSF2HMbRnGBv6OwaKKhMaZT0lPMNaV4CfZJzkR0zRTJLXNsTyn5bt1/QeuFjKGlDjM2JmpbvEj3pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738494572; c=relaxed/simple;
	bh=2Pu/er8f8z+6R0bcJVLgWxXnfgPQ9K6bEThTAiEmzJU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=nxm1ywNQi6ObDnLiPiPntPPZhLPr50kgM1C6OuenMYTDtIAbGF8yEXDQ36FdaLHbwgmrk7QnijhoLHSn0L4ccWo1nX41z4vgJZHXhlAME9cvPV3MMCkdMhoRc5iMZI5EEZQ1tVuWw45dowwO+Br9MWEWyU0T1ZuLuPrAxTiNMvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i92mbynH; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i92mbynH"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3862d6d5765so1803772f8f.3
        for <git@vger.kernel.org>; Sun, 02 Feb 2025 03:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738494569; x=1739099369; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TAREKvy1Z1WX66a36evF5ciMeIt3h07m3V0f1kUoVQg=;
        b=i92mbynHaklXsJ9T48xBYDj3SMgDs2L94L8J2N7ciIyB1vJd40JDh03eKQTb9QyfRO
         q6QlUxIwwI4ybtHbQ2CA99wZ4p7zWgG6FbIHpZQhWUKiXoildrcxDM+f6rtVyK4IWuJl
         UtZ0rgHubgWy1VYs5pH9zejKKk1uKuPbs7L9ZVUtMRopRoT3yEpfDNn0fsHf2vC2QOn4
         rg89TRPVN6fmBKulttquUxck2B3vkzWUVT8KNSPmpevzPQyMX44Rt38YqwHU+CMdoG6M
         Nx2BbSKgVtNsF9yFkeF+P5NEhffjbBJQBAA1TOndIYoxZmE8hLHpX8BbrNLClZIAiTMh
         E8rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738494569; x=1739099369;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TAREKvy1Z1WX66a36evF5ciMeIt3h07m3V0f1kUoVQg=;
        b=f7i0W6Nq7YM6hS4Reu1Qgab+5dk2y/F4xrYMRd3n4MV94Jy8OtqUw6iqsXGfsW5Zoe
         PWA0AjE8lqTxConyI+531B+jM7NZ9rx0CYAWLxrxZHZlwfaqq5bJEck28i2PTa+YGWYy
         eFLKecyNWDM5X6/IidEVYUxcKzZMGIneU/udqXBwLYWcR34gH7PV/Po9tLbMriIYRvzD
         JFBOVw2l0+0ZFiDP5mpj/1n6BCCHO4IZmp7uv3zISofHMBpkT7gK2D4tDIRtP5TBjIJo
         b5/M76ghAz/eWr0l2nF4Ci6czJyJlSAIX+KZgzJxFyawGbAotbz3a/1b1EWOrEOVPuqL
         4ieA==
X-Forwarded-Encrypted: i=1; AJvYcCWkJdwfXaeAI1zc8CmTML16lTbJIpYBePtieFmPMq7BKpAOEbFgAYJSyNZipLmRUksNtPM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywmimw/3W/udPNcIZUp135cvCvBcGD3X1/cNT+u57IOcLHjMLVA
	sAswX7wEJ4NODsZktT5c2IMgXUBoh3RLNgrV10bacHd80eMX7PeV
X-Gm-Gg: ASbGncuEU0Gii+1Fq1+jHSxFh2I46Sa3EJH2uwoTQPVSGFJlKaCWpxVbqZkCYCzzPI3
	U5GFXdy1KwhsWQ78RRNxGWxAQf/XLwYfaL7gGkTrnbVjKwXnZJHPsUfd6Zy0eGvp9Rq+QFzzaF0
	n5BThXFkhKlWm2R0xpi7+rcKn+F7tzJYsCZb/XNgnSyCJtpW7dbgnDvRKG91lH/L3Khir16hzdJ
	qjHV2WYui9ih7BiyTorXib3BPy7F5PZ8FoL32o8uZc/s+38TgO+s2wEG4ei/QgRP5YwZMjhjFN5
	LZddtIfPjfh6FctM7rvG0kvKiWQBKuVclvDh+tCXnILg/UB8gAl7BOZsH/0lPpKA0gEvzw==
X-Google-Smtp-Source: AGHT+IHVQTZE14SRfV3MsDewrVLYCU56ifcfuc9w8ci3+Vcw9szFiGKIj8QP85eskgVxd4QlBjaKBA==
X-Received: by 2002:a05:6000:1449:b0:38a:88ac:ed10 with SMTP id ffacd0b85a97d-38c51973c01mr17077203f8f.25.1738494568427;
        Sun, 02 Feb 2025 03:09:28 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:700:a501:27ae:70ed:9eda:7f80? ([2a0a:ef40:700:a501:27ae:70ed:9eda:7f80])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c5c1cf896sm9948866f8f.94.2025.02.02.03.09.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Feb 2025 03:09:27 -0800 (PST)
Message-ID: <6be977a0-4bf9-4568-9b28-cdc988a49b89@gmail.com>
Date: Sun, 2 Feb 2025 11:09:25 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 1/4] t/unit-tests: convert hashmap test to use clar
 test framework
To: Seyi Kuforiji <kuforiji98@gmail.com>, git@vger.kernel.org
Cc: ps@pks.im, phillip.wood@dunelm.org.uk, Junio C Hamano <gitster@pobox.com>
References: <20250130091334.39922-1-kuforiji98@gmail.com>
 <20250131221420.38161-1-kuforiji98@gmail.com>
 <20250131221420.38161-2-kuforiji98@gmail.com>
Content-Language: en-US
In-Reply-To: <20250131221420.38161-2-kuforiji98@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Seyi

On 31/01/2025 22:14, Seyi Kuforiji wrote:
> Adapts hashmap test script to clar framework by using clar assertions
> where necessary.

As Patrick mentioned we use the imperative mood for our commit messages
so this should start "Adapt". I'm a bit confused by "where necessary" -
isn't that everywhere because we're using a different framework. Maybe
it would be clearer to say that we're replacing the existing assertions
with the equivalent clar assertions.

The conversion here looks correct but I'm concerned about the loss of
diagnostic messages.

> -	if (check(entry != NULL))
> -		check_str(get_value(entry), "value3");
> +	cl_assert(entry != NULL);
> +	cl_assert_equal_s(get_value(entry), "value3");

Unfortunately cl_assert_equal_s() is not equivalent to check_str()
because it does not handle NULL correctly. I think it would be very
helpful to fix that upstream. The diff below shows a possible solution
which avoids any ambiguity as to which pointer is NULL by only quoting
non-NULL values. In the long run it would be good to fix
cl_assert_equal_s() to properly quote control characters as check_str()
does.

diff --git a/t/unit-tests/clar/clar.c b/t/unit-tests/clar/clar.c
index d54e4553674..16f86c952f7 100644
--- a/t/unit-tests/clar/clar.c
+++ b/t/unit-tests/clar/clar.c
@@ -754,7 +754,12 @@ void clar__assert_equal(
                                  p_snprintf(buf, sizeof(buf), "'%s' != '%s' (at byte %d)",
                                          s1, s2, pos);
                          } else {
-                                p_snprintf(buf, sizeof(buf), "'%s' != '%s'", s1, s2);
+                                const char *q1 = s1 ? "'" : "";
+                                const char *q2 = s2 ? "'" : "";
+                                s1 = s1 ? s1 : "NULL";
+                                s2 = s2 ? s2 : "NULL";
+                                p_snprintf(buf, sizeof(buf), "%s%s%s != %s%s%s",
+                                           q1, s1, q1, q2, s2, q2);
                          }
                  }
          }
  
>   	for (size_t i = 0; i < ARRAY_SIZE(query); i++) {
>   		entry = get_test_entry(map, query[i][0], ignore_case);
> -		if (check(entry != NULL))
> -			check_str(get_value(entry), query[i][1]);
> -		else
> -			test_msg("query key: %s", query[i][0]);

It is a shame that we're removing all of the helpful debugging messages
from this test. It would be much nicer if we could keep them by using an
if statement and cl_failf() as we do in u-ctype.c

Best Wishes

Phillip

> +		cl_assert(entry != NULL);
> +		cl_assert_equal_s(get_value(entry), query[i][1]);
>   	}
>   
> -	check_pointer_eq(get_test_entry(map, "notInMap", ignore_case), NULL);
> -	check_int(map->tablesize, ==, 64);
> -	check_int(hashmap_get_size(map), ==, ARRAY_SIZE(key_val));
> +	cl_assert_equal_p(get_test_entry(map, "notInMap", ignore_case), NULL);
> +	cl_assert_equal_i(map->tablesize, 64);
> +	cl_assert_equal_i(hashmap_get_size(map), ARRAY_SIZE(key_val));
>   }
>   
>   static void t_add(struct hashmap *map, unsigned int ignore_case)
> @@ -165,39 +163,19 @@ static void t_add(struct hashmap *map, unsigned int ignore_case)
>   
>   		hashmap_for_each_entry_from(map, entry, ent)
>   		{
> -			int ret;
> -			if (!check_int((ret = key_val_contains(
> -						key_val, seen,
> -						ARRAY_SIZE(key_val), entry)),
> -				       ==, 0)) {
> -				switch (ret) {
> -				case 1:
> -					test_msg("found entry was not given in the input\n"
> -						 "    key: %s\n  value: %s",
> -						 entry->key, get_value(entry));
> -					break;
> -				case 2:
> -					test_msg("duplicate entry detected\n"
> -						 "    key: %s\n  value: %s",
> -						 entry->key, get_value(entry));
> -					break;
> -				}
> -			} else {
> -				count++;
> -			}
> +			int ret = key_val_contains(key_val, seen,
> +						   ARRAY_SIZE(key_val), entry);
> +			cl_assert_equal_i(ret, 0);
> +			count++;
>   		}
> -		check_int(count, ==, 2);
> +		cl_assert_equal_i(count, 2);
>   	}
>   
> -	for (size_t i = 0; i < ARRAY_SIZE(seen); i++) {
> -		if (!check_int(seen[i], ==, 1))
> -			test_msg("following key-val pair was not iterated over:\n"
> -				 "    key: %s\n  value: %s",
> -				 key_val[i][0], key_val[i][1]);
> -	}
> +	for (size_t i = 0; i < ARRAY_SIZE(seen); i++)
> +		cl_assert_equal_i(seen[i], 1);
>   
> -	check_int(hashmap_get_size(map), ==, ARRAY_SIZE(key_val));
> -	check_pointer_eq(get_test_entry(map, "notInMap", ignore_case), NULL);
> +	cl_assert_equal_i(hashmap_get_size(map), ARRAY_SIZE(key_val));
> +	cl_assert_equal_p(get_test_entry(map, "notInMap", ignore_case), NULL);
>   }
>   
>   static void t_remove(struct hashmap *map, unsigned int ignore_case)
> @@ -211,24 +189,25 @@ static void t_remove(struct hashmap *map, unsigned int ignore_case)
>   
>   	for (size_t i = 0; i < ARRAY_SIZE(key_val); i++) {
>   		entry = alloc_test_entry(key_val[i][0], key_val[i][1], ignore_case);
> -		check_pointer_eq(hashmap_put_entry(map, entry, ent), NULL);
> +		cl_assert_equal_p(hashmap_put_entry(map, entry, ent), NULL);
>   	}
>   
>   	for (size_t i = 0; i < ARRAY_SIZE(remove); i++) {
>   		entry = alloc_test_entry(remove[i][0], "", ignore_case);
>   		removed = hashmap_remove_entry(map, entry, ent, remove[i][0]);
> -		if (check(removed != NULL))
> -			check_str(get_value(removed), remove[i][1]);
> +		cl_assert(removed != NULL);
> +		cl_assert_equal_s(get_value(removed), remove[i][1]);
>   		free(entry);
>   		free(removed);
>   	}
>   
>   	entry = alloc_test_entry("notInMap", "", ignore_case);
> -	check_pointer_eq(hashmap_remove_entry(map, entry, ent, "notInMap"), NULL);
> +	cl_assert_equal_p(hashmap_remove_entry(map, entry, ent, "notInMap"), NULL);
>   	free(entry);
>   
> -	check_int(map->tablesize, ==, 64);
> -	check_int(hashmap_get_size(map), ==, ARRAY_SIZE(key_val) - ARRAY_SIZE(remove));
> +	cl_assert_equal_i(map->tablesize, 64);
> +	cl_assert_equal_i(hashmap_get_size(map),
> +			  ARRAY_SIZE(key_val) - ARRAY_SIZE(remove));
>   }
>   
>   static void t_iterate(struct hashmap *map, unsigned int ignore_case)
> @@ -242,38 +221,21 @@ static void t_iterate(struct hashmap *map, unsigned int ignore_case)
>   
>   	for (size_t i = 0; i < ARRAY_SIZE(key_val); i++) {
>   		entry = alloc_test_entry(key_val[i][0], key_val[i][1], ignore_case);
> -		check_pointer_eq(hashmap_put_entry(map, entry, ent), NULL);
> +		cl_assert_equal_p(hashmap_put_entry(map, entry, ent), NULL);
>   	}
>   
>   	hashmap_for_each_entry(map, &iter, entry, ent /* member name */)
>   	{
> -		int ret;
> -		if (!check_int((ret = key_val_contains(key_val, seen,
> -						       ARRAY_SIZE(key_val),
> -						       entry)), ==, 0)) {
> -			switch (ret) {
> -			case 1:
> -				test_msg("found entry was not given in the input\n"
> -					 "    key: %s\n  value: %s",
> -					 entry->key, get_value(entry));
> -				break;
> -			case 2:
> -				test_msg("duplicate entry detected\n"
> -					 "    key: %s\n  value: %s",
> -					 entry->key, get_value(entry));
> -				break;
> -			}
> -		}
> +		int ret = key_val_contains(key_val, seen,
> +					   ARRAY_SIZE(key_val),
> +					   entry);
> +		cl_assert(ret == 0);
>   	}
>   
> -	for (size_t i = 0; i < ARRAY_SIZE(seen); i++) {
> -		if (!check_int(seen[i], ==, 1))
> -			test_msg("following key-val pair was not iterated over:\n"
> -				 "    key: %s\n  value: %s",
> -				 key_val[i][0], key_val[i][1]);
> -	}
> +	for (size_t i = 0; i < ARRAY_SIZE(seen); i++)
> +		cl_assert_equal_i(seen[i], 1);
>   
> -	check_int(hashmap_get_size(map), ==, ARRAY_SIZE(key_val));
> +	cl_assert_equal_i(hashmap_get_size(map), ARRAY_SIZE(key_val));
>   }
>   
>   static void t_alloc(struct hashmap *map, unsigned int ignore_case)
> @@ -284,17 +246,17 @@ static void t_alloc(struct hashmap *map, unsigned int ignore_case)
>   		char *key = xstrfmt("key%d", i);
>   		char *value = xstrfmt("value%d", i);
>   		entry = alloc_test_entry(key, value, ignore_case);
> -		check_pointer_eq(hashmap_put_entry(map, entry, ent), NULL);
> +		cl_assert_equal_p(hashmap_put_entry(map, entry, ent), NULL);
>   		free(key);
>   		free(value);
>   	}
> -	check_int(map->tablesize, ==, 64);
> -	check_int(hashmap_get_size(map), ==, 51);
> +	cl_assert_equal_i(map->tablesize, 64);
> +	cl_assert_equal_i(hashmap_get_size(map), 51);
>   
>   	entry = alloc_test_entry("key52", "value52", ignore_case);
> -	check_pointer_eq(hashmap_put_entry(map, entry, ent), NULL);
> -	check_int(map->tablesize, ==, 256);
> -	check_int(hashmap_get_size(map), ==, 52);
> +	cl_assert_equal_p(hashmap_put_entry(map, entry, ent), NULL);
> +	cl_assert_equal_i(map->tablesize, 256);
> +	cl_assert_equal_i(hashmap_get_size(map), 52);
>   
>   	for (int i = 1; i <= 12; i++) {
>   		char *key = xstrfmt("key%d", i);
> @@ -302,27 +264,27 @@ static void t_alloc(struct hashmap *map, unsigned int ignore_case)
>   
>   		entry = alloc_test_entry(key, "", ignore_case);
>   		removed = hashmap_remove_entry(map, entry, ent, key);
> -		if (check(removed != NULL))
> -			check_str(value, get_value(removed));
> +		cl_assert(removed != NULL);
> +		cl_assert_equal_s(value, get_value(removed));
>   		free(key);
>   		free(value);
>   		free(entry);
>   		free(removed);
>   	}
> -	check_int(map->tablesize, ==, 256);
> -	check_int(hashmap_get_size(map), ==, 40);
> +	cl_assert_equal_i(map->tablesize, 256);
> +	cl_assert_equal_i(hashmap_get_size(map), 40);
>   
>   	entry = alloc_test_entry("key40", "", ignore_case);
>   	removed = hashmap_remove_entry(map, entry, ent, "key40");
> -	if (check(removed != NULL))
> -		check_str("value40", get_value(removed));
> -	check_int(map->tablesize, ==, 64);
> -	check_int(hashmap_get_size(map), ==, 39);
> +	cl_assert(removed != NULL);
> +	cl_assert_equal_s("value40", get_value(removed));
> +	cl_assert_equal_i(map->tablesize, 64);
> +	cl_assert_equal_i(hashmap_get_size(map), 39);
>   	free(entry);
>   	free(removed);
>   }
>   
> -static void t_intern(void)
> +void test_hashmap__intern(void)
>   {
>   	const char *values[] = { "value1", "Value1", "value2", "value2" };
>   
> @@ -330,32 +292,68 @@ static void t_intern(void)
>   		const char *i1 = strintern(values[i]);
>   		const char *i2 = strintern(values[i]);
>   
> -		if (!check(!strcmp(i1, values[i])))
> -			test_msg("strintern(%s) returns %s\n", values[i], i1);
> -		else if (!check(i1 != values[i]))
> -			test_msg("strintern(%s) returns input pointer\n",
> -				 values[i]);
> -		else if (!check_pointer_eq(i1, i2))
> -			test_msg("address('%s') != address('%s'), so strintern('%s') != strintern('%s')",
> -				 i1, i2, values[i], values[i]);
> -		else
> -			check_str(i1, values[i]);
> +		cl_assert_equal_s(i1, values[i]);
> +		cl_assert(i1 != values[i]);
> +		cl_assert_equal_p(i1, i2);
>   	}
>   }
>   
> -int cmd_main(int argc UNUSED, const char **argv UNUSED)
> +void test_hashmap__replace_case_sensitive(void)
> +{
> +	setup(t_replace, 0);
> +}
> +
> +void test_hashmap__replace_case_insensitive(void)
> +{
> +	setup(t_replace, 1);
> +}
> +
> +void test_hashmap__get_case_sensitive(void)
> +{
> +	setup(t_get, 0);
> +}
> +
> +void test_hashmap__get_case_insensitive(void)
> +{
> +	setup(t_get, 1);
> +}
> +
> +void test_hashmap__add_case_sensitive(void)
> +{
> +	setup(t_add, 0);
> +}
> +
> +void test_hashmap__add_case_insensitive(void)
> +{
> +	setup(t_add, 1);
> +}
> +
> +void test_hashmap__remove_case_sensitive(void)
> +{
> +	setup(t_remove, 0);
> +}
> +
> +void test_hashmap__remove_case_insensitive(void)
> +{
> +	setup(t_remove, 1);
> +}
> +
> +void test_hashmap__iterate_case_sensitive(void)
> +{
> +	setup(t_iterate, 0);
> +}
> +
> +void test_hashmap__iterate_case_insensitive(void)
> +{
> +	setup(t_iterate, 1);
> +}
> +
> +void test_hashmap__alloc_case_sensitive(void)
> +{
> +	setup(t_alloc, 0);
> +}
> +
> +void test_hashmap__alloc_case_insensitive(void)
>   {
> -	TEST(setup(t_replace, 0), "replace works");
> -	TEST(setup(t_replace, 1), "replace (case insensitive) works");
> -	TEST(setup(t_get, 0), "get works");
> -	TEST(setup(t_get, 1), "get (case insensitive) works");
> -	TEST(setup(t_add, 0), "add works");
> -	TEST(setup(t_add, 1), "add (case insensitive) works");
> -	TEST(setup(t_remove, 0), "remove works");
> -	TEST(setup(t_remove, 1), "remove (case insensitive) works");
> -	TEST(setup(t_iterate, 0), "iterate works");
> -	TEST(setup(t_iterate, 1), "iterate (case insensitive) works");
> -	TEST(setup(t_alloc, 0), "grow / shrink works");
> -	TEST(t_intern(), "string interning works");
> -	return test_done();
> +	setup(t_alloc, 1);
>   }

