From: Richard Quirk <richard.quirk@gmail.com>
Subject: [PATCH] gitk: bind Key-Return to create on new branch dialog
Date: Tue, 14 Oct 2008 22:53:25 +0200
Message-ID: <1224017605-13893-1-git-send-email-richard.quirk@gmail.com>
Cc: git@vger.kernel.org, Richard Quirk <richard.quirk@gmail.com>
To: paulus@samba.org
X-From: git-owner@vger.kernel.org Tue Oct 14 22:55:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kpquj-0002iL-Ps
	for gcvg-git-2@gmane.org; Tue, 14 Oct 2008 22:54:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755301AbYJNUxd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Oct 2008 16:53:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755016AbYJNUxd
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Oct 2008 16:53:33 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:27023 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755288AbYJNUxc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Oct 2008 16:53:32 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1768779fgg.17
        for <git@vger.kernel.org>; Tue, 14 Oct 2008 13:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=RECY2rSwXEzCmagCLHn+obV34yfEm7uc0J7qzCktaFk=;
        b=ajCzdSVqaN6EXeur8rOv0PifkFl4XGc6WV1FTPLqfNHts2T459XCgvMSWwa42GXDJL
         Oqq7UyH5bcprTIf567ChaZeaGbcH8I9jkqfBMXZ7wAL4vIB66jPgao1sG8mSqBRCb4Wq
         94xW/6mjHkpHCjUWBbnirClyYho+Xbk6NEvHM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=G6ojVkSGiXPbamfRrrDdJS5ooVLDdfmEJrsDmhK93TpWCpBvadEhGTPhSQLkoSurcT
         T6b92+LjczCxBcFly7jiuwZUWLAzFnE/J1ujiRhV0cCT7Am0snx4YcN1N5OdsZRrPsmz
         WWDcFKmQ6QoVBs9V/hqKw8qSSnOPCEHajV+fs=
Received: by 10.180.235.10 with SMTP id i10mr15437bkh.58.1224017610247;
        Tue, 14 Oct 2008 13:53:30 -0700 (PDT)
Received: from localhost ([84.79.238.242])
        by mx.google.com with ESMTPS id d25sm7168563nfh.6.2008.10.14.13.53.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 14 Oct 2008 13:53:27 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.6.gc667
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98211>

The Return key can now be used as well as pressing the Create button
from the dialog box that is shown when selecting "Create new branch".

Signed-off-by: Richard Quirk <richard.quirk@gmail.com>
---
 gitk |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/gitk b/gitk
index 2eaa2ae..81d6c80 100755
--- a/gitk
+++ b/gitk
@@ -7590,6 +7590,7 @@ proc mkbranch {} {
     grid $top.id $top.sha1 -sticky w
     label $top.nlab -text [mc "Name:"]
     entry $top.name -width 40
+    bind $top.name <Key-Return> "[list mkbrgo $top]"
     grid $top.nlab $top.name -sticky w
     frame $top.buts
     button $top.buts.go -text [mc "Create"] -command [list mkbrgo $top]
-- 
1.6.0.6.gc667
