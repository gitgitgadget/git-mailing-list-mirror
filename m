Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB75621
	for <git@vger.kernel.org>; Fri, 12 Jul 2024 00:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720742458; cv=none; b=m8syLv2tSZI/sw0mRxSVHK0I7rdIxvdE4kg9QTIsOUrGA7Okc2D9K5ZtAztD4/HwS5o26uW51kVvtzdb1VUigxrV8ye1ExG61pucIbje+ddsx2Q6LcpkZhdyTw2aeQrQhuW0FUBCVHW7ZOfyR99G2efX/w+4gnMzLL4PeG+mzL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720742458; c=relaxed/simple;
	bh=mU8GbWu4bKUuQRSegSb6odryiGkQzXWq0YW8cpenayM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=uNqMib+FbTWrx/IZLiHpGGxXb0BiKl1l0hyjXnuxFiZWJHej0FTSIuMnw1qgHhOJ/l8AQvTMyj2ZaLUvr5fc9zni2o4i0dnUhHr0AkpuQ8CDqSC68drXG3Qe28sdm1dQEaLMzEYJvZ58v42ZqpR6O3xR3KfWTHcyw7yq4LrF1UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hLG06q0C; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hLG06q0C"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7515437ff16so951214a12.2
        for <git@vger.kernel.org>; Thu, 11 Jul 2024 17:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720742455; x=1721347255; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oVAgPI/mw+zkgpO9bxc6bRhUau0wB/kQfwgua9X+WHQ=;
        b=hLG06q0CEYGiKhnMDrTeLgOHVw0oGyAozNG20p/BWkN05ktL2AAK47Kv1wpbcQ25oP
         9A+strU/eoNwXukVSWvs6AF2i5PuDa0ixZzsyiIIGUVoxpJDZ41SJJbLHCP7Fo7KVMMz
         IUkHIAGRYEuyd4fdVTcO5S+WNAtSkZuvGOYA9CZCo5q9q12DQ7T6/ZZxgW87xmaGGmy0
         cKSHyHdhIPUvXzbJbM0sgvrDiMXWPm+Oqf3Crn+thh3eRInodi6G2vwBP4+6OKlJTr28
         SRPWekAk0KrQj1NdxizPl10RO0pNodI4LdqbpclTA15r8aVh2GO2sl6sQ3q5ju14TApl
         s7hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720742455; x=1721347255;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oVAgPI/mw+zkgpO9bxc6bRhUau0wB/kQfwgua9X+WHQ=;
        b=Po+LOYxdgr/rZObuVnE1hGqRGeZPrH8WHksiynY6aEPzQqMzCA0cCL3zcRWZR4GEPb
         ii1L0xA7zNTAkjO/7UotvZr9tvNr6Fr+4NZhiaACGjU59ehxiKadB5JmYv6z2VsCu/uk
         NXMSHSk2ZmNscqawyKcxvExwbwkjUCCStTyeCWdb35Zm8hPH/Wpqu5a5PJy3+1nYG1AW
         Mat1WrXL0qOfeexPzn9kB7wdshKQGY0Q+K4sWB5Z7SXmD/rseWBcpj2wqojsE98h7Q67
         Dxm2UIzxt1UxeJkvAYpYndfe87WII6iZ6d/D1KTKsSk8czgLGcGKdX370Kqmlucomxvv
         qLgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEXETfjQNKRdrpyBO4Y/BjCWWKBHigQVRJxsO7afrb8IfTQObVKyfCeaAI0+eD8LQM0zhNSaibFBiXNDtluC8hrfXy
X-Gm-Message-State: AOJu0YwipS0KHnfxMU94eWqioaGKjUecOWkFv2jPy/fs3gWOpvgwKenZ
	Kuj23QRQa8CtkmVUPgqIhV9gnLPzLrOWGb7mpJbUTxWu2TrlKHD/r2A11hka
X-Google-Smtp-Source: AGHT+IHOdmX74Nmy8ZQ2XDmzJ94S1r8YSzJJlTWo1KnwdtoQ3tu9zv30a2D2Fd+2zpdrPJGztatINA==
X-Received: by 2002:a05:6a20:7fa9:b0:1c0:f1c9:6846 with SMTP id adf61e73a8af0-1c2984c8526mr12340210637.42.1720742454525;
        Thu, 11 Jul 2024 17:00:54 -0700 (PDT)
Received: from localhost ([2402:a00:401:a99b:b1ca:de8:cd9e:bf98])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-77d682b3895sm4906477a12.87.2024.07.11.17.00.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jul 2024 17:00:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 12 Jul 2024 05:30:48 +0530
Message-Id: <D2N4AG0P10QT.2EMBZAPNDBSP0@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>, "Christian Couder"
 <christian.couder@gmail.com>, "Christian Couder" <chriscool@tuxfamily.org>,
 "Kaartic Sivaraam" <kaartic.sivaraam@gmail.com>, "Josh Steadmon"
 <steadmon@google.com>, "Phillip Wood" <phillip.wood123@gmail.com>
Subject: Re: [GSoC][PATCH v3] t: port helper/test-hashmap.c to
 unit-tests/t-hashmap.c
From: "Ghanshyam Thakkar" <shyamthakkar001@gmail.com>
To: "Ghanshyam Thakkar" <shyamthakkar001@gmail.com>, <git@vger.kernel.org>
References: <20240708161641.10335-2-shyamthakkar001@gmail.com>
 <20240711235159.5320-1-shyamthakkar001@gmail.com>
In-Reply-To: <20240711235159.5320-1-shyamthakkar001@gmail.com>

Ghanshyam Thakkar <shyamthakkar001@gmail.com> wrote:
> helper/test-hashmap.c along with t0011-hashmap.sh test the hashmap.h
> library. Migrate them to the unit testing framework for better
> debugging, runtime performance and concise code.
>
> Along with the migration, make 'add' tests from the shellscript order
> agnostic in unit tests, since they iterate over entries with the same
> keys and we do not guarantee the order.
>
> The helper/test-hashmap.c is still not removed because it contains a
> performance test meant to be run by the user directly (not used in
> t/perf). And it makes sense for such a utility to be a helper.
>
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
> Helped-by: Josh Steadmon <steadmon@google.com>
> Helped-by: Phillip Wood <phillip.wood123@gmail.com>
> Signed-off-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
> ---
Changes in v3:

