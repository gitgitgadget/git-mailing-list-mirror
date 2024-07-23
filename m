Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA16615351B
	for <git@vger.kernel.org>; Tue, 23 Jul 2024 14:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721745208; cv=none; b=n1JGoeUhyptppjFoC8SPvzdR5BmSacbe0zNFtj0KZQHKp0b3QlurrL/rL9pnFvibOvQVQ1fCQRModv+/qHuqstOih+xkh54SWvvyOCY72w8EWYpyXvxYvSp+5eGW1M5muF7EIUKkqBGw/d9xJZ4/am+H/nyWX2QE9POhn47wvds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721745208; c=relaxed/simple;
	bh=R29cgDnjxTJhmO6Mv1rjS1yQqT5SrGF2kr1Lfatc/uc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pD/cXzFM8SwGjnuj2pmWnFl4m6V4w7rKxQcGq/8egpuu/MOLoJ/VCSYOtxWvEE9sQXBdOBPPQm3+fiKE/oXzkxRn2NEmQtn1WT890A1Eeyq6hqAcTe+QCJ1I2lmLc8kRitR6iU/ZLWoaaFiGQpH1zkaXp2rtP+JhEufi7/S3eU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IQ366IiV; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IQ366IiV"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1fc692abba4so7115285ad.2
        for <git@vger.kernel.org>; Tue, 23 Jul 2024 07:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721745206; x=1722350006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d3WTk9ZUGTxWd0TmHrFF3eGJIwC1j72BS3dqj0Qqk6g=;
        b=IQ366IiVk3+s0GZYxU/Qz+coquDcq3uirR/Ndzqcwsc+z7Yw9BTOfhGtV8U7WICbTM
         b6H+bYSR7JG7SwPAeQ7qwQQ7KJ0TvavDhH2b5M+mOrb1nLbQlA8/SAPaNS/kM/sJa4Vt
         P1KmBMfPu+s28QrY6a9zrk6dJO9E4sF+x7JgDMTxbBXsp+0Ve1LFF99pSDfS1xyEEwkJ
         KWRmB2Plj0tV6lLhHc0XVhesCFZyEEBTFub9uhPQ9XLUwgLjHcrZJ+wuebEnT13BHwwz
         /06XlhbQOrmVwfykCaduGvgcbaaZJCQpjkKcyKXZBMnXAzZEZ1dOwqxiHoZWxZlMHjFv
         v56A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721745206; x=1722350006;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d3WTk9ZUGTxWd0TmHrFF3eGJIwC1j72BS3dqj0Qqk6g=;
        b=jXaNqau5H8X1kG9+X2xGsE7ER5KoIITsTS0FVDL67hklYJ2ZUyZMb/lIqRFWpJPmA3
         yeL8mMttfA+5pGA8wY1J+SOcfgCsdpyoDeZQfAJNyARDO6bUF9BBfVjJ9/XiYY3tg3Qp
         INmLRIidGjhMPfk8zFXaQmoTVMkhwAasKNoe8JzzWD9KdNSwRM0LGbTB51+RtZhAK4/l
         VRztUg+n9ToKNn+kg97odtVzHoJaviGt/4rZ0r1QIDXfnYXO+zFCfC7kVgiC/24s6vJg
         NAy9Wxdi2VK8XEF7EbWnWBUCmqUCsgAoBunuODwGbRlwkxYvjTJFuIXtIKKgysd4TiOn
         s2OQ==
X-Gm-Message-State: AOJu0Yzyn9zIHnOcoE3P2d1sq4LDmMO/L/d1cS6uBPnPh/l3xvfwMair
	mCUXuKypLoVE8lbIIFva1miWOwfBR/BBHFyLbCVa5XOQ3Zl2P0Bj+arC05+LZQI=
X-Google-Smtp-Source: AGHT+IGPx2F1HxbXdI/yygMVq0/AOmiDL9ccWmwoeVosjByPawj0MOrkup2S4KOzToFgMp9fWzuPrw==
X-Received: by 2002:a17:902:ec83:b0:1fd:acd1:b63a with SMTP id d9443c01a7336-1fdacd1b921mr40594495ad.50.1721745205668;
        Tue, 23 Jul 2024 07:33:25 -0700 (PDT)
Received: from Ubuntu.. ([223.176.63.81])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1fd6f256c09sm75301305ad.2.2024.07.23.07.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 07:33:25 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v5 6/7] t-reftable-pq: add test for index based comparison
Date: Tue, 23 Jul 2024 19:47:16 +0530
Message-ID: <20240723143032.4261-7-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240723143032.4261-1-chandrapratap3519@gmail.com>
References: <20240614095136.12052-1-chandrapratap3519@gmail.com>
 <20240723143032.4261-1-chandrapratap3519@gmail.com>
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
 t/unit-tests/t-reftable-pq.c | 43 ++++++++++++++++++++++++++++++++++--
 1 file changed, 41 insertions(+), 2 deletions(-)

diff --git a/t/unit-tests/t-reftable-pq.c b/t/unit-tests/t-reftable-pq.c
index 9230dd9b9e..23c3f6888b 100644
--- a/t/unit-tests/t-reftable-pq.c
+++ b/t/unit-tests/t-reftable-pq.c
@@ -18,7 +18,7 @@ static void merged_iter_pqueue_check(const struct merged_iter_pqueue *pq)
 	}
 }
 
-static void t_pq(void)
+static void t_pq_record(void)
 {
 	struct merged_iter_pqueue pq = { 0 };
 	struct reftable_record recs[54];
@@ -59,9 +59,48 @@ static void t_pq(void)
 	merged_iter_pqueue_release(&pq);
 }
 
+static void t_pq_index(void)
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
-	TEST(t_pq(), "pq works");
+	TEST(t_pq_record(), "pq works with record-based comparison");
+	TEST(t_pq_index(), "pq works with index-based comparison");
 
 	return test_done();
 }
-- 
2.45.GIT

