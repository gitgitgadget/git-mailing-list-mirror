Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4561A1DC996
	for <git@vger.kernel.org>; Sat,  5 Apr 2025 22:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743891387; cv=none; b=UXy/DmsMkqZTZnBKeV4MwkIdMPphkzdHVdUL6LFxdO4SayX6gXOTMAOUVsmw/Q1L5xc5Nf0Bn7Eh2JQ+thvXIIoJMhAAZXywTkchbUTwNLe0sHX91pHWQPSvz2aRWE/+yizIPF2x0jNu6Mga1O5Ri7JNR2o3atZzMjaV9T6B0m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743891387; c=relaxed/simple;
	bh=g5N+/trWCnnZPkzxzjZXamw4Zft2/X4SOI1UNDsaizw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=JUCT1uC1bk6vbk8YdqkgdeLEOKNmdD4gvq8f4+mkkMpzCvCyYT9dzoeBGqwAf35xqqtjQKLRYCYpSLREu0Inq0YPlpO0SNQgkpHd3v16QiCUemwwiBDb28GjRrgQ9K1Q3yvHmj1b2czZ6YUz90EqAOgnbOHW+lwI+w6SppmuTN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ejq4oAj1; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ejq4oAj1"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43ed8d32a95so12496685e9.3
        for <git@vger.kernel.org>; Sat, 05 Apr 2025 15:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743891383; x=1744496183; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kDUFwTWnyfdEZ603Aon99l31Fux2UGQLEUtoIF0xayQ=;
        b=Ejq4oAj1S66I5ICQpc6NsgHMR5hXtsQDDdqdzRu8bURzPYBmithDglHompqUZsHo9N
         M9dd+ZB21k2Q62flYO0GLE4DP/lk7aV15qFmQ4BwJ5fEtJ2kLB56Ywax4hIdIoMzZZE+
         en6X0F/+J0FE8iPY90yqwK2DG7wC277YfojxNztPz5bEvWt9EBvEkciGP1zA0QxPzoP2
         pGEvB1WumYbAhBctIY06e7uijma2MFEv2hQ2BF4WIFAbBedclsSC+xmkkqyE8ueRJ1vZ
         vsfipacW+SMWaLPc1zjkRSevzlkIgKS2pqj02q1jcyoERRy49WZwFMafSdwIRS9HII9c
         I/Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743891383; x=1744496183;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kDUFwTWnyfdEZ603Aon99l31Fux2UGQLEUtoIF0xayQ=;
        b=jLF9pR5RKrJhxONe8r2t6vEb5QXybT6b5vRolEGSk7L+dD+co6I+y3UbnfXCeEN84Q
         sbrqtzAmpmtQOdezeM2vdZ6T/ZkyrMVXImPOaWtDw49AXYoCicNPIh/rlJHCkGHZmt+J
         kzyDzbuVFIALbyujFa6lbsIWob7tC5vEivHnxBINjoX7CJ5y5F3lu7UMQVUlskwc7ti6
         G07mPwwmK6qr31yLOuODt+qcM1NhzLjOqmNyl4YUtzoD1heMew7viATkgdmm8xqpp4Bf
         UHq6SmkqRD6wtiJDj7bRHJQJHf7mANuDgGHA5nsJI0e0XXIub4VlV821Fyqqq8uqZ/4C
         Bm5w==
X-Gm-Message-State: AOJu0YwZKIFlEurtrFefk8nq+edQGuCH9frtXMZSIFoGN5+w700PFrPA
	pQZpE1/iDikjdszxeH6uqJ9GJUSeXUxqstd5v+jK1hdAUPe1S3gb6tu99Q==
X-Gm-Gg: ASbGncsIaN3gxDn5hwpd/tvwZk4WSjONsxe5p6QD1E52JBPBcT88vVtd+rMx0pZk2d4
	I9TWOCbyc55NlzUcBI1XdcFdHzK88Gmm1g23fVWJX3ZHokuN4sbY5nmu7YRQkj8TxKkw8XqcQYt
	GVjzItpmeWa4R85Xih30xeX2rR93mE6UEjlS8BsdLD/ydUjgmbLbUIrcm0w4NqO/rdgpKsmgrMg
	vvf1PvNmd8e/ugNZZ92/kUp/VTc9sG0BAy9xRoKcFWhoJ4EZSwHkuu9080E4yxx9wUdNedcuj+q
	jW+GEcFHIVDT/YptmE9uAvcYZli+0Hbrwbv8+cUdN7QK8iD+tAXYvn3Q
