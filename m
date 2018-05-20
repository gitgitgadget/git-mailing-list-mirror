Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3E3C1F51C
	for <e@80x24.org>; Sun, 20 May 2018 18:41:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751929AbeETSlA (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 May 2018 14:41:00 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:40789 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751615AbeETSkl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 May 2018 14:40:41 -0400
Received: by mail-lf0-f67.google.com with SMTP id u140-v6so8493496lff.7
        for <git@vger.kernel.org>; Sun, 20 May 2018 11:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yxGpw/JAXiARXYwz6QUrB6gwj1rKVd2xp3nP+VrgRNM=;
        b=oknYhuHDSkUttTDEn/PSuAxm/ekiacsbi7RdCaXCYVxavJ2ERCwk0dCVJlkc2fYxT8
         iJh7eoAgPOJjPBc7nmgLfoP4yw1jSBARZpCpMqN6ZZA49t11xY13MJk6NpCQzXGfXhdh
         pN1KIy5q4zl58LI8lhH740fWDOPG8kocjGVS1UnDoQkfOgq5BNih8TIaG+idX7yUUnN4
         Br7grLqMLz23jaq8GE0jg48MKEAzsubPBNvXaPc+W4m4pRwifvtWp0eg/wqVnn3ikxWj
         dIGlrSnO0lJB3mScHRQ1V0X9VaFZdu1dHbdpWrlVGNc1yCynRai3DwgkPGrpqLc2n+PG
         0KYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yxGpw/JAXiARXYwz6QUrB6gwj1rKVd2xp3nP+VrgRNM=;
        b=ZQ0HRJlYeD+0kuElhHZnMVOPc6Xx7SLwtIUgLibCdfi9uNaScUiTikhd/8wfR/ElMx
         UWBhUFdbWiTD58/C9oZ2vjWxquOI5dj7wGqWdsiKI51ZBQVsGAkoJ/tDr094keDGT5Ke
         DPLinXgGocUGizeyzyDW+lEhCZ8IEYo+EnGZ8r8TCajBshV2rZQrCS6gf8YzAyPlum+c
         pcBxQklNp7ceP/C2jLwdfCaVWZvbwFuMESC9wT/t+4ZGqFRq3WALdOPqU3qjcxfgzrkK
         JICF1Un2PeOAfB4zC1G9n96hAtIO12tSoE0X+tCJWvOi04wOwd2yMCrIC55A82lpREJ/
         08ng==
X-Gm-Message-State: ALKqPwfeS/c3k9eWo63p05OBui7cEL4etRWcUeVyzIRFQek3zcj8ziAw
        Bx5gShUnTj4sGNS7bxzJTXBRDg==
X-Google-Smtp-Source: AB8JxZqHkwi1WEZauWy0AEaBqXpx8STsePJbrBTfnuxrTchH0oywSAR56JyCEVEv61kALMlYBvWEhw==
X-Received: by 2002:a2e:7213:: with SMTP id n19-v6mr10170308ljc.71.1526841639737;
        Sun, 20 May 2018 11:40:39 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id k5-v6sm2176906lji.39.2018.05.20.11.40.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 May 2018 11:40:38 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 17/17] completion: allow to customize the completable command list
Date:   Sun, 20 May 2018 20:40:09 +0200
Message-Id: <20180520184009.976-18-pclouds@gmail.com>
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

By default we show porcelain, external commands and a couple others
that are also popular. If you are not happy with this list, you can
now customize it a new config variable.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/config.txt               |  8 +++++++
 Documentation/git.txt                  |  3 ++-
 contrib/completion/git-completion.bash |  2 +-
 git.c                                  |  2 ++
 help.c                                 | 33 ++++++++++++++++++++++++++
 help.h                                 |  1 +
 6 files changed, 47 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 2659153cb3..9e81dcf867 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1343,6 +1343,14 @@ credential.<url>.*::
 credentialCache.ignoreSIGHUP::
 	Tell git-credential-cache--daemon to ignore SIGHUP, instead of quitting.
 
