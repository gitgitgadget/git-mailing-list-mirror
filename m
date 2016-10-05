Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B85071F4F8
	for <e@80x24.org>; Wed,  5 Oct 2016 14:54:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754557AbcJEOyi (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Oct 2016 10:54:38 -0400
Received: from mail.javad.com ([54.86.164.124]:43258 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753148AbcJEOyh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2016 10:54:37 -0400
X-Greylist: delayed 486 seconds by postgrey-1.27 at vger.kernel.org; Wed, 05 Oct 2016 10:54:37 EDT
Received: from localhost6.localdomain6 (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id 4F756633E0;
        Wed,  5 Oct 2016 14:46:29 +0000 (UTC)
Received: from localhost6.localdomain6 (localhost.localdomain [127.0.0.1])
        by localhost6.localdomain6 (8.14.4/8.14.4) with ESMTP id u95EkRSi020689;
        Wed, 5 Oct 2016 17:46:27 +0300
Received: (from osv@localhost)
        by localhost6.localdomain6 (8.14.4/8.14.4/Submit) id u95EkRMD020686;
        Wed, 5 Oct 2016 17:46:27 +0300
From:   sorganov@gmail.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Sergey Organov <sorganov@gmail.com>
Subject: [PATCH 5/6] Documentation/git-merge.txt: improve short description in DESCRIPTION
Date:   Wed,  5 Oct 2016 17:46:23 +0300
Message-Id: <e74ae8afc1bfc4cd9161ccaa56d926a89439551e.1475678515.git.sorganov@gmail.com>
X-Mailer: git-send-email 2.10.0.1.g57b01a3
In-Reply-To: <cover.1475678515.git.sorganov@gmail.com>
References: <cover.1475678515.git.sorganov@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Sergey Organov <sorganov@gmail.com>

Old description had a few problems:

- sounded as if commits have changes

- stated that changes are taken since some "divergence point"
  that was not defined.

New description rather uses "common ancestor" and "merge base",
definitions of which are easily discoverable in the rest of GIT
documentation.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 Documentation/git-merge.txt | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index cc0329d..351b8fc 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -16,11 +16,16 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-Incorporates changes from the named commits (since the time their
-histories diverged from the current branch) into the current
-branch.  This command is used by 'git pull' to incorporate changes
-from another repository and can be used by hand to merge changes
-from one branch into another.
+
+Incorporates changes that lead to the named commits into the current
+branch, and joins corresponding histories. The best common ancestor of
+named commits and the current branch, called "merge base", is
+calculated, and then net changes taken from the merge base to
+the named commits are applied.
+
+This command is used by 'git pull' to incorporate changes from another
+repository, and can be used by hand to merge changes from one branch
+into another.
 
 Assume the following history exists and the current branch is
 "`master`":
@@ -31,11 +36,11 @@ Assume the following history exists and the current branch is
     D---E---F---G master
 ------------
 
-Then "`git merge topic`" will replay the changes made on the
-`topic` branch since it diverged from `master` (i.e., `E`) until
-its current commit (`C`) on top of `master`, and record the result
-in a new commit along with the names of the two parent commits and
-a log message from the user describing the changes.
+Then "`git merge topic`" will replay the changes made on the `topic`
+branch since it diverged from `master` (i.e., `E`) until its current
+commit (`C`) on top of `master`, and record the result in a new commit
+along with references to the two parent commits and a log message from
+the user describing the changes.
 
 ------------
 	  A---B---C topic
-- 
2.10.0.1.g57b01a3

