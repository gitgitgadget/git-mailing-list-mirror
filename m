Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CD34B1E79
	for <git@vger.kernel.org>; Sun, 18 May 2025 15:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747583859; cv=none; b=DuTbnh3sgKMF/C3Hg2K29IzLPcFsKGtWCWGsIdCRL2mzP/KEQGMPTOB3rdSLuprJShNNvJ2d8VEw5TDUxtnpbwyiS5Efs4zjZiWz9GXltM8C5mq5fG1G+4L4SLmbAZ41heZ1TYdXW6B5QITnhkCMVkTsxixWgIS0aw3k9crdbQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747583859; c=relaxed/simple;
	bh=6eXfGP1vb+fbfmSVZpvK5TtcYFdLF7YoFFLCnig41BM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T7tS1aV/MaA+3iK/gJjfOahp8AL2SlB0K3b9Sn4wRrnLBMRkBqWScC7OY4G7xjamBXbeHUws1YEDPgV8kmbvxu7CKK/wB95wjGzD0dGdRHAaCiyvWiyJGuVQFLD3t/FsJw7xszCtSfuDXkk6n1bQVreCiDwarEGO4GdEMYOEUdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PIR1PG1c; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PIR1PG1c"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-af523f4511fso2816281a12.0
        for <git@vger.kernel.org>; Sun, 18 May 2025 08:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747583857; x=1748188657; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7Lb/bqIkPDzLhUhac+/o5cUDb0D2Y2N80LeniP2AFYo=;
        b=PIR1PG1clSGCe5PAhDXp6FZmTyJHT4IWltQHgNC1TYp+txkjPK8myA3bwBZkHaVXvb
         c0sgLwz1hIldcR2vnjLav5An8HWuS3E+Imdobjth3f7NF3d+l4RjirZ/BPEyyZqA3QRt
         Xrr1K7pIbtgIdIj8mhUVnhdhOhIFbFtMttGbUzrrGndiiVtAq7C6WXGIGRwktd2dtVXD
         I9OnCJxIkdaIatotJpazZG4UPGZgc7hCTgqYhq1+0qitAjLN5HdfhCRbgQdEsCBadu2C
         xnF909f1B+dZfEaB+Eqo4SQc1szawxXqr1qZw68SfnSHm+AJHZSUlbJo/+Du2W12bjCF
         jgEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747583857; x=1748188657;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Lb/bqIkPDzLhUhac+/o5cUDb0D2Y2N80LeniP2AFYo=;
        b=cHQCa+ZMSoX+vADJMf3dTZaDpMmDrV4ENx0jqAmN9OYI+ifO4h6kKQlub72mJpBxxU
         fUhm3VFezlhHxU23nXuZk0Rn1qO0BzcSQNe6hTlB7rb18SpErvBmeFrJWhE4Pg/2rbQg
         wEGCTxmbkNWGPxh7dfrWSSP7a67yAmSMXRU2E8DmjfPhe4z5qyzrXHacCiD2Fp0OWA4o
         nbuFbV8D98RVzHhBQcR2mLbiqsqLLL92haGjvsuGnwOEQjM8wG5jqq9G2pe+R9FvVStm
         MOs/686YcD6qHesXuExkp6cVYxHUXqxr1opF5ztsqkvclJChRFh5XgAW95uyIWVXL77E
         LP6A==
X-Gm-Message-State: AOJu0Yy/kdGg66xK7aV9FI658HVsscYo4eNtJLxfGj7O6PbaWGdU6LzD
	sJXdfIOTr76MUTnUUfKdx33vsdNntv0RHLEKbrE4hQCjqfi0IrDXlk4gk4KErLcLe5Q=
X-Gm-Gg: ASbGncsyjbjIqaxoPBarc3IAYDom+6B5GToMG2vcDXzEekpyP2yKggCXDDz76CnSPzx
	0ascQUlBtYeRbe0LcQDfYJIu/GmdhXA9va09zVpjuFLS97b2w5BP7V+gnL2c18DNiq+4iwggObk
	R+sAtOlBhs/YUbOpmi+PqJQcTfCXMsv5K7zvFyUVPu+TnxLlwqHtNHLh1Mm40uvS3+/eJNqC9O0
	3Gu3k1c1R5n06Cb3aCvcaU1vKSOOHmtV0jdJjHhKGYHSJf4d1RCotTSaHHbTdqLBEDLB8qJ3fGX
	JS5yqDJ0XElu2om+rX3z5W3b9ShWrW/opW/gsqmGcfXSNiFXC71ecr2Kog==
