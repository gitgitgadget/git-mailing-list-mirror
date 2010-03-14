From: Jari Aalto <jari.aalto@cante.net>
Subject: [PATCH 1/3] git-send-email.perl: improve error message in send_message()
Date: Sun, 14 Mar 2010 17:15:33 +0200
Organization: Private
Message-ID: <871vfnc4tm.fsf_-_@jondo.cante.net>
References: <4B97C157.4020806@gmail.com>
	<20100311081213.GA13575@sigill.intra.peff.net>
	<20100311083148.GA13786@sigill.intra.peff.net>
	<7vaaueziv8.fsf@alter.siamese.dyndns.org> <4B9A74CA.4080507@gmail.com>
	<7vy6hxnnfx.fsf@alter.siamese.dyndns.org>
	<87bpesi0om.fsf_-_@jondo.cante.net>
	<7vfx433l9x.fsf@alter.siamese.dyndns.org>
	<87eijng4hy.fsf@jondo.cante.net>
	<7vtysjs9hi.fsf@alter.siamese.dyndns.org>
	<878w9vdx01.fsf@jondo.cante.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 14 16:16:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NqpY2-00053t-Q1
	for gcvg-git-2@lo.gmane.org; Sun, 14 Mar 2010 16:16:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758762Ab0CNPPy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Mar 2010 11:15:54 -0400
Received: from lo.gmane.org ([80.91.229.12]:52936 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752813Ab0CNPPx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Mar 2010 11:15:53 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1NqpXi-0004xr-Nl
	for git@vger.kernel.org; Sun, 14 Mar 2010 16:15:50 +0100
Received: from a91-155-187-216.elisa-laajakaista.fi ([91.155.187.216])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 14 Mar 2010 16:15:50 +0100
Received: from jari.aalto by a91-155-187-216.elisa-laajakaista.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 14 Mar 2010 16:15:50 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: a91-155-187-216.elisa-laajakaista.fi
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/23.1 (gnu/linux)
Cancel-Lock: sha1:QQayewzsLtZiSCDKg++qZ1MFfkU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142143>


Signed-off-by: Jari Aalto <jari.aalto@cante.net>
---
 git-send-email.perl |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

    ================================
    This is REVISION SET 4, reworked
    ================================

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
