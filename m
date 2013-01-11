From: Chris Rorvick <chris@rorvick.com>
Subject: [PATCH 3/3] t9604: fixup for new cvsimport
Date: Thu, 10 Jan 2013 22:27:19 -0600
Message-ID: <1357878439-27500-4-git-send-email-chris@rorvick.com>
References: <1357878439-27500-1-git-send-email-chris@rorvick.com>
Cc: "Eric S. Raymond" <esr@thyrsus.com>,
	Chris Rorvick <chris@rorvick.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 11 05:29:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TtWEo-0004xE-Jq
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jan 2013 05:29:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753422Ab3AKE2j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jan 2013 23:28:39 -0500
Received: from mail-ia0-f169.google.com ([209.85.210.169]:34141 "EHLO
	mail-ia0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754193Ab3AKE2h (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jan 2013 23:28:37 -0500
Received: by mail-ia0-f169.google.com with SMTP id r4so1209953iaj.14
        for <git@vger.kernel.org>; Thu, 10 Jan 2013 20:28:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:sender:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=Ft2eMgvPGvQlfMLj61jJ4f7qWEvJqlaRM4tYbyWUGeg=;
        b=eoHpDabq26R7ajWj+JPuNggbOZtVEzVZaXYKwyFRa8fLse+s65hr4j4ican5ELjM4N
         Uux/zc/lRmgrsMBs8dQcP89UiZjQ/J5byi3LTnpwdFm/z6CWFMeQ3CoHu8zL71GBpAzK
         9nONqhRlAG7M1zaI5Meyj+h79EUWqczDqKmu3shQ0OaY1PJ/VrSwEPg4ofgROCDw+4/Z
         O6WiLT/lENhj+obZhtftfVh4DBdw7vP1mMSutIc4W3gFEQlOG+X8E9sbxa4Szzf+aBqP
         4ztHMeoXHi9Mvn9AdneK2zA4MLILy5nQV+P6j2iauM9qTdZE0fxehevxsae6XO73FE8S
         d/0A==
X-Received: by 10.50.104.232 with SMTP id gh8mr7722896igb.45.1357878517285;
        Thu, 10 Jan 2013 20:28:37 -0800 (PST)
Received: from marlin.localdomain ([70.131.98.170])
        by mx.google.com with ESMTPS id s20sm3793135igs.10.2013.01.10.20.28.35
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 10 Jan 2013 20:28:36 -0800 (PST)
X-Mailer: git-send-email 1.8.1.1.g220e17a
In-Reply-To: <1357878439-27500-1-git-send-email-chris@rorvick.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213178>

---
 t/t9604-cvsimport-timestamps.sh | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/t/t9604-cvsimport-timestamps.sh b/t/t9604-cvsimport-timestamps.sh
index 1fd5142..b1629b6 100755
--- a/t/t9604-cvsimport-timestamps.sh
+++ b/t/t9604-cvsimport-timestamps.sh
@@ -7,8 +7,7 @@ setup_cvs_test_repository t9604
 
 test_expect_success 'check timestamps are UTC (TZ=CST6CDT)' '
 
-	TZ=CST6CDT git cvsimport -p"-x" -C module-1 module &&
-	git cvsimport -p"-x" -C module-1 module &&
+	TZ=CST6CDT git cvsimport -C module-1 module &&
 	(
 		cd module-1 &&
 		git log --format="%s %ai"
@@ -42,7 +41,7 @@ test_expect_success 'check timestamps with author-specific timezones' '
 	user3=User Three <user3@domain.org> EST5EDT
 	user4=User Four <user4@domain.org> MST7MDT
 	EOF
-	git cvsimport -p"-x" -A cvs-authors -C module-2 module &&
+	git cvsimport -A cvs-authors -C module-2 module &&
 	(
 		cd module-2 &&
 		git log --format="%s %ai %an"
-- 
1.8.1.1.g220e17a
