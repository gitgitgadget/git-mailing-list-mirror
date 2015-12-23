From: "Stephen P. Smith" <ischis2@cox.net>
Subject: [PATCH V3 2/2] user-manual: add section documenting shallow clones
Date: Tue, 22 Dec 2015 20:53:47 -0700
Message-ID: <1450842827-14115-1-git-send-email-ischis2@cox.net>
References: <CAPig+cQOAGzQMj5oNMEsD0u7Wqj80kyyYcOwi-Y0q1yHtX4s4A@mail.gmail.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	"Stephen P. Smith" <ischis2@cox.net>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 23 04:53:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aBaUF-00015J-1G
	for gcvg-git-2@plane.gmane.org; Wed, 23 Dec 2015 04:53:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755269AbbLWDxH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Dec 2015 22:53:07 -0500
Received: from fed1rmfepo202.cox.net ([68.230.241.147]:41534 "EHLO
	fed1rmfepo202.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755192AbbLWDxF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Dec 2015 22:53:05 -0500
Received: from fed1rmimpo306 ([68.230.241.174]) by fed1rmfepo202.cox.net
          (InterMail vM.8.01.05.15 201-2260-151-145-20131218) with ESMTP
          id <20151223035304.VBLV22785.fed1rmfepo202.cox.net@fed1rmimpo306>
          for <git@vger.kernel.org>; Tue, 22 Dec 2015 22:53:04 -0500
Received: from thunderbird ([68.231.74.134])
	by fed1rmimpo306 with cox
	id wrt41r0012tqoqC01rt4Yt; Tue, 22 Dec 2015 22:53:04 -0500
X-CT-Class: Clean
X-CT-Score: 0.00
X-CT-RefID: str=0001.0A020206.567A1AA0.0051,ss=1,re=0.000,fgs=0
X-CT-Spam: 0
X-Authority-Analysis: v=2.0 cv=LKq4tuq9 c=1 sm=1
 a=/Rt4pg3TtX3KzfzhvVoEow==:17 a=kviXuzpPAAAA:8 a=wUQvQvOEmiQA:10
 a=1PfJBRKZKCHrU5mnAFQA:9 a=/Rt4pg3TtX3KzfzhvVoEow==:117
X-CM-Score: 0.00
Authentication-Results: cox.net; none
Received: from thunderbird.smith.home (thunderbird [127.0.0.1])
	by thunderbird (Postfix) with ESMTP id F122113F63A;
	Tue, 22 Dec 2015 20:53:53 -0700 (MST)
X-Mailer: git-send-email 2.6.3.368.gf34be46
In-Reply-To: <CAPig+cQOAGzQMj5oNMEsD0u7Wqj80kyyYcOwi-Y0q1yHtX4s4A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282921>

Rather than merely pointing readers at the 1.5 release notes to
learn about shallow clones, document them formally.

Signed-off-by: Stephen P. Smith <ischis2@cox.net>
---
 Documentation/user-manual.txt | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 1c790ac..bdfe984 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -2128,6 +2128,24 @@ The gitweb cgi script provides users an easy way to browse your
 project's files and history without having to install Git; see the file
 gitweb/INSTALL in the Git source tree for instructions on setting it up.
 
+[[how-to-get-a-git-repository-with-minimal-history]]
+How to get a Git repository with minimal history
+------------------------------------------------
+
+A <<def_shallow_clone,shallow clone>> is useful when the recent
+history of a project is needed and getting real history recorded in
+the upstream is expensive. The resultant cloned <<def_repository,repository>>
+has truncated history. This clone could be used to look at history
+near the tip of a branch and contribute email patches to the project.
+
+A <<def_shallow_clone,shallow clone>> is created by specifying the
+depth when creating a clone of a repository using the
+linkgit:git-clone[1] `--depth` switch.  The depth can later be changed
+by using the linkgit:git-fetch[1] `--depth` switch.  If there is later
+a need to fetch the entire history and if the source repository is
+complete, the linkgit:git-fetch[1] `--unshallow` switch can be used to
+convert a shallow repository to a complete one.
+
 [[sharing-development-examples]]
 Examples
 --------
@@ -4645,9 +4663,6 @@ standard end-of-chapter section?
 
 Include cross-references to the glossary, where appropriate.
 
-Document shallow clones?  See draft 1.5.0 release notes for some
-documentation.
-
 Add a section on working with other version control systems, including
 CVS, Subversion, and just imports of series of release tarballs.
 
-- 
2.6.3.368.gf34be46
