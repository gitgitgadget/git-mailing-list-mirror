From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH 2/3] cg-patch: Use optparse
Date: Tue, 7 Feb 2006 23:44:33 +0100
Message-ID: <20060207224433.GB24790@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 07 23:45:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F6baC-0003Cw-B1
	for gcvg-git@gmane.org; Tue, 07 Feb 2006 23:45:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030222AbWBGWoz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Feb 2006 17:44:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030221AbWBGWoy
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Feb 2006 17:44:54 -0500
Received: from mgw1.diku.dk ([130.225.96.91]:24779 "EHLO mgw1.diku.dk")
	by vger.kernel.org with ESMTP id S1030222AbWBGWof (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Feb 2006 17:44:35 -0500
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id BD2F752D5A3;
	Tue,  7 Feb 2006 23:44:34 +0100 (CET)
Received: from mgw1.diku.dk ([127.0.0.1])
 by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 19983-05; Tue,  7 Feb 2006 23:44:33 +0100 (CET)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id 359B252D5A2;
	Tue,  7 Feb 2006 23:44:33 +0100 (CET)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 358E86DFC1C; Tue,  7 Feb 2006 23:43:48 +0100 (CET)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 2407261AD6; Tue,  7 Feb 2006 23:44:33 +0100 (CET)
To: Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-Virus-Scanned: amavisd-new at diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15720>

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
---
commit 77defc166986330f4285db8faf206c1176a6c4ae
tree 293120fe428f40eab2422ed59d84e77aa1fa53a1
parent 5095aca7013d87ccdb08dad20a9fb93d7465d33d
author Jonas Fonseca <fonseca@diku.dk> Tue, 07 Feb 2006 23:07:32 +0100
committer Jonas Fonseca <fonseca@antimatter.localdomain> Tue, 07 Feb 2006 23:07:32 +0100

 cg-patch |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/cg-patch b/cg-patch
index 8be13be..90dfd30 100755
--- a/cg-patch
+++ b/cg-patch
@@ -70,10 +70,13 @@ redzone_border()
 
 
 reverse=
-if [ "${ARGS[0]}" = "-R" ]; then
-	reverse=1
-	shift
-fi
+while optparse; do
+	if optparse -R; then
+		reverse=1
+	else
+		optfail
+	fi
+done
 
 
 gonefile="$(mktemp -t gitapply.XXXXXX)"

-- 
Jonas Fonseca
