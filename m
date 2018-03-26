Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBAB71F404
	for <e@80x24.org>; Mon, 26 Mar 2018 16:56:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752370AbeCZQ4L (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Mar 2018 12:56:11 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:46886 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751692AbeCZQ4J (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Mar 2018 12:56:09 -0400
Received: by mail-lf0-f66.google.com with SMTP id j68-v6so29164136lfg.13
        for <git@vger.kernel.org>; Mon, 26 Mar 2018 09:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i1wnC8JJ9h6KBvMo7piZYgcY77I39ZB8ABgs1reS4tU=;
        b=HgZpYy3J6m5+4f9SeF9U1FP5dl0Xkt45GYztSP0G7T0dsuA+43LIii7Ua2OfGYFj5J
         RXxE5li15nRWs5OT0RRdmOkFqcLDb9bVDQ+GDLDC9V0MsV7rWeV7Hpli3CTE/p7oES/N
         PErc7OYWU+FxkEREGCJYaesR84l2fBQE5exfBWOzoxawrjMPkmHktMx+5Dj50pVVi6n7
         KgOjLK1du31A/rMp3gpOlS64T6Yhha0uXyYUo8vT+QVXJOZNOJzwgjjPb4tbzfbIRvRj
         s4X18ffe2mrqqPVW2wh/fnnC6Q+o29pA/FOyp6QlAtsmD4TBWCVTBSiYv6+2gfQWz+iz
         eHrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i1wnC8JJ9h6KBvMo7piZYgcY77I39ZB8ABgs1reS4tU=;
        b=qVd1ZgXtuG1f6j+7mVE8rK/4+Il5nIWKXeQI6qyW2AfN1XsP6PxaomB37HKafHWLZe
         TGACb2IOEbQXiIbSQ3oLKZsPV3vfje3bRb6RB3rsgK+8E4C7z7fLQQImf7JSKkikNkuS
         bXHqZTwT168+J/x+8TbezHvzF6tQhl3C9dqYeeZDEWLZVEZLYzO0XTfoAnMJbitrtUw+
         g1eRtgaUcwxETkArdg6b5hGmop1vCoYc57muzqwL9EG0IeQWQWyQGOKGbIV2lICPdQR5
         Ns+fAnVpiWHaxIC8q5IA8oJ2XAin6T2GgLNPBmkn/MpLDJXxUivvU8PUhzEuOUWDmf0q
         SBOw==
X-Gm-Message-State: AElRT7ELp6rDy/hub0649/UX581HRd/sfvY2e1MV6WFZOws0U5cKZ1M7
        AgmSzKVsQvd+wcBh4w9BQnNZSQ==
X-Google-Smtp-Source: AG47ELvAnSf3FGMFNxFGlT3oGKuCJDWyjATV28QBK4uIbV3u3hbiT+mMyhgeLF62PDaqAX9blXpzJg==
X-Received: by 10.46.133.135 with SMTP id b7mr26574723lji.41.1522083367390;
        Mon, 26 Mar 2018 09:56:07 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id j8sm814451lje.83.2018.03.26.09.56.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Mar 2018 09:56:06 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH/RFC 2/5] git.c: implement --list-cmds=all and use it in git-completion.bash
Date:   Mon, 26 Mar 2018 18:55:17 +0200
Message-Id: <20180326165520.802-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.rc0.348.gd5a49e0b6f
In-Reply-To: <20180326165520.802-1-pclouds@gmail.com>
References: <20180326165520.802-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 contrib/completion/git-completion.bash |  2 +-
 git.c                                  |  2 ++
 help.c                                 | 15 +++++++++++++++
 help.h                                 |  1 +
 4 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index c7957f0a90..e0f545819d 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -833,7 +833,7 @@ __git_commands () {
 	then
 		printf "%s" "${GIT_TESTING_COMMAND_COMPLETION}"
 	else
-		git help -a|egrep '^  [a-zA-Z0-9]'
+		git --list-cmds=all
 	fi
 }
 
diff --git a/git.c b/git.c
index f350002260..2e0c5e17e2 100644
--- a/git.c
+++ b/git.c
@@ -208,6 +208,8 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 		} else if (skip_prefix(cmd, "--list-cmds=", &cmd)) {
 			if (!strcmp(cmd, "builtins"))
 				list_builtins();
+			else if (!strcmp(cmd, "all"))
+				list_all_cmds();
 			else
 				die("unsupported command listing type '%s'", cmd);
 			exit(0);
diff --git a/help.c b/help.c
index 60071a9bea..f3f35dfbb1 100644
--- a/help.c
+++ b/help.c
@@ -228,6 +228,21 @@ void list_common_cmds_help(void)
 	}
 }
 
+void list_all_cmds(void)
+{
+	struct cmdnames main_cmds, other_cmds;
+	int i;
+
+	memset(&main_cmds, 0, sizeof(main_cmds));
+	memset(&other_cmds, 0, sizeof(other_cmds));
+	load_command_list("git-", &main_cmds, &other_cmds);
+
+	for (i = 0; i < main_cmds.cnt; i++)
+		puts(main_cmds.names[i]->name);
+	for (i = 0; i < other_cmds.cnt; i++)
+		puts(other_cmds.names[i]->name);
+}
+
 int is_in_cmdlist(struct cmdnames *c, const char *s)
 {
 	int i;
diff --git a/help.h b/help.h
index b21d7c94e8..0bf29f8dc5 100644
--- a/help.h
+++ b/help.h
@@ -17,6 +17,7 @@ static inline void mput_char(char c, unsigned int num)
 }
 
 extern void list_common_cmds_help(void);
+extern void list_all_cmds(void);
 extern const char *help_unknown_cmd(const char *cmd);
 extern void load_command_list(const char *prefix,
 			      struct cmdnames *main_cmds,
-- 
2.17.0.rc0.348.gd5a49e0b6f

