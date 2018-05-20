Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 572451F51C
	for <e@80x24.org>; Sun, 20 May 2018 18:41:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751688AbeETSkw (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 May 2018 14:40:52 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:38760 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751574AbeETSkk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 May 2018 14:40:40 -0400
Received: by mail-lf0-f66.google.com with SMTP id z142-v6so20767978lff.5
        for <git@vger.kernel.org>; Sun, 20 May 2018 11:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dXLp4Y9BD+OeHupmr6w9I0sBlSdiIPAuqqbHW4fspRw=;
        b=hy9XFN/429ou5KO02YTc42WMdVCM2DalklKovMT/zkDScDJL52O+xgONUgjKu0BS9O
         F46IuS6rTVDWgEw6EOvjgntZ6qMC1Q3F2yS8RrmVl/vvuJ+xfQCZVrXjYtS2xxx5ewuL
         xyAhqrJ7ZSi0pC2t9nSxsRDmnEgrjWILKKaGo9X0OlwDfrYh2OIODUEe3QL4CyNzWobL
         Slt46+aKf7yaIZnUJsMKS8ihINV8tlzCtlKVH9cokQBjKVTtpzjx6kEDH2D6kQWwDnCs
         aJ5AWpy/4RX1z63E00sDkberuxkfP7SrxF82NPrC6SfMEvYHKxmL6FvZbBlr+qiWNO6w
         FjiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dXLp4Y9BD+OeHupmr6w9I0sBlSdiIPAuqqbHW4fspRw=;
        b=Tcx7t4/Pqca5Ai/6Talz1xhEA4n8XJ7q/dMew05XrWAv2v1NFbW6iAtZQukmZ//E4h
         1GEHVdz67ABUrKnHyNSl1FHjeUZrE5XmC3n0wiYXRwcMnnyeIFGnjUK6BAee/stF3mpt
         4DagNIXybp2eOlm3giOEAYoeY9fQmDx4zYYPf+WeqseFPkJCxtyMWRyzck42ndELc/Kb
         Oi0bm1CAsOSLeE9yGQuZ9pjUdX0hYCS6C43UJFfv+3yvDsbgEblsA37m00OeMZl3AXBZ
         4ZCmq1guiX+kvTm1/vMabb7rl1o5YaLug63nJD/L8gHe8TfEsRBS8Cd6OAJ305iPbZRG
         3QvQ==
X-Gm-Message-State: ALKqPwcPQDCfFJb26m5aD/RVSCIzyj7/DSRxTXMFvj18fuVBLP53UHRX
        UZEN4eg9IrPAu5a9hqlNbAqc2Q==
X-Google-Smtp-Source: AB8JxZphKKKv1tRg9feG25aYtSdXifervzT0ehixMFPlmFeKqlYH64kmcHFifvQ+elgpYgIg94DbIA==
X-Received: by 2002:a2e:3503:: with SMTP id z3-v6mr10734446ljz.95.1526841638185;
        Sun, 20 May 2018 11:40:38 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id k5-v6sm2176906lji.39.2018.05.20.11.40.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 May 2018 11:40:37 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 16/17] completion: add and use --list-cmds=alias
Date:   Sun, 20 May 2018 20:40:08 +0200
Message-Id: <20180520184009.976-17-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.705.g3525833791
In-Reply-To: <20180520184009.976-1-pclouds@gmail.com>
References: <20180519042752.8666-1-pclouds@gmail.com>
 <20180520184009.976-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

By providing aliases via --list-cmds=, we could simplify command
collection code in the script. We only issue one git command. Before
this patch that is "git config", after it's "git --list-cmds=". In
"git help" completion case we actually reduce one "git" process (for
getting guides) but that call was added in this series so it does not
really count.

A couple of bash functions are removed because they are not needed
anymore. __git_compute_all_commands() and $__git_all_commands stay
because they are still needed for completing pager.* config and
without "alias" group, the result is still cacheable.

