Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AACC1F42D
	for <e@80x24.org>; Thu, 10 May 2018 08:47:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756835AbeEJIrD (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 04:47:03 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:37797 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756379AbeEJIq7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 04:46:59 -0400
Received: by mail-lf0-f65.google.com with SMTP id r2-v6so1833328lff.4
        for <git@vger.kernel.org>; Thu, 10 May 2018 01:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=324uIZbEAeEoGMUhggUWs+YGzs/od8fueZnwhSikd7c=;
        b=oLI05oXXmEd3Abc6qfdvOnEY+jSpTIDQ5YCBfJrNQ9v5GIAoH2L64PMkTwyHr4uDVQ
         97FoD7iFpBB3RcYOuOx6F1cQcmQ9xEFI9DU7zxJHThM+9Qucy40Zhyn5DZ0tZO5i9P7A
         Qw0cw7yNH2CPmFqyUyZ8CL93pu5fuCKyHtTwwllnRV8ciNLQpIt5/9wkDyacwica/Uck
         UnnK/ZBg57vBvbal7/Lq3dnyJqR9uQnnGVSzqiKveywFRPn5CrYy94301tLilbsnctmq
         t+jbETNpr7EGaVUb6I7DXO9PEx0O0YwuUimIf2nzmq8w+v92UeTRf0YpQz0sdHX6ApHm
         cHFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=324uIZbEAeEoGMUhggUWs+YGzs/od8fueZnwhSikd7c=;
        b=CfQ6Vn71Rxhi6dRCSu7R4sKsvTUV4oZo82piFdlLHJa5+Ww1GGKvKXDQuQwRIGrxAF
         byv0JU0mgr/sC1VPpBz4iQF0NKlWI8ykAbsst65RpCj+Ub3qCqeAzqTyYgwJipFppYiz
         PnANPwFZAG1SLzPDs7bw/NFPsKG+aFfLfcnSSGcK/r0Z/vMH1JvV8O3ldEovQNEZFh/N
         DABtE3qQgAMqJXBRtptWW3C5wJ9yt/QBaiRpr2xMUNFs2zLGFTH/W5kWdhe/hIsONWd4
         S7JBtgS9gx3nLnz+EpMEo+/opeC3MwyZvzM7/w45rduTlPwkl93J6JQPerHiUl2SKYF3
         21rQ==
X-Gm-Message-State: ALKqPwdEJDzWv6i3otpcuBrOhJqCvcl8oCS+Gmrb97XW9FKfD9sTsOAZ
        v55d3B4z3kVzx5A6FZ+c5+0=
X-Google-Smtp-Source: AB8JxZpvxCDxHUJBjCZE69YSY/szSyZyJZCdDvB4JK0rqFD72lB4qsEon7QucxVAu/L5DvF11NVOog==
X-Received: by 2002:a19:385c:: with SMTP id d28-v6mr441068lfj.11.1525942017709;
        Thu, 10 May 2018 01:46:57 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id l24-v6sm68024lje.42.2018.05.10.01.46.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 May 2018 01:46:56 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        szeder.dev@gmail.com
Subject: [PATCH v7 00/13] Keep all info in command-list.txt in git binary
Date:   Thu, 10 May 2018 10:46:39 +0200
Message-Id: <20180510084652.25880-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.705.g3525833791
In-Reply-To: <20180507175222.12114-1-pclouds@gmail.com>
References: <20180507175222.12114-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v7 is mostly code cleanup plus one more change:

git-completion.bash now always checks completion.commands config key.
This makes it much more convenient to customize the command complete
list. You only have to fall back to setting $GIT_COMPLETION_CMD_GROUPS
when you have very special needs.

Interdiff

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 2659153cb3..91f7eaed7b 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1343,6 +1343,16 @@ credential.<url>.*::
 credentialCache.ignoreSIGHUP::
 	Tell git-credential-cache--daemon to ignore SIGHUP, instead of quitting.
 
+completion.commands::
+	This is only used by git-completion.bash to add or remove
+	commands from the complete list. Normally only porcelain
+	commands and a few select others are in the complete list. You
+	can add more commands, separated by space, in this
+	variable. Prefixing a command with '-' will remove it from
+	the existing list.
++
+This variable should not be per-repository.
+
 include::diff-config.txt[]
 
 difftool.<tool>.path::
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 0fd29803d5..f7ca9a4d4f 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -50,10 +50,10 @@
 #
 #         GIT_COMPLETION_CMD_GROUPS=main,others
 #
-#     Or you could go with defaults add some extra commands specified
-#     in the configuration variable completion.commands [1] with
+#     Or you could go with main porcelain only and extra commands in
+#     the configuration variable completion.commands with
 #
-#         GIT_COMPLETION_CMD_GROUPS=mainporcelain,others,list-complete,config
+#         GIT_COMPLETION_CMD_GROUPS=mainporcelain,config
 #
 #     Or go completely custom group with
 #
@@ -61,15 +61,6 @@
 #
 #     Or you could even play with other command categories found in
 #     command-list.txt.
-#
-#     [1] Note that completion.commands should not be per-repository
-#         since the command list is generated once and cached.
-#
-#         completion.commands could be used to exclude commands as
-#         well.  If a command in this list begins with '-', then it
-#         will be excluded from the list of commands gathered by the
-#         groups specified before "config" in
-#         $GIT_COMPLETION_CMD_GROUPS.
 
 case "$COMP_WORDBREAKS" in
 *:*) : great ;;
