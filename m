Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D269618D648
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 14:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722954061; cv=none; b=Stig30NYHba6OBYJ8eohgUp2JP5mYDM2Ao+SHqA/PZytY9oVSXZ7SE/W/nep8kFHfUPCf/V92ITICXX9Q8nbRKLu4q+gXnS9lvLWBV7LnsVplzuVBNcygRC5X5yZB6TVMGjDh7KTiVPf4B9FVVwH6LBARtXMH8eO7y+Ci8ZTxZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722954061; c=relaxed/simple;
	bh=ybJ2xtykgebCTatZBuEeLCEpAvoHdTasXIwdbz/Wwqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IgsoG29/01sVFBQpdjshhtrbt5Y/sWg8Fo+0nB6LqDpsOR5i/YZHPQWUopriTdadGDte5ucjLVaChSCAii3IHON4sZugrifSiIMpLjhGL51/pWJizPb4ywYxVueGVD6q91iR6WEt8Baby+EKbCYNVZHPLPs9wu9Zd9M8oWA8pyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RzPPckuM; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RzPPckuM"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-710887a8083so518116b3a.0
        for <git@vger.kernel.org>; Tue, 06 Aug 2024 07:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722954059; x=1723558859; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z8w6SZ0MvriHWod+NEqxC9OqroeN7udMheOXVRQCekQ=;
        b=RzPPckuMlUZvfEjG8zcxt0JC9LVph8/nLbX9jkTEM4tWFHECol0tdfvCCXIbAdjNCB
         Ywt9BRxZQDeRzMWF1yHBHX3yN64oXSY/uvOz2ELQSUE8FTYBZNegG6QgR1fMIapqufXx
         ObeQOGNzmnLrjMIwY/Pf9O8ZR7tHmKDqUvzM/Di0+uet0wNcSDXAtbcwY+JNS4i4dWjZ
         E1lutRSOSognGPvE6EC+7aLyOU67z+d6A/LtKXTLLder+KNI7OXeiTH7JOf276Ai6b4C
         dYuj8EgPRw8SfaZU1NLae6KrAbcDLLLaK/woRJUdqxoXbalgTH8Jn056xSDeySUvc674
         trmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722954059; x=1723558859;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z8w6SZ0MvriHWod+NEqxC9OqroeN7udMheOXVRQCekQ=;
        b=Xdu7nEVKOkNWEU0DsQuQrQiTAR8vnFoPmFtkUMZp14T0YR1SWvDnnAFoPDcrqQ+vAo
         O6756LDO7HuPRaPqKEDgwJDXPy3j/anX6LQkxZPshEY+K5PMuxHqlQEJ1mSZ5QqScBab
         UPUQC636P4xllU1ibpKzqDxjHYzZ20ZC5thJRRTRjcRi8M6gG711eVsuSTrzo3ZEwG7K
         9KCRccanA55snviw2ZHBgxNDH2PzpmP2Jsdx8yflMPq/HReK9r1Lsjh+9p/i72OXg6p+
         0PN8v3Dhy+PwtJ6a9ozuGGtMpy0dUWyaduPMP//fVGX57K2D5vANEC3uf4qA0owR6KPA
         eS2g==
X-Gm-Message-State: AOJu0YxthaonuYRawzxqvHaOauIsEG2CBK6cJm69WiHNR6LKVwTlj1Mn
	eCokmWzwNhc6OLTtl6WwQaumpiY1TWvfM9HC3/+byyBICyXGm7HiQprPWTEF2tdWqg==
X-Google-Smtp-Source: AGHT+IEzh6mFe8c3isVFW/qxaQ9Vd9KJ5PXW+xScRPMa7afMMxXeyJOKHD8Jq8f5JgW3NGmiDhr7BA==
X-Received: by 2002:a05:6a20:439e:b0:1c0:7ec3:c7ae with SMTP id adf61e73a8af0-1c699628d27mr14719527637.47.1722954058635;
        Tue, 06 Aug 2024 07:20:58 -0700 (PDT)
