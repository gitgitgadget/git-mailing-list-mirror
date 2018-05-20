Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E8FB1F51C
	for <e@80x24.org>; Sun, 20 May 2018 18:40:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751500AbeETSkd (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 May 2018 14:40:33 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:46299 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751365AbeETSk2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 May 2018 14:40:28 -0400
Received: by mail-lf0-f68.google.com with SMTP id t22-v6so1570416lff.13
        for <git@vger.kernel.org>; Sun, 20 May 2018 11:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KUMa/4s34NbgmqtA5r7pEwSHwn02XFefZ1BxXnUXuWQ=;
        b=cuMMeSpC+tCNOqDp/aSafjcyYoIuAUqY8/I5AHXmPyOnLfSspQkEJvtoBMP0AElt9I
         3RJCdMI0RVmy7cbmauGt+xkLzLfXvCyMkHLTI++VMxL3EP+kUZELCC7y3OOfnWBqCAoG
         Y7YKVDHsDwEvEOs0x1k/EAuvQCVCWxDZ9SQemANl2hbV+utvMKvH+WvaJxGnrhzHO0LG
         X2B2ZvaVz4Y/j5+EGEuwRj55w1wOvJXtCkE8HiN8rhOU3EemK4eSg6XMn60U+5JQi9y4
         queOtxwa9Tsks7lFnDskgwWyPwUmMFkFSYk9siG7VlOtSU6NfX3D5JHmb8nLtznkZd1F
         cxnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KUMa/4s34NbgmqtA5r7pEwSHwn02XFefZ1BxXnUXuWQ=;
        b=K1zF85Hyl8PmLxJPTghwZFhItB9boDlfRNaHLVItPT4eK9oFUG+WgjrpQ0j1Q72aHu
         LPxUxs4xK8yNvR6YxMlObDqevYsggo/cayfjO4wEw7CbGM8/jEBXMhGbVvnjceWIzoqV
         TmOpHzwYMBynx4DjR1u6EGf6E6qi6htRK6O6Xd4g/rcAtAUcRhkxwjryxOj24jpKaTCt
         A+O/5bh5L3VfXCv1g6CuPvnrHQN7z6/2EemkBQmm+UISUSo4671OtqOtcP4dOdgbULk+
         EbddgEQb+NZFhb7QZYR5oF8MLtqx6dakrLgzyuy9YybVWy/b9ON20z5vq3bcQck4SlOk
         Maeg==
X-Gm-Message-State: ALKqPwcwsnK/U/UG3flVopxl+eSk25PomxmV/5gEZKH9g22DAt6FXYqk
        J/p9gOC41HEucLoASdOfcgpN7A==
X-Google-Smtp-Source: AB8JxZo2fTCo1lbFodinLLd+6rBof0erQDJ/6zO5rk4oI2Kb36skZBZmD27Db3kgHTdyNmimeMZJ5w==
X-Received: by 2002:a19:1ad5:: with SMTP id a204-v6mr26506125lfa.43.1526841627251;
        Sun, 20 May 2018 11:40:27 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id k5-v6sm2176906lji.39.2018.05.20.11.40.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 May 2018 11:40:26 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 06/17] git --list-cmds: collect command list in a string_list
Date:   Sun, 20 May 2018 20:39:58 +0200
Message-Id: <20180520184009.976-7-pclouds@gmail.com>
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

Instead of printing the command directly one by one, keep them in a
list and print at the end. This allows more modification before we
print out (e.g. sorting, removing duplicates or even excluding some
items).

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 git.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/git.c b/git.c
index cd85355d81..376a59b97f 100644
--- a/git.c
+++ b/git.c
@@ -36,7 +36,7 @@ const char git_more_info_string[] =
 
 static int use_pager = -1;
 
-static void list_builtins(unsigned int exclude_option, char sep);
+static void list_builtins(struct string_list *list, unsigned int exclude_option);
 
 static int match_token(const char *spec, int len, const char *token)
 {
@@ -47,18 +47,24 @@ static int match_token(const char *spec, int len, const char *token)
 
 static int list_cmds(const char *spec)
 {
+	struct string_list list = STRING_LIST_INIT_DUP;
+	int i;
+
 	while (*spec) {
 		const char *sep = strchrnul(spec, ',');
 		int len = sep - spec;
 
 		if (match_token(spec, len, "builtins"))
-			list_builtins(0, '\n');
+			list_builtins(&list, 0);
 		else
 			die(_("unsupported command listing type '%s'"), spec);
 		spec += len;
 		if (*spec == ',')
 			spec++;
 	}
+	for (i = 0; i < list.nr; i++)
+		puts(list.items[i].string);
+	string_list_clear(&list, 0);
 	return 0;
 }
 
@@ -249,7 +255,13 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 			(*argc)--;
 		} else if (skip_prefix(cmd, "--list-cmds=", &cmd)) {
 			if (!strcmp(cmd, "parseopt")) {
-				list_builtins(NO_PARSEOPT, ' ');
+				struct string_list list = STRING_LIST_INIT_DUP;
+				int i;
+
+				list_builtins(&list, NO_PARSEOPT);
+				for (i = 0; i < list.nr; i++)
+					printf("%s ", list.items[i].string);
+				string_list_clear(&list, 0);
 				exit(0);
 			} else {
 				exit(list_cmds(cmd));
@@ -533,14 +545,14 @@ int is_builtin(const char *s)
 	return !!get_builtin(s);
 }
 
-static void list_builtins(unsigned int exclude_option, char sep)
+static void list_builtins(struct string_list *out, unsigned int exclude_option)
 {
 	int i;
 	for (i = 0; i < ARRAY_SIZE(commands); i++) {
 		if (exclude_option &&
 		    (commands[i].option & exclude_option))
 			continue;
-		printf("%s%c", commands[i].cmd, sep);
+		string_list_append(out, commands[i].cmd);
 	}
 }
 
-- 
2.17.0.705.g3525833791

