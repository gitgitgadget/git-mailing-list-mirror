Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 568BD20A1E
	for <e@80x24.org>; Mon, 10 Dec 2018 19:05:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728997AbeLJTFE (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Dec 2018 14:05:04 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46715 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727849AbeLJTFC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Dec 2018 14:05:02 -0500
Received: by mail-pl1-f194.google.com with SMTP id t13so5660789ply.13
        for <git@vger.kernel.org>; Mon, 10 Dec 2018 11:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8G/FQvpdgnWC0xyRAdmxw4IEnc2iEmPQo9XZh+Ndtzw=;
        b=CK1e+LuvUHeZIg+7Ez67wJmhCJgxaPpFNh+0DYTmDJRH+OrpynA065hsjqrpIXUH3d
         5K8XQ4vgLXjShby3umuv+lPFzdyWN0Dc2fDaYJntoM30Z0usthDrh/JZiOjSHqoMpKEv
         7KRelWlpQXIwuTy0O7iwcU6MqqAFeYIPfqIiQ48FedeqrSO5jFAC2x629vXL6SHiKfuH
         7QT3E21FOR+AmFAaL6Vyjp6cW86t62xSxnBBWEJNmfRW4b/YBvQ4pw7vFjsIa2ozvG2X
         /xmCXAWDwWEVeNQfYU0eb7o9+MKkUeivyCdEgj4JiCNOnsVGOJXlvM/H2N3LsClXP3dO
         b6lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=8G/FQvpdgnWC0xyRAdmxw4IEnc2iEmPQo9XZh+Ndtzw=;
        b=mNrXHHs9EJ4cWl3FIesX8UfS+i3srDhJM98RlojOZ22oMcteqpVd4joeitL3P/PPXp
         l7hGP8kwKmpWsQ8LqGDM698rYHFG0BkgFUZdyoq9Raga7VUfR+6paW6tRS2RxhKgLFu+
         IOqW4aU8l774U/REEES4dzfqFrp+y0sA9hnPC3H/dk/lrvXmtmr6vpz0/yQBHHbA8Ndx
         Brewg+e1ZoCvzijnowjnmJQMINkWbyJgkzqRXOUV213yZnqMK06q9vk84q0VpEjegV8I
         PGEAu0EjuMNVPvLQkgN/XY2JFXVU29IroGMmLbw3N1kO+XKpKquMx8wPTx7/W+x+AkN3
         Wq3w==
X-Gm-Message-State: AA+aEWZrc/LRJdLvWvoIEJWX/fY8PG93oQNx47v8Az/WPyqrr2G3azVX
        eZWyZP3kNmXaazilOlaQLwQdw8Y+
X-Google-Smtp-Source: AFSGD/WAyJI+D/miB6ws5dHxYfma2Txa2ZU76IE1y4HY9A/PysITn2xwR4oGLWfUZMLHqY3QKVT62g==
X-Received: by 2002:a17:902:848d:: with SMTP id c13mr13224242plo.257.1544468701857;
        Mon, 10 Dec 2018 11:05:01 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id f6sm17883599pfg.188.2018.12.10.11.05.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 11:05:01 -0800 (PST)
Date:   Mon, 10 Dec 2018 11:05:01 -0800 (PST)
X-Google-Original-Date: Mon, 10 Dec 2018 19:04:55 GMT
Message-Id: <86ed094426bd7d18f24ede841e08756efcf30caa.1544468696.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.90.git.gitgitgadget@gmail.com>
References: <pull.90.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 3/3] rebase: introduce a shortcut for --reschedule-failed-exec
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

It is a bit cumbersome to write out the `--reschedule-failed-exec`
option before `-x <cmd>` all the time; let's introduce a convenient
option to do both at the same time: `-y <cmd>`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/git-rebase.txt |  6 ++++++
 builtin/rebase.c             | 21 +++++++++++++++++++++
 git-legacy-rebase.sh         |  6 ++++++
 t/t3418-rebase-continue.sh   |  3 +++
 4 files changed, 36 insertions(+)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 9dd68f77f6..99ca589ffc 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -462,6 +462,12 @@ without an explicit `--interactive`.
 +
 See also INCOMPATIBLE OPTIONS below.
 