Received: from Ubuntu.. ([27.59.87.1])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7106ec416aasm7040563b3a.70.2024.08.06.07.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 07:20:58 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 5/6] t-reftable-stack: add test for non-default compaction factor
Date: Tue,  6 Aug 2024 19:43:41 +0530
Message-ID: <20240806142020.4615-6-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240806142020.4615-1-chandrapratap3519@gmail.com>
References: <20240806142020.4615-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In a recent codebase update (commit ae8e378430, merge branch
'ps/reftable-write-options', 2024/05/13) the geometric factor used
in auto-compaction of reftable tables was made configurable. Add
a test to verify the functionality introduced by this update.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 t/unit-tests/t-reftable-stack.c | 41 +++++++++++++++++++++++++++++----
 1 file changed, 37 insertions(+), 4 deletions(-)

diff --git a/t/unit-tests/t-reftable-stack.c b/t/unit-tests/t-reftable-stack.c
index 0c15e654e8..5228872450 100644
--- a/t/unit-tests/t-reftable-stack.c
+++ b/t/unit-tests/t-reftable-stack.c
@@ -808,12 +808,12 @@ static void t_empty_add(void)
 	reftable_stack_destroy(st2);
 }
 
-static int fastlog2(uint64_t sz)
+static int fastlogN(uint64_t sz, uint64_t N)
 {
 	int l = 0;
 	if (sz == 0)
 		return 0;
-	for (; sz; sz /= 2)
+	for (; sz; sz /= N)
 		l++;
 	return l - 1;
 }
@@ -846,11 +846,43 @@ static void t_reftable_stack_auto_compaction(void)
 
 		err = reftable_stack_auto_compact(st);
 		check(!err);
-		check(i < 3 || st->merged->stack_len < 2 * fastlog2(i));
+		check(i < 2 || st->merged->stack_len < 2 * fastlogN(i, 2));
 	}
 
 	check_int(reftable_stack_compaction_stats(st)->entries_written, <,
-		 (uint64_t)(N * fastlog2(N)));
+		 (uint64_t)(N * fastlogN(N, 2)));
+
+	reftable_stack_destroy(st);
+	clear_dir(dir);
+}
+
+static void t_reftable_stack_auto_compaction_factor(void)
+{
+	struct reftable_write_options opts = {
+		.auto_compaction_factor = 5,
+	};
+	struct reftable_stack *st = NULL;
+	char *dir = get_tmp_dir(__LINE__);
+	int err;
+	size_t N = 100;
+
+	err = reftable_new_stack(&st, dir, &opts);
+	check(!err);
+
+	for (size_t i = 0; i < N; i++) {
+		char name[20];
+		struct reftable_ref_record ref = {
+			.refname = name,
+			.update_index = reftable_stack_next_update_index(st),
+			.value_type = REFTABLE_REF_VAL1,
+		};
+		xsnprintf(name, sizeof(name), "branch%04"PRIuMAX, (uintmax_t)i);
+
+		err = reftable_stack_add(st, &write_test_ref, &ref);
+		check(!err);
+
+		check(i < 5 || st->merged->stack_len < 5 * fastlogN(i, 5));
+	}
 
 	reftable_stack_destroy(st);
 	clear_dir(dir);
@@ -1009,6 +1041,7 @@ int cmd_main(int argc, const char *argv[])
 	TEST(t_reftable_stack_add_one(), "add a single ref record to stack");
 	TEST(t_reftable_stack_add_performs_auto_compaction(), "addition to stack triggers auto-compaction");
 	TEST(t_reftable_stack_auto_compaction(), "stack must form geometric sequence after compaction");
+	TEST(t_reftable_stack_auto_compaction_factor(), "auto-compaction with non-default geometric factor");
 	TEST(t_reftable_stack_auto_compaction_fails_gracefully(), "failure on auto-compaction");
 	TEST(t_reftable_stack_compaction_concurrent(), "compaction with concurrent stack");
 	TEST(t_reftable_stack_compaction_concurrent_clean(), "compaction with unclean stack shutdown");
-- 
2.45.GIT

