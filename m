From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] git-send-email: add a new sendemail.to configuration variable
Date: Mon,  1 Oct 2007 14:42:42 +0200
Message-ID: <1191242562-27486-1-git-send-email-vmiklos@frugalware.org>
Cc: Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 01 14:44:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcKdS-0005P1-9q
	for gcvg-git-2@gmane.org; Mon, 01 Oct 2007 14:44:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751628AbXJAMoW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Oct 2007 08:44:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751453AbXJAMoW
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Oct 2007 08:44:22 -0400
Received: from virgo.iok.hu ([193.202.89.103]:40089 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751320AbXJAMoV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Oct 2007 08:44:21 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 99C6D1B250A;
	Mon,  1 Oct 2007 14:44:20 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 7C0976FD02;
	Mon,  1 Oct 2007 14:44:20 +0200 (CEST)
Received: from vmobile.example.net (dhcp-114.i.air.bme.hu [152.66.146.114])
	by genesis.frugalware.org (Postfix) with ESMTP id 06AB713A406A;
	Mon,  1 Oct 2007 14:44:19 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 80DF38B2F4; Mon,  1 Oct 2007 14:42:42 +0200 (CEST)
X-Mailer: git-send-email 1.5.3.2.111.g5166-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59610>

Several projects prefers to receive patches via a given email address. In these
cases it's handy to configure that address once.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 Documentation/git-send-email.txt |    3 +++
 git-send-email.perl              |    1 +
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 3727776..e38b702 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -159,6 +159,9 @@ sendemail.aliasfiletype::
 	Format of the file(s) specified in sendemail.aliasesfile. Must be
 	one of 'mutt', 'mailrc', 'pine', or 'gnus'.
 
+sendemail.to::
+	Email address (or alias) to always send to.
+
 sendemail.cccmd::
 	Command to execute to generate per patch file specific "Cc:"s.
 
diff --git a/git-send-email.perl b/git-send-email.perl
index 62e1429..96051bc 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -191,6 +191,7 @@ my %config_settings = (
     "smtpserverport" => \$smtp_server_port,
     "smtpuser" => \$smtp_authuser,
     "smtppass" => \$smtp_authpass,
+    "to" => \@to,
     "cccmd" => \$cc_cmd,
     "aliasfiletype" => \$aliasfiletype,
     "bcc" => \@bcclist,
-- 
1.5.3.2.111.g5166-dirty
