Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512841F4706
	for <git@vger.kernel.org>; Tue, 22 Apr 2025 14:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745333703; cv=none; b=m6+AcMaft+O+A8Ma/rNohsMfIuaum+kp0/ao/qNSHoRUAVZ4H2Xo3h/lR3LhkBND2FnzXlyun5nMNyzm+J05UrjiVBVGKZLfGibFzYq66zlfVgXta+BrifZkuZwubQqutnefLB4M0zkDbnNVB36q8Vy9C3ljlHlkH49ePMEF9P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745333703; c=relaxed/simple;
	bh=pT7QN7yi0q0vd6pe0wfE0BF7hhPwjh91So2GWWYS9OE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WQsUYxYKZRJCvWBEm6BBMl4r0Ab35HkUl+GWeQR0djuyVH3Z1vJHfKSH27qEs2HB9GO4b1rDoZDF863XA6vBAaG4ZAKQfeCMnuo9T7qmucWRAzdhIqH5jN7kyf6Ku2uWxKvMVr2NKlVn+QOseruBuOrEFjEydh/0JXwlp/ROId4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cMPpD4JX; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cMPpD4JX"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-227cf12df27so46346255ad.0
        for <git@vger.kernel.org>; Tue, 22 Apr 2025 07:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745333700; x=1745938500; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WUHJCPOnvzmtcKkbgrd0vUx1lkiyz/ZyFD32DANzm24=;
        b=cMPpD4JXhoLkLh0shxzwHmV+ya7gmLaAzUIX/wu/iQvpI23ZOtKwNT1O1pkXtYFlqc
         GDjnE5iHbvNDglD4HwAgSETStKqcnw/tnHXZSjmiXkZvatjP+bex3Yy97IoX1SYqclgx
         ezeJB2TLqwgUG54ivke2HyDmgtm+xi4kFPmhygvZMDZmya+4UCvqQb/oScPH0UHTAl5u
         4SsoSr44+7FeRHM261ZmDDx4DGb6y4T1065uk8wTsMDiRWPbsv/rXUOHbalFu16dVhoZ
         zswbb6luLF+OgxWDMoyLQPDIdYPmCx8fYQQPT79bLlc4K2AegZKQmRZaP2unRCKfeTht
         0skg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745333700; x=1745938500;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WUHJCPOnvzmtcKkbgrd0vUx1lkiyz/ZyFD32DANzm24=;
        b=ezTcIh8MP5Cyc4T2bS/XxnyEW8zRvlWXo1VZA4oa6+M2UGkNxnjzFMvjSP64TMM2PW
         kKFKQKt9gM7vRTxODMlmXGiV+l5xmbXHQ+juAdeo/Wh8QfGQ0tEcRIz0Hw7YG7RE+sDZ
         0+0vt7rqoUiZyGYvO8aGNJH8ZUNxXAO/vIYQSzxQvzl+gcV5g5uKsLEyKPYzxIusWCRB
         4a+uFQXoR+rq7yy29d3OEGANV6w0x/8MRAhr9BGHu2TDx8apCPSxeBx6skm9tCjxdlaU
         X92IlK07GabiqS39m+c+f/rwI5loICi/mTa64H54PSxTaPlBdOqmnUblqL803eOkRrPV
         RrIw==
X-Gm-Message-State: AOJu0YxJ4SluNY8yh6aNQCzvB0FGiZERBbevZbKeisIdUOZMi4Ksyc5m
	P/r3uxU9d6vJ6dJztM6N7PcxHCYIgiHW+yQmUeb5a56ZLnI76xFRF/BV3Vp6
X-Gm-Gg: ASbGncvrMYYrH6rlHrE0oWK9TYcRrylgO/b00FEGE5uRBrAnuyRbM4xSjes+9/8Xpn3
	EArKXxEgaGmsnkZlL1v12gGjxW6dyBxcBOTsCnd8ZNT5pa9q1i/59KknVdr6rqqqAlktDmbniqJ
	4RpOKOeXwNjhw6s+R/xugeKuMabBgU7rKA/f08htCJRstH8vXvhOECcTz8DrsyxvEvrf3dkUXlw
	c0jH7b/523qCtpQnlvyElS9Bk/ZD89OeQXqTkRgrNdf+3iQG198+I4pe9XNXaaJgQqPw4i/FgVv
	YIiLF/rO60TUkkL3xKUTeuESIcboFUQ9XkWJ
X-Google-Smtp-Source: AGHT+IEvC+mMwVEmwU6qzNly5+jgbvvwRvY4deLQoilfVSX0/88qMGNo5hsPftagm3yantAzU+zdrg==
X-Received: by 2002:a17:902:ebc3:b0:21f:6dcf:fd2b with SMTP id d9443c01a7336-22c50bd645amr253788065ad.1.1745333700033;
        Tue, 22 Apr 2025 07:55:00 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22c50eb448esm85741115ad.152.2025.04.22.07.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 07:54:59 -0700 (PDT)
Date: Tue, 22 Apr 2025 22:55:06 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 3/5] u-string-list: move "test_split_in_place" to
 "u-string-list.c"
Message-ID: <aAetyvcw7ZgXa3f7@ArchLinux>
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

We use "test-tool string-list split_in_place" to test the
"string_list_split_in_place" function. As we have introduced the unit
test, we'd better remove the logic from shell script to C program to
improve test speed and readability.

Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 t/helper/test-string-list.c  | 22 ----------------
 t/t0063-string-list.sh       | 51 ------------------------------------
 t/unit-tests/u-string-list.c | 39 +++++++++++++++++++++++++++
 3 files changed, 39 insertions(+), 73 deletions(-)