There is a slight (good) change in _git_help() with this patch: before
"git help <tab>" shows external commands (as in _not_ part of git) as
well as part of $__git_all_commands. We have finer control over
command listing now and can exclude that because we can't provide a
man page for external commands anyway.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/git.txt                  |  2 +-
 alias.c                                | 21 +++++++-
 alias.h                                |  3 ++
 contrib/completion/git-completion.bash | 75 ++++++--------------------
 git.c                                  |  2 +
 t/t9902-completion.sh                  | 18 -------
 6 files changed, 40 insertions(+), 81 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 820ab77fcb..75f50d2379 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -170,7 +170,7 @@ foo.bar= ...`) sets `foo.bar` to the empty string which `git config
 	parse-options), main (all commands in libexec directory),
 	others (all other commands in `$PATH` that have git- prefix),
 	list-<category> (see categories in command-list.txt),
-	nohelpers (exclude helper commands).
+	nohelpers (exclude helper commands) and alias.
 
 GIT COMMANDS
 ------------
diff --git a/alias.c b/alias.c
index e9726ce8c5..a7e4e57130 100644
--- a/alias.c
+++ b/alias.c
@@ -1,10 +1,12 @@
 #include "cache.h"
 #include "alias.h"
 #include "config.h"
+#include "string-list.h"
 
 struct config_alias_data {
 	const char *alias;
 	char *v;
+	struct string_list *list;
 };
 
 static int config_alias_cb(const char *key, const char *value, void *d)
@@ -12,8 +14,16 @@ static int config_alias_cb(const char *key, const char *value, void *d)
 	struct config_alias_data *data = d;
 	const char *p;
 
-	if (skip_prefix(key, "alias.", &p) && !strcasecmp(p, data->alias))
-		return git_config_string((const char **)&data->v, key, value);
+	if (!skip_prefix(key, "alias.", &p))
+		return 0;
+
+	if (data->alias) {
+		if (!strcasecmp(p, data->alias))
+			return git_config_string((const char **)&data->v,
+						 key, value);
+	} else if (data->list) {
+		string_list_append(data->list, p);
+	}
 
 	return 0;
 }
@@ -27,6 +37,13 @@ char *alias_lookup(const char *alias)
 	return data.v;
 }
 
+void list_aliases(struct string_list *list)
+{
+	struct config_alias_data data = { NULL, NULL, list };
+
+	read_early_config(config_alias_cb, &data);
+}
+
 #define SPLIT_CMDLINE_BAD_ENDING 1
 #define SPLIT_CMDLINE_UNCLOSED_QUOTE 2
 static const char *split_cmdline_errors[] = {
diff --git a/alias.h b/alias.h
index fbf1d22a94..79933f2457 100644
--- a/alias.h
+++ b/alias.h
@@ -1,9 +1,12 @@
 #ifndef __ALIAS_H__
 #define __ALIAS_H__
 
+struct string_list;
+
 char *alias_lookup(const char *alias);
 int split_cmdline(char *cmdline, const char ***argv);
 /* Takes a negative value returned by split_cmdline */
 const char *split_cmdline_strerror(int cmdline_errno);
+void list_aliases(struct string_list *list);
 
 #endif
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 217c8a3d3b..98f278fb9a 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -834,51 +834,11 @@ __git_complete_strategy ()
 	return 1
 }
 
-# __git_commands requires 1 argument:
-# 1: the command group, either "all" or "porcelain"
-__git_commands () {
-	case "$1" in
-	porcelain)
-		if test -n "$GIT_TESTING_PORCELAIN_COMMAND_LIST"
-		then
-			printf "%s" "$GIT_TESTING_PORCELAIN_COMMAND_LIST"
-		else
-			git --list-cmds=list-mainporcelain,others,nohelpers,list-complete
-		fi
-		;;
-	all)
-		if test -n "$GIT_TESTING_ALL_COMMAND_LIST"
-		then
-			printf "%s" "$GIT_TESTING_ALL_COMMAND_LIST"
-		else
-			git --list-cmds=main,others,nohelpers
-		fi
-		;;
-	esac
-}
-
-__git_list_all_commands ()
-{
-	__git_commands all
-}
-
 __git_all_commands=
 __git_compute_all_commands ()
 {
 	test -n "$__git_all_commands" ||
-	__git_all_commands=$(__git_list_all_commands)
-}
-
-__git_list_porcelain_commands ()
-{
-	__git_commands porcelain
-}
-
-__git_porcelain_commands=
-__git_compute_porcelain_commands ()
-{
-	test -n "$__git_porcelain_commands" ||
-	__git_porcelain_commands=$(__git_list_porcelain_commands)
+	__git_all_commands=$(git --list-cmds=main,others,alias,nohelpers)
 }
 
 # Lists all set config variables starting with the given section prefix,
