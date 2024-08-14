Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75861B0107
	for <git@vger.kernel.org>; Wed, 14 Aug 2024 12:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723637543; cv=none; b=MU+my4G/oRlj956hiBb24O6KZU5HJ9rb4eUJJyS0Rdcm9fxvwECxAL5mUaQU4jI9N1dfWU4XV5nS7XMmWLNPkV8IQjQg9JcYSE3e05lKu4EPD+E7Kd1lPiMGGJK3DLdeR9n5fpxjNQ508WpjV2iA7TmcS5Liam5twWVgl1vowyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723637543; c=relaxed/simple;
	bh=1smM/cAQL8nw54vdniZByCCCLuflaeq0PrwTE6hutPc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ehOeIS6ARZMh+AU2kX65W94IsQuUis/nMB1busvwTvzQL4Aee1e7GTVKKccQ4xZgPeZ9gPqiI4X3vVlEsTfl3UTCZ36Gir922THgw1Z+yeTGV10NIzYcl4HuSucoc8YNj1cTocT2lKeHbfiTVr5ScjGHLD9/XR4v5SqZtjUbpAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jKerikQY; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jKerikQY"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-70d2b921cd1so5986200b3a.1
        for <git@vger.kernel.org>; Wed, 14 Aug 2024 05:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723637541; x=1724242341; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4xrFjut8JjgOetgEstqcCA9rNOpSVMl67RvsAlmxJzU=;
        b=jKerikQYy7WI5L+R6lPH7aLXx0yBEveLfzW9KzECWOJlmxbzMYoy3qViNh9/QeOGDc
         cKMWKsMjGjvbCr9Z16DetaphbUXCvfTBmglis5k/hQG3AIoDemhSAhOqJFtUSDvUyYjK
         Qi2kkNtRJWYCprqCFDkY7KtnLWBrhKDdLSpg1cANXmp5F87SroomtSZ8l0YB36sv7rfO
         S8usUANqCmqJpsMO+xl6vKxlRdFXJe+wjJTJWn585PyApjbr4XaUqPzSttU+/SlW8Ht9
         RyRdir94lsrBISVbVoVD/g+eJZoVrrcOAPtm0GJ3obJH1/udb+h95dCyuY1H0hsriKso
         6Udw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723637541; x=1724242341;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4xrFjut8JjgOetgEstqcCA9rNOpSVMl67RvsAlmxJzU=;
        b=IWzTvskEKz9Ylw8hRwK+DNpARxy4ACw+L+tW9Pzqi1l5jrJTinEfW3KsmNBN1DKHQj
         B4YB+YqX8GabGsz3aIkjSkipAqq6TjI7I4R/hv638/tzPihbniHUjqvPgcK7bU9t0jYM
         +UZ8GmWTdYVev6akYDMIHTgMhQACiw8M6udsGJgGFx+Izd08iWmpa3WtmFiBMXA2jcQ/
         26oqx2Ypgym69vHGHLIhVzskpEc5E+t6s1pLNDUZK3nnjE1/Yac6iSWzhUOg3XBUvFSw
         2BehYajALa4nGSryXLKNosN6QMan5nV6c2M+JJYOd6UM4AKf8ZNm8aMJKfJgWK7ysL6y
         CSdg==
X-Gm-Message-State: AOJu0YxEDFcsL9uWjyre5EOrT4FHtEQ08xza9G2oizQTuu4rzkpObYoD
	JyNA0/ueFTOEu1Fo2k9c2C6OTEY2tVaLWECP/OmadRtr6V5eJnYtQcfMUlpsv+w=
X-Google-Smtp-Source: AGHT+IHvJVgaiqO1yGxIsPfXWf4rlMd+TbRL+IvLO6eVFXI/txEuDJCKn8eWkHgYcqRp3TVrhyEoLQ==
X-Received: by 2002:a05:6a21:b8a:b0:1c6:edfb:431f with SMTP id adf61e73a8af0-1c8eaf8c17bmr3114683637.44.1723637540604;
        Wed, 14 Aug 2024 05:12:20 -0700 (PDT)
Received: from Ubuntu.. ([106.205.236.194])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-710e5875200sm7195450b3a.37.2024.08.14.05.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 05:12:20 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 05/10] t-reftable-block: use block_iter_reset() instead of block_iter_close()
Date: Wed, 14 Aug 2024 17:33:13 +0530
Message-ID: <20240814121122.4642-6-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240814121122.4642-1-chandrapratap3519@gmail.com>
References: <20240814121122.4642-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

block_iter_reset() restores a block iterator to its state at the time
of initialization without freeing any memory while block_iter_close()
deallocates the memory for the iterator.

In the current testing setup, a block iterator is allocated and
deallocated for every iteration of a loop, which hurts performance.
Improve upon this by using block_iter_reset() at the start of each
iteration instead. This has the added benifit of testing
block_iter_reset(), which currently remains untested.

Similarly, remove reftable_record_release() for a reftable record
that is still in use.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 t/unit-tests/t-reftable-block.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/t/unit-tests/t-reftable-block.c b/t/unit-tests/t-reftable-block.c
index 0d73fb98d6..dfb7262a65 100644
--- a/t/unit-tests/t-reftable-block.c
+++ b/t/unit-tests/t-reftable-block.c
@@ -76,11 +76,8 @@ static void t_block_read_write(void)
 		j++;
 	}
 
-	reftable_record_release(&rec);
-	block_iter_close(&it);
-
 	for (i = 0; i < N; i++) {
-		struct block_iter it = BLOCK_ITER_INIT;
+		block_iter_reset(&it);
 		reftable_record_key(&recs[i], &want);
 
 		n = block_iter_seek_key(&it, &br, &want);
@@ -98,11 +95,10 @@ static void t_block_read_write(void)
 		n = block_iter_next(&it, &rec);
 		check_int(n, ==, 0);
 		check(reftable_record_equal(&recs[10 * (i / 10)], &rec, GIT_SHA1_RAWSZ));
-
-		block_iter_close(&it);
 	}
 
 	block_reader_release(&br);
+	block_iter_close(&it);
 	reftable_record_release(&rec);
 	reftable_block_done(&br.block);
 	strbuf_release(&want);
-- 
2.45.GIT

