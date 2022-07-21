Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0AADC433EF
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 08:17:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232046AbiGUIRE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 04:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232355AbiGUIQp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 04:16:45 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49FAA7D7B0
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 01:16:43 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id u5so1142462wrm.4
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 01:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=6hI0ujbKfrvBHFR6SdNeoTzpn5XDYNZYoqkJ+jSkDvY=;
        b=nVDV+fe0eIOI8FVI3+JeiHp4s1c3grw0vq+qJo++w0sxLcUcKlqoDz6yg72lmjv9Oq
         WbcG6ysC3cLyVb2shUZMjPdF6hJXWwbdufZTze+orYIJ0LLu0NJvxjc+nLRPx+SpyBVQ
         XGSg+R/hvMp2AJz1Ndk5Byc2eRkfr4BPGtDse7LoqZ//mgsWQhtIQ0SxbRe5MKSAyWCP
         yj3NKPUXWeSbKHjFxqvjf56HJpVDozU2f+nsbQEU2luntSP2oUAJ2kh/pva/0Vs+hveq
         P/dUqXfepj300ba/GM9ZHrdelsBto3xa78uoXUCwPCAq2/NULzjeYgtgDP67w9YWLuhG
         k44Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=6hI0ujbKfrvBHFR6SdNeoTzpn5XDYNZYoqkJ+jSkDvY=;
        b=BgTH6JhWr0p0/WrRbcaCSAGAiabOTY04zUr7v2+A5l5Uh6ibjG/fNahAHVzidIW/ze
         A3rCKjB9Ql1rale2jht+m/43fiTTRM+Y0klh7rltmT8HIixZmuVo5M0HZnZeVbopEM1U
         DM5S39P1YmYm3sdCGfUFdSFk66W5peZ4e3ODBkOykYlwBr12S6xqJW3DFmCMwY7V/Sj0
         Ngcyqq3tOmTql2aYTs43Av3Lu6CLBnqxOSE5ni+DnypTrjAZFlTrO/tb7hCZBdO7MCoc
         bpRgvFbffTvuw79+IEJMbw0nkJsQ7Q5nItQ+oeXkZvau4dOEWne+GLBY3AjcYuM2Mt3B
         xOpA==
X-Gm-Message-State: AJIora9yiVYf2mhrjGZUKjKoxsqnJklbnaZLp2mUEFpJgNbNkAZ/pxh+
        H5M1varpF8pqHbs5oEIAu8siqBvY4uI=
X-Google-Smtp-Source: AGRyM1vqCLfVSetbOfnHiLYctxmyNdRDaGnwbg8Bxe5GQoA7FnE7Ig7jwRpcCxyDf+YELNbMcPclZw==
X-Received: by 2002:adf:f602:0:b0:21d:6662:f9e4 with SMTP id t2-20020adff602000000b0021d6662f9e4mr35433041wrp.353.1658391401204;
        Thu, 21 Jul 2022 01:16:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c15-20020adfe70f000000b0021bbf6687b1sm1400202wrm.81.2022.07.21.01.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 01:16:40 -0700 (PDT)
Message-Id: <91c495c770e3f7f91ae655a503bdd1cd99935e40.1658391391.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1231.v3.git.1658391391.gitgitgadget@gmail.com>
References: <pull.1231.v2.git.1655621424.gitgitgadget@gmail.com>
        <pull.1231.v3.git.1658391391.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 21 Jul 2022 08:16:29 +0000
Subject: [PATCH v3 5/7] merge: make restore_state() restore staged state too
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     ZheNing Hu <adlternative@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
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