@@ -896,11 +856,6 @@ __git_pretty_aliases ()
 	__git_get_config_variables "pretty"
 }
 
-__git_aliases ()
-{
-	__git_get_config_variables "alias"
-}
-
 # __git_aliased_command requires 1 argument
 __git_aliased_command ()
 {
@@ -1500,13 +1455,6 @@ _git_grep ()
 	__git_complete_refs
 }
 
-__git_all_guides=
-__git_compute_all_guides ()
-{
-	test -n "$__git_all_guides" ||
-	__git_all_guides=$(git --list-cmds=list-guide)
-}
-
 _git_help ()
 {
 	case "$cur" in
@@ -1515,11 +1463,12 @@ _git_help ()
 		return
 		;;
 	esac
-	__git_compute_all_commands
-	__git_compute_all_guides
-	__gitcomp "$__git_all_commands $(__git_aliases) $__git_all_guides
-		gitk
-		"
+	if test -n "$GIT_TESTING_ALL_COMMAND_LIST"
+	then
+		__gitcomp "$GIT_TESTING_ALL_COMMAND_LIST $(git --list-cmds=alias,list-guide) gitk"
+	else
+		__gitcomp "$(git --list-cmds=main,nohelpers,alias,list-guide) gitk"
+	fi
 }
 
 _git_init ()
@@ -3058,8 +3007,14 @@ __git_main ()
 			--help
 			"
 			;;
-		*)     __git_compute_porcelain_commands
-		       __gitcomp "$__git_porcelain_commands $(__git_aliases)" ;;
+		*)
+			if test -n "$GIT_TESTING_PORCELAIN_COMMAND_LIST"
+			then
+				__gitcomp "$GIT_TESTING_PORCELAIN_COMMAND_LIST"
+			else
+				__gitcomp "$(git --list-cmds=list-mainporcelain,others,nohelpers,alias,list-complete)"
+			fi
+			;;
 		esac
 		return
 	fi
diff --git a/git.c b/git.c
index f6ae79ffaf..63acd9ea81 100644
--- a/git.c
+++ b/git.c
@@ -75,6 +75,8 @@ static int list_cmds(const char *spec)
 			list_all_other_cmds(&list);
 		else if (match_token(spec, len, "nohelpers"))
 			exclude_helpers_from_list(&list);
+		else if (match_token(spec, len, "alias"))
+			list_aliases(&list);
 		else if (len > 5 && !strncmp(spec, "list-", 5)) {
 			struct strbuf sb = STRBUF_INIT;
 
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 2f16679380..5863b1acac 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -1192,17 +1192,6 @@ test_expect_success '__git_pretty_aliases' '
 	test_cmp expect actual
 '
 
-test_expect_success '__git_aliases' '
-	cat >expect <<-EOF &&
-	ci
-	co
-	EOF
-	test_config alias.ci commit &&
-	test_config alias.co checkout &&
-	__git_aliases >actual &&
-	test_cmp expect actual
-'
-
 test_expect_success 'basic' '
 	run_completion "git " &&
 	# built-in
@@ -1511,13 +1500,6 @@ test_expect_success 'sourcing the completion script clears cached commands' '
 	verbose test -z "$__git_all_commands"
 '
 
-test_expect_success 'sourcing the completion script clears cached porcelain commands' '
-	__git_compute_porcelain_commands &&
-	verbose test -n "$__git_porcelain_commands" &&
-	. "$GIT_BUILD_DIR/contrib/completion/git-completion.bash" &&
-	verbose test -z "$__git_porcelain_commands"
-'
-
 test_expect_success !GETTEXT_POISON 'sourcing the completion script clears cached merge strategies' '
 	__git_compute_merge_strategies &&
 	verbose test -n "$__git_merge_strategies" &&
-- 
2.17.0.705.g3525833791

