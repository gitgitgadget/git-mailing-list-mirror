Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F1EF202F3
	for <e@80x24.org>; Wed, 20 Jul 2016 21:10:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755275AbcGTVKm (ORCPT <rfc822;e@80x24.org>);
	Wed, 20 Jul 2016 17:10:42 -0400
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:23335 "EHLO
	smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754915AbcGTVKT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jul 2016 17:10:19 -0400
Received: from localhost.localdomain ([92.22.79.77])
	by smtp.talktalk.net with SMTP
	id PykwbXvjRHGLwPyl0bEmcu; Wed, 20 Jul 2016 22:10:18 +0100
X-Originating-IP: [92.22.79.77]
X-Spam:	0
X-OAuthority: v=2.2 cv=dsCZMBo4 c=1 sm=1 tr=0 a=YfJyJ16zsu2qLTmLoX9DvA==:117
 a=YfJyJ16zsu2qLTmLoX9DvA==:17 a=xtxXYLxNAAAA:8 a=TOVKkDOYyZsXre-1sqsA:9
 a=xts0dhWdiJbonKbuqhAr:22
From:	Philip Oakley <philipoakley@iee.org>
To:	GitList <git@vger.kernel.org>
Cc:	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Marc Branchaud <marcnarc@xiplink.com>,
	=?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>
Subject: [PATCH v4 4/8] doc: give headings for the two and three dot notations
Date:	Wed, 20 Jul 2016 22:10:03 +0100
Message-Id: <20160720211007.5520-5-philipoakley@iee.org>
X-Mailer: git-send-email 2.9.0.windows.1
In-Reply-To: <20160720211007.5520-1-philipoakley@iee.org>
References: <20160711202518.532-1-philipoakley@iee.org>
 <20160720211007.5520-1-philipoakley@iee.org>
X-CMAE-Envelope: MS4wfASWNeGta+Su5kA5zjODLSNmYwjXLIvPTeeSouMg52L/Bs0+Rlr6X1BxeP9nIL/O9bsbhQhzTG3IdohaQX/56WUh6rCYhJkmqVZBA2RTEPlARKj/Uxf9
 96huvuaOF67UYpZfw0Ww0+Bqb+2TbilFiy3UOD2ExpxIlVguvf5R5/kxruM6XyMmDeIUsfjceETecx2JrLjCS6YYEmOYDmjTdWb/SkrDmz1roSK/LfvvfprY
 CkO12aWzkMapYrI2QftLqJ1JPbGsgEbcrhlbv3i3mP9gqfMm6S5bX028u9S1Aaht
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

While there, also break out the other shorthand notations and
add a title for the revision range summary (which also appears
in git-rev-parse, so keep it mixed case).

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
 Documentation/revisions.txt | 58 ++++++++++++++++++++++++++++-----------------
 1 file changed, 36 insertions(+), 22 deletions(-)

diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
index 6e9cd41..5b37283 100644
--- a/Documentation/revisions.txt
+++ b/Documentation/revisions.txt
@@ -242,35 +242,49 @@ specifying a single revision with the notation described in the
 previous section means the set of commits reachable from that
 commit, following the commit ancestry chain.
 
-To exclude commits reachable from a commit, a prefix '{caret}'
-notation is used.  E.g. '{caret}r1 r2' means commits reachable
-from 'r2' but exclude the ones reachable from 'r1'.
-
-This set operation appears so often that there is a shorthand
-for it.  When you have two commits 'r1' and 'r2' (named according
-to the syntax explained in SPECIFYING REVISIONS above), you can ask
-for commits that are reachable from r2 excluding those that are reachable
-from r1 by '{caret}r1 r2' and it can be written as 'r1..r2'.
-
-A similar notation 'r1\...r2' is called symmetric difference
-of 'r1' and 'r2' and is defined as
-'r1 r2 --not $(git merge-base --all r1 r2)'.
-It is the set of commits that are reachable from either one of
-'r1' (left side) or 'r2' (right side) but not from both.
-
-In these two shorthands, you can omit one end and let it default to HEAD.
+Commit Exclusions
+~~~~~~~~~~~~~~~~~
+
+'{caret}<rev>' (caret) Notation::
+ To exclude commits reachable from a commit, a prefix '{caret}'
+ notation is used.  E.g. '{caret}r1 r2' means commits reachable
+ from 'r2' but exclude the ones reachable from 'r1'.
+
+Dotted Range Notations
+~~~~~~~~~~~~~~~~~~~~~~
+
+The '..' (two-dot) Range Notation::
+ The '{caret}r1 r2' set operation appears so often that there is a shorthand
+ for it.  When you have two commits 'r1' and 'r2' (named according
+ to the syntax explained in SPECIFYING REVISIONS above), you can ask
+ for commits that are reachable from r2 excluding those that are reachable
+ from r1 by '{caret}r1 r2' and it can be written as 'r1..r2'.
+
+The '...' (three dot) Symmetric Difference Notation::
+ A similar notation 'r1\...r2' is called symmetric difference
+ of 'r1' and 'r2' and is defined as
+ 'r1 r2 --not $(git merge-base --all r1 r2)'.
+ It is the set of commits that are reachable from either one of
+ 'r1' (left side) or 'r2' (right side) but not from both.
+
+In these two shorthand notations, you can omit one end and let it default to HEAD.
 For example, 'origin..' is a shorthand for 'origin..HEAD' and asks "What
 did I do since I forked from the origin branch?"  Similarly, '..origin'
 is a shorthand for 'HEAD..origin' and asks "What did the origin do since
 I forked from them?"  Note that '..' would mean 'HEAD..HEAD' which is an
 empty range that is both reachable and unreachable from HEAD.
 
-Two other shorthands for naming a set that is formed by a commit
-and its parent commits exist.  The 'r1{caret}@' notation means all
-parents of 'r1'.  'r1{caret}!' includes commit 'r1' but excludes
-all of its parents.
+Special '<rev>{caret}' Shorthand Notations
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+Two other shorthands exist, particularly useful for merge commits, is
+for naming a set that is formed by a commit and its parent commits.
 
-To summarize:
+The 'r1{caret}@' notation means all parents of 'r1'.
+
+'r1{caret}!' includes commit 'r1' but excludes all of its parents.
+
+Revision Range Summary
+----------------------
 
 '<rev>'::
 	Include commits that are reachable from (i.e. ancestors of)
-- 
2.9.0.windows.1

