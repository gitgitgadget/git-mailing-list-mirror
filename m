Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E678CC433EF
	for <git@archiver.kernel.org>; Tue, 14 Jun 2022 19:27:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243571AbiFNT1u (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jun 2022 15:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236660AbiFNT1l (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jun 2022 15:27:41 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB72DFF3
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 12:27:40 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id q15so12513206wrc.11
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 12:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=TQOfzG3gc2ljmIL19/ejawb0LXd+xsTXQkMKPYfW7LU=;
        b=ELf0mHCYUBpykTxXcrH2nqbBd0C1t8yG6sFOJVAP9LVGOrUrLfYw7S59aGHsd2cj8M
         qR6DGJPwswaX+xLQUC0yzJjs6kzApcZzJGaiEs5EwaTgt3Zn/xTPhweGF6QFNL10ceji
         dVpL4i1baDZyIF/PpEqFD9DwWFnVH8dXpj4Jdll51QyklJvRtNQLww1QMOSHTYdwP5dz
         103LkwTjS9/vAyaQhuf+OenJsVS5e6GlKpgea1txMLdVaBRlA1cYduupo8gmB4D+Wg4I
         3M99pfP71WtpeXk/EyS9jKItgUOkdjKw+1qEKvuFJrp2VDDTQIYFd5SjX64PDebzEOCL
         /ZfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=TQOfzG3gc2ljmIL19/ejawb0LXd+xsTXQkMKPYfW7LU=;
        b=DwEo69Z8hEoh2exiMNfAbkbz3dOkhKWdzd28FvMexZngj1UeEamNnOlubUYnoPOM0Z
         +e+1CYRfkhBlojswHpqi75GWuWZR00HKQd58RrQmsNXHehJjMbX49+b0azrP5stuEO63
         Z0HQRRlKelRzvF6GjpXxZPmSK1qNtPo19PuqzvA/l93l5MqeLHYs7aGXBLe/DO6JtMLt
         OaCjBMWJ3zuGTFYpt/MtlLRfrvUYklYOn75B7Tz+gR2O68qiQ6QdU3rweqbTAXJPyZ6e
         IxJqzTm1xKgY6qtA/FcLxyo0heL9gRcEktzum7BM04f8vk+wZyG7lAFJdhcSpPuL3975
         EE3Q==
X-Gm-Message-State: AJIora8lIGBYeniQSArH55+iFhnquim8CRXxCyFqu8sFGTNZzLWoRmjv
        kkgIoGBHiufKkjhjiCUC6pui0BZ8xUyt1g==
X-Google-Smtp-Source: AGRyM1uWRI8xKYnWO3gNwRgqxWeRR4RuEY6S8APvdtC4blcT8yInSfXSrFtQN2EfT6FxLN1mz1KOiw==
X-Received: by 2002:a05:6000:1866:b0:218:40cc:a26e with SMTP id d6-20020a056000186600b0021840cca26emr6418863wri.678.1655234858711;
        Tue, 14 Jun 2022 12:27:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q7-20020a056000136700b0020c6b78eb5asm12494664wrz.68.2022.06.14.12.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 12:27:38 -0700 (PDT)
Message-Id: <1c764bfcfe4d2a3233055c8f5175ebbf0076c6dd.1655234853.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1254.v2.git.1655234853.gitgitgadget@gmail.com>
References: <pull.1254.git.1654718942.gitgitgadget@gmail.com>
        <pull.1254.v2.git.1655234853.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 14 Jun 2022 19:27:31 +0000
Subject: [PATCH v2 3/5] fetch: use new branch_checked_out() and add tests
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, johannes.schindelin@gmx.de, me@ttaylorr.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

When fetching refs from a remote, it is possible that the refspec will
cause use to overwrite a ref that is checked out in a worktree. The
existing logic in builtin/fetch.c uses a possibly-slow mechanism. Update
those sections to use the new, more efficient branch_checked_out()
helper.

These uses were not previously tested, so add a test case that can be
used for these kinds of collisions. There is only one test now, but more
tests will be added as other consumers of branch_checked_out() are
added.

Note that there are two uses in builtin/fetch.c, but only one of the
messages is tested. This is because the tested check is run before
completing the fetch, and the untested check is not reachable without
concurrent updates to the filesystem. Thus, it is beneficial to keep
that extra check for the sake of defense-in-depth. However, we should
not attempt to test the check, as the effort required is too
complicated to be worth the effort. This use in update_local_ref()
also requires a change in the error message because we no longer have
access to the worktree struct, only the path of the worktree. This error
is so rare that making a distinction between the two is not critical.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 builtin/fetch.c           | 22 +++++++-----------
 t/t2407-worktree-heads.sh | 47 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+), 14 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index ac29c2b1ae3..7fdbfee5c93 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -885,7 +885,6 @@ static int update_local_ref(struct ref *ref,
 			    struct worktree **worktrees)
 {
 	struct commit *current = NULL, *updated;
-	const struct worktree *wt;
 	const char *pretty_ref = prettify_refname(ref->name);
 	int fast_forward = 0;
 
@@ -900,16 +899,14 @@ static int update_local_ref(struct ref *ref,
 	}
 
 	if (!update_head_ok &&
-	    (wt = find_shared_symref(worktrees, "HEAD", ref->name)) &&
-	    !wt->is_bare && !is_null_oid(&ref->old_oid)) {
+	    !is_null_oid(&ref->old_oid) &&
+	    branch_checked_out(ref->name)) {
 		/*
 		 * If this is the head, and it's not okay to update
 		 * the head, and the old value of the head isn't empty...
 		 */
 		format_display(display, '!', _("[rejected]"),
-			       wt->is_current ?
-				       _("can't fetch in current branch") :
-				       _("checked out in another worktree"),
+			       _("can't fetch into checked-out branch"),
 			       remote, pretty_ref, summary_width);
 		return 1;
 	}
@@ -1434,19 +1431,16 @@ cleanup:
 	return result;
 }
 
-static void check_not_current_branch(struct ref *ref_map,
-				     struct worktree **worktrees)
+static void check_not_current_branch(struct ref *ref_map)
 {
-	const struct worktree *wt;
+	const char *path;
 	for (; ref_map; ref_map = ref_map->next)
 		if (ref_map->peer_ref &&
 		    starts_with(ref_map->peer_ref->name, "refs/heads/") &&
-		    (wt = find_shared_symref(worktrees, "HEAD",
-					     ref_map->peer_ref->name)) &&
-		    !wt->is_bare)
+		    (path = branch_checked_out(ref_map->peer_ref->name)))
 			die(_("refusing to fetch into branch '%s' "
 			      "checked out at '%s'"),
-			    ref_map->peer_ref->name, wt->path);
+			    ref_map->peer_ref->name, path);
 }
 
 static int truncate_fetch_head(void)
