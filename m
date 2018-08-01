Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 273BD1F597
	for <e@80x24.org>; Wed,  1 Aug 2018 15:54:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389798AbeHARlJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Aug 2018 13:41:09 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34069 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389658AbeHARlJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Aug 2018 13:41:09 -0400
Received: by mail-pf1-f196.google.com with SMTP id k19-v6so8070272pfi.1
        for <git@vger.kernel.org>; Wed, 01 Aug 2018 08:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Xhfb6R8l8mdmBNE5/Gml2UF29bNcS/Q0yqsPKnHE0EE=;
        b=dSG9uD9K2GI+HNXfeGcM1LtEPaLfyqEOfqCTofOj4mVZwYNGUbbFdy8/N7b75LADLE
         X6ivL1QCMxMoE+LQxb9bas4e+GRlCWNAc9Z9bGnLfEQdXxSn54H6nMTCPKWaOkZJsNjG
         UnC+Kz2aFl4wSnoo+TysNf3Mqx+PRVzVKxbdrRCpyQ0BEXs8qYiB12kNxIeA3uApS5Yf
         xKpkZ9E8s27dCWKrdmPSzGiRlotnxtx/Jcs7Uy8MgZJp8ULsjsRNK3MYayJDoU8x2cpx
         ugD+NCfDK+lDR2QaWBc/eW889gGXi3Szr/0OA317fim267N2EWoR87TI3hpwy0iTkAN9
         QhJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Xhfb6R8l8mdmBNE5/Gml2UF29bNcS/Q0yqsPKnHE0EE=;
        b=YCYU41YtKQQbuhPKOleSGJa3AG4bghykRHZWxtflkE76NzgFAO0lzEKoyXugM7Kzj/
         e54PmlIB2nNv1xrVoLYzTNo0GzUAzhjuc83IQHntLdvUrjOFn96ATkICdzjGji9sz0m6
         xvv2PPHCY/cBXDAmxNR3upNa5ANFltOx3PKkPoZSXowEQi86Re4OjjgmZ5iifxJxXmBu
         68xv1qjeRmnOT2iHH3gzjstl3nnNy8sz0znAAIiZSPmJaVUfBFfNrnCLiF1GjSS6Srtp
         AAt/CDJiONh/ICdroayH+inNeKkuErmEjuNkEyQyuooNd/kb6nw00WJMHolQr8bdoi6S
         j22g==
X-Gm-Message-State: AOUpUlET0ysbkSi72rB18TFhLSWyAVYo1NexyBe9tkXqxQER4CP5/QHU
        fP0+NoJX5HXoPx2lpSxLa8qpy+CY
X-Google-Smtp-Source: AAOMgpe3qdq9TfZIRQ6vl6yTn5/vFJr56E3RB1GqWCayMZiFeqUdgFgttlft64FAAxzO4bisWC6BrA==
X-Received: by 2002:a62:3f99:: with SMTP id z25-v6mr27482102pfj.250.1533138886867;
        Wed, 01 Aug 2018 08:54:46 -0700 (PDT)
Received: from localhost.localdomain ([110.175.42.185])
        by smtp.gmail.com with ESMTPSA id 16-v6sm25833104pfp.6.2018.08.01.08.54.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Aug 2018 08:54:45 -0700 (PDT)
From:   Chen Bin <chenbin.sh@gmail.com>
To:     git@vger.kernel.org
Cc:     Chen Bin <chenbin.sh@gmail.com>
Subject: [PATCH 1/1] Add the `p4-pre-submit` hook
Date:   Thu,  2 Aug 2018 01:54:32 +1000
Message-Id: <20180801155432.4041-1-chenbin.sh@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <xmqqmuu686mp.fsf@gitster-ct.c.googlers.com>
References: <xmqqmuu686mp.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The `p4-pre-submit` hook is executed before git-p4 submits code.
If the hook exits with non-zero value, submit process won't start.

Signed-off-by: Chen Bin <chenbin.sh@gmail.com>
---
 Documentation/git-p4.txt   |  8 ++++++++
 Documentation/githooks.txt |  7 +++++++
 git-p4.py                  | 16 +++++++++++++++-
 t/t9800-git-p4-basic.sh    | 29 +++++++++++++++++++++++++++++
 4 files changed, 59 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