diff --git a/t/helper/test-string-list.c b/t/helper/test-string-list.c
index 17c18c30f6..8a344347ad 100644
--- a/t/helper/test-string-list.c
+++ b/t/helper/test-string-list.c
@@ -18,13 +18,6 @@ static void parse_string_list(struct string_list *list, const char *arg)
 	(void)string_list_split(list, arg, ':', -1);
 }
 
-static void write_list(const struct string_list *list)
-{
-	int i;
-	for (i = 0; i < list->nr; i++)
-		printf("[%d]: \"%s\"\n", i, list->items[i].string);
-}
-
 static void write_list_compact(const struct string_list *list)
 {
 	int i;
@@ -46,21 +39,6 @@ static int prefix_cb(struct string_list_item *item, void *cb_data)
 
 int cmd__string_list(int argc, const char **argv)
 {
-	if (argc == 5 && !strcmp(argv[1], "split_in_place")) {
-		struct string_list list = STRING_LIST_INIT_NODUP;
-		int i;
-		char *s = xstrdup(argv[2]);
-		const char *delim = argv[3];
-		int maxsplit = atoi(argv[4]);
-
-		i = string_list_split_in_place(&list, s, delim, maxsplit);
-		printf("%d\n", i);
-		write_list(&list);
-		string_list_clear(&list, 0);
-		free(s);
-		return 0;
-	}
-
 	if (argc == 4 && !strcmp(argv[1], "filter")) {
 		/*
 		 * Retain only the items that have the specified prefix.
diff --git a/t/t0063-string-list.sh b/t/t0063-string-list.sh
index 6b20ffd206..1a9cf8bfcf 100755
--- a/t/t0063-string-list.sh
+++ b/t/t0063-string-list.sh
@@ -7,57 +7,6 @@ test_description='Test string list functionality'
 
 . ./test-lib.sh
 
-test_split_in_place() {
-	cat >expected &&
-	test_expect_success "split (in place) $1 at $2, max $3" "
-		test-tool string-list split_in_place '$1' '$2' '$3' >actual &&
-		test_cmp expected actual
-	"
-}
-
-test_split_in_place "foo:;:bar:;:baz:;:" ":;" "-1" <<EOF
-10
-[0]: "foo"
-[1]: ""
-[2]: ""
-[3]: "bar"
-[4]: ""
-[5]: ""
-[6]: "baz"
-[7]: ""
-[8]: ""
-[9]: ""
-EOF
-
-test_split_in_place "foo:;:bar:;:baz" ":;" "0" <<EOF
-1
-[0]: "foo:;:bar:;:baz"
-EOF
-
-test_split_in_place "foo:;:bar:;:baz" ":;" "1" <<EOF
-2
-[0]: "foo"
-[1]: ";:bar:;:baz"
-EOF
-
-test_split_in_place "foo:;:bar:;:baz" ":;" "2" <<EOF
-3
-[0]: "foo"
-[1]: ""
-[2]: ":bar:;:baz"
-EOF
-
-test_split_in_place "foo:;:bar:;:" ":;" "-1" <<EOF
-7
-[0]: "foo"
-[1]: ""
-[2]: ""
-[3]: "bar"
-[4]: ""
-[5]: ""
-[6]: ""
-EOF
-
 test_expect_success "test filter_string_list" '
 	test "x-" = "x$(test-tool string-list filter - y)" &&
 	test "x-" = "x$(test-tool string-list filter no y)" &&
diff --git a/t/unit-tests/u-string-list.c b/t/unit-tests/u-string-list.c
index 0c148684ea..44ec8de3d0 100644
--- a/t/unit-tests/u-string-list.c
+++ b/t/unit-tests/u-string-list.c
@@ -84,3 +84,42 @@ void test_string_list__split(void)
 
 	t_string_list_clear(&expected_strings, 0);
 }
+
+static void t_string_list_split_in_place(const char *data, const char *delim, int maxsplit,
+					 struct string_list *expected_strings)
+{
+	struct string_list list = STRING_LIST_INIT_NODUP;
+
+	char *string = xstrdup(data);
+
+	int len = string_list_split_in_place(&list, string, delim, maxsplit);
+	cl_assert_equal_i(len, expected_strings->nr);
+	t_check_string_list(&list, expected_strings);
+
+	free(string);
+	t_string_list_clear(&list, 0);
+}
+
+void test_string_list__split_in_place(void)
+{
+	struct string_list expected_strings = STRING_LIST_INIT_DUP;
+
+	t_create_string_list_dup(&expected_strings, 0, "foo", "", "", "bar",
+				 "", "", "baz", "", "", "", NULL);
+	t_string_list_split_in_place("foo:;:bar:;:baz:;:", ":;", -1, &expected_strings);
+
+	t_create_string_list_dup(&expected_strings, 0, "foo:;:bar:;:baz", NULL);
+	t_string_list_split_in_place("foo:;:bar:;:baz", ":;", 0, &expected_strings);
+
+	t_create_string_list_dup(&expected_strings, 0, "foo", ";:bar:;:baz", NULL);
+	t_string_list_split_in_place("foo:;:bar:;:baz", ":;", 1, &expected_strings);
+
+	t_create_string_list_dup(&expected_strings, 0, "foo", "", ":bar:;:baz", NULL);
+	t_string_list_split_in_place("foo:;:bar:;:baz", ":;", 2, &expected_strings);
+
+	t_create_string_list_dup(&expected_strings, 0, "foo", "", "", "bar",
+				 "", "", "", NULL);
+	t_string_list_split_in_place("foo:;:bar:;:", ":;", -1, &expected_strings);
+
+	t_string_list_clear(&expected_strings, 0);
+}
-- 
2.49.0

