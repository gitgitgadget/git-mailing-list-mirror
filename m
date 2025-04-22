Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0715B28E616
	for <git@vger.kernel.org>; Tue, 22 Apr 2025 14:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745333691; cv=none; b=A5k8eTEQTDoktmSUcQyqDfkGzSMjDK+SDYHH7PFqBPtKksBu91DK1kTtDOtxcxnkZVyXv2riGNPNW+ekrp/QJCk+zJ5EuUfPG8ezQF4LLVxv+UMXGOUkYEIn5TDiZC79oVkZt7v2CVITsccq8CTuTyDVMhHAgjcoKSbV2sLkqQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745333691; c=relaxed/simple;
	bh=E/9TDubcFzGjWrP+jCJOuURFI7V8a9BTjBYBDLRKDxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q85RYj2wBY5LkHfvn2mkYqYbAr4BjDAkKCWwHAOft3we/gypBz7N+UoSVvSWsgtf6VagyN5A6csc16TUTUE0bTYkfpxpaSIU+RN4MONrFvnj0HzFdanjAMzHZfNBiNfPwO0PGiYr8xj27HoCytOWFAmyNJose7byo0vDnDX0Vgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lNgGjhkR; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lNgGjhkR"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22401f4d35aso57802235ad.2
        for <git@vger.kernel.org>; Tue, 22 Apr 2025 07:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745333689; x=1745938489; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mFqIlQANAckQXeJTL4OcI7YXQfOj1juLzskAk5QpSwQ=;
        b=lNgGjhkRcLufgVlOs/HZ3xK9uNEbmjpIrchTPqlMwFjSQVNFBGxa8qk8SIDG0T8hkA
         0+fQm9KDT8AWJ9sk3R0GdLrQKbgIt83k2kg/9Ei3yanoR81zsDvCj2AU0ppQhY5WeJK3
         CEUDfDG45mwstX7GSD8srOmcIWLaVqe3LyIVgtw0rMR9LoSmqI9qhFZpY4rSOStQ3uvi
         P/XbFUAjzgFCBEE2utO7tNpgvL9qZJXSllNxs8OTawbhZmJYXmiDbeuiVIx2gx14EBXU
         6isA8twyzrL5ALHn6NrydJlAI/JE6VvkvRHTE7IO/45+fFVlK37tDoKMUshUjcj5TNmk
         7+Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745333689; x=1745938489;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mFqIlQANAckQXeJTL4OcI7YXQfOj1juLzskAk5QpSwQ=;
        b=fAFb8vcT/l2NnUKIAr5dwJFomlzDMytfs4V1y2uTFt3slH1EPY9ycmFbTwomRWJitM
         TeyRC4ds8DauwiG+OEKJJvADrtpsBsduKIJf+w3eKQBxmeVssxZ6HaI57S0/7XQ6UiRm
         TvMaPh30OMaCYxeYGsSH+HHQhWfmYSQRE6pOLCETOFHqavQMJBNtw+OiS5ZyDKW2ZFq6
         kNrXeFvdORq9uvGgQhnLXasxM7o0w8nq8aqLvJXNYon4l9/Mxlx7TZ/Ny61jlbwHkjCp
         ZBZYwSD89Y8kWQg9RXKRDHSlWzVz6+18qKQZAaTwQMk5rqHI3maoUSZ5Ak4aX4IOoy7N
         oN5Q==
X-Gm-Message-State: AOJu0YzqrmmZ54lKc8azA8Wvg7nd0VKKyPNSjD3bpVZ2bRHj8lHUGciO
	u6ov0kY9yvixbn7wg/fjUSngY1ptVNhJhD3w/2rgjWF5tNsAo6NSwzC3WWSR
X-Gm-Gg: ASbGncuoL7XG4gODqYdECTmiNe4ElKVv6pJGVUs+jUtjHRXbIGBMGs+cmHdhfkw0176
	823HcHlJe63NM5lspos9Jb61bMwF1ZpIF9NVMXnmnOUQnjO2gwC9/UWg27+10vWIerXatTAwC1n
	Ta22GGT6Kz20UHGN66SxPoQlNVFQbIXKR8pQ/7+oEbQp0DhrKNflzit4Rwt8lF74sDpUZNHHQFV
	qeR/A5uZmCg9Il00i+S6yrvADELuedNN7+gdfc3Ao6n8TVZ5K4rAr5N9Pkt6jDzhuCj3/Pg/D2T
	DvSOE1LA9+W06K+JelvamXDXnMpj8zq0U0vd
X-Google-Smtp-Source: AGHT+IFd06o2AlnDdpv5NZDXLLltxVDn0aLGordTJ0bl1JkqkJWPjwdrrtWzCdSBYwP684I5Uu51JA==
X-Received: by 2002:a17:902:d50b:b0:220:c813:dfd1 with SMTP id d9443c01a7336-22c53607db6mr238929605ad.36.1745333688834;
        Tue, 22 Apr 2025 07:54:48 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22c50ecf37csm86085535ad.197.2025.04.22.07.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 07:54:48 -0700 (PDT)
