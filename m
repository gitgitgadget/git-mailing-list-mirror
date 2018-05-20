Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BB001F51C
	for <e@80x24.org>; Sun, 20 May 2018 18:40:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751556AbeETSkg (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 May 2018 14:40:36 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:44340 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751084AbeETSkb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 May 2018 14:40:31 -0400
Received: by mail-lf0-f66.google.com with SMTP id h197-v6so20753027lfg.11
        for <git@vger.kernel.org>; Sun, 20 May 2018 11:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BzutEb+qk9kFpsYJ9rnNPvkaKBddOPZHEs4jg+3kZZI=;
        b=akIaL2kVajzcZDWvmFAJ6jbA0p7NXUGBly+Yk70ZsuRas7WMGS++hcvo5q2Q6MqsK6
         1w7C08eCWAZCWFbAEgmVzXh6mCfK+adkalRdegG3vUhNKrYUah/SPcM6aAf0nLKQUpW3
         IyxLzm6XgIdW1EykMC8rQOu/Hgo8DgyCypjgsqO/ChIadNZLzZb3m/de1i3ZXbG8yho3
         9KT7qL2Yf8OYv02JeGBQfegyBe7ocGiup3tH0aSuuhORfmEuvvldSRnY0VZNPGOA7CW/
         dYCaY8IYbtAX6IiP2HdKREwGAKoHBbm4vTNY8zXpjZm9TwS7efsbGZT5SckUpe/URHUy
         /0Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BzutEb+qk9kFpsYJ9rnNPvkaKBddOPZHEs4jg+3kZZI=;
        b=N8N8/lThmHoAuUCTmwIBu41+uXPsqHyjOElBq/i1WuInl1+efkv+cQFu/dqZjkRo6R
         xu8dKS+LrY/JFa0iFqWL5YAPmnAWHPO8SRJGwbY1Hg6A14Jucd+0fFxdjSZ+53AZFm1M
         DFJ1bDefaBT0+MMrj1JZdIGP3Sinmt+YmoRrB0kZdIzID/p4CSsGfqg1BcAycuBxbDRB
         uERxgHY7XACBNFKdfeI7qirecfpJj6dmKNd2tGpX+mmDIy+i1QTb5orLWq6dUrY7SdcQ
         QTprRQp/grHtqi2PoMRyCOYfKkXzA/eKwqD+fCANE9+H+Bssr3E4Pidco9LFtj/u+6LA
         Hnxw==
X-Gm-Message-State: ALKqPwcwdGxDmPK0FTrg710aHFPnanwmk9NUnpX59ZmpU/1vdV4dKoRs
        HJJG2SrPHF8MmBbYV4+J9qJ1+w==
X-Google-Smtp-Source: AB8JxZryEIXdAY/3lQM5LN4QOZkq3Csc7t6CrcbF2v3DR6yD8cq7lShRY4kt0ds70X6pR/HKT1b/Kg==
X-Received: by 2002:a19:7515:: with SMTP id y21-v6mr2670282lfe.107.1526841629411;
        Sun, 20 May 2018 11:40:29 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id k5-v6sm2176906lji.39.2018.05.20.11.40.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 May 2018 11:40:28 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 08/17] git: support --list-cmds=list-<category>
Date:   Sun, 20 May 2018 20:40:00 +0200
Message-Id: <20180520184009.976-9-pclouds@gmail.com>
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

This allows us to select any group of commands by a category defined
in command-list.txt. This is an internal/hidden option so we don't
have to be picky about the category name or worried about exposing too
much.

This will be used later by git-completion.bash to retrieve certain
command groups.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/git.txt |  3 ++-
 generate-cmdlist.sh   | 17 +++++++++++++++++
 git.c                 |  7 +++++++
 help.c                | 23 +++++++++++++++++++++++
 help.h                |  2 ++
 5 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index c01477ab5e..c423810eac 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -168,7 +168,8 @@ foo.bar= ...`) sets `foo.bar` to the empty string which `git config
 	option and may change or be removed in the future. Supported
 	groups are: builtins, parseopt (builtin commands that use
 	parse-options), main (all commands in libexec directory),
