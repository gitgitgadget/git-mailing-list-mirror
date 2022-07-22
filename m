Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCAFFC433EF
	for <git@archiver.kernel.org>; Fri, 22 Jul 2022 05:16:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233663AbiGVFQA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jul 2022 01:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231522AbiGVFPw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jul 2022 01:15:52 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF56248C5
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 22:15:51 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id u14-20020a05600c00ce00b003a323062569so1844919wmm.4
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 22:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=o7GPUzkCZ8mQA/iw0P73pmXqknSvuHaMPI4bL6mBzJM=;
        b=fxRgjj4UAaKTH9K5Y/BAfrglfbjkgoSm2OsfRLoMs79yiQS6wqi2zKltfxV1kaaR8a
         sgWn5ySmucyukPLRAJ8aJ8bbfzqIfUaOKQKaeQNuYlSCqtuilEww/b+tEzzkavd0xlMt
         jVIjp//ZqbdxtJmfrU9PglfhaZRU0RowpwqnkSYWo2XXsku1Q9tfvXJg3H3OonKqw9fz
         DM00xhAQmK1JDKDymd7Zv+idDdCrfO30m37ukn0eZGfbEetyAbSrKA6wJFYOFGqbG32Y
         8JHH5frvdn0K9mhFs3TCR93Px5HpmCF0OB6BwgstJnzXqLLGgTmxNIUtjPHKxJbIje4x
         6SkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=o7GPUzkCZ8mQA/iw0P73pmXqknSvuHaMPI4bL6mBzJM=;
        b=btRDQPqArFynGUbA/LZWBINbKFtWvTH77bquykiaPSinM1h3XATXZ6MDSI/QiKPfI0
         GhaufkdxRSxLHbM9OAC1jtOgbTuVxyLve1aM9myp29WjWTvfqGLNfr2BgMYGkbGh/o/k
         cMejYm92X1wDMHRRAFXi/xdEeiF+67Q0nm6fESzEx4kukb+cd5s5+Uzu+i4KZIlNqAOp
         rRrH6cbkzULMKpaH7gbyQjH5j4swXDM2v/PU6UriHr+pRGY5VeOeYxz7rhMdQSquJ3ZT
         qLO+sf+lT66Z9D1TRTnlWq0Ij/PT+ahwi+VDb5Q3YyqOeUyYbldD9zobNgEbiGk3fIHz
         59hA==
X-Gm-Message-State: AJIora9faL1Rk4dM1tt9s2svV6FBuh2Mq7afPro0Z404rxmHG1Ho5Oh8
        fSRpcaXwjqWvrWNNMaMDuzO872IuEKE=
X-Google-Smtp-Source: AGRyM1t47T33CsL6dDbaXr9TjFhGQKLA0kN+K7Ecb6ExHKZeuNC9VRroOky3NeUI6mHQD8+ZBRxfOw==
X-Received: by 2002:a05:600c:19d2:b0:3a3:2cdb:cc02 with SMTP id u18-20020a05600c19d200b003a32cdbcc02mr8269322wmq.182.1658466949398;
        Thu, 21 Jul 2022 22:15:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k22-20020a5d5256000000b0021e2fccea97sm3711445wrc.64.2022.07.21.22.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 22:15:48 -0700 (PDT)
Message-Id: <f401bd5ad0dd7564412e72d19a4193ad3f64e638.1658466942.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1231.v4.git.1658466942.gitgitgadget@gmail.com>
References: <pull.1231.v3.git.1658391391.gitgitgadget@gmail.com>
        <pull.1231.v4.git.1658466942.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 22 Jul 2022 05:15:40 +0000
Subject: [PATCH v4 5/7] merge: make restore_state() restore staged state too
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     ZheNing Hu <adlternative@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

There are multiple issues at play here:

  1) If `git merge` is invoked with staged changes, it should abort
     without doing any merging, and the user's working tree and index
     should be the same as before merge was invoked.
  2) Merge strategies are responsible for enforcing the index == HEAD
     requirement. (See 9822175d2b ("Ensure index matches head before
     invoking merge machinery, round N", 2019-08-17) for some history
     around this.)
  3) Merge strategies can bail saying they are not an appropriate
     handler for the merge in question (possibly allowing other
     strategies to be used instead).
  4) Merge strategies can make changes to the index and working tree,
     and have no expectation to clean up after themselves, *even* if
     they bail out and say they are not an appropriate handler for
     the merge in question.  (The `octopus` merge strategy does this,
     for example.)
  5) Because of (3) and (4), builtin/merge.c stashes state before
     trying merge strategies and restores it afterward.

Unfortunately, if users had staged changes before calling `git merge`,
builtin/merge.c could do the following:

   * stash the changes, in order to clean up after the strategies
   * try all the merge strategies in turn, each of which report they
     cannot function due to the index not matching HEAD
   * restore the changes via "git stash apply"

But that last step would have the net effect of unstaging the user's
changes.  Fix this by adding the "--index" option to "git stash apply".
While at it, also squelch the stash apply output; we already report
"Rewinding the tree to pristine..." and don't need a detailed `git
status` report afterwards.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/merge.c                          | 5 +++--
 t/t6424-merge-unrelated-index-changes.sh | 7 ++++++-
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 4170c30317e..f807bf335bd 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -383,14 +383,15 @@ static void reset_hard(const struct object_id *oid, int verbose)
 static void restore_state(const struct object_id *head,
 			  const struct object_id *stash)
 {
-	const char *args[] = { "stash", "apply", NULL, NULL };
+	const char *args[] = { "stash", "apply", "--index", "--quiet",
+			       NULL, NULL };
 
 	if (is_null_oid(stash))
 		return;
 
 	reset_hard(head, 1);
 
-	args[2] = oid_to_hex(stash);
+	args[4] = oid_to_hex(stash);
 
 	/*
 	 * It is OK to ignore error here, for example when there was
diff --git a/t/t6424-merge-unrelated-index-changes.sh b/t/t6424-merge-unrelated-index-changes.sh
index 3019d030e07..c96649448fa 100755
--- a/t/t6424-merge-unrelated-index-changes.sh
+++ b/t/t6424-merge-unrelated-index-changes.sh
@@ -285,6 +285,7 @@ test_expect_success 'resolve && recursive && ort' '
 
 	test_seq 0 10 >a &&
 	git add a &&
+	git rev-parse :a >expect &&
 
 	sane_unset GIT_TEST_MERGE_ALGORITHM &&
 	test_must_fail git merge -s resolve -s recursive -s ort C^0 >output 2>&1 &&
@@ -292,7 +293,11 @@ test_expect_success 'resolve && recursive && ort' '
 	grep "Trying merge strategy resolve..." output &&
 	grep "Trying merge strategy recursive..." output &&
 	grep "Trying merge strategy ort..." output &&
-	grep "No merge strategy handled the merge." output
+	grep "No merge strategy handled the merge." output &&
+
+	# Changes to "a" should remain staged
+	git rev-parse :a >actual &&
+	test_cmp expect actual
 '
 
 test_done
-- 
gitgitgadget

