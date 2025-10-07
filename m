Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92182DCC04
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 12:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759839101; cv=none; b=IyhFlkD+TjE32F2pJPuc7DNWzeo+IQlGTBupO70lSBxUxlOTwNyGvQ1Afb7SQreNT82IMN5fH0ZUKjS/r5c9m52DuMewBS0zqEO06Ay+GDVb/jsOoLdxseXzx+6v9pJ30SX6uF3itXU6gTgBQV8B7UImylRWTCo00lx4DjxSIY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759839101; c=relaxed/simple;
	bh=vajzF7gR5nafo2oxwHjDspAaXQSIcSzrCP+wtXDSp7o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d2JrsWozJJdssV7b3TzTWUy4ZhO+s9bN+08ctxINMZa0P1iSxpTfjuTYk2XJ9bbTomxuHclJTuJOS2botoXcxuvBIu+XHylELa/Zr7FNGsKAsH19RAlWUQNli46mCHF+ZafN9c3i1g5fwd2gT+Dpneodo1yTklGdOp8ie4Crr2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P4swP4MK; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P4swP4MK"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-afcb78ead12so1114198466b.1
        for <git@vger.kernel.org>; Tue, 07 Oct 2025 05:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759839097; x=1760443897; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oZulA/Nl8RAZOdFaT1Hp0Rr0e1j2BhSBKgui2uzZ1Gs=;
        b=P4swP4MKRiHHZTDPs6O3smNCyVaVax/p6L3zJ2IIZeKgLhm1U12ygH6Jt7JiCBFtKG
         b386cruM02sHDdRaTAFYIyMzdhacZg+KaP0KrPd+prlpmPEFL94AHFxmxMeoYh4iBLuY
         mnbDhxjGgLeLab89sKDIzPhRZYQ8hYJute1QMicta5lQNE4a7DTB4s8t5UP2PvcVXNBY
         ENdrKa/Klf9bCF4ke4GlegYWSa69O/ag4EmwoveKMMcLnVaM6LjSOmQ9oqOvi/FDcnoG
         a0GltVx23XP1GGvmHo2bnQihREoZbMThRTdIPeW8DnnAPA8QPHSwBgUKqMcYY12d/kOy
         Bt7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759839097; x=1760443897;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oZulA/Nl8RAZOdFaT1Hp0Rr0e1j2BhSBKgui2uzZ1Gs=;
        b=t5pSMIRsiqhWI3yNXP7ZpI1VBDIqJq9IM2anyQSFEyzMGiJgBAwYkXaX5jWe5qZ2W5
         qWTpMzfbRHLSGXuJdtOy4zDuHpxLDGwX27Ap5HCbsw5rjuxnUvzpB56stHN9kP4bTGwL
         rs1hpd7WQrgGj8F4QSMxu52bhpTuUyyCEl+xluR4yuX0kELHRM+LvYX1SYAUCiDD4HhI
         UesPcEmL3MnE63U0gqFMypkRsBfKsX4TjqjfWE3c8uIbuGJAjNTK4rnOFznLgi/j6RAK
         cu7scYwTiSI0s2X25bX2I/MTFiURmjnAPihKv5m1D12373hRAlwKE8279/t1RYyMgoIG
         xB/Q==
X-Gm-Message-State: AOJu0YziodetrmMJSoDUT4/ApvHECf6nNUMOJGpBvYbK/wvz7EKOY0nE
	hHiglOPSgjXq48etEddc75S2cu37o+fANAf5pGOE7nqGW+htsrJFSwE9
