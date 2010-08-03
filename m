From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] post-receive-email: remove spurious commas in email subject.
Date: Tue,  3 Aug 2010 15:10:49 +0200
Message-ID: <1280841049-19091-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 03 15:11:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OgHGn-0008MO-2p
	for gcvg-git-2@lo.gmane.org; Tue, 03 Aug 2010 15:11:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755983Ab0HCNK4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Aug 2010 09:10:56 -0400
Received: from mx1.imag.fr ([129.88.30.5]:33285 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755949Ab0HCNKz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Aug 2010 09:10:55 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o73D0OWB004695
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 3 Aug 2010 15:00:24 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1OgHGe-0001oA-LX; Tue, 03 Aug 2010 15:10:52 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1OgHGe-00055O-Gn; Tue, 03 Aug 2010 15:10:52 +0200
X-Mailer: git-send-email 1.7.2.1.30.g18195
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 03 Aug 2010 15:00:24 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o73D0OWB004695
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1281445225.7088@vghZYhpwB6X7n5w3/kjNhg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152512>

The previous form produced subjects like

  [SCM] project.git branch, foo, updated. ...

The new one will produce the lighter

  [SCM] project.git branch foo updated. ...

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
I am the only one bothered by these extra commas in email subject? If
so, I can live with it, but I thought I'd give it a try ;-).

 contrib/hooks/post-receive-email |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/hooks/post-receive-email b/contrib/hooks/post-receive-email
index 30ae63d..09c5241 100755
--- a/contrib/hooks/post-receive-email
+++ b/contrib/hooks/post-receive-email
@@ -203,7 +203,7 @@ generate_email_header()
 	# Generate header
 	cat <<-EOF
 	To: $recipients
-	Subject: ${emailprefix}$projectdesc $refname_type, $short_refname, ${change_type}d. $describe
+	Subject: ${emailprefix}$projectdesc $refname_type $short_refname ${change_type}d. $describe
 	X-Git-Refname: $refname
 	X-Git-Reftype: $refname_type
 	X-Git-Oldrev: $oldrev
-- 
1.7.2.1.30.g18195
