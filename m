Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 782891F51C
	for <e@80x24.org>; Fri,  1 Jun 2018 07:47:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751301AbeFAHrL (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Jun 2018 03:47:11 -0400
Received: from mail-wr0-f181.google.com ([209.85.128.181]:32790 "EHLO
        mail-wr0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750961AbeFAHrK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jun 2018 03:47:10 -0400
Received: by mail-wr0-f181.google.com with SMTP id k16-v6so8111766wro.0
        for <git@vger.kernel.org>; Fri, 01 Jun 2018 00:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=v2U3aYX1mmIudgj7VrCjLFmKDTJaYX971dJC0v9sjAY=;
        b=FTNoiUrKYfySKTVjWXcftaCVW04jp+Tob48zhgar+Zi5EEnyFj0xjMBnq4Ns9XA1/D
         AgXhjc9NiR/0LLMyZqvxHaBguhMwzxrjoy2oBZQHod9dLrHPrbzz5ojOi/2yZZRmolDI
         iDnZtRq9eukLPr68/5H+51gJLikEFfI0DAd71W49lm/SH++NHHCATV8V7m8hHJd/mou9
         3ZMghw/5H+8WjN9s5Y5ZCET0eBlYs3fgdTeWhLADbznC86FbCi6/pdn+p5Oi8LADOxCY
         1ZTFL06vv7NPWHfl2yCqO5VCDAQw++abqw5jPcYIWzfZeF9upM52TyJn4Nkn01GUsRop
         ZfGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=v2U3aYX1mmIudgj7VrCjLFmKDTJaYX971dJC0v9sjAY=;
        b=r/r4dojCZSyQEo0r8K8bKR4OdGKglz/RbEJ0n0bpTRoErNesFXi+5LFHyN0d01HeV6
         QBE8ip14yEpT52NbHg4rh0FFQG1H+UJD/ase+g7zg1qwZZtd6xjIsuqLP31DXMEcFMRi
         +vrvTtG9jqRdCzG7qvbPipU1j3Gjjo9di9YHLYu9mcb9ADVxQ1IZ4zsVe7xfnNiFuJPt
         yTaYwklbBgJBv7bcF+4e+lWlUJIXXDxYXNESRsayzBJcTE5FqHT03gpr7bdBhhJZG9+P
         mXMvoHeaOIT5dSO/1O/F7KIT3jcheMoJte9+gtqomWmFLGtAa/uxtv1/NoZNoFzJxTAn
         OJZQ==
X-Gm-Message-State: ALKqPwfiXmXJk5prQ38jiKNNmPqwQA0eESLb+gpWi/z9g7Fe5XwTnzz/
        5pTGZctsSgneOzreEvxt3M8=
X-Google-Smtp-Source: ADUXVKJ+tZ4YHsMG3IArbIwdpMD6gWcMkcoX+cDPGLVMgDG0hhj8y93XfaeLZA/lFL2ARvOsKhwl2A==
X-Received: by 2002:adf:acae:: with SMTP id o43-v6mr7060964wrc.132.1527839228730;
        Fri, 01 Jun 2018 00:47:08 -0700 (PDT)
Received: from ws-ncy-merland.paradigmgeo.net (2a01cb088ab9050021defbf4b392fc27.ipv6.abo.wanadoo.fr. [2a01:cb08:8ab9:500:21de:fbf4:b392:fc27])
        by smtp.gmail.com with ESMTPSA id s5-v6sm43069861wra.48.2018.06.01.00.47.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 01 Jun 2018 00:47:08 -0700 (PDT)
From:   Romain Merland <merlorom@gmail.com>
X-Google-Original-From: Romain Merland <merlorom@yahoo.fr>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Romain Merland <merlorom@yahoo.fr>, git@vger.kernel.org,
        Luke Diamand <luke@diamand.org>,
        Matthieu Moy <Matthieu.Moy@imag.fr>,
        Vinicius Kursancew <viniciusalexandre@gmail.com>,
        Jeff King <peff@peff.net>,
        Cedric Borgese <cedric.borgese@gmail.com>
Subject: [PATCH 1/1] git-p4: add options --commit and --disable-rebase
Date:   Fri,  1 Jun 2018 09:46:14 +0200
Message-Id: <20180601074614.7856-2-merlorom@yahoo.fr>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180601074614.7856-1-merlorom@yahoo.fr>
References: <20180601074614.7856-1-merlorom@yahoo.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On a daily work with multiple local git branches, the usual way to submit only a
specified commit was to cherry-pick the commit on master then run git-p4 submit.
It can be very annoying to switch between local branches and master, only to
submit one commit.
The proposed new way is to select directly the commit you want to submit.

add option --commit to command 'git-p4 submit' in order to submit only specified commit(s) in p4.

On a daily work developping software with big compilation time, one may not want
to rebase on his local git tree, in order to avoid long recompilation.

add option --disable-rebase to command 'git-p4 submit' in order to disable rebase after submission.

Thanks-to: Cedric Borgese <cedric.borgese@gmail.com>
Reviewed-by: Luke Diamand <luke@diamand.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Romain Merland <merlorom@yahoo.fr>
---
 Documentation/git-p4.txt | 14 ++++++++++++++
 git-p4.py                | 29 +++++++++++++++++++++++------
 t/t9807-git-p4-submit.sh | 40 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 77 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
index d8c8f11c9..88d109deb 100644
--- a/Documentation/git-p4.txt
+++ b/Documentation/git-p4.txt
@@ -149,6 +149,12 @@ To specify a branch other than the current one, use:
 $ git p4 submit topicbranch
 ------------
 
+To specify a single commit or a range of commits, use:
+------------
+$ git p4 submit --commit <sha1>
+$ git p4 submit --commit <sha1..sha1>
+------------
+
 The upstream reference is generally 'refs/remotes/p4/master', but can
 be overridden using the `--origin=` command-line option.
 
@@ -330,6 +336,14 @@ These options can be used to modify 'git p4 submit' behavior.
 	p4/master.  See the "Sync options" section above for more
 	information.
 
+--commit <sha1>|<sha1..sha1>::
+    Submit only the specified commit or range of commits, instead of the full
+    list of changes that are in the current Git branch.
+
+--disable-rebase::
+    Disable the automatic rebase after all commits have been successfully
+    submitted.
+
 Rebase options
 ~~~~~~~~~~~~~~
 These options can be used to modify 'git p4 rebase' behavior.
diff --git a/git-p4.py b/git-p4.py
index 7bb9cadc6..f4a6f3b4c 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1352,7 +1352,12 @@ class P4Submit(Command, P4UserMap):
                 optparse.make_option("--update-shelve", dest="update_shelve", action="append", type="int",
                                      metavar="CHANGELIST",
                                      help="update an existing shelved changelist, implies --shelve, "
-                                           "repeat in-order for multiple shelved changelists")
+                                           "repeat in-order for multiple shelved changelists"),
+                optparse.make_option("--commit", dest="commit", metavar="COMMIT",
+                                     help="submit only the specified commit(s), one commit or xxx..xxx"),
+                optparse.make_option("--disable-rebase", dest="disable_rebase", action="store_true",
+                                     help="Disable rebase after submit is completed. Can be useful if you "
+                                     "work from a local git branch that is not master")
         ]
         self.description = "Submit changes from git to the perforce depot."
         self.usage += " [name of git branch to submit into perforce depot]"