X-Google-Smtp-Source: AGHT+IH+3rxQOE6wf9msRgVS4EJAL7QrSbBQ5kHAuiz//0ZR7589nhW3pSJMO0e6uzXwcNJ3Ml/fyw==
X-Received: by 2002:a17:903:f8d:b0:224:f12:3734 with SMTP id d9443c01a7336-231d43d36ffmr124733705ad.30.1747583856881;
        Sun, 18 May 2025 08:57:36 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-231d4e978adsm44707715ad.119.2025.05.18.08.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 May 2025 08:57:36 -0700 (PDT)
Date: Sun, 18 May 2025 23:57:33 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 5/8] u-string-list: move "test_split" into
 "u-string-list.c"
Message-ID: <aCoDbRCQSjAXV7H1@ArchLinux>
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

We rely on "test-tool string-list" command to test the functionality of
the "string-list". However, as we have introduced clar test framework,
we'd better move the shell script into C program to improve speed and
readability.

Create a new file "u-string-list.c" under "t/unit-tests", then update
the Makefile and "meson.build" to build the file. And let's first move
"test_split" into unit test and gradually convert the shell script into
C program.

In order to create `string_list` easily by simply specifying strings in
the function call, create "t_vcreate_string_list_dup" function to do
this.

Then port the shell script tests to C program and remove unused
"test-tool" code and tests.

Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 Makefile                     |  1 +
 t/helper/test-string-list.c  | 14 --------
 t/meson.build                |  1 +
 t/t0063-string-list.sh       | 53 -----------------------------
 t/unit-tests/u-string-list.c | 66 ++++++++++++++++++++++++++++++++++++
 5 files changed, 68 insertions(+), 67 deletions(-)
 create mode 100644 t/unit-tests/u-string-list.c

diff --git a/Makefile b/Makefile
index de73c6ddcd..cdffa13aba 100644
--- a/Makefile
+++ b/Makefile
@@ -1366,6 +1366,7 @@ CLAR_TEST_SUITES += u-prio-queue
 CLAR_TEST_SUITES += u-reftable-tree
 CLAR_TEST_SUITES += u-strbuf
 CLAR_TEST_SUITES += u-strcmp-offset
+CLAR_TEST_SUITES += u-string-list
 CLAR_TEST_SUITES += u-strvec
 CLAR_TEST_SUITES += u-trailer
 CLAR_TEST_SUITES += u-urlmatch-normalization
