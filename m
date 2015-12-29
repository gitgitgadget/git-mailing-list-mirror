From: "Stephen P. Smith" <ischis2@cox.net>
Subject: [PATCH V5 2/2] user-manual: add section documenting shallow clones
Date: Tue, 29 Dec 2015 11:54:56 -0700
Message-ID: <1451415296-3960-1-git-send-email-ischis2@cox.net>
References: <xmqqfuymji50.fsf@gitster.mtv.corp.google.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	"Stephen P. Smith" <ischis2@cox.net>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 29 19:55:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aDzQK-0002b5-BG
	for gcvg-git-2@plane.gmane.org; Tue, 29 Dec 2015 19:55:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753711AbbL2SzE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Dec 2015 13:55:04 -0500
Received: from fed1rmfepo103.cox.net ([68.230.241.145]:44854 "EHLO
	fed1rmfepo103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753606AbbL2SzD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2015 13:55:03 -0500
Received: from fed1rmimpo210 ([68.230.241.161]) by fed1rmfepo103.cox.net
          (InterMail vM.8.01.05.15 201-2260-151-145-20131218) with ESMTP
          id <20151229185501.PZTA11111.fed1rmfepo103.cox.net@fed1rmimpo210>
          for <git@vger.kernel.org>; Tue, 29 Dec 2015 13:55:01 -0500
Received: from thunderbird ([68.231.74.134])
	by fed1rmimpo210 with cox
	id zWv11r0052tqoqC01Wv1iD; Tue, 29 Dec 2015 13:55:01 -0500
X-CT-Class: Clean
X-CT-Score: 0.00
X-CT-RefID: str=0001.0A020202.5682D705.00FB,ss=1,re=0.000,fgs=0
X-CT-Spam: 0
X-Authority-Analysis: v=2.0 cv=Hq2o7TvS c=1 sm=1
 a=/Rt4pg3TtX3KzfzhvVoEow==:17 a=kviXuzpPAAAA:8 a=wUQvQvOEmiQA:10
 a=TSbVqHtbAAAA:8 a=zGAwCBeI_n6qoTXIpA4A:9 a=/Rt4pg3TtX3KzfzhvVoEow==:117
X-CM-Score: 0.00
Authentication-Results: cox.net; none
Received: from thunderbird.smith.home (thunderbird [127.0.0.1])
	by thunderbird (Postfix) with ESMTP id F333013F6E8;
	Tue, 29 Dec 2015 11:55:00 -0700 (MST)
X-Mailer: git-send-email 2.7.0-rc2
In-Reply-To: <xmqqfuymji50.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283143>

Rather than merely pointing readers at the 1.5 release notes to
learn about shallow clones, document them formally.

Signed-off-by: Stephen P. Smith <ischis2@cox.net>
---

Notes:
    Added a paragraph about the fundamental limitation with merging
    histories that do not have a merge base in the shallow repository.
    
    The review comment implied that since the first two limitations have
    been lifted they would not need to be noted [1].
    
    [1] http://article.gmane.org/gmane.comp.version-control.git/283052

 Documentation/user-manual.txt | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 1c790ac..78f878d 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -2128,6 +2128,25 @@ The gitweb cgi script provides users an easy way to browse your
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
+as the merge base is in the resent history.  If the merge base is not
+present then the merge would be of un-related histories.  This
+limitaion is fundamental and will not be removed.
+
 [[sharing-development-examples]]
 Examples
 --------
@@ -4645,9 +4664,6 @@ standard end-of-chapter section?
 
 Include cross-references to the glossary, where appropriate.
 
-Document shallow clones?  See draft 1.5.0 release notes for some
-documentation.
-
 Add a section on working with other version control systems, including
 CVS, Subversion, and just imports of series of release tarballs.
 
-- 
2.7.0-rc2
