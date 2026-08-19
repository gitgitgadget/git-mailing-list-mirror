Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D2A392807
	for <git@vger.kernel.org>; Wed, 19 Aug 2026 13:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787145611; cv=none; b=Y6kDKp57nW/QXFNFG44oGaKq+Gp++2TvSGgL78RDTjhWBlAwRwTH2YnHOMRqVLXOJMKLqyMLuGV8FxieNb/Gl/0XpHE8G01KcBKZnx5nLU3KV8E9UIZnWcxZpsUihyEDS7vbniKWyuLBV2QHaedSYRx/wsZ/eItLHZp8Q1xPp28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787145611; c=relaxed/simple;
	bh=jE1nBZs/swiQJpXt2zdCvFoXImLiBC+owT6rrVIBF+0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tvUvHwB/K+0t+lHc4iETzEe0PgLQ+aTf4L8d+I38v9t46CsrcyyL0mgExQN6QruzH4LZs+QJS/Mz35zfkciV3B6f6CIfo5lXDyAifMhhZzY1bUvn77JBAeGzQDe8kU9wtkTWEFYYp83IATqaGPrqd3IZgwt07UTfq951rYf+t2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D5wKAe9k; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D5wKAe9k"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4980fe6b3beso15706635e9.0
        for <git@vger.kernel.org>; Wed, 19 Aug 2026 06:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787145607; x=1787750407; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A5dFkHfv0mgTmtyZvL3BJVNHogreuntYXPOMhbUhpsg=;
        b=D5wKAe9kltfg+EeanCQWN5yg0TCrFCoJD1rSooP8eWSTc0ZRJ1FMTJ/1bTfCcpk6MH
         cNJaQtV3XfvAp1FpNxgPIGsr1vPfBg5jwLVQw3S5bo1Hs8c2DCxStZ+RmrGMI/ZCBlVr
         O2geC5qh6+wI6L8L7fH7nMx9a1ipdl63CTFUtpPi+EO3Xhiqc7tWUlusxRUTevn5S7EU
         zqF+ePJEMvkmXrnGOgn8sTNcSEhKkjlHXSMRoXKJcK0b73T+Z74UGIGUeMmDTvMvcsVo
         /BqQkwKCMozUEyn4ulQFvCt6DL2Wm6gYBq9S8tOy3W0zj2HfQ7DjD3XIousynO9IUe/s
         gNIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787145607; x=1787750407;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A5dFkHfv0mgTmtyZvL3BJVNHogreuntYXPOMhbUhpsg=;
        b=eCezWE8VoIzsy8jU0bEUXmwkVlj7KmRzoHqG4AhGT8RpN0Vvq9n9bUoCLm53Hnd6mo
         zkOFjtsAK64aYs8v4lYWint+ZcGpHf0qDtmt/Q0CXOpAG5G6jlf8dqcEkNKZVOIZ7Cco
         RfeSZ3r6qg5sDcNUyEd4bU5NYPbjdItkD8vMvL3YAsMX3w5z0SDres43ZiRarS5Bnjan
         EJM8OI/M/rEg4c6xyqgeMSKHJecW2ik0H0JLvv0zjzLKj8xK6AIc3fSjw+dinrWYMdZM
         7n9NS9mRuDOL5+Att1/MdkoRU3nxrSKW91v+/ULMAcg+wCqUDDiiQYjP5SqiZ5Va0xAM
         geFQ==
X-Gm-Message-State: AOJu0YxsnNbMhbb2mFvEGBi3dYBo3BGRynvCmyav/ITbwQcEj6eM4JyH
	qeevs1OzooRq41AWweQqidncWuDb/DRYLEgNKqwSdNIUXfUKaJy/2+qBMu/1eLPr
X-Gm-Gg: AR+sD10YZQoHZb2ht8iiJQVKduAbGJM3YVpfpsJmoWdaM+LMMNSEZr/RhFa+X8ytiVw
	Vpz12keUpcXhdmA+qKhfsesapwR9e7bvhJcE4/yaQaBryDy+6INIDg2YdYPPXzVdX6idtvtJeFK
	aO1LFlAnvhzWSjaJw3jHPWYDYAGTMlvdjGF3LHAxplXN/ZD/juYfF1oFUW9KsfoHaH5U3UqWL6l
	IIl8xv2qhlWU2i090ZiZWVrsKcmqyRHgtsQhmsq5ufggicmxKLMjLwpBHqod95xSnW4cCiE/Pn5
	ZIxoGcd9nGSXzSs4Tpq63AjviqsINQi24dNCt35eEoKxbKd1FBuOxolRVjKnZZLM42Rmoonj6u9
	+1+1ZIZ7gSYVMDtX9mYPMGr8OakZJH++DPbfhuz+j+WRUak4NGXIOQD1+1+kvHbumQwed5aBih+
	JJ8igEiN15p/qB7n5JG7h8J+gUNKHDgpksyYUGRDMsnXfbbZSPM8tgUscwM+h+GpFyr/UoGjL30
	Q6Fy6mIhYBWrhNDF2pf2yPK9WI=
X-Received: by 2002:a05:600c:3f10:b0:493:f783:c46a with SMTP id 5b1f17b1804b1-499aa0f306fmr86559045e9.6.1787145606920;
        Wed, 19 Aug 2026 06:20:06 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:15a6:881d:7fd4:eabb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499a9ddee1esm37578955e9.2.2026.08.19.06.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 06:20:05 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Wed, 19 Aug 2026 15:19:39 +0200
