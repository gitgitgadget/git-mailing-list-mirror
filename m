Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000D8174EFC
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 08:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718094785; cv=none; b=LY9acveQR4nLwmGnJMKEIxZxgngiCLkYkzfkKaQXC1A2Fm5c296ynRet+hqT1nMo1tWCARyHVvDKYMx7Qvmn3a5rVgyG7ZBn4Kg+ZdkUUiLpTroCKSvaj4kGseJ20iV4lm2O9W6cfIWq6jg/+eT8pc5QacsnV9z8jrQW98Lcllc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718094785; c=relaxed/simple;
	bh=eziVbiL0LUGaEg6d4C+WXfmKilNXwroxU5hjbTdR3E8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pr2k3qNvtBVj3az2yIbKCxcLMql6BOYiDhDq13VIEXdtuDrzSwEzhIsHQdwvekr60YMrsh4vjTHN9BOpWGzfojNHbipXSXTgbjc861TJr41ET027yO9woHQiGLpzmJXpMavc/n8tHxPwXIO579sxiTUm//S6Rtsn3WOLLUDmb7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xh75z/8x; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xh75z/8x"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6f9b5bc97baso954730a34.0
        for <git@vger.kernel.org>; Tue, 11 Jun 2024 01:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718094783; x=1718699583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2A1jaJbvylBYtbwBpSmIIsBRdMautt6SxxGgpkJHVVg=;
        b=Xh75z/8xV9een5SrjoSx6iSPIu4BEOe0V3ZxyMQaLr9FPzx8ndGsP8l1L1OHuxF9kW
         2dEsxPib5Ln8CXhWO1fmuGFe1sCBNQ56KbMiyJ3FrEVmPPLU6NT5wb+QuVuGYlbk51o9
         dwJCtxtDEVG4YeA5Tj7Tj7TL9amQsBRxrAIU4j/J0V8RSKbL8Usqw5FFm10uqgYI854O
         dVAtggU9aakZPH9xLzLT55JbaQLZ7u/o2F9bulE5BmSLy5be7VOm0UbO9dNn0DyFYqNY
         oz0/FbJxMmGv1BVCYa5nI7bcyzhd8k2KkmBXVVbo/qrSeIGgjzLtLB+GGm2Plg7jcm/f
         xekg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718094783; x=1718699583;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2A1jaJbvylBYtbwBpSmIIsBRdMautt6SxxGgpkJHVVg=;
        b=n+bXLsRAA766yOZYmfKlEoiePB6EKEVLAmKaFUNzgfFBca9KDAkM04XvEk1h39AHEm
         F+Z08UmfaCPaT4ZuC3d9xud7QwQnQ5bPkJWqhhtXYtHpXNcJ/9BBmUuEJCdfQvLycN8x
         xN5wm35NTlxHKUTvh/k0GnMsCNY3BiI7Xl/TCJwcMBpZSklJr9cOoNGBbVgZus6DYMdc
         IRMWgTDPaIfRTVfeIA0Yc3E1WDvofQsAFhWjNatSTFTcOz+UoA7O3ZnGGyhW7Q79b7s5
         jszjR3G++0AXYLVatJHVCvuremXfXYdK5E8MqlmpWePuO1e1mi6nPryfgFfux45EdgB4
         nIww==
X-Gm-Message-State: AOJu0YxgqkMZMHQtV7QXy/LuAAaMsQv14eaqP9VzcongdZJm83Aut/q5
	kUgnkvkEMWa6StXAo+HiFWBnd0dz6W91bibulKvsyUnOM8Vix+VGccOZMw==
X-Google-Smtp-Source: AGHT+IFTXb0tLkNwc9jVGrQmTXXx84jw251UzYhuKa/9paIlHsclNTn/mescnyNdbiQCvlqR7HWoYw==
X-Received: by 2002:a05:6870:ec8d:b0:254:b7d9:2de3 with SMTP id 586e51a60fabf-254b7d94e8emr6349043fac.33.1718094782696;
        Tue, 11 Jun 2024 01:33:02 -0700 (PDT)
Received: from Ubuntu.. ([106.206.199.126])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7041cff68d0sm5776170b3a.185.2024.06.11.01.33.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 01:33:02 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 6/7] t-reftable-pq: add test for index based comparison
Date: Tue, 11 Jun 2024 13:49:23 +0530
Message-ID: <20240611083157.9876-7-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.2.404.g9eaef5822c
In-Reply-To: <20240611083157.9876-1-chandrapratap3519@gmail.com>
References: <20240606154712.15935-1-chandrapratap3519@gmail.com>
 <20240611083157.9876-1-chandrapratap3519@gmail.com>
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
index 774c4194e5..e114a8cb0f 100644
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
@@ -59,9 +59,48 @@ static void test_pq(void)
 	merged_iter_pqueue_release(&pq);
 }
 
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

