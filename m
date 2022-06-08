Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB4D9C433EF
	for <git@archiver.kernel.org>; Wed,  8 Jun 2022 20:09:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234229AbiFHUJU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jun 2022 16:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbiFHUJL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jun 2022 16:09:11 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9555AFB34
        for <git@vger.kernel.org>; Wed,  8 Jun 2022 13:09:09 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id q26so19356476wra.1
        for <git@vger.kernel.org>; Wed, 08 Jun 2022 13:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ooa+r+KA0ROv78hgZ3byUALMb8dAeoa5zSIOtZeuH74=;
        b=B61092oDahMktdge4VLs7oFOKnM/1bZl4RGYGTjYXiOge8GcOFZA5y+O2OY+LLbgvk
         35e0ASutPQFWpY9F1icHb33C48g9aw6IFDv9S7af/nlNfLmCj0mUWgciSq6XUI1LqiqI
         YPthGNU6DWfSH8K75r5RO+GK8y6Ku06uWBbwbeFYYR58SZDI+417FZJTGMCIf0z5Mdgd
         oKF8/ZNWxu+j5btSAnjnWEqiG7a0Ndaup5KlDZbQ2Gp2MuCh2fN8b7b1gZJ9qJxTTTYU
         mh9isSFJwD78hiFBQflFcrhnPEL4N4Eqzo7fPWLMO9LO+792XVyuHSarD1rtBIZJDGh+
         zaJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ooa+r+KA0ROv78hgZ3byUALMb8dAeoa5zSIOtZeuH74=;
        b=Zk2Xf+IGdnMp3MUEiOoXB7pOvx1T4QYJHxhqmwz9W/eWBZ8XujXjnc42VVmoWqT7HO
         PiRXruvp1bStTH50jPnpuLzxw9RXIhLwz8Rb7MElefhOwm6QNznwfw2rdDIqv7nkRH/B
         hkxAzIhDYM4wFAhHIskfOcAGdnRG0nH+mj6fXKi0mBH7ZhINWykWCNFDZ0hqgCY76a5J
         PPKdqrQc1eLVcMXZH7gSOBATZO1tK7PcUvcBnMceuDaoemuEzPz9MjjZC7PMh19Og3VP
         F9QBGMMUSYmqQw8SdZ4e3o5a7T/zamcQBVgAKrSxje9RqDcCE1FjkrnFaFTtyWWEhD2M
         sVFg==
X-Gm-Message-State: AOAM532/a4F9dDc+08GH3vUsvZmUF1ZfCJmQbBOfk86oJWpJPWfgwOQL
        F+yan7J0MhqBEPTLGxJBeFYIm8MwIJuqwdAg
X-Google-Smtp-Source: ABdhPJy5UIvd7qZI1NUUwhIAHazVKi7wRbwN2BXSFyhaqBbSGovMgd3ZbJl5/HZ3NtPiut0a5N1i6A==
X-Received: by 2002:adf:ded2:0:b0:218:4336:55b1 with SMTP id i18-20020adfded2000000b00218433655b1mr15390822wrn.24.1654718948151;
        Wed, 08 Jun 2022 13:09:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n27-20020a05600c3b9b00b0039c64d0c4e8sm3004515wms.45.2022.06.08.13.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 13:09:07 -0700 (PDT)
Message-Id: <4540dbeed385341f8c5b45134e1a65dc48c75b0c.1654718942.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1254.git.1654718942.gitgitgadget@gmail.com>
References: <pull.1254.git.1654718942.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 08 Jun 2022 20:09:01 +0000
Subject: [PATCH 3/4] fetch: use new branch_checked_out() and add tests
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, johannes.schindelin@gmx.de, me@ttaylorr.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
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
complicated to be worth the effort.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 builtin/fetch.c           | 25 +++++++++++--------------
 t/t2407-worktree-heads.sh | 29 +++++++++++++++++++++++++++--
 2 files changed, 38 insertions(+), 16 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index ac29c2b1ae3..1ba56240312 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -885,7 +885,7 @@ static int update_local_ref(struct ref *ref,
 			    struct worktree **worktrees)
 {
 	struct commit *current = NULL, *updated;
-	const struct worktree *wt;
+	char *path = NULL;
 	const char *pretty_ref = prettify_refname(ref->name);
 	int fast_forward = 0;
 
@@ -900,17 +900,17 @@ static int update_local_ref(struct ref *ref,
 	}
 
 	if (!update_head_ok &&
-	    (wt = find_shared_symref(worktrees, "HEAD", ref->name)) &&
-	    !wt->is_bare && !is_null_oid(&ref->old_oid)) {
+	    !is_null_oid(&ref->old_oid) &&
+	    branch_checked_out(ref->name, &path)) {
 		/*
 		 * If this is the head, and it's not okay to update
 		 * the head, and the old value of the head isn't empty...
 		 */
 		format_display(display, '!', _("[rejected]"),
-			       wt->is_current ?
-				       _("can't fetch in current branch") :
-				       _("checked out in another worktree"),
+			       path ? _("can't fetch in current branch") :
+				      _("checked out in another worktree"),
 			       remote, pretty_ref, summary_width);
+		free(path);
 		return 1;
 	}
 
@@ -1434,19 +1434,16 @@ cleanup:
 	return result;
 }
 
