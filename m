Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7568C20248
	for <e@80x24.org>; Fri, 29 Mar 2019 10:40:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729121AbfC2Kk3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Mar 2019 06:40:29 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45586 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728858AbfC2Kk3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Mar 2019 06:40:29 -0400
Received: by mail-pf1-f194.google.com with SMTP id e24so858791pfi.12
        for <git@vger.kernel.org>; Fri, 29 Mar 2019 03:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KLjMC0gWwQ14+sVWjBuPYxax41jDf2KnKxeCS3H54Vc=;
        b=YQqNB6bE6edqaIG3vfWnJX3xmGiM+8UgmWU/oQ62sq3ITmpyQy2NCh08I6gblsg0I2
         jVhJzqJj3t9bBHrftFrMQPuwqv1i7P2Lz7v8z02ofUrTKgS6KCMnYxxARAtiIDJGg88U
         h4DkZhv48umIejRLmQto0oqpPuMyd77D1stp9YKsLGDeMMqnLGzPKx4Vl4HeotPs5nLV
         JylkdKaAdPVLUiMPCtV7fQtbPDs21pRkhgYAsP7KNH6taiDzZuISnOsKC6/Pvx3b4ehN
         OUUOneMpo762j/pASWpiPteG4z4uvmls917P8sn/hv5Jkm38ILnU53JJg5fHcLghvEvf
         uYAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KLjMC0gWwQ14+sVWjBuPYxax41jDf2KnKxeCS3H54Vc=;
        b=UkWTC4TwQsi3xYKz+QT25L9dFm/F4FsmU/38/nqkq4XsbwhEJ/iE92m0hwmOs5oHYm
         93Dl7YPwIKmqRlwUJK4I2v13LWrcO6oUG/wlefRbP7bfgLPLeovZFFlNYTNkBda0syXe
         K4EoKElpDf1lPJI7qpVPcVVf9OrRXrk7kgZt2L2ZNCw2bKbpzOsWZ660ULAo4/ltzWzT
         x5mojSxu2RFbAWrXjmtGgIeZzJ+HBkQ+vdznwNKMXcDgYpD+tuSy+aB7OMu3Cbyl8zNB
         NsbkJvCt9NGJ5/bBrL+rX/rJZFERyZkUQW7NCm4zpgxkD0DRzRzmPj3+BtTeQBXriv4W
         jL2A==
X-Gm-Message-State: APjAAAXk1M3OhR+WeG2Rzqj7mTSBWZ8KpDKVEbR2peb4aobbGxe9VxgM
        nRQng6Vxov/PePLEXHxEggc=
X-Google-Smtp-Source: APXvYqxbzt1CGPmkRlI1a597Dx2GvVPyU/bYyj6VLU3dP3gUWaBU2fGabj80QaX4qWRId78OKxX35A==
X-Received: by 2002:a62:293:: with SMTP id 141mr45584092pfc.245.1553856028423;
        Fri, 29 Mar 2019 03:40:28 -0700 (PDT)
Received: from ash ([171.236.209.43])
        by smtp.gmail.com with ESMTPSA id z6sm2899799pgo.31.2019.03.29.03.40.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 03:40:27 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Fri, 29 Mar 2019 17:40:22 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     eckhard.s.maass@googlemail.com, git@vger.kernel.org,
        gitster@pobox.com, jacob.keller@gmail.com, martin.agren@gmail.com,
        newren@gmail.com, phillip.wood123@gmail.com, rybak.a.v@gmail.com,
        sunshine@sunshineco.com, szeder.dev@gmail.com
Subject: [PATCH v6 07/27] checkout: inform the user when removing branch state
Date:   Fri, 29 Mar 2019 17:38:59 +0700
Message-Id: <20190329103919.15642-8-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.479.g47ac719cd3
In-Reply-To: <20190329103919.15642-1-pclouds@gmail.com>
References: <20190321131655.15249-1-pclouds@gmail.com>
 <20190329103919.15642-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After a successful switch, if a merge, cherry-pick or revert is ongoing,
it is canceled. This behavior has been with us from the very early
beginning, soon after git-merge was created but never actually
documented [1]. It may be a good idea to be transparent and tell the
user if some operation is canceled.

I consider this a better way of telling the user than just adding a
sentence or two in git-checkout.txt, which will be mostly ignored
anyway.

PS. Originally I wanted to print more details like

    warning: cancelling an in-progress merge from <SHA-1>

which may allow some level of undo if the user wants to. But that seems
a lot more work. Perhaps it can be improved later if people still want
that.

