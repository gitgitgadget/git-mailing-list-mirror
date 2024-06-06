Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8094613C839
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 07:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717660648; cv=none; b=Ymx+hvEC5OFhmQvkbMq30VurkLZrk/WLZRA1dgOK2/p7Zb9eu8H2VVloNe1uGEthEIaNq0kzUamZwuemEQJq2MQ1b+dOB+u8BmY6D+xWn101cZnvZrriKz5M0jy+BntQ3PXmKihklToij1ktXtkMbVGAj3exrWvaSmSi4gZtw6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717660648; c=relaxed/simple;
	bh=xXngqgh62RZ/0fbXn8qQInGgMtHxNDVVRPdYlYvxIAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MkkuXMf9wIKEneCCsHEhuabqbWLY2P7sG8L4lI0lMyToqwAuwQBVOZCkmgFikvkQKONDnQzIJ6JDHwziUwVSGdkkbnpuQU65/+c4a/9ucLE3td71Al5VNnDtA24s2kaCYRLE7JA9whQJ7vKGcFxxMqjhKew7V5rC3rwJ+76QIlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B19wqniO; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B19wqniO"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1f6c7cded01so153015ad.0
        for <git@vger.kernel.org>; Thu, 06 Jun 2024 00:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717660647; x=1718265447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WSqITE4lscpEpiyPN4IT3WNL1I4RvWn06OSc1XrW0Oc=;
        b=B19wqniO+aRRCIXj8FEACHMWfpB6obsHlCXLW5pftjeadI4IhD2XOAcyzGxzEgI0f0
         Wru78Sl/0BBuaF7kTK1KbW539oN+Q795IezdeIHIrT2z8YTxR/ICNbynQUh8X+Nhu29u
         csQ8th3rn9d9Mab53Vd4eUdSjboWI/EvQ+snlJ++M0v1R7066mwAf5jfiNm4uSWq39YZ
         LBlwU/6b6qBq9LxqvwVk35KZmavt9aqrYggX2mQAgc1kQ/e1LX83k3SWj4haU+tdN69p
         eynRVqMIiAv4vExckZ5O2O+z6NPmjn6xzzITy54Dfx6FqW1K3z85qBkvvwIOspWrlKIS
         lgSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717660647; x=1718265447;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WSqITE4lscpEpiyPN4IT3WNL1I4RvWn06OSc1XrW0Oc=;
        b=MAwN9e90k4o7QD75pKfqaHukBPFjXXqpSZh+aT+FrIegh33KX1NOPbllBE1Ue7ejBF
         zM/kgqcdWUTWZd1ZaI4nCn2f2PRV8QW7wM55TlkJRtMOvgy3wx10pWJEeFUSiVwK+9ap
         1/VphCKj3nc8GEPtWI0QppSRtJt+8tR/xLi3K52r16AoZ5jHB163lVBZ98v/xmDHLqrn
         XBnAawbD/on2Gg2Qso0uORYA2B+5nhbLoWG1+cy8a2xGR6Ss9+Lrnba/QQG2MrpEOkzC
         ICpVqBPB4/AR1dbmXOv9Y8ANMHmOgJ0IvBOyfEFKOt9HXMsfExw7do/Gx5w5F0Ts1eW/
         XQNw==
X-Gm-Message-State: AOJu0YyfhgH2MWwtgGe05Kb1l2/MXHSrHG346EXr2nGFzgwKfSYujhrR
	uJEwyevUfuRAt4ST5+qsu56fJIxB8Hf2Cpl4zMK9a2yK+MC0n/VcBS68kKYw
X-Google-Smtp-Source: AGHT+IGdBqAf1NET++Ib0lK/igG+qOa0PqPpq88cSELdstYJDDLuppfk/UEMqc7Fp5ojMC+lOkg1cg==
X-Received: by 2002:a17:902:d511:b0:1f4:7713:8f6 with SMTP id d9443c01a7336-1f6a5a5a85fmr60960235ad.52.1717660646600;
        Thu, 06 Jun 2024 00:57:26 -0700 (PDT)
Received: from Ubuntu.. ([27.61.69.112])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1f6bd7ed6b2sm8192415ad.246.2024.06.06.00.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 00:57:25 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [GSoC][PATCH 5/6] t-reftable-pq: add test for index based comparison
Date: Thu,  6 Jun 2024 13:10:49 +0530
Message-ID: <20240606075601.6989-6-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.2.404.g9eaef5822c
In-Reply-To: <20240606075601.6989-1-chandrapratap3519@gmail.com>
References: <20240606075601.6989-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When comparing two entries, the priority queue as defined by
reftable/pq.{c, h} first compares the entries on the basis of
their ref-record's keys. If the keys turn out to be equal, the
comparison is then made on the basis of their update indices
(which are never equal).

In the current testing setup, only the case for comparison on
the basis of ref-record's keys is exercised. Add a test for
index-based comparison as well. Rename the existing test to
reflect its nature of only testing record-based comparison.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 t/unit-tests/t-reftable-pq.c | 44 ++++++++++++++++++++++++++++++++++--
 1 file changed, 42 insertions(+), 2 deletions(-)

diff --git a/t/unit-tests/t-reftable-pq.c b/t/unit-tests/t-reftable-pq.c
index 30bf9cb492..6f6bf58307 100644
--- a/t/unit-tests/t-reftable-pq.c
+++ b/t/unit-tests/t-reftable-pq.c
@@ -18,7 +18,7 @@ static void merged_iter_pqueue_check(const struct merged_iter_pqueue *pq)
 	}
 }
 
-static void test_pq(void)
+static void test_pq_record(void)
 {
 	struct merged_iter_pqueue pq = { 0 };
 	struct reftable_record recs[54];
@@ -59,9 +59,49 @@ static void test_pq(void)
 	merged_iter_pqueue_release(&pq);
 }
 
+
+static void test_pq_index(void)
+{
+	struct merged_iter_pqueue pq = { 0 };
+	struct reftable_record recs[14];
+	char *last = NULL;
+	size_t N = ARRAY_SIZE(recs), i;
+
+	for (i = 0; i < N; i++) {
+		reftable_record_init(&recs[i], BLOCK_TYPE_REF);
+		recs[i].u.ref.refname = xstrdup("refs/heads/master");
+	}
+
+	for (i = 0; i < N; i++) {
+		struct pq_entry e = {
+			.rec = &recs[i],
+			.index = i,
+		};
+
+		merged_iter_pqueue_add(&pq, &e);
+		merged_iter_pqueue_check(&pq);
+	}
+
+	for (i = N - 1; !merged_iter_pqueue_is_empty(pq); i--) {
+		struct pq_entry e = merged_iter_pqueue_remove(&pq);
+		merged_iter_pqueue_check(&pq);
+
+		check(reftable_record_type(e.rec) == BLOCK_TYPE_REF);
+		check_int(e.index, ==, i);
+		if (last)
+			check_str(last, e.rec->u.ref.refname);
+		last = e.rec->u.ref.refname;
+	}
+
+	for (i = 0; i < N; i++)
+		reftable_record_release(&recs[i]);
+	merged_iter_pqueue_release(&pq);
+}
+
 int cmd_main(int argc, const char *argv[])
 {
-	TEST(test_pq(), "pq works");
+	TEST(test_pq_record(), "pq works with record-based comparison");
+	TEST(test_pq_index(), "pq works with index-based comparison");
 
 	return test_done();
 }
-- 
2.45.2.404.g9eaef5822c

