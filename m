Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92F431F516
	for <e@80x24.org>; Mon, 25 Jun 2018 13:44:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933938AbeFYNo4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Jun 2018 09:44:56 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:34031 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755594AbeFYNou (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jun 2018 09:44:50 -0400
Received: by mail-wr0-f193.google.com with SMTP id a12-v6so13770917wro.1
        for <git@vger.kernel.org>; Mon, 25 Jun 2018 06:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=enxU5UB0nacE2eR7DfVpvA2BKlPdraX/RHM32Kf/cr4=;
        b=Fi8WyrtHoUVO8K6U5WAuOOF+0k8vjyUyOOzPfbDr6nkH0AkI8zMk60y3LS4j6NItJN
         oG60rGyNPK8kf9KoNf+KWjPL8QU7axarRI1G/QQcEjnrw59uHpE2VhvNJyx+5o4JZuBr
         gVlvoCwNlKvg/VMjiwUmg8lXft9DOKeNBJsqYjHX9cnK7iBfFRgZQTqhpydOoYQNRfhi
         6loFQNr7aYXH3je9wNGY7u4VyYBx5inGlNEqL0X4RIpicbB0wiYg5g64uOsZUh11Tt3u
         K0ZVN2iXhj93VT2SWsm9AGACZqyQSSPVAOg3t7c9SIuzR+fu58/PtNUYi/kU7m6iiQJa
         YzqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=enxU5UB0nacE2eR7DfVpvA2BKlPdraX/RHM32Kf/cr4=;
        b=Sqse24H0TrClR79c28XFF46HquOg6WuJK3JsQ/wSlqMqATvfk/DxDyDSHYH/AzSyH0
         sCidiBRImgqx2wZPkuw6gIscjd50uyjIysiO6M1RjA5d2+DRp4t8Q3tRr/I4y+LgEkBT
         wZu8Ip+APrS+WuF7HVgNKpC0UIRc1SGg1UsL/81JmipZCT6gG0sauUZI1FsYr6OMb70M
         JWqK/ZohOQzJ/OAWWNFAwxYZNn92Es6CusLzSy/nwSe49M/azxUpVU+fn9XtlcQtJEq6
         5A7EbN5DaKbQBX3dKntjd7zZmaIE8+c6sNvBvgLoD4+FVp6iB9EmyQ8+kZMDC0aZ6cN7
         QalA==
X-Gm-Message-State: APt69E0ete3HjqO8LfUxqsYGlRWekStvVlnzweBi8wdRqnoNSbTVC5XT
        nkjCz5q+zioO2NyUOqSWIEzqwl0U
X-Google-Smtp-Source: AAOMgpfIwKGFHhs3ecuXCAEte5tD86GIBrMvGCM7/AvDOvI/66R64ZAxRxzKXSrvG0P1oSyveIK+1A==
X-Received: by 2002:adf:e392:: with SMTP id e18-v6mr10650826wrm.94.1529934288847;
        Mon, 25 Jun 2018 06:44:48 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-38-233.w86-221.abo.wanadoo.fr. [86.221.117.233])
        by smtp.googlemail.com with ESMTPSA id 13-v6sm11020369wmi.2.2018.06.25.06.44.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 06:44:47 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, Elijah Newren <newren@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH v4 3/3] rebase -i: rewrite setup_reflog_action() in C
Date:   Mon, 25 Jun 2018 15:44:19 +0200
Message-Id: <20180625134419.18435-4-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180625134419.18435-1-alban.gruin@gmail.com>
References: <20180621141732.19952-1-alban.gruin@gmail.com>
 <20180625134419.18435-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This rewrites (the misnamed) setup_reflog_action() from shell to C. The
new version is called checkout_onto().

A new command is added to rebase--helper.c, “checkout-base”. The shell
version is then stripped.

As $GIT_REFLOG_ACTION is no longer set at the first call of
checkout_onto(), a call to comment_for_reflog() is added at the
beginning of this function.

If the commit OID provided to checkout_onto() is empty, nothing happens
and no errors are returned, otherwise it would break some
tests (t3404.92 and t3404.93).

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 builtin/rebase--helper.c   |  6 +++++-
 git-rebase--interactive.sh | 15 +--------------
 sequencer.c                | 14 ++++++++++++++
 sequencer.h                |  2 ++
 4 files changed, 22 insertions(+), 15 deletions(-)

