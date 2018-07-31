Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E572E1F597
	for <e@80x24.org>; Tue, 31 Jul 2018 18:00:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731578AbeGaTmK (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 15:42:10 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35029 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729598AbeGaTmK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 15:42:10 -0400
Received: by mail-wm0-f66.google.com with SMTP id o18-v6so4160037wmc.0
        for <git@vger.kernel.org>; Tue, 31 Jul 2018 11:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KtESFwLRHZvP0Om8d+pt4dbXPEmhRK1GYuFpdhFhQ2w=;
        b=lLyDA4SFMXxFRFwCz1gEIeTJ9MijFX0kf4B7bLnj78upRkXHa2QpiA6a6pr7YfLAZL
         TGO3H4IB2EorPrVO4+MKN/JxAHpYosGaSRn758eLJ+BDFyGpxr4HNeQ01qlIucaopTfI
         dY2OzSMHdtDKp9PWfDsC5VF8k/NKlbrHCm0wT/OKxrc5No6G6FdYBg+C1zfkG3yExJVQ
         DK73JMCXouycAQwN/fCJYrc1zDW3+BL8lo3cb/4aQ3INYpb0+koJZvX1Wi1X8hng5n45
         sj7nqZOX7BZfIJ9CGhA52WTd6TV8Z6kJ9n3khvr3F9QHL3tcnhGQG7fqCf4wj+Vgi7JF
         DWlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KtESFwLRHZvP0Om8d+pt4dbXPEmhRK1GYuFpdhFhQ2w=;
        b=mKyGNY7zs1gKAH+t8PDq6cgsd9vha+7tuvi4b4+u7RuQQPOwA5p2rlkUQ7KxhIN2WO
         IgVQ4mueNlkbC7XCiYAXw+79atEFQKdDDe/0/CsC38ti8DKYYGe0ZBd6HVtSNjeYA+2r
         /Xlz1Ppds2HFOzmX2zNReSfdH52X9LgRKfRAgjdndBkHZPVy4vTFy+E9tSYJTrwF4+kL
         Dlamp2MGBYGB7H6xUfzBy9+4n+ao9jmHwGXf+UEf9/zg1KeV8BAE//V/Ulq8K8mxyYfs
         kUQS7XfnpZa1IWIHX+AQru/Sk8Vm2fVTXkwNiTVwyap8Q2/5ocz6nVlVwDCN+OLYNsEB
         77vQ==
X-Gm-Message-State: AOUpUlFj6RMMzRYlfzQKw0sE6mSJ4UnkR7OiAyso5kfn3hT2tAf3XwVZ
        7gErv+jDSiLUEsXqag00PZbx+8jm
X-Google-Smtp-Source: AAOMgpc4g8rtngQfJGc7CfxuIbhzw3Tc56QmNsY8HLn2IRe4pnvCREKi/+JAnZEacEvFcsWQhHQ7Vg==
X-Received: by 2002:a1c:6546:: with SMTP id z67-v6mr452335wmb.130.1533060040316;
        Tue, 31 Jul 2018 11:00:40 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-67-118.w92-136.abo.wanadoo.fr. [92.136.29.118])
        by smtp.googlemail.com with ESMTPSA id l10-v6sm20756602wrv.23.2018.07.31.11.00.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 11:00:39 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, gitster@pobox.com,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH v5 13/20] rebase -i: implement the logic to initialize $revisions in C
Date:   Tue, 31 Jul 2018 19:59:56 +0200
Message-Id: <20180731180003.5421-14-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180731180003.5421-1-alban.gruin@gmail.com>
References: <20180724163221.15201-1-alban.gruin@gmail.com>
 <20180731180003.5421-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This rewrites the part of init_revisions_and_shortrevisions() needed by
`--make-script` from shell to C.  The new version is called
get_revision_ranges(), and is a static function inside of
rebase--helper.c.  As this does not initialize $shortrevision, the
original shell version is not yet stripped.

Unlike init_revisions_and_shortrevisions(), get_revision_ranges()
doesn’t write $squash_onto to the state directory, it’s done by the
handler of `--make-script` instead.

Finally, this drops the $revision argument passed to `--make-script` in
git-rebase--interactive.sh, and rebase--helper is changed accordingly.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
No changes since v4.

 builtin/rebase--helper.c   | 56 ++++++++++++++++++++++++++++++++++++--
 git-rebase--interactive.sh |  4 ++-
 2 files changed, 56 insertions(+), 4 deletions(-)

diff --git a/builtin/rebase--helper.c b/builtin/rebase--helper.c
index 6085527b2b..15fa556f65 100644
--- a/builtin/rebase--helper.c
+++ b/builtin/rebase--helper.c
@@ -4,6 +4,25 @@
 #include "parse-options.h"
 #include "sequencer.h"
 #include "rebase-interactive.h"
