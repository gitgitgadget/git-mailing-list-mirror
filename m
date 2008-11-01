From: "Tom Preston-Werner" <tom@github.com>
Subject: [PATCH] add instructions on how to send patches to the mailing list with Gmail
Date: Sat, 1 Nov 2008 00:28:18 -0700
Message-ID: <b97024a40811010028l36606128v61172807f4cf503a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 01 08:33:46 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwAzM-0004SQ-Tq
	for gcvg-git-2@gmane.org; Sat, 01 Nov 2008 08:33:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750791AbYKAH2W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Nov 2008 03:28:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750757AbYKAH2W
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Nov 2008 03:28:22 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:37961 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750747AbYKAH2V (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Nov 2008 03:28:21 -0400
Received: by nf-out-0910.google.com with SMTP id d3so698127nfc.21
        for <git@vger.kernel.org>; Sat, 01 Nov 2008 00:28:19 -0700 (PDT)
Received: by 10.210.56.7 with SMTP id e7mr5568676eba.198.1225524498865;
        Sat, 01 Nov 2008 00:28:18 -0700 (PDT)
Received: by 10.210.117.11 with HTTP; Sat, 1 Nov 2008 00:28:18 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99721>

Gmail is one of the most popular email providers in the world. Now that Gmail
supports IMAP, sending properly formatted patches via `git imap-send` is
trivial. This section in SubmittingPatches explains how to do so.

Signed-off-by: Tom Preston-Werner <tom@github.com>
---
 Documentation/SubmittingPatches |   27 +++++++++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index a1e9100..f0295c6 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -456,3 +456,30 @@ This should help you to submit patches inline using KMail.

 5) Back in the compose window: add whatever other text you wish to the
 message, complete the addressing and subject fields, and press send.
+
+
+Gmail
+-----
+
+Submitting properly formatted patches via Gmail is simple now that
+IMAP support is available. First, edit your ~/.gitconfig to specify your
+account settings:
+
+[imap]
+	folder = "[Gmail]/Drafts"
+	host = imaps://imap.gmail.com
+	user = user@gmail.com
+	pass = p4ssw0rd
+	port = 993
+	sslverify = false
+
+Next, ensure that your Gmail settings are correct. In "Settings" the
+"Use Unicode (UTF-8) encoding for outgoing messages" should be checked.
+
+Once your commits are ready to send to the mailing list, run the following
+command to send the patch emails to your Gmail Drafts folder.
+
+	$ git format-patch -M --stdout origin/master | git imap-send
+
+Go to your Gmail account, open the Drafts folder, find the patch email, fill
+in the To: and CC: fields and send away!
-- 
1.6.0.2
