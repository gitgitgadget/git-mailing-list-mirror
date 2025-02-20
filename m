Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3032E1EDA1C
	for <git@vger.kernel.org>; Thu, 20 Feb 2025 08:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740040228; cv=none; b=tcFgI9akxsO2i1+0l3/zJVi7kQNZlz4JwnTCzJWhGkdJJKCi/w1Sq4sJ9jLkTJSTKcY1CPaWKjbpX6QyB8iSjMt8ilGecl5i5vmGaiiEEjKZuhu1C+zDsf3W+CVHlitNdos5E6lL50ZGy8TvKu/JqQw1mcVMnZBGM8jqopHuarc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740040228; c=relaxed/simple;
	bh=k4BoABB5by+iiofaE/PHK7FGScfahVzUesUSAZZAYzE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mfJI9Nj5laMzveQYtBPAOIMTTKTlc8xriZ9x6tlJ38FYaOGuEvrO3D8pG86tqLfrgZkR09jgAY1sNokq4g6PVcQ5fCkjT644mTOBflPxqXeQ39/2lStt1GCZa/rwnyuxUQ4L4Km1CkALmYyb4/aL7ASUIcXjrTpmeFH/h37O798=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YrDamdTH; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YrDamdTH"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ab7430e27b2so119106066b.3
        for <git@vger.kernel.org>; Thu, 20 Feb 2025 00:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740040224; x=1740645024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p+8q52LtX47sRUIbNGIeZa/PiPJPDFPMyNOagzmri7I=;
        b=YrDamdTHPzHabo0dQDJEdZ3lmC6EdWvD+U2lxw3Scc/nPi1s9nglZ61RmGVJ/Ne40J
         Cj6tq2YgJowas55TnijGlX6efziuh9sWuAxIXjwfFsm4NBX69BnA2YmP4n/AcsGpS7N7
         BAgrLwHnkgckyFlUaI+RaWuPc8o9bM4L8NRYNTOVx1r5ukz+e0MErphYXVvQp7Rt/h4t
         jr2352g0ySvDeNb/8gJ3j5oh4/QSveB63TOyXpWVsuHjnp8YJ2hVvSl3t3GVbBdb/8e8
         O+BKe/AtNYijDBfmpFj6CQ99RpXov0/+Dg3aj9W70dlCqbSKSELPnmi28Ydbz1kD9okp
         RXwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740040224; x=1740645024;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p+8q52LtX47sRUIbNGIeZa/PiPJPDFPMyNOagzmri7I=;
        b=b3defNs+RgVJRx0eAw2JvQHlY+jskD30aYVAB9j9RRrlGJ78ME5PHdBHH3Oq5cyLhM
         PsIHqUUtiZ4765Q+BS821ngpBQSZcXtxcQZbCdAsty+wkCG9iu79RAw3bOmBZfg5cZBM
         if7MegEugJKiecf50nWc1W8qvEnjAgFt72n4TneoFGSbOnrgTId2HWRsubfOoIbKOyZO
         T6wlf102EddaraR639C/DG73jqic/6A9l3QXPiIoUtY7vIICxIDFZBsr8iHhLCGVUwl8
         Ew7j/fYgDJjYEimoWSSbjnFdybXrY14FpZPAB+6W5PgT8dRCZ0q1eVKo5HfNl6bzG29F
         SCFA==
X-Gm-Message-State: AOJu0Yy1HS3mL51M6laF5EISt8ZUbVCJrstZS8ruuqCeh57AquQ+nVbh
	E5xW1YYhMrEKkc8/Z+833Fh3MKcLiPPS/sS0Kn+J+d71AsomRijdhDuMJBI6/hu6uA==
X-Gm-Gg: ASbGncsn+Y4bA6ZNBcI3kp01745EgM4wqxxlKFdcugY3q3fDKUs1fX/yUf3Cvho3HDI
	p2TjIsHbd8vnZG4R3HR2w/uJOLbiqjWUGxojOw22IzoD+Za3O+uR4yd+TSeMlCemUcX3BqCKqgH
	8KMRHEd4UhUrHbPJojaZEOO6m9tm03oiZdJl/aU/i219br73NokW4ZhQI/9HvwvcqnR9wd7E4Zr
	uE/KGeCSyXI7vjmsgvcaDLdfRPLXLN0tNjip0ETOJdhjXusr6AtWaTuOYhzmwIvBvsjRikGzYqu
	1xIKncDQ4hpGamXe+TnhCXBfBVo=
X-Google-Smtp-Source: AGHT+IFXVv2YIW3OchsbOgbI1Ftm3gUfiF8cOg/fNqYg++N/10X8rQL+MkDgwaH1BGJhldtphmqF+g==
X-Received: by 2002:a17:907:da4:b0:ab7:6d59:3b4c with SMTP id a640c23a62f3a-abb70aa65bcmr1678631966b.21.1740040223897;
        Thu, 20 Feb 2025 00:30:23 -0800 (PST)
Received: from localhost.localdomain ([154.118.9.41])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-abbdf53d765sm230533966b.39.2025.02.20.00.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 00:30:23 -0800 (PST)
From: Seyi Kuforiji <kuforiji98@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	phillip.wood@dunelm.org.uk,
	Seyi Kuforiji <kuforiji98@gmail.com>
Subject: [PATCH 5/5] t/unit-tests: remove lib-oid.{c,h,o}
Date: Thu, 20 Feb 2025 09:29:59 +0100
Message-ID: <20250220082959.10854-6-kuforiji98@gmail.com>
X-Mailer: git-send-email 2.47.0.86.g15030f9556
In-Reply-To: <20250220082959.10854-1-kuforiji98@gmail.com>
References: <20250220082959.10854-1-kuforiji98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `lib-oid.c`, `lib-oid.h`, and `lib-oid.o files` are no longer needed
since their equivalent functions have been implemented in unit-test.c
and unit-test.h. This removes redundant code and ensures all unit
test-related functionality is consolidated in a single location.