-	others (all other commands in `$PATH` that have git- prefix).
+	others (all other commands in `$PATH` that have git- prefix),
+	list-<category> (see categories in command-list.txt)
 
 GIT COMMANDS
 ------------
diff --git a/generate-cmdlist.sh b/generate-cmdlist.sh
index 3bcc1ee57d..8d6d8b45ce 100755
--- a/generate-cmdlist.sh
+++ b/generate-cmdlist.sh
@@ -45,6 +45,21 @@ define_categories () {
 	test "$bit" -gt 32 && die "Urgh.. too many categories?"
 }
 
+define_category_names () {
+	echo
+	echo "/* Category names */"
+	echo "static const char *category_names[] = {"
+	bit=0
+	category_list "$1" |
+	while read cat
+	do
+		echo "	\"$cat\", /* (1UL << $bit) */"
+		bit=$(($bit+1))
+	done
+	echo "	NULL"
+	echo "};"
+}
+
 print_command_list () {
 	echo "static struct cmdname_help command_list[] = {"
 
@@ -70,4 +85,6 @@ struct cmdname_help {
 "
 define_categories "$1"
 echo
+define_category_names "$1"
+echo
 print_command_list "$1"
diff --git a/git.c b/git.c
index 10907f7266..4d5b8a9931 100644
--- a/git.c
+++ b/git.c
@@ -60,6 +60,13 @@ static int list_cmds(const char *spec)
 			list_all_main_cmds(&list);
 		else if (match_token(spec, len, "others"))
 			list_all_other_cmds(&list);
+		else if (len > 5 && !strncmp(spec, "list-", 5)) {
+			struct strbuf sb = STRBUF_INIT;
+
+			strbuf_add(&sb, spec + 5, len - 5);
+			list_cmds_by_category(&list, sb.buf);
+			strbuf_release(&sb);
+		}
 		else
 			die(_("unsupported command listing type '%s'"), spec);
 		spec += len;
diff --git a/help.c b/help.c
index d5ce9dfcbb..1117f7d1d1 100644
--- a/help.c
+++ b/help.c
@@ -329,6 +329,29 @@ void list_all_other_cmds(struct string_list *list)
 	clean_cmdnames(&other_cmds);
 }
 
+void list_cmds_by_category(struct string_list *list,
+			   const char *cat)
+{
+	int i, n = ARRAY_SIZE(command_list);
+	uint32_t cat_id = 0;
+
+	for (i = 0; category_names[i]; i++) {
+		if (!strcmp(cat, category_names[i])) {
+			cat_id = 1UL << i;
+			break;
+		}
+	}
+	if (!cat_id)
+		die(_("unsupported command listing type '%s'"), cat);
+
+	for (i = 0; i < n; i++) {
+		struct cmdname_help *cmd = command_list + i;
+
+		if (cmd->category & cat_id)
+			string_list_append(list, drop_prefix(cmd->name));
+	}
+}
+
 int is_in_cmdlist(struct cmdnames *c, const char *s)
 {
 	int i;
diff --git a/help.h b/help.h
index 97e6c0965e..734bba32d3 100644
--- a/help.h
+++ b/help.h
@@ -21,6 +21,8 @@ static inline void mput_char(char c, unsigned int num)
 extern void list_common_cmds_help(void);
 extern void list_all_main_cmds(struct string_list *list);
 extern void list_all_other_cmds(struct string_list *list);
+extern void list_cmds_by_category(struct string_list *list,
+				  const char *category);
 extern const char *help_unknown_cmd(const char *cmd);
 extern void load_command_list(const char *prefix,
 			      struct cmdnames *main_cmds,
-- 
2.17.0.705.g3525833791

