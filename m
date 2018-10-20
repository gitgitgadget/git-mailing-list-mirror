Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 461D01F453
	for <e@80x24.org>; Sat, 20 Oct 2018 12:40:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727678AbeJTUuU (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Oct 2018 16:50:20 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40480 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727652AbeJTUuT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Oct 2018 16:50:19 -0400
Received: by mail-lf1-f65.google.com with SMTP id n3-v6so277685lfe.7
        for <git@vger.kernel.org>; Sat, 20 Oct 2018 05:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KD0pzZsa7CPaOV7bs3UOC3qINNG7OYxdJhHquCyF5ig=;
        b=JCtAA++rcLgz3FvYFO1rQfQEyM1HoWXUe2Bl1NJENBlUZCHKwPZoMItoJ1CpI2A97g
         Tbz5Cmvw11ZgdnEyaD47jFRD9b3UKErNyBprIfuWFzoVjeMVEbG5il09dEW0ONLVnSmC
         HWLq2c5TP4/Rj9A0Pyb/Z0c37//UJAIChgNXdxry5mgcphGXMyjAWlSG4IwjM0ocZfMF
         tKBs5I8DbcOoDqe/lBCm2+P0oapXF1KsXwDQoBl8C+x6wdwCVlhwaBy0Hs3YjOLOt+lJ
         9hgxooLfvfREK41/Z06W1sviwBvG3JAqD76SCjrRseXTXu3IZCsrarVRuugiBoK9eJih
         +xpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KD0pzZsa7CPaOV7bs3UOC3qINNG7OYxdJhHquCyF5ig=;
        b=G93gc0be3JI9z61+q570aPbFe16dZqpdglfE67ZIqzJty+GVdVHH0oebJkxbILlF82
         m+rbaF+fdAKiwXNHghyxL29zat/3gKu2PZzbKJQQKLxGsLY9kRTHpHH4YnyvkSJXMqbQ
         fgvDs+ZtAORsoVmKDqDd0NcZjV2h+VZbWq92IbvIT39+xD9Ui1a6W7OsKlsbz1FDyXaP
         keoLRJYeoulLb6w4v8d8GmzNPRKoaDKzuWGuz9rav+QJvlubkWTuBBy8QJCZLRlElDYz
         qtaucOuGQ+4pvszSMqF6bbLGLBf5nQIvZ1Di+DlaLZ+TU4Ccq9eIrvgpoR+NXxBHixLs
         FoqA==
X-Gm-Message-State: ABuFfojYB5Kg4lrxSlVMJUbcDoJIiZsEGbP53Bq52I/Rnvfes85Hgd4t
        LsWCEKQU2a8xkecXDPt/3c1K8YJk
X-Google-Smtp-Source: ACcGV63oWkRL91BADD6tlVoDdzzYc6W0qHkN84UnyMv4dzQq5OF+bOyD3fv6I0VENkKnobJrOW++Vw==
X-Received: by 2002:a19:df54:: with SMTP id q20-v6mr5543335lfj.130.1540039196668;
        Sat, 20 Oct 2018 05:39:56 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id o22-v6sm5759379ljc.79.2018.10.20.05.39.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Oct 2018 05:39:56 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 37/59] config.txt: move mergetool.* to a separate file
Date:   Sat, 20 Oct 2018 14:38:26 +0200
Message-Id: <20181020123848.2785-38-pclouds@gmail.com>
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
 Documentation/config.txt           | 54 +-----------------------------
 Documentation/mergetool-config.txt | 53 +++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+), 53 deletions(-)
 create mode 100644 Documentation/mergetool-config.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 72222c113f..9acc42e3c2 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -624,59 +624,7 @@ include::man-config.txt[]
 
 include::merge-config.txt[]
 