Drop references to lib-oid from our `Makefile`, and `meson.build` files
to prevent build errors due to missing files.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Seyi Kuforiji <kuforiji98@gmail.com>
---
 Makefile               |  1 -
 t/meson.build          |  1 -
 t/unit-tests/lib-oid.c | 52 ------------------------------------------
 t/unit-tests/lib-oid.h | 25 --------------------
 4 files changed, 79 deletions(-)
 delete mode 100644 t/unit-tests/lib-oid.c
 delete mode 100644 t/unit-tests/lib-oid.h

diff --git a/Makefile b/Makefile
index feb01702c7..6afa6587ba 100644
--- a/Makefile
+++ b/Makefile
@@ -1381,7 +1381,6 @@ UNIT_TEST_PROGRAMS += t-trailer
 UNIT_TEST_PROGRAMS += t-urlmatch-normalization
 UNIT_TEST_PROGS = $(patsubst %,$(UNIT_TEST_BIN)/%$X,$(UNIT_TEST_PROGRAMS))
 UNIT_TEST_OBJS += $(UNIT_TEST_DIR)/test-lib.o
-UNIT_TEST_OBJS += $(UNIT_TEST_DIR)/lib-oid.o
 UNIT_TEST_OBJS += $(UNIT_TEST_DIR)/lib-reftable.o
 
 # xdiff and reftable libs may in turn depend on what is in libgit.a
diff --git a/t/meson.build b/t/meson.build
index 0b412a7c16..c1c4aa32aa 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -68,7 +68,6 @@ foreach unit_test_program : unit_test_programs
   unit_test = executable(unit_test_name,
     sources: [
       'unit-tests/test-lib.c',
-      'unit-tests/lib-oid.c',
       'unit-tests/lib-reftable.c',
       unit_test_program,
     ],
diff --git a/t/unit-tests/lib-oid.c b/t/unit-tests/lib-oid.c
deleted file mode 100644
index 8f0ccac532..0000000000
--- a/t/unit-tests/lib-oid.c
+++ /dev/null
@@ -1,52 +0,0 @@
-#include "test-lib.h"
-#include "lib-oid.h"
-#include "strbuf.h"
-#include "hex.h"
-
-int init_hash_algo(void)
-{
-	static int algo = -1;
-
-	if (algo < 0) {
-		const char *algo_name = getenv("GIT_TEST_DEFAULT_HASH");
-		algo = algo_name ? hash_algo_by_name(algo_name) : GIT_HASH_SHA1;
-
-		if (!check(algo != GIT_HASH_UNKNOWN))
-			test_msg("BUG: invalid GIT_TEST_DEFAULT_HASH value ('%s')",
-				 algo_name);
-	}
-	return algo;
-}
-
-static int get_oid_arbitrary_hex_algop(const char *hex, struct object_id *oid,
-				       const struct git_hash_algo *algop)
-{
-	int ret;
-	size_t sz = strlen(hex);
-	struct strbuf buf = STRBUF_INIT;
-
-	if (!check(sz <= algop->hexsz)) {
-		test_msg("BUG: hex string (%s) bigger than maximum allowed (%lu)",
-			 hex, (unsigned long)algop->hexsz);
-		return -1;
-	}
-
-	strbuf_add(&buf, hex, sz);
-	strbuf_addchars(&buf, '0', algop->hexsz - sz);
-
-	ret = get_oid_hex_algop(buf.buf, oid, algop);
-	if (!check_int(ret, ==, 0))
-		test_msg("BUG: invalid hex input (%s) provided", hex);
-
-	strbuf_release(&buf);
-	return ret;
-}
-
-int get_oid_arbitrary_hex(const char *hex, struct object_id *oid)
-{
-	int hash_algo = init_hash_algo();
-
-	if (!check_int(hash_algo, !=, GIT_HASH_UNKNOWN))
-		return -1;
-	return get_oid_arbitrary_hex_algop(hex, oid, &hash_algos[hash_algo]);
-}
diff --git a/t/unit-tests/lib-oid.h b/t/unit-tests/lib-oid.h
deleted file mode 100644
index 4e77c04bd2..0000000000
--- a/t/unit-tests/lib-oid.h
+++ /dev/null
@@ -1,25 +0,0 @@
-#ifndef LIB_OID_H
-#define LIB_OID_H
-
-#include "hash.h"
-
-/*
- * Convert arbitrary hex string to object_id.
- * For example, passing "abc12" will generate
- * "abc1200000000000000000000000000000000000" hex of length 40 for SHA-1 and
- * create object_id with that.
- * WARNING: passing a string of length more than the hexsz of respective hash
- * algo is not allowed. The hash algo is decided based on GIT_TEST_DEFAULT_HASH
- * environment variable.
- */
-int get_oid_arbitrary_hex(const char *s, struct object_id *oid);
-/*
- * Returns one of GIT_HASH_{SHA1, SHA256, UNKNOWN} based on the value of
- * GIT_TEST_DEFAULT_HASH environment variable. The fallback value in the
- * absence of GIT_TEST_DEFAULT_HASH is GIT_HASH_SHA1. It also uses
- * check(algo != GIT_HASH_UNKNOWN) before returning to verify if the
- * GIT_TEST_DEFAULT_HASH's value is valid or not.
- */
-int init_hash_algo(void);
-
-#endif /* LIB_OID_H */
-- 
2.47.0.86.g15030f9556

