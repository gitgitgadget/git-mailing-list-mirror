From: "Stephen P. Smith" <ischis2@cox.net>
Subject: [PATCH V7 2/2] user-manual: add section documenting shallow clones
Date: Tue, 29 Dec 2015 17:03:50 -0700
Message-ID: <1451433830-7680-1-git-send-email-ischis2@cox.net>
References: <xmqq8u4cg6y8.fsf@gitster.mtv.corp.google.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	"Stephen P. Smith" <ischis2@cox.net>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 30 01:04:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aE4FL-0004A4-6d
	for gcvg-git-2@plane.gmane.org; Wed, 30 Dec 2015 01:04:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754019AbbL3AEB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Dec 2015 19:04:01 -0500
Received: from fed1rmfepo101.cox.net ([68.230.241.143]:56753 "EHLO
	fed1rmfepo101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754007AbbL3ADz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2015 19:03:55 -0500
Received: from fed1rmimpo110 ([68.230.241.159]) by fed1rmfepo101.cox.net
          (InterMail vM.8.01.05.15 201-2260-151-145-20131218) with ESMTP
          id <20151230000354.ZMWV331.fed1rmfepo101.cox.net@fed1rmimpo110>
          for <git@vger.kernel.org>; Tue, 29 Dec 2015 19:03:54 -0500
Received: from thunderbird ([68.231.74.134])
	by fed1rmimpo110 with cox
	id zc3u1r0072tqoqC01c3uEi; Tue, 29 Dec 2015 19:03:54 -0500
X-CT-Class: Clean
X-CT-Score: 0.00
X-CT-RefID: str=0001.0A020206.56831F6A.00BC,ss=1,re=0.000,fgs=0
X-CT-Spam: 0
X-Authority-Analysis: v=2.0 cv=B55nJpRM c=1 sm=1
 a=/Rt4pg3TtX3KzfzhvVoEow==:17 a=kviXuzpPAAAA:8 a=wUQvQvOEmiQA:10
 a=a-mmkxGj_Wl2OYgx35IA:9 a=/Rt4pg3TtX3KzfzhvVoEow==:117
X-CM-Score: 0.00
Authentication-Results: cox.net; none
Received: from thunderbird.smith.home (thunderbird [127.0.0.1])
	by thunderbird (Postfix) with ESMTP id 2C8481402B9;
	Tue, 29 Dec 2015 17:03:55 -0700 (MST)
X-Mailer: git-send-email 2.7.0-rc2
In-Reply-To: <xmqq8u4cg6y8.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283160>

Signed-off-by: Stephen P. Smith <ischis2@cox.net>
---
 Documentation/user-manual.txt | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 1c790ac..ce347ff 100644
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
+as a merge base is in the recent history.
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