-mergetool.<tool>.path::
-	Override the path for the given tool.  This is useful in case
-	your tool is not in the PATH.
-
-mergetool.<tool>.cmd::
-	Specify the command to invoke the specified merge tool.  The
-	specified command is evaluated in shell with the following
-	variables available: 'BASE' is the name of a temporary file
-	containing the common base of the files to be merged, if available;
-	'LOCAL' is the name of a temporary file containing the contents of
-	the file on the current branch; 'REMOTE' is the name of a temporary
-	file containing the contents of the file from the branch being
-	merged; 'MERGED' contains the name of the file to which the merge
-	tool should write the results of a successful merge.
-
-mergetool.<tool>.trustExitCode::
-	For a custom merge command, specify whether the exit code of
-	the merge command can be used to determine whether the merge was
-	successful.  If this is not set to true then the merge target file
-	timestamp is checked and the merge assumed to have been successful
-	if the file has been updated, otherwise the user is prompted to
-	indicate the success of the merge.
-
-mergetool.meld.hasOutput::
-	Older versions of `meld` do not support the `--output` option.
-	Git will attempt to detect whether `meld` supports `--output`
-	by inspecting the output of `meld --help`.  Configuring
-	`mergetool.meld.hasOutput` will make Git skip these checks and
-	use the configured value instead.  Setting `mergetool.meld.hasOutput`
-	to `true` tells Git to unconditionally use the `--output` option,
-	and `false` avoids using `--output`.
-
-mergetool.keepBackup::
-	After performing a merge, the original file with conflict markers
-	can be saved as a file with a `.orig` extension.  If this variable
-	is set to `false` then this file is not preserved.  Defaults to
-	`true` (i.e. keep the backup files).
-
-mergetool.keepTemporaries::
-	When invoking a custom merge tool, Git uses a set of temporary
-	files to pass to the tool. If the tool returns an error and this
-	variable is set to `true`, then these temporary files will be
-	preserved, otherwise they will be removed after the tool has
-	exited. Defaults to `false`.
-
-mergetool.writeToTemp::
-	Git writes temporary 'BASE', 'LOCAL', and 'REMOTE' versions of
-	conflicting files in the worktree by default.  Git will attempt
-	to use a temporary directory for these files when set `true`.
-	Defaults to `false`.
-
-mergetool.prompt::
-	Prompt before each invocation of the merge resolution program.
+include::mergetool-config.txt[]
 
 notes.mergeStrategy::
 	Which merge strategy to choose by default when resolving notes
diff --git a/Documentation/mergetool-config.txt b/Documentation/mergetool-config.txt
new file mode 100644
index 0000000000..09ed31dbfa
--- /dev/null
+++ b/Documentation/mergetool-config.txt
@@ -0,0 +1,53 @@
+mergetool.<tool>.path::
+	Override the path for the given tool.  This is useful in case
+	your tool is not in the PATH.
+
+mergetool.<tool>.cmd::
+	Specify the command to invoke the specified merge tool.  The
+	specified command is evaluated in shell with the following
+	variables available: 'BASE' is the name of a temporary file
+	containing the common base of the files to be merged, if available;
+	'LOCAL' is the name of a temporary file containing the contents of
+	the file on the current branch; 'REMOTE' is the name of a temporary
+	file containing the contents of the file from the branch being
+	merged; 'MERGED' contains the name of the file to which the merge
+	tool should write the results of a successful merge.
+
+mergetool.<tool>.trustExitCode::
+	For a custom merge command, specify whether the exit code of
+	the merge command can be used to determine whether the merge was
+	successful.  If this is not set to true then the merge target file
+	timestamp is checked and the merge assumed to have been successful
+	if the file has been updated, otherwise the user is prompted to
+	indicate the success of the merge.
+
+mergetool.meld.hasOutput::
+	Older versions of `meld` do not support the `--output` option.
+	Git will attempt to detect whether `meld` supports `--output`
+	by inspecting the output of `meld --help`.  Configuring
+	`mergetool.meld.hasOutput` will make Git skip these checks and
+	use the configured value instead.  Setting `mergetool.meld.hasOutput`
+	to `true` tells Git to unconditionally use the `--output` option,
+	and `false` avoids using `--output`.
+
+mergetool.keepBackup::
+	After performing a merge, the original file with conflict markers
+	can be saved as a file with a `.orig` extension.  If this variable
+	is set to `false` then this file is not preserved.  Defaults to
+	`true` (i.e. keep the backup files).
+
+mergetool.keepTemporaries::
+	When invoking a custom merge tool, Git uses a set of temporary
+	files to pass to the tool. If the tool returns an error and this
+	variable is set to `true`, then these temporary files will be
+	preserved, otherwise they will be removed after the tool has
+	exited. Defaults to `false`.
+
+mergetool.writeToTemp::
+	Git writes temporary 'BASE', 'LOCAL', and 'REMOTE' versions of
+	conflicting files in the worktree by default.  Git will attempt
+	to use a temporary directory for these files when set `true`.
+	Defaults to `false`.
+
+mergetool.prompt::
+	Prompt before each invocation of the merge resolution program.
-- 
2.19.1.647.g708186aaf9

