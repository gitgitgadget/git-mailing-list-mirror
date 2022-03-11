Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69CBFC433F5
	for <git@archiver.kernel.org>; Fri, 11 Mar 2022 17:25:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350737AbiCKR0F (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Mar 2022 12:26:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350733AbiCKR0B (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Mar 2022 12:26:01 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 349ED17B89F
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 09:24:57 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id u10so13952943wra.9
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 09:24:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=yjmNL/tivFKW02xWi2ghefdCPTSMO+axbZaAoU6mLo8=;
        b=oMtiKWb96on7G77NYiI9vSkeLz6I04qPCWZx1D59coNCX8z2KVEDcSqSxOg9BlNrJa
         ekuZ/CW0wqCBPV93XDYBjzFKAPJwtPRyUKXQYEXhtupzG8eOQo59PJ6JNccHS+1xtr0J
         0YNS88++4uCzHVfhXRU2lLIXPTHX154TSzOmRsY3qrs1woTfXF+ewj8tD3pJCrfHo8Mk
         t+zv0ILYLu91MGVxoisldOuIdRIGyIqfXiWJB2mIN+wOg2H2xxSoa76OJms04BYkQsF9
         /LW49BrI0e2Chw1JN1QKnb0CmA9l9pepNhzOGpLB0DvxzhKbruBd/6MaMaeZZguSfL7X
         Rs8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=yjmNL/tivFKW02xWi2ghefdCPTSMO+axbZaAoU6mLo8=;
        b=JUOMisphJ7axitYc2K5yWK0iaGA26ZraMMkU3wjrHb/q8J1maI+7dgKYySUFywDvOf
         PsEMr8nwKsLjzMWhGe4lCQL6mZE3w5m7SE90NbTm2Ix7DWV7hmcMc82WKeDqlZW32KX2
         Q6dh2z2N/XUjRbb29/lFx7C/OEKNJLPvLyf0b71PB3X4dO8Ww2wv/1/4No941vHrVRe2
         J7Z6949eV2n9KjRmI2221FvfoYU89SeBGR+U709fA/XsRP3MdJzqlK30GKB/BwyuLWWS
         iJMWzAMtI2gYOS7+M8wKo7hw/T9SzVruglTAlp6Q5qOQa31P93UIhssiK1BxKmhdUMuT
         LHHw==
X-Gm-Message-State: AOAM532QKI9neowcu5rHCEiDFDpRZZGadX7BrnTaIHHtsvMhVIFVFx0K
        a4Hy98WN7hMCYoHRWfX/gKH1KHjK6OQ=
X-Google-Smtp-Source: ABdhPJzGh0irWrh5+48A8vJwWbweUW9a4AxeVm0mAg/ZiMmctQ4fwvye/QTyVnWpclyBk73Un1pJdg==
X-Received: by 2002:a05:6000:137a:b0:1f1:d6ec:7b69 with SMTP id q26-20020a056000137a00b001f1d6ec7b69mr7883098wrz.78.1647019495610;
        Fri, 11 Mar 2022 09:24:55 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n16-20020a5d4850000000b0020373b34961sm6931069wrs.66.2022.03.11.09.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 09:24:55 -0800 (PST)
Message-Id: <0e3c73375c18a470fd5357b09acefeaf5ca4017f.1647019492.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1226.v2.git.git.1647019492.gitgitgadget@gmail.com>
References: <pull.1226.git.git.1646975144178.gitgitgadget@gmail.com>
        <pull.1226.v2.git.git.1647019492.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 11 Mar 2022 17:24:52 +0000
Subject: [PATCH v2 2/2] rebase: set REF_HEAD_DETACH in checkout_up_to_date()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        John Cai <johncai86@gmail.com>, John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: John Cai <johncai86@gmail.com>

Fixes a bug whereby rebase updates the deferenced reference HEAD points
to instead of HEAD directly.

If HEAD is on main and if the following is a fast-forward operation,

git rebase $(git rev-parse main) $(git rev-parse topic)

Instead of HEAD being set to $(git rev-parse topic), rebase erroneously
dereferences HEAD and sets main to $(git rev-parse topic). See [1] for
the original bug report.

The callstack from checkout_up_to_date() is the following:

cmd_rebase() -> checkout_up_to_date() -> reset_head() -> update_refs()
 -> update_ref()

When <branch> is not a valid branch but a sha, rebase sets the head_name
of rebase_options to NULL. This value gets passed down this call chain
through the branch member of reset_head_opts also getting set to NULL
all the way to update_refs(). update_refs() checks ropts.branch to
decide whether or not to switch brancheds. If ropts.branch is NULL, it
calls update_ref() to update HEAD. At this point however, from rebase's
point of view, we want a detached HEAD. But, since checkout_up_to_date()
does not set the RESET_HEAD_DETACH flag, the update_ref() call will
deference HEAD and update the branch its pointing to, which in the above
example is main.

The correct behavior is that git rebase should update HEAD to $(git
rev-parse topic) without dereferencing it.

Fix this bug by adding the RESET_HEAD_DETACH flag in checkout_up_to_date
if <branch> is not a valid branch. so that once reset_head() calls
update_refs(), it calls update_ref() with REF_NO_DEREF which updates
HEAD directly intead of deferencing it and updating the branch that HEAD
points to.

Also add a test to ensure this behavior.

1. https://lore.kernel.org/git/xmqqsfrpbepd.fsf@gitster.g/

Reported-by: Michael McClimon <michael@mcclimon.org>
Signed-off-by: John Cai <johncai86@gmail.com>
---
 builtin/rebase.c  | 5 ++++-
 reset.c           | 3 +++
 t/t3400-rebase.sh | 9 +++++++++
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index b29ad2b65e7..5ae7fa2a169 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -827,8 +827,11 @@ static int checkout_up_to_date(struct rebase_options *options)
 		    getenv(GIT_REFLOG_ACTION_ENVIRONMENT),
 		    options->switch_to);
 	ropts.oid = &options->orig_head;
-	ropts.branch = options->head_name;
 	ropts.flags = RESET_HEAD_RUN_POST_CHECKOUT_HOOK;
+	if (options->head_name)
+		ropts.branch = options->head_name;
+	else
+		ropts.flags |=  RESET_HEAD_DETACH;
 	ropts.head_msg = buf.buf;
 	if (reset_head(the_repository, &ropts) < 0)
 		ret = error(_("could not switch to %s"), options->switch_to);
diff --git a/reset.c b/reset.c
index e3383a93343..f8e32fcc240 100644
--- a/reset.c
+++ b/reset.c
@@ -101,6 +101,9 @@ int reset_head(struct repository *r, const struct reset_head_opts *opts)
 	if (opts->branch_msg && !opts->branch)
 		BUG("branch reflog message given without a branch");
 
+	if (switch_to_branch && opts->flags & RESET_HEAD_DETACH)
+		BUG("attempting to detach HEAD when branch is given");
+
 	if (!refs_only && repo_hold_locked_index(r, &lock, LOCK_REPORT_ON_ERROR) < 0) {
 		ret = -1;
 		goto leave_reset_head;
diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index 0643d015255..d5a8ee39fc4 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -394,6 +394,15 @@ test_expect_success 'switch to branch not checked out' '
 	git rebase main other
 '
 
+test_expect_success 'switch to non-branch detaches HEAD' '
+	git checkout main &&
+	old_main=$(git rev-parse HEAD) &&
+	git rebase First Second^0 &&
+	test_cmp_rev HEAD Second &&
+	test_cmp_rev main $old_main &&
+	test_must_fail git symbolic-ref HEAD
+'
+
 test_expect_success 'refuse to switch to branch checked out elsewhere' '
 	git checkout main &&
 	git worktree add wt &&
-- 
gitgitgadget
