Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC9D199FAE
	for <git@vger.kernel.org>; Wed, 21 Aug 2024 12:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724244163; cv=none; b=QqqG8Y0NYpII4IcsKmXKifVbc2lE2TirS8UrJHQLtDpUsuAiAITAhiZpDUF0kef8gpMDEQGvPT9Yn7m5J4aty2aktNeKNQhd+rEFH2ujuyNBppq6d7gqXGW5mQS1r4rLriG80wC0ro9ut2Lq+02tg+MKBX2Vcmjv1dtnAVREHF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724244163; c=relaxed/simple;
	bh=Hd4wOug/0b1JQdE7wz2KGghHzvolfW+D+YQltMKcWrA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s2VMcU0gAAeHyF/uE/gCKqQSD6jjdPoHzcWp6ybDVAL37+2Hp4diwI768pI83Q66xyl6cu3ZjF+OsAxRRIbZlp31wV6ZBB4Q2n4Tj6KBwYajgBFTYzL9XWiU5PcUdz/tN/2bfJND1MP6rhyOWG583mcrpgKweowZRTGo0/0o8GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eg4DSkau; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eg4DSkau"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7c3d9a5e050so4261109a12.2
        for <git@vger.kernel.org>; Wed, 21 Aug 2024 05:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724244161; x=1724848961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=frzvWvpMMvPReCU9NkAAFFb+E44xKvgtTgqnqaYEuXg=;
        b=eg4DSkauvFXcT9WsFurm/fFylpJOC89EIpg95ljJnowIHum2+/UvPHO/Tq0Zx7SPgO
         MRGYfZxPh1QfpFHOL55SfzrbivV3VaNKQeI3YPdHwwWt+BaYYH/sbsMUqaWOynsWMiei
         hqpri5gJseZdF3KVszBJTZ1VsrEAMDtY2kP+YfPkv45q2dinIiVkvSxyw/DPICgyUjOh
         wp6j0vNiSp/qucMJ+tlEGYMFAHULMpOmkAsTzvcck7jxnP1DnE89B7Bv9gbNEbv2aOR1
         HNy+rbALbFLp0rTI7YzMNsgCucfqNrmTSj5rwO5v9aZNDRnomKsp5xp8tZ/rgI6DtpWa
         ZzHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724244161; x=1724848961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=frzvWvpMMvPReCU9NkAAFFb+E44xKvgtTgqnqaYEuXg=;
        b=ed9PqR3DX4tdsXNFq7gk5ax850Qut7uoTGesTprjFxu/ARuR6QD59/Xb4xI5ocApdh
         70wlE/+6u0STcTMYybizit90RqGiflbwyU4t8u7corlhuVnFaKeNwaicw6lthekQ0x16
         7VK2w7QMdy5mBCovw9yHVBLMu0OYqETSy8f/gtH75ePjnqa4Iw11qdJN4HUNdGfxifue
         pguRwTY6bFq8857viN2E1Tle+SHAnp5R1aLfl2oZ/+WTO6j9PROV5wXkNEIGe32rcSb1
         xN5tczuf8DRs57Ipep2WvsL5xFNdJ6TostREssc7oUlkzrz9ATQ9hdhf/tqVESb8UMnv
         0yuQ==
X-Gm-Message-State: AOJu0YzU9+x9N/vct3zwTDB2duWF3hutZ2wQZ65cRROsPr4NjMC5MAuo
	gL8qeECV4khckAaaQ8AiJD79Bvd3PCEkmpOf/b9F5IHhQRm6xf7f6ShYY5Xr
X-Google-Smtp-Source: AGHT+IEd50VbjaQ5nAdED2oLNeVa5bF+Dxj4RzQnBcMC9t+5usc+hplVk9fqWSnuuppuV+ICzgyVCQ==
X-Received: by 2002:a05:6a20:6b9e:b0:1ca:da95:d49b with SMTP id adf61e73a8af0-1cada95d6bfmr1705813637.2.1724244160907;
        Wed, 21 Aug 2024 05:42:40 -0700 (PDT)
Received: from Ubuntu.. ([27.59.95.0])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2d5ebba8853sm1670963a91.56.2024.08.21.05.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 05:42:40 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 09/11] t-reftable-block: add tests for log blocks
Date: Wed, 21 Aug 2024 18:00:59 +0530
Message-ID: <20240821124150.4463-10-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240821124150.4463-1-chandrapratap3519@gmail.com>
References: <20240816175414.5169-1-chandrapratap3519@gmail.com>
 <20240821124150.4463-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the current testing setup, block operations are only exercised
