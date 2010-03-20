From: Benjamin C Meyer <bmeyer@rim.com>
Subject: [PATCH 2/4] pull: use --quiet rather than 2>/dev/null
Date: Fri, 19 Mar 2010 22:18:36 -0400
Message-ID: <1269051518-25099-2-git-send-email-bmeyer@rim.com>
References: <1269051518-25099-1-git-send-email-bmeyer@rim.com>
Cc: Benjamin C Meyer <bmeyer@rim.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 20 03:19:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsoHW-0003E6-Eh
	for gcvg-git-2@lo.gmane.org; Sat, 20 Mar 2010 03:19:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751995Ab0CTCTF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Mar 2010 22:19:05 -0400
Received: from qmta01.westchester.pa.mail.comcast.net ([76.96.62.16]:44977
	"EHLO qmta01.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751867Ab0CTCSy (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Mar 2010 22:18:54 -0400
Received: from omta01.westchester.pa.mail.comcast.net ([76.96.62.11])
	by qmta01.westchester.pa.mail.comcast.net with comcast
	id vCUe1d0050EZKEL51EJu0L; Sat, 20 Mar 2010 02:18:54 +0000
Received: from localhost.localdomain ([71.192.50.29])
	by omta01.westchester.pa.mail.comcast.net with comcast
	id vEJo1d00g0dnthT3MEJuPC; Sat, 20 Mar 2010 02:18:54 +0000
X-Mailer: git-send-email 1.7.0.2
In-Reply-To: <1269051518-25099-1-git-send-email-bmeyer@rim.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142672>

Signed-off-by: Benjamin C Meyer <bmeyer@rim.com>
---
 git-pull.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-pull.sh b/git-pull.sh
index d45b50c..08dac0a 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -206,7 +206,7 @@ test true = "$rebase" && {
 	. git-parse-remote &&
 	remoteref="$(get_remote_merge_branch "$@" 2>/dev/null)" &&
 	oldremoteref="$(git rev-parse -q --verify "$remoteref")" &&
-	for reflog in $(git rev-list -g $remoteref 2>/dev/null)
+	for reflog in $(git rev-list --quiet -g $remoteref)
 	do
 		if test "$reflog" = "$(git merge-base $reflog $curr_branch)"
 		then
-- 
1.7.0.2
