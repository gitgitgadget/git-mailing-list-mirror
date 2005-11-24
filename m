From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 4/9] remove git wrapper dependency
Date: Wed, 23 Nov 2005 23:51:33 -0800
Message-ID: <20051124075133.GE4789@mail.yhbt.net>
References: <20051112092336.GA16218@Muzzle> <46a038f90511170126l5f04f4e0ta578fc2cb375db68@mail.gmail.com> <20051124074605.GA4789@mail.yhbt.net> <20051124074739.GB4789@mail.yhbt.net> <20051124074857.GC4789@mail.yhbt.net> <20051124075027.GD4789@mail.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>,
	Martin Langhoff <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Thu Nov 24 08:53:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EfBtJ-0006sS-Qp
	for gcvg-git@gmane.org; Thu, 24 Nov 2005 08:51:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030566AbVKXHve (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 Nov 2005 02:51:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030565AbVKXHve
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Nov 2005 02:51:34 -0500
Received: from hand.yhbt.net ([66.150.188.102]:59625 "EHLO mail.yhbt.net")
	by vger.kernel.org with ESMTP id S1030566AbVKXHvd (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Nov 2005 02:51:33 -0500
Received: by mail.yhbt.net (Postfix, from userid 500)
	id 151582DC033; Wed, 23 Nov 2005 23:51:33 -0800 (PST)
To: Martin Langhoff <martin.langhoff@gmail.com>
Content-Disposition: inline
In-Reply-To: <20051124075027.GD4789@mail.yhbt.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12685>

use git-diff-files instead of git diff-files so we don't rely on the
wrapper being installed (some people may have git as GNU interactive
tools :)

Signed-off-by: Eric Wong <normalperson@yhbt.net>

---

 git-archimport.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

applies-to: 36c4ad6c2442e7700e5f1435d834f86d2680dd7f
40b5378433aa6b09dd358d482d7713c2db6a5d92
diff --git a/git-archimport.perl b/git-archimport.perl
index 2ed2e3c..938fa2b 100755
--- a/git-archimport.perl
+++ b/git-archimport.perl
@@ -278,7 +278,7 @@ foreach my $ps (@psets) {
     #
     # ensure we have a clean state 
     # 
-    if (`git diff-files`) {
+    if (`git-diff-files`) {
         die "Unclean tree when about to process $ps->{id} " .
             " - did we fail to commit cleanly before?";
     }
---
0.99.9.GIT
