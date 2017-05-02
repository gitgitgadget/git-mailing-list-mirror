Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C9D7207D6
	for <e@80x24.org>; Tue,  2 May 2017 04:01:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751205AbdEBEBc (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 00:01:32 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:33650 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751135AbdEBEB3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 00:01:29 -0400
Received: by mail-io0-f193.google.com with SMTP id o22so1895341iod.0
        for <git@vger.kernel.org>; Mon, 01 May 2017 21:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=a2v0QH/y89XnEZa2qJoCWBwF7PZx1AJcGb9HqBDc3ps=;
        b=IZ0Xo4mnzyDDyJNaryKPqnmKLlod5hAF6H6GFln6WGZ0BLSCbucfhBrVz4R5RdUXjy
         VkX33Bj3W9G3MJTDViPen3S0FRRqpMwqWhmItMj4+eXt5+ADXSdKVOzW0tHZfYJ3E116
         d4ipPVRqMLXTVpy+oohG1dgvXUz5jAt/I96M9lkvaq8a7mIgiFQNWjGFkDZHUzDlomVN
         zwXI+SbmAT/VnNRVneB2Xg6a9vF8lovQkNfm15hoZaOyt6e+3jzsW0KI2fmmNQL7CGxj
         mLed+k/9m30wdk+csvdKy11gzNd9va20Q7/XDx/NmfOUi5m7MAaqIDv5r0ZPiVrhTaoI
         C7/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=a2v0QH/y89XnEZa2qJoCWBwF7PZx1AJcGb9HqBDc3ps=;
        b=RLP4NuOvd/iSzNERmj244P3FuFmWtwudTJsYuaOLM8XpFJQNB8ridSy/ugFpiDnJON
         yW4f23ADiV+ViOuIUvYBqTHyRjWGR/HRXWzj9zUx7tnhlGcqycAfDoBuq2LJV+ulFbgf
         g8LA+7Tp4f+OZ623S8qtiy4yP2lyn9qYG/sGXfJRtefknBkW5koPtbz3YoUkpWjN1wi4
         W0VnPlsB3qgoaLQoDRr2qRjmhE5d5Bco6iPKk4RCVIXFWr26py58tp0b7r0RAKjEArm5
         +0EkBJu/OTGyi71St/27ilZUytzHc4BPBpnyPztWCIdvIMR5ub0iglKaHeK3abHEKrpS
         Q4hw==
X-Gm-Message-State: AN3rC/7Afpt6M2q676ZCQSyJGjSCbR0uK2VBI7VKaorl4fhA+pCL56qd
        mqDc+ZQ4wQNlNA==
X-Received: by 10.107.52.202 with SMTP id b193mr26597468ioa.150.1493697683797;
        Mon, 01 May 2017 21:01:23 -0700 (PDT)
Received: from localhost.localdomain (24-212-246-46.cable.teksavvy.com. [24.212.246.46])
        by smtp.gmail.com with ESMTPSA id p65sm7211762ioe.3.2017.05.01.21.01.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 May 2017 21:01:23 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, peff@peff.net,
        Liam Beguin <liambeguin@gmail.com>
Subject: [PATCH v3 4/6] Documentation: move rebase.* config variables to a separate rebase-config.txt
Date:   Tue,  2 May 2017 00:00:46 -0400
Message-Id: <20170502040048.9065-5-liambeguin@gmail.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170502040048.9065-1-liambeguin@gmail.com>
References: <20170502040048.9065-1-liambeguin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move configuration variables to a separate file in order to remove
duplicates, and include it in config.txt and git-rebase.txt.
The new descriptions are taken from config.txt as they are more verbose.

Signed-off-by: Liam Beguin <liambeguin@gmail.com>
---
 Documentation/config.txt        | 31 +------------------------------
 Documentation/git-rebase.txt    | 19 +------------------
 Documentation/rebase-config.txt | 30 ++++++++++++++++++++++++++++++
 3 files changed, 32 insertions(+), 48 deletions(-)
 create mode 100644 Documentation/rebase-config.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 475e874d5155..6b647c504e8f 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2583,36 +2583,7 @@ push.recurseSubmodules::
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
-	When set to true, automatically create a temporary stash
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
index 3e49d8b046ca..702a46adfa18 100644
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
index 000000000000..718721000031
--- /dev/null
+++ b/Documentation/rebase-config.txt
@@ -0,0 +1,30 @@
+rebase.stat::
+	Whether to show a diffstat of what changed upstream since the last
+	rebase. False by default.
+
+rebase.autoSquash::
+	If set to true enable `--autosquash` option by default.
+
+rebase.autoStash::
+	When set to true, automatically create a temporary stash
+	before the operation begins, and apply it after the operation
+	ends.  This means that you can run rebase on a dirty worktree.
+	However, use with care: the final stash application after a
+	successful rebase might result in non-trivial conflicts.
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
+	A format string, as specified in linkgit:git-log[1], to be used for
+	the instruction list during an interactive rebase.  The format will automatically
+	have the long commit hash prepended to the format.
-- 
2.9.3

