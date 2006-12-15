X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD,
	UNPARSEABLE_RELAY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
From: Brian Gernhardt <benji@silverinsanity.com>
Subject: [PATCH] Make git-diff documentation use [--] when it should.
Date: Fri, 15 Dec 2006 07:39:33 -0500
Message-ID: <20061215123933.GB21322@162.242.249.10.in-addr.arpa>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 15 Dec 2006 12:39:42 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34501>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvCLi-0003Ig-UY for gcvg-git@gmane.org; Fri, 15 Dec
 2006 13:39:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752077AbWLOMjf (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 15 Dec 2006
 07:39:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752078AbWLOMjf
 (ORCPT <rfc822;git-outgoing>); Fri, 15 Dec 2006 07:39:35 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:55368 "EHLO
 silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id
 S1752077AbWLOMjf (ORCPT <rfc822;git@vger.kernel.org>); Fri, 15 Dec 2006
 07:39:35 -0500
Received: from localhost.localdomain (localhost [127.0.0.1]) by
 silverinsanity.com (Postfix) with ESMTP id A596A1FFC02B for
 <git@vger.kernel.org>; Fri, 15 Dec 2006 12:39:34 +0000 (UTC)
Received: from Mutt by mutt-smtp-wrapper.pl 1.2 
 (www.zdo.com/articles/mutt-smtp-wrapper.shtml)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Two of the cases has "[--] [<path>...]" and two had "-- [<path>...]".
Not terribly consistent and potentially confusing.  Also add "[--]" to
the synopsis so that it's obvious you can use it from the very
beginning.

Signed-off-by: Brian Gernhardt <benji@silverinsanity.com>
---
 Documentation/git-diff.txt |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
index 127d68c..10fdf88 100644
--- a/Documentation/git-diff.txt
+++ b/Documentation/git-diff.txt
@@ -8,7 +8,7 @@ git-diff - Show changes between commits, commit and working tree, etc
 
 SYNOPSIS
 --------
-'git-diff' [ --diff-options ] <tree-ish>{0,2} [<path>...]
+'git-diff' [ --diff-options ] <tree-ish>{0,2} [--] [<path>...]
 
 DESCRIPTION
 -----------
@@ -30,7 +30,7 @@ tree and the index file, or the index file and the working tree.
 	would want comparison with the latest commit, so if you
 	do not give <commit>, it defaults to HEAD.
 
-'git-diff' [--options] <commit> -- [<path>...]::
+'git-diff' [--options] <commit> [--] [<path>...]::
 
 	This form is to view the changes you have in your
 	working tree relative to the named <commit>.  You can
@@ -38,7 +38,7 @@ tree and the index file, or the index file and the working tree.
 	branch name to compare with the tip of a different
 	branch.
 
-'git-diff' [--options] <commit> <commit> -- [<path>...]::
+'git-diff' [--options] <commit> <commit> [--] [<path>...]::
 
 	This form is to view the changes between two <commit>,
 	for example, tips of two branches.
-- 
1.4.4.1.GIT
