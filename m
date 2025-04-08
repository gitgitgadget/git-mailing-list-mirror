Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5929A22E3E7
	for <git@vger.kernel.org>; Tue,  8 Apr 2025 15:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744127333; cv=none; b=dQp9bD7KYto+8o7fpuPKultElLXgMm3/TMl7g8Dxw+54Mr88f9JRXjI3406tnTgo5KDKsFO8/kWoUxdIjN8g43tXB3AHubaT6gAqQZKDUCjq6YqsRyjBn0ISkK10YGTq9jJs4Hc88wdhbC0g2fMJAO5m7fagX4kT1aQZdCB2bfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744127333; c=relaxed/simple;
	bh=g5N+/trWCnnZPkzxzjZXamw4Zft2/X4SOI1UNDsaizw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=XhBo+kygRu1SCekbTlVKsAAGCF82XV6Dcg0hm0CFSTl4VBki0WejOuBDurlIOucv2l0zgdDIRI3xMmpXnCd1GFh0eplO7IPhk+ifqLCRjfjdZs7t8oVsHKdfMdS+1u46A2jJjkDDn8Fo2zopPVaicl9XB0J9e34MHLgkJQms2UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FOs/7NuP; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FOs/7NuP"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-39727fe912cso2567066f8f.3
        for <git@vger.kernel.org>; Tue, 08 Apr 2025 08:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744127329; x=1744732129; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kDUFwTWnyfdEZ603Aon99l31Fux2UGQLEUtoIF0xayQ=;
        b=FOs/7NuPqb8oMchZrt1tWzUmLgh0osxr2oC+kRoIKpaAVeYZnMHzXm6J8qAwlXe+FE
         Jto0jvz0rE1xQMWFIk2+Q17wBM/ph0EXrtFMkY3O0aumC172Ehsn/GZ79Cmo9q52cWaF
         50XqvjCzjQLEAkY5FAEgYK1iC5hNp4EIeRsPY/Y23KxoXJJ4uap7QRtv1Cq5JplbPmqs
         awgUJlibubjr+3d0U0FeBVpErrfi1o1q32uhSXVuOabVjzLK9oy0e0viZ6YctDAr5BvD
         dmM0FNCCbTTNLlOIvstHOwfn8DQap14E3MmO+PFehu/ycEfUDwn5MyS0qJaXOoIcjear
         mOpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744127329; x=1744732129;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kDUFwTWnyfdEZ603Aon99l31Fux2UGQLEUtoIF0xayQ=;
        b=ZRdrRnOsYQAD70JYwRedm4IwQVkrZsrB3xcgbSJVbUS1I07mIvpg85PbguhvMMNQEy
         fRiEZtU2cWBPOnPxi2mOT6phg8eHYTLRrqX6PytQGGoxjdDSo29kJRuI5tLI2vGTU+Uv
         BbtEs9fCIUXfbopiOi2n/4dMI+uRn2TSChPkxWHmVk4KZHGG3pIBUsVh44psawN5HOc+
         cP0eLizdg/YkW5/iwKkR35s+v6XZFrZio+NOVxRZ+glRVPgHtwGfVZkSRCpcDNTzlytt
         iu7zyrRPS3a5Ho3JIZq2Pi2iXVnGqHfuL223Pagvj008RJciKOpx2XTenN0rX/+dOCwH
         FMwQ==
X-Gm-Message-State: AOJu0YwIaER7pCBtu3/LWdeXv6onEmD7f4H94rQ3lmOEyiN9k4cOegWF
	oB29b+bftDT3hki243ox03BK1TksbCq72G+9TeFbL8bIexthD8GHN//mvA==
X-Gm-Gg: ASbGncvmfFWGPIfWzUaoZRGswM6KWQds/M8L8JH+Ia6jl2WL9RDFBvlaGcTPSMRrtmT
	QeDGzZm+RI5clhRvemmefkt3EhknLvnzmUDhCr74RB6E37K5qUpufRNmZEWK2VGzxA7S8LrbS2G
	1EVeyIvenFp+5/X5NvNPiiFeK/lTb/xnBDyFrFY5hj75CTs5TY4zB7Y3z6yKV7zWq7IkOkqAn99
	cIFWfOWRo5JqgmzACeK5n0qjywhBbrbARs4Orgk/ZNZNIlPG3jQ9TjSbt9PVLgHlayRXxkc1CZD
	nr8Wq/hcynji753izf853vFS3sAfeyJNUQiLZl0ts4cy0WLJgV0k5SEc
X-Google-Smtp-Source: AGHT+IGuSM+uUWlXT+qkJ8cAVo8Bv7e8UdIyVdm0KEyucmzAgOUnB3hEa1yeB2Hqs7wEwQwdJAFO5g==
X-Received: by 2002:a5d:59ad:0:b0:391:1139:2653 with SMTP id ffacd0b85a97d-39d6fd06913mr9486372f8f.52.1744127329138;
        Tue, 08 Apr 2025 08:48:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec1795db7sm172729845e9.25.2025.04.08.08.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 08:48:48 -0700 (PDT)
Message-Id: <8821f22d5eac351cbf05505668b1bdff9705a982.1744127323.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1898.v3.git.1744127322.gitgitgadget@gmail.com>
References: <pull.1898.v2.git.1743891374.gitgitgadget@gmail.com>
	<pull.1898.v3.git.1744127322.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 08 Apr 2025 15:48:39 +0000
Subject: [PATCH v3 5/8] merge, sequencer: switch recursive merges over to ort
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

