From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 3/4] git-remote-mediawiki: use dont-update-private capability on dumb push
Date: Thu, 29 Aug 2013 20:58:23 +0200
Message-ID: <1377802704-30881-3-git-send-email-Matthieu.Moy@imag.fr>
References: <vpqsixvfvdk.fsf@anie.imag.fr>
 <1377802704-30881-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Aug 29 20:59:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VF7R3-0007DS-E0
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 20:59:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755693Ab3H2S7I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 14:59:08 -0400
Received: from mx2.imag.fr ([129.88.30.17]:40839 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753503Ab3H2S7H (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Aug 2013 14:59:07 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r7TIwWoS009291
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 29 Aug 2013 20:58:32 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1VF7QQ-00039U-MX; Thu, 29 Aug 2013 20:58:34 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1VF7QQ-00083B-Cy; Thu, 29 Aug 2013 20:58:34 +0200
X-Mailer: git-send-email 1.8.4.12.g98a4f55.dirty
In-Reply-To: <1377802704-30881-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 29 Aug 2013 20:58:32 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r7TIwWoS009291
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1378407515.00338@6l4BtqbHId27dVYPYI7qAQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233337>

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---

I prefer not to bother with compatibility of git-remote-mediawiki with
older Git versions. The recommanded way is to install Git and
git-remote-mediawiki from the same source tree. People who want to
keep an old Git version can still use old versions of
git-remote-mediawiki.

 contrib/mw-to-git/git-remote-mediawiki.perl | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/contrib/mw-to-git/git-remote-mediawiki.perl b/contrib/mw-to-git/git-remote-mediawiki.perl
index f8d7d2c..cdc278c 100755
--- a/contrib/mw-to-git/git-remote-mediawiki.perl
+++ b/contrib/mw-to-git/git-remote-mediawiki.perl
@@ -590,6 +590,9 @@ sub mw_capabilities {
 	print {*STDOUT} "import\n";
 	print {*STDOUT} "list\n";
 	print {*STDOUT} "push\n";
+	if ($dumb_push) {
+		print {*STDOUT} "dont-update-private\n";
+	}
 	print {*STDOUT} "\n";
 	return;
 }
-- 
1.8.4.12.g98a4f55.dirty
