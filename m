Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6EF275108
	for <git@vger.kernel.org>; Thu, 18 Sep 2025 08:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758183114; cv=none; b=GaZN9zobOIRyuC/ky0D/zJoc5lN8psmFzVbob+cBii6L/o18ICUCmslFNmbyAFdAengDj6zjFjMlstMp33EGj1JL4JbawG+D0CwadHNZUOL1oSNGdT4apGpIWh/r24wk7j1Mae3THv4facpB3+2hxHzFW6444MLXsUBzePSXcS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758183114; c=relaxed/simple;
	bh=ujHkeRn/Cf+Yegiu++bZLx3tuHm9S+jdP4ovFeE6iBQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=udre+hd3pl2wAvSZtc85ofVn9CN0l99gUq6Um5ctE92FTkpWgbPpo9c+viwROrMP5yxMFk47VJkJP5D7NV6xPZJBl5glhCy3r+WuO2+w2KsXJZSKdwLODlfVUv5hQRJ4If2NzkXlw2eagKuh0/kdqlPV+BMXIRaKsqBOo6ttLhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BSroPCgx; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BSroPCgx"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-62f0702ef0dso3432374a12.1
        for <git@vger.kernel.org>; Thu, 18 Sep 2025 01:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758183111; x=1758787911; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9l8SNlFS3baFKDeWU7ksG0Ss0uhuqOjf6j1G+1tXByY=;
        b=BSroPCgxqDtDiWbXm5HQkDr8M+oKqzBcg7QH0Z2fkmO3RknmMv3RmSqZAOfl4Dq1Vc
         haBkhJ3qyMvt+teBfD8uetxicOl8bAUBP7gi5RQmfdAo0xhlQUxjBpjw9nbArkzRF4Rs
         /WX7Jxx/2broEcCcxZbMpMREe15oBIHwapfht/ePOVguxInaqJTeHqNlKJwN15ozy182
         5XGbzcm1AwIKUyKsqaYCgWKRhCohZgr6pIYPWTnZtePy5WSW1JtCMQaUuKV+x0Di3Gfr
         a+LKpj7AWOauJyRa84eNfer82WKq/Wos/Pi4/3Ie8LKei2f+z5UCPemP40TdcdMdeaqt
         iQkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758183111; x=1758787911;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9l8SNlFS3baFKDeWU7ksG0Ss0uhuqOjf6j1G+1tXByY=;
        b=pfj0wbBUH4TenBQSrUJm5NZEH8Pur8kTgv2DGasyFCqfIs408wCdkv3pc/Msparkoo
         Q9EkrYXEcEVGSRh7T2wwGF2DN+3RNiF0lFtGlE5ki3uwfkMyLzWVpZLtR2hO0WY0hcBc
         h8I+y7HPD57xWpergzmUT+ElDOqrO7cjCuPNag2xrMnKu93uPikGNm9zoUqRR0jQFD+O
         XyGRBi5XD8A/uEM0DI/+B/5QKKVBHZ/Va+h3M0o5/M8cpoi5+m97gj7GvwzWTO0D/zgd
         rKYaRTbrKbv1RYRkAmXMFzOVMVcgTcb6F5ay/qumlGrEAA5Pq0piz0PIzVaQB+u5KMRF
         wQqg==
X-Gm-Message-State: AOJu0Ywn0jhqjiHJeH85mlhKim93hHGe6O55MmFJNXRbIxsUSy7rmz4F
	lOxKpOVRIAZWbNE9VyltsvEjEISXny8/3boL9bmpfz92v5G4AK50JnCb
X-Gm-Gg: ASbGncuBEY+GOGm81+vpDtU8rcoihBJjYhFxz6oX7ukoEa5z22c67KNpHCTZ/P0Ui2G
	Ojc8gmNMtLKABQSwlj3nhti59UiRbWb3B9zvasnQcFXTlGqpWnptRW/cxjVUPUEHriIRHBkx9/d
	EF+N5PkanFLd90qutktPhuudSit6QuGuURrkCyX9SFv7O2bK2gt6C7ZjH0YegrFcnyofH3DtSCa
	dtXm9H9fz2Z28/pZyXBTBri/0SyezehJgvHxF6fYrzMs9BAeSpGknyFSbYa6xBeoO/UE8ieQd8E
	KaddNjL8wqMpg64tE3mer9XPWoqvxfVvINsuff8c2r1Jhx9ZxfQ7pTAKeoSKMT1cwrEQMxgUHRy
	cgDvexCuVafun7CHquFfEbxlQrEu3pvTPoPgvVF7LVVVUhOm0bopmF/qOyQ==
