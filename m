Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E8101F597
	for <e@80x24.org>; Wed, 25 Jul 2018 13:45:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729256AbeGYO4x (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jul 2018 10:56:53 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:34269 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729088AbeGYO4x (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jul 2018 10:56:53 -0400
Received: by mail-pl0-f67.google.com with SMTP id f6-v6so3332964plo.1
        for <git@vger.kernel.org>; Wed, 25 Jul 2018 06:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=j/+kMaKpiXItyk+UPTQaydam/dWNnFZL5Koc/qjOlGE=;
        b=D/3wDVM1WiCtXHureG0Z5IuPOTgLGYLijb5FTd3dzIte4hPl2jFVQDsFMdFsLEgTee
         UYCZYO1PkCWXkt1ur/PDtnKpcF/pdlpsApwXCNK/TAMgoMG1q3xI2Uzu24cAqn7RzFed
         OOBij92AxEOQCjOjkiPJko9SLv7W0TjIPiuuwg0i9CwcrgOHKCIOJvuqonNIaeezj5Ks
         D3qEQztEP442IAuVMlrnUZp2guw85Im3/P4FCriho70FlPCbpTjAee2UbpBD/bC4l6Q8
         d1PRKH06z3eNL58caOeCeNjWacEyv2/mqBCiYqWPqRBSBhRmIziibnimXY0nlz4DrLyq
         0VNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=j/+kMaKpiXItyk+UPTQaydam/dWNnFZL5Koc/qjOlGE=;
        b=gzmrO6m41vtS9fk1Y8rvEABYKiBBK0x9dg0XqUy7fQK9oYKub2dx9y3/HMqpNOz6x2
         8d+GIdUxc75e4OXmWP2qwbxY1719g1hNqegcGzSt4DyGKcJpQvJN40sJoWRf+opZyh03
         7zVOY+dCqtAAVu/5nYa2Xx3deIkefcDamzjsRvBjPh25uwWS1BsViHCG0mG29GJmLjke
         nIhnqXjCH5Rfe+5lLhgQme6c5dtKnOZ9CS10RK5vDxw2TS1s5x8l9oc9q2JtWzH5C6gv
         bTcqtmHDp1XEo1Hd1bcPyx9RVbejy3dwITurTwpywJDlOoYSr4pPpaA+SG2Hu+GRz7iz
         O2LA==
X-Gm-Message-State: AOUpUlFYgdlMTbwGgtf1ICuhX/sADQtrfkIzzFI7Lm7lAjSrIAG1ODwM
        nVy+UAXlkHBSyfH6mF3PBT9zXRmV
X-Google-Smtp-Source: AAOMgpeXaAIhCpDuv2XQkrlhCGexfjX2JuNTL1iZlCe1Sxazef8jrN/R7bCDToDodlEUz0lqssRK4w==
X-Received: by 2002:a17:902:2908:: with SMTP id g8-v6mr21164380plb.180.1532526307640;
        Wed, 25 Jul 2018 06:45:07 -0700 (PDT)
Received: from localhost.localdomain ([110.175.42.185])
        by smtp.gmail.com with ESMTPSA id y27-v6sm34690226pff.181.2018.07.25.06.45.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Jul 2018 06:45:06 -0700 (PDT)
From:   Chen Bin <chenbin.sh@gmail.com>
To:     git@vger.kernel.org
Cc:     Chen Bin <chenbin.sh@gmail.com>
Subject: [PATCH 1/1] add hook pre-p4-submit
Date:   Wed, 25 Jul 2018 23:43:45 +1000
Message-Id: <20180725134345.8631-1-chenbin.sh@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <CAE5ih79ndEbnEeV_muQyZwG+01_8Kg0J74rZtOoK1_V40E0z7g@mail.gmail.com>
References: <CAE5ih79ndEbnEeV_muQyZwG+01_8Kg0J74rZtOoK1_V40E0z7g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hook pre-p4-submit is executed before git-p4 actually submits code.
If the hook exits with non-zero value, submit process will abort.

Signed-off-by: Chen Bin <chenbin.sh@gmail.com>
---
 Documentation/git-p4.txt   |  7 +++++++
 Documentation/githooks.txt |  7 +++++++
 git-p4.py                  | 18 +++++++++++++++++-
 t/t9800-git-p4-basic.sh    | 22 ++++++++++++++++++++++
 4 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
index f0de3b891..73f7a2691 100644
--- a/Documentation/git-p4.txt
+++ b/Documentation/git-p4.txt
@@ -374,6 +374,13 @@ These options can be used to modify 'git p4 submit' behavior.
     been submitted. Implies --disable-rebase. Can also be set with
     git-p4.disableP4Sync. Sync with origin/master still goes ahead if possible.
 
+Hook for submit
+~~~~~~~~~~~~~~~
+Hook `pre-p4-submit` is executed if it exists and is executable.
+Exiting with non-zero status from this script cause `git-p4 submit` to abort.
+By default the hooks directory is `$GIT_DIR/hooks`, but that can be changed.
+See githooks(5) manpage for details about hooks.
+
 Rebase options
 ~~~~~~~~~~~~~~
 These options can be used to modify 'git p4 rebase' behavior.
diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index e3c283a17..5148627b4 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -485,6 +485,13 @@ The exit status determines whether git will use the data from the
 hook to limit its search.  On error, it will fall back to verifying
 all files and folders.
 
+pre-p4-submit
+~~~~~~~~~~~~~
+
+This hook is invoked by `git-p4 submit`. It takes no parameter, and
+exiting with non-zero status from this script causes `git-p4 submit`
+to abort. Run `git-p4 submit --help` for details.
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/git-p4.py b/git-p4.py
index b449db1cc..bbb0d987e 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1494,7 +1494,12 @@ def __init__(self):
                 optparse.make_option("--disable-p4sync", dest="disable_p4sync", action="store_true",
                                      help="Skip Perforce sync of p4/master after submit or shelve"),
         ]
-        self.description = "Submit changes from git to the perforce depot."
+        self.description = """Submit changes from git to the perforce depot.\n
+    Hook `pre-p4-submit` is executed if it exists and is executable.
+    Exiting with non-zero status from this script cause `git-p4 submit` to abort.
+    By default the hooks directory is `$GIT_DIR/hooks`, but that can be changed.
+    See githooks(5) manpage for details about hooks."""
+
         self.usage += " [name of git branch to submit into perforce depot]"
         self.origin = ""
         self.detectRenames = False
@@ -2303,6 +2308,17 @@ def run(self, args):
             sys.exit("number of commits (%d) must match number of shelved changelist (%d)" %
                      (len(commits), num_shelves))
 
+        # locate hook
+        hooks_path = gitConfig("core.hooksPath")
+        if len(hooks_path) > 0:
+            hook_file = os.path.join(hooks_path, "pre-p4-submit")
+        else:
+            hook_file = os.path.join(read_pipe("git rev-parse --git-dir").strip(), "hooks", "pre-p4-submit")
+
+        # Execute hook. If it exits with non-zero value, do NOT continue.
+        if os.path.isfile(hook_file) and os.access(hook_file, os.X_OK) and subprocess.call([hook_file]) != 0:
+            sys.exit(1)
+
         #
         # Apply the commits, one at a time.  On failure, ask if should
         # continue to try the rest of the patches, or quit.
diff --git a/t/t9800-git-p4-basic.sh b/t/t9800-git-p4-basic.sh
index 4849edc4e..48b768fa7 100755
--- a/t/t9800-git-p4-basic.sh
+++ b/t/t9800-git-p4-basic.sh
@@ -261,6 +261,28 @@ test_expect_success 'unresolvable host in P4PORT should display error' '
 	)
 '
 
+# Test following scenarios:
+#   - Without hook ".git/hooks/pre-p4-submit", submit should continue
+#   - With hook returning 0, submit should continue
+#   - With hook returning 1, submit should abort
+test_expect_success 'run hook pre-p4-submit before submit' '
+	test_when_finished cleanup_git &&
+	git p4 clone --dest="$git" //depot &&
+	(
+		cd "$git" &&
+		echo "hello world" >hello.txt &&
+		git add hello.txt &&
+		git commit -m "add hello.txt" &&
+		git config git-p4.skipSubmitEdit true &&
+		git p4 submit --dry-run | grep "Would apply" &&
+		mkdir -p .git/hooks &&
+		: >.git/hooks/pre-p4-submit && chmod +x .git/hooks/pre-p4-submit &&
+		git p4 submit --dry-run | grep "Would apply" &&
+		echo #!/bin/sh && echo exit 1 >.git/hooks/pre-p4-submit &&
+		git p4 submit --dry-run | grep "Would apply" || echo "Abort submit"
+	)
+'
+
 test_expect_success 'submit from detached head' '
 	test_when_finished cleanup_git &&
 	git p4 clone --dest="$git" //depot &&
-- 
2.18.0