- I have removed the t_put() tests as they were identical to
  t_get() minus the size checks at the end. So, I've added those size
  checks to t_get().

- Besides that I've replaced check() with check_pointer_eq() where ever
  applicable.
 =20
- And replaced the third elements of key_val[] which recorded
  the presence of certain key-val pair with 'char seen[]'.

- Added some test_msg() statements for better debugging.

- Fixed typo in commit message.

Thanks.

> Range-diff against v2:
> 1: bbb4f2f23e ! 1: 03ba77665e t: port helper/test-hashmap.c to
> unit-tests/t-hashmap.c
> @@ Commit message
>     =20
> helper/test-hashmap.c along with t0011-hashmap.sh test the hashmap.h
> library. Migrate them to the unit testing framework for better
> - debugging, runtime performance and consice code.
> + debugging, runtime performance and concise code.
>     =20
> Along with the migration, make 'add' tests from the shellscript order
> agnostic in unit tests, since they iterate over entries with the same
> @@ Commit message
>     =20
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
> + Helped-by: Josh Steadmon <steadmon@google.com>
> + Helped-by: Phillip Wood <phillip.wood123@gmail.com>
> Signed-off-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
>     =20
> ## Makefile ##
> @@ t/unit-tests/t-hashmap.c (new)
> + struct test_entry, ent);
> +}
> +
> -+static int key_val_contains(const char *key_val[][3], size_t n,
> ++static int key_val_contains(const char *key_val[][2], char seen[],
> size_t n,
> + struct test_entry *entry)
> +{
> + for (size_t i =3D 0; i < n; i++) {
> + if (!strcmp(entry->key, key_val[i][0]) &&
> + !strcmp(get_value(entry), key_val[i][1])) {
> -+ if (!strcmp(key_val[i][2], "USED"))
> ++ if (seen[i])
> + return 2;
> -+ key_val[i][2] =3D "USED";
> ++ seen[i] =3D 1;
> + return 0;
> + }
> + }
> @@ t/unit-tests/t-hashmap.c (new)
> + hashmap_clear_and_free(&map, struct test_entry, ent);
> +}
> +
> -+static void t_put(struct hashmap *map, int ignore_case)
> -+{
> -+ struct test_entry *entry;
> -+ const char *key_val[][2] =3D { { "key1", "value1" },
> -+ { "key2", "value2" },
> -+ { "fooBarFrotz", "value3" } };
> -+
> -+ for (size_t i =3D 0; i < ARRAY_SIZE(key_val); i++) {
> -+ entry =3D alloc_test_entry(ignore_case, key_val[i][0], key_val[i][1]);
> -+ check(hashmap_put_entry(map, entry, ent) =3D=3D NULL);
> -+ }
> -+
> -+ entry =3D alloc_test_entry(ignore_case, "foobarfrotz", "value4");
> -+ entry =3D hashmap_put_entry(map, entry, ent);
> -+ check(ignore_case ? entry !=3D NULL : entry =3D=3D NULL);
> -+ free(entry);
> -+
> -+ check_int(map->tablesize, =3D=3D, 64);
> -+ check_int(hashmap_get_size(map), =3D=3D,
> -+ ignore_case ? ARRAY_SIZE(key_val) : ARRAY_SIZE(key_val) + 1);
> -+}
> -+
> +static void t_replace(struct hashmap *map, int ignore_case)
> +{
> + struct test_entry *entry;
> +
> + entry =3D alloc_test_entry(ignore_case, "key1", "value1");
> -+ check(hashmap_put_entry(map, entry, ent) =3D=3D NULL);
> ++ check_pointer_eq(hashmap_put_entry(map, entry, ent), NULL);
> +
> + entry =3D alloc_test_entry(ignore_case, ignore_case ? "Key1" : "key1",
> + "value2");
> @@ t/unit-tests/t-hashmap.c (new)
> + free(entry);
> +
> + entry =3D alloc_test_entry(ignore_case, "fooBarFrotz", "value3");
> -+ check(hashmap_put_entry(map, entry, ent) =3D=3D NULL);
> ++ check_pointer_eq(hashmap_put_entry(map, entry, ent), NULL);
> +
> + entry =3D alloc_test_entry(ignore_case,
> + ignore_case ? "foobarfrotz" : "fooBarFrotz",
> @@ t/unit-tests/t-hashmap.c (new)
> +
> + for (size_t i =3D 0; i < ARRAY_SIZE(key_val); i++) {
> + entry =3D alloc_test_entry(ignore_case, key_val[i][0], key_val[i][1]);
> -+ check(hashmap_put_entry(map, entry, ent) =3D=3D NULL);
> ++ check_pointer_eq(hashmap_put_entry(map, entry, ent), NULL);
> + }
> +
> + for (size_t i =3D 0; i < ARRAY_SIZE(query); i++) {
> + entry =3D get_test_entry(map, ignore_case, query[i][0]);
> + if (check(entry !=3D NULL))
> + check_str(get_value(entry), query[i][1]);
> ++ else
> ++ test_msg("query key: %s", query[i][0]);
> + }
> +
> -+ check(get_test_entry(map, ignore_case, "notInMap") =3D=3D NULL);
> ++ check_pointer_eq(get_test_entry(map, ignore_case, "notInMap"), NULL);
> ++ check_int(map->tablesize, =3D=3D, 64);
> ++ check_int(hashmap_get_size(map), =3D=3D, ARRAY_SIZE(key_val));
> +}
> +
> +static void t_add(struct hashmap *map, int ignore_case)
> +{
> + struct test_entry *entry;
> -+ const char *key_val[][3] =3D {
> -+ { "key1", "value1", "UNUSED" },
> -+ { ignore_case ? "Key1" : "key1", "value2", "UNUSED" },
> -+ { "fooBarFrotz", "value3", "UNUSED" },
> -+ { ignore_case ? "Foobarfrotz" : "fooBarFrotz", "value4", "UNUSED" }
> ++ const char *key_val[][2] =3D {
> ++ { "key1", "value1" },
> ++ { ignore_case ? "Key1" : "key1", "value2" },
> ++ { "fooBarFrotz", "value3" },
> ++ { ignore_case ? "Foobarfrotz" : "fooBarFrotz", "value4" }
> + };
> + const char *queries[] =3D { "key1",
> + ignore_case ? "Foobarfrotz" : "fooBarFrotz" };
> ++ char seen[ARRAY_SIZE(key_val)] =3D { 0 };
> +
> + for (size_t i =3D 0; i < ARRAY_SIZE(key_val); i++) {
> + entry =3D alloc_test_entry(ignore_case, key_val[i][0], key_val[i][1]);
> @@ t/unit-tests/t-hashmap.c (new)
> + {
> + int ret;
> + if (!check_int((ret =3D key_val_contains(
> -+ key_val, ARRAY_SIZE(key_val),
> -+ entry)), =3D=3D, 0)) {
> ++ key_val, seen,
> ++ ARRAY_SIZE(key_val), entry)),
> ++ =3D=3D, 0)) {
> + switch (ret) {
> + case 1:
> + test_msg("found entry was not given in the input\n"
> @@ t/unit-tests/t-hashmap.c (new)
> + }
> + check_int(count, =3D=3D, 2);
> + }
> ++
> ++ for (size_t i =3D 0; i < ARRAY_SIZE(seen); i++) {
> ++ if (!check_int(seen[i], =3D=3D, 1))
> ++ test_msg("following key-val pair was not iterated over:\n"
> ++ " key: %s\n value: %s",
> ++ key_val[i][0], key_val[i][1]);
> ++ }
> ++
> + check_int(hashmap_get_size(map), =3D=3D, ARRAY_SIZE(key_val));
> -+ check(get_test_entry(map, ignore_case, "notInMap") =3D=3D NULL);
> ++ check_pointer_eq(get_test_entry(map, ignore_case, "notInMap"), NULL);
> +}
> +
> +static void t_remove(struct hashmap *map, int ignore_case)
> @@ t/unit-tests/t-hashmap.c (new)
> +
> + for (size_t i =3D 0; i < ARRAY_SIZE(key_val); i++) {
> + entry =3D alloc_test_entry(ignore_case, key_val[i][0], key_val[i][1]);
> -+ check(hashmap_put_entry(map, entry, ent) =3D=3D NULL);
> ++ check_pointer_eq(hashmap_put_entry(map, entry, ent), NULL);
> + }
> +
> + for (size_t i =3D 0; i < ARRAY_SIZE(remove); i++) {
> @@ t/unit-tests/t-hashmap.c (new)
> + }
> +
> + entry =3D alloc_test_entry(ignore_case, "notInMap", "");
> -+ check(hashmap_remove_entry(map, entry, ent, "notInMap") =3D=3D NULL);
> ++ check_pointer_eq(hashmap_remove_entry(map, entry, ent, "notInMap"),
> NULL);
> + free(entry);
> ++
> ++ check_int(map->tablesize, =3D=3D, 64);
> ++ check_int(hashmap_get_size(map), =3D=3D, ARRAY_SIZE(key_val) -
> ARRAY_SIZE(remove));
> +}
> +
> +static void t_iterate(struct hashmap *map, int ignore_case)
> +{
> + struct test_entry *entry;
> + struct hashmap_iter iter;
> -+ const char *key_val[][3] =3D { { "key1", "value1", "UNUSED" },
> -+ { "key2", "value2", "UNUSED" },
> -+ { "fooBarFrotz", "value3", "UNUSED" } };
> -+ int count =3D 0;
> ++ const char *key_val[][2] =3D { { "key1", "value1" },
> ++ { "key2", "value2" },
> ++ { "fooBarFrotz", "value3" } };
> ++ char seen[ARRAY_SIZE(key_val)] =3D { 0 };
> +
> + for (size_t i =3D 0; i < ARRAY_SIZE(key_val); i++) {
> + entry =3D alloc_test_entry(ignore_case, key_val[i][0], key_val[i][1]);
> -+ check(hashmap_put_entry(map, entry, ent) =3D=3D NULL);
> ++ check_pointer_eq(hashmap_put_entry(map, entry, ent), NULL);
> + }
> +
> + hashmap_for_each_entry(map, &iter, entry, ent /* member name */)
> + {
> + int ret;
> -+ if (!check_int((ret =3D key_val_contains(key_val, ARRAY_SIZE(key_val),
> ++ if (!check_int((ret =3D key_val_contains(key_val, seen,
> ++ ARRAY_SIZE(key_val),
> + entry)), =3D=3D, 0)) {
> + switch (ret) {
> + case 1:
> @@ t/unit-tests/t-hashmap.c (new)
> + entry->key, get_value(entry));
> + break;
> + }
> -+ } else {
> -+ count++;
> + }
> + }
> -+ check_int(count, =3D=3D, ARRAY_SIZE(key_val));
> ++
> ++ for (size_t i =3D 0; i < ARRAY_SIZE(seen); i++) {
> ++ if (!check_int(seen[i], =3D=3D, 1))
> ++ test_msg("following key-val pair was not iterated over:\n"
> ++ " key: %s\n value: %s",
> ++ key_val[i][0], key_val[i][1]);
> ++ }
> ++
> + check_int(hashmap_get_size(map), =3D=3D, ARRAY_SIZE(key_val));
> +}
> +
> @@ t/unit-tests/t-hashmap.c (new)
> + char *key =3D xstrfmt("key%d", i);
> + char *value =3D xstrfmt("value%d", i);
> + entry =3D alloc_test_entry(ignore_case, key, value);
> -+ check(hashmap_put_entry(map, entry, ent) =3D=3D NULL);
> ++ check_pointer_eq(hashmap_put_entry(map, entry, ent), NULL);
> + free(key);
> + free(value);
> + }
> @@ t/unit-tests/t-hashmap.c (new)
> + check_int(hashmap_get_size(map), =3D=3D, 51);
> +
> + entry =3D alloc_test_entry(ignore_case, "key52", "value52");
> -+ check(hashmap_put_entry(map, entry, ent) =3D=3D NULL);
> ++ check_pointer_eq(hashmap_put_entry(map, entry, ent), NULL);
> + check_int(map->tablesize, =3D=3D, 256);
> + check_int(hashmap_get_size(map), =3D=3D, 52);
> +
> @@ t/unit-tests/t-hashmap.c (new)
> + else if (!check(i1 !=3D values[i]))
> + test_msg("strintern(%s) returns input pointer\n",
> + values[i]);
> -+ else if (!check(i1 =3D=3D i2))
> ++ else if (!check_pointer_eq(i1, i2))
> + test_msg("address('%s') !=3D address('%s'), so strintern('%s') !=3D
> strintern('%s')",
> + i1, i2, values[i], values[i]);
> + else
> @@ t/unit-tests/t-hashmap.c (new)
> +
> +int cmd_main(int argc UNUSED, const char **argv UNUSED)
> +{
> -+ TEST(setup(t_put, 0), "put works");
> -+ TEST(setup(t_put, 1), "put (case insensitive) works");
> + TEST(setup(t_replace, 0), "replace works");
> + TEST(setup(t_replace, 1), "replace (case insensitive) works");
> + TEST(setup(t_get, 0), "get works");
>
> Makefile | 1 +
> t/helper/test-hashmap.c | 100 +----------
> t/t0011-hashmap.sh | 260 ----------------------------
> t/unit-tests/t-hashmap.c | 358 +++++++++++++++++++++++++++++++++++++++
> 4 files changed, 361 insertions(+), 358 deletions(-)
> delete mode 100755 t/t0011-hashmap.sh
> create mode 100644 t/unit-tests/t-hashmap.c
>
> diff --git a/Makefile b/Makefile
> index 3eab701b10..74bb026610 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1336,6 +1336,7 @@ THIRD_PARTY_SOURCES +=3D sha1dc/%
> UNIT_TEST_PROGRAMS +=3D t-ctype
> UNIT_TEST_PROGRAMS +=3D t-example-decorate
> UNIT_TEST_PROGRAMS +=3D t-hash
> +UNIT_TEST_PROGRAMS +=3D t-hashmap
> UNIT_TEST_PROGRAMS +=3D t-mem-pool
> UNIT_TEST_PROGRAMS +=3D t-oidtree
> UNIT_TEST_PROGRAMS +=3D t-prio-queue
> diff --git a/t/helper/test-hashmap.c b/t/helper/test-hashmap.c
> index 2912899558..7b854a7030 100644
> --- a/t/helper/test-hashmap.c
> +++ b/t/helper/test-hashmap.c
> @@ -12,11 +12,6 @@ struct test_entry
> char key[FLEX_ARRAY];
> };
> =20
> -static const char *get_value(const struct test_entry *e)
> -{
> - return e->key + strlen(e->key) + 1;
> -}
> -
> static int test_entry_cmp(const void *cmp_data,
> const struct hashmap_entry *eptr,
> const struct hashmap_entry *entry_or_key,
> @@ -141,30 +136,16 @@ static void perf_hashmap(unsigned int method,
> unsigned int rounds)
> /*
> * Read stdin line by line and print result of commands to stdout:
> *
> - * hash key -> strhash(key) memhash(key) strihash(key) memihash(key)
> - * put key value -> NULL / old value
> - * get key -> NULL / value
> - * remove key -> NULL / old value
> - * iterate -> key1 value1\nkey2 value2\n...
> - * size -> tablesize numentries
> - *
> * perfhashmap method rounds -> test hashmap.[ch] performance
> */
> int cmd__hashmap(int argc, const char **argv)
> {
> struct string_list parts =3D STRING_LIST_INIT_NODUP;
> struct strbuf line =3D STRBUF_INIT;
> - int icase;
> - struct hashmap map =3D HASHMAP_INIT(test_entry_cmp, &icase);
> -
> - /* init hash map */
> - icase =3D argc > 1 && !strcmp("ignorecase", argv[1]);
> =20
> /* process commands from stdin */
> while (strbuf_getline(&line, stdin) !=3D EOF) {
> char *cmd, *p1, *p2;
> - unsigned int hash =3D 0;
> - struct test_entry *entry;
> =20
> /* break line into command and up to two parameters */
> string_list_setlen(&parts, 0);
> @@ -180,84 +161,8 @@ int cmd__hashmap(int argc, const char **argv)
> cmd =3D parts.items[0].string;
> p1 =3D parts.nr >=3D 1 ? parts.items[1].string : NULL;
> p2 =3D parts.nr >=3D 2 ? parts.items[2].string : NULL;
> - if (p1)
> - hash =3D icase ? strihash(p1) : strhash(p1);
> -
> - if (!strcmp("add", cmd) && p1 && p2) {
> -
> - /* create entry with key =3D p1, value =3D p2 */
> - entry =3D alloc_test_entry(hash, p1, p2);
> -
> - /* add to hashmap */
> - hashmap_add(&map, &entry->ent);
> -
> - } else if (!strcmp("put", cmd) && p1 && p2) {
> -
> - /* create entry with key =3D p1, value =3D p2 */
> - entry =3D alloc_test_entry(hash, p1, p2);
> -
> - /* add / replace entry */
> - entry =3D hashmap_put_entry(&map, entry, ent);
> -
> - /* print and free replaced entry, if any */
> - puts(entry ? get_value(entry) : "NULL");
> - free(entry);
> -
> - } else if (!strcmp("get", cmd) && p1) {
> - /* lookup entry in hashmap */
> - entry =3D hashmap_get_entry_from_hash(&map, hash, p1,
> - struct test_entry, ent);
> -
> - /* print result */
> - if (!entry)
> - puts("NULL");
> - hashmap_for_each_entry_from(&map, entry, ent)
> - puts(get_value(entry));
> -
> - } else if (!strcmp("remove", cmd) && p1) {
> -
> - /* setup static key */
> - struct hashmap_entry key;
> - struct hashmap_entry *rm;
> - hashmap_entry_init(&key, hash);
> -
> - /* remove entry from hashmap */
> - rm =3D hashmap_remove(&map, &key, p1);
> - entry =3D rm ? container_of(rm, struct test_entry, ent)
> - : NULL;
> -
> - /* print result and free entry*/
> - puts(entry ? get_value(entry) : "NULL");
> - free(entry);
> -
> - } else if (!strcmp("iterate", cmd)) {
> - struct hashmap_iter iter;
> -
> - hashmap_for_each_entry(&map, &iter, entry,
> - ent /* member name */)
> - printf("%s %s\n", entry->key, get_value(entry));
> -
> - } else if (!strcmp("size", cmd)) {
> -
> - /* print table sizes */
> - printf("%u %u\n", map.tablesize,
> - hashmap_get_size(&map));
> -
> - } else if (!strcmp("intern", cmd) && p1) {
> -
> - /* test that strintern works */
> - const char *i1 =3D strintern(p1);
> - const char *i2 =3D strintern(p1);
> - if (strcmp(i1, p1))
> - printf("strintern(%s) returns %s\n", p1, i1);
> - else if (i1 =3D=3D p1)
> - printf("strintern(%s) returns input pointer\n", p1);
> - else if (i1 !=3D i2)
> - printf("strintern(%s) !=3D strintern(%s)", i1, i2);
> - else
> - printf("%s\n", i1);
> -
> - } else if (!strcmp("perfhashmap", cmd) && p1 && p2) {
> +
> + if (!strcmp("perfhashmap", cmd) && p1 && p2) {
> =20
> perf_hashmap(atoi(p1), atoi(p2));
> =20
> @@ -270,6 +175,5 @@ int cmd__hashmap(int argc, const char **argv)
> =20
> string_list_clear(&parts, 0);
> strbuf_release(&line);
> - hashmap_clear_and_free(&map, struct test_entry, ent);
> return 0;
> }
> diff --git a/t/t0011-hashmap.sh b/t/t0011-hashmap.sh
> deleted file mode 100755
> index 46e74ad107..0000000000
> --- a/t/t0011-hashmap.sh
> +++ /dev/null
> @@ -1,260 +0,0 @@
> -#!/bin/sh
> -
> -test_description=3D'test hashmap and string hash functions'
> -
> -TEST_PASSES_SANITIZE_LEAK=3Dtrue
> -. ./test-lib.sh
> -
> -test_hashmap() {
> - echo "$1" | test-tool hashmap $3 > actual &&
> - echo "$2" > expect &&
> - test_cmp expect actual
> -}
> -
> -test_expect_success 'put' '
> -
> -test_hashmap "put key1 value1
> -put key2 value2
> -put fooBarFrotz value3
> -put foobarfrotz value4
> -size" "NULL
> -NULL
> -NULL
> -NULL
> -64 4"
> -
> -'
> -
> -test_expect_success 'put (case insensitive)' '
> -
> -test_hashmap "put key1 value1
> -put key2 value2
> -put fooBarFrotz value3
> -size" "NULL
> -NULL
> -NULL
> -64 3" ignorecase
> -
> -'
> -
> -test_expect_success 'replace' '
> -
> -test_hashmap "put key1 value1
> -put key1 value2
> -put fooBarFrotz value3
> -put fooBarFrotz value4
> -size" "NULL
> -value1
> -NULL
> -value3
> -64 2"
> -
> -'
> -
> -test_expect_success 'replace (case insensitive)' '
> -
> -test_hashmap "put key1 value1
> -put Key1 value2
> -put fooBarFrotz value3
> -put foobarfrotz value4
> -size" "NULL
> -value1
> -NULL
> -value3
> -64 2" ignorecase
> -
> -'
> -
> -test_expect_success 'get' '
> -
> -test_hashmap "put key1 value1
> -put key2 value2
> -put fooBarFrotz value3
> -put foobarfrotz value4
> -get key1
> -get key2
> -get fooBarFrotz
> -get notInMap" "NULL
> -NULL
> -NULL
> -NULL
> -value1
> -value2
> -value3
> -NULL"
> -
> -'
> -
> -test_expect_success 'get (case insensitive)' '
> -
> -test_hashmap "put key1 value1
> -put key2 value2
> -put fooBarFrotz value3
> -get Key1
> -get keY2
> -get foobarfrotz
> -get notInMap" "NULL
> -NULL
> -NULL
> -value1
> -value2
> -value3
> -NULL" ignorecase
> -
> -'
> -
> -test_expect_success 'add' '
> -
> -test_hashmap "add key1 value1
> -add key1 value2
> -add fooBarFrotz value3
> -add fooBarFrotz value4
> -get key1
> -get fooBarFrotz
> -get notInMap" "value2
> -value1
> -value4
> -value3
> -NULL"
> -
> -'
> -
> -test_expect_success 'add (case insensitive)' '
> -
> -test_hashmap "add key1 value1
> -add Key1 value2
> -add fooBarFrotz value3
> -add foobarfrotz value4
> -get key1
> -get Foobarfrotz
> -get notInMap" "value2
> -value1
> -value4
> -value3
> -NULL" ignorecase
> -
> -'
> -
> -test_expect_success 'remove' '
> -
> -test_hashmap "put key1 value1
> -put key2 value2
> -put fooBarFrotz value3
> -remove key1
> -remove key2
> -remove notInMap
> -size" "NULL
> -NULL
> -NULL
> -value1
> -value2
> -NULL
> -64 1"
> -
> -'
> -
> -test_expect_success 'remove (case insensitive)' '
> -
> -test_hashmap "put key1 value1
> -put key2 value2
> -put fooBarFrotz value3
> -remove Key1
> -remove keY2
> -remove notInMap
> -size" "NULL
> -NULL
> -NULL
> -value1
> -value2
> -NULL
> -64 1" ignorecase
> -
> -'
> -
> -test_expect_success 'iterate' '
> - test-tool hashmap >actual.raw <<-\EOF &&
> - put key1 value1
> - put key2 value2
> - put fooBarFrotz value3
> - iterate
> - EOF
> -
> - cat >expect <<-\EOF &&
> - NULL
> - NULL
> - NULL
> - fooBarFrotz value3
> - key1 value1
> - key2 value2
> - EOF
> -
> - sort <actual.raw >actual &&
> - test_cmp expect actual
> -'
> -
> -test_expect_success 'iterate (case insensitive)' '
> - test-tool hashmap ignorecase >actual.raw <<-\EOF &&
> - put key1 value1
> - put key2 value2
> - put fooBarFrotz value3
> - iterate
> - EOF
> -
> - cat >expect <<-\EOF &&
> - NULL
> - NULL
> - NULL
> - fooBarFrotz value3
> - key1 value1
> - key2 value2
> - EOF
> -
> - sort <actual.raw >actual &&
> - test_cmp expect actual
> -'
> -
> -test_expect_success 'grow / shrink' '
> -
> - rm -f in &&
> - rm -f expect &&
> - for n in $(test_seq 51)
> - do
> - echo put key$n value$n >> in &&
> - echo NULL >> expect || return 1
> - done &&
> - echo size >> in &&
> - echo 64 51 >> expect &&
> - echo put key52 value52 >> in &&
> - echo NULL >> expect &&
> - echo size >> in &&
> - echo 256 52 >> expect &&
> - for n in $(test_seq 12)
> - do
> - echo remove key$n >> in &&
> - echo value$n >> expect || return 1
> - done &&
> - echo size >> in &&
> - echo 256 40 >> expect &&
> - echo remove key40 >> in &&
> - echo value40 >> expect &&
> - echo size >> in &&
> - echo 64 39 >> expect &&
> - test-tool hashmap <in >out &&
> - test_cmp expect out
> -
> -'
> -
> -test_expect_success 'string interning' '
> -
> -test_hashmap "intern value1
> -intern Value1
> -intern value2
> -intern value2
> -" "value1
> -Value1
> -value2
> -value2"
> -
> -'
> -
> -test_done
> diff --git a/t/unit-tests/t-hashmap.c b/t/unit-tests/t-hashmap.c
> new file mode 100644
> index 0000000000..3112b10b33
> --- /dev/null
> +++ b/t/unit-tests/t-hashmap.c
> @@ -0,0 +1,358 @@
> +#include "test-lib.h"
> +#include "hashmap.h"
> +#include "strbuf.h"
> +
> +struct test_entry {
> + int padding; /* hashmap entry no longer needs to be the first member
> */
> + struct hashmap_entry ent;
> + /* key and value as two \0-terminated strings */
> + char key[FLEX_ARRAY];
> +};
> +
> +static int test_entry_cmp(const void *cmp_data,
> + const struct hashmap_entry *eptr,
> + const struct hashmap_entry *entry_or_key,
> + const void *keydata)
> +{
> + const int ignore_case =3D cmp_data ? *((int *)cmp_data) : 0;
> + const struct test_entry *e1, *e2;
> + const char *key =3D keydata;
> +
> + e1 =3D container_of(eptr, const struct test_entry, ent);
> + e2 =3D container_of(entry_or_key, const struct test_entry, ent);
> +
> + if (ignore_case)
> + return strcasecmp(e1->key, key ? key : e2->key);
> + else
> + return strcmp(e1->key, key ? key : e2->key);
> +}
> +
> +static const char *get_value(const struct test_entry *e)
> +{
> + return e->key + strlen(e->key) + 1;
> +}
> +
> +static struct test_entry *alloc_test_entry(unsigned int ignore_case,
> + const char *key, const char *value)
> +{
> + size_t klen =3D strlen(key);
> + size_t vlen =3D strlen(value);
> + unsigned int hash =3D ignore_case ? strihash(key) : strhash(key);
> + struct test_entry *entry =3D xmalloc(st_add4(sizeof(*entry), klen, vlen=
,
> 2));
> +
> + hashmap_entry_init(&entry->ent, hash);
> + memcpy(entry->key, key, klen + 1);
> + memcpy(entry->key + klen + 1, value, vlen + 1);
> + return entry;
> +}
> +
> +static struct test_entry *get_test_entry(struct hashmap *map,
> + unsigned int ignore_case, const char *key)
> +{
> + return hashmap_get_entry_from_hash(
> + map, ignore_case ? strihash(key) : strhash(key), key,
> + struct test_entry, ent);
> +}
> +
> +static int key_val_contains(const char *key_val[][2], char seen[],
> size_t n,
> + struct test_entry *entry)
> +{
> + for (size_t i =3D 0; i < n; i++) {
> + if (!strcmp(entry->key, key_val[i][0]) &&
> + !strcmp(get_value(entry), key_val[i][1])) {
> + if (seen[i])
> + return 2;
> + seen[i] =3D 1;
> + return 0;
> + }
> + }
> + return 1;
> +}
> +
> +static void setup(void (*f)(struct hashmap *map, int ignore_case),
> + int ignore_case)
> +{
> + struct hashmap map =3D HASHMAP_INIT(test_entry_cmp, &ignore_case);
> +
> + f(&map, ignore_case);
> + hashmap_clear_and_free(&map, struct test_entry, ent);
> +}
> +
> +static void t_replace(struct hashmap *map, int ignore_case)
> +{
> + struct test_entry *entry;
> +
> + entry =3D alloc_test_entry(ignore_case, "key1", "value1");
> + check_pointer_eq(hashmap_put_entry(map, entry, ent), NULL);
> +
> + entry =3D alloc_test_entry(ignore_case, ignore_case ? "Key1" : "key1",
> + "value2");
> + entry =3D hashmap_put_entry(map, entry, ent);
> + if (check(entry !=3D NULL))
> + check_str(get_value(entry), "value1");
> + free(entry);
> +
> + entry =3D alloc_test_entry(ignore_case, "fooBarFrotz", "value3");
> + check_pointer_eq(hashmap_put_entry(map, entry, ent), NULL);
> +
> + entry =3D alloc_test_entry(ignore_case,
> + ignore_case ? "foobarfrotz" : "fooBarFrotz",
> + "value4");
> + entry =3D hashmap_put_entry(map, entry, ent);
> + if (check(entry !=3D NULL))
> + check_str(get_value(entry), "value3");
> + free(entry);
> +}
> +
> +static void t_get(struct hashmap *map, int ignore_case)
> +{
> + struct test_entry *entry;
> + const char *key_val[][2] =3D { { "key1", "value1" },
> + { "key2", "value2" },
> + { "fooBarFrotz", "value3" },
> + { ignore_case ? "key4" : "foobarfrotz", "value4" } };
> + const char *query[][2] =3D {
> + { ignore_case ? "Key1" : "key1", "value1" },
> + { ignore_case ? "keY2" : "key2", "value2" },
> + { ignore_case ? "foobarfrotz" : "fooBarFrotz", "value3" }
> + };
> +
> + for (size_t i =3D 0; i < ARRAY_SIZE(key_val); i++) {
> + entry =3D alloc_test_entry(ignore_case, key_val[i][0], key_val[i][1]);
> + check_pointer_eq(hashmap_put_entry(map, entry, ent), NULL);
> + }
> +
> + for (size_t i =3D 0; i < ARRAY_SIZE(query); i++) {
> + entry =3D get_test_entry(map, ignore_case, query[i][0]);
> + if (check(entry !=3D NULL))
> + check_str(get_value(entry), query[i][1]);
> + else
> + test_msg("query key: %s", query[i][0]);
> + }
> +
> + check_pointer_eq(get_test_entry(map, ignore_case, "notInMap"), NULL);
> + check_int(map->tablesize, =3D=3D, 64);
> + check_int(hashmap_get_size(map), =3D=3D, ARRAY_SIZE(key_val));
> +}
> +
> +static void t_add(struct hashmap *map, int ignore_case)
> +{
> + struct test_entry *entry;
> + const char *key_val[][2] =3D {
> + { "key1", "value1" },
> + { ignore_case ? "Key1" : "key1", "value2" },
> + { "fooBarFrotz", "value3" },
> + { ignore_case ? "Foobarfrotz" : "fooBarFrotz", "value4" }
> + };
> + const char *queries[] =3D { "key1",
> + ignore_case ? "Foobarfrotz" : "fooBarFrotz" };
> + char seen[ARRAY_SIZE(key_val)] =3D { 0 };
> +
> + for (size_t i =3D 0; i < ARRAY_SIZE(key_val); i++) {
> + entry =3D alloc_test_entry(ignore_case, key_val[i][0], key_val[i][1]);
> + hashmap_add(map, &entry->ent);
> + }
> +
> + for (size_t i =3D 0; i < ARRAY_SIZE(queries); i++) {
> + int count =3D 0;
> + entry =3D hashmap_get_entry_from_hash(map,
> + ignore_case ? strihash(queries[i]) :
> + strhash(queries[i]),
> + queries[i], struct test_entry, ent);
> +
> + hashmap_for_each_entry_from(map, entry, ent)
> + {
> + int ret;
> + if (!check_int((ret =3D key_val_contains(
> + key_val, seen,
> + ARRAY_SIZE(key_val), entry)),
> + =3D=3D, 0)) {
> + switch (ret) {
> + case 1:
> + test_msg("found entry was not given in the input\n"
> + " key: %s\n value: %s",
> + entry->key, get_value(entry));
> + break;
> + case 2:
> + test_msg("duplicate entry detected\n"
> + " key: %s\n value: %s",
> + entry->key, get_value(entry));
> + break;
> + }
> + } else {
> + count++;
> + }
> + }
> + check_int(count, =3D=3D, 2);
> + }
> +
> + for (size_t i =3D 0; i < ARRAY_SIZE(seen); i++) {
> + if (!check_int(seen[i], =3D=3D, 1))
> + test_msg("following key-val pair was not iterated over:\n"
> + " key: %s\n value: %s",
> + key_val[i][0], key_val[i][1]);
> + }
> +
> + check_int(hashmap_get_size(map), =3D=3D, ARRAY_SIZE(key_val));
> + check_pointer_eq(get_test_entry(map, ignore_case, "notInMap"), NULL);
> +}
> +
> +static void t_remove(struct hashmap *map, int ignore_case)
> +{
> + struct test_entry *entry, *removed;
> + const char *key_val[][2] =3D { { "key1", "value1" },
> + { "key2", "value2" },
> + { "fooBarFrotz", "value3" } };
> + const char *remove[][2] =3D { { ignore_case ? "Key1" : "key1", "value1"
> },
> + { ignore_case ? "keY2" : "key2", "value2" } };
> +
> + for (size_t i =3D 0; i < ARRAY_SIZE(key_val); i++) {
> + entry =3D alloc_test_entry(ignore_case, key_val[i][0], key_val[i][1]);
> + check_pointer_eq(hashmap_put_entry(map, entry, ent), NULL);
> + }
> +
> + for (size_t i =3D 0; i < ARRAY_SIZE(remove); i++) {
> + entry =3D alloc_test_entry(ignore_case, remove[i][0], "");
> + removed =3D hashmap_remove_entry(map, entry, ent, remove[i][0]);
> + if (check(removed !=3D NULL))
> + check_str(get_value(removed), remove[i][1]);
> + free(entry);
> + free(removed);
> + }
> +
> + entry =3D alloc_test_entry(ignore_case, "notInMap", "");
> + check_pointer_eq(hashmap_remove_entry(map, entry, ent, "notInMap"),
> NULL);
> + free(entry);
> +
> + check_int(map->tablesize, =3D=3D, 64);
> + check_int(hashmap_get_size(map), =3D=3D, ARRAY_SIZE(key_val) -
> ARRAY_SIZE(remove));
> +}
> +
> +static void t_iterate(struct hashmap *map, int ignore_case)
> +{
> + struct test_entry *entry;
> + struct hashmap_iter iter;
> + const char *key_val[][2] =3D { { "key1", "value1" },
> + { "key2", "value2" },
> + { "fooBarFrotz", "value3" } };
> + char seen[ARRAY_SIZE(key_val)] =3D { 0 };
> +
> + for (size_t i =3D 0; i < ARRAY_SIZE(key_val); i++) {
> + entry =3D alloc_test_entry(ignore_case, key_val[i][0], key_val[i][1]);
> + check_pointer_eq(hashmap_put_entry(map, entry, ent), NULL);
> + }
> +
> + hashmap_for_each_entry(map, &iter, entry, ent /* member name */)
> + {
> + int ret;
> + if (!check_int((ret =3D key_val_contains(key_val, seen,
> + ARRAY_SIZE(key_val),
> + entry)), =3D=3D, 0)) {
> + switch (ret) {
> + case 1:
> + test_msg("found entry was not given in the input\n"
> + " key: %s\n value: %s",
> + entry->key, get_value(entry));
> + break;
> + case 2:
> + test_msg("duplicate entry detected\n"
> + " key: %s\n value: %s",
> + entry->key, get_value(entry));
> + break;
> + }
> + }
> + }
> +
> + for (size_t i =3D 0; i < ARRAY_SIZE(seen); i++) {
> + if (!check_int(seen[i], =3D=3D, 1))
> + test_msg("following key-val pair was not iterated over:\n"
> + " key: %s\n value: %s",
> + key_val[i][0], key_val[i][1]);
> + }
> +
> + check_int(hashmap_get_size(map), =3D=3D, ARRAY_SIZE(key_val));
> +}
> +
> +static void t_alloc(struct hashmap *map, int ignore_case)
> +{
> + struct test_entry *entry, *removed;
> +
> + for (int i =3D 1; i <=3D 51; i++) {
> + char *key =3D xstrfmt("key%d", i);
> + char *value =3D xstrfmt("value%d", i);
> + entry =3D alloc_test_entry(ignore_case, key, value);
> + check_pointer_eq(hashmap_put_entry(map, entry, ent), NULL);
> + free(key);
> + free(value);
> + }
> + check_int(map->tablesize, =3D=3D, 64);
> + check_int(hashmap_get_size(map), =3D=3D, 51);
> +
> + entry =3D alloc_test_entry(ignore_case, "key52", "value52");
> + check_pointer_eq(hashmap_put_entry(map, entry, ent), NULL);
> + check_int(map->tablesize, =3D=3D, 256);
> + check_int(hashmap_get_size(map), =3D=3D, 52);
> +
> + for (int i =3D 1; i <=3D 12; i++) {
> + char *key =3D xstrfmt("key%d", i);
> + char *value =3D xstrfmt("value%d", i);
> +
> + entry =3D alloc_test_entry(ignore_case, key, "");
> + removed =3D hashmap_remove_entry(map, entry, ent, key);
> + if (check(removed !=3D NULL))
> + check_str(value, get_value(removed));
> + free(key);
> + free(value);
> + free(entry);
> + free(removed);
> + }
> + check_int(map->tablesize, =3D=3D, 256);
> + check_int(hashmap_get_size(map), =3D=3D, 40);
> +
> + entry =3D alloc_test_entry(ignore_case, "key40", "");
> + removed =3D hashmap_remove_entry(map, entry, ent, "key40");
> + if (check(removed !=3D NULL))
> + check_str("value40", get_value(removed));
> + check_int(map->tablesize, =3D=3D, 64);
> + check_int(hashmap_get_size(map), =3D=3D, 39);
> + free(entry);
> + free(removed);
> +}
> +
> +static void t_intern(struct hashmap *map, int ignore_case)
> +{
> + const char *values[] =3D { "value1", "Value1", "value2", "value2" };
> +
> + for (size_t i =3D 0; i < ARRAY_SIZE(values); i++) {
> + const char *i1 =3D strintern(values[i]);
> + const char *i2 =3D strintern(values[i]);
> +
> + if (!check(!strcmp(i1, values[i])))
> + test_msg("strintern(%s) returns %s\n", values[i], i1);
> + else if (!check(i1 !=3D values[i]))
> + test_msg("strintern(%s) returns input pointer\n",
> + values[i]);
> + else if (!check_pointer_eq(i1, i2))
> + test_msg("address('%s') !=3D address('%s'), so strintern('%s') !=3D
> strintern('%s')",
> + i1, i2, values[i], values[i]);
> + else
> + check_str(i1, values[i]);
> + }
> +}
> +
> +int cmd_main(int argc UNUSED, const char **argv UNUSED)
> +{
> + TEST(setup(t_replace, 0), "replace works");
> + TEST(setup(t_replace, 1), "replace (case insensitive) works");
> + TEST(setup(t_get, 0), "get works");
> + TEST(setup(t_get, 1), "get (case insensitive) works");
> + TEST(setup(t_add, 0), "add works");
> + TEST(setup(t_add, 1), "add (case insensitive) works");
> + TEST(setup(t_remove, 0), "remove works");
> + TEST(setup(t_remove, 1), "remove (case insensitive) works");
> + TEST(setup(t_iterate, 0), "iterate works");
> + TEST(setup(t_iterate, 1), "iterate (case insensitive) works");
> + TEST(setup(t_alloc, 0), "grow / shrink works");
> + TEST(setup(t_intern, 0), "string interning works");
> + return test_done();
> +}
> --
> 2.45.2

