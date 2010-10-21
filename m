From: "Luck, Tony" <tony.luck@intel.com>
Subject: [PATCH] Better advice on using topic branches for kernel development
Date: Thu, 21 Oct 2010 09:29:53 -0700
Message-ID: <4cc06a8128436b591e@agluck-desktop.sc.intel.com>
Cc: git@vger.kernel.org,
	"Linus Torvalds" <torvalds@linux-foundation.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 21 18:30:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8y1q-0005Dh-Fg
	for gcvg-git-2@lo.gmane.org; Thu, 21 Oct 2010 18:30:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751293Ab0JUQaD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Oct 2010 12:30:03 -0400
Received: from mga03.intel.com ([143.182.124.21]:18232 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750990Ab0JUQaC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Oct 2010 12:30:02 -0400
Received: from azsmga001.ch.intel.com ([10.2.17.19])
  by azsmga101.ch.intel.com with ESMTP; 21 Oct 2010 09:30:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.58,218,1286175600"; 
   d="scan'208";a="338862246"
Received: from agluck-desktop.sc.intel.com ([10.3.52.238])
  by azsmga001.ch.intel.com with SMTP; 21 Oct 2010 09:29:53 -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159521>

Linus Torvalds wrote:
> The real problem is that maintainers often pick random - and not at
> all stable - points for their development to begin with. They just
> pick some random "this is where Linus -git tree is today", and do
> their development on top of that. THAT is the problem - they are
> unaware that there's some nasty bug in that version.

Maybe they do this because they read it in the Git user-manual.

Fix the manual to give them better guidance.

Signed-off-by: Tony Luck <tony.luck@intel.com>

---

Originally posted on October 1st ... no comments received.

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index fecc4eb..66a249d 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -2171,11 +2171,14 @@ $ git push mytree release
 
 Now to apply some patches from the community.  Think of a short
 snappy name for a branch to hold this patch (or related group of
-patches), and create a new branch from the current tip of Linus's
-branch:
+patches), and create a new branch from a recent stable tag of
+Linus's branch. Picking a stable base for your branch will:
+1) help you: by avoiding inclusion of unrelated and perhaps lightly
+tested changes
+2) help future bug hunters that use "git bisect" to find problems
 
 -------------------------------------------------
-$ git checkout -b speed-up-spinlocks origin
+$ git checkout -b speed-up-spinlocks v2.6.35
 -------------------------------------------------
 
 Now you apply the patch(es), run some tests, and commit the change(s).  If