[1] ... and I will try not to argue whether it is a sensible behavior.
There is some more discussion here if people are interested:
CACsJy8Axa5WsLSjiscjnxVK6jQHkfs-gH959=YtUvQkWriAk5w@mail.gmail.com

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 branch.c           | 11 +++++++----
 branch.h           |  2 +-
 builtin/am.c       |  2 +-
 builtin/checkout.c |  2 +-
 builtin/rebase.c   |  4 ++--
 builtin/reset.c    |  2 +-
 builtin/revert.c   |  2 +-
 7 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/branch.c b/branch.c
index 28b81a7e02..8dd5bb9f1c 100644
--- a/branch.c
+++ b/branch.c
@@ -337,11 +337,14 @@ void create_branch(struct repository *r,
 	free(real_ref);
 }
 
-void remove_branch_state(struct repository *r)
+void remove_branch_state(struct repository *r, int verbose)
 {
-	unlink(git_path_cherry_pick_head(r));
-	unlink(git_path_revert_head(r));
-	unlink(git_path_merge_head(r));
+	if (!unlink(git_path_cherry_pick_head(r)) && verbose)
+		warning(_("cancelling a cherry picking in progress"));
+	if (!unlink(git_path_revert_head(r)) && verbose)
+		warning(_("cancelling a revert in progress"));
+	if (!unlink(git_path_merge_head(r)) && verbose)
+		warning(_("cancelling a merge in progress"));
 	unlink(git_path_merge_rr(r));
 	unlink(git_path_merge_msg(r));
 	unlink(git_path_merge_mode(r));
diff --git a/branch.h b/branch.h
index 29c1afa4d0..aed045901e 100644
--- a/branch.h
+++ b/branch.h
@@ -64,7 +64,7 @@ extern int validate_new_branchname(const char *name, struct strbuf *ref, int for
  * Remove information about the state of working on the current
  * branch. (E.g., MERGE_HEAD)
  */
-void remove_branch_state(struct repository *r);
+void remove_branch_state(struct repository *r, int verbose);
 
 /*
  * Configure local branch "local" as downstream to branch "remote"
diff --git a/builtin/am.c b/builtin/am.c
index 4fb107a9d1..99b66508fd 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1957,7 +1957,7 @@ static int clean_index(const struct object_id *head, const struct object_id *rem
 	if (merge_tree(remote_tree))
 		return -1;
 
-	remove_branch_state(the_repository);
+	remove_branch_state(the_repository, 0);
 
 	return 0;
 }
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 0e6037b296..f66bd2f56d 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -899,7 +899,7 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
 				delete_reflog(old_branch_info->path);
 		}
 	}
-	remove_branch_state(the_repository);
+	remove_branch_state(the_repository, !opts->quiet);
 	strbuf_release(&msg);
 	if (!opts->quiet &&
 	    (new_branch_info->path || (!opts->force_detach && !strcmp(new_branch_info->name, "HEAD"))))
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 52114cbf0d..646d0f9fb1 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1272,7 +1272,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		if (reset_head(NULL, "reset", NULL, RESET_HEAD_HARD,
 			       NULL, NULL) < 0)
 			die(_("could not discard worktree changes"));
-		remove_branch_state(the_repository);
+		remove_branch_state(the_repository, 0);
 		if (read_basic_state(&options))
 			exit(1);
 		goto run_rebase;
@@ -1292,7 +1292,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			       NULL, NULL) < 0)
 			die(_("could not move back to %s"),
 			    oid_to_hex(&options.orig_head));
-		remove_branch_state(the_repository);
+		remove_branch_state(the_repository, 0);
 		ret = finish_rebase(&options);
 		goto cleanup;
 	}
diff --git a/builtin/reset.c b/builtin/reset.c
index 7882829a95..6d9397c844 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -420,7 +420,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 			print_new_head_line(lookup_commit_reference(the_repository, &oid));
 	}
 	if (!pathspec.nr)
-		remove_branch_state(the_repository);
+		remove_branch_state(the_repository, 0);
 
 	return update_ref_status;
 }
diff --git a/builtin/revert.c b/builtin/revert.c
index a47b53ceaf..ebf2789225 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -196,7 +196,7 @@ static int run_sequencer(int argc, const char **argv, struct replay_opts *opts)
 	if (cmd == 'q') {
 		int ret = sequencer_remove_state(opts);
 		if (!ret)
-			remove_branch_state(the_repository);
+			remove_branch_state(the_repository, 0);
 		return ret;
 	}
 	if (cmd == 'c')
-- 
2.21.0.479.g47ac719cd3

