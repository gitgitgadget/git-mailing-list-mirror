Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0E028F520
	for <git@vger.kernel.org>; Tue, 22 Apr 2025 14:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745333714; cv=none; b=U6EPnEXwsfOvzwX6RFKaBtAi66aQ9qNTzTw+wJOPL5bva8aA3baD3nsZUMpH5tQ6bjG0GBpvyCBiDPaWAk5hWnENuo1SQMpEfBZ/gjAZKoOsDU9Ylk5DgNbCKcQex1FhPjonkv6Jol2jXU2zlQchWbHwz89dC95EgvLWemSpBzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745333714; c=relaxed/simple;
	bh=QKsTmXYnWoeXGUQAGZQedxQnUXcm+RNhdhWVQH5WiVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZvC86FLLLGoBf+9TvXK95FgkLz3D1Oqi3SaGXLC1v8AgzSH487ZUn2j/Rd9bzwXLjyQ7r1sTp8iJX9yPouMskUuj5PP2yqXlXjXT1Vp/TfwuiKSQ4I3i6lijNoy/xOuqWnFMv/EFcTdt+kDKUyTebDpdIbCwltdj8Aj62rwJQJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JCm2RV9J; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JCm2RV9J"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-736c1138ae5so4690293b3a.3
        for <git@vger.kernel.org>; Tue, 22 Apr 2025 07:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745333709; x=1745938509; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zQZhJUcGKJHF47hq/amqXvg6f2/C1Xe2AD/5sd92RTM=;
        b=JCm2RV9J2dltASqh2Wnrp1fIUnQv/tYi58qP8tDLt0CkjP0D6GGOvmkTkq08ci8k5o
         ISkUETaECl0MhLJmM7szChFC3Q1xOQljp74zY6t1i800zf4j52dV1EqjSNcWYSpdXzJv
         WrqsYMC92CvlG/Tn/BNX8BldWqZhjwzKIaWNQsNHb22+WrEtUj+qabLvCSrPj2wmYJEh
         Tnf/J7t1WZMHwcP35zjzish3H0kz9mw6oGHSuGSrXApniYbBMBYOMBo3CVCJyGGZxKaB
         0KyBX6L3WqEthUzjr38sB1gtAiFsmI1LqwKGh4GR8NW/FS1cymweIZi98jkuk7jopoqU
         bOZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745333709; x=1745938509;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zQZhJUcGKJHF47hq/amqXvg6f2/C1Xe2AD/5sd92RTM=;
        b=MNJUvtVOxdmdeLqGR0YiGVy2KKNcMuQ1kntkIxEw9ypdCcf+2GOLhzXpw1JV5oKItK
         hI4qvsw5CRltiR93Zbpp5t7jrqw2jMFd7q+RVmjcxV5LE9rGVz0QiCTQ0BEmwBtb5gfG
         jB7q9nzuY1lJjPSp9hQNaUlQR2vl/Ae4rr0edWJfdxusmpRiZtZybhL7SlS33pcxJF4f
         2SgP5ZM/ucYICQPRIC3gxD1TCZoy9vKxvaoryiwyJEQ9zlxP0HVcdcRt4UqaGSDFq4ZC
         r0cACU79Ok92+BFpkZNC7vgow3WhDf8yvctqO6blpcDpWBlDiwfTnpPwFm3P8biemZy9
         Bx2Q==
X-Gm-Message-State: AOJu0YweZFek40v/kgEic5jmltKkqAYr5YUY+zeH4f8PNw5Q9Xd0JFBn
	DICVkHA54F87WJGZPPT98D0H6yJFTvtpgsyXJH3ryj9lRCIesIplZ+dT6oOd
X-Gm-Gg: ASbGncujYlCUsDThd1By9EIq5wkAWw1bE4FvPVQj2wDlz9GRs1IIV7LKKRPj2t2QFfW
	s5+Ck1pU2mJq2nP2eqCCoorN0eugA428ef2csqYgaIZl7KDQKX7MhZ7Bu4LLkjY7umOzPFh+tZ+
	ZWsDeG3H/IQwy6kCwq0yZEaWf+qM/tl0b1nwon0sNHUgytWbTERvrSdCNGsK6cZX2LTSo6JTShO
	fgKTINxoOiBckW/j+aMF8zqxR7Uve1Mds1HrI2bDpzGk6V/S2GLtCF9VSEc2FjbShSEZMCgR8j/
	LyfhoYLK5/zcK8w5QuwUjs6wpklK+6SrwI72
X-Google-Smtp-Source: AGHT+IG0nSCfa74zvFqlSigxEiyYtx44RESHTSXjxJ9mnJxBR/1SsnrGxhzgqlfIvit29N/cBPA8aQ==
X-Received: by 2002:a05:6a00:3cc2:b0:736:46b4:bef2 with SMTP id d2e1a72fcca58-73dc14a0c09mr20829682b3a.6.1745333708731;
        Tue, 22 Apr 2025 07:55:08 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73dbfa595efsm8927819b3a.101.2025.04.22.07.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 07:55:07 -0700 (PDT)
Date: Tue, 22 Apr 2025 22:55:15 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 4/5] u-string-list: move "filter string" test to
 "u-string-list.c"
Message-ID: <aAet07CAKsJUklrS@ArchLinux>
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

We use "test-tool string-list filter" to test the "filter_string_list"
function. As we have introduced the unit test, we'd better remove the
logic from shell script to C program to improve test speed and
readability.

Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 t/helper/test-string-list.c  | 21 ---------------
 t/t0063-string-list.sh       | 11 --------
 t/unit-tests/u-string-list.c | 51 ++++++++++++++++++++++++++++++++++++
 3 files changed, 51 insertions(+), 32 deletions(-)

