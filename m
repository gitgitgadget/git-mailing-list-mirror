Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F94D1F453
	for <e@80x24.org>; Sat, 20 Oct 2018 12:40:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbeJTUuj (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Oct 2018 16:50:39 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44853 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727692AbeJTUui (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Oct 2018 16:50:38 -0400
Received: by mail-lj1-f193.google.com with SMTP id v6-v6so33059517ljc.11
        for <git@vger.kernel.org>; Sat, 20 Oct 2018 05:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L6yfg0IOKx2TlE/F91oWyM5GVprPRb0Y+K4Y/vv0KqY=;
        b=t9LDgIE9FLAMyNtyH4+SGwpQXBiQfO/Q0pNsH9QCprwb9vGInN8ATDZhi9d4U6M4SL
         jvtyFHEDnafAWRfr+N4xyMEllbU/jaczpIB9+yDFwq7tEADmt/nvIDcThX+gqF6mjIPK
         rdab7h0CgI0YLBGRyNFuTBuXCi6EwotyGNErHvEiyer0Ilqad9k4GF4iotakfTFyEwMQ
         EHm+tr6EBomWgB3RT6arlNptY5Vpm1lHwwOVKQYYKiSCF7UN6QrCYBSIcQHktS7gNFL3
         D4buuxAOJqJRU2/S81NK1mHqhoYxNCgc+Kx3fTEC+FC4vnmt29ZM14oqCQ306Rz57vDo
         RUsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L6yfg0IOKx2TlE/F91oWyM5GVprPRb0Y+K4Y/vv0KqY=;
        b=bS86Iwx2dBTq+PBetmKD31PD7qnZmvmommwiEzl/Zwx4u3IJPX16jvpLkQJghqcslA
         +Zolh01ojt4YrDnv+EfkqELWm1lIjfcXAfAxPwxkWQJpN3MZW5KZ1PLppSqwyxpTatI8
         s4lRcFIv2wRFJCktn/lZYEXL/n/87zJ9vRTBASwVtUMnkhjHVsNw5cwvMN/2mWDd1dnD
         /K5AeP/vl/c9RMeYy5V2p9a6+wwzgcKpm4WSfDd0qLmPecP/nFQ5UKMMT6GuAjjycuaI
         G8+yj+cun6VCFqh97LctYyjU06Yu/FxC/ltMBc/no9241qyD1wrTo0W9+tqDYes+zvtK
         qIuA==
X-Gm-Message-State: ABuFfoj1RsQ/TfNFsTzCAWGs+TL3dd6RzbDDIccmDO6nKMJrzzy8YpLX
        MJhSm2zeljIAY6iA2TKR+BbZH/yZ
X-Google-Smtp-Source: ACcGV63W7MqlXV/nx/ROvIcfqB74jApGfmtr9uTZzyn689+vt+rbgmQ1SDC2DfAmL+7txyvi3MWvuw==
X-Received: by 2002:a2e:92ca:: with SMTP id k10-v6mr25191029ljh.103.1540039215605;
        Sat, 20 Oct 2018 05:40:15 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id o22-v6sm5759379ljc.79.2018.10.20.05.40.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Oct 2018 05:40:14 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 50/59] config.txt: move status.* to a separate file
Date:   Sat, 20 Oct 2018 14:38:39 +0200
Message-Id: <20181020123848.2785-51-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.647.g708186aaf9
In-Reply-To: <20181020123848.2785-1-pclouds@gmail.com>
References: <20181020123848.2785-1-pclouds@gmail.com>
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
 Documentation/status-config.txt | 72 ++++++++++++++++++++++++++++++++
 2 files changed, 73 insertions(+), 72 deletions(-)
 create mode 100644 Documentation/status-config.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 2330acd840..b7df6a8311 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -662,78 +662,7 @@ include::splitindex-config.txt[]
 
 include::ssh-config.txt[]
 
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
+include::status-config.txt[]
 
 stash.showPatch::
 	If this is set to true, the `git stash show` command without an
diff --git a/Documentation/status-config.txt b/Documentation/status-config.txt
new file mode 100644
index 0000000000..ed72fa7dae
--- /dev/null
+++ b/Documentation/status-config.txt
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

