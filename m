Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DF641F453
	for <e@80x24.org>; Sat, 10 Nov 2018 05:43:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728893AbeKJP0u (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Nov 2018 10:26:50 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:45599 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728567AbeKJP0t (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Nov 2018 10:26:49 -0500
Received: by mail-lf1-f65.google.com with SMTP id b20so2806586lfa.12
        for <git@vger.kernel.org>; Fri, 09 Nov 2018 21:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vbg/HmGTmMkxuobaqt08V5vv/zUhOAeCBh/WiLcKz+k=;
        b=vaox0g70qFHKAu40pajNNv7kewt8hTHWk6zwL7rQmsBxeouImaX2y2Zoqa2hcMxY61
         S7/uDK5bYwWraxWIHVBtt8xteqsI/JUlte5ePnS8zRk9tlOwh4l9i2LJJoRLDL37KAgu
         12vmRjB+4nDBWeLc/3uvTyqaV49IiOaNMRq/ojCJvVC8iPFBC0IWBwere2utR/cJXCj+
         9YGmG9tjHvwW/JUpgLjUv9iKc7nN+4pNufQePP8tvYqWkU65y/vhpYozJ0PfMNxHkKJ8
         QaWKPVL19Y+Xv+0v4BqCZA3KEHHpMctBkbPIOptYkXGKz91RVgkz55bAyKiYi0jESAff
         Easw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vbg/HmGTmMkxuobaqt08V5vv/zUhOAeCBh/WiLcKz+k=;
        b=HbqdyNxRhLRyRbA7K5yleaqfJJrEkWYQGV+OWOiueqqvr7Fv7iAn3qEt83CPtD7ZmD
         N59JQaNb6HjcaCIgjraqr/fcxF6z+tDw8Z4vYQFLR+s72nYUFZJpnO9g4llh5sc1WDFF
         CHxQ7V+DKP4SuPW8W0X/jDJ1lpcXul74IEYWVIhjPbXMBlJCkw86MYYAhRWNaPuCYE3M
         kkAftWRWirHCf0y2q2T/ih1K3fvVNWjT+IKACuDiETVwA15OGCLb5NeGH8QhX1W1H/0W
         iF8jnBHvclsr3mq8eh3xCxNhNQREM9cr61cPhy07ew8zWoM/eDhv0qDVeDpiY9I8lcof
         vKNA==
X-Gm-Message-State: AGRZ1gIcAuaB3W+JJwzhYZvixUAnKF/6OBz+75F1pLaX2DFIZ4f6Un+D
        OB1kYFqW6IFnGoj2ncyXsdo=
X-Google-Smtp-Source: AJdET5dxk/8r9CeBnNxLGyfkeOWOwuh5bGiI/cca0EYMDOHgHw/2oV8wDgBoEuWrT9P4MYhaKCs5pw==
X-Received: by 2002:a19:6e0b:: with SMTP id j11mr7296005lfc.124.1541826983034;
        Fri, 09 Nov 2018 21:16:23 -0800 (PST)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g66sm1769663lfe.42.2018.11.09.21.16.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 21:16:22 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, szeder.dev@gmail.com
Subject: [PATCH v3 01/16] git.c: mark more strings for translation
Date:   Sat, 10 Nov 2018 06:16:00 +0100
Message-Id: <20181110051615.8641-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.1231.g84aef82467
In-Reply-To: <20181110051615.8641-1-pclouds@gmail.com>
References: <20181105192059.20303-1-pclouds@gmail.com>
 <20181110051615.8641-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

One string is slightly updated to keep consistency with the rest:
die() should begin with lowercase.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 git.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/git.c b/git.c
index adac132956..5fd30da093 100644
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
+			die(_("%s doesn't support --super-prefix"), p->cmd);
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
+		die(_("%s doesn't support --super-prefix"), argv[0]);
 
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
2.19.1.1231.g84aef82467