X-Google-Smtp-Source: AGHT+IHwffasOcuqVenSfl68l8gTwXF8Ri5vAOO2RVBzOyvfjA9bskIaRDoCvwvHVTih2sq3DkrxDQ==
X-Received: by 2002:a17:907:86a1:b0:b07:d171:fcd8 with SMTP id a640c23a62f3a-b1fad740e23mr246748866b.27.1758183110861;
        Thu, 18 Sep 2025 01:11:50 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:2802:b9c0:7d04:71e9])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b1fd2ce20f4sm139986566b.111.2025.09.18.01.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 01:11:50 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Thu, 18 Sep 2025 10:11:44 +0200
Subject: [PATCH v3 3/8] reftable: check for trailing newline in
 'tables.list'
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250918-228-reftable-introduce-consistency-checks-v3-3-271af03eb34d@gmail.com>
References: <20250918-228-reftable-introduce-consistency-checks-v3-0-271af03eb34d@gmail.com>
In-Reply-To: <20250918-228-reftable-introduce-consistency-checks-v3-0-271af03eb34d@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im, gitster@pobox.com, shejialuo@gmail.com, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5148; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=ujHkeRn/Cf+Yegiu++bZLx3tuHm9S+jdP4ovFeE6iBQ=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGjLvsJfEdpeiqVrSgEGhum36S60bDoQG9M+v
 w3btRqLpSV2NYkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJoy77CAAoJED7VnySO
 Rox/sgEL/RD6XEmZSq++Oax36m4TLwVP4f6swWhTYddjnVO9N14tErEPCGJMP93O1u83a15c5Hw
 3kNC051LA00N3SdgXX4lWbUfCAeWqs3VILmhhtGxbc+UTTlcDigwmdIN+QYT7stjc7DNnnS0ZDx
 9rEQ6Aqz+VHkIX0G9aPb/R0g3i8nEsC7/DmlLOK2EQcby3I7FmoL7ueFj2v0fh1mmwTDoWApnRm
 aF4MrXgjkk4Q5oS36nAIdwOmPwN2i4TokRmDCgG0b4JCS3E1mA7pQ0SI1ZijAQlAfzLFpGFfwRf
 gSvLgCYhuDgJnpO7UgFGq9Yo5zHNV/y/ljsth9MyrUoF81okwK20vydiTLWP/aXwPaKNa5VysUP
 EsQ3av7S2B2JtmzfSO0amB/ikIqfIVvA4XiD+cPsYT0aMI4cak0cV75pCTsICWOBDKYl8FnQuud
 6qvP3qVOR9v+uE7EUAUjedlubobOHmCw04zQ3CRogmb3/mUgnh8m8bLO/rLHKbHmDgJrICSV+t3
 gU=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

In the reftable format, the 'tables.list' file contains a newline
separated list of tables. While we parse this file, we do not check or
care about trailing newlines. Tighten the parser in `parse_names()` to
return an appropriate error if there is no trailing newline.

This requires modification to `parse_names()` to accept a third argument
which will hold the error value.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 reftable/basics.c                | 28 +++++++++++++++++++---------
 reftable/basics.h                |  7 ++++---
 reftable/stack.c                 |  6 ++----
 t/unit-tests/u-reftable-basics.c | 23 +++++++++++++++++++----
 4 files changed, 44 insertions(+), 20 deletions(-)

diff --git a/reftable/basics.c b/reftable/basics.c
index 9988ebd635..75d4086769 100644
--- a/reftable/basics.c
+++ b/reftable/basics.c
@@ -195,7 +195,7 @@ size_t names_length(const char **names)
 	return p - names;
 }
 
-char **parse_names(char *buf, int size)
+char **parse_names(char *buf, int size, int *err)
 {
 	char **names = NULL;
 	size_t names_cap = 0;
@@ -205,30 +205,40 @@ char **parse_names(char *buf, int size)
 
 	while (p < end) {
 		char *next = strchr(p, '\n');
-		if (next && next < end) {
+		if (!next) {
+			*err = REFTABLE_FORMAT_ERROR;
+			goto done;
+		} else if (next < end) {
 			*next = 0;
 		} else {
 			next = end;
 		}
+
 		if (p < next) {
 			if (REFTABLE_ALLOC_GROW(names, names_len + 1,
-						names_cap))
-				goto err;
+						names_cap)) {
+				*err = REFTABLE_OUT_OF_MEMORY_ERROR;
+				goto done;
+			}
 
 			names[names_len] = reftable_strdup(p);
-			if (!names[names_len++])
-				goto err;
+			if (!names[names_len++]) {
+				*err = REFTABLE_OUT_OF_MEMORY_ERROR;
+				goto done;
+			}
 		}
 		p = next + 1;
 	}
 