@@ -876,7 +867,7 @@ __git_commands () {
 		then
 			git --list-cmds="$GIT_COMPLETION_CMD_GROUPS"
 		else
-			git --list-cmds=list-mainporcelain,others,list-complete
+			git --list-cmds=list-mainporcelain,others,list-complete,config
 		fi
 		;;
 	all)
diff --git a/generate-cmdlist.sh b/generate-cmdlist.sh
index bfd8ef0671..8d6d8b45ce 100755
--- a/generate-cmdlist.sh
+++ b/generate-cmdlist.sh
@@ -9,7 +9,7 @@ command_list () {
 	grep -v '^#' "$1"
 }
 
-get_categories() {
+get_categories () {
 	tr ' ' '\n'|
 	grep -v '^$' |
 	sort |
@@ -32,7 +32,7 @@ get_synopsis () {
 		}' "Documentation/$1.txt"
 }
 
-define_categories() {
+define_categories () {
 	echo
 	echo "/* Command categories */"
 	bit=0
@@ -45,7 +45,7 @@ define_categories() {
 	test "$bit" -gt 32 && die "Urgh.. too many categories?"
 }
 
-define_category_names() {
+define_category_names () {
 	echo
 	echo "/* Category names */"
 	echo "static const char *category_names[] = {"
@@ -60,7 +60,7 @@ define_category_names() {
 	echo "};"
 }
 
-print_command_list() {
+print_command_list () {
 	echo "static struct cmdname_help command_list[] = {"
 
 	command_list "$1" |
diff --git a/git.c b/git.c
index fd08911e11..ea4feedd0b 100644
--- a/git.c
+++ b/git.c
@@ -38,6 +38,13 @@ static int use_pager = -1;
 
 static void list_builtins(struct string_list *list, unsigned int exclude_option);
 
+static int match_token(const char *spec, int len, const char *token)
+{
+	int token_len = strlen(token);
+
+	return len == token_len && !strncmp(spec, token, token_len);
+}
+
 static int list_cmds(const char *spec)
 {
 	struct string_list list = STRING_LIST_INIT_DUP;
@@ -47,13 +54,13 @@ static int list_cmds(const char *spec)
 		const char *sep = strchrnul(spec, ',');
 		int len = sep - spec;
 
-		if (len == 8 && !strncmp(spec, "builtins", 8))
+		if (match_token(spec, len, "builtins"))
 			list_builtins(&list, 0);
-		else if (len == 4 && !strncmp(spec, "main", 4))
+		else if (match_token(spec, len, "main"))
 			list_all_main_cmds(&list);
-		else if (len == 6 && !strncmp(spec, "others", 6))
+		else if (match_token(spec, len, "others"))
 			list_all_other_cmds(&list);
-		else if (len == 6 && !strncmp(spec, "config", 6))
+		else if (match_token(spec, len, "config"))
 			list_cmds_by_config(&list);
 		else if (len > 5 && !strncmp(spec, "list-", 5)) {
 			struct strbuf sb = STRBUF_INIT;

Nguyễn Thái Ngọc Duy (13):
  generate-cmds.sh: factor out synopsis extract code
  generate-cmds.sh: export all commands to command-list.h
  help: use command-list.h for common command list
  Remove common-cmds.h
  git.c: convert --list-* to --list-cmds=*
  git --list-cmds: collect command list in a string_list
  completion: implement and use --list-cmds=main,others
  git: support --list-cmds=list-<category>
  help: add "-a --verbose" to list all commands with synopsis
  help: use command-list.txt for the source of guides
  command-list.txt: documentation and guide line
  completion: let git provide the completable command list
  completion: allow to customize the completable command list

 .gitignore                             |   2 +-
 Documentation/config.txt               |  10 +
 Documentation/git-help.txt             |   4 +-
 Documentation/gitattributes.txt        |   2 +-
 Documentation/gitmodules.txt           |   2 +-
 Documentation/gitrevisions.txt         |   2 +-
 Makefile                               |  16 +-
 builtin/help.c                         |  39 +---
 command-list.txt                       | 111 ++++++++---
 contrib/completion/git-completion.bash | 160 +++++++---------
 generate-cmdlist.sh                    | 126 ++++++++-----
 git.c                                  |  68 ++++++-
 help.c                                 | 244 ++++++++++++++++++++++---
 help.h                                 |  10 +
 t/t0012-help.sh                        |  26 ++-
 t/t9902-completion.sh                  |   5 +-
 16 files changed, 573 insertions(+), 254 deletions(-)

-- 
2.17.0.705.g3525833791

