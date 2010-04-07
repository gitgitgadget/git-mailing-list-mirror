From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH] Documentation/SubmittingPatches: Clarify Gmail section
Date: Thu,  8 Apr 2010 01:03:13 +0530
Message-ID: <1270668793-2187-2-git-send-email-artagnon@gmail.com>
References: <1270668793-2187-1-git-send-email-artagnon@gmail.com>
Cc: Git Mailing List <git@vger.kernel.org>,
	John Tapsell <johnflux@gmail.com>,
	Aaron Crane <git@aaroncrane.co.uk>,
	A Large Angry SCM <gitzilla@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 07 21:36:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nzb2n-0000ON-Sr
	for gcvg-git-2@lo.gmane.org; Wed, 07 Apr 2010 21:36:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751038Ab0DGTgE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Apr 2010 15:36:04 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:53007 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750948Ab0DGTgB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Apr 2010 15:36:01 -0400
Received: by mail-pw0-f46.google.com with SMTP id 9so1324551pwj.19
        for <git@vger.kernel.org>; Wed, 07 Apr 2010 12:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=5hIwLtLkekSOg/Yr5/wy5AaYFI3g8An9vY0kBFTBPA8=;
        b=rSTOpUxejnajs99M2+VSTcOGzWjWYt58i3WcoiLfEtQ3CFvAlRivVFl7dDz6McCZGg
         QoAJWzUb6/hCoAhpm/0FCritAJNeH/R+MFo5IAjVVxK7h5Xj/wW8urtFTxISzr1iAFhm
         J+MkRVFtu+TfcgX3lC+lHIlSh7ezu2mD6UfFQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=KIvqG3oUbOLF1AN+kmWSmqO9o3J7Aar813gwNLXfOYCoJLMnEWfCI8wVwyWzD0ffRr
         PEXSF5ddySu5AF/55Znj/kwhCzi5qu51FvAR1yu1NCj61tUnFjtyf59cy4hO5sp4I/0Q
         bkc7K4zoWJrCzCovlpXQOM0LfcdLz5NOM3bUc=
Received: by 10.140.56.18 with SMTP id e18mr8071810rva.167.1270668961069;
        Wed, 07 Apr 2010 12:36:01 -0700 (PDT)
Received: from localhost.localdomain ([203.110.244.110])
        by mx.google.com with ESMTPS id j42sm385492ibr.7.2010.04.07.12.35.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 07 Apr 2010 12:36:00 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.3
In-Reply-To: <1270668793-2187-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144276>

The web interface mangles patches no matter what. Replace paragraph
about "git imap-send" with another one about "git send-email".

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/SubmittingPatches |   53 +++++++++++++++-----------------------
 1 files changed, 21 insertions(+), 32 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index c686f86..8193a5b 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -517,35 +517,24 @@ message, complete the addressing and subject fields, and press send.
 Gmail
 -----
 
-GMail does not appear to have any way to turn off line wrapping in the web
-interface, so this will mangle any emails that you send.  You can however
-use any IMAP email client to connect to the google imap server, and forward
-the emails through that.  Just make sure to disable line wrapping in that
-email client.  Alternatively, use "git send-email" instead.
-
-Submitting properly formatted patches via Gmail is simple now that
-IMAP support is available. First, edit your ~/.gitconfig to specify your
-account settings:
-
-[imap]
-	folder = "[Gmail]/Drafts"
-	host = imaps://imap.gmail.com
-	user = user@gmail.com
-	pass = p4ssw0rd
-	port = 993
-	sslverify = false
-
-You might need to instead use: folder = "[Google Mail]/Drafts" if you get an error
-that the "Folder doesn't exist".
-
-Next, ensure that your Gmail settings are correct. In "Settings" the
-"Use Unicode (UTF-8) encoding for outgoing messages" should be checked.
-
-Once your commits are ready to send to the mailing list, run the following
-command to send the patch emails to your Gmail Drafts folder.
-
-	$ git format-patch -M --stdout origin/master | git imap-send
-
-Go to your Gmail account, open the Drafts folder, find the patch email, fill
-in the To: and CC: fields and send away!
-
+GMail does not have any way to turn off line wrapping in the web
+interface, so this will mangle any emails that you send.  You can
+either configure an email client that that doesn't break lines to use
+the GMail SMTP server, or use "git send-email" to achieve the same
+effect.
+
+To use "git send-email", edit ~/.gitconfig to specify your account
+settings:
+
+[sendemail]
+	smtpencryption = tls
+	smtpserver = smtp.gmail.com
+	smtpuser = user@gmail.com
+	smtppass = p4ssw0rd
+	smtpserverport = 587
+
+Once your commits are ready to send to the mailing list, run the
+following commands:
+
+	$ git format-patch --no-color -C -M origin/master -o outgoing/
+	$ git send-email --compose outgoing/*
-- 
1.7.0.3
