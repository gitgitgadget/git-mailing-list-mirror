Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF50C4B1E79
	for <git@vger.kernel.org>; Sun, 18 May 2025 15:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747583911; cv=none; b=YjLw9PmpnAmUc/+xIWlhcCHhUHh86TmGHt515Tx1hdVzHAw0NY+dswRmplLZilxdjN/es3XMNzvZitNltUQIbVKr1xKN/TmjpjDPRKtkQEFwssw6GEkruGsNSBp/kzx51e5N8O1sMUEW0dOiyv8YvSpwz9tIVQgtCC8s15cjD/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747583911; c=relaxed/simple;
	bh=3j09pGCjzJaKX6Dvdqy7LhQRZPhwcTYaZoL+yscSFLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qems7QWGwquADnEQ0mm4gzebdLywBQ9CwFOsyQ5kDkd0v3t8MCB0/3szyyQyZuPZlWl1ZOnpLHpA3HGZOWMsysLub6xKw+O/E4A/EljBKbfv3bmZmzFUeydvJRZB0W0J6W/eFy1KsV+1ypCIJfeFOezoQlV3ZtF8hNMy0JQe65E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NXknsEUD; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NXknsEUD"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-30e9a44dbb9so2184423a91.1
        for <git@vger.kernel.org>; Sun, 18 May 2025 08:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747583909; x=1748188709; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X0JSP3moda1VTlRUfPiDlGTLcOBNjkNrxbPmznR/hds=;
        b=NXknsEUDzvGNpCBrzMyrqnEUCIj2FkeW7aIXMQ4GtH8WnN2vn0VNWbej1ZfSBcfaBZ
         9F6zV1BVkDEc2xA6skxSppCL12YxToYsE7a+CpKlcSGs0mu1+BVVQcJDIu92fVyTMlDI
         98qCM9AnEeSBBowkewSzoL0+GhePC4XOO4iF3h2NYo0MSCJOTuw+r610MiSKYtwipi8F
         tkDL7t94AiBowfv76X0Rg+ow/ZJZU9jTLwmCAFxgLcfseWIt4Ka8YHpecj+/H7az5lPO
         S85wDbRNPRJaI7JTaBdETdvgvPK+VXpp9015eeXxO1Td/uiMurtZes4fq2urVHaucPLP
         1T9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747583909; x=1748188709;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X0JSP3moda1VTlRUfPiDlGTLcOBNjkNrxbPmznR/hds=;
        b=S9kt4D1bNLNb76kkjbzaCs+JJM9wEfWDMU3CgsGea4v0oTuSzCidCVyW1HD981XFyD
         bDhUORLT+sRMUbJ8so2ufeewqrcrwPGBEhM3HkhJoBtjNYYZ+BQ6qn/NPqJyv9tCUnMm
         QsbgsSehuA22Ty6NK5FUfjAK+bmcwqrjR4RmTCUwXMGKYyjQxEXf2G36ktWGnWzksxWm
         qMck36QUD6KI0dis+3aP6XqJmRiDidgEpM2XunsIacG220tty8s9SPAFRUok8ySxF2qF
         mWwGWCRXXlDhw/fZMSaRJhcGMPRbmj71iXA4JytU54J7BSSOe3Hyefo9bjFxSdVcQiR5
         iyxw==
X-Gm-Message-State: AOJu0YwpzVzHDElPuLqs1sOuGwAf1aQQtEbaYn9e/hIq/un6FuTELB9d
	1ugvq4bSponpsY0gm6+uRnCzu29aLxb2nfY6fvcMB8hV9EJSiUnTxL1Azo4Yh0fDVng=
X-Gm-Gg: ASbGncuhp8/GVZjy4NNkTX90bSgsiwc5SHHoLCUZf08uZ7oG2NJMS8Zboj5GeXjdBCq
	X2jItleL+FVDxOUt83WzjnPo4Lid49QK5PL6In6NW/HsVMS9tBeaz3jXUFZIMXRGRn4rdRdDqGR
	GncZs+7+acgPvoHwx6dTfn87/gWjPTMgQ92CesmadW9RADX67GTZGQO1NLk0bk/P7JhcPzHz2Zy
	n1OfT1Y++5gR8esLulzgyRk1x6No3NX4Lyevs3PXwWTxnDhAyLEJmVaRXe7LH3XiGJVkqDPEGMk
	vmbl9eVC24C9CO4yReZ9sV3wSvVwPI0+R4tpd4ZR6EeBNLyCWVnKEiLNAA==
