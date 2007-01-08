From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH] Documentation: clarify glossary definition of "reachable"
Date: Sun, 7 Jan 2007 22:28:45 -0500
Message-ID: <20070108032845.GJ18009@fieldses.org>
References: <20070108002839.GF18009@fieldses.org> <7vvejiz40u.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 08 04:28:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3lBq-0003Fa-9l
	for gcvg-git@gmane.org; Mon, 08 Jan 2007 04:28:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030469AbXAHD2r (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 Jan 2007 22:28:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030470AbXAHD2r
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jan 2007 22:28:47 -0500
Received: from mail.fieldses.org ([66.93.2.214]:38063 "EHLO
	pickle.fieldses.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030469AbXAHD2r (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jan 2007 22:28:47 -0500
Received: from bfields by pickle.fieldses.org with local (Exim 4.63)
	(envelope-from <bfields@fieldses.org>)
	id 1H3lBl-0000DR-Uc; Sun, 07 Jan 2007 22:28:45 -0500
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vvejiz40u.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36231>

On Sun, Jan 07, 2007 at 05:44:01PM -0800, Junio C Hamano wrote:
> That is better but the description is too commit centric.
> 
>         The set of reachable objects from a tag is the tag
>         itself and the set of reachable objects from the object
>         it tags.  The set of reachable objects from a commit is
>         the commit itself, and the set of reachable objects from
>         its parents and its tree.  The set of reachable objects
>         from a tree is the tree itself, and the set of reachable
>         objects from the trees and blobs contained within it.
>         The set of reachable objects from a blob is the blob
>         itself.
> 
> And that description is too verbose and too technical
> (definition being recursive).  Better rewording?

Oops, you're right!  Take two:  (I'm still giving the commit case first
as a special example, because I think it's the most important case, and
because it requires less knowledge to understand.)

--b.

>From 1b1885dc3cf597452c597f34e6f52856c9524239 Mon Sep 17 00:00:00 2001
From: J. Bruce Fields <bfields@citi.umich.edu>
Date: Sun, 7 Jan 2007 19:25:35 -0500
Subject: [PATCH] [PATCH] Documentation: clarify definition of "reachable"

Clarify definition of "reachable" (what chain?)

Signed-off-by: "J. Bruce Fields" <bfields@citi.umich.edu>
---
 Documentation/glossary.txt |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/glossary.txt b/Documentation/glossary.txt
index 7c1a659..cd61aa2 100644
--- a/Documentation/glossary.txt
+++ b/Documentation/glossary.txt
@@ -235,8 +235,11 @@ push::
 	local head, the push fails.
 
 reachable::
-	An object is reachable from a ref/commit/tree/tag, if there is a
-	chain leading from the latter to the former.
+	All of the ancestors of a given commit are said to be reachable from
+	that commit.  More generally, one object is reachable from another if
+	we can reach the one from the other by a chain that follows tags to
+	whatever they tag, commits to their parents or trees, and trees to the
+	trees or blobs that they contain.
 
 rebase::
 	To clean a branch by starting from the head of the main line of
-- 
1.5.0.rc0.ge16c2
