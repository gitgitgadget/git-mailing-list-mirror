From: "Luck, Tony" <tony.luck@intel.com>
Subject: [PATCH] Better advice on using topic branches for kernel development
Date: Fri, 01 Oct 2010 11:57:52 -0700
Message-ID: <4ca62f3028180720b7@agluck-desktop.sc.intel.com>
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 01 20:58:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1knx-0002bf-Vg
	for gcvg-git-2@lo.gmane.org; Fri, 01 Oct 2010 20:58:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755342Ab0JAS5y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Oct 2010 14:57:54 -0400
Received: from mga01.intel.com ([192.55.52.88]:40900 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755333Ab0JAS5w (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Oct 2010 14:57:52 -0400
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP; 01 Oct 2010 11:57:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.57,267,1283756400"; 
   d="scan'208";a="612388319"
Received: from agluck-desktop.sc.intel.com ([10.3.52.238])
  by fmsmga002.fm.intel.com with SMTP; 01 Oct 2010 11:57:52 -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157772>

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
