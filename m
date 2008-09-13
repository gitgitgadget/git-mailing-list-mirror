From: Thomas Rast <trast@student.ethz.ch>
Subject: Interdiff: [3/3] Documentation: add manpage about workflows
Date: Sat, 13 Sep 2008 18:11:03 +0200
Message-ID: <1221322263-25291-5-git-send-email-trast@student.ethz.ch>
References: <7v8wtwk4yp.fsf@gitster.siamese.dyndns.org>
 <1221322263-25291-1-git-send-email-trast@student.ethz.ch>
 <1221322263-25291-2-git-send-email-trast@student.ethz.ch>
 <1221322263-25291-3-git-send-email-trast@student.ethz.ch>
 <1221322263-25291-4-git-send-email-trast@student.ethz.ch>
Cc: Junio C Hamano <junio@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 13 18:12:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KeXjX-0001Zh-3R
	for gcvg-git-2@gmane.org; Sat, 13 Sep 2008 18:12:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751832AbYIMQLW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Sep 2008 12:11:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751853AbYIMQLU
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Sep 2008 12:11:20 -0400
Received: from xsmtp1.ethz.ch ([82.130.70.13]:43500 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751639AbYIMQLR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Sep 2008 12:11:17 -0400
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 13 Sep 2008 18:11:10 +0200
Received: from localhost.localdomain ([77.56.223.244]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 13 Sep 2008 18:11:09 +0200
X-Mailer: git-send-email 1.6.0.2.408.g3709
In-Reply-To: <1221322263-25291-4-git-send-email-trast@student.ethz.ch>
X-OriginalArrivalTime: 13 Sep 2008 16:11:09.0933 (UTC) FILETIME=[55CCE9D0:01C915BB]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95804>

---
 Documentation/gitworkflows.txt |   24 ++++++++++++++----------
 1 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/Documentation/gitworkflows.txt b/Documentation/gitworkflows.txt
index 3462000..b4b43da 100644
--- a/Documentation/gitworkflows.txt
+++ b/Documentation/gitworkflows.txt
@@ -92,8 +92,8 @@ Topic branches
 
 Any nontrivial feature will require several patches to implement, and
 may get extra bugfixes or improvements during its lifetime.  If all
-such commits were in one long linear history chain (e.g. if they were
-all committed directly to, 'master'), it becomes very hard to see how
+such commits were in one long linear history chain (e.g., if they were
+all committed directly to 'master'), it becomes very hard to see how
 they belong together.
 
 The key concept here is "topic branches".  The name is pretty self
@@ -124,8 +124,8 @@ elsewhere should not be rebased.  See the section on RECOVERING FROM
 UPSTREAM REBASE in linkgit:git-rebase[1].
 
 We should point out that "habitually" (regularly for no real reason)
-merging a main branch into your topics--and by extension, merging
-anything upstream into anything downstream on a regular basis--is
+merging a main branch into your topics -- and by extension, merging
+anything upstream into anything downstream on a regular basis -- is
 frowned upon:
 
 .Merge to downstream only at well-defined points
@@ -207,7 +207,7 @@ There are three main tools that can be used for this:
 * linkgit:git-fetch[1] that copies remote branches to your repository;
   and
 
-* linkgit:git-pull[1] that is fetch and merge in one go.
+* linkgit:git-pull[1] that does fetch and merge in one go.
 
 Note the last point.  Do 'not' use 'git-pull' unless you actually want
 to merge the remote branch.
@@ -258,7 +258,7 @@ follows.
 Occasionally, the maintainer may get merge conflicts when he tries to
 pull changes from downstream.  In this case, he can ask downstream to
 do the merge and resolve the conflicts themselves (perhaps they will
-know better how to react).  It is one of the rare cases where
+know better how to resolve them).  It is one of the rare cases where
 downstream 'should' merge from upstream.
 
 
@@ -274,12 +274,15 @@ maintainer's life easier).
 .format-patch/am: Publishing branches/topics
 [caption="Recipe: "]
 =====================================
-`git format-patch -M upstream..topic` and send out the resulting files.
+* `git format-patch -M upstream..topic` to turn them into preformatted
+  patch files
+* `git send-email --to=<recipient> <patches>`
 =====================================
 
-See the linkgit:git-format-patch[1] manpage for further usage notes.
-Also you should be aware that the maintainer may impose further
-restrictions, such as "Signed-off-by" requirements.
+See the linkgit:git-format-patch[1] and linkgit:git-send-email[1]
+manpages for further usage notes.  Also you should be aware that the
+maintainer may impose further restrictions, such as "Signed-off-by"
+requirements.
 
 If the maintainer tells you that your patch no longer applies to the
 current upstream, you will have to rebase your topic (you cannot use a
@@ -319,6 +322,7 @@ linkgit:git-pull[1],
 linkgit:git-merge[1],
 linkgit:git-rebase[1],
 linkgit:git-format-patch[1],
+linkgit:git-send-email[1],
 linkgit:git-am[1]
 
 GIT
-- 
1.6.0.2.408.g3709
