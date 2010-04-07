From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH] Documentation/SubmittingPatches: Clarify Gmail section
Date: Wed, 7 Apr 2010 23:22:28 +0530
Message-ID: <s2kf3271551004071052o58656534z80de5068b207bdb2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: John Tapsell <johnflux@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	A Large Angry SCM <gitzilla@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 07 19:52:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzZQt-0002sk-UA
	for gcvg-git-2@lo.gmane.org; Wed, 07 Apr 2010 19:52:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754900Ab0DGRwu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Apr 2010 13:52:50 -0400
Received: from mail-yw0-f172.google.com ([209.85.211.172]:57667 "EHLO
	mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756503Ab0DGRwt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Apr 2010 13:52:49 -0400
Received: by ywh2 with SMTP id 2so685300ywh.33
        for <git@vger.kernel.org>; Wed, 07 Apr 2010 10:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:received
         :message-id:subject:to:cc:content-type;
        bh=cEYzg++LfLyf7l+Ivgw9e9mXr1+GJ0yAoKz6UE0ZNZo=;
        b=ga6erl1FR0du9k6s89V45ll5+kTd3X9GPT/uI2rr9jDTZOTYJng8f73yZB16q/NiIZ
         XkASzJkO556yDYL47p1QDhIvQE21hbwnWyaqxRgu29E7+ZZ7th/iMtP7zIubzEdx+h/4
         hOyEwwxzyXZMA4eZ7Tf/2VLTcipUbm6HW4Y54=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        b=e0oAoExOUiSlgxWJKxOwLI4x72JC36SbfbzUYFrOIwfKy/VyDkvtmPz1Oy4jqVaxKj
         DLpsOxiFUpOGZAwi+guF6OGBT2DGDZFM2LIiCCTFnlWBm/QAX/Veyzs5Ho9CxnnTlh0a
         l6H+8ebGbmmUvC64z01znEl7VW4zMu7UJl4OI=
Received: by 10.90.69.14 with HTTP; Wed, 7 Apr 2010 10:52:28 -0700 (PDT)
Received: by 10.91.95.15 with SMTP id x15mr3040804agl.104.1270662768144; Wed, 
	07 Apr 2010 10:52:48 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144255>

Clarify the Gmail section: the user should not touch the message body
after using "git imap-send", otherwise the patch will get mangled.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/SubmittingPatches |   36 ++++++++++++++++++------------------
 1 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index c686f86..ff0e1b6 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -517,15 +517,20 @@ message, complete the addressing and subject
fields, and press send.
 Gmail
 -----

-GMail does not appear to have any way to turn off line wrapping in the web
-interface, so this will mangle any emails that you send.  You can however
-use any IMAP email client to connect to the google imap server, and forward
-the emails through that.  Just make sure to disable line wrapping in that
-email client.  Alternatively, use "git send-email" instead.
+GMail does not have any way to turn off line wrapping in the web
+interface, so this will mangle any emails that you send.  You have a
+couple of options here:

-Submitting properly formatted patches via Gmail is simple now that
-IMAP support is available. First, edit your ~/.gitconfig to specify your
-account settings:
+1. Use an email client that doesn't automatically wrap lines to send
+emails through the Google SMTP server, or use "git send-email" to
+achieve the same effect.
+
+2. Use "git imap-send" to push an email to the GMail Drafts folder via
+IMAP. Then use the GMail web interface to fill out the To: and CC:
+fields, taking care not to touch the message body, and send away!
+
+To get it working, edit your ~/.gitconfig to specify your account
+settings:

 [imap]
 	folder = "[Gmail]/Drafts"
@@ -536,16 +541,11 @@ account settings:
 	sslverify = false

 You might need to instead use: folder = "[Google Mail]/Drafts" if you
get an error
-that the "Folder doesn't exist".
-
-Next, ensure that your Gmail settings are correct. In "Settings" the
-"Use Unicode (UTF-8) encoding for outgoing messages" should be checked.
+that the "Folder doesn't exist". Also ensure that under the GMail
+"Settings", the "Use Unicode (UTF-8) encoding for outgoing messages"
+is checked.

-Once your commits are ready to send to the mailing list, run the following
-command to send the patch emails to your Gmail Drafts folder.
+Once your commits are ready to send to the mailing list, run the
+following command.

 	$ git format-patch -M --stdout origin/master | git imap-send
-
-Go to your Gmail account, open the Drafts folder, find the patch email, fill
-in the To: and CC: fields and send away!
-
-- 
1.7.0.3
