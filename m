Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A312848A4
	for <git@vger.kernel.org>; Fri, 26 Sep 2025 07:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758871560; cv=none; b=WH/joyOpmwXA1WIHARXhEiEMUT0NzS5wvd91pr9XMSisPJheFRJsKDKdeodyyhb81EZ7Mf28HP/1LCjxo7mt9tJUW21uGK7mX8K+oAM7GLaofyBTRmJkbiI/YJT18IeJpeK8H9vU8BFIKZIJXd0UgwJjcTBfKU14RHDLFR+Ph74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758871560; c=relaxed/simple;
	bh=H/VmlgpG8R6XUR5Wl2B0LScX/7+pkwK7S/i5tDeMQag=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=noJDUMKwGmdwJ7QqCYYAEaNRHEROEOh7qRluEXsZ+rb/xisYIX5q/XKn+tKFQ3eQaRh31fla9j9zG2k6OVUhNkn5XSxT7neCNII09qGY2W626k47EZrOyc7UMhOt4NWyg/8kd4KrPNB5DPuWNL7iyCS1rhURBwvanLE/9Vepv10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YGUsL8IH; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YGUsL8IH"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-62fb48315ddso3272971a12.2
        for <git@vger.kernel.org>; Fri, 26 Sep 2025 00:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758871557; x=1759476357; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e80D+DALQmmS3HY/Cugk8d8E4Te880MjiNvZpJxTk88=;
        b=YGUsL8IHJW+SaOxzay9d1eNiEPc+8SmKFCT5wdEMBx2ER0rTtF03BUV5nfN7oKQsXb
         fZ9iVhQymegkmlPLdioZmB5IGds8zBl2uFkjrjbN10t+LSKBZ31Jax+TJehhZSZjBJof
         6y3rLN/gBU48bVnFPspzF1EsDy1lL7ZmPWPp4lP055JWXmwolvpV2LFy5rHKRb4QyjNP
         wEIJhYOjizrjwMvb8bJ/bPVKZRFLNS6gcBVNHFKGSJg8TjdCnTEXgUUltige5Ila+BF1
         cmp3fGLP18J4uH7Fr4/0sLf9fPEnpa86OdijYt+0S/cg+ENAdLSjl0FhKbkkuSWPmBHk
         L38A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758871557; x=1759476357;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e80D+DALQmmS3HY/Cugk8d8E4Te880MjiNvZpJxTk88=;
        b=Ja5ayCoLo/8nNK2oMkIYMlhsGmYa8TDQ2LCQavKlu1tPhKFqIwjZiXTG/SXfrNDknF
         ZwLeEdIv9gYOu51bc1yjrpgGqySO91DV2aFbBwdxWINahdb+NDiZODgZaSQg3d6ywDWJ
         xEFuQMxNgDydr5p9o3yslD0xmivUDuwRNuQzqjFXbKXDRO8G1jaBWIHlsz0BiSXMMy/8
         o/gfwB6Z1O+Hkgc+Y7tMFGmIPFjP13UY7PzcojkFAtgD8TBRFMEFTdPK8CiA/NVJmeZ1
         BXL6q46sOmen3MreDC3hYRGVpxBpF/AiY2pelMHaAPlOkk4HO+sli1MWYsx0tDISEWkG
         e2mw==
X-Gm-Message-State: AOJu0Yxe22ipMp5UpxXzRlO/mYb2P5EPfAuCdl4pypM4AFavaFMf6Lia
	9fiG0Vz5JocRrT5ehH/ZcJ/1k5awejoZKR5/z01s2NunlPbO9zManA7hmzsCmnx2
X-Gm-Gg: ASbGncvv+bk32VsV70cfWuNxm8NIBrm6zudeD+ZuqlhCpCatki3rO+UtDhfTAjeMslY
	fvfhjjIxDh9xGqm6EqEN9q+NjjzeL6X3uMFH1Zoi3KVDtDJfMyGm7kQh2CrfC3nPWbyz7QEVOWq
	s4gTPL9SR/vJn732t40170HDDsPOI8G+4D+I8aDtXqk9odHCBCJhQU4DIx8DDbNm/fYBseWn/+A
	DL0nJt1ZDnoNkeFbz9X+SLiKF7+jAQAwnS3piLs2DpXeJTuA8G6T3n/osu4DjYM7bjKorwJE0Ku
	sINzdiCumsX2o5Dmbm973ahpG6e14z3YpJgqsOOu69P+saBJpL8voylwVQRfos3HyAhS8SQGsq2
	E4McKSDIHXgwbRMAxnv/Kt8ATJGXQ34TTRrGfTtk=