X-Google-Smtp-Source: AGHT+IEozLJXPqRU8UWPtdAypjdebP42gL5pFleoRrVnmjpOrDvpxTXN2pHC/a9Sv5+03GU49JFbJw==
X-Received: by 2002:a17:90b:4b0f:b0:2fe:b907:562f with SMTP id 98e67ed59e1d1-30e7d527e41mr17068740a91.14.1747583908636;
        Sun, 18 May 2025 08:58:28 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b26eaf96573sm4683579a12.43.2025.05.18.08.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 May 2025 08:58:27 -0700 (PDT)
Date: Sun, 18 May 2025 23:58:25 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 8/8] u-string-list: move "remove duplicates" test to
 "u-string-list.c"
Message-ID: <aCoDobl95P_VSaes@ArchLinux>
References: <aCoDB9P5XV1lHMil@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCoDB9P5XV1lHMil@ArchLinux>

We use "test-tool string-list remove_duplicates" to test the
"string_list_remove_duplicates" function. As we have introduced the unit
test, we'd better remove the logic from shell script to C program to
improve test speed and readability.

As all the tests in shell script are removed, let's just delete the
"t0063-string-list.sh" and update the "meson.build" file to align with
this change.

Also we could simply remove "DISABLE_SIGN_COMPARE_WARNINGS" due to we
have already deleted related code.

Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 t/helper/test-string-list.c  | 39 -----------------------
 t/meson.build                |  1 -
 t/t0063-string-list.sh       | 27 ----------------
 t/unit-tests/u-string-list.c | 62 ++++++++++++++++++++++++++++++++++++
 4 files changed, 62 insertions(+), 67 deletions(-)
 delete mode 100755 t/t0063-string-list.sh

diff --git a/t/helper/test-string-list.c b/t/helper/test-string-list.c
index 262b28c599..6be0cdb8e2 100644
--- a/t/helper/test-string-list.c
+++ b/t/helper/test-string-list.c
@@ -1,48 +1,9 @@
-#define DISABLE_SIGN_COMPARE_WARNINGS
-
 #include "test-tool.h"
 #include "strbuf.h"
 #include "string-list.h"
 
