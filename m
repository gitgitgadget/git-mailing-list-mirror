From: Eric Lesh <eclesh@ucla.edu>
Subject: [GUILT PATCH 1/4] get_series: Remove comments from end of series lines
Date: Sun, 29 Jul 2007 00:50:15 -0700
Message-ID: <11856954183111-git-send-email-eclesh@ucla.edu>
References: <118569541814-git-send-email-eclesh@ucla.edu>
Cc: git@vger.kernel.org, Eric Lesh <eclesh@ucla.edu>
To: jsipek@cs.sunysb.edu
X-From: git-owner@vger.kernel.org Sun Jul 29 09:50:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IF3Xw-000795-Up
	for gcvg-git@gmane.org; Sun, 29 Jul 2007 09:50:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760086AbXG2Huc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jul 2007 03:50:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760083AbXG2Hub
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jul 2007 03:50:31 -0400
Received: from smtp-7.smtp.ucla.edu ([169.232.46.138]:43350 "EHLO
	smtp-7.smtp.ucla.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759714AbXG2Hua (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jul 2007 03:50:30 -0400
Received: from mail.ucla.edu (mail.ucla.edu [169.232.48.151])
	by smtp-7.smtp.ucla.edu (8.13.8/8.13.8) with ESMTP id l6T7oN54025896;
	Sun, 29 Jul 2007 00:50:23 -0700
Received: from localhost (adsl-75-26-192-134.dsl.scrm01.sbcglobal.net [75.26.192.134])
	(authenticated bits=0)
	by mail.ucla.edu (8.13.8/8.13.8) with ESMTP id l6T7oMT7005167
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 29 Jul 2007 00:50:23 -0700
Received: by localhost (Postfix, from userid 1000)
	id 9A6061E80A7; Sun, 29 Jul 2007 00:50:18 -0700 (PDT)
X-Mailer: git-send-email 1.5.2
In-Reply-To: <118569541814-git-send-email-eclesh@ucla.edu>
X-Probable-Spam: no
X-Spam-Report: none
X-Scanned-By: smtp.ucla.edu on 169.232.46.138
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54089>

Signed-off-by: Eric Lesh <eclesh@ucla.edu>

--
---
 guilt |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/guilt b/guilt
index f67bfb5..774909e 100755
--- a/guilt
+++ b/guilt
@@ -178,7 +178,8 @@ get_series()
 	#	- whitespace only
 	#	- optional whitespace followed by '#' followed by more
 	#	  optional whitespace
-	grep -ve '^[[:space:]]*\(#.*\)*$' "$series"
+	# also remove comments from end of lines
+	grep -ve '^[[:space:]]*\(#.*\)*$' < "$series" | sed -e 's/[[:space:]]*#.*$//'
 }
 
 # usage: do_make_header <hash>
-- 
1.5.2