X-Google-Smtp-Source: AGHT+IHLU2oKSz+TsQbUR36Y+3jw4oL0qBqnMDnO2qGQRpo2WLr1xcte0QIUbVSeEaiNcmRm+66UjQ==
X-Received: by 2002:a05:6402:4556:b0:633:d0b7:d6ce with SMTP id 4fb4d7f45d1cf-6349f9f0134mr4292784a12.15.1758871556702;
        Fri, 26 Sep 2025 00:25:56 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:2fd5:3bfb:87f3:d768])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-634a3af54desm2368795a12.40.2025.09.26.00.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 00:25:56 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Fri, 26 Sep 2025 09:25:46 +0200
Subject: [PATCH v4 3/7] reftable: check for trailing newline in
 'tables.list'
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250926-228-reftable-introduce-consistency-checks-v4-3-c96fd8551c0d@gmail.com>
References: <20250926-228-reftable-introduce-consistency-checks-v4-0-c96fd8551c0d@gmail.com>
In-Reply-To: <20250926-228-reftable-introduce-consistency-checks-v4-0-c96fd8551c0d@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, gitster@pobox.com, 
 shejialuo@gmail.com
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5292; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=H/VmlgpG8R6XUR5Wl2B0LScX/7+pkwK7S/i5tDeMQag=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGjWP//2wIDxJPvJbTtnHQYY3IYHYwhUlPTq2
 JIzRZeJIyEoXIkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJo1j//AAoJED7VnySO
 Rox/lyQMAI9jN08ufqSm2m7KgIT/iWv0m8Ky3+PYr/mJxoKeytRMPHdwodFjSzE3TfjLV8gyZta
 JRCcTcHai/u+J0q6vG3Ky6+AQRay2rjf0AoOicGagsBnR6ABjn2Vh4L0mU/82fSEQ2PnnxT/wv3
 PdvrG0Fvt0WfGa3LuaDqabWyKeq1QHBAx/qKrGKN38PqmeJmrZ8VtginvqumDWXUQrM7cr2nC+1
 Wk4czTwXVKM+T1mNNdNtM3rkTG4NLVWIzrVCMeeB7SGoNwRPsR50atXcu2k9W+QqBQHjY4hQ0cK
 kaBPgwtGmxSRZA+pyquqlEWKpna4//LQuB8jKdrkeA1flFLz9RvrDAhRkWur3wJcQp3ReMH35D7
 RYV89m38EjWmstSFief2QpddkoplOIHy16mnIozchICtwquazQqad9ZgBZEcFN2lZeLHRM2xKaA
 4QT8djkO5axYiK6Cpf1hLN9YO1Jio0SYUotlYlAqncSL5M0OlyJ/0sIVUsOkvLP2yOQvOclSHd7
 MU=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

In the reftable format, the 'tables.list' file contains a
newline separated list of tables. While we parse this file, we do not
check or care about the last newline. Tighten the parser in
`parse_names()` to return an appropriate error if the last newline is
missing.

This requires modification to `parse_names()` to now return the error
while accepting the output as a third argument.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 reftable/basics.c                | 37 ++++++++++++++++++++++++-------------
 reftable/basics.h                |  5 ++---
 reftable/stack.c                 |  7 +------
 t/unit-tests/u-reftable-basics.c | 24 ++++++++++++++++++++----
 4 files changed, 47 insertions(+), 26 deletions(-)

diff --git a/reftable/basics.c b/reftable/basics.c
index 9988ebd635..e969927b61 100644
--- a/reftable/basics.c
+++ b/reftable/basics.c
@@ -195,44 +195,55 @@ size_t names_length(const char **names)
 	return p - names;
 }
 
-char **parse_names(char *buf, int size)
+int parse_names(char *buf, int size, char ***out)
 {
 	char **names = NULL;
 	size_t names_cap = 0;
 	size_t names_len = 0;
 	char *p = buf;
 	char *end = buf + size;
+	int err = 0;
 
 	while (p < end) {
 		char *next = strchr(p, '\n');
-		if (next && next < end) {
-			*next = 0;
+		if (!next) {
+			err = REFTABLE_FORMAT_ERROR;
+			goto done;
+		} else if (next < end) {
+			*next = '\0';
 		} else {
 			next = end;
 		}
+
 		if (p < next) {
 			if (REFTABLE_ALLOC_GROW(names, names_len + 1,
-						names_cap))
-				goto err;
+						names_cap)) {
+				err = REFTABLE_OUT_OF_MEMORY_ERROR;
+				goto done;
+			}
 
 			names[names_len] = reftable_strdup(p);
-			if (!names[names_len++])
-				goto err;
+			if (!names[names_len++]) {
+				err = REFTABLE_OUT_OF_MEMORY_ERROR;
+				goto done;
+			}
 		}
 		p = next + 1;
 	}
 
