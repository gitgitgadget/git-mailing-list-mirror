Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C04971FEAA
	for <e@80x24.org>; Sat, 25 Jun 2016 16:47:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751589AbcFYQrI (ORCPT <rfc822;e@80x24.org>);
	Sat, 25 Jun 2016 12:47:08 -0400
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:6337 "EHLO
	smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751543AbcFYQrG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jun 2016 12:47:06 -0400
Received: from localhost.localdomain ([92.22.68.35])
	by smtp.talktalk.net with SMTP
	id GqjWbvjeqYIiqGqjYbpjXU; Sat, 25 Jun 2016 17:47:04 +0100
X-Originating-IP: [92.22.68.35]
X-Spam:	0
X-OAuthority: v=2.2 cv=P/l4vWIu c=1 sm=1 tr=0 a=MvvZD7eUgq4fJAFIMo7fmA==:117
 a=MvvZD7eUgq4fJAFIMo7fmA==:17 a=xtxXYLxNAAAA:8 a=wgAWyCurPUsrivyQAi4A:9
 a=xts0dhWdiJbonKbuqhAr:22
From:	Philip Oakley <philipoakley@iee.org>
To:	GitList <git@vger.kernel.org>
Cc:	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH 2/2] doc: give headings for the two and three dot notations
Date:	Sat, 25 Jun 2016 17:46:54 +0100
Message-Id: <20160625164654.5192-3-philipoakley@iee.org>
X-Mailer: git-send-email 2.8.4.windows.1.3.ge328a54
In-Reply-To: <20160625164654.5192-1-philipoakley@iee.org>
References: <E61B46FFA8874DD3973AA96BE5B36790@PhilipOakley>
 <20160625164654.5192-1-philipoakley@iee.org>
X-CMAE-Envelope: MS4wfE2gho3hODbY6xiCNmlC/bjHolZrFJ2LNEqC9kGuUEmZoOH9ZOuvpj00UYtn0Dm9N4MKBr4EHvaAvMEaRqxuuRezlJqRp6EMbSjQO98Ll+ZIDOh/CjVd
 R2QxX3nzfZ+bP5uGzVGJdpDojd6wG3QHtma9QSCQzyQnwMQ3EkD4CqU8+bXyOr6E9H5QLrbDZhCULTFp1Tvb8QS1o81kBgNGegDcwr8rJ6p+lNXzkaTcn4Cj
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

While there, also break out the other shorthand notations and
add a title for the revision range summary (which also appears
in git-rev-parse).

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
 Documentation/revisions.txt | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
index 19314e3..c7e123a 100644
--- a/Documentation/revisions.txt
+++ b/Documentation/revisions.txt
@@ -246,12 +246,16 @@ To exclude commits reachable from a commit, a prefix '{caret}'
 notation is used.  E.g. '{caret}r1 r2' means commits reachable
 from 'r2' but exclude the ones reachable from 'r1'.
 
+Single-Sided Difference (two dots)
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 This set operation appears so often that there is a shorthand
 for it.  When you have two commits 'r1' and 'r2' (named according
 to the syntax explained in SPECIFYING REVISIONS above), you can ask
 for commits that are reachable from r2 excluding those that are reachable
 from r1 by '{caret}r1 r2' and it can be written as 'r1..r2'.
 
+Symmetric Difference (three dots)
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 A similar notation 'r1\...r2' is called symmetric difference
 of 'r1' and 'r2' and is defined as
 'r1 r2 --not $(git merge-base --all r1 r2)'.
@@ -265,12 +269,17 @@ is a shorthand for 'HEAD..origin' and asks "What did the origin do since
 I forked from them?"  Note that '..' would mean 'HEAD..HEAD' which is an
 empty range that is both reachable and unreachable from HEAD.
 
+The '{caret}' Shorthands
+~~~~~~~~~~~~~~~~~~~~~~~~
 Two other shorthands for naming a set that is formed by a commit
-and its parent commits exist.  The 'r1{caret}@' notation means all
-parents of 'r1'.  'r1{caret}!' includes commit 'r1' but excludes
-all of its parents.
+and its parent commits exist.
 
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
2.8.4.windows.1.3.ge328a54

