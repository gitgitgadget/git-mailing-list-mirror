Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2A64DA14
	for <git@vger.kernel.org>; Wed,  3 Jul 2024 07:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719990264; cv=none; b=Pd4I9IsdlvbOm/mKgJDA9A1pEWlOo+hOSIHWuTnrzInOYjEXIlMW1GWkuZ0h5tSyVzHyp2XnprfXPi2HCnhnjf3IPZLYyIe9utB03xRbxbP6VaTSc+ndKxI71Am5j+qbThISsq16MpaLEewHUqtfQOVAKrbZl0bTZUuWeVVDA5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719990264; c=relaxed/simple;
	bh=VU0q4qSsV3g8AvSOWz6aILAdWYNWxytaig/r/B3T9zc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=jBYSIw9I8e9Gptd6DzsgPnJhK4faK5Y0cmSIaPX12MGZRfsBHEzl3P8aK+sYbtK/XmFmwoLrXnxXFmNO6VDnUCWd4sr/X4miqJpYRUj+y9g5NQUI5AQlIkVu9QJxY5xCMb8dAAvWEjnLKZN4rvlEr9uXY0aKe40QImaE6y5WOSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IBrTn+Ul; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IBrTn+Ul"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7201cb6cae1so2804772a12.2
        for <git@vger.kernel.org>; Wed, 03 Jul 2024 00:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719990262; x=1720595062; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xzAJihTgf3vTltOm/23cushFYZWqkET5cku+vkRgm0E=;
        b=IBrTn+UlCU5lBe0PpQ29DG+2r2uBswhYF/V9L0Y8FEKBkTbetc7vkIwdzK4yiZQj/u
         iwn4ZLrwnovFfGDXrIiwlheKpkp+3w2hpHS/dKpv7SGz2RgybE5llUBWk6zTnccSM43n
         sAMUIXmN7xa5pcciXk1+njbfchCoQ+9l6tnbGPkqPjXd9y5nslW7FD+tAXu5GIwywMrW
         fI7NxPKlSXgYwrvvFlElWa1od/CjrIuNqk1GQvYX2rImmtofOXgErFYlOhsSmeP32kOU
         kHK4w8gMEKlv9mjqzGJOIhvTktdMGBphPqLwDGpe6zsOZYXMS4anWJVI2CpgJqootEqj
         9jxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719990262; x=1720595062;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xzAJihTgf3vTltOm/23cushFYZWqkET5cku+vkRgm0E=;
        b=NBy8Oy3hpj4oVcLU9ycAVkTFLAWRBNrNMI/GNvZi/ZaYCw9aqualByxuwE5LlHHyav
         asE9jV14q2rCiWQl3bNu77ckMowRCscbHwsUcI13Kso3U5KaPLruQe4xlMLaEdHe4duQ
         xsqslToxAhjkpmFswMbtlVPPbXxsoRSuSOk3LcyEF3BjnO1lNAOtkptter4bkktOwTfE
         vum9xP4PXQx7MAJkzufr1vBdJcDvslbqXCmwdJISbP0MR+rQ7e7xMP10YyC5qbCUcPxp
         oAGJRsausvrxijRxR+AmHEEQUzQnKVS5JYwe9f8lrrysEq+C7AvpKNQvvbj7xYYPuKH1
         Iz6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVIAL3GpAPWzVh3R/72CGq/cnO/3ZXOR87sJrFVLJErFyVKDAdIeEQrgZE+rq+AXUus3Y1RLv/N/dfynTo//DYoeGmP
X-Gm-Message-State: AOJu0YzqYTJpmW03fVDhpsJFbr+1hsaeDK2CnkHw39XE7FmCEd2XGn5f
	K5lHtqRdRxIIHYw//cIGQm9etsOAg00ZCQrO4bYOzpnFW+IYhqkA
X-Google-Smtp-Source: AGHT+IFdtxHBtl+3vx+RcA7S4siVIkX/PFInEqMAax+VmMlf/pYR+yhInespg1V54IAZIQGgTlxVzA==
X-Received: by 2002:a05:6a20:da8d:b0:1bf:295:8482 with SMTP id adf61e73a8af0-1bf029588a5mr8836004637.60.1719990261966;
        Wed, 03 Jul 2024 00:04:21 -0700 (PDT)
