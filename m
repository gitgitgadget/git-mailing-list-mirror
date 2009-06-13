From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH] git-rerere.txt: grammatical fixups and cleanups
Date: Sat, 13 Jun 2009 11:20:00 -0700
Message-ID: <1244917200-6097-1-git-send-email-bebarino@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 13 20:20:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MFXq2-0005ZX-Ns
	for gcvg-git-2@gmane.org; Sat, 13 Jun 2009 20:20:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752468AbZFMSUF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Jun 2009 14:20:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751654AbZFMSUE
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Jun 2009 14:20:04 -0400
Received: from wf-out-1314.google.com ([209.85.200.171]:30162 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751310AbZFMSUC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jun 2009 14:20:02 -0400
Received: by wf-out-1314.google.com with SMTP id 26so1114023wfd.4
        for <git@vger.kernel.org>; Sat, 13 Jun 2009 11:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=3nwMd3wRGsnfo+G2oz80yLFFzHGuL7PXnBoUH7R2FII=;
        b=S8R0UiO4NqWAmzmTZsyNeEwXRfmJXFzZ6nwEy5MrsWawidta8pPzmr+txsBQknAeDq
         2H718aiHeP72v4mnUGd5Ngjlzos1Pyjm7ko/h9PAhS/IjL3sZRkD+pG2bKsCwWsww9TI
         Gd/ULBT1M16x8QO7t2tRmC+dgBj5w49ye3tmY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=sM+98TxTDXDoKydn+FooFQCXDKlpNt6qla0djUOvrnT2NGaxgBlw2TSSBO49nSCVTi
         z2sq5M1dDDpBRys6xMDyS9+wFtTbfppDt/Kixs6KBvkn/q1cqxHJGFEwfm4Cw4oFfDxE
         jlb2ouol+L1ghGdzao+a1fGwQXf7YUJTQplXI=
Received: by 10.142.80.12 with SMTP id d12mr1894313wfb.309.1244917204407;
        Sat, 13 Jun 2009 11:20:04 -0700 (PDT)
Received: from earth ([76.89.212.195])
        by mx.google.com with ESMTPS id 32sm3334833wfa.33.2009.06.13.11.20.02
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 13 Jun 2009 11:20:03 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Sat, 13 Jun 2009 11:20:00 -0700
X-Mailer: git-send-email 1.6.3.2.225.gb8364
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121514>

Rewrite the gc section using unresolved and resolved instead of "not
recorded". Add plurals and missing articles. Make some sentences have
consistent tense. Try and be more active by removing "that" and
simplifying sentences.

The terms "hand-resolve" and "hand resolve" were used, so just use "hand
resolve" to be more consistent.

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---
 Documentation/git-rerere.txt |   65 ++++++++++++++++++++---------------------
 1 files changed, 32 insertions(+), 33 deletions(-)

diff --git a/Documentation/git-rerere.txt b/Documentation/git-rerere.txt
index 64715c1..a53c3cd 100644
--- a/Documentation/git-rerere.txt
+++ b/Documentation/git-rerere.txt
@@ -12,15 +12,15 @@ SYNOPSIS
 DESCRIPTION
 -----------
 
-In a workflow that employs relatively long lived topic branches,
-the developer sometimes needs to resolve the same conflict over
+In a workflow employing relatively long lived topic branches,
+the developer sometimes needs to resolve the same conflicts over
 and over again until the topic branches are done (either merged
 to the "release" branch, or sent out and accepted upstream).
 
-This command helps this process by recording conflicted
-automerge results and corresponding hand-resolve results on the
-initial manual merge, and later by noticing the same automerge
-results and applying the previously recorded hand resolution.
+This command assists the developer in this process by recording
+conflicted automerge results and corresponding hand resolve results
+on the initial manual merge, and applying previously recorded
+hand resolutions to their corresponding automerge results.
 
 [NOTE]
 You need to set the configuration variable rerere.enabled to
@@ -54,18 +54,18 @@ for resolutions.
 
 'gc'::
 
-This command is used to prune records of conflicted merge that
-occurred long time ago.  By default, conflicts older than 15
-days that you have not recorded their resolution, and conflicts
-older than 60 days, are pruned.  These are controlled with
+This prunes records of conflicted merges that
+occurred a long time ago.  By default, unresolved conflicts older
+than 15 days and resolved conflicts older than 60
+days are pruned.  These defaults are controlled via the
 `gc.rerereunresolved` and `gc.rerereresolved` configuration
-variables.
+variables respectively.
 
 
 DISCUSSION
 ----------
 
-When your topic branch modifies overlapping area that your
+When your topic branch modifies an overlapping area that your
 master branch (or upstream) touched since your topic branch
 forked from it, you may want to test it with the latest master,
 even before your topic branch is ready to be pushed upstream:
@@ -140,9 +140,9 @@ top of the tip before the test merge:
 This would leave only one merge commit when your topic branch is
 finally ready and merged into the master branch.  This merge
 would require you to resolve the conflict, introduced by the
-commits marked with `*`.  However, often this conflict is the
+commits marked with `*`.  However, this conflict is often the
 same conflict you resolved when you created the test merge you
-blew away.  'git-rerere' command helps you to resolve this final
+blew away.  'git-rerere' helps you resolve this final
 conflicted merge using the information from your earlier hand
 resolve.
 
@@ -150,33 +150,32 @@ Running the 'git-rerere' command immediately after a conflicted
 automerge records the conflicted working tree files, with the
 usual conflict markers `<<<<<<<`, `=======`, and `>>>>>>>` in
 them.  Later, after you are done resolving the conflicts,
-running 'git-rerere' again records the resolved state of these
+running 'git-rerere' again will record the resolved state of these
 files.  Suppose you did this when you created the test merge of
 master into the topic branch.
 
-Next time, running 'git-rerere' after seeing a conflicted
-automerge, if the conflict is the same as the earlier one
-recorded, it is noticed and a three-way merge between the
+Next time, after seeing the same conflicted automerge,
+running 'git-rerere' will perform a three-way merge between the
 earlier conflicted automerge, the earlier manual resolution, and
-the current conflicted automerge is performed by the command.
+the current conflicted automerge.
 If this three-way merge resolves cleanly, the result is written
-out to your working tree file, so you would not have to manually
+out to your working tree file, so you do not have to manually
 resolve it.  Note that 'git-rerere' leaves the index file alone,
 so you still need to do the final sanity checks with `git diff`
 (or `git diff -c`) and 'git-add' when you are satisfied.
 
 As a convenience measure, 'git-merge' automatically invokes
-'git-rerere' when it exits with a failed automerge, which
-records it if it is a new conflict, or reuses the earlier hand
+'git-rerere' upon exiting with a failed automerge and 'git-rerere'
+records the hand resolve when it is a new conflict, or reuses the earlier hand
 resolve when it is not.  'git-commit' also invokes 'git-rerere'
-when recording a merge result.  What this means is that you do
-not have to do anything special yourself (Note: you still have
-to set the config variable rerere.enabled to enable this command).
+when committing a merge result.  What this means is that you do
+not have to do anything special yourself (besides enabling
+the rerere.enabled config variable).
 
-In our example, when you did the test merge, the manual
+In our example, when you do the test merge, the manual
 resolution is recorded, and it will be reused when you do the
-actual merge later with updated master and topic branch, as long
-as the earlier resolution is still applicable.
+actual merge later with the updated master and topic branch, as long
+as the recorded resolution is still applicable.
 
 The information 'git-rerere' records is also used when running
 'git-rebase'.  After blowing away the test merge and continuing
@@ -194,11 +193,11 @@ development on the topic branch:
     o---o---o---*---o---o---o---o   master
 ------------
 
-you could run `git rebase master topic`, to keep yourself
-up-to-date even before your topic is ready to be sent upstream.
-This would result in falling back to three-way merge, and it
-would conflict the same way the test merge you resolved earlier.
-'git-rerere' is run by 'git-rebase' to help you resolve this
+you could run `git rebase master topic`, to bring yourself
+up-to-date before your topic is ready to be sent upstream.
+This would result in falling back to a three-way merge, and it
+would conflict the same way as the test merge you resolved earlier.
+'git-rerere' will be run by 'git-rebase' to help you resolve this
 conflict.
 
 
-- 
1.6.3.2.225.gb8364