+#include "argv-array.h"
+
+static GIT_PATH_FUNC(path_squash_onto, "rebase-merge/squash-onto")
+
+static int get_revision_ranges(const char *upstream, const char *onto,
+			       const char **head_hash,
+			       char **revisions)
+{
+	const char *base_rev = upstream ? upstream : onto;
+	struct object_id orig_head;
+
+	if (get_oid("HEAD", &orig_head))
+		return error(_("no HEAD?"));
+
+	*head_hash = find_unique_abbrev(&orig_head, GIT_MAX_HEXSZ);
+	*revisions = xstrfmt("%s...%s", base_rev, *head_hash);
+
+	return 0;
+}
 
 static const char * const builtin_rebase_helper_usage[] = {
 	N_("git rebase--helper [<options>]"),
@@ -14,7 +33,9 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 {
 	struct replay_opts opts = REPLAY_OPTS_INIT;
 	unsigned flags = 0, keep_empty = 0, rebase_merges = 0, autosquash = 0;
-	int abbreviate_commands = 0, rebase_cousins = -1;
+	int abbreviate_commands = 0, rebase_cousins = -1, ret;
+	const char *head_hash = NULL, *onto = NULL, *restrict_revision = NULL,
+		*squash_onto = NULL, *upstream = NULL;
 	enum {
 		CONTINUE = 1, ABORT, MAKE_SCRIPT, SHORTEN_OIDS, EXPAND_OIDS,
 		CHECK_TODO_LIST, REARRANGE_SQUASH, ADD_EXEC, EDIT_TODO, PREPARE_BRANCH,
@@ -54,6 +75,13 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 			    N_("prepare the branch to be rebased"), PREPARE_BRANCH),
 		OPT_CMDMODE(0, "complete-action", &command,
 			    N_("complete the action"), COMPLETE_ACTION),
+		OPT_STRING(0, "onto", &onto, N_("onto"), N_("onto")),
+		OPT_STRING(0, "restrict-revision", &restrict_revision,
+			   N_("restrict-revision"), N_("restrict revision")),
+		OPT_STRING(0, "squash-onto", &squash_onto, N_("squash-onto"),
+			   N_("squash onto")),
+		OPT_STRING(0, "upstream", &upstream, N_("upstream"),
+			   N_("the upstream commit")),
 		OPT_END()
 	};
 
@@ -81,8 +109,30 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 		return !!sequencer_continue(&opts);
 	if (command == ABORT && argc == 1)
 		return !!sequencer_remove_state(&opts);
-	if (command == MAKE_SCRIPT && argc > 1)
-		return !!sequencer_make_script(stdout, argc, argv, flags);
+	if (command == MAKE_SCRIPT && argc == 1) {
+		char *revisions = NULL;
+		struct argv_array make_script_args = ARGV_ARRAY_INIT;
+
+		if (!upstream && squash_onto)
+			write_file(path_squash_onto(), "%s\n", squash_onto);
+
+		ret = get_revision_ranges(upstream, onto, &head_hash, &revisions);
+		if (ret)
+			return ret;
+
+		argv_array_pushl(&make_script_args, "", revisions, NULL);
+		if (restrict_revision)
+			argv_array_push(&make_script_args, restrict_revision);
+
+		ret = sequencer_make_script(stdout,
+					    make_script_args.argc, make_script_args.argv,
+					    flags);
+
+		free(revisions);
+		argv_array_clear(&make_script_args);
+
+		return !!ret;
+	}
 	if ((command == SHORTEN_OIDS || command == EXPAND_OIDS) && argc == 1)
 		return !!transform_todos(flags);
 	if (command == CHECK_TODO_LIST && argc == 1)
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 0d66c0f8b8..4ca47aed1e 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -92,7 +92,9 @@ git_rebase__interactive () {
 	git rebase--helper --make-script ${keep_empty:+--keep-empty} \
 		${rebase_merges:+--rebase-merges} \
 		${rebase_cousins:+--rebase-cousins} \
-		$revisions ${restrict_revision+^$restrict_revision} >"$todo" ||
+		${upstream:+--upstream "$upstream"} ${onto:+--onto "$onto"} \
+		${squash_onto:+--squash-onto "$squash_onto"} \
+		${restrict_revision:+--restrict-revision ^"$restrict_revision"} >"$todo" ||
 	die "$(gettext "Could not generate todo list")"
 
 	exec git rebase--helper --complete-action "$shortrevisions" "$onto_name" \
-- 
2.18.0

