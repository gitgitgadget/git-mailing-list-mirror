From: "Jeffrey C. Ollie" <jeff@ocjtech.us>
Subject: [PATCH 2/2] Quiet the output from git-init when cloning, if requested.
Date: Thu,  7 Jun 2007 07:50:30 -0500
Message-ID: <11812206302958-git-send-email-jeff@ocjtech.us>
References: <11812206303473-git-send-email-jeff@ocjtech.us>
Cc: Git Mailing List <git@vger.kernel.org>,
	"Jeffrey C. Ollie" <jeff@ocjtech.us>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Jun 07 14:49:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwHQu-0007Gg-S4
	for gcvg-git@gmane.org; Thu, 07 Jun 2007 14:49:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755742AbXFGMta (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Jun 2007 08:49:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755608AbXFGMta
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jun 2007 08:49:30 -0400
Received: from homer.isunet.net ([63.175.164.9]:33095 "EHLO homer.isunet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753117AbXFGMt3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2007 08:49:29 -0400
Received: from localhost (localhost [127.0.0.1])
	by homer.isunet.net (Postfix) with ESMTP id 628D9388358;
	Thu,  7 Jun 2007 06:58:16 -0500 (CDT)
Received: from homer.isunet.net ([63.175.164.9])
 by localhost (homer [63.175.164.9]) (amavisd-new, port 10024) with ESMTP
 id 29170-09; Thu,  7 Jun 2007 06:58:15 -0500 (CDT)
Received: from max1.ocjtech.us (dsl-ppp239.isunet.net [63.175.164.239])
	by homer.isunet.net (Postfix) with ESMTP id 7810E388360;
	Thu,  7 Jun 2007 06:58:15 -0500 (CDT)
Received: from [161.210.6.122] (helo=lt21223.campus.dmacc.edu)
	by max1.ocjtech.us with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.62)
	(envelope-from <jeff@ocjtech.us>)
	id 1HwHQj-0002CC-Vr; Thu, 07 Jun 2007 07:49:34 -0500
Received: from localhost ([127.0.0.1] helo=localhost.localdomain)
	by lt21223.campus.dmacc.edu with esmtp (Exim 4.63)
	(envelope-from <jeff@ocjtech.us>)
	id 1HwHRe-0001Og-RV; Thu, 07 Jun 2007 07:50:30 -0500
X-Mailer: git-send-email 1.5.2.GIT
In-Reply-To: <11812206303473-git-send-email-jeff@ocjtech.us>
X-Virus-Scanned: by amavisd-new at isunet.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49365>

From: Jeffrey C. Ollie <jeff@ocjtech.us>

Now that git-init has an option to quiet itself, use it if the -q
option was specified on the clone command line.

Signed-off-by: Jeffrey C. Ollie <jeff@ocjtech.us>
---
 git-clone.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-clone.sh b/git-clone.sh
index fdd354f..4cc09e3 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -184,7 +184,7 @@ yes)
 	GIT_DIR="$D" ;;
 *)
 	GIT_DIR="$D/.git" ;;
-esac && export GIT_DIR && git-init ${template+"$template"} || usage
+esac && export GIT_DIR && git-init $quiet ${template+"$template"} || usage
 
 if test -n "$reference"
 then
-- 
1.5.2.GIT
