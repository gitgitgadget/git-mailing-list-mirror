From: Jari Aalto <jari.aalto@cante.net>
Subject: [PATCH] git-send-email.perl: improve error message in send_message()
Date: Fri, 12 Mar 2010 22:07:22 +0200
Organization: Private
Message-ID: <87vdd1ti9f.fsf@jondo.cante.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 12 21:09:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NqBAV-0004ta-43
	for gcvg-git-2@lo.gmane.org; Fri, 12 Mar 2010 21:09:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933151Ab0CLUJF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Mar 2010 15:09:05 -0500
Received: from lo.gmane.org ([80.91.229.12]:36892 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932176Ab0CLUJE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Mar 2010 15:09:04 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1NqBAM-0004q3-Gu
	for git@vger.kernel.org; Fri, 12 Mar 2010 21:09:02 +0100
Received: from a91-155-187-216.elisa-laajakaista.fi ([91.155.187.216])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 12 Mar 2010 21:09:02 +0100
Received: from jari.aalto by a91-155-187-216.elisa-laajakaista.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 12 Mar 2010 21:09:02 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: a91-155-187-216.elisa-laajakaista.fi
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/23.1 (gnu/linux)
Cancel-Lock: sha1:J8IiGsiWrZTHPfDnHv/z/FYvPMw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142062>



Signed-off-by: Jari Aalto <jari.aalto@cante.net>
---
 git-send-email.perl |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index e05455f..221506c 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -957,7 +957,10 @@ X-Mailer: git-send-email $gitversion
 		}
 
 		if (!$smtp) {
-			die "Unable to initialize SMTP properly.  Is there something wrong with your config?";
+			die "Unable to initialize SMTP properly. Check config. ",
+			    "VALUES: server=$smtp_server ",
+			    "encryption=$smtp_encryption ",
+			    defined $smtp_server_port ? "port=$smtp_server_port" : "";
 		}
 
 		if (defined $smtp_authuser) {
-- 
1.7.0