X-Google-Smtp-Source: AGHT+IEWU1gt6teWh8pcRm8hFtVM1RPlOFdP/xmscz6jssrj56xKfzoAU7M5/jbA3P3KmX5qG8tE4A==
X-Received: by 2002:a05:600c:1e23:b0:43b:c95f:fd9 with SMTP id 5b1f17b1804b1-43ecf81c304mr69832745e9.5.1743891382952;
        Sat, 05 Apr 2025 15:16:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c3020d943sm7987731f8f.74.2025.04.05.15.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Apr 2025 15:16:22 -0700 (PDT)
Message-Id: <8821f22d5eac351cbf05505668b1bdff9705a982.1743891375.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1898.v2.git.1743891374.gitgitgadget@gmail.com>
References: <pull.1898.git.1743436279.gitgitgadget@gmail.com>
	<pull.1898.v2.git.1743891374.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 05 Apr 2025 22:16:11 +0000
Subject: [PATCH v2 5/8] merge, sequencer: switch recursive merges over to ort
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

More precisely, replace calls to merge_recursive() with
merge_ort_recursive().

Also change t7615 to quit calling out recursive; it is not needed
anymore, and we are in fact using ort now.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/merge.c                            |  9 ++-------
 sequencer.c                                | 23 ++++++++--------------
 t/t7615-diff-algo-with-mergy-operations.sh |  2 --
 3 files changed, 10 insertions(+), 24 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index ba9faf126aa..c0bbdab7104 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -39,7 +39,6 @@
 #include "rerere.h"
 #include "help.h"
 #include "merge.h"
-#include "merge-recursive.h"
 #include "merge-ort-wrappers.h"
 #include "resolve-undo.h"
 #include "remote.h"
@@ -750,12 +749,8 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
 
 		repo_hold_locked_index(the_repository, &lock,
 				       LOCK_DIE_ON_ERROR);
-		if (!strcmp(strategy, "ort"))
-			clean = merge_ort_recursive(&o, head, remoteheads->item,
-						    reversed, &result);
-		else
-			clean = merge_recursive(&o, head, remoteheads->item,
-						reversed, &result);
+		clean = merge_ort_recursive(&o, head, remoteheads->item,
+					    reversed, &result);
 		free_commit_list(reversed);
 		strbuf_release(&o.obuf);
 
diff --git a/sequencer.c b/sequencer.c
index b5d91fd3515..8bb49735891 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4319,20 +4319,13 @@ static int do_merge(struct repository *r,
 	o.branch2 = ref_name.buf;
 	o.buffer_output = 2;
 
-	if (!opts->strategy || !strcmp(opts->strategy, "ort")) {
-		/*
-		 * TODO: Should use merge_incore_recursive() and
-		 * merge_switch_to_result(), skipping the call to
-		 * merge_switch_to_result() when we don't actually need to
-		 * update the index and working copy immediately.
-		 */
-		ret = merge_ort_recursive(&o,
-					  head_commit, merge_commit, bases,
-					  &i);
-	} else {
-		ret = merge_recursive(&o, head_commit, merge_commit, bases,
-				      &i);
-	}
+	/*
+	 * TODO: Should use merge_incore_recursive() and
+	 * merge_switch_to_result(), skipping the call to
+	 * merge_switch_to_result() when we don't actually need to
+	 * update the index and working copy immediately.
+	 */
+	ret = merge_ort_recursive(&o, head_commit, merge_commit, bases, &i);
 	if (ret <= 0)
 		fputs(o.obuf.buf, stdout);
 	strbuf_release(&o.obuf);
@@ -4343,7 +4336,7 @@ static int do_merge(struct repository *r,
 		goto leave_merge;
 	}
 	/*
-	 * The return value of merge_recursive() is 1 on clean, and 0 on
+	 * The return value of merge_ort_recursive() is 1 on clean, and 0 on
 	 * unclean merge.
 	 *
 	 * Let's reverse that, so that do_merge() returns 0 upon success and
diff --git a/t/t7615-diff-algo-with-mergy-operations.sh b/t/t7615-diff-algo-with-mergy-operations.sh
index ac5863e788c..5822d02d517 100755
--- a/t/t7615-diff-algo-with-mergy-operations.sh
+++ b/t/t7615-diff-algo-with-mergy-operations.sh
@@ -22,8 +22,6 @@ test_expect_success 'setup' '
 	git tag c2
 '
 
-GIT_TEST_MERGE_ALGORITHM=recursive
-
 test_expect_success 'merge c2 to c1 with recursive merge strategy fails with the current default myers diff algorithm' '
 	git reset --hard c1 &&
 	test_must_fail git merge -s recursive -Xdiff-algorithm=myers c2
-- 
gitgitgadget