Date: Tue, 22 Apr 2025 22:54:55 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 2/5] u-string-list: move "test_split" into "u-string-list.c"
Message-ID: <aAetv8l8jrxvEywB@ArchLinux>
References: <aAetW0dan8S3Fljq@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aAetW0dan8S3Fljq@ArchLinux>

We rely on "test-tool string-list" command to test the functionality of
the "string-list". However, as we have introduced clar test framework,
we'd better move the shell script into C program to improve speed and
readability.

Create a new file "u-string-list.c" under "t/unit-tests", then update
the Makefile and "meson.build" to build the file. And let's first move
"test_split" into unit test and gradually convert the shell script into
C program.

In order to create `string_list` easily by simply specifying strings in
the function call, create "t_vcreate_string_list_dup" and
"t_create_string_list_dup" functions to do above.

Then port the shell script tests to C program and remove unused
"test-tool" code and tests.

Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 Makefile                     |  1 +
 t/helper/test-string-list.c  | 14 ------
 t/meson.build                |  1 +
 t/t0063-string-list.sh       | 53 ----------------------
 t/unit-tests/u-string-list.c | 86 ++++++++++++++++++++++++++++++++++++
 5 files changed, 88 insertions(+), 67 deletions(-)
 create mode 100644 t/unit-tests/u-string-list.c

diff --git a/Makefile b/Makefile
index 13f9062a05..58df1f1150 100644
--- a/Makefile
+++ b/Makefile
@@ -1365,6 +1365,7 @@ CLAR_TEST_SUITES += u-prio-queue
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
index bfb744e886..424e7e445f 100644
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
index 0000000000..0c148684ea
--- /dev/null
+++ b/t/unit-tests/u-string-list.c
@@ -0,0 +1,86 @@
+#include "unit-test.h"
+#include "string-list.h"
+
+static void t_check_string_list(struct string_list *list,
+				struct string_list *expected_strings)
+{
+	size_t expect_len = expected_strings->nr;
+	cl_assert_equal_i(list->nr, expect_len);
+	cl_assert(list->nr <= list->alloc);
+	for (size_t i = 0; i < expect_len; i++)
+		cl_assert_equal_s(list->items[i].string,
+				  expected_strings->items[i].string);
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
+static void t_vcreate_string_list_dup(struct string_list *list,
+				      int free_util, va_list ap)
+{
+	const char *arg;
+
+	cl_assert(list->strdup_strings);
+
+	t_string_list_clear(list, free_util);
+	while ((arg = va_arg(ap, const char *)))
+		string_list_append(list, arg);
+}
+
+static void t_create_string_list_dup(struct string_list *list, int free_util, ...)
+{
+	va_list ap;
+
+	cl_assert(list->strdup_strings);
+
+	t_string_list_clear(list, free_util);
+	va_start(ap, free_util);
+	t_vcreate_string_list_dup(list, free_util, ap);
+	va_end(ap);
+}
+
+static void t_string_list_split(const char *data, int delim, int maxsplit,
+				struct string_list *expected_strings)
+{
+	struct string_list list = STRING_LIST_INIT_DUP;
+	int len;
+
+	len = string_list_split(&list, data, delim, maxsplit);
+	cl_assert_equal_i(len, expected_strings->nr);
+	t_check_string_list(&list, expected_strings);
+
+	t_string_list_clear(&list, 0);
+}
+
+void test_string_list__split(void)
+{
+	struct string_list expected_strings = STRING_LIST_INIT_DUP;
+
+	t_create_string_list_dup(&expected_strings, 0, "foo", "bar", "baz", NULL);
+	t_string_list_split("foo:bar:baz", ':', -1, &expected_strings);
+
+	t_create_string_list_dup(&expected_strings, 0, "foo:bar:baz", NULL);
+	t_string_list_split("foo:bar:baz", ':', 0, &expected_strings);
+
+	t_create_string_list_dup(&expected_strings, 0, "foo", "bar:baz", NULL);
+	t_string_list_split("foo:bar:baz", ':', 1, &expected_strings);
+
+	t_create_string_list_dup(&expected_strings, 0, "foo", "bar", "baz", NULL);
+	t_string_list_split("foo:bar:baz", ':', 2, &expected_strings);
+
+	t_create_string_list_dup(&expected_strings, 0, "foo", "bar", "", NULL);
+	t_string_list_split("foo:bar:", ':', -1, &expected_strings);
+
+	t_create_string_list_dup(&expected_strings, 0, "", NULL);
+	t_string_list_split("", ':', -1, &expected_strings);
+
+	t_create_string_list_dup(&expected_strings, 0, "", "", NULL);
+	t_string_list_split(":", ':', -1, &expected_strings);
+
+	t_string_list_clear(&expected_strings, 0);
+}
-- 
2.49.0

