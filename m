Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB63620A40
	for <e@80x24.org>; Mon, 27 Nov 2017 04:55:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751227AbdK0Ezj (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Nov 2017 23:55:39 -0500
Received: from mail-io0-f193.google.com ([209.85.223.193]:35532 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750932AbdK0Ezh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Nov 2017 23:55:37 -0500
Received: by mail-io0-f193.google.com with SMTP id i38so34935917iod.2
        for <git@vger.kernel.org>; Sun, 26 Nov 2017 20:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=v62cJoI35eLb+9SK49/iLre6zkWxu1VZsSbhCXm6ATQ=;
        b=l1m+gZLuDwGKkC4kbn8Tol3ZpoXuoZ/z5GAkvYUEzfUqoVeWPRO1OjlTYSOCRqY3p4
         Yup+qcLPisLzHF7IUwEVCDeT+f2hTlYF2UxfswYyqhvmEpn2WWsfq9bQ3OaL1agMG1ZE
         PS/JpSFVha4vSjGbRmx8lroy9+63KteCwpK5I8fA3qPNmHwFwRp+KWAdJ1dI9/kDnwVK
         bR8Qo5/8OshPmCGWtpeudvcEiQcQtvtE5CZ135IEdncJonAiZ+ZJRbxUeya8u08oyqEh
         0yel4yk350VAmNaMKItV9pUWfn52iw9tWdeLK1HerrWi1KjZffeIS8G0n1zAoHj8wT0C
         iwVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=v62cJoI35eLb+9SK49/iLre6zkWxu1VZsSbhCXm6ATQ=;
        b=I4ph5nW9Wj7MWdANWAEIC23pwkoVK0oC8HYQHeLzfXGAqMU+yKq6Ye38dYpN4PCiUu
         0dgwM9sucPytCdNIKpx14le4//dHGJ0asG/FaNzonHdH3ra+MM4xFo3JFwLl4kiQGB4K
         7stBsiGbL4/V1i1KclbNjq/SATVqlG0NCX6wEPY0IemSSn7DeeJGR68ZkUi6rabt8c73
         jHLfSt03bGKcoEFyGLXiTf6yPke+GzMt5hKtO9nh/RCnvrQ5cdZiJ5uUPUNdpWE+Ebd3
         5ugN++uZj7T+yUP0nh4DVhY/PkLC5nZCMw+s/8nJ22GYbK6W/ffRUnhbMxIImqwXd5tr
         Vb9Q==
X-Gm-Message-State: AJaThX6Pct0+J9g0v1oHmMx3ZtWBIQF9Qdfjui9RfQIRyOP855pM3ACV
        Mn497xWorX6+k9SAtzhEfuazEC8/
X-Google-Smtp-Source: AGs4zMZFvj6nc8nwVTdkS3oHKAfIzUhhKvp3mSh1dg+nf0NujZCzAY+N9YavwTlQGupkT5s0MKNRfA==
X-Received: by 10.107.130.227 with SMTP id m96mr39560314ioi.35.1511758536921;
        Sun, 26 Nov 2017 20:55:36 -0800 (PST)
Received: from localhost.localdomain (24-212-246-46.cable.teksavvy.com. [24.212.246.46])
        by smtp.gmail.com with ESMTPSA id c141sm4606305ioe.13.2017.11.26.20.55.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Nov 2017 20:55:36 -0800 (PST)
From:   Liam Beguin <liambeguin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, gitster@pobox.com, avarab@gmail.com,
        Liam Beguin <liambeguin@gmail.com>
Subject: [PATCH 1/5] Documentation: move rebase.* configs to new file
Date:   Sun, 26 Nov 2017 23:55:10 -0500
Message-Id: <20171127045514.25647-2-liambeguin@gmail.com>
X-Mailer: git-send-email 2.15.0.321.g19bf2bb99cee.dirty
In-Reply-To: <20171127045514.25647-1-liambeguin@gmail.com>
References: <20171127045514.25647-1-liambeguin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move all rebase.* configuration variables to a separate file in order to
remove duplicates, and include it in config.txt and git-rebase.txt.  The
new descriptions are mostly taken from config.txt as they are more
verbose.

Signed-off-by: Liam Beguin <liambeguin@gmail.com>
---
 Documentation/config.txt        | 31 +------------------------------
 Documentation/git-rebase.txt    | 19 +------------------
 Documentation/rebase-config.txt | 32 ++++++++++++++++++++++++++++++++
 3 files changed, 34 insertions(+), 48 deletions(-)
 create mode 100644 Documentation/rebase-config.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 531649cb40ea..e424b7de90b5 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2691,36 +2691,7 @@ push.recurseSubmodules::
 	is retained. You may override this configuration at time of push by
 	specifying '--recurse-submodules=check|on-demand|no'.
 
-rebase.stat::
-	Whether to show a diffstat of what changed upstream since the last
-	rebase. False by default.
-
-rebase.autoSquash::
-	If set to true enable `--autosquash` option by default.
-
-rebase.autoStash::
-	When set to true, automatically create a temporary stash entry
-	before the operation begins, and apply it after the operation
-	ends.  This means that you can run rebase on a dirty worktree.
-	However, use with care: the final stash application after a
-	successful rebase might result in non-trivial conflicts.
-	Defaults to false.
-
-rebase.missingCommitsCheck::
-	If set to "warn", git rebase -i will print a warning if some
-	commits are removed (e.g. a line was deleted), however the
-	rebase will still proceed. If set to "error", it will print
-	the previous warning and stop the rebase, 'git rebase
-	--edit-todo' can then be used to correct the error. If set to
-	"ignore", no checking is done.
-	To drop a commit without warning or error, use the `drop`
-	command in the todo-list.
-	Defaults to "ignore".
-
-rebase.instructionFormat::
-	A format string, as specified in linkgit:git-log[1], to be used for
-	the instruction list during an interactive rebase.  The format will automatically
-	have the long commit hash prepended to the format.
+include::rebase-config.txt[]
 
 receive.advertiseAtomic::
 	By default, git-receive-pack will advertise the atomic push
diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 3cedfb0fd22b..8a861c1e0d69 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -203,24 +203,7 @@ Alternatively, you can undo the 'git rebase' with
 CONFIGURATION
 -------------
 
-rebase.stat::
-	Whether to show a diffstat of what changed upstream since the last
-	rebase. False by default.
-
-rebase.autoSquash::
-	If set to true enable `--autosquash` option by default.
-
-rebase.autoStash::
-	If set to true enable `--autostash` option by default.
-
-rebase.missingCommitsCheck::
-	If set to "warn", print warnings about removed commits in
-	interactive mode. If set to "error", print the warnings and
-	stop the rebase. If set to "ignore", no checking is
-	done. "ignore" by default.
-
-rebase.instructionFormat::
-	Custom commit list format to use during an `--interactive` rebase.
+include::rebase-config.txt[]
 
 OPTIONS
 -------
diff --git a/Documentation/rebase-config.txt b/Documentation/rebase-config.txt
new file mode 100644
index 000000000000..dba088d7c68f
--- /dev/null
+++ b/Documentation/rebase-config.txt
@@ -0,0 +1,32 @@
+rebase.stat::
+	Whether to show a diffstat of what changed upstream since the last
+	rebase. False by default.
+
+rebase.autoSquash::
+	If set to true enable `--autosquash` option by default.
+
+rebase.autoStash::
+	When set to true, automatically create a temporary stash entry
+	before the operation begins, and apply it after the operation
+	ends.  This means that you can run rebase on a dirty worktree.
+	However, use with care: the final stash application after a
+	successful rebase might result in non-trivial conflicts.
+	This option can be overridden by the `--no-autostash` and
+	`--autostash` options of linkgit:git-rebase[1].
+	Defaults to false.
+
+rebase.missingCommitsCheck::
+	If set to "warn", git rebase -i will print a warning if some
+	commits are removed (e.g. a line was deleted), however the
+	rebase will still proceed. If set to "error", it will print
+	the previous warning and stop the rebase, 'git rebase
+	--edit-todo' can then be used to correct the error. If set to
+	"ignore", no checking is done.
+	To drop a commit without warning or error, use the `drop`
+	command in the todo-list.
+	Defaults to "ignore".
+
+rebase.instructionFormat::
+	A format string, as specified in linkgit:git-log[1], to be used for the
+	instruction list during an interactive rebase.  The format will
+	automatically have the long commit hash prepended to the format.
-- 
2.15.0.321.g19bf2bb99cee.dirty