Received: from localhost ([2402:a00:401:a99b:b1ca:de8:cd9e:bf98])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac155c32esm96169725ad.185.2024.07.03.00.04.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jul 2024 00:04:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 03 Jul 2024 12:34:15 +0530
Message-Id: <D2FPNR4PMYNG.AGGPEUYK2ETE@gmail.com>
Subject: Re: [GSoC][PATCH v3] t: migrate helper/test-oidmap.c to
 unit-tests/t-oidmap.c
From: "Ghanshyam Thakkar" <shyamthakkar001@gmail.com>
To: "Ghanshyam Thakkar" <shyamthakkar001@gmail.com>, <git@vger.kernel.org>
Cc: "Christian Couder" <christian.couder@gmail.com>, "Junio C Hamano"
 <gitster@pobox.com>, "Phillip Wood" <phillip.wood123@gmail.com>, "Josh
 Steadmon" <steadmon@google.com>, "Christian Couder"
 <chriscool@tuxfamily.org>, "Kaartic Sivaraam" <kaartic.sivaraam@gmail.com>
References: <20240703062958.23262-2-shyamthakkar001@gmail.com>
In-Reply-To: <20240703062958.23262-2-shyamthakkar001@gmail.com>

Ghanshyam Thakkar <shyamthakkar001@gmail.com> wrote:
> helper/test-oidmap.c along with t0016-oidmap.sh test the oidmap.h
> library which is built on top of hashmap.h.
>
> Migrate them to the unit testing framework for better performance,
> concise code and better debugging. Along with the migration also plug
> memory leaks and make the test logic independent for all the tests.
> The migration removes 'put' tests from t0016, because it is used as
> setup to all the other tests, so testing it separately does not yield
> any benefit.
>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Helped-by: Phillip Wood <phillip.wood123@gmail.com>
> Reviewed-by: Josh Steadmon <steadmon@google.com>
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
> Signed-off-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
> ---

Forgot to put in the message-id for reply. Apologies for the noise.

link to v1: https://lore.kernel.org/git/20240619175036.64291-1-shyamthakkar=
001@gmail.com/
link to v2: https://lore.kernel.org/git/20240628122030.41554-1-shyamthakkar=
001@gmail.com/

Thanks.

