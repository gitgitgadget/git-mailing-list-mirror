From: "Stephen P. Smith" <ischis2@cox.net>
Subject: [PATCH V6 2/2] user-manual: add section documenting shallow clones
Date: Tue, 29 Dec 2015 16:31:14 -0700
Message-ID: <1451431874-7310-1-git-send-email-ischis2@cox.net>
References: <xmqqd1tog88a.fsf@gitster.mtv.corp.google.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	"Stephen P. Smith" <ischis2@cox.net>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 30 00:31:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aE3jj-00036N-4y
	for gcvg-git-2@plane.gmane.org; Wed, 30 Dec 2015 00:31:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753904AbbL2XbY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Dec 2015 18:31:24 -0500
Received: from fed1rmfepo201.cox.net ([68.230.241.146]:33736 "EHLO
	fed1rmfepo201.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752951AbbL2XbW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2015 18:31:22 -0500
Received: from fed1rmimpo305 ([68.230.241.173]) by fed1rmfepo201.cox.net
          (InterMail vM.8.01.05.15 201-2260-151-145-20131218) with ESMTP
          id <20151229233121.SDHW5597.fed1rmfepo201.cox.net@fed1rmimpo305>
          for <git@vger.kernel.org>; Tue, 29 Dec 2015 18:31:21 -0500
Received: from thunderbird ([68.231.74.134])
	by fed1rmimpo305 with cox
	id zbXM1r0052tqoqC01bXMbv; Tue, 29 Dec 2015 18:31:21 -0500
X-CT-Class: Clean
X-CT-Score: 0.00
X-CT-RefID: str=0001.0A020202.568317C9.0121,ss=1,re=0.000,fgs=0
X-CT-Spam: 0
X-Authority-Analysis: v=2.0 cv=f8aW8pOM c=1 sm=1
 a=/Rt4pg3TtX3KzfzhvVoEow==:17 a=kviXuzpPAAAA:8 a=wUQvQvOEmiQA:10
 a=a-mmkxGj_Wl2OYgx35IA:9 a=/Rt4pg3TtX3KzfzhvVoEow==:117
X-CM-Score: 0.00
Authentication-Results: cox.net; none
Received: from thunderbird.smith.home (thunderbird [127.0.0.1])
	by thunderbird (Postfix) with ESMTP id 1CD821402B9;
	Tue, 29 Dec 2015 16:31:22 -0700 (MST)
X-Mailer: git-send-email 2.7.0-rc2
In-Reply-To: <xmqqd1tog88a.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283158>

Signed-off-by: Stephen P. Smith <ischis2@cox.net>
---
 Documentation/user-manual.txt | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 1c790ac..15e97d3 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -2128,6 +2128,26 @@ The gitweb cgi script provides users an easy way to browse your
 project's files and history without having to install Git; see the file
 gitweb/INSTALL in the Git source tree for instructions on setting it up.
 
+[[how-to-get-a-git-repository-with-minimal-history]]
+How to get a Git repository with minimal history
+------------------------------------------------
+
+A <<def_shallow_clone,shallow clone>>, with its truncated
+history, is useful when one is interested only in recent history
+of a project and getting full history from the upstream is
+expensive.
+
+A <<def_shallow_clone,shallow clone>> is created by specifying
+the linkgit:git-clone[1] `--depth` switch. The depth can later be
+changed with the linkgit:git-fetch[1] `--depth` switch, or full
+history restored with `--unshallow`.
+
+Merging inside a <<def_shallow_clone,shallow clone>> will work as long
+as the merge base is in the recent history.
+Otherwise, it will be like merging unrelated histories and may
+have to result in huge conflicts.  This limitation may make such
+a repository unsuitable to be used in merge based workflows.
+
 [[sharing-development-examples]]
 Examples
 --------
@@ -4645,9 +4665,6 @@ standard end-of-chapter section?
 
 Include cross-references to the glossary, where appropriate.
 
-Document shallow clones?  See draft 1.5.0 release notes for some
-documentation.
-
 Add a section on working with other version control systems, including
 CVS, Subversion, and just imports of series of release tarballs.
 
-- 
2.7.0-rc2
