Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7DB4D1F51C
	for <e@80x24.org>; Sun, 20 May 2018 18:40:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751523AbeETSkf (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 May 2018 14:40:35 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:38747 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751045AbeETSka (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 May 2018 14:40:30 -0400
Received: by mail-lf0-f66.google.com with SMTP id z142-v6so20767684lff.5
        for <git@vger.kernel.org>; Sun, 20 May 2018 11:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HBbFgA+DTR0oCoAY4aT0HeTojxuTjdliHg7eJRCYeP8=;
        b=F7VoNH79HXkYEV2fPCSbCumHKm/SNVgKZvwfEZAU+bp2cboaqQWs4EBVzEitw/wHre
         X8y6wHzeoXoqv+QpXk80CC/kW8afIutPtFXdij7s4LS89iU2Tj8MIpyiF4OSNr2yTya7
         sjfACJ35pN/YF2zXa5p9mRykhWVBY7mafuqJhyLaFm55iUbjTTLAuR2U68gi2TmHUFDF
         iMJfB6p0HR08NUaD9uBfLXGyaH2R6ZgYUKW1T3QGbMHtm3ezxn6iGGpP6NkZx+/qBgEs
         Pvj5pJ2wAJqQxXT94P4U14WgT0FHXmEszPCPTfkRlDiEiHYJfgRaPIeQHgyzEXv4NTDO
         1Iow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HBbFgA+DTR0oCoAY4aT0HeTojxuTjdliHg7eJRCYeP8=;
        b=Mo+VkbZaFlMSQuBQ1WCrd+shc6hJdYvYdEVstBiSdh+QflzSDXpicI7yFHg3pkgqV5
         vYgebb5xCV7ECvMl2js8dxciVzkVVr/DpxzmfOoWnjwKXjt0WNu4G6pqeOBZMx3YV1x1
         /j4k2KFXZdVlLy2aL13lGGIDuDCTMjrQ6kPk5dUp+PhXe1m2mIFlKax+l7XzsLE3PNtz
         NcBozDIE4O/ujzejSA0Zgv9JOtNceJv4zhSUY3yFFgn5YQWsx/MKlsJzazrJ6zEfR4Lh
         7p7JwQmq6hvvmQ5HcbMxWhDIzvXZOa6lanCXg2nFqsEL1ZD730NWUsUzIlugmZ/t8tcF
         N6QA==
X-Gm-Message-State: ALKqPwdpgPR7fOMwCLZcDd5sDdNaJR5KCGtp13a4oruJIbpCNVw0aiew
        R9nlSJURe1MJxty4N4IXRfUiiQ==
X-Google-Smtp-Source: AB8JxZp0+Y6Um15mbJ8zS29vRmW2DNZGr8boy4B/MLeMzJp8pNsNzfMwZRlJKO3E697Dij0mTayEgA==
X-Received: by 2002:a19:51c9:: with SMTP id g70-v6mr17981552lfl.50.1526841628398;
        Sun, 20 May 2018 11:40:28 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id k5-v6sm2176906lji.39.2018.05.20.11.40.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 May 2018 11:40:27 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 07/17] completion: implement and use --list-cmds=main,others
Date:   Sun, 20 May 2018 20:39:59 +0200
Message-Id: <20180520184009.976-8-pclouds@gmail.com>
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
 Documentation/git.txt                  |  3 ++-
 contrib/completion/git-completion.bash |  2 +-
 git.c                                  |  4 ++++
 help.c                                 | 32 ++++++++++++++++++++++++++
 help.h                                 |  4 ++++
 5 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 2800e3d188..c01477ab5e 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -167,7 +167,8 @@ foo.bar= ...`) sets `foo.bar` to the empty string which `git config
 	List commands by group. This is an internal/experimental
 	option and may change or be removed in the future. Supported
 	groups are: builtins, parseopt (builtin commands that use
-	parse-options).
+	parse-options), main (all commands in libexec directory),
+	others (all other commands in `$PATH` that have git- prefix).
 
 GIT COMMANDS
 ------------
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