diff --git a/t/helper/test-string-list.c b/t/helper/test-string-list.c
index 6f10c5a435..17c18c30f6 100644
--- a/t/helper/test-string-list.c
+++ b/t/helper/test-string-list.c
@@ -46,20 +46,6 @@ static int prefix_cb(struct string_list_item *item, void *cb_data)
 
 int cmd__string_list(int argc, const char **argv)
 {
-	if (argc == 5 && !strcmp(argv[1], "split")) {
-		struct string_list list = STRING_LIST_INIT_DUP;
-		int i;
-		const char *s = argv[2];
-		int delim = *argv[3];
-		int maxsplit = atoi(argv[4]);
-
-		i = string_list_split(&list, s, delim, maxsplit);
-		printf("%d\n", i);
-		write_list(&list);
-		string_list_clear(&list, 0);
-		return 0;
-	}
-
 	if (argc == 5 && !strcmp(argv[1], "split_in_place")) {
 		struct string_list list = STRING_LIST_INIT_NODUP;
 		int i;
diff --git a/t/meson.build b/t/meson.build
index fcfc1c2c2b..a3dbe572d8 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -11,6 +11,7 @@ clar_test_suites = [
   'unit-tests/u-reftable-tree.c',
   'unit-tests/u-strbuf.c',
   'unit-tests/u-strcmp-offset.c',
+  'unit-tests/u-string-list.c',
   'unit-tests/u-strvec.c',
   'unit-tests/u-trailer.c',
   'unit-tests/u-urlmatch-normalization.c',
diff --git a/t/t0063-string-list.sh b/t/t0063-string-list.sh
index aac63ba506..6b20ffd206 100755
--- a/t/t0063-string-list.sh
+++ b/t/t0063-string-list.sh
@@ -7,16 +7,6 @@ test_description='Test string list functionality'
 
 . ./test-lib.sh
 
-test_split () {
-	cat >expected &&
-	test_expect_success "split $1 at $2, max $3" "
-		test-tool string-list split '$1' '$2' '$3' >actual &&
-		test_cmp expected actual &&
-		test-tool string-list split_in_place '$1' '$2' '$3' >actual &&
-		test_cmp expected actual
-	"
-}
-
 test_split_in_place() {
 	cat >expected &&
 	test_expect_success "split (in place) $1 at $2, max $3" "
@@ -25,49 +15,6 @@ test_split_in_place() {
 	"
 }
 
-test_split "foo:bar:baz" ":" "-1" <<EOF
-3
-[0]: "foo"
-[1]: "bar"
-[2]: "baz"
-EOF
-
-test_split "foo:bar:baz" ":" "0" <<EOF
-1
-[0]: "foo:bar:baz"
-EOF
-
-test_split "foo:bar:baz" ":" "1" <<EOF
-2
-[0]: "foo"
-[1]: "bar:baz"
-EOF
-
-test_split "foo:bar:baz" ":" "2" <<EOF
-3
-[0]: "foo"
-[1]: "bar"
-[2]: "baz"
-EOF
-
-test_split "foo:bar:" ":" "-1" <<EOF
-3
-[0]: "foo"
-[1]: "bar"
-[2]: ""
-EOF
-
-test_split "" ":" "-1" <<EOF
-1
-[0]: ""
-EOF
-
-test_split ":" ":" "-1" <<EOF
-2
-[0]: ""
-[1]: ""
-EOF
-
 test_split_in_place "foo:;:bar:;:baz:;:" ":;" "-1" <<EOF
 10
 [0]: "foo"
diff --git a/t/unit-tests/u-string-list.c b/t/unit-tests/u-string-list.c
new file mode 100644
index 0000000000..c304934de2
--- /dev/null
+++ b/t/unit-tests/u-string-list.c
@@ -0,0 +1,66 @@
+#include "unit-test.h"
+#include "string-list.h"
+
+static void t_vcreate_string_list_dup(struct string_list *list,
+				      int free_util, va_list ap)
+{
+	const char *arg;
+
+	cl_assert(list->strdup_strings);
+
+	string_list_clear(list, free_util);
+	while ((arg = va_arg(ap, const char *)))
+		string_list_append(list, arg);
+}
+
+static void t_string_list_clear(struct string_list *list, int free_util)
+{
+	string_list_clear(list, free_util);
+	cl_assert_equal_p(list->items, NULL);
+	cl_assert_equal_i(list->nr, 0);
+	cl_assert_equal_i(list->alloc, 0);
+}
+
+static void t_string_list_equal(struct string_list *list,
+				struct string_list *expected_strings)
+{
+	cl_assert_equal_i(list->nr, expected_strings->nr);
+	cl_assert(list->nr <= list->alloc);
+	for (size_t i = 0; i < expected_strings->nr; i++)
+		cl_assert_equal_s(list->items[i].string,
+				  expected_strings->items[i].string);
+}
+
+static void t_string_list_split(struct string_list *list, const char *data,
+				int delim, int maxsplit, ...)
+{
+	struct string_list expected_strings = STRING_LIST_INIT_DUP;
+	va_list ap;
+	int len;
+
+	va_start(ap, maxsplit);
+	t_vcreate_string_list_dup(&expected_strings, 0, ap);
+	va_end(ap);
+
+	string_list_clear(list, 0);
+	len = string_list_split(list, data, delim, maxsplit);
+	cl_assert_equal_i(len, expected_strings.nr);
+	t_string_list_equal(list, &expected_strings);
+
+	string_list_clear(&expected_strings, 0);
+}
+
+void test_string_list__split(void)
+{
+	struct string_list list = STRING_LIST_INIT_DUP;
+
+	t_string_list_split(&list, "foo:bar:baz", ':', -1, "foo", "bar", "baz", NULL);
+	t_string_list_split(&list, "foo:bar:baz", ':', 0, "foo:bar:baz", NULL);
+	t_string_list_split(&list, "foo:bar:baz", ':', 1, "foo", "bar:baz", NULL);
+	t_string_list_split(&list, "foo:bar:baz", ':', 2, "foo", "bar", "baz", NULL);
+	t_string_list_split(&list, "foo:bar:", ':', -1, "foo", "bar", "", NULL);
+	t_string_list_split(&list, "", ':', -1, "", NULL);
+	t_string_list_split(&list, ":", ':', -1, "", "", NULL);
+
+	t_string_list_clear(&list, 0);
+}
-- 
2.49.0