diff --git a/t/helper/test-string-list.c b/t/helper/test-string-list.c
index 8a344347ad..262b28c599 100644
--- a/t/helper/test-string-list.c
+++ b/t/helper/test-string-list.c
@@ -31,29 +31,8 @@ static void write_list_compact(const struct string_list *list)
 	}
 }
 
-static int prefix_cb(struct string_list_item *item, void *cb_data)
-{
-	const char *prefix = (const char *)cb_data;
-	return starts_with(item->string, prefix);
-}
-
 int cmd__string_list(int argc, const char **argv)
 {
-	if (argc == 4 && !strcmp(argv[1], "filter")) {
-		/*
-		 * Retain only the items that have the specified prefix.
-		 * Arguments: list|- prefix
-		 */
-		struct string_list list = STRING_LIST_INIT_DUP;
-		const char *prefix = argv[3];
-
-		parse_string_list(&list, argv[2]);
-		filter_string_list(&list, 0, prefix_cb, (void *)prefix);
-		write_list_compact(&list);
-		string_list_clear(&list, 0);
-		return 0;
-	}
-
 	if (argc == 3 && !strcmp(argv[1], "remove_duplicates")) {
 		struct string_list list = STRING_LIST_INIT_DUP;
 
diff --git a/t/t0063-string-list.sh b/t/t0063-string-list.sh
index 1a9cf8bfcf..31fd62bba8 100755
--- a/t/t0063-string-list.sh
+++ b/t/t0063-string-list.sh
@@ -7,17 +7,6 @@ test_description='Test string list functionality'
 
 . ./test-lib.sh
 
-test_expect_success "test filter_string_list" '
-	test "x-" = "x$(test-tool string-list filter - y)" &&
-	test "x-" = "x$(test-tool string-list filter no y)" &&
-	test yes = "$(test-tool string-list filter yes y)" &&
-	test yes = "$(test-tool string-list filter no:yes y)" &&
-	test yes = "$(test-tool string-list filter yes:no y)" &&
-	test y1:y2 = "$(test-tool string-list filter y1:y2 y)" &&
-	test y2:y1 = "$(test-tool string-list filter y2:y1 y)" &&
-	test "x-" = "x$(test-tool string-list filter x1:x2 y)"
-'
-
 test_expect_success "test remove_duplicates" '
 	test "x-" = "x$(test-tool string-list remove_duplicates -)" &&
 	test "x" = "x$(test-tool string-list remove_duplicates "")" &&
diff --git a/t/unit-tests/u-string-list.c b/t/unit-tests/u-string-list.c
index 44ec8de3d0..e02a15ac04 100644
--- a/t/unit-tests/u-string-list.c
+++ b/t/unit-tests/u-string-list.c
@@ -123,3 +123,54 @@ void test_string_list__split_in_place(void)
 
 	t_string_list_clear(&expected_strings, 0);
 }
+
+static int prefix_cb(struct string_list_item *item, void *cb_data)
+{
+	const char *prefix = (const char *)cb_data;
+	return starts_with(item->string, prefix);
+}
+
+static void t_string_list_filter(struct string_list *list,
+				 string_list_each_func_t want, void *cb_data,
+				 struct string_list *expected_strings)
+{
+	filter_string_list(list, 0, want, cb_data);
+	t_check_string_list(list, expected_strings);
+}
+
+void test_string_list__filter(void)
+{
+	struct string_list expected_strings = STRING_LIST_INIT_DUP;
+	struct string_list list = STRING_LIST_INIT_DUP;
+	const char *prefix = "y";
+
+	t_string_list_filter(&list, prefix_cb, (void*)prefix, &expected_strings);
+
+	t_create_string_list_dup(&list, 0, "no", NULL);
+	t_string_list_filter(&list, prefix_cb, (void*)prefix, &expected_strings);
+
+	t_create_string_list_dup(&list, 0, "yes", NULL);
+	t_create_string_list_dup(&expected_strings, 0, "yes", NULL);
+	t_string_list_filter(&list, prefix_cb, (void*)prefix, &expected_strings);
+
+	t_create_string_list_dup(&list, 0, "no", "yes", NULL);
+	t_string_list_filter(&list, prefix_cb, (void*)prefix, &expected_strings);
+
+	t_create_string_list_dup(&list, 0, "yes", "no", NULL);
+	t_string_list_filter(&list, prefix_cb, (void*)prefix, &expected_strings);
+
+	t_create_string_list_dup(&list, 0, "y1", "y2", NULL);
+	t_create_string_list_dup(&expected_strings, 0, "y1", "y2", NULL);
+	t_string_list_filter(&list, prefix_cb, (void*)prefix, &expected_strings);
+
+	t_create_string_list_dup(&list, 0, "y2", "y1", NULL);
+	t_create_string_list_dup(&expected_strings, 0, "y2", "y1", NULL);
+	t_string_list_filter(&list, prefix_cb, (void*)prefix, &expected_strings);
+
+	t_create_string_list_dup(&list, 0, "x1", "x2", NULL);
+	t_create_string_list_dup(&expected_strings, 0, NULL);
+	t_string_list_filter(&list, prefix_cb, (void*)prefix, &expected_strings);
+
+	t_string_list_clear(&list, 0);
+	t_string_list_clear(&expected_strings, 0);
+}
-- 
2.49.0

