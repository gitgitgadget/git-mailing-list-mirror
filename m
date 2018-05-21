Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9AC081F42D
	for <e@80x24.org>; Mon, 21 May 2018 07:01:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750911AbeEUHBM (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 May 2018 03:01:12 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34274 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750773AbeEUHBL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 May 2018 03:01:11 -0400
Received: by mail-wm0-f67.google.com with SMTP id a137-v6so10851355wme.1
        for <git@vger.kernel.org>; Mon, 21 May 2018 00:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=PdyEbPs9NFnwmI7MNZnXtMCZvJ72gGNwJFSi3zaQGN0=;
        b=OSu/eYn9v0BmFSjcH8OSZicRO7hK9K8byUHsipb3GVyLKELUeGdGQgz4kj5dyGQijU
         L+EFFBxkVO+IarJMrljC159V+GP/4R3I1nwqsows6buNNgmD4Hdj+Lz3SsumwNCg5GVA
         gVycFY3EMzQJlzaC8KXPr7Iry3TM4tOAL8S5LGkOH7ZZhL0jGM6MaRgBEy9n2IjHvPPd
         aF5I9ZzCr1fTlCPDFPvrVF/TvIip9YHWHSi9nT78US9s/V5pIxL2WdNEpupQ/30hSdGa
         GvJkDMIRNhPUye7dkIKFPI1c4DquPmfGyDlza29GTS4/QPeMJn1J7CYp17mxd2djvWj8
         B8rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=PdyEbPs9NFnwmI7MNZnXtMCZvJ72gGNwJFSi3zaQGN0=;
        b=VH/aeV/2eFqST/OacpCSuQD6j1LBCkfSmRYgNtXwYoMMWyM5QDpuiZY+SdtxG6EWO9
         xi7RCZNEZcOwvUItoDoJgYT2LxzFCSiTsRdulnpE3Y+CAunMgr3dAQwQv8epinmufnVk
         1I9rwBGDilMJi7PA7xKoqu8F6apPP2+EbllLFaFV8byptlTYsrWmoXs4cp6cWmtn2tr7
         Q92H6qni16+i4qMRnVt68uj+Ho54jdlv+0d0jELJ4Iawhtgwndrz31D+YjwVT5Qt+CQ9
         tsXwGvOrokryuLVBBCh9C5snvJMfCLsmE6qUt5pmEQa1xV6gjFMFOwpNKTSHJGVl6tOY
         nURw==
X-Gm-Message-State: ALKqPwf/aP4J9juPp40PhgK7vfqxyjc8sXGys7nGiUpVxyEFLopY1pDF
        ptjvSu5o2Z4GXM6LG7YHtuY=
X-Google-Smtp-Source: AB8JxZr9S6Eta+KT+o/4BTtGcPPUltB9nHQ3wgkjYxAMLOTVVvqCxZPSQADGgT4zHbmiy/vfc1W6mg==
X-Received: by 2002:a1c:55c9:: with SMTP id j192-v6mr11281376wmb.160.1526886069863;
        Mon, 21 May 2018 00:01:09 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 76-v6sm16110982wmj.0.2018.05.21.00.01.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 May 2018 00:01:08 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Luke Diamand <luke@diamand.org>
Cc:     Romain Merland <merlorom@yahoo.fr>,
        Git Users <git@vger.kernel.org>,
        Matthieu Moy <Matthieu.Moy@imag.fr>,
        Vinicius Kursancew <viniciusalexandre@gmail.com>,
        Jeff King <peff@peff.net>,
        Cedric Borgese <cedric.borgese@gmail.com>,
        Fabien Boutantin <fabien.boutantin@pdgm.com>
Subject: Re: [PATCH] git-p4: add options --commit and --disable-rebase
References: <20180509153212.2681-1-merlorom@yahoo.fr>
        <CAE5ih7_U_8TqsWQbCBrATkrOpyAkE2sdgj3KXdovLw7rsXtt6A@mail.gmail.com>
Date:   Mon, 21 May 2018 16:01:08 +0900
In-Reply-To: <CAE5ih7_U_8TqsWQbCBrATkrOpyAkE2sdgj3KXdovLw7rsXtt6A@mail.gmail.com>
        (Luke Diamand's message of "Fri, 18 May 2018 12:54:22 +0100")
Message-ID: <xmqqh8n11oi3.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Luke Diamand <luke@diamand.org> writes:

> On 9 May 2018 at 16:32, Romain Merland <merlorom@yahoo.fr> wrote:
>> On a daily work with multiple local git branches, the usual way to submit only a
>> specified commit was to cherry-pick the commit on master then run git-p4 submit.
>> It can be very annoying to switch between local branches and master, only to
>> submit one commit.
>> The proposed new way is to select directly the commit you want to submit.
>>
>> add option --commit to command 'git-p4 submit' in order to submit only specified commit(s) in p4.
>>
>> On a daily work developping software with big compilation time, one may not want
>> to rebase on his local git tree, in order to avoid long recompilation.
>>
>> add option --disable-rebase to command 'git-p4 submit' in order to disable rebase after submission.
>
> I've been using this for real and it works well for me. Ack.
>
> Because of the way I'm using git-p4, the --disable-rebase option
> doesn't really help me - I really need a --disable-sync option but
> that's a different feature.

These sound like two separate issues that deserve two separate
patches, but I'll take it as-is with your Reviewed-by:

The original patch I couldn't find in the public inbox archive, so
here is based on what I saw in my spambox (where pieces of e-mail
addressed to gitster@ but do not appear on the public archive are
sent).

    ... goes and notices the lack of sign-off

Oh, I take it back; I cannot use it as-is, as Romain's sign-off is
missing X-<.

Romain, could you sign it off after understanding what it means by
checking

    https://git.github.io/htmldocs/SubmittingPatches.html#sign-off

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
2.17.0-582-gccdcbd54c4

