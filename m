From: Chris Rorvick <chris@rorvick.com>
Subject: [PATCH 2/3] t9600: fixup for new cvsimport
Date: Thu, 10 Jan 2013 22:27:18 -0600
Message-ID: <1357878439-27500-3-git-send-email-chris@rorvick.com>
References: <1357878439-27500-1-git-send-email-chris@rorvick.com>
Cc: "Eric S. Raymond" <esr@thyrsus.com>,
	Chris Rorvick <chris@rorvick.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 11 05:29:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TtWEo-0004xE-4y
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jan 2013 05:29:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754258Ab3AKE2h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jan 2013 23:28:37 -0500
Received: from mail-ie0-f178.google.com ([209.85.223.178]:48958 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753422Ab3AKE2g (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jan 2013 23:28:36 -0500
Received: by mail-ie0-f178.google.com with SMTP id c12so1807905ieb.23
        for <git@vger.kernel.org>; Thu, 10 Jan 2013 20:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:sender:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=1xTAazlJ8Vpsdedq4VCV/2bn50FINvuseF0roQj1bgQ=;
        b=dSIsLRCzHZ1MA4gmVI9mY5Oz2Hos+D2AjGLtoc1KsS2W4Bu/UL+HYFqzikU1hgZvq8
         DF+TLyDcAUB+25K2/L2EIaixRx3m8ZS2WiB2g5eL2f6k7jOzX9qEoxs96DnSWD16vD58
         z06JKhptV/OdQT5vslyBOWPBFCyCzR2fV92PWns8CVANJ+ZplkpESgle8hN1cwafndxN
         KdSWc6OW2FH/HYOECOZlCgSxkNg3nvdH9S3bXV5SBnPlejUd4OLFOneo+6n6/LqGNeAR
         ZYPux58EgHleqCH6q205tDfuyN8KGdD4s7H9J/SdmuiITh2mC4juAbdUph6DtKDReu1Y
         mHJQ==
X-Received: by 10.50.196.164 with SMTP id in4mr7562586igc.86.1357878515742;
        Thu, 10 Jan 2013 20:28:35 -0800 (PST)
Received: from marlin.localdomain ([70.131.98.170])
        by mx.google.com with ESMTPS id s20sm3793135igs.10.2013.01.10.20.28.34
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 10 Jan 2013 20:28:35 -0800 (PST)
X-Mailer: git-send-email 1.8.1.1.g220e17a
In-Reply-To: <1357878439-27500-1-git-send-email-chris@rorvick.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213177>

---
 t/t9600-cvsimport.sh | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/t/t9600-cvsimport.sh b/t/t9600-cvsimport.sh
index 4c384ff..14f54d5 100755
--- a/t/t9600-cvsimport.sh
+++ b/t/t9600-cvsimport.sh
@@ -44,7 +44,7 @@ EOF
 
 test_expect_success PERL 'import a trivial module' '
 
-	git cvsimport -a -R -z 0 -C module-git module &&
+	git cvsimport -R -z 0 -C module-git module &&
 	test_cmp module-cvs/o_fortuna module-git/o_fortuna
 
 '
@@ -90,8 +90,7 @@ test_expect_success PERL 'update git module' '
 
 	(cd module-git &&
 	git config cvsimport.trackRevisions true &&
-	git cvsimport -a -z 0 module &&
-	git merge origin
+	git cvsimport -z 0 module
 	) &&
 	test_cmp module-cvs/o_fortuna module-git/o_fortuna
 
@@ -119,8 +118,7 @@ test_expect_success PERL 'cvsimport.module config works' '
 	(cd module-git &&
 		git config cvsimport.module module &&
 		git config cvsimport.trackRevisions true &&
-		git cvsimport -a -z0 &&
-		git merge origin
+		git cvsimport -z0
 	) &&
 	test_cmp module-cvs/tick module-git/tick
 
@@ -140,7 +138,7 @@ test_expect_success PERL 'import from a CVS working tree' '
 	$CVS co -d import-from-wt module &&
 	(cd import-from-wt &&
 		git config cvsimport.trackRevisions false &&
-		git cvsimport -a -z0 &&
+		git cvsimport -z0 &&
 		echo 1 >expect &&
 		git log -1 --pretty=format:%s%n >actual &&
 		test_cmp actual expect
-- 
1.8.1.1.g220e17a
