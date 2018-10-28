Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A3941F454
	for <e@80x24.org>; Sun, 28 Oct 2018 06:52:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727532AbeJ1Pfs (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Oct 2018 11:35:48 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40485 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbeJ1Pfs (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Oct 2018 11:35:48 -0400
Received: by mail-lj1-f193.google.com with SMTP id t22-v6so4788615lji.7
        for <git@vger.kernel.org>; Sat, 27 Oct 2018 23:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0oAnrQf77bV8x6zqJItp0DV6sU7wpFBQ9f7w61XuEZ0=;
        b=h+8FXu/FC8i+bJNwe6q3uWRxmSOQ5DOqVz0fUvel5ha+fHiUU1Ag7nlJ7d5WMseTKN
         jcN23WVJV3Z+cAECmKVg5Xib6a5ZyTwk1KgT/Qgmr/oLXyxDDlQ9ntIaUhwkXFqn4kMC
         nLFoJaybkhc40GhbBcNpusgiH/Ya3uunwxAYI62hK2jP8dgwmuGXo5RaHT7e1fpreXIm
         FygaipfoDnCa3/qzNrYcQ6hXdZ5AOJS1pzRDDccDvjddU6m2RDtIK8pV2ME4Re92EirG
         Ww3n1m4fzwLgPhZNLZpQ8XLWjIT5/532fg5oX0C2T3pDs6apsbsioWZ1ugrCEi3FyUZp
         OJmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0oAnrQf77bV8x6zqJItp0DV6sU7wpFBQ9f7w61XuEZ0=;
        b=YO1uP9r/EdrJ2759CtxyEB74WUKKHGFBwgatXFLGtK8HEF+He68qxdfjV8683ssF1B
         fZBJQzNAll74PC2pl0oT5HiMYbwp0xEx4Ne55RwzJJxiKVoIqYNu+fSAL2SQr0swvOlH
         nthOuH/JuuE/ZmPb5VilVjisrGA/IgY14jBN6gMslsw9Nqc+HPPQYy3AQ/7pmf5LTqp8
         a/m/x5vYCX+jes3E2+cv+tgGgzFk7PnbTg7YLlBf7s0/Ql1Xz2bjmRjRUfiMIpz1Duv3
         LVrmmQww1B0te8nKCsIscFXfzl8KYJ5cBRtlHaxDSQCb1VMqpo6mBLVbWNcWBsKHrEWi
         gNsw==
X-Gm-Message-State: AGRZ1gJwAWy0uH5LJPu8mJgtYJI5TWmZ33ohTIMDU7pKY1PBgxYNN5Ei
        g3+aUd2dZm+PfAhbZrkhRMF11sXT
X-Google-Smtp-Source: AJdET5dZvL+keCTSXAKaFBrK2z672NhEA3F9LgBYd6lUOuar4qf2xqh9EsMBuYWB5z5NPpKSLoI33A==
X-Received: by 2002:a2e:8eca:: with SMTP id e10-v6mr3295178ljl.109.1540709523443;
        Sat, 27 Oct 2018 23:52:03 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id v23-v6sm148847ljd.70.2018.10.27.23.52.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Oct 2018 23:52:02 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 01/12] git.c: mark more strings for translation
Date:   Sun, 28 Oct 2018 07:51:46 +0100
Message-Id: <20181028065157.26727-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.647.g708186aaf9
In-Reply-To: <20181028065157.26727-1-pclouds@gmail.com>
References: <20181028065157.26727-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 git.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/git.c b/git.c
index adac132956..1ad565c5c8 100644
--- a/git.c
+++ b/git.c
@@ -338,27 +338,27 @@ static int handle_alias(int *argcp, const char ***argv)
 			if (ret >= 0)   /* normal exit */
 				exit(ret);
 
-			die_errno("while expanding alias '%s': '%s'",
-			    alias_command, alias_string + 1);
+			die_errno(_("while expanding alias '%s': '%s'"),
+				  alias_command, alias_string + 1);
 		}
 		count = split_cmdline(alias_string, &new_argv);
 		if (count < 0)
-			die("Bad alias.%s string: %s", alias_command,
+			die(_("bad alias.%s string: %s"), alias_command,
 			    split_cmdline_strerror(count));
 		option_count = handle_options(&new_argv, &count, &envchanged);
 		if (envchanged)
-			die("alias '%s' changes environment variables.\n"
-				 "You can use '!git' in the alias to do this",
-				 alias_command);
+			die(_("alias '%s' changes environment variables.\n"
+			      "You can use '!git' in the alias to do this"),
+			    alias_command);
 		memmove(new_argv - option_count, new_argv,
 				count * sizeof(char *));
 		new_argv -= option_count;
 
 		if (count < 1)
-			die("empty alias for %s", alias_command);
+			die(_("empty alias for %s"), alias_command);
 
 		if (!strcmp(alias_command, new_argv[0]))
-			die("recursive alias: %s", alias_command);
+			die(_("recursive alias: %s"), alias_command);
 
 		trace_argv_printf(new_argv,
 				  "trace: alias expansion: %s =>",
@@ -409,7 +409,7 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
 
 	if (!help && get_super_prefix()) {
 		if (!(p->option & SUPPORT_SUPER_PREFIX))
-			die("%s doesn't support --super-prefix", p->cmd);
+			BUG("%s doesn't support --super-prefix", p->cmd);
 	}
 
 	if (!help && p->option & NEED_WORK_TREE)
@@ -433,11 +433,11 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
 
 	/* Check for ENOSPC and EIO errors.. */
 	if (fflush(stdout))
-		die_errno("write failure on standard output");
+		die_errno(_("write failure on standard output"));
 	if (ferror(stdout))
-		die("unknown write failure on standard output");
+		die(_("unknown write failure on standard output"));
 	if (fclose(stdout))
-		die_errno("close failed on standard output");
+		die_errno(_("close failed on standard output"));
 	return 0;
 }
 
@@ -648,7 +648,7 @@ static void execv_dashed_external(const char **argv)
 	int status;
 
 	if (get_super_prefix())
-		die("%s doesn't support --super-prefix", argv[0]);
+		BUG("%s doesn't support --super-prefix", argv[0]);
 
 	if (use_pager == -1 && !is_builtin(argv[0]))
 		use_pager = check_pager_config(argv[0]);
@@ -760,7 +760,7 @@ int cmd_main(int argc, const char **argv)
 	if (skip_prefix(cmd, "git-", &cmd)) {
 		argv[0] = cmd;
 		handle_builtin(argc, argv);
-		die("cannot handle %s as a builtin", cmd);
+		die(_("cannot handle %s as a builtin"), cmd);
 	}
 
 	/* Look for flags.. */
@@ -773,7 +773,7 @@ int cmd_main(int argc, const char **argv)
 	} else {
 		/* The user didn't specify a command; give them help */
 		commit_pager_choice();
-		printf("usage: %s\n\n", git_usage_string);
+		printf(_("usage: %s\n\n"), git_usage_string);
 		list_common_cmds_help();
 		printf("\n%s\n", _(git_more_info_string));
 		exit(1);
-- 
2.19.1.647.g708186aaf9

