From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH] user-manual: Talk about tracking third-party snapshots
Date: Sun, 18 Nov 2007 19:48:28 -0500
Message-ID: <20071119004828.GB23671@fieldses.org>
References: <11949569992214-git-send-email-msmith@cbnco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Michael Smith <msmith@cbnco.com>
X-From: git-owner@vger.kernel.org Mon Nov 19 01:49:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ituot-0000iL-Kb
	for gcvg-git-2@gmane.org; Mon, 19 Nov 2007 01:49:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751047AbXKSAsj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Nov 2007 19:48:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750891AbXKSAsj
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Nov 2007 19:48:39 -0500
Received: from mail.fieldses.org ([66.93.2.214]:56793 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750705AbXKSAsi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Nov 2007 19:48:38 -0500
Received: from bfields by fieldses.org with local (Exim 4.68)
	(envelope-from <bfields@fieldses.org>)
	id 1ItuoO-0000Gz-Ko; Sun, 18 Nov 2007 19:48:28 -0500
Content-Disposition: inline
In-Reply-To: <11949569992214-git-send-email-msmith@cbnco.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65396>

On Tue, Nov 13, 2007 at 07:29:59AM -0500, Michael Smith wrote:
> +You can view all your local changes--b, d, h, and i--with the
> +gitlink:git-diff[1] command:
> +
> +------------------------------------------
> +$ git diff origin/master...master
> +------------------------------------------
> +
> +The three-dot `\...` tells gitlink:git-diff[1] to show the changes on the
> +master branch since the last common ancestor with origin/master. (If you
> +used two dots instead of three, you'd see the entire patch to go from
> +origin/master to master, including reversing commits "f" and "g".)

I missed the "..." thing when on my first attempt at the manual.  It
really should be mentioned in the "Generating diffs" section; I've added
the following to my

	git://linux-nfs.org/~bfields/git.git maint

--b.

>From 5b98d9bca16e19710380d2d03f704de9eb98621d Mon Sep 17 00:00:00 2001
From: J. Bruce Fields <bfields@citi.umich.edu>
Date: Sun, 18 Nov 2007 19:18:27 -0500
Subject: [PATCH] user-manual: mention "..." in "Generating diffs", etc.

We should mention the use of the "..." syntax for git-diff here.  The
note about the difference between diff and the combined output of
git-format-patch then no longer fits so well, so remove it.  Add a
reference to the git-format-patch[1] manpage.

Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
---
 Documentation/user-manual.txt |   15 +++++++++++----
 1 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index e399685..c027353 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -658,16 +658,23 @@ gitlink:git-diff[1]:
 $ git diff master..test
 -------------------------------------------------
 
-Sometimes what you want instead is a set of patches:
+That will produce the diff between the tips of the two branches.  If
+you'd prefer to find the diff from their common ancestor to test, you
+can use three dots instead of two:
+
+-------------------------------------------------
+$ git diff master...test
+-------------------------------------------------
+
+Sometimes what you want instead is a set of patches; for this you can
+use gitlink:git-format-patch[1]:
 
 -------------------------------------------------
 $ git format-patch master..test
 -------------------------------------------------
 
 will generate a file with a patch for each commit reachable from test
-but not from master.  Note that if master also has commits which are
-not reachable from test, then the combined result of these patches
-will not be the same as the diff produced by the git-diff example.
+but not from master.
 
 [[viewing-old-file-versions]]
 Viewing old file versions
-- 
1.5.3.5.561.g140d
