From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Update git-diff-cache documentation.
Date: Mon, 23 May 2005 18:20:39 -0700
Message-ID: <7vu0ktzafs.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 24 03:20:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DaO4z-0004i2-GO
	for gcvg-git@gmane.org; Tue, 24 May 2005 03:19:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261257AbVEXBU4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 May 2005 21:20:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261278AbVEXBU4
	(ORCPT <rfc822;git-outgoing>); Mon, 23 May 2005 21:20:56 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:37300 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S261257AbVEXBUl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2005 21:20:41 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050524012039.MUSV23392.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 23 May 2005 21:20:39 -0400
To: torvalds@osdl.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

The recent diff updates gave diff-cache the same ability to
filter paths, which was not properly documented.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

Documentation/git-diff-cache.txt |   10 ++++++----
diff-cache.c                     |    2 +-
2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-diff-cache.txt b/Documentation/git-diff-cache.txt
--- a/Documentation/git-diff-cache.txt
+++ b/Documentation/git-diff-cache.txt
@@ -9,13 +9,15 @@ git-diff-cache - Compares content and mo
 
 SYNOPSIS
 --------
-'git-diff-cache' [-p] [-r] [-z] [-m] [-M] [-R] [-C] [-S<string>] [--cached] <tree-ish>
+'git-diff-cache' [-p] [-r] [-z] [-m] [-M] [-R] [-C] [-S<string>] [--cached] <tree-ish> [<path>...]
 
 DESCRIPTION
 -----------
-Compares the content and mode of the blobs found via a tree object
-with the content of the current cache and, optionally ignoring the
-stat state of the file on disk.
+Compares the content and mode of the blobs found via a tree
+object with the content of the current cache and, optionally
+ignoring the stat state of the file on disk.  When paths are
+specified, compares only those named paths.  Otherwise all
+entries in the cache are compared.
 
 OPTIONS
 -------
diff --git a/diff-cache.c b/diff-cache.c
--- a/diff-cache.c
+++ b/diff-cache.c
@@ -154,7 +154,7 @@ static void mark_merge_entries(void)
 }
 
 static char *diff_cache_usage =
-"git-diff-cache [-p] [-r] [-z] [-m] [-M] [-C] [-R] [-S<string>] [--cached] <tree-ish>";
+"git-diff-cache [-p] [-r] [-z] [-m] [-M] [-C] [-R] [-S<string>] [--cached] <tree-ish> [<path>...]";
 
 int main(int argc, const char **argv)
 {
------------------------------------------------

