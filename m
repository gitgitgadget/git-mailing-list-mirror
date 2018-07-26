Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 412B51F597
	for <e@80x24.org>; Thu, 26 Jul 2018 13:41:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731490AbeGZO6u (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jul 2018 10:58:50 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33669 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730030AbeGZO6t (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jul 2018 10:58:49 -0400
Received: by mail-pg1-f195.google.com with SMTP id r5-v6so1207884pgv.0
        for <git@vger.kernel.org>; Thu, 26 Jul 2018 06:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RJ1C9nz9El2rb58Zh4QFeK+xNChnmKgEEoUhcJtP1dk=;
        b=coF5+6elpQrP9QABnh+46wQ3YZIAnYNh5WqWcr0b2mSRq86J9LNX1rO8pqC+fTN6p3
         f1ntd6ajPYgQzycqg0Eo4iZkUoQmJ9KeLl19RnbUzbq15K7rx+XNoA5E5cFT8qBzKWd8
         h9s+mUA/hQK3fMl5Qhrh0KSS2pznic5OmG6oy9Sxj0rZSSX5moQpLlDM50o5zrsjZQZn
         epOZ9ES8PnDdC+1G+2IwRNS2eZfWaJyKAB1st1/h2529iuFo3wnldsSXZC4AyzkLfuiu
         RSZzX2CwaS3ywl5ASZk7Wm/q8ifxM/WiMdrSHIx+3Q7jzFBPv2iGIQVAJM/jNHBLmcUR
         AeSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RJ1C9nz9El2rb58Zh4QFeK+xNChnmKgEEoUhcJtP1dk=;
        b=OABLhlKZlmphDwxyhZS+IRqM++T0Y/pgG09J1fHJxE/HQVqqUJ4Y1kwGCqEt24RtLH
         cWAKvOlrW1onPGTXHb/UUxTZkuWGh5e+9aRG4TkGIxUyEZTucsiXQyGFGy0wPD6ZJhmq
         jZG0C1Rjevy1txeWITqqX+HztGTO6v62qiamIKD01GjUS4rsJIQaA85TJQZs5TF5KvJb
         PYE8OwWe592/1fyKnh7xg0ZaSONeJz7Ct83J9u8Lw3GSiYpAbK1u3KJ//GIqrEZNiQY4
         s/IVUqKSsyBhXrwBq4YzPyvPU1a2O+MqPpjPMC4iHrdDaXd8bCWOmL62detE9ZJ9PUMM
         TiVQ==
X-Gm-Message-State: AOUpUlHmhYqJ1GmnZp79Dpc0wXiFtYR2Qax5ZJjNSqTCawGUcxLUtxF7
        375sAIEx/1/HhXgQ+eRjZLoe6oHr
X-Google-Smtp-Source: AAOMgpdg2zrFXDGo8dgarHvJ1wcApzsRjerFzEwmpGmDB7Oe8m1rkSCNCdblZjAdR2I/NTte1fsHTA==
X-Received: by 2002:a62:3a5b:: with SMTP id h88-v6mr2188556pfa.61.1532612512649;
        Thu, 26 Jul 2018 06:41:52 -0700 (PDT)
Received: from localhost.localdomain ([110.175.42.185])
        by smtp.gmail.com with ESMTPSA id n18-v6sm4191592pfa.50.2018.07.26.06.41.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 06:41:51 -0700 (PDT)
From:   Chen Bin <chenbin.sh@gmail.com>
To:     git@vger.kernel.org
Cc:     Chen Bin <chenbin.sh@gmail.com>
Subject: [PATCH 1/1] add hook pre-p4-submit
Date:   Thu, 26 Jul 2018 23:41:38 +1000
Message-Id: <20180726134138.12183-1-chenbin.sh@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180725134345.8631-1-chenbin.sh@gmail.com>
References: <20180725134345.8631-1-chenbin.sh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hook pre-p4-submit is executed before git-p4 actually submits code.
If the hook exits with non-zero value, submit process will abort.

Signed-off-by: Chen Bin <chenbin.sh@gmail.com>
---
 Documentation/git-p4.txt   | 12 ++++++++++++
 Documentation/githooks.txt |  7 +++++++
 git-p4.py                  | 21 ++++++++++++++++++++-
 t/t9800-git-p4-basic.sh    | 26 ++++++++++++++++++++++++++
 4 files changed, 65 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
index f0de3b891..f5d428ddf 100644
--- a/Documentation/git-p4.txt
+++ b/Documentation/git-p4.txt
@@ -374,6 +374,18 @@ These options can be used to modify 'git p4 submit' behavior.
     been submitted. Implies --disable-rebase. Can also be set with
     git-p4.disableP4Sync. Sync with origin/master still goes ahead if possible.
 
+Hook for submit
+~~~~~~~~~~~~~~~
+Hook `p4-pre-submit` is executed if it exists and is executable.
+The hook takes no parameter and nothing from standard input. Exiting with
+non-zero status from this script prevents `git-p4 submit` from launching.
+So nothing is touched when it exits with non-zero status.
+
+One usage scenario is to run unit tests in the hook.
+
+By default the hooks directory is `$GIT_DIR/hooks`, but that can be changed.
+See githooks(5) manpage for details about hooks.
+
 Rebase options
 ~~~~~~~~~~~~~~
 These options can be used to modify 'git p4 rebase' behavior.
diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index e3c283a17..22fcabbe2 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -485,6 +485,13 @@ The exit status determines whether git will use the data from the
 hook to limit its search.  On error, it will fall back to verifying
 all files and folders.
 
+p4-pre-submit
+~~~~~~~~~~~~~
+
+This hook is invoked by `git-p4 submit`. It takes no parameter and nothing
+from standard input. Exiting with non-zero status from this script prevent
+`git-p4 submit` from launching. Run `git-p4 submit --help` for details.
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/git-p4.py b/git-p4.py
index b449db1cc..f147a2d2f 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1494,7 +1494,17 @@ def __init__(self):
                 optparse.make_option("--disable-p4sync", dest="disable_p4sync", action="store_true",
                                      help="Skip Perforce sync of p4/master after submit or shelve"),
         ]
-        self.description = "Submit changes from git to the perforce depot."
+        self.description = """Submit changes from git to the perforce depot.\n
+    Hook `p4-pre-submit` is executed if it exists and is executable.
+    The hook takes no parameter and nothing from standard input. Exiting with
+    non-zero status from this script prevents `git-p4 submit` from launching.
+    So nothing is touched when it exits with non-zero status.
+
+    One usage scenario is to run unit tests in the hook.
+
+    By default the hooks directory is `$GIT_DIR/hooks`, but that can be changed.
+    See githooks(5) manpage for details about hooks."""
+
         self.usage += " [name of git branch to submit into perforce depot]"
         self.origin = ""
         self.detectRenames = False
@@ -2303,6 +2313,15 @@ def run(self, args):
             sys.exit("number of commits (%d) must match number of shelved changelist (%d)" %
                      (len(commits), num_shelves))
 
+        hooks_path = gitConfig("core.hooksPath")
+        if len(hooks_path) > 0:
+            hook_file = os.path.join(hooks_path, "p4-pre-submit")
+        else:
+            hook_file = os.path.join(read_pipe("git rev-parse --git-dir").strip(), "hooks", "p4-pre-submit")
+
+        if os.path.isfile(hook_file) and os.access(hook_file, os.X_OK) and subprocess.call([hook_file]) != 0:
+            sys.exit(1)
+
         #
         # Apply the commits, one at a time.  On failure, ask if should
         # continue to try the rest of the patches, or quit.
diff --git a/t/t9800-git-p4-basic.sh b/t/t9800-git-p4-basic.sh
index 4849edc4e..8457ff617 100755
--- a/t/t9800-git-p4-basic.sh
+++ b/t/t9800-git-p4-basic.sh
@@ -261,6 +261,32 @@ test_expect_success 'unresolvable host in P4PORT should display error' '
 	)
 '
 
+# Test following scenarios:
+#   - Without hook ".git/hooks/p4-pre-submit", submit should continue
+#   - With hook returning 0, submit should continue
+#   - With hook returning 1, submit should abort
+test_expect_success 'run hook p4-pre-submit before submit' '
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
+		write_script .git/hooks/p4-pre-submit <<-\EOF &&
+		exit 0
+		EOF
+		git p4 submit --dry-run >out &&  grep "Would apply" out &&
+		write_script .git/hooks/p4-pre-submit <<-\EOF &&
+		exit 1
+		EOF
+		git p4 submit --dry-run >out && grep "Would apply" out || echo "Abort submit"
+	)
+'
+
 test_expect_success 'submit from detached head' '
 	test_when_finished cleanup_git &&
 	git p4 clone --dest="$git" //depot &&
-- 
2.18.0

