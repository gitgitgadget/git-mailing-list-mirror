From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH v2 3/4] git-remote-mediawiki: use no-private-update capability on dumb push
Date: Mon,  2 Sep 2013 09:19:47 +0200
Message-ID: <1378106388-27992-3-git-send-email-Matthieu.Moy@imag.fr>
References: <CAMP44s2aV8X8TJigSqiSPB2HkK7hdxC2dFPWf5X62h90Y7M8Jg@mail.gmail.com>
 <1378106388-27992-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Sep 02 09:20:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGOR1-0001W7-2I
	for gcvg-git-2@plane.gmane.org; Mon, 02 Sep 2013 09:20:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757390Ab3IBHUD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Sep 2013 03:20:03 -0400
Received: from mx1.imag.fr ([129.88.30.5]:56621 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757204Ab3IBHUC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Sep 2013 03:20:02 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r827JsL3012176
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 2 Sep 2013 09:19:54 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1VGOQV-0004ZL-1v; Mon, 02 Sep 2013 09:19:55 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1VGOQU-0007IZ-Np; Mon, 02 Sep 2013 09:19:54 +0200
X-Mailer: git-send-email 1.8.4.12.g98a4f55.dirty
In-Reply-To: <1378106388-27992-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 02 Sep 2013 09:19:54 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r827JsL3012176
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1378711197.89903@eEClWcZnKAfPFElswEkW8A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233625>

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 contrib/mw-to-git/git-remote-mediawiki.perl | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/contrib/mw-to-git/git-remote-mediawiki.perl b/contrib/mw-to-git/git-remote-mediawiki.perl
index f8d7d2c..22300a1 100755
--- a/contrib/mw-to-git/git-remote-mediawiki.perl
+++ b/contrib/mw-to-git/git-remote-mediawiki.perl
@@ -590,6 +590,9 @@ sub mw_capabilities {
 	print {*STDOUT} "import\n";
 	print {*STDOUT} "list\n";
 	print {*STDOUT} "push\n";
+	if ($dumb_push) {
+		print {*STDOUT} "no-private-update\n";
+	}
 	print {*STDOUT} "\n";
 	return;
 }
-- 
1.8.4.12.g98a4f55.dirty
