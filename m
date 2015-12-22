From: "Stephen P. Smith" <ischis2@cox.net>
Subject: [PATCH 2/2] Add a section to the users manual documenting shallow clones.
Date: Mon, 21 Dec 2015 19:09:39 -0700
Message-ID: <1450750180-1811-2-git-send-email-ischis2@cox.net>
References: <1450750180-1811-1-git-send-email-ischis2@cox.net>
Cc: "Stephen P. Smith" <ischis2@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 22 03:10:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aBCOx-0001dJ-1L
	for gcvg-git-2@plane.gmane.org; Tue, 22 Dec 2015 03:10:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752039AbbLVCKG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Dec 2015 21:10:06 -0500
Received: from fed1rmfepo102.cox.net ([68.230.241.144]:55768 "EHLO
	fed1rmfepo102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751982AbbLVCKD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Dec 2015 21:10:03 -0500
Received: from fed1rmimpo210 ([68.230.241.161]) by fed1rmfepo102.cox.net
          (InterMail vM.8.01.05.15 201-2260-151-145-20131218) with ESMTP
          id <20151222021002.JUDW7752.fed1rmfepo102.cox.net@fed1rmimpo210>
          for <git@vger.kernel.org>; Mon, 21 Dec 2015 21:10:02 -0500
Received: from thunderbird ([68.231.74.134])
	by fed1rmimpo210 with cox
	id wSA21r0052tqoqC01SA2XN; Mon, 21 Dec 2015 21:10:02 -0500
X-CT-Class: Clean
X-CT-Score: 0.00
X-CT-RefID: str=0001.0A020203.5678B0FA.00A0,ss=1,re=0.000,fgs=0
X-CT-Spam: 0
X-Authority-Analysis: v=2.0 cv=Hq2o7TvS c=1 sm=1
 a=/Rt4pg3TtX3KzfzhvVoEow==:17 a=kviXuzpPAAAA:8 a=wUQvQvOEmiQA:10
 a=VwQbUJbxAAAA:8 a=_4diPbmaOKkjqgUBgfkA:9 a=/Rt4pg3TtX3KzfzhvVoEow==:117
X-CM-Score: 0.00
Authentication-Results: cox.net; none
Received: from thunderbird.smith.home (thunderbird [127.0.0.1])
	by thunderbird (Postfix) with ESMTP id 156C813F6E8;
	Mon, 21 Dec 2015 19:10:46 -0700 (MST)
X-Mailer: git-send-email 2.6.3.368.gf34be46
In-Reply-To: <1450750180-1811-1-git-send-email-ischis2@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282829>

The todo section previously noted that documentation of shallow clones
was not in the manual and had references to the 1.5.0 release notes.

The patch adds a section to the manual and removes the entry in the
ToDo list.

Signed-off-by: Stephen P. Smith <ischis2@cox.net>
---

Notes:
    I considered adding a paragraph to each of several sections noting the
    issues with regard to clone, fetch, merge and push.
    
    After looking for other such notes and finding none in the
    manual I chose to not add the paragraphs.

 Documentation/user-manual.txt | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 1c790ac..15825e0 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -39,7 +39,6 @@ without any explanation.
 Finally, see <<todo>> for ways that you can help make this manual more
 complete.
 
-
 [[repositories-and-branches]]
 Repositories and Branches
 =========================
@@ -72,6 +71,25 @@ called the <<def_working_tree,working tree>>, together with a special
 top-level directory named `.git`, which contains all the information
 about the history of the project.
 
+[[how-to-get-a-git-repository-with-minimal-history]]
+How to get a Git repository with minimal history
+------------------------------------------------
+
+Sometimes there is a need to view recent history or send email patches
+for a project with lots of history. In such cases a <<def_shallow_clone,shallow
+clone>> can be used to create a <<def_shallow_repository,shallow
+repository>>.
+
+A <<def_shallow_clone,shallow clone>> is created by specifying the
+depth when creating a clone of a repository using the
+linkgit:git-clone[1] --depth switch.  The depth can later be changed
+by using the linkgit:git-fetch[1] --depth switch.
+
+------------------------------------------------
+	# the Linux kernel:
+$ git clone --depth=20 git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
+------------------------------------------------
+
 [[how-to-check-out]]
 How to check out a different version of a project
 -------------------------------------------------
@@ -4645,9 +4663,6 @@ standard end-of-chapter section?
 
 Include cross-references to the glossary, where appropriate.
 
-Document shallow clones?  See draft 1.5.0 release notes for some
-documentation.
-
 Add a section on working with other version control systems, including
 CVS, Subversion, and just imports of series of release tarballs.
 
-- 
2.6.3.368.gf34be46