@@ -1650,7 +1644,7 @@ static int do_fetch(struct transport *transport,
 	ref_map = get_ref_map(transport->remote, remote_refs, rs,
 			      tags, &autotags);
 	if (!update_head_ok)
-		check_not_current_branch(ref_map, worktrees);
+		check_not_current_branch(ref_map);
 
 	retcode = open_fetch_head(&fetch_head);
 	if (retcode)
diff --git a/t/t2407-worktree-heads.sh b/t/t2407-worktree-heads.sh
index a838f2be474..1fbde05fe2b 100755
--- a/t/t2407-worktree-heads.sh
+++ b/t/t2407-worktree-heads.sh
@@ -15,6 +15,21 @@ test_expect_success 'setup' '
 		test_commit $i &&
 		git branch wt-$i &&
 		git worktree add wt-$i wt-$i || return 1
+	done &&
+
+	# Create a server that updates each branch by one commit
+	git init server &&
+	test_commit -C server initial &&
+	git remote add server ./server &&
+	for i in 1 2 3 4
+	do
+		git -C server checkout -b wt-$i &&
+		test_commit -C server A-$i || return 1
+	done &&
+	for i in 1 2
+	do
+		git -C server checkout -b fake-$i &&
+		test_commit -C server f-$i || return 1
 	done
 '
 
@@ -48,4 +63,36 @@ test_expect_success 'refuse to overwrite: worktree in rebase' '
 	grep "cannot force update the branch '\''fake-1'\'' checked out at.*wt-3" err
 '
 
+test_expect_success !SANITIZE_LEAK 'refuse to fetch over ref: checked out' '
+	test_must_fail git fetch server +refs/heads/wt-3:refs/heads/wt-3 2>err &&
+	grep "refusing to fetch into branch '\''refs/heads/wt-3'\''" err &&
+
+	# General fetch into refs/heads/ will fail on first ref,
+	# so use a generic error message check.
+	test_must_fail git fetch server +refs/heads/*:refs/heads/* 2>err &&
+	grep "refusing to fetch into branch" err
+'
+
+test_expect_success !SANITIZE_LEAK 'refuse to fetch over ref: worktree in bisect' '
+	test_when_finished rm -rf .git/worktrees/wt-*/BISECT_* &&
+
+	touch .git/worktrees/wt-4/BISECT_LOG &&
+	echo refs/heads/fake-2 >.git/worktrees/wt-4/BISECT_START &&
+
+	test_must_fail git fetch server +refs/heads/fake-2:refs/heads/fake-2 2>err &&
+	grep "refusing to fetch into branch" err
+'
+
+test_expect_success !SANITIZE_LEAK 'refuse to fetch over ref: worktree in rebase' '
+	test_when_finished rm -rf .git/worktrees/wt-*/rebase-merge &&
+
+	mkdir -p .git/worktrees/wt-4/rebase-merge &&
+	touch .git/worktrees/wt-4/rebase-merge/interactive &&
+	echo refs/heads/fake-1 >.git/worktrees/wt-4/rebase-merge/head-name &&
+	echo refs/heads/fake-2 >.git/worktrees/wt-4/rebase-merge/onto &&
+
+	test_must_fail git fetch server +refs/heads/fake-1:refs/heads/fake-1 2>err &&
+	grep "refusing to fetch into branch" err
+'
+
 test_done
-- 
gitgitgadget

