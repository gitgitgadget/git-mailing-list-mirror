Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32DF31F403
	for <e@80x24.org>; Tue, 12 Jun 2018 17:10:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934312AbeFLRKe (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Jun 2018 13:10:34 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37212 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933076AbeFLRKc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jun 2018 13:10:32 -0400
Received: by mail-wm0-f67.google.com with SMTP id r125-v6so375241wmg.2
        for <git@vger.kernel.org>; Tue, 12 Jun 2018 10:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=rLfsPbls/sF17VqQ0raUvkhriP+7mGYKO01vyw+K8+8=;
        b=CC9BPMKqGjOutmFFr/U/YX2hT+m7zjzPjY/4TAxh3gVrk51zzxhBxcZoobtaaJaeZz
         Iy95B+50qhex+bCD84ZC/3+inLZixUFVaedeMf8LA/AlNx6q7l86uQsjkHqXSkwzN2z7
         HAKN/Wm7u4YUveAbnJfPevEYpz9YUJJd65V2hND729z2guOxv74TYeMv6vIjkfQAbX5w
         CJsMO3i4bZjVgXzFuyAo8EjIkbu2br3JcgUGzhJ5oKCkkXr/aM7s8Bug4wn295r+r88H
         xRjmL1QMP9QXSkl4nF8aigIqFY/rLTVmiLrvrOPsPMMWVS11htieaIk8quNVduWoRLDc
         SOIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=rLfsPbls/sF17VqQ0raUvkhriP+7mGYKO01vyw+K8+8=;
        b=X1vjDbqnxpgO5Ly3hlscTrjXZQsxgp/NQ/NptBj2kW+rHVRRHukDx8imGxP9/LvjLD
         PpJNP4+dhlscesHDCiriEGQRQU3f48GqoaVJcUiZoyJ46jzgVjStVWRuZFOG/HVpCh1+
         wBmz5sh2RGZeuNZjia5/4uQ1J76x9Y+q0PBWxLjMS3jGKnbBr8etQozg5U1q5x55SWTY
         V5CiapF0Vf7aRJ+DeZWHpudHoaRh7lAgoZlX7m1gqi/UEQRRrKSRqMTKbX4RkZJctQ67
         mPCv/ySJaQUjWx2v4wNBasZHCR6lZU5ScGEYtHzHrGJeY3CvhuArZyDNQqqEA5iazjr3
         6ONw==
X-Gm-Message-State: APt69E1kT8ISYnkfVxJylO7tNpl3rCfUEFPygB1hzxyzoDSHGj5auSbl
        IoyNcLvEj0Ev++75qmds5T0=
X-Google-Smtp-Source: ADUXVKLx455uGwCnIvh5tXXu6qzAV1XEHsN20vG36jaUBinEfnC9unxD42VPXmQYo0uEvAvxS2XrSw==
X-Received: by 2002:a1c:5f82:: with SMTP id t124-v6mr759804wmb.147.1528823430168;
        Tue, 12 Jun 2018 10:10:30 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id u13-v6sm835798wrr.70.2018.06.12.10.10.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Jun 2018 10:10:29 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Merland Romain <merlorom@yahoo.fr>, Luke Diamand <luke@diamand.org>
Cc:     git@vger.kernel.org, Eric Scouten <eric@scouten.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Miguel Torroja <miguel.torroja@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Lex Spoon <lex@lexspoon.org>, viniciusalexandre@gmail.com
Subject: Re: [PATCHv2 0/6] git-p4: some small fixes updated
References: <20180608203248.16311-1-luke@diamand.org>
Date:   Tue, 12 Jun 2018 10:10:28 -0700
In-Reply-To: <20180608203248.16311-1-luke@diamand.org> (Luke Diamand's message
        of "Fri, 8 Jun 2018 21:32:42 +0100")
Message-ID: <xmqqo9gg9bi3.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Luke Diamand <luke@diamand.org> writes:

> This is an updated version of the set of changes I posted recently,
> following comments on the list:
>
> disable automatic sync after git-p4 submit:
>     https://marc.info/?l=git&m=152818734814838&w=2
>
> better handling of being logged out by Perforce:
>    https://marc.info/?l=git&m=152818893815326&w=2
>
> adapt the block size automatically on git-p4 submit:
>    https://marc.info/?l=git&m=152819004315688&w=2
>
> - Spelling corrections (Eric)
> - Improved comments (Eric)
> - Exception class hierarchy fix (Merland)
> - test simplification (Eric)
>

That reminds me of one thing.  

This 6-patch series depends on the rm/p4-submit-with-commit-option
that came without and still waiting for a sign-off by the original
author.  Also I do not think the original patch reached the public
list, so I'm attaching the patch to make sure people know which
patch I am talking about.

Romain, can we get your sign-off on the patch you sent earlier?

Thanks.

-- >8 --
From: Romain Merland <merlorom@yahoo.fr>
Date: Wed, 9 May 2018 17:32:12 +0200
Subject: [PATCH] git-p4: add options --commit and --disable-rebase

On a daily work with multiple local git branches, the usual way to
submit only a specified commit was to cherry-pick the commit on
master then run git-p4 submit.  It can be very annoying to switch
between local branches and master, only to submit one commit.  The
proposed new way is to select directly the commit you want to
submit.

Add option --commit to command 'git-p4 submit' in order to submit
only specified commit(s) in p4.

On a daily work developping software with big compilation time, one
may not want to rebase on his local git tree, in order to avoid long
recompilation.

Add option --disable-rebase to command 'git-p4 submit' in order to
disable rebase after submission.

Reviewed-by: Luke Diamand <luke@diamand.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-p4.txt | 14 ++++++++++++++
 git-p4.py                | 29 +++++++++++++++++++++++------
 t/t9807-git-p4-submit.sh | 40 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 77 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
index d8c8f11c9f..88d109debb 100644
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
index 7bb9cadc69..f4a6f3b4c3 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1352,7 +1352,12 @@ def __init__(self):
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
@@ -1362,6 +1367,8 @@ def __init__(self):
         self.dry_run = False
         self.shelve = False
         self.update_shelve = list()
+        self.commit = ""
+        self.disable_rebase = False
         self.prepare_p4_only = False
         self.conflict_behavior = None
         self.isWindows = (platform.system() == "Windows")
@@ -2103,9 +2110,18 @@ def run(self, args):
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
@@ -2215,8 +2231,9 @@ def run(self, args):
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
index 71cae2874d..2325599ee6 100755
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
2.18.0-rc1-1-g6f333ff2fb

