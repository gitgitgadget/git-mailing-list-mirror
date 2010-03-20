From: Benjamin C Meyer <bmeyer@rim.com>
Subject: [PATCH 3/4] rebase: use --quiet rather than 2>/dev/null
Date: Fri, 19 Mar 2010 22:18:37 -0400
Message-ID: <1269051518-25099-3-git-send-email-bmeyer@rim.com>
References: <1269051518-25099-1-git-send-email-bmeyer@rim.com>
Cc: Benjamin C Meyer <bmeyer@rim.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 20 03:19:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsoHX-0003E6-0t
	for gcvg-git-2@lo.gmane.org; Sat, 20 Mar 2010 03:19:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752100Ab0CTCTG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Mar 2010 22:19:06 -0400
Received: from qmta02.westchester.pa.mail.comcast.net ([76.96.62.24]:33062
	"EHLO qmta02.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751944Ab0CTCSy (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Mar 2010 22:18:54 -0400
Received: from omta01.westchester.pa.mail.comcast.net ([76.96.62.11])
	by qmta02.westchester.pa.mail.comcast.net with comcast
	id vCc41d0010EZKEL52EJuaW; Sat, 20 Mar 2010 02:18:54 +0000
Received: from localhost.localdomain ([71.192.50.29])
	by omta01.westchester.pa.mail.comcast.net with comcast
	id vEJo1d00g0dnthT3MEJuPJ; Sat, 20 Mar 2010 02:18:54 +0000
X-Mailer: git-send-email 1.7.0.2
In-Reply-To: <1269051518-25099-1-git-send-email-bmeyer@rim.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142673>

Signed-off-by: Benjamin C Meyer <bmeyer@rim.com>
---
 git-rebase.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index fb4fef7..bf93019 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -101,7 +101,7 @@ call_merge () {
 	cmt="$(cat "$dotest/cmt.$1")"
 	echo "$cmt" > "$dotest/current"
 	hd=$(git rev-parse --verify HEAD)
-	cmt_name=$(git symbolic-ref HEAD 2> /dev/null || echo HEAD)
+	cmt_name=$(git symbolic-ref --quiet HEAD || echo HEAD)
 	msgnum=$(cat "$dotest/msgnum")
 	end=$(cat "$dotest/end")
 	eval GITHEAD_$cmt='"${cmt_name##refs/heads/}~$(($end - $msgnum))"'
-- 
1.7.0.2