for ref blocks. Add another test that exercises these operations
for log blocks as well.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 t/unit-tests/t-reftable-block.c | 93 ++++++++++++++++++++++++++++++++-
 1 file changed, 91 insertions(+), 2 deletions(-)

diff --git a/t/unit-tests/t-reftable-block.c b/t/unit-tests/t-reftable-block.c
index 6aa86a3edf..4c4fb39ab4 100644
--- a/t/unit-tests/t-reftable-block.c
+++ b/t/unit-tests/t-reftable-block.c
@@ -12,7 +12,7 @@ license that can be found in the LICENSE file or at
 #include "reftable/constants.h"
 #include "reftable/reftable-error.h"
 
-static void t_block_read_write(void)
+static void t_ref_block_read_write(void)
 {
 	const int header_off = 21; /* random */
 	struct reftable_record recs[30];
@@ -103,9 +103,98 @@ static void t_block_read_write(void)
 		reftable_record_release(&recs[i]);
 }
 
+static void t_log_block_read_write(void)
+{
+	const int header_off = 21;
+	struct reftable_record recs[30];
+	const size_t N = ARRAY_SIZE(recs);
+	const size_t block_size = 2048;
+	struct reftable_block block = { 0 };
+	struct block_writer bw = {
+		.last_key = STRBUF_INIT,
+	};
+	struct reftable_record rec = {
+		.type = BLOCK_TYPE_LOG,
+	};
+	size_t i = 0;
+	int ret;
+	struct block_reader br = { 0 };
+	struct block_iter it = BLOCK_ITER_INIT;
+	struct strbuf want = STRBUF_INIT, buf = STRBUF_INIT;
+
+	REFTABLE_CALLOC_ARRAY(block.data, block_size);
+	block.len = block_size;
+	block_source_from_strbuf(&block.source ,&buf);
+	block_writer_init(&bw, BLOCK_TYPE_LOG, block.data, block_size,
+			  header_off, hash_size(GIT_SHA1_FORMAT_ID));
+
+	for (i = 0; i < N; i++) {
+		rec.u.log.refname = xstrfmt("branch%02"PRIuMAX , (uintmax_t)i);
+		rec.u.log.update_index = i;
+		rec.u.log.value_type = REFTABLE_LOG_UPDATE;
+
+		recs[i] = rec;
+		ret = block_writer_add(&bw, &rec);
+		rec.u.log.refname = NULL;
+		rec.u.log.value_type = REFTABLE_LOG_DELETION;
+		check_int(ret, ==, 0);
+	}
+
+	ret = block_writer_finish(&bw);
+	check_int(ret, >, 0);
+
+	block_writer_release(&bw);
+
+	block_reader_init(&br, &block, header_off, block_size, GIT_SHA1_RAWSZ);
+
+	block_iter_seek_start(&it, &br);
+
+	for (i = 0; ; i++) {
+		ret = block_iter_next(&it, &rec);
+		check_int(ret, >=, 0);
+		if (ret > 0) {
+			check_int(i, ==, N);
+			break;
+		}
+		check(reftable_record_equal(&recs[i], &rec, GIT_SHA1_RAWSZ));
+	}
+
+	for (i = 0; i < N; i++) {
+		block_iter_reset(&it);
+		strbuf_reset(&want);
+		strbuf_addstr(&want, recs[i].u.log.refname);
+
+		ret = block_iter_seek_key(&it, &br, &want);
+		check_int(ret, ==, 0);
+
+		ret = block_iter_next(&it, &rec);
+		check_int(ret, ==, 0);
+
+		check(reftable_record_equal(&recs[i], &rec, GIT_SHA1_RAWSZ));
+
+		want.len--;
+		ret = block_iter_seek_key(&it, &br, &want);
+		check_int(ret, ==, 0);
+
+		ret = block_iter_next(&it, &rec);
+		check_int(ret, ==, 0);
+		check(reftable_record_equal(&recs[10 * (i / 10)], &rec, GIT_SHA1_RAWSZ));
+	}
+
+	block_reader_release(&br);
+	block_iter_close(&it);
+	reftable_record_release(&rec);
+	reftable_block_done(&br.block);
+	strbuf_release(&want);
+	strbuf_release(&buf);
+	for (i = 0; i < N; i++)
+		reftable_record_release(&recs[i]);
+}
+
 int cmd_main(int argc, const char *argv[])
 {
-	TEST(t_block_read_write(), "read-write operations on blocks work");
+	TEST(t_log_block_read_write(), "read-write operations on log blocks work");
+	TEST(t_ref_block_read_write(), "read-write operations on ref blocks work");
 
 	return test_done();
 }
-- 
2.45.GIT