index f0de3b891..a7aac1b92 100644
--- a/Documentation/git-p4.txt
+++ b/Documentation/git-p4.txt
@@ -374,6 +374,14 @@ These options can be used to modify 'git p4 submit' behavior.
     been submitted. Implies --disable-rebase. Can also be set with
     git-p4.disableP4Sync. Sync with origin/master still goes ahead if possible.
 
+Hook for submit
+~~~~~~~~~~~~~~~
+The `p4-pre-submit` hook is executed if it exists and is executable.
+The hook takes no parameter and nothing from standard input. Exiting with
+non-zero status from this script prevents `git-p4 submit` from launching.
+
+One usage scenario is to run unit tests in the hook.
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
index b449db1cc..879abfd2b 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1494,7 +1494,13 @@ def __init__(self):
                 optparse.make_option("--disable-p4sync", dest="disable_p4sync", action="store_true",
                                      help="Skip Perforce sync of p4/master after submit or shelve"),
         ]
-        self.description = "Submit changes from git to the perforce depot."
+        self.description = """Submit changes from git to the perforce depot.\n
+    The `p4-pre-submit` hook is executed if it exists and is executable.
+    The hook takes no parameter and nothing from standard input. Exiting with
+    non-zero status from this script prevents `git-p4 submit` from launching.
+
+    One usage scenario is to run unit tests in the hook."""
+
         self.usage += " [name of git branch to submit into perforce depot]"
         self.origin = ""
         self.detectRenames = False
@@ -2303,6 +2309,14 @@ def run(self, args):
             sys.exit("number of commits (%d) must match number of shelved changelist (%d)" %
                      (len(commits), num_shelves))
 
+        hooks_path = gitConfig("core.hooksPath")
+        if len(hooks_path) <= 0:
+            hooks_path = os.path.join(os.environ.get("GIT_DIR", ".git"), "hooks")
+
+        hook_file = os.path.join(hooks_path, "p4-pre-submit")
+        if os.path.isfile(hook_file) and os.access(hook_file, os.X_OK) and subprocess.call([hook_file]) != 0:
+            sys.exit(1)
+
         #
         # Apply the commits, one at a time.  On failure, ask if should
         # continue to try the rest of the patches, or quit.
diff --git a/t/t9800-git-p4-basic.sh b/t/t9800-git-p4-basic.sh
index 4849edc4e..729cd2577 100755
--- a/t/t9800-git-p4-basic.sh
+++ b/t/t9800-git-p4-basic.sh
@@ -261,6 +261,35 @@ test_expect_success 'unresolvable host in P4PORT should display error' '
 	)
 '
 
+# Test following scenarios:
+#   - Without ".git/hooks/p4-pre-submit" , submit should continue
+#   - With the hook returning 0, submit should continue
+#   - With the hook returning 1, submit should abort
+test_expect_success 'run hook p4-pre-submit before submit' '
+	test_when_finished cleanup_git &&
+	git p4 clone --dest="$git" //depot &&
+	(
+		cd "$git" &&
+		echo "hello world" >hello.txt &&
+		git add hello.txt &&
+		git commit -m "add hello.txt" &&
+		git config git-p4.skipSubmitEdit true &&
+		git p4 submit --dry-run >out &&
+		grep "Would apply" out &&
+		mkdir -p .git/hooks &&
+		write_script .git/hooks/p4-pre-submit <<-\EOF &&
+		exit 0
+		EOF
+		git p4 submit --dry-run >out &&
+		grep "Would apply" out &&
+		write_script .git/hooks/p4-pre-submit <<-\EOF &&
+		exit 1
+		EOF
+		test_must_fail git p4 submit --dry-run >errs 2>&1 &&
+		! grep "Would apply" errs
+	)
+'
+
 test_expect_success 'submit from detached head' '
 	test_when_finished cleanup_git &&
 	git p4 clone --dest="$git" //depot &&
-- 
2.18.0

