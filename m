Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063F25024E
	for <git@vger.kernel.org>; Wed, 29 May 2024 08:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716969661; cv=none; b=Ck9BBFqMNOHncbrsxBFiPNgFQlHoel2jSDl6Y4NmEhmLAp7XgDrt5LBPFECNCld83r1MGHeT+R/fDrmqNqsB8M1x+pySs3hJfqevXJhTFWGzqj5FZbR43yPq2jl9vbp58ieShs5Tz3R0+lxZvm7/l42Jq3xSoI1YpPCUkqHauAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716969661; c=relaxed/simple;
	bh=iwKOrFNR6cDNtc1aMaW/wseYf6q9aAOumafKe70F9b4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d2YQvWdGDXqXUEwML383Yi93CfWNNeL7GxxH1DEIvAEeJ79wGH27WjmZ/xiDxmIgrTgV/NMAfLYXnCdb4UoTyjdQt8oI5Pmp5SKY42StIx9vW1wRP7Ljohmh7YufmHQBgBE1ouOKDatLBZBaEvrUIzJwfiVTot6Y/T9berxLUw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fMpfsjdp; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fMpfsjdp"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6f8ea3e9543so1315523b3a.2
        for <git@vger.kernel.org>; Wed, 29 May 2024 01:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716969659; x=1717574459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5UYDD4mDlxvpZSgX0uVLlxDuO+NulM+cS1hwgwD4olA=;
        b=fMpfsjdpheWXK4YoXCuxhxus3hieBtF6+O9uLr6puAE/fX1XoxToz1WxCXNp26GfjA
         bsHsPacXYJ9+z7OtaKamFwZomhr8FZ4BM/LmI4P6kRaduipUIgkgN1pE3wEKf4WUZMpl
         OTxjvy1yu0hzv0K1aplDtYZs6W2knXbs5/Y75rMxqbKAsUBQs1jT5ARQncMKfVnRhUwT
         zaSpEXPilNnVe1LqD7P7E2+f1VOwQKUqh31brfYNfbrPaXfaxiziunll6kpbMhLtpPsR
         5CbRuuqWhXvVLng2EXHBB1Hq7V1XoqTCVCRRf1f1H4IA7yd+BsprMrI8Nb0Yxn9CytxP
         CbtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716969659; x=1717574459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5UYDD4mDlxvpZSgX0uVLlxDuO+NulM+cS1hwgwD4olA=;
        b=lVE1BQZ0mn5mUTvC5bb9YuLLZ0gDnYLouW+VjKhibc/NkaVKrjxoEYGyMlREmZ1TCv
         Z4QRdIw2HynkvmOweqvnm9i3AoBkgFiUOScLKlanaIU68ZCt1O5YtBSSkfz4O5PW2j0b
         rNph9S3iqzHu07R45zBysRZIG68+wl68FeODPPPkOJhtaIwNpKhZIVH1xlZWQiaMfgjY
         8MvidtTkx9pJMAHMTL3Z8IEWxbEoq8CCkrGcVZ45SlBarq7VxMhuwulNJ0x6Ga8TupGo
         Nn8m4m/UNm1ARrkW6RGdqybXsiRhGN4M1lvicnptpLSigc+6i45Ntas1eeST5T+NpNkG
         jIDA==
X-Forwarded-Encrypted: i=1; AJvYcCVYsfkdtPZdtguEfKKTTUG8ezDi0RN/iu2ul43pZDiMttz7EHbQ0ZpuCz7QLApu4sRPLM6j1gniTeT4M+KEo3BbWCj5
X-Gm-Message-State: AOJu0YzutzPUpXiCIz8ADo6RjA/ssUTI8V7Bh72mJvviMgtC3oT8oVJI
	3Orua2zTQ+xPzHFPlox5jIaaYkTF5ULdQdduwyCKpVqUO5WyQHse