diff --git a/builtin/rebase--helper.c b/builtin/rebase--helper.c
index 2dfd55c76..a00b1091d 100644
--- a/builtin/rebase--helper.c
+++ b/builtin/rebase--helper.c
@@ -17,7 +17,7 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 	enum {
 		CONTINUE = 1, ABORT, MAKE_SCRIPT, SHORTEN_OIDS, EXPAND_OIDS,
 		CHECK_TODO_LIST, SKIP_UNNECESSARY_PICKS, REARRANGE_SQUASH,
-		ADD_EXEC, APPEND_TODO_HELP, EDIT_TODO, DETACH_ONTO
+		ADD_EXEC, APPEND_TODO_HELP, EDIT_TODO, DETACH_ONTO, CHECKOUT_ONTO
 	} command = 0;
 	struct option options[] = {
 		OPT_BOOL(0, "ff", &opts.allow_ff, N_("allow fast-forward")),
@@ -53,6 +53,8 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 			    EDIT_TODO),
 		OPT_CMDMODE(0, "detach-onto", &command,
 			    N_("checkout a commit"), DETACH_ONTO),
+		OPT_CMDMODE(0, "checkout-onto", &command,
+			    N_("checkout the base commit"), CHECKOUT_ONTO),
 		OPT_END()
 	};
 
@@ -98,5 +100,7 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 		return !!edit_todo_list(flags);
 	if (command == DETACH_ONTO && argc == 4)
 		return !!detach_onto(&opts, argv[1], argv[2], argv[3], verbose);
+	if (command == CHECKOUT_ONTO && argc == 2)
+		return !!checkout_onto(&opts, argv[1], verbose);
 	usage_with_options(builtin_rebase_helper_usage, options);
 }
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 2f5761d49..375c36fb5 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -112,19 +112,6 @@ initiate_action () {
 	esac
 }
 
-setup_reflog_action () {
-	comment_for_reflog start
-
-	if test ! -z "$switch_to"
-	then
-		GIT_REFLOG_ACTION="$GIT_REFLOG_ACTION: checkout $switch_to"
-		output git checkout "$switch_to" -- ||
-			die "$(eval_gettext "Could not checkout \$switch_to")"
-
-		comment_for_reflog start
-	fi
-}
-
 init_basic_state () {
 	orig_head=$(git rev-parse --verify HEAD) || die "$(gettext "No HEAD?")"
 	mkdir -p "$state_dir" || die "$(eval_gettext "Could not create temporary \$state_dir")"
@@ -206,7 +193,7 @@ git_rebase__interactive () {
 		return 0
 	fi
 
-	setup_reflog_action
+	git rebase--helper --checkout-onto "$switch_to" ${verbose:+--verbose}
 	init_basic_state
 
 	init_revisions_and_shortrevisions
diff --git a/sequencer.c b/sequencer.c
index ee6374921..620b41e96 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3165,6 +3165,20 @@ int detach_onto(struct replay_opts *opts,
 	return update_ref(NULL, "ORIG_HEAD", &oid, NULL, 0, UPDATE_REFS_MSG_ON_ERR);
 }
 
+int checkout_onto(struct replay_opts *opts, const char *commit,
+		  int verbose)
+{
+	const char *action;
+
+	if (commit && *commit) {
+		action = reflog_message(opts, "start", "checkout %s", commit);
+		if (run_git_checkout(opts, commit, verbose, action))
+			return error(_("Could not checkout %s"), commit);
+	}
+
+	return 0;
+}
+
 static const char rescheduled_advice[] =
 N_("Could not execute the todo command\n"
 "\n"
diff --git a/sequencer.h b/sequencer.h
index 9f0ac5e75..afbb2edf1 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -103,6 +103,8 @@ void commit_post_rewrite(const struct commit *current_head,
 int detach_onto(struct replay_opts *opts,
 		const char *onto_name, const char *onto,
 		const char *orig_head, unsigned verbose);
+int checkout_onto(struct replay_opts *opts, const char *commit,
+		  int verbose);
 
 #define SUMMARY_INITIAL_COMMIT   (1 << 0)
 #define SUMMARY_SHOW_AUTHOR_DATE (1 << 1)
-- 
2.18.0