X-Gm-Gg: ASbGnctGdtfBmV9eQuaYB24JvfKkj7uI6lhmZeJZ0sc+D9e30eAmtsrhtUd0x0SJw4A
	JtHNeLPJsVcKU6mCGqkNavif5mumpVYhlQLZ0QtA1QoZea5ioqskphRsO74czMsR8csbcgp8sWJ
	skLn5vhVqOw2DzKFcg0taA12oQK83m1aNHSj07lakdnTNY6mhPdxWG3Ho48xWNdGS+7NtDJUPp+
	ELRi1osEg/CYEsVTK0765GaEs2+x6h2XcpAvuSlod3YOtfTfFhsAQfLIJVKsh+GQ6J2Y0alzgXy
	iDffvW0Ch0e7WESLbaPD8CERUh9/koVPD6tO5oK5nX4hHocVaWNPslQFnCThyYvY92EmTNtCaO4
	kNqVkHxGUAs+/C6DcvgDdHJy2mWhijHHZGF5Cd/jfHnyLVFR7
X-Google-Smtp-Source: AGHT+IEAmrk9dCuAjHjXiEqEZo2GmKRGKwSlZwPRhugRXRulLauhAmVvaZ4dLnfXh2v7PSq9R6km6g==
X-Received: by 2002:a17:906:abcb:b0:b4f:e357:78f8 with SMTP id a640c23a62f3a-b4fe35780ffmr161451566b.52.1759839096848;
        Tue, 07 Oct 2025 05:11:36 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:406:6e87:ed:4c93])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b486970b36fsm1367386866b.62.2025.10.07.05.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 05:11:36 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Tue, 07 Oct 2025 14:11:27 +0200
Subject: [PATCH v6 3/7] reftable: check for trailing newline in
 'tables.list'
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251007-228-reftable-introduce-consistency-checks-v6-3-638cff42f0b0@gmail.com>
References: <20251007-228-reftable-introduce-consistency-checks-v6-0-638cff42f0b0@gmail.com>
In-Reply-To: <20251007-228-reftable-introduce-consistency-checks-v6-0-638cff42f0b0@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im, gitster@pobox.com, peff@peff.net, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5359; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=vajzF7gR5nafo2oxwHjDspAaXQSIcSzrCP+wtXDSp7o=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGjlA3QsF+/FV0UYie+YfKkxwXydBheO7t5Gs
 hM6lNY5ARQstIkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJo5QN0AAoJED7VnySO
 Rox/8QAL/3PMxox5JgCpE108u7i9yKduktOjuAbk5qx6cUD3OGOBWHax43JyFkicxqucxp/L6eX
 DTFApeqfO8NXPdZ4Jxe8OC1VLJZW69zau+v2ZxQX4uZ7XNRx0JJ6caqQ8YMe06UZmP0S5zdvJZP
 CE/TkjzL+1u7nDtWKtRxCNZf7yy37SHbhQbzmSEC6jHF+03s+psnlZfwwo+wNVSPY+q/unaBaRb
 GpFnaiCI+cmBfHjZunJYYWz7/K956p3YaQPn0NMEu5e53WN9UtQcRfaqUo7WKFhyJDpsu7zygs0
 zMR33nkXqElfpoRjFt4+UhtDEqQnsiK+/KLSOYcW1dLHAhgmnKiIVmq7dR3XBo8z/pNPL5d5HhR
 YLHrILui9bchkJRve54vLXexqjctUrcoAzxytj2ZudVVmU+C/KXQCZehcT1+F05IBv7dfnfKjTa
 oaz9zGx8+IACgDPM/DQpTTCOgFomKtul7FdbJLgCRO2anOxIZYYgtbW6Qd1yH3gTwFXkXgryUl7
 uo=
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
 reftable/basics.h                |  7 ++++---
 reftable/stack.c                 |  7 +------
 t/unit-tests/u-reftable-basics.c | 24 ++++++++++++++++++++----
 4 files changed, 49 insertions(+), 26 deletions(-)

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
index 7d22f96261..e4b83b2b03 100644
--- a/reftable/basics.h
+++ b/reftable/basics.h
@@ -167,10 +167,11 @@ void free_names(char **a);
 
 /*
  * Parse a newline separated list of names. `size` is the length of the buffer,
- * without terminating '\0'. Empty names are discarded. Returns a `NULL`
- * pointer when allocations fail.
+ * without terminating '\0'. Empty names are discarded.
+ *
+ * Returns 0 on success, a reftable error code on error.
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