+-y <cmd>::
+	This is the same as passing `--reschedule-failed-exec` before
+	`-x <cmd>`, i.e. it appends the specified `exec` command and
+	turns on the mode where failed `exec` commands are automatically
+	rescheduled.
+
 --root::
 	Rebase all commits reachable from <branch>, instead of
 	limiting them with an <upstream>.  This allows you to rebase
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 06e450b537..b707ccf00f 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -754,6 +754,23 @@ static int parse_opt_interactive(const struct option *opt, const char *arg,
 	return 0;
 }
 
+struct opt_y {
+	struct string_list *list;
+	struct rebase_options *options;
+};
+
+static int parse_opt_y(const struct option *opt, const char *arg, int unset)
+{
+	struct opt_y *o = opt->value;
+
+	if (unset || !arg)
+		return -1;
+
+	o->options->reschedule_failed_exec = 1;
+	string_list_append(o->list, arg);
+	return 0;
+}
+
 static void NORETURN error_on_missing_default_upstream(void)
 {
 	struct branch *current_branch = branch_get(NULL);
@@ -817,6 +834,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	struct string_list strategy_options = STRING_LIST_INIT_NODUP;
 	struct object_id squash_onto;
 	char *squash_onto_name = NULL;
+	struct opt_y opt_y = { .list = &exec, .options = &options };
 	struct option builtin_rebase_options[] = {
 		OPT_STRING(0, "onto", &options.onto_name,
 			   N_("revision"),
@@ -894,6 +912,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		OPT_STRING_LIST('x', "exec", &exec, N_("exec"),
 				N_("add exec lines after each commit of the "
 				   "editable list")),
+		{ OPTION_CALLBACK, 'y', NULL, &opt_y, N_("<cmd>"),
+			N_("same as --reschedule-failed-exec -x <cmd>"),
+			PARSE_OPT_NONEG, parse_opt_y },
 		OPT_BOOL(0, "allow-empty-message",
 			 &options.allow_empty_message,
 			 N_("allow rebasing commits with empty messages")),
diff --git a/git-legacy-rebase.sh b/git-legacy-rebase.sh
index 1b268a5fcc..8048891fed 100755
--- a/git-legacy-rebase.sh
+++ b/git-legacy-rebase.sh
@@ -26,6 +26,7 @@ f,force-rebase!    cherry-pick all commits, even if unchanged
 m,merge!           use merging strategies to rebase
 i,interactive!     let the user edit the list of commits to rebase
 x,exec=!           add exec lines after each commit of the editable list
+y=!                same as --reschedule-failed-exec -x
 k,keep-empty	   preserve empty commits during rebase
 allow-empty-message allow rebasing commits with empty messages
 stat!              display a diffstat of what changed upstream
@@ -262,6 +263,11 @@ do
 		cmd="${cmd}exec ${1#--exec=}${LF}"
 		test -z "$interactive_rebase" && interactive_rebase=implied
 		;;
+	-y*)
+		reschedule_failed_exec=--reschedule-failed-exec
+		cmd="${cmd}exec ${1#-y}${LF}"
+		test -z "$interactive_rebase" && interactive_rebase=implied
+		;;
 	--interactive)
 		interactive_rebase=explicit
 		;;
diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
index bdaa511bb0..25aaacacfc 100755
--- a/t/t3418-rebase-continue.sh
+++ b/t/t3418-rebase-continue.sh
@@ -262,6 +262,9 @@ test_expect_success '--reschedule-failed-exec' '
 	test_must_fail git -c rebase.rescheduleFailedExec=true \
 		rebase -x false HEAD^ 2>err &&
 	grep "^exec false" .git/rebase-merge/git-rebase-todo &&
+	test_i18ngrep "has been rescheduled" err &&
+	git rebase --abort &&
+	test_must_fail git rebase -y false HEAD^ 2>err &&
 	test_i18ngrep "has been rescheduled" err
 '
 
-- 
gitgitgadget
