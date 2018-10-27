Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26F0E1F454
	for <e@80x24.org>; Sat, 27 Oct 2018 06:25:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728529AbeJ0PFJ (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 11:05:09 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38791 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728238AbeJ0PFJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 11:05:09 -0400
Received: by mail-lj1-f194.google.com with SMTP id k11-v6so3114683lja.5
        for <git@vger.kernel.org>; Fri, 26 Oct 2018 23:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HbAyPcAgJbxT8ARauRA7+kIY6eu1AinGlRWp3EFJJuM=;
        b=HfZYGXWhrKyUWmsv2mSK0XOiMTnbB1riznvaX9ykKfnqhcbIvpkWyfaNORyoNg4HL1
         A/LPoXwLZ7qzcQI82BbpHGY5jlYGmo0M6MJBKWNY0Vhkpjp1kj/PZgC1b3APnMEQr6wp
         kvicERKKIgi+gCXLxhWKxMwMJov3qfe2k0c0Ms6Qg961M34+gTCbYQZm+VvaFxmKoUS6
         BL226hYZZDBoIWVWp+O+sVbnLKNBAY+9XvuJJVmNpQoSAssMLDqW0ZTJWxV9Qc/pET6L
         EK+6jJMvsPwlDQYfVgFojnwsw8ILZcB+Ps4P5c/OTv5MfgMdRThTy3t67OHPHbaqy+dM
         OYsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HbAyPcAgJbxT8ARauRA7+kIY6eu1AinGlRWp3EFJJuM=;
        b=BnCP4io6tPoTQedZPD1otQNfjxELYWV45YZTLKYmESIN4X4t7PTi+LW1shXwKi7iZc
         1t9d6l2Lyn0x2vtYVAbpLO2Mf2EOkHBg8t6OAf5Syq4WEaYDacMe+1KRv2yDL4yspBOl
         D7sbDueVSN38S//bOnh6e5XGxF1OfcEcG/MnX1UUbjsOyUktvpTlWyvp6RyEoAkve+t5
         Bi9kP5QO5Z3XlDjieCVNRKakigCjr1SSXrp6E2HGT3M3NT377y6Psb4YCYGSLN7s4E4r
         otza5HSohtFl3AA4MweH32prOB/VE6rvaSZiqW1sJK3BwhXzoVgXNAyxXKzOKYy4cxqr
         IXoA==
X-Gm-Message-State: AGRZ1gL1RIJH7ig1s8sH7jnvPBwiRRDEk2C3r+VYid9CkHVqIPLMS2Tb
        UchL/5WmOCsI6caLDveiLA45Atp9
X-Google-Smtp-Source: AJdET5e44ebEz/OtC0FspS3fsUJGFjFj3GjP+MJlmpCHGp8GzdZhxjSr4pa6m0oCSCtdiZDFLwauHg==
X-Received: by 2002:a2e:1615:: with SMTP id w21-v6mr4196875ljd.33.1540621512106;
        Fri, 26 Oct 2018 23:25:12 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id c81-v6sm2097487lfe.79.2018.10.26.23.25.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 23:25:11 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 66/78] config.txt: move status.* to a separate file
Date:   Sat, 27 Oct 2018 08:23:39 +0200
Message-Id: <20181027062351.30446-67-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.647.g708186aaf9
In-Reply-To: <20181027062351.30446-1-pclouds@gmail.com>
References: <20181027062351.30446-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/config.txt        | 73 +--------------------------------
 Documentation/config/status.txt | 72 ++++++++++++++++++++++++++++++++
 2 files changed, 73 insertions(+), 72 deletions(-)
 create mode 100644 Documentation/config/status.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 13beb1ea18..5e9fc20c41 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -413,78 +413,7 @@ include::config/splitindex.txt[]
 
 include::config/ssh.txt[]
 
