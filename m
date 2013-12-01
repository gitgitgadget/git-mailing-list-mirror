From: Thomas Rast <tr@thomasrast.ch>
Subject: [PATCH 2/3] send-email: --smtp-ssl-cert-path takes an argument
Date: Sun,  1 Dec 2013 23:48:42 +0100
Message-ID: <a8acc2b499f1635be6a7f7414aca8cfd75a7c828.1385938050.git.tr@thomasrast.ch>
References: <3bb0c80c70e1c40236034552bec037cb0c26167c.1385938050.git.tr@thomasrast.ch>
Cc: Ramkumar Ramachandra <artagnon@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 01 23:49:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VnFp0-0004Sy-0E
	for gcvg-git-2@plane.gmane.org; Sun, 01 Dec 2013 23:49:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751653Ab3LAWsu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Dec 2013 17:48:50 -0500
Received: from psi.thgersdorf.net ([176.9.98.78]:39509 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751412Ab3LAWst (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Dec 2013 17:48:49 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id E241A4D64C4;
	Sun,  1 Dec 2013 23:48:46 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id UeeaiojxzKaP; Sun,  1 Dec 2013 23:48:46 +0100 (CET)
Received: from linux.local (unknown [89.204.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id 7C2464D64FC;
	Sun,  1 Dec 2013 23:48:45 +0100 (CET)
X-Mailer: git-send-email 1.8.5.rc3.5.g2a1fe2f
In-Reply-To: <3bb0c80c70e1c40236034552bec037cb0c26167c.1385938050.git.tr@thomasrast.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238599>

35035bb (send-email: be explicit with SSL certificate verification,
2013-07-18) forgot to specify that --smtp-ssl-cert-path takes a string
argument.  This means that the option could not actually be used as
intended.  Presumably noone noticed because it's much easier to set it
through configs anyway.

Add the required "=s".

Signed-off-by: Thomas Rast <tr@thomasrast.ch>
---
 git-send-email.perl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index f7468b6..9f31c68 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -291,7 +291,7 @@ sub signal_handler {
 		    "smtp-pass:s" => \$smtp_authpass,
 		    "smtp-ssl" => sub { $smtp_encryption = 'ssl' },
 		    "smtp-encryption=s" => \$smtp_encryption,
-		    "smtp-ssl-cert-path" => \$smtp_ssl_cert_path,
+		    "smtp-ssl-cert-path=s" => \$smtp_ssl_cert_path,
 		    "smtp-debug:i" => \$debug_net_smtp,
 		    "smtp-domain:s" => \$smtp_domain,
 		    "identity=s" => \$identity,
-- 
1.8.5.rc3.5.g2a1fe2f