X-Google-Smtp-Source: AGHT+IFsy9g7zCMVbLcW0oDXprJl7c+pgeSe96ObtJEuPeU5DvfxbgheToXgAC4DLPbF2hDeLRMeZQ==
X-Received: by 2002:a05:6a20:9744:b0:1af:fca1:b692 with SMTP id adf61e73a8af0-1b212d4a38cmr15601126637.35.1716969659017;
        Wed, 29 May 2024 01:00:59 -0700 (PDT)
Received: from localhost.localdomain ([2402:a00:401:a99b:f188:2dd3:d960:a8ab])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f478a651f6sm68290875ad.101.2024.05.29.01.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 01:00:58 -0700 (PDT)
From: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
To: shyamthakkar001@gmail.com
Cc: ach.lumap@gmail.com,
	chriscool@tuxfamily.org,
	christian.couder@gmail.com,
	git@vger.kernel.org,
	gitster@pobox.com,
	kaartic.sivaraam@gmail.com,
	ps@pks.im
Subject: [PATCH v5 2/2] t/: migrate helper/test-{sha1, sha256} to unit-tests/t-hash
Date: Wed, 29 May 2024 13:30:30 +0530
Message-ID: <20240529080030.64410-3-shyamthakkar001@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240529080030.64410-1-shyamthakkar001@gmail.com>
References: <20240526084345.24138-1-shyamthakkar001@gmail.com>
 <20240529080030.64410-1-shyamthakkar001@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

t/helper/test-{sha1, sha256} and t/t0015-hash.sh test the hash
implementation of SHA-1 and SHA-256 in Git with basic hash values.
Migrate them to the new unit testing framework for better debugging
and runtime performance.

The 'sha1' and 'sha256' subcommands are still not removed due to
pack_trailer():lib-pack.sh's reliance on them. The 'sha1' subcommand
is also relied upon by t0013-sha1dc (which requires 'test-tool
sha1' dying when it is used on a file created to contain the
known sha1 attack).

Helped-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Co-authored-by: Achu Luma <ach.lumap@gmail.com>
Signed-off-by: Achu Luma <ach.lumap@gmail.com>
Signed-off-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
---
 Makefile              |  1 +
 t/t0015-hash.sh       | 56 ----------------------------
 t/unit-tests/t-hash.c | 86 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 87 insertions(+), 56 deletions(-)
 delete mode 100755 t/t0015-hash.sh
 create mode 100644 t/unit-tests/t-hash.c

diff --git a/Makefile b/Makefile
index 8f4432ae57..2b19fdf6ae 100644
--- a/Makefile
+++ b/Makefile
@@ -1335,6 +1335,7 @@ THIRD_PARTY_SOURCES += sha1collisiondetection/%
 THIRD_PARTY_SOURCES += sha1dc/%
 
 UNIT_TEST_PROGRAMS += t-ctype
+UNIT_TEST_PROGRAMS += t-hash
 UNIT_TEST_PROGRAMS += t-mem-pool
 UNIT_TEST_PROGRAMS += t-prio-queue
 UNIT_TEST_PROGRAMS += t-strbuf