-/*
- * Parse an argument into a string list.  arg should either be a
- * ':'-separated list of strings, or "-" to indicate an empty string
- * list (as opposed to "", which indicates a string list containing a
- * single empty string).  list->strdup_strings must be set.
- */
-static void parse_string_list(struct string_list *list, const char *arg)
-{
-	if (!strcmp(arg, "-"))
-		return;
-
-	(void)string_list_split(list, arg, ':', -1);
-}
-
-static void write_list_compact(const struct string_list *list)
-{
-	int i;
-	if (!list->nr)
-		printf("-\n");
-	else {
-		printf("%s", list->items[0].string);
-		for (i = 1; i < list->nr; i++)
-			printf(":%s", list->items[i].string);
-		printf("\n");
-	}
-}
-
 int cmd__string_list(int argc, const char **argv)
 {
-	if (argc == 3 && !strcmp(argv[1], "remove_duplicates")) {
-		struct string_list list = STRING_LIST_INIT_DUP;
-
-		parse_string_list(&list, argv[2]);
-		string_list_remove_duplicates(&list, 0);
-		write_list_compact(&list);
-		string_list_clear(&list, 0);
-		return 0;
-	}
-
 	if (argc == 2 && !strcmp(argv[1], "sort")) {
 		struct string_list list = STRING_LIST_INIT_NODUP;
 		struct strbuf sb = STRBUF_INIT;
diff --git a/t/meson.build b/t/meson.build
index a3dbe572d8..c7efcc6db9 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -124,7 +124,6 @@ integration_tests = [
   't0060-path-utils.sh',
   't0061-run-command.sh',
   't0062-revision-walking.sh',
-  't0063-string-list.sh',
   't0066-dir-iterator.sh',
   't0067-parse_pathspec_file.sh',
   't0068-for-each-repo.sh',
diff --git a/t/t0063-string-list.sh b/t/t0063-string-list.sh
deleted file mode 100755
index 31fd62bba8..0000000000
--- a/t/t0063-string-list.sh
+++ /dev/null
@@ -1,27 +0,0 @@
-#!/bin/sh
-#
-# Copyright (c) 2012 Michael Haggerty
-#
-
-test_description='Test string list functionality'
-
-. ./test-lib.sh
-
-test_expect_success "test remove_duplicates" '
-	test "x-" = "x$(test-tool string-list remove_duplicates -)" &&
-	test "x" = "x$(test-tool string-list remove_duplicates "")" &&
-	test a = "$(test-tool string-list remove_duplicates a)" &&
-	test a = "$(test-tool string-list remove_duplicates a:a)" &&
-	test a = "$(test-tool string-list remove_duplicates a:a:a:a:a)" &&
-	test a:b = "$(test-tool string-list remove_duplicates a:b)" &&
-	test a:b = "$(test-tool string-list remove_duplicates a:a:b)" &&
-	test a:b = "$(test-tool string-list remove_duplicates a:b:b)" &&
-	test a:b:c = "$(test-tool string-list remove_duplicates a:b:c)" &&
-	test a:b:c = "$(test-tool string-list remove_duplicates a:a:b:c)" &&
-	test a:b:c = "$(test-tool string-list remove_duplicates a:b:b:c)" &&
-	test a:b:c = "$(test-tool string-list remove_duplicates a:b:c:c)" &&
-	test a:b:c = "$(test-tool string-list remove_duplicates a:a:b:b:c:c)" &&
-	test a:b:c = "$(test-tool string-list remove_duplicates a:a:a:b:b:b:c:c:c)"
-'
-
-test_done
diff --git a/t/unit-tests/u-string-list.c b/t/unit-tests/u-string-list.c
index be2bb5f103..a575fdda97 100644
--- a/t/unit-tests/u-string-list.c
+++ b/t/unit-tests/u-string-list.c
@@ -169,3 +169,65 @@ void test_string_list__filter(void)
 
 	t_string_list_clear(&list, 0);
 }
+
+static void t_string_list_remove_duplicates(struct string_list *list, ...)
+{
+	struct string_list expected_strings = STRING_LIST_INIT_DUP;
+	va_list ap;
+
+	va_start(ap, list);
+	t_vcreate_string_list_dup(&expected_strings, 0, ap);
+	va_end(ap);
+
+	string_list_remove_duplicates(list, 0);
+	t_string_list_equal(list, &expected_strings);
+
+	string_list_clear(&expected_strings, 0);
+}
+
+void test_string_list__remove_duplicates(void)
+{
+	struct string_list list = STRING_LIST_INIT_DUP;
+
+	t_create_string_list_dup(&list, 0, NULL);
+	t_string_list_remove_duplicates(&list, NULL);
+
+	t_create_string_list_dup(&list, 0, "", NULL);
+	t_string_list_remove_duplicates(&list, "", NULL);
+
+	t_create_string_list_dup(&list, 0, "a", NULL);
+	t_string_list_remove_duplicates(&list, "a", NULL);
+
+	t_create_string_list_dup(&list, 0, "a", "a", NULL);
+	t_string_list_remove_duplicates(&list, "a", NULL);
+
+	t_create_string_list_dup(&list, 0, "a", "a", "a", NULL);
+	t_string_list_remove_duplicates(&list, "a", NULL);
+
+	t_create_string_list_dup(&list, 0, "a", "a", "b", NULL);
+	t_string_list_remove_duplicates(&list, "a", "b", NULL);
+
+	t_create_string_list_dup(&list, 0, "a", "b", "b", NULL);
+	t_string_list_remove_duplicates(&list, "a", "b", NULL);
+
+	t_create_string_list_dup(&list, 0, "a", "b", "c", NULL);
+	t_string_list_remove_duplicates(&list, "a", "b", "c", NULL);
+
+	t_create_string_list_dup(&list, 0, "a", "a", "b", "c", NULL);
+	t_string_list_remove_duplicates(&list, "a", "b", "c", NULL);
+
+	t_create_string_list_dup(&list, 0, "a", "b", "b", "c", NULL);
+	t_string_list_remove_duplicates(&list, "a", "b", "c", NULL);
+
+	t_create_string_list_dup(&list, 0, "a", "b", "c", "c", NULL);
+	t_string_list_remove_duplicates(&list, "a", "b", "c", NULL);
+
+	t_create_string_list_dup(&list, 0, "a", "a", "b", "b", "c", "c", NULL);
+	t_string_list_remove_duplicates(&list, "a", "b", "c", NULL);
+
+	t_create_string_list_dup(&list, 0, "a", "a", "a", "b", "b", "b",
+				 "c", "c", "c", NULL);
+	t_string_list_remove_duplicates(&list, "a", "b", "c", NULL);
+
+	t_string_list_clear(&list, 0);
+}
-- 
2.49.0

