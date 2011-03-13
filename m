From: Drew Northup <drew.northup@maine.edu>
Subject: [PATCH] Clarify: rebase abort leaves <branch> checked-out
Date: Sun, 13 Mar 2011 12:54:18 -0400
Message-ID: <1300035258.5129.12.camel@drew-northup.unet.maine.edu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>,
	"Johannes E. Schindelin" <johannes.schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 13 18:03:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pyoh8-0008SJ-7s
	for gcvg-git-2@lo.gmane.org; Sun, 13 Mar 2011 18:03:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755311Ab1CMRDA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Mar 2011 13:03:00 -0400
Received: from basalt.its.maine.edu ([130.111.32.66]:44068 "EHLO
	basalt.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752189Ab1CMRDA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Mar 2011 13:03:00 -0400
Received: from [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e])
	by basalt.its.maine.edu (8.13.8/8.13.8) with ESMTP id p2DGsMLm022530
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 13 Mar 2011 12:54:27 -0400
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: basalt.its.maine.edu 1003; Body=8
	Fuz1=8 Fuz2=8
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: p2DGsMLm022530
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1300640177.76814@oYbMcOJM2EJ0up0ZukCwdw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168970>

This change makes it clearer that while the change
to the history effected by executing
'git rebase master' and 'git rebase master topic'
(in the example given) will be the same the
implicit checkout of the second form will not be
undone even if the rebase operation itself is
aborted.

Signed-off-by: Drew Northup <drew.northup@maine.edu>
---
 Documentation/git-rebase.txt |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 96680c8..4e2411a 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -66,8 +66,9 @@ would be:
     D---E---F---G master
 ------------
 
-The latter form is just a short-hand of `git checkout topic`
-followed by `git rebase master`.
+*NOTE:* The latter form is just a short-hand of `git checkout topic`
+followed by `git rebase master`. If the rebase is aborted `topic` will 
+remain the checked-out branch.
 
 If the upstream branch already contains a change you have made (e.g.,
 because you mailed a patch which was applied upstream), then that commit
-- 
1.6.4
-- 
-Drew Northup
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