diff --git a/t/t0015-hash.sh b/t/t0015-hash.sh
deleted file mode 100755
index 0a087a1983..0000000000
--- a/t/t0015-hash.sh
+++ /dev/null
@@ -1,56 +0,0 @@
-#!/bin/sh
-
-test_description='test basic hash implementation'
-
-TEST_PASSES_SANITIZE_LEAK=true
-. ./test-lib.sh
-
-test_expect_success 'test basic SHA-1 hash values' '
-	test-tool sha1 </dev/null >actual &&
-	grep da39a3ee5e6b4b0d3255bfef95601890afd80709 actual &&
-	printf "a" | test-tool sha1 >actual &&
-	grep 86f7e437faa5a7fce15d1ddcb9eaeaea377667b8 actual &&
-	printf "abc" | test-tool sha1 >actual &&
-	grep a9993e364706816aba3e25717850c26c9cd0d89d actual &&
-	printf "message digest" | test-tool sha1 >actual &&
-	grep c12252ceda8be8994d5fa0290a47231c1d16aae3 actual &&
-	printf "abcdefghijklmnopqrstuvwxyz" | test-tool sha1 >actual &&
-	grep 32d10c7b8cf96570ca04ce37f2a19d84240d3a89 actual &&
-	perl -e "$| = 1; print q{aaaaaaaaaa} for 1..100000;" |
-		test-tool sha1 >actual &&
-	grep 34aa973cd4c4daa4f61eeb2bdbad27316534016f actual &&
-	printf "blob 0\0" | test-tool sha1 >actual &&
-	grep e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 actual &&
-	printf "blob 3\0abc" | test-tool sha1 >actual &&
-	grep f2ba8f84ab5c1bce84a7b441cb1959cfc7093b7f actual &&
-	printf "tree 0\0" | test-tool sha1 >actual &&
-	grep 4b825dc642cb6eb9a060e54bf8d69288fbee4904 actual
-'
-
-test_expect_success 'test basic SHA-256 hash values' '
-	test-tool sha256 </dev/null >actual &&
-	grep e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855 actual &&
-	printf "a" | test-tool sha256 >actual &&
-	grep ca978112ca1bbdcafac231b39a23dc4da786eff8147c4e72b9807785afee48bb actual &&
-	printf "abc" | test-tool sha256 >actual &&
-	grep ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad actual &&
-	printf "message digest" | test-tool sha256 >actual &&
-	grep f7846f55cf23e14eebeab5b4e1550cad5b509e3348fbc4efa3a1413d393cb650 actual &&
-	printf "abcdefghijklmnopqrstuvwxyz" | test-tool sha256 >actual &&
-	grep 71c480df93d6ae2f1efad1447c66c9525e316218cf51fc8d9ed832f2daf18b73 actual &&
-	# Try to exercise the chunking code by turning autoflush on.
-	perl -e "$| = 1; print q{aaaaaaaaaa} for 1..100000;" |
-		test-tool sha256 >actual &&
-	grep cdc76e5c9914fb9281a1c7e284d73e67f1809a48a497200e046d39ccc7112cd0 actual &&
-	perl -e "$| = 1; print q{abcdefghijklmnopqrstuvwxyz} for 1..100000;" |
-		test-tool sha256 >actual &&
-	grep e406ba321ca712ad35a698bf0af8d61fc4dc40eca6bdcea4697962724ccbde35 actual &&
-	printf "blob 0\0" | test-tool sha256 >actual &&
-	grep 473a0f4c3be8a93681a267e3b1e9a7dcda1185436fe141f7749120a303721813 actual &&
-	printf "blob 3\0abc" | test-tool sha256 >actual &&
-	grep c1cf6e465077930e88dc5136641d402f72a229ddd996f627d60e9639eaba35a6 actual &&
-	printf "tree 0\0" | test-tool sha256 >actual &&
-	grep 6ef19b41225c5369f1c104d45d8d85efa9b057b53b14b4b9b939dd74decc5321 actual
-'
-
-test_done
diff --git a/t/unit-tests/t-hash.c b/t/unit-tests/t-hash.c
new file mode 100644
index 0000000000..ba785e2d94
--- /dev/null
+++ b/t/unit-tests/t-hash.c
@@ -0,0 +1,86 @@
+#include "test-lib.h"
+#include "hex.h"
+#include "strbuf.h"
+
+static void check_hash_data(const void *data, size_t data_length,
+			    const char *expected_hashes[])
+{
+	if (!check(data != NULL)) {
+		test_msg("BUG: NULL data pointer provided");
+		return;
+	}
+
+	for (size_t i = 1; i < ARRAY_SIZE(hash_algos); i++) {
+		git_hash_ctx ctx;
+		unsigned char hash[GIT_MAX_HEXSZ];
+		const struct git_hash_algo *algop = &hash_algos[i];
+
+		algop->init_fn(&ctx);
+		algop->update_fn(&ctx, data, data_length);
+		algop->final_fn(hash, &ctx);
+
+		if (!check_str(hash_to_hex_algop(hash, algop), expected_hashes[i - 1]))
+			test_msg("result does not match with the expected for %s\n", hash_algos[i].name);
+	}
+}
+
+/* Works with a NUL terminated string. Doesn't work if it should contain a NUL character. */
+#define TEST_HASH_STR(data, expected_sha1, expected_sha256) \
+	do { \
+		const char *expected_hashes[] = { expected_sha1, expected_sha256 }; \
+		TEST(check_hash_data(data, strlen(data), expected_hashes), \
+		     "SHA1 and SHA256 (%s) works", #data); \
+	} while (0)
+
+/* Only works with a literal string, useful when it contains a NUL character. */
+#define TEST_HASH_LITERAL(literal, expected_sha1, expected_sha256) \
+	do { \
+		const char *expected_hashes[] = { expected_sha1, expected_sha256 }; \
+		TEST(check_hash_data(literal, (sizeof(literal) - 1), expected_hashes), \
+		     "SHA1 and SHA256 (%s) works", #literal); \
+	} while (0)
+
+int cmd_main(int argc, const char **argv)
+{
+	struct strbuf aaaaaaaaaa_100000 = STRBUF_INIT;
+	struct strbuf alphabet_100000 = STRBUF_INIT;
+
+	strbuf_addstrings(&aaaaaaaaaa_100000, "aaaaaaaaaa", 100000);
+	strbuf_addstrings(&alphabet_100000, "abcdefghijklmnopqrstuvwxyz", 100000);
+
+	TEST_HASH_STR("",
+		"da39a3ee5e6b4b0d3255bfef95601890afd80709",
+		"e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855");
+	TEST_HASH_STR("a",
+		"86f7e437faa5a7fce15d1ddcb9eaeaea377667b8",
+		"ca978112ca1bbdcafac231b39a23dc4da786eff8147c4e72b9807785afee48bb");
+	TEST_HASH_STR("abc",
+		"a9993e364706816aba3e25717850c26c9cd0d89d",
+		"ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad");
+	TEST_HASH_STR("message digest",
+		"c12252ceda8be8994d5fa0290a47231c1d16aae3",
+		"f7846f55cf23e14eebeab5b4e1550cad5b509e3348fbc4efa3a1413d393cb650");
+	TEST_HASH_STR("abcdefghijklmnopqrstuvwxyz",
+		"32d10c7b8cf96570ca04ce37f2a19d84240d3a89",
+		"71c480df93d6ae2f1efad1447c66c9525e316218cf51fc8d9ed832f2daf18b73");
+	TEST_HASH_STR(aaaaaaaaaa_100000.buf,
+		"34aa973cd4c4daa4f61eeb2bdbad27316534016f",
+		"cdc76e5c9914fb9281a1c7e284d73e67f1809a48a497200e046d39ccc7112cd0");
+	TEST_HASH_STR(alphabet_100000.buf,
+		"e7da7c55b3484fdf52aebec9cbe7b85a98f02fd4",
+		"e406ba321ca712ad35a698bf0af8d61fc4dc40eca6bdcea4697962724ccbde35");
+	TEST_HASH_LITERAL("blob 0\0",
+		"e69de29bb2d1d6434b8b29ae775ad8c2e48c5391",
+		"473a0f4c3be8a93681a267e3b1e9a7dcda1185436fe141f7749120a303721813");
+	TEST_HASH_LITERAL("blob 3\0abc",
+		"f2ba8f84ab5c1bce84a7b441cb1959cfc7093b7f",
+		"c1cf6e465077930e88dc5136641d402f72a229ddd996f627d60e9639eaba35a6");
+	TEST_HASH_LITERAL("tree 0\0",
+		"4b825dc642cb6eb9a060e54bf8d69288fbee4904",
+		"6ef19b41225c5369f1c104d45d8d85efa9b057b53b14b4b9b939dd74decc5321");
+
+	strbuf_release(&aaaaaaaaaa_100000);
+	strbuf_release(&alphabet_100000);
+
+	return test_done();
+}
-- 
2.45.1