+completion.commands::
+	This is only used by git-completion.bash to add or remove
+	commands from the list of completed commands. Normally only
+	porcelain commands and a few select others are completed. You
+	can add more commands, separated by space, in this
+	variable. Prefixing the command with '-' will remove it from
+	the existing list.
+
 include::diff-config.txt[]
 
 difftool.<tool>.path::
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 75f50d2379..6f7eddf847 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -170,7 +170,8 @@ foo.bar= ...`) sets `foo.bar` to the empty string which `git config
 	parse-options), main (all commands in libexec directory),
 	others (all other commands in `$PATH` that have git- prefix),
 	list-<category> (see categories in command-list.txt),
-	nohelpers (exclude helper commands) and alias.
+	nohelpers (exclude helper commands), alias and config
+	(retrieve command list from config variable completion.commands)
 
 GIT COMMANDS
 ------------
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 98f278fb9a..e5b2ccbdd2 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -3012,7 +3012,7 @@ __git_main ()
 			then
 				__gitcomp "$GIT_TESTING_PORCELAIN_COMMAND_LIST"
 			else
-				__gitcomp "$(git --list-cmds=list-mainporcelain,others,nohelpers,alias,list-complete)"
+				__gitcomp "$(git --list-cmds=list-mainporcelain,others,nohelpers,alias,list-complete,config)"
 			fi
 			;;
 		esac
diff --git a/git.c b/git.c
index 63acd9ea81..447dac0e71 100644
--- a/git.c
+++ b/git.c
@@ -77,6 +77,8 @@ static int list_cmds(const char *spec)
 			exclude_helpers_from_list(&list);
 		else if (match_token(spec, len, "alias"))
 			list_aliases(&list);
+		else if (match_token(spec, len, "config"))
+			list_cmds_by_config(&list);
 		else if (len > 5 && !strncmp(spec, "list-", 5)) {
 			struct strbuf sb = STRBUF_INIT;
 
diff --git a/help.c b/help.c
index 23924dd300..abf87205b2 100644
--- a/help.c
+++ b/help.c
@@ -366,6 +366,39 @@ void list_cmds_by_category(struct string_list *list,
 	}
 }
 
+void list_cmds_by_config(struct string_list *list)
+{
+	const char *cmd_list;
+
+	/*
+	 * There's no actual repository setup at this point (and even
+	 * if there is, we don't really care; only global config
+	 * matters). If we accidentally set up a repository, it's ok
+	 * too since the caller (git --list-cmds=) should exit shortly
+	 * anyway.
+	 */
+	if (git_config_get_string_const("completion.commands", &cmd_list))
+		return;
+
+	string_list_sort(list);
+	string_list_remove_duplicates(list, 0);
+
+	while (*cmd_list) {
+		struct strbuf sb = STRBUF_INIT;
+		const char *p = strchrnul(cmd_list, ' ');
+
+		strbuf_add(&sb, cmd_list, p - cmd_list);
+		if (*cmd_list == '-')
+			string_list_remove(list, cmd_list + 1, 0);
+		else
+			string_list_insert(list, sb.buf);
+		strbuf_release(&sb);
+		while (*p == ' ')
+			p++;
+		cmd_list = p;
+	}
+}
+
 void list_common_guides_help(void)
 {
 	struct category_description catdesc[] = {
diff --git a/help.h b/help.h
index b2293e99be..3b38292a1b 100644
--- a/help.h
+++ b/help.h
@@ -26,6 +26,7 @@ extern void list_all_main_cmds(struct string_list *list);
 extern void list_all_other_cmds(struct string_list *list);
 extern void list_cmds_by_category(struct string_list *list,
 				  const char *category);
+extern void list_cmds_by_config(struct string_list *list);
 extern const char *help_unknown_cmd(const char *cmd);
 extern void load_command_list(const char *prefix,
 			      struct cmdnames *main_cmds,
-- 
2.17.0.705.g3525833791