-static void check_not_current_branch(struct ref *ref_map,
-				     struct worktree **worktrees)
+static void check_not_current_branch(struct ref *ref_map)
 {
-	const struct worktree *wt;
+	char *path;
 	for (; ref_map; ref_map = ref_map->next)
 		if (ref_map->peer_ref &&
 		    starts_with(ref_map->peer_ref->name, "refs/heads/") &&
-		    (wt = find_shared_symref(worktrees, "HEAD",
-					     ref_map->peer_ref->name)) &&
-		    !wt->is_bare)
+		    branch_checked_out(ref_map->peer_ref->name, &path))
 			die(_("refusing to fetch into branch '%s' "
 			      "checked out at '%s'"),
-			    ref_map->peer_ref->name, wt->path);
+			    ref_map->peer_ref->name, path);
 }
 
 static int truncate_fetch_head(void)
@@ -1650,7 +1647,7 @@ static int do_fetch(struct transport *transport,
 	ref_map = get_ref_map(transport->remote, remote_refs, rs,
 			      tags, &autotags);
 	if (!update_head_ok)
-		check_not_current_branch(ref_map, worktrees);
+		check_not_current_branch(ref_map);
 
 	retcode = open_fetch_head(&fetch_head);
 	if (retcode)
diff --git a/t/t2407-worktree-heads.sh b/t/t2407-worktree-heads.sh
index 12faca7f655..f3f8b0b2b79 100755
--- a/t/t2407-worktree-heads.sh
+++ b/t/t2407-worktree-heads.sh
@@ -10,6 +10,15 @@ test_expect_success 'setup' '
 		test_commit $i &&
 		git branch wt-$i &&
 		git worktree add wt-$i wt-$i || return 1
+	done &&
+
+	# Create a server that updates each branch by one commit
+	git clone . server &&
+	git remote add server ./server &&
+	for i in 1 2 3 4
+	do
+		git -C server checkout wt-$i &&
+		test_commit -C server A-$i || return 1
 	done
 '
 
@@ -21,6 +30,16 @@ test_expect_success 'refuse to overwrite: checked out in worktree' '
 	done
 '
 
+test_expect_success 'refuse to overwrite during fetch' '
+	test_must_fail git fetch server +refs/heads/wt-3:refs/heads/wt-3 2>err &&
+	grep "refusing to fetch into branch '\''refs/heads/wt-3'\''" err &&
+
+	# General fetch into refs/heads/ will fail on first ref,
+	# so use a generic error message check.
+	test_must_fail git fetch server +refs/heads/*:refs/heads/* 2>err &&
+	grep "refusing to fetch into branch" err
+'
+
 test_expect_success 'refuse to overwrite: worktree in bisect' '
 	test_when_finished test_might_fail git -C wt-4 bisect reset &&
 
@@ -31,7 +50,10 @@ test_expect_success 'refuse to overwrite: worktree in bisect' '
 	) &&
 
 	test_must_fail git branch -f wt-4 HEAD 2>err &&
-	grep "cannot force update the branch '\''wt-4'\'' checked out at" err
+	grep "cannot force update the branch '\''wt-4'\'' checked out at" err &&
+
+	test_must_fail git fetch server +refs/heads/wt-4:refs/heads/wt-4 2>err &&
+	grep "refusing to fetch into branch '\''refs/heads/wt-4'\''" err
 '
 
 . "$TEST_DIRECTORY"/lib-rebase.sh
@@ -47,7 +69,10 @@ test_expect_success 'refuse to overwrite: worktree in rebase' '
 	) &&
 
 	test_must_fail git branch -f wt-4 HEAD 2>err &&
-	grep "cannot force update the branch '\''wt-4'\'' checked out at" err
+	grep "cannot force update the branch '\''wt-4'\'' checked out at" err &&
+
+	test_must_fail git fetch server +refs/heads/wt-4:refs/heads/wt-4 2>err &&
+	grep "refusing to fetch into branch '\''refs/heads/wt-4'\''" err
 '
 
 test_done
-- 
gitgitgadget

