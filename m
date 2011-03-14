From: Drew Northup <drew.northup@maine.edu>
Subject: [PATCH v2] Clarify: rebase exit leaves <branch> checked-out
Date: Mon, 14 Mar 2011 11:47:37 -0400
Message-ID: <1300117657.5129.41.camel@drew-northup.unet.maine.edu>
References: <7vtyf6hkpo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>,
	"Johannes E.Schindelin" <johannes.schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 14 16:48:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzA0R-0006QT-OU
	for gcvg-git-2@lo.gmane.org; Mon, 14 Mar 2011 16:48:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754515Ab1CNPsV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Mar 2011 11:48:21 -0400
Received: from basalt.its.maine.edu ([130.111.32.66]:50230 "EHLO
	basalt.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752154Ab1CNPsU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Mar 2011 11:48:20 -0400
Received: from [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e])
	by basalt.its.maine.edu (8.13.8/8.13.8) with ESMTP id p2EFlfrG003543
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 14 Mar 2011 11:47:46 -0400
In-Reply-To: <7vtyf6hkpo.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: basalt.its.maine.edu 1003; Body=6
	Fuz1=6 Fuz2=6
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: p2EFlfrG003543
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1300722468.28801@4cti6RbNJgA6Lh9qTpASWA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168994>

This change makes it clearer that while the change
to the history effected by executing
'git rebase master' and 'git rebase master topic'
(in the example given) will be the same the
implicit checkout of the second form will always
remain following the rebase.

Signed-off-by: Drew Northup <drew.northup@maine.edu>
---

This applies cleanly to both master and pu. Changed patch subject to
better match the amended contents.

 Documentation/git-rebase.txt |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 96680c8..ac35894 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -66,8 +66,9 @@ would be:
     D---E---F---G master
 ------------
 
-The latter form is just a short-hand of `git checkout topic`
-followed by `git rebase master`.
+*NOTE:* The latter form is just a short-hand of `git checkout topic`
+followed by `git rebase master`. When rebase exits `topic` will
+remain the checked-out branch.
 
 If the upstream branch already contains a change you have made (e.g.,
 because you mailed a patch which was applied upstream), then that commit
-- 
1.7.4
-- 
-Drew Northup
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