-	if (REFTABLE_ALLOC_GROW(names, names_len + 1, names_cap))
-		goto err;
+	if (REFTABLE_ALLOC_GROW(names, names_len + 1, names_cap)) {
+		*err = REFTABLE_OUT_OF_MEMORY_ERROR;
+		goto done;
+	}
 	names[names_len] = NULL;
 
 	return names;
 
-err:
+done:
 	for (size_t i = 0; i < names_len; i++)
 		reftable_free(names[i]);
 	reftable_free(names);
diff --git a/reftable/basics.h b/reftable/basics.h
index 7d22f96261..019dfe6d7e 100644
--- a/reftable/basics.h
+++ b/reftable/basics.h
@@ -167,10 +167,11 @@ void free_names(char **a);
 
 /*
  * Parse a newline separated list of names. `size` is the length of the buffer,
- * without terminating '\0'. Empty names are discarded. Returns a `NULL`
- * pointer when allocations fail.
+ * without terminating '\0'. Empty names are discarded.
+ *
+ * Errors are assigned to the `err` variable.
  */
-char **parse_names(char *buf, int size);
+char **parse_names(char *buf, int size, int *err);
 
 /* compares two NULL-terminated arrays of strings. */
 int names_equal(const char **a, const char **b);
diff --git a/reftable/stack.c b/reftable/stack.c
index f91ce50bcd..955be1edb6 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -109,11 +109,9 @@ static int fd_read_lines(int fd, char ***namesp)
 	}
 	buf[size] = 0;
 
-	*namesp = parse_names(buf, size);
-	if (!*namesp) {
-		err = REFTABLE_OUT_OF_MEMORY_ERROR;
+	*namesp = parse_names(buf, size, &err);
+	if (!*namesp)
 		goto done;
-	}
 
 done:
 	reftable_free(buf);
diff --git a/t/unit-tests/u-reftable-basics.c b/t/unit-tests/u-reftable-basics.c
index a0471083e7..f77ec96429 100644
--- a/t/unit-tests/u-reftable-basics.c
+++ b/t/unit-tests/u-reftable-basics.c
@@ -9,6 +9,7 @@ license that can be found in the LICENSE file or at
 #include "unit-test.h"
 #include "lib-reftable.h"
 #include "reftable/basics.h"
+#include "reftable/reftable-error.h"
 
 struct integer_needle_lesseq_args {
 	int needle;
@@ -79,14 +80,17 @@ void test_reftable_basics__names_equal(void)
 void test_reftable_basics__parse_names(void)
 {
 	char in1[] = "line\n";
-	char in2[] = "a\nb\nc";
-	char **out = parse_names(in1, strlen(in1));
+	char in2[] = "a\nb\nc\n";
+	int err = 0;
+	char **out = parse_names(in1, strlen(in1), &err);
+	cl_assert(err == 0);
 	cl_assert(out != NULL);
 	cl_assert_equal_s(out[0], "line");
 	cl_assert(!out[1]);
 	free_names(out);
 
-	out = parse_names(in2, strlen(in2));
+	out = parse_names(in2, strlen(in2), &err);
+	cl_assert(err == 0);
 	cl_assert(out != NULL);
 	cl_assert_equal_s(out[0], "a");
 	cl_assert_equal_s(out[1], "b");
@@ -95,10 +99,21 @@ void test_reftable_basics__parse_names(void)
 	free_names(out);
 }
 
+void test_reftable_basics__parse_names_missing_newline(void)
+{
+	char in1[] = "line\nline2";
+	int err = 0;
+	char **out = parse_names(in1, strlen(in1), &err);
+	cl_assert(err == REFTABLE_FORMAT_ERROR);
+	cl_assert(out == NULL);
+}
+
 void test_reftable_basics__parse_names_drop_empty_string(void)
 {
 	char in[] = "a\n\nb\n";
-	char **out = parse_names(in, strlen(in));
+	int err = 0;
+	char **out = parse_names(in, strlen(in), &err);
+	cl_assert(err ==  0);
 	cl_assert(out != NULL);
 	cl_assert_equal_s(out[0], "a");
 	/* simply '\n' should be dropped as empty string */

-- 
2.51.0

