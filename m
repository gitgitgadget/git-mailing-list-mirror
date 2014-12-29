From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: [PATCH v3] send-email: Improve format of smtp initialization error message
Date: Mon, 29 Dec 2014 23:53:21 +0600
Message-ID: <1419875601-20836-1-git-send-email-kuleshovmail@gmail.com>
Cc: git@vger.kernel.org, Thomas Gummerer <t.gummerer@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Alexander Kuleshov <kuleshovmail@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 29 18:53:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y5eVf-0003Lr-3C
	for gcvg-git-2@plane.gmane.org; Mon, 29 Dec 2014 18:53:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752125AbaL2Rxe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Dec 2014 12:53:34 -0500
Received: from mail-lb0-f169.google.com ([209.85.217.169]:36308 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752115AbaL2Rxe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Dec 2014 12:53:34 -0500
Received: by mail-lb0-f169.google.com with SMTP id p9so11369457lbv.0
        for <git@vger.kernel.org>; Mon, 29 Dec 2014 09:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=319v3OWkWr9xVjWI4bUWkEIAzCAnP0/wUnT1w7aogGc=;
        b=eHWwhK4bXyNnYDCNdiFdXYJTJ22J5Zbed1JiFSf2sn6Q63B3FX4bCypmVkuX9OE3ER
         amOACU6HEN+07QUCvxNMdHNwkKp7fyVsYCWfr9AcMGXVX8325WyjpBfLWPZ94TzmzeXw
         Js6lYJKclPBruv0pISqAJFxROW2Agkg25fCpFBs571E4L4E03PkpePwxJS7qBURliPw9
         QmfTf+6CxaF0kyjSaDR/TBicM0hz6NKFI+eIbg6SVDOGYHOHKUaz7XDm7efmDCDPiYQ/
         a+sgH2ofM1wuJugT71HFxcWCpVUvL4yI8FhV33Upl6rjrN6eygzOYB93fsT6pcyQOU7r
         Fd8Q==
X-Received: by 10.152.36.37 with SMTP id n5mr56341308laj.27.1419875612886;
        Mon, 29 Dec 2014 09:53:32 -0800 (PST)
Received: from localhost.localdomain ([92.46.101.129])
        by mx.google.com with ESMTPSA id v4sm10082857lav.25.2014.12.29.09.53.30
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 29 Dec 2014 09:53:32 -0800 (PST)
X-Mailer: git-send-email 2.2.1.202.g44ae4ee
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261868>

Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
---
 git-send-email.perl | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 82c6fea..60dcd8d 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1275,10 +1275,10 @@ X-Mailer: git-send-email $gitversion
 
 		if (!$smtp) {
 			die "Unable to initialize SMTP properly. Check config and use --smtp-debug. ",
-			    "VALUES: server=$smtp_server ",
-			    "encryption=$smtp_encryption ",
-			    "hello=$smtp_domain",
-			    defined $smtp_server_port ? " port=$smtp_server_port" : "";
+			    "\nVALUES: \n\tserver=$smtp_server ",
+			    "\n\tencryption=$smtp_encryption ",
+			    "\n\thello=$smtp_domain",
+			    defined $smtp_server_port ? " \n\tport=$smtp_server_port" : "";
 		}
 
 		smtp_auth_maybe or die $smtp->message;
-- 
2.2.1.201.gbbcefff.dirty
