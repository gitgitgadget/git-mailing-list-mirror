Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 83F2E1F597
	for <e@80x24.org>; Tue, 24 Jul 2018 16:34:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388536AbeGXRlu (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jul 2018 13:41:50 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35277 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388350AbeGXRlt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jul 2018 13:41:49 -0400
Received: by mail-wr1-f66.google.com with SMTP id a3-v6so4791625wrt.2
        for <git@vger.kernel.org>; Tue, 24 Jul 2018 09:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TFDrXMmRQILdRcaz8X4+ZjVWNvoxc9a/bLBp5v7Hf/0=;
        b=qCMGbPua/bZ+hOFDxP47xsqG9xneekg9L2nx7blGUgsI3IyKKXEuN4xDk4uCBvfcfH
         FeSfqgNJWQX2fE3Uk6czyHfUuNvGClxgH0Snjzh6EXh7UHfZaZKZe9B5sOhYxvcsLHa9
         B2AZkYfhPcb6nqA3glJo/no9GIRKWQwG0zOOk6HgMl30qe6j2Y3cLiiLEF8nr3tQZJ/c
         vFarMBaD9OoHSwd4vefnfnRdPKN3bLmxhxf29cip/IML6QtPuIHcCN6sRQ4p0I4BneDu
         NIXoO+kKE4uMBA6FNneWK2J3Z+Ol/Cynkm9fvTM6Q0bBpEY1cAoTPxnqPwcogaa89zzw
         oUSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TFDrXMmRQILdRcaz8X4+ZjVWNvoxc9a/bLBp5v7Hf/0=;
        b=boRyvxtoM0zOMtqPgPgbc7nCWKvZqMZLwAnJbHNAmNPaMVJWZMP2YjDaYuBMopkhEY
         LVGt7TgU7ECxGIy3nYeJo4/J3zqLFPC4T7aTcuImYVMZww6WckPc8sovd+2Ub0qIlqJ3
         3a2a+oqk8M93dz55WCj9lY+LTkG7Bp0jdlCLwazK1sqEterd8ABZGstd/wlZUtiilXV7
         h+/2NXvklBe/uKnQcSr7N/XtAwaMOensY7ODU1Bw4f8yfUYmJtNq0YFajDvi1QQi5qEt
         AZ2wbTIuNEVONhQTG/HjhkWlLXpCC1Og9Jhx0IPaeFYQpdD1Ok4BGIq6Gpks068odhcj
         OxXA==
X-Gm-Message-State: AOUpUlGuhceERprA55qVDO2WBTCwVHouOswMW9sw/yd5/kyAUlmxNFnj
        wTV7GaarDegnEBXene3lzD+Tj2kX
X-Google-Smtp-Source: AAOMgpd8EE1iRB4fuNEGeWxlicJzHgBmgVZcKheTcZjUQpEODxNv4fY8aJRpo+gaZshoWdaXiKmqjg==
X-Received: by 2002:adf:deca:: with SMTP id i10-v6mr11488013wrn.163.1532450071084;
        Tue, 24 Jul 2018 09:34:31 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-75-221.w92-156.abo.wanadoo.fr. [92.156.127.221])
        by smtp.googlemail.com with ESMTPSA id x124-v6sm1899091wmg.38.2018.07.24.09.34.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Jul 2018 09:34:30 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, gitster@pobox.com,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH v4 13/20] rebase -i: implement the logic to initialize $revisions in C
Date:   Tue, 24 Jul 2018 18:32:14 +0200
Message-Id: <20180724163221.15201-14-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180724163221.15201-1-alban.gruin@gmail.com>
References: <20180710121557.6698-1-alban.gruin@gmail.com>
 <20180724163221.15201-1-alban.gruin@gmail.com>
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

