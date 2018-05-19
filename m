Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D78C1F51C
	for <e@80x24.org>; Sat, 19 May 2018 04:28:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751034AbeESE2L (ORCPT <rfc822;e@80x24.org>);
        Sat, 19 May 2018 00:28:11 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:41368 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750817AbeESE2G (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 May 2018 00:28:06 -0400
Received: by mail-lf0-f67.google.com with SMTP id m17-v6so16762846lfj.8
        for <git@vger.kernel.org>; Fri, 18 May 2018 21:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SWsS3R3ij5ySRSeB4DD4iR2fzsxsSTAS4KnKig/gO7c=;
        b=QxHfhE7eFjmZicVADwfeuekiDWMnnZorqmAGh7PYMRdQgW6ZQFlhSl2a5vkH5ydEkD
         SbgxAb67LB1G0g9RugrjE7whn04718fZmK/df2Sn3SCnkjWf6tmT+c5Kn6Wfqmj9QI+r
         PcaEF7xEfO/ULjkmwkcm1C3t9XHmoLbV4r1mt+fx372vIZ3nkUCj8JG12yv44OtII/97
         9U7DQpOmK19y1vxR1JIZfWx+rE67gcIjpLumiLf2WByr745XIIhXdipMz71QeJQTN0SR
         tHsKb/evpWnWVKaAW3onMDnMDFWUGXW+V/AKAprJQHWjLVmaE0Gb3ZZEAclegvImAlTg
         eqCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SWsS3R3ij5ySRSeB4DD4iR2fzsxsSTAS4KnKig/gO7c=;
        b=TObL4x2ryDs3jb1IWZFvLu8gYuxRH1WaRiQY8aHmXBeA1dR6IuU738nIrV4lN/UJYy
         Kb7A6Y4wKme3faspxl+dxXf7CQerBeBaLlOGUkDLAZhpHuMEMOPJeq3GmehBqArPswfA
         Jj+2BOUZtP9uSlndhAF2X8push8LMdwJU56d2j8QhHgUDAfW8GDDyJc/JYYJO/cNrCto
         ZBaoBknYH9BoDlR42lC0X+slfSVEpXs7t1R/kAj3Tyx7BMgYaNMopPt/3N8IkcMWeMe3
         kODQnde2/cDrUzVhDFpj6hs3QmrEyvnhzkkxDrHPb8+wl+1KUaMgn/7RbM36Ki2GJRJG
         zHoQ==
X-Gm-Message-State: ALKqPweKL/SjkwGaqzF9TXGQMhTYweI/BL9B7YiPJj0BTpXBHtTIHoKM
        vhuhpjI8HeSgayWhXDd97OZkQg==
X-Google-Smtp-Source: AB8JxZoybSNMQ6NaIdn1N8shTKu/5Kpiojm01Oc8GO0NEU93kPmPwRKKGnbSFrNkmhLQ2dmzl3dNPQ==
X-Received: by 2002:a2e:954b:: with SMTP id t11-v6mr7544282ljh.138.1526704084742;
        Fri, 18 May 2018 21:28:04 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id o11-v6sm1960309lfi.14.2018.05.18.21.28.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 May 2018 21:28:04 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Philip Oakley <philipoakley@iee.org>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 07/14] completion: implement and use --list-cmds=main,others
Date:   Sat, 19 May 2018 06:27:45 +0200
Message-Id: <20180519042752.8666-8-pclouds@gmail.com>
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

This is part of the effort to break down and provide commands by
category in machine-readable form. This could be helpful later on when
completion script switches to use --list-cmds for selecting
completable commands. It would be much easier for the user to choose
to complete _all_ commands instead of the default selection by passing
different values to --list-cmds in git-completino.bash.

While at there, replace "git help -a" in git-completion.bash with
--list-cmds since it's better suited for this task.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 contrib/completion/git-completion.bash |  2 +-
 git.c                                  |  4 ++++
 help.c                                 | 32 ++++++++++++++++++++++++++
 help.h                                 |  4 ++++
 4 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 3556838759..62ca8641f4 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -839,7 +839,7 @@ __git_commands () {
 	then
 		printf "%s" "${GIT_TESTING_COMMAND_COMPLETION}"
 	else
-		git help -a|egrep '^  [a-zA-Z0-9]'
+		git --list-cmds=main,others
 	fi
 }
 
diff --git a/git.c b/git.c
index 376a59b97f..10907f7266 100644
--- a/git.c
+++ b/git.c
@@ -56,6 +56,10 @@ static int list_cmds(const char *spec)
 
 		if (match_token(spec, len, "builtins"))
 			list_builtins(&list, 0);
+		else if (match_token(spec, len, "main"))
+			list_all_main_cmds(&list);
+		else if (match_token(spec, len, "others"))
+			list_all_other_cmds(&list);
 		else
 			die(_("unsupported command listing type '%s'"), spec);
 		spec += len;
diff --git a/help.c b/help.c
index 2d6a3157f8..d5ce9dfcbb 100644
--- a/help.c
+++ b/help.c
@@ -297,6 +297,38 @@ void list_common_cmds_help(void)
 	print_cmd_by_category(common_categories);
 }
 
+void list_all_main_cmds(struct string_list *list)
+{
+	struct cmdnames main_cmds, other_cmds;
+	int i;
+
+	memset(&main_cmds, 0, sizeof(main_cmds));
+	memset(&other_cmds, 0, sizeof(other_cmds));
+	load_command_list("git-", &main_cmds, &other_cmds);
+
+	for (i = 0; i < main_cmds.cnt; i++)
+		string_list_append(list, main_cmds.names[i]->name);
+
+	clean_cmdnames(&main_cmds);
+	clean_cmdnames(&other_cmds);
+}
+
+void list_all_other_cmds(struct string_list *list)
+{
+	struct cmdnames main_cmds, other_cmds;
+	int i;
+
+	memset(&main_cmds, 0, sizeof(main_cmds));
+	memset(&other_cmds, 0, sizeof(other_cmds));
+	load_command_list("git-", &main_cmds, &other_cmds);
+
+	for (i = 0; i < other_cmds.cnt; i++)
+		string_list_append(list, other_cmds.names[i]->name);
+
+	clean_cmdnames(&main_cmds);
+	clean_cmdnames(&other_cmds);
+}
+
 int is_in_cmdlist(struct cmdnames *c, const char *s)
 {
 	int i;
diff --git a/help.h b/help.h
index b21d7c94e8..97e6c0965e 100644
--- a/help.h
+++ b/help.h
@@ -1,6 +1,8 @@
 #ifndef HELP_H
 #define HELP_H
 
+struct string_list;
+
 struct cmdnames {
 	int alloc;
 	int cnt;
@@ -17,6 +19,8 @@ static inline void mput_char(char c, unsigned int num)
 }
 
 extern void list_common_cmds_help(void);
+extern void list_all_main_cmds(struct string_list *list);
+extern void list_all_other_cmds(struct string_list *list);
 extern const char *help_unknown_cmd(const char *cmd);
 extern void load_command_list(const char *prefix,
 			      struct cmdnames *main_cmds,
-- 
2.17.0.705.g3525833791

