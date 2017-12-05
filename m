Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC38320A40
	for <e@80x24.org>; Tue,  5 Dec 2017 17:52:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752664AbdLERwx (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Dec 2017 12:52:53 -0500
Received: from mail-it0-f67.google.com ([209.85.214.67]:41031 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752212AbdLERwu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Dec 2017 12:52:50 -0500
Received: by mail-it0-f67.google.com with SMTP id x28so3623384ita.0
        for <git@vger.kernel.org>; Tue, 05 Dec 2017 09:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VKtnIruKruQrztPoqnbsMoV0QivC5hcKr5/egM47FI4=;
        b=Q/9eTXFbDHOMOs58SUXJxYUoJO2cHvegGN8BPA4hq70+Qb5i26caZ4xpCDrA+4yfnp
         yIRwq8T4cyv+gNg8W9cFEokmcsVKo+xZRj21W9RYktwB+DE1woigsyTr0FraTOjhCDid
         1kakX6I5ajC6XoNqwjUBTkfsa0cNURD8sIFV8sGK9avXacMjaHeAHDjGX8dyfhVkP19x
         sPbQL1mS9WMt//kBvDxAyOOzyu4RHr9xeZlluMkGKEtkhrLWE41CHlwdYkbaIf6j2EbQ
         1rMphMnskZRq5AODmYRl1HTiMoaX9dWR7D8IFVfRjWZzjXMvdKgbR6cDF6Ya29FQ0UqN
         EwQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VKtnIruKruQrztPoqnbsMoV0QivC5hcKr5/egM47FI4=;
        b=SiAdXxGJtyPfmsfy7xByz/ZLdfwoFJx/H43TrdqHliP9KaIFuEFtGeWiGjjrEQSIVW
         dUbzF7kee6hOmTxqIAL9Codbn6dQpU8qAgzHrZZXAz78+KQNeZEH8a/a/uhq2o+WIzoK
         SLyM+exvyLNzRQ1wxK+wVLmHsDLENg0Vud9zVobNy5q0twiei4uN+o1r8oXYlrIzRecg
         qT5Mtyho7plROJAGYqJY9CLjYJ3fWs25G1S+xdfOXbkde+2hqrORgTV824JKyXm26WKe
         UHaGN7MJhBBdhdXOpTwRCGb4iCEwEKhKxMoqBFJQcd1IASmrRQnN4uaj5JkZKHOttcVg
         /kNw==
X-Gm-Message-State: AJaThX5oMxJIiv0DjKWwwpceOAMY7MoI9M6AewlDjWpiT5lmA5QeWQCx
        HhuwTOm8V6MpnNwHpKGFCWGxAGarJ08=
X-Google-Smtp-Source: AGs4zMahgk4nmglAz4m1YSUhG5bJFEPfzoz+5haTIY0O6aBw89Rskx8oX9hxnfJpojgA5GP2xgx35A==
X-Received: by 10.107.9.218 with SMTP id 87mr31838212ioj.188.1512496369800;
        Tue, 05 Dec 2017 09:52:49 -0800 (PST)
Received: from localhost.localdomain (24-212-246-46.cable.teksavvy.com. [24.212.246.46])
        by smtp.gmail.com with ESMTPSA id i195sm264737ioi.44.2017.12.05.09.52.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Dec 2017 09:52:49 -0800 (PST)
From:   Liam Beguin <liambeguin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, gitster@pobox.com, peff@peff.net,
        Liam Beguin <liambeguin@gmail.com>
Subject: [PATCH v3 1/9] Documentation: move rebase.* configs to new file
Date:   Tue,  5 Dec 2017 12:52:27 -0500
Message-Id: <20171205175235.32319-2-liambeguin@gmail.com>
X-Mailer: git-send-email 2.15.1.280.gbdce6e0789cb
In-Reply-To: <20171205175235.32319-1-liambeguin@gmail.com>
References: <20171127045514.25647-1-liambeguin@gmail.com>
 <20171205175235.32319-1-liambeguin@gmail.com>
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
2.15.1.280.g10402c1f5b5c