-	if (REFTABLE_ALLOC_GROW(names, names_len + 1, names_cap))
-		goto err;
+	if (REFTABLE_ALLOC_GROW(names, names_len + 1, names_cap)) {
+		err = REFTABLE_OUT_OF_MEMORY_ERROR;
+		goto done;
+	}
 	names[names_len] = NULL;
 
-	return names;
-
-err:
+	*out = names;
+	return 0;
+done:
 	for (size_t i = 0; i < names_len; i++)
 		reftable_free(names[i]);
 	reftable_free(names);
-	return NULL;
+	return err;
 }
 
 int names_equal(const char **a, const char **b)
diff --git a/reftable/basics.h b/reftable/basics.h
index 7d22f96261..693db9524f 100644
--- a/reftable/basics.h
+++ b/reftable/basics.h
@@ -167,10 +167,9 @@ void free_names(char **a);
 
 /*
  * Parse a newline separated list of names. `size` is the length of the buffer,
- * without terminating '\0'. Empty names are discarded. Returns a `NULL`
- * pointer when allocations fail.
+ * without terminating '\0'. Empty names are discarded.
  */
-char **parse_names(char *buf, int size);
+int parse_names(char *buf, int size, char ***out);
 
 /* compares two NULL-terminated arrays of strings. */
 int names_equal(const char **a, const char **b);
diff --git a/reftable/stack.c b/reftable/stack.c
index f91ce50bcd..65d89820bd 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -109,12 +109,7 @@ static int fd_read_lines(int fd, char ***namesp)
 	}
 	buf[size] = 0;
 
-	*namesp = parse_names(buf, size);
-	if (!*namesp) {
-		err = REFTABLE_OUT_OF_MEMORY_ERROR;
-		goto done;
-	}
-
+	err = parse_names(buf, size, namesp);
 done:
 	reftable_free(buf);
 	return err;
diff --git a/t/unit-tests/u-reftable-basics.c b/t/unit-tests/u-reftable-basics.c
index a0471083e7..73566ed0eb 100644
--- a/t/unit-tests/u-reftable-basics.c
+++ b/t/unit-tests/u-reftable-basics.c
@@ -9,6 +9,7 @@ license that can be found in the LICENSE file or at
 #include "unit-test.h"
 #include "lib-reftable.h"
 #include "reftable/basics.h"
+#include "reftable/reftable-error.h"
 
 struct integer_needle_lesseq_args {
 	int needle;
@@ -79,14 +80,18 @@ void test_reftable_basics__names_equal(void)
 void test_reftable_basics__parse_names(void)
 {
 	char in1[] = "line\n";
-	char in2[] = "a\nb\nc";
-	char **out = parse_names(in1, strlen(in1));
+	char in2[] = "a\nb\nc\n";
+	char **out = NULL;
+	int err = parse_names(in1, strlen(in1), &out);
+	cl_assert(err == 0);
 	cl_assert(out != NULL);
 	cl_assert_equal_s(out[0], "line");
 	cl_assert(!out[1]);
 	free_names(out);
 
-	out = parse_names(in2, strlen(in2));
+	out = NULL;
+	err = parse_names(in2, strlen(in2), &out);
+	cl_assert(err == 0);
 	cl_assert(out != NULL);
 	cl_assert_equal_s(out[0], "a");
 	cl_assert_equal_s(out[1], "b");
@@ -95,10 +100,21 @@ void test_reftable_basics__parse_names(void)
 	free_names(out);
 }
 
+void test_reftable_basics__parse_names_missing_newline(void)
+{
+	char in1[] = "line\nline2";
+	char **out = NULL;
+	int err = parse_names(in1, strlen(in1), &out);
+	cl_assert(err == REFTABLE_FORMAT_ERROR);
+	cl_assert(out == NULL);
+}
+
 void test_reftable_basics__parse_names_drop_empty_string(void)
 {
 	char in[] = "a\n\nb\n";
-	char **out = parse_names(in, strlen(in));
+	char **out = NULL;
+	int err = parse_names(in, strlen(in), &out);
+	cl_assert(err == 0);
 	cl_assert(out != NULL);
 	cl_assert_equal_s(out[0], "a");
 	/* simply '\n' should be dropped as empty string */

-- 
2.51.0

