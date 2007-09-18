From: Federico Mena Quintero <federico@novell.com>
Subject: [PATCH 4/4] Make git-pull give hints on what to do when there is
	no branch to merge from
Date: Mon, 17 Sep 2007 20:12:28 -0500
Message-ID: <1190077948.22387.66.camel@cacharro.xalalinux.org>
References: <1190077493.22387.54.camel@cacharro.xalalinux.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 18 03:10:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXRbB-00076h-3d
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 03:09:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754021AbXIRBJw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2007 21:09:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753992AbXIRBJw
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Sep 2007 21:09:52 -0400
Received: from jericho.provo.novell.com ([137.65.248.124]:19985 "EHLO
	jericho.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753842AbXIRBJw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2007 21:09:52 -0400
Received: from [164.99.193.124] ([164.99.193.124])
	by jericho.provo.novell.com with ESMTP; Mon, 17 Sep 2007 19:09:47 -0600
In-Reply-To: <1190077493.22387.54.camel@cacharro.xalalinux.org>
X-Mailer: Evolution 2.11.5 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58521>

Signed-off-by: Federico Mena Quintero <federico@gnu.org>
---
 git-pull.sh |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/git-pull.sh b/git-pull.sh
index 5e96d1f..7beef4d 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -98,7 +98,11 @@ case "$merge_head" in
 	curr_branch=${curr_branch#refs/heads/}
 
 	echo >&2 "Warning: No merge candidate found because value of config option
-         \"branch.${curr_branch}.merge\" does not match any remote branch fetched."
+         \"branch.${curr_branch}.merge\" does not match any remote branch fetched.
+         This branch is not set up to track any other branches.  Please name which
+         branch you want to merge from on the command line, or if you almost always
+         want to merge from the same branch, then set this up with
+         \"git branch --track\"."
 	echo >&2 "No changes."
 	exit 0
 	;;
-- 
1.5.2.4