Subject: [PATCH 3/3] reftable/stack: avoid reloading the stack when already
 locked
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260819-740-optimize-reloading-the-reftable-stack-v1-3-6bf5305d4e43@gmail.com>
References: <20260819-740-optimize-reloading-the-reftable-stack-v1-0-6bf5305d4e43@gmail.com>
In-Reply-To: <20260819-740-optimize-reloading-the-reftable-stack-v1-0-6bf5305d4e43@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3434; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=jE1nBZs/swiQJpXt2zdCvFoXImLiBC+owT6rrVIBF+0=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGqFrYD0jYeqJ5PSJffm/HxvHSOECLi8BUNyt
 j8/fnbtOOCt3okBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJqha2AAAoJED7VnySO
 Rox/B30L/RJlyB6b77LGBTSfLpr2UMHaaqrvUGAMiTa7V0mGXM5CPEVI5hVjzJe0VpGx44U87vS
 mWd3NV/f8tkwFPsYGn2bOvtt2H4H8ikrIq7AkC0wf24HQA8gI4ELLpgDiKuYjKhglqDh8LuP4vL
 f+hsnih91BVkTJoKhLhHXxxMKmII1AelOXzyoLYXSXFcRt92XUwrwPughHnVJHob5Ibyh1gEjFk
 AB7YZuk5lO33NX1n34f8NUV7dDmST7OlaQifdojlUX8gN0JyNzYaPSBC8ai+HiXDmyQ48D8+X+n
 zJuIX2fUofxw6S0RnYMM5VwODv14s+YvYDUKcJcj+lW50sHYG2Y12Jb4cDisOXUGzSmsgOCZiMe
 hYzTl1YHquM7i9hfzEGth9pLq6wnTpZQaORH/+oMGSIpqza3QCo7cubxJ5eS9i3YXng/CAYUgOc
 x4Q8Y6p4vMqwVCrfYan5uZl2ep3YrtgqL3VGdymODl6YLDERNIkCV0IphqGrCu76YrW4w3vwYN9
 vk=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

When making modifications to the reftable stack, the stack obtains a
lock to the list file and removes the lock after the commit phase. Since
most operations reload the stack to ensure we have the latest state, any
branched operation during the locked phase could trigger a state reload.

To prevent data loss due to concurrent writes, state reload is necessary
right after obtaining the lock. But any reloads after that are just a
no-op. Now that the struct has access to the lock file status, simply
skip reloading if the lock is present.

Benchmarking with a fixed, non-symbolic target OID shows a modest but
consistent ~1-2% improvement in clock time for `update-ref` across ref
counts ranging from 2,000 to 100,000.

We can see better improvements in the number of syscall counts. On
master, the number of calls to `newfstatat()` grows linearly with the
number of refs created. With this patch, the number is now a constant:

  refcount   master   patch
  --------   ------   ------
  1,000      1,059       55
  5,000      5,059       55
  10,000     10,059      55
  20,000     20,059      55

Reported-by: Jeff King <peff@peff.net>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 reftable/stack.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index e449af9c03..433a611ed1 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -553,14 +553,21 @@ int reftable_new_stack(struct reftable_stack **dest, const char *dir,
 
 /*
  * Check whether the given stack is up-to-date with what we have in memory.
+ * If skip_if_locked is set skip stack reloading if the stack is currently
+ * locked. Stack reloading must _not_ be skipped right after obtaining the
+ * lock, to check for concurrent updates which may have happened.
+ *
  * Returns 0 if so, 1 if the stack is out-of-date or a negative error code
  * otherwise.
  */
-static int stack_uptodate(struct reftable_stack *st)
+static int stack_uptodate(struct reftable_stack *st, int skip_if_locked)
 {
 	char **names = NULL;
 	int err;
 
+	if (skip_if_locked && st->list_lock.fd != -1)
+		return 0;
+
 	/*
 	 * When we have cached stat information available then we use it to
 	 * verify whether the file has been rewritten.
@@ -623,7 +630,7 @@ static int stack_uptodate(struct reftable_stack *st)
 
 int reftable_stack_reload(struct reftable_stack *st)
 {
-	int err = stack_uptodate(st);
+	int err = stack_uptodate(st, 1);
 	if (err > 0)
 		return reftable_stack_reload_maybe_reuse(st, 1);
 	return err;
@@ -683,7 +690,7 @@ static int reftable_stack_init_addition(struct reftable_addition *add,
 		}
 	}
 
-	err = stack_uptodate(st);
+	err = stack_uptodate(st, 0);
 	if (err < 0)
 		goto done;
 	if (err > 0) {
@@ -1189,7 +1196,7 @@ static int stack_compact_range(struct reftable_stack *st,
 	 * we could check that relevant tables still exist. But for now it's
 	 * good enough to just abort.
 	 */
-	err = stack_uptodate(st);
+	err = stack_uptodate(st, 0);
 	if (err < 0)
 		goto done;
 	if (err > 0) {
@@ -1308,7 +1315,7 @@ static int stack_compact_range(struct reftable_stack *st,
 	 * tables with our compacted version. If they don't, then we need to
 	 * abort.
 	 */
-	err = stack_uptodate(st);
+	err = stack_uptodate(st, 0);
 	if (err < 0)
 		goto done;
 	if (err > 0) {

-- 
2.55.GIT

