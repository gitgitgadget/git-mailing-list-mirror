Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65AF41F51C
	for <e@80x24.org>; Sat, 19 May 2018 04:28:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751743AbeESE2P (ORCPT <rfc822;e@80x24.org>);
        Sat, 19 May 2018 00:28:15 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:44274 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750713AbeESE2H (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 May 2018 00:28:07 -0400
Received: by mail-lf0-f65.google.com with SMTP id h197-v6so16743469lfg.11
        for <git@vger.kernel.org>; Fri, 18 May 2018 21:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tPyBgE986HPj/Q1cLhkOnkKV9yi9tpYM8qsj5MPCqfY=;
        b=J9Ea1S/m/D4cTAAiuGqvhM1ukfPSEP6DkoHM3Scs3JGMeJSjgmF9UxAStKcldTBBcS
         8MjQw7TrGML5GIritU0RWKh0+oS0UFK8RMCdbxj/Gzd+h6vP/9BEj4OSIDRFPXmbfIuM
         L2GfVWSlYBd8RhDFnCj+XzP2pSfDpqYce8i+8tJa7/qW+VBpOgh8nH0SAtXhNZuewlb4
         KCf+9XlUAvIoNSQR72KLewe2TzDF5f1GHDN+obg4Mve/Aa0kQP5TcdtlyOBqjidQe71c
         P2wwKgLpms6+yIjHZjkgeV5v3/AQ35zAUYcEd1pdyIw4jlMUF+2q1nS0YvAvrchLfl1z
         COYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tPyBgE986HPj/Q1cLhkOnkKV9yi9tpYM8qsj5MPCqfY=;
        b=O7xfrtlh2JdMBTXh8icF1UyX5GQbtyEJJ08PsBoNHMeEPgLRZ/ElEUIsl3ln2TicDH
         qi0dUglaEr3t3SM0BghHEoVdrrAlObVJym0f1ezAQg3NzEt4TCpOm8XEdtLSP7JbqUdH
         rDs4nt9kCWUlG95TCxJoCECGX3/UMKCa5G7yHurD5M+L41kJYKrTyxWZZmGTTdvJANEJ
         OSkjr3hxeAR5scljP80NZhoSGLI9hiJFuIYizRadE3Zd2atxfcyksZSXTvfTF+gOLaIj
         KSOD6N97xZvOovg3wBbWmyily/EgboGjKU3feVuUFL/H4GskERYhV5F5urJMUJc3+blh
         oCRg==
X-Gm-Message-State: ALKqPwfXjkPNfT3ekBLBd7INODredSnB1nt++GQVYtH0sz3X5zmefgd+
        JiACwHxT3UjA4oBlkePuGmaN4g==
X-Google-Smtp-Source: AB8JxZqJ08Rp7RDmUBUZ5wNOnSh65d65nmc62cHjaeRMEVS5315EfN3U6A9+bBd6G8VNxeyToryEOQ==
X-Received: by 2002:a2e:9248:: with SMTP id v8-v6mr7453147ljg.133.1526704085892;
        Fri, 18 May 2018 21:28:05 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id o11-v6sm1960309lfi.14.2018.05.18.21.28.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 May 2018 21:28:05 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Philip Oakley <philipoakley@iee.org>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 08/14] git: support --list-cmds=list-<category>
Date:   Sat, 19 May 2018 06:27:46 +0200
Message-Id: <20180519042752.8666-9-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.705.g3525833791
In-Reply-To: <20180519042752.8666-1-pclouds@gmail.com>
References: <20180519042752.8666-1-pclouds@gmail.com>
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
 generate-cmdlist.sh | 17 +++++++++++++++++
 git.c               |  7 +++++++
 help.c              | 23 +++++++++++++++++++++++
 help.h              |  2 ++
 4 files changed, 49 insertions(+)

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

