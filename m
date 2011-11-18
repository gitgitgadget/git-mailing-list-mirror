From: Samuel Bronson <naesten@gmail.com>
Subject: [PATCH] git-gui: Set both 16x16 and 32x32 icons on X to pacify Xming.
Date: Fri, 18 Nov 2011 13:13:35 -0500
Message-ID: <1321640015-6663-1-git-send-email-naesten@gmail.com>
Cc: Pat Thoyts <patthoyts@users.sourceforge.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Samuel Bronson <naesten@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 18 19:14:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RRSxO-0003pS-Hu
	for gcvg-git-2@lo.gmane.org; Fri, 18 Nov 2011 19:14:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752955Ab1KRSOb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Nov 2011 13:14:31 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:37380 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751643Ab1KRSOa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Nov 2011 13:14:30 -0500
Received: by vcbfk1 with SMTP id fk1so3493682vcb.19
        for <git@vger.kernel.org>; Fri, 18 Nov 2011 10:14:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=nB7dM0ebh2Nd4NjpD6Hbh+a6/DIVtVdAIpWgAyyTtyM=;
        b=iI7t8AGycDL18O8UNtMka4J9vjsetpAOi27aaJvLYOMFZyVRdFS7taI4qpOgVoFWjX
         IJiQ16guR8HagHoTs4laEV+/O34JAocLtyx3UsMcoBYbOY33U0xocl63OJsVNwv2VZ8T
         r7VBJSW+9vAdfXyCuiYlYilHLpEpKtps1ji8c=
Received: by 10.52.74.162 with SMTP id u2mr4561648vdv.69.1321640069093;
        Fri, 18 Nov 2011 10:14:29 -0800 (PST)
Received: from hydrogen (207-172-114-83.c3-0.upd-ubr1.trpr-upd.pa.cable.rcn.com. [207.172.114.83])
        by mx.google.com with ESMTPS id r5sm1877317vdj.11.2011.11.18.10.14.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 18 Nov 2011 10:14:27 -0800 (PST)
Received: from naesten by hydrogen with local (Exim 4.76)
	(envelope-from <naesten@gmail.com>)
	id 1RRSxE-0001lG-OK; Fri, 18 Nov 2011 13:14:25 -0500
X-Mailer: git-send-email 1.7.6.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185671>

It would be better if the 32x32 icon was equivalent to the one used on
Windows (in git-gui.ico), but I'm not sure how that would best be done,
so I copied this code from gitk instead.
---
 git-gui.sh |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index c190cbe..9d01039 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -729,7 +729,12 @@ if {[is_Windows]} {
 		gitlogo put gray26  -to  5 15 11 16
 		gitlogo redither
 
-		wm iconphoto . -default gitlogo
+		# TODO: should use something equivalent to the 32x32 image in
+		# the .ico file
+		image create photo gitlogo32    -width 32 -height 32
+		gitlogo32 copy gitlogo -zoom 2 2
+
+		wm iconphoto . -default gitlogo gitlogo32
 	}
 }
 
-- 
1.7.6.3