> Changes in v3:
> - use 'count' to check if we iterated over all the entries (Phillip's
> suggestion)
> - use 'seen' array instead of modifying the global array (Junio's
> review)
>
> Range-diff against v2:
> 1: cc0c4c3b0a ! 1: bdb3c8ebe4 t: migrate helper/test-oidmap.c to
> unit-tests/t-oidmap.c
> @@ Commit message
> setup to all the other tests, so testing it separately does not yield
> any benefit.
>     =20
> + Helped-by: Junio C Hamano <gitster@pobox.com>
> Helped-by: Phillip Wood <phillip.wood123@gmail.com>
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
> @@ t/unit-tests/t-oidmap.c (new)
> + char name[FLEX_ARRAY];
> +};
> +
> -+static const char *key_val[][2] =3D { { "11", "one" },
> -+ { "22", "two" },
> -+ { "33", "three" } };
> ++static const char *const key_val[][2] =3D { { "11", "one" },
> ++ { "22", "two" },
> ++ { "33", "three" } };
> +
> +static void setup(void (*f)(struct oidmap *map))
> +{
> @@ t/unit-tests/t-oidmap.c (new)
> + check(oidmap_remove(map, &oid) =3D=3D NULL);
> +}
> +
> -+static int key_val_contains(struct test_entry *entry)
> ++static int key_val_contains(struct test_entry *entry, char seen[])
> +{
> + for (size_t i =3D 0; i < ARRAY_SIZE(key_val); i++) {
> + struct object_id oid;
> @@ t/unit-tests/t-oidmap.c (new)
> + return -1;
> +
> + if (oideq(&entry->entry.oid, &oid)) {
> -+ if (!strcmp(key_val[i][1], "USED"))
> ++ if (seen[i])
> + return 2;
> -+ key_val[i][1] =3D "USED";
> ++ seen[i] =3D 1;
> + return 0;
> + }
> + }
> @@ t/unit-tests/t-oidmap.c (new)
> +{
> + struct oidmap_iter iter;
> + struct test_entry *entry;
> ++ char seen[ARRAY_SIZE(key_val)] =3D { 0 };
> ++ int count =3D 0;
> +
> + oidmap_iter_init(map, &iter);
> + while ((entry =3D oidmap_iter_next(&iter))) {
> + int ret;
> -+ if (!check_int((ret =3D key_val_contains(entry)), =3D=3D, 0)) {
> ++ if (!check_int((ret =3D key_val_contains(entry, seen)), =3D=3D, 0)) {
> + switch (ret) {
> + case -1:
> + break; /* error message handled by get_oid_arbitrary_hex() */
> @@ t/unit-tests/t-oidmap.c (new)
> + ret);
> + break;
> + }
> ++ } else {
> ++ count++;
> + }
> + }
> ++ check_int(count, =3D=3D, ARRAY_SIZE(key_val));
> + check_int(hashmap_get_size(&map->map), =3D=3D, ARRAY_SIZE(key_val));
> +}
> +
>
> Makefile | 2 +-
> t/helper/test-oidmap.c | 123 ---------------------------
> t/helper/test-tool.c | 1 -
> t/helper/test-tool.h | 1 -
> t/t0016-oidmap.sh | 112 -------------------------
> t/unit-tests/t-oidmap.c | 181 ++++++++++++++++++++++++++++++++++++++++
> 6 files changed, 182 insertions(+), 238 deletions(-)
> delete mode 100644 t/helper/test-oidmap.c
> delete mode 100755 t/t0016-oidmap.sh
> create mode 100644 t/unit-tests/t-oidmap.c
>
> diff --git a/Makefile b/Makefile
> index 3eab701b10..2a5c70d218 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -809,7 +809,6 @@ TEST_BUILTINS_OBJS +=3D test-match-trees.o
> TEST_BUILTINS_OBJS +=3D test-mergesort.o
> TEST_BUILTINS_OBJS +=3D test-mktemp.o
> TEST_BUILTINS_OBJS +=3D test-oid-array.o
> -TEST_BUILTINS_OBJS +=3D test-oidmap.o
> TEST_BUILTINS_OBJS +=3D test-online-cpus.o
> TEST_BUILTINS_OBJS +=3D test-pack-mtimes.o
> TEST_BUILTINS_OBJS +=3D test-parse-options.o
> @@ -1337,6 +1336,7 @@ UNIT_TEST_PROGRAMS +=3D t-ctype
> UNIT_TEST_PROGRAMS +=3D t-example-decorate
> UNIT_TEST_PROGRAMS +=3D t-hash
> UNIT_TEST_PROGRAMS +=3D t-mem-pool
> +UNIT_TEST_PROGRAMS +=3D t-oidmap
> UNIT_TEST_PROGRAMS +=3D t-oidtree
> UNIT_TEST_PROGRAMS +=3D t-prio-queue
> UNIT_TEST_PROGRAMS +=3D t-reftable-basics
> diff --git a/t/helper/test-oidmap.c b/t/helper/test-oidmap.c
> deleted file mode 100644
> index bd30244a54..0000000000
> --- a/t/helper/test-oidmap.c
> +++ /dev/null
> @@ -1,123 +0,0 @@
> -#include "test-tool.h"
> -#include "hex.h"
> -#include "object-name.h"
> -#include "oidmap.h"
> -#include "repository.h"
> -#include "setup.h"
> -#include "strbuf.h"
> -#include "string-list.h"
> -
> -/* key is an oid and value is a name (could be a refname for example)
> */
> -struct test_entry {
> - struct oidmap_entry entry;
> - char name[FLEX_ARRAY];
> -};
> -
> -#define DELIM " \t\r\n"
> -
> -/*
> - * Read stdin line by line and print result of commands to stdout:
> - *
> - * hash oidkey -> sha1hash(oidkey)
> - * put oidkey namevalue -> NULL / old namevalue
> - * get oidkey -> NULL / namevalue
> - * remove oidkey -> NULL / old namevalue
> - * iterate -> oidkey1 namevalue1\noidkey2 namevalue2\n...
> - *
> - */
> -int cmd__oidmap(int argc UNUSED, const char **argv UNUSED)
> -{
> - struct string_list parts =3D STRING_LIST_INIT_NODUP;
> - struct strbuf line =3D STRBUF_INIT;
> - struct oidmap map =3D OIDMAP_INIT;
> -
> - setup_git_directory();
> -
> - /* init oidmap */
> - oidmap_init(&map, 0);
> -
> - /* process commands from stdin */
> - while (strbuf_getline(&line, stdin) !=3D EOF) {
> - char *cmd, *p1, *p2;
> - struct test_entry *entry;
> - struct object_id oid;
> -
> - /* break line into command and up to two parameters */
> - string_list_setlen(&parts, 0);
> - string_list_split_in_place(&parts, line.buf, DELIM, 2);
> - string_list_remove_empty_items(&parts, 0);
> -
> - /* ignore empty lines */
> - if (!parts.nr)
> - continue;
> - if (!*parts.items[0].string || *parts.items[0].string =3D=3D '#')
> - continue;
> -
> - cmd =3D parts.items[0].string;
> - p1 =3D parts.nr >=3D 1 ? parts.items[1].string : NULL;
> - p2 =3D parts.nr >=3D 2 ? parts.items[2].string : NULL;
> -
> - if (!strcmp("put", cmd) && p1 && p2) {
> -
> - if (repo_get_oid(the_repository, p1, &oid)) {
> - printf("Unknown oid: %s\n", p1);
> - continue;
> - }
> -
> - /* create entry with oid_key =3D p1, name_value =3D p2 */
> - FLEX_ALLOC_STR(entry, name, p2);
> - oidcpy(&entry->entry.oid, &oid);
> -
> - /* add / replace entry */
> - entry =3D oidmap_put(&map, entry);
> -
> - /* print and free replaced entry, if any */
> - puts(entry ? entry->name : "NULL");
> - free(entry);
> -
> - } else if (!strcmp("get", cmd) && p1) {
> -
> - if (repo_get_oid(the_repository, p1, &oid)) {
> - printf("Unknown oid: %s\n", p1);
> - continue;
> - }
> -
> - /* lookup entry in oidmap */
> - entry =3D oidmap_get(&map, &oid);
> -
> - /* print result */
> - puts(entry ? entry->name : "NULL");
> -
> - } else if (!strcmp("remove", cmd) && p1) {
> -
> - if (repo_get_oid(the_repository, p1, &oid)) {
> - printf("Unknown oid: %s\n", p1);
> - continue;
> - }
> -
> - /* remove entry from oidmap */
> - entry =3D oidmap_remove(&map, &oid);
> -
> - /* print result and free entry*/
> - puts(entry ? entry->name : "NULL");
> - free(entry);
> -
> - } else if (!strcmp("iterate", cmd)) {
> -
> - struct oidmap_iter iter;
> - oidmap_iter_init(&map, &iter);
> - while ((entry =3D oidmap_iter_next(&iter)))
> - printf("%s %s\n", oid_to_hex(&entry->entry.oid), entry->name);
> -
> - } else {
> -
> - printf("Unknown command %s\n", cmd);
> -
> - }
> - }
> -
> - string_list_clear(&parts, 0);
> - strbuf_release(&line);
> - oidmap_free(&map, 1);
> - return 0;
> -}
> diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
> index 93436a82ae..da3e69128a 100644
> --- a/t/helper/test-tool.c
> +++ b/t/helper/test-tool.c
> @@ -44,7 +44,6 @@ static struct test_cmd cmds[] =3D {
> { "mergesort", cmd__mergesort },
> { "mktemp", cmd__mktemp },
> { "oid-array", cmd__oid_array },
> - { "oidmap", cmd__oidmap },
> { "online-cpus", cmd__online_cpus },
> { "pack-mtimes", cmd__pack_mtimes },
> { "parse-options", cmd__parse_options },
> diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
> index d9033d14e1..642a34578c 100644
> --- a/t/helper/test-tool.h
> +++ b/t/helper/test-tool.h
> @@ -37,7 +37,6 @@ int cmd__lazy_init_name_hash(int argc, const char
> **argv);
> int cmd__match_trees(int argc, const char **argv);
> int cmd__mergesort(int argc, const char **argv);
> int cmd__mktemp(int argc, const char **argv);
> -int cmd__oidmap(int argc, const char **argv);
> int cmd__online_cpus(int argc, const char **argv);
> int cmd__pack_mtimes(int argc, const char **argv);
> int cmd__parse_options(int argc, const char **argv);
> diff --git a/t/t0016-oidmap.sh b/t/t0016-oidmap.sh
> deleted file mode 100755
> index 0faef1f4f1..0000000000
> --- a/t/t0016-oidmap.sh
> +++ /dev/null
> @@ -1,112 +0,0 @@
> -#!/bin/sh
> -
> -test_description=3D'test oidmap'
> -
> -TEST_PASSES_SANITIZE_LEAK=3Dtrue
> -. ./test-lib.sh
> -
> -# This purposefully is very similar to t0011-hashmap.sh
> -
> -test_oidmap () {
> - echo "$1" | test-tool oidmap $3 >actual &&
> - echo "$2" >expect &&
> - test_cmp expect actual
> -}
> -
> -
> -test_expect_success 'setup' '
> -
> - test_commit one &&
> - test_commit two &&
> - test_commit three &&
> - test_commit four
> -
> -'
> -
> -test_expect_success 'put' '
> -
> -test_oidmap "put one 1
> -put two 2
> -put invalidOid 4
> -put three 3" "NULL
> -NULL
> -Unknown oid: invalidOid
> -NULL"
> -
> -'
> -
> -test_expect_success 'replace' '
> -
> -test_oidmap "put one 1
> -put two 2
> -put three 3
> -put invalidOid 4
> -put two deux
> -put one un" "NULL
> -NULL
> -NULL
> -Unknown oid: invalidOid
> -2
> -1"
> -
> -'
> -
> -test_expect_success 'get' '
> -
> -test_oidmap "put one 1
> -put two 2
> -put three 3
> -get two
> -get four
> -get invalidOid
> -get one" "NULL
> -NULL
> -NULL
> -2
> -NULL
> -Unknown oid: invalidOid
> -1"
> -
> -'
> -
> -test_expect_success 'remove' '
> -
> -test_oidmap "put one 1
> -put two 2
> -put three 3
> -remove one
> -remove two
> -remove invalidOid
> -remove four" "NULL
> -NULL
> -NULL
> -1
> -2
> -Unknown oid: invalidOid
> -NULL"
> -
> -'
> -
> -test_expect_success 'iterate' '
> - test-tool oidmap >actual.raw <<-\EOF &&
> - put one 1
> - put two 2
> - put three 3
> - iterate
> - EOF
> -
> - # sort "expect" too so we do not rely on the order of particular oids
> - sort >expect <<-EOF &&
> - NULL
> - NULL
> - NULL
> - $(git rev-parse one) 1
> - $(git rev-parse two) 2
> - $(git rev-parse three) 3
> - EOF
> -
> - sort <actual.raw >actual &&
> - test_cmp expect actual
> -'
> -
> -test_done
> diff --git a/t/unit-tests/t-oidmap.c b/t/unit-tests/t-oidmap.c
> new file mode 100644
> index 0000000000..b22e52d08b
> --- /dev/null
> +++ b/t/unit-tests/t-oidmap.c
> @@ -0,0 +1,181 @@
> +#include "test-lib.h"
> +#include "lib-oid.h"
> +#include "oidmap.h"
> +#include "hash.h"
> +#include "hex.h"
> +
> +/*
> + * Elements we will put in oidmap structs are made of a key: the
> entry.oid
> + * field, which is of type struct object_id, and a value: the name
> field (could
> + * be a refname for example).
> + */
> +struct test_entry {
> + struct oidmap_entry entry;
> + char name[FLEX_ARRAY];
> +};
> +
> +static const char *const key_val[][2] =3D { { "11", "one" },
> + { "22", "two" },
> + { "33", "three" } };
> +
> +static void setup(void (*f)(struct oidmap *map))
> +{
> + struct oidmap map =3D OIDMAP_INIT;
> + int ret =3D 0;
> +
> + for (size_t i =3D 0; i < ARRAY_SIZE(key_val); i++){
> + struct test_entry *entry;
> +
> + FLEX_ALLOC_STR(entry, name, key_val[i][1]);
> + if ((ret =3D get_oid_arbitrary_hex(key_val[i][0], &entry->entry.oid))) =
{
> + free(entry);
> + break;
> + }
> + entry =3D oidmap_put(&map, entry);
> + if (!check(entry =3D=3D NULL))
> + free(entry);
> + }
> +
> + if (!ret)
> + f(&map);
> + oidmap_free(&map, 1);
> +}
> +
> +static void t_replace(struct oidmap *map)
> +{
> + struct test_entry *entry, *prev;
> +
> + FLEX_ALLOC_STR(entry, name, "un");
> + if (get_oid_arbitrary_hex("11", &entry->entry.oid))
> + return;
> + prev =3D oidmap_put(map, entry);
> + if (!check(prev !=3D NULL))
> + return;
> + check_str(prev->name, "one");
> + free(prev);
> +
> + FLEX_ALLOC_STR(entry, name, "deux");
> + if (get_oid_arbitrary_hex("22", &entry->entry.oid))
> + return;
> + prev =3D oidmap_put(map, entry);
> + if (!check(prev !=3D NULL))
> + return;
> + check_str(prev->name, "two");
> + free(prev);
> +}
> +
> +static void t_get(struct oidmap *map)
> +{
> + struct test_entry *entry;
> + struct object_id oid;
> +
> + if (get_oid_arbitrary_hex("22", &oid))
> + return;
> + entry =3D oidmap_get(map, &oid);
> + if (!check(entry !=3D NULL))
> + return;
> + check_str(entry->name, "two");
> +
> + if (get_oid_arbitrary_hex("44", &oid))
> + return;
> + check(oidmap_get(map, &oid) =3D=3D NULL);
> +
> + if (get_oid_arbitrary_hex("11", &oid))
> + return;
> + entry =3D oidmap_get(map, &oid);
> + if (!check(entry !=3D NULL))
> + return;
> + check_str(entry->name, "one");
> +}
> +
> +static void t_remove(struct oidmap *map)
> +{
> + struct test_entry *entry;
> + struct object_id oid;
> +
> + if (get_oid_arbitrary_hex("11", &oid))
> + return;
> + entry =3D oidmap_remove(map, &oid);
> + if (!check(entry !=3D NULL))
> + return;
> + check_str(entry->name, "one");
> + check(oidmap_get(map, &oid) =3D=3D NULL);
> + free(entry);
> +
> + if (get_oid_arbitrary_hex("22", &oid))
> + return;
> + entry =3D oidmap_remove(map, &oid);
> + if (!check(entry !=3D NULL))
> + return;
> + check_str(entry->name, "two");
> + check(oidmap_get(map, &oid) =3D=3D NULL);
> + free(entry);
> +
> + if (get_oid_arbitrary_hex("44", &oid))
> + return;
> + check(oidmap_remove(map, &oid) =3D=3D NULL);
> +}
> +
> +static int key_val_contains(struct test_entry *entry, char seen[])
> +{
> + for (size_t i =3D 0; i < ARRAY_SIZE(key_val); i++) {
> + struct object_id oid;
> +
> + if (get_oid_arbitrary_hex(key_val[i][0], &oid))
> + return -1;
> +
> + if (oideq(&entry->entry.oid, &oid)) {
> + if (seen[i])
> + return 2;
> + seen[i] =3D 1;
> + return 0;
> + }
> + }
> + return 1;
> +}
> +
> +static void t_iterate(struct oidmap *map)
> +{
> + struct oidmap_iter iter;
> + struct test_entry *entry;
> + char seen[ARRAY_SIZE(key_val)] =3D { 0 };
> + int count =3D 0;
> +
> + oidmap_iter_init(map, &iter);
> + while ((entry =3D oidmap_iter_next(&iter))) {
> + int ret;
> + if (!check_int((ret =3D key_val_contains(entry, seen)), =3D=3D, 0)) {
> + switch (ret) {
> + case -1:
> + break; /* error message handled by get_oid_arbitrary_hex() */
> + case 1:
> + test_msg("obtained entry was not given in the input\n"
> + " name: %s\n oid: %s\n",
> + entry->name, oid_to_hex(&entry->entry.oid));
> + break;
> + case 2:
> + test_msg("duplicate entry detected\n"
> + " name: %s\n oid: %s\n",
> + entry->name, oid_to_hex(&entry->entry.oid));
> + break;
> + default:
> + test_msg("BUG: invalid return value (%d) from key_val_contains()",
> + ret);
> + break;
> + }
> + } else {
> + count++;
> + }
> + }
> + check_int(count, =3D=3D, ARRAY_SIZE(key_val));
> + check_int(hashmap_get_size(&map->map), =3D=3D, ARRAY_SIZE(key_val));
> +}
> +
> +int cmd_main(int argc UNUSED, const char **argv UNUSED)
> +{
> + TEST(setup(t_replace), "replace works");
> + TEST(setup(t_get), "get works");
> + TEST(setup(t_remove), "remove works");
> + TEST(setup(t_iterate), "iterate works");
> + return test_done();
> +}
> --
> 2.45.2