@@ -1362,6 +1367,8 @@ class P4Submit(Command, P4UserMap):
         self.dry_run = False
         self.shelve = False
         self.update_shelve = list()
+        self.commit = ""
+        self.disable_rebase = False
         self.prepare_p4_only = False
         self.conflict_behavior = None
         self.isWindows = (platform.system() == "Windows")
@@ -2103,9 +2110,18 @@ class P4Submit(Command, P4UserMap):
         else:
             commitish = 'HEAD'
 
-        for line in read_pipe_lines(["git", "rev-list", "--no-merges", "%s..%s" % (self.origin, commitish)]):
-            commits.append(line.strip())
-        commits.reverse()
+        if self.commit != "":
+            if self.commit.find("..") != -1:
+                limits_ish = self.commit.split("..")
+                for line in read_pipe_lines(["git", "rev-list", "--no-merges", "%s..%s" % (limits_ish[0], limits_ish[1])]):
+                    commits.append(line.strip())
+                commits.reverse()
+            else:
+                commits.append(self.commit)
+        else:
+            for line in read_pipe_lines(["git", "rev-list", "--no-merges", "%s..%s" % (self.origin, commitish)]):
+                commits.append(line.strip())
+            commits.reverse()
 
         if self.preserveUser or gitConfigBool("git-p4.skipUserNameCheck"):
             self.checkAuthorship = False
@@ -2215,8 +2231,9 @@ class P4Submit(Command, P4UserMap):
                 sync.branch = self.branch
             sync.run([])
 
-            rebase = P4Rebase()
-            rebase.rebase()
+            if self.disable_rebase is False:
+                rebase = P4Rebase()
+                rebase.rebase()
 
         else:
             if len(applied) == 0:
diff --git a/t/t9807-git-p4-submit.sh b/t/t9807-git-p4-submit.sh
index 71cae2874..2325599ee 100755
--- a/t/t9807-git-p4-submit.sh
+++ b/t/t9807-git-p4-submit.sh
@@ -155,6 +155,46 @@ test_expect_success 'allow submit from branch with same revision but different n
 	)
 '
 
+# make two commits, but tell it to apply only one
+
+test_expect_success 'submit --commit one' '
+	test_when_finished cleanup_git &&
+	git p4 clone --dest="$git" //depot &&
+	(
+		cd "$git" &&
+		test_commit "file9" &&
+		test_commit "file10" &&
+		git config git-p4.skipSubmitEdit true &&
+		git p4 submit --commit HEAD
+	) &&
+	(
+		cd "$cli" &&
+		test_path_is_missing "file9.t" &&
+		test_path_is_file "file10.t"
+	)
+'
+
+# make three commits, but tell it to apply only range
+
+test_expect_success 'submit --commit range' '
+	test_when_finished cleanup_git &&
+	git p4 clone --dest="$git" //depot &&
+	(
+		cd "$git" &&
+		test_commit "file11" &&
+		test_commit "file12" &&
+		test_commit "file13" &&
+		git config git-p4.skipSubmitEdit true &&
+		git p4 submit --commit HEAD~2..HEAD
+	) &&
+	(
+		cd "$cli" &&
+		test_path_is_missing "file11.t" &&
+		test_path_is_file "file12.t" &&
+		test_path_is_file "file13.t"
+	)
+'
+
 #
 # Basic submit tests, the five handled cases
 #
-- 
2.17.0