-status.relativePaths::
-	By default, linkgit:git-status[1] shows paths relative to the
-	current directory. Setting this variable to `false` shows paths
-	relative to the repository root (this was the default for Git
-	prior to v1.5.4).
-
-status.short::
-	Set to true to enable --short by default in linkgit:git-status[1].
-	The option --no-short takes precedence over this variable.
-
-status.branch::
-	Set to true to enable --branch by default in linkgit:git-status[1].
-	The option --no-branch takes precedence over this variable.
-
-status.displayCommentPrefix::
-	If set to true, linkgit:git-status[1] will insert a comment
-	prefix before each output line (starting with
-	`core.commentChar`, i.e. `#` by default). This was the
-	behavior of linkgit:git-status[1] in Git 1.8.4 and previous.
-	Defaults to false.
-
-status.renameLimit::
-	The number of files to consider when performing rename detection
-	in linkgit:git-status[1] and linkgit:git-commit[1]. Defaults to
-	the value of diff.renameLimit.
-
-status.renames::
-	Whether and how Git detects renames in linkgit:git-status[1] and
-	linkgit:git-commit[1] .  If set to "false", rename detection is
-	disabled. If set to "true", basic rename detection is enabled.
-	If set to "copies" or "copy", Git will detect copies, as well.
-	Defaults to the value of diff.renames.
-
-status.showStash::
-	If set to true, linkgit:git-status[1] will display the number of
-	entries currently stashed away.
-	Defaults to false.
-
-status.showUntrackedFiles::
-	By default, linkgit:git-status[1] and linkgit:git-commit[1] show
-	files which are not currently tracked by Git. Directories which
-	contain only untracked files, are shown with the directory name
-	only. Showing untracked files means that Git needs to lstat() all
-	the files in the whole repository, which might be slow on some
-	systems. So, this variable controls how the commands displays
-	the untracked files. Possible values are:
-+
---
-* `no` - Show no untracked files.
-* `normal` - Show untracked files and directories.
-* `all` - Show also individual files in untracked directories.
---
-+
-If this variable is not specified, it defaults to 'normal'.
-This variable can be overridden with the -u|--untracked-files option
-of linkgit:git-status[1] and linkgit:git-commit[1].
-
-status.submoduleSummary::
-	Defaults to false.
-	If this is set to a non zero number or true (identical to -1 or an
-	unlimited number), the submodule summary will be enabled and a
-	summary of commits for modified submodules will be shown (see
-	--summary-limit option of linkgit:git-submodule[1]). Please note
-	that the summary output command will be suppressed for all
-	submodules when `diff.ignoreSubmodules` is set to 'all' or only
-	for those submodules where `submodule.<name>.ignore=all`. The only
-	exception to that rule is that status and commit will show staged
-	submodule changes. To
-	also view the summary for ignored submodules you can either use
-	the --ignore-submodules=dirty command-line option or the 'git
-	submodule summary' command, which shows a similar output but does
-	not honor these settings.
+include::config/status.txt[]
 
 stash.showPatch::
 	If this is set to true, the `git stash show` command without an
diff --git a/Documentation/config/status.txt b/Documentation/config/status.txt
new file mode 100644
index 0000000000..ed72fa7dae
--- /dev/null
+++ b/Documentation/config/status.txt
@@ -0,0 +1,72 @@
+status.relativePaths::
+	By default, linkgit:git-status[1] shows paths relative to the
+	current directory. Setting this variable to `false` shows paths
+	relative to the repository root (this was the default for Git
+	prior to v1.5.4).
+
+status.short::
+	Set to true to enable --short by default in linkgit:git-status[1].
+	The option --no-short takes precedence over this variable.
+
+status.branch::
+	Set to true to enable --branch by default in linkgit:git-status[1].
+	The option --no-branch takes precedence over this variable.
+
+status.displayCommentPrefix::
+	If set to true, linkgit:git-status[1] will insert a comment
+	prefix before each output line (starting with
+	`core.commentChar`, i.e. `#` by default). This was the
+	behavior of linkgit:git-status[1] in Git 1.8.4 and previous.
+	Defaults to false.
+
+status.renameLimit::
+	The number of files to consider when performing rename detection
+	in linkgit:git-status[1] and linkgit:git-commit[1]. Defaults to
+	the value of diff.renameLimit.
+
+status.renames::
+	Whether and how Git detects renames in linkgit:git-status[1] and
+	linkgit:git-commit[1] .  If set to "false", rename detection is
+	disabled. If set to "true", basic rename detection is enabled.
+	If set to "copies" or "copy", Git will detect copies, as well.
+	Defaults to the value of diff.renames.
+
+status.showStash::
+	If set to true, linkgit:git-status[1] will display the number of
+	entries currently stashed away.
+	Defaults to false.
+
+status.showUntrackedFiles::
+	By default, linkgit:git-status[1] and linkgit:git-commit[1] show
+	files which are not currently tracked by Git. Directories which
+	contain only untracked files, are shown with the directory name
+	only. Showing untracked files means that Git needs to lstat() all
+	the files in the whole repository, which might be slow on some
+	systems. So, this variable controls how the commands displays
+	the untracked files. Possible values are:
++
+--
+* `no` - Show no untracked files.
+* `normal` - Show untracked files and directories.
+* `all` - Show also individual files in untracked directories.
+--
++
+If this variable is not specified, it defaults to 'normal'.
+This variable can be overridden with the -u|--untracked-files option
+of linkgit:git-status[1] and linkgit:git-commit[1].
+
+status.submoduleSummary::
+	Defaults to false.
+	If this is set to a non zero number or true (identical to -1 or an
+	unlimited number), the submodule summary will be enabled and a
+	summary of commits for modified submodules will be shown (see
+	--summary-limit option of linkgit:git-submodule[1]). Please note
+	that the summary output command will be suppressed for all
+	submodules when `diff.ignoreSubmodules` is set to 'all' or only
+	for those submodules where `submodule.<name>.ignore=all`. The only
+	exception to that rule is that status and commit will show staged
+	submodule changes. To
+	also view the summary for ignored submodules you can either use
+	the --ignore-submodules=dirty command-line option or the 'git
+	submodule summary' command, which shows a similar output but does
+	not honor these settings.
-- 
2.19.1.647.g708186aaf9

