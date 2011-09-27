From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 1/3] git-remote-mediawiki: trivial fixes
Date: Tue, 27 Sep 2011 19:54:58 +0200
Message-ID: <1317146100-22938-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Sep 27 19:55:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8bsG-00054a-Od
	for gcvg-git-2@lo.gmane.org; Tue, 27 Sep 2011 19:55:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751865Ab1I0RzN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Sep 2011 13:55:13 -0400
Received: from mx1.imag.fr ([129.88.30.5]:51691 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750965Ab1I0RzN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Sep 2011 13:55:13 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id p8RHr49o030893
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 27 Sep 2011 19:53:04 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1R8bs0-0008V4-TJ; Tue, 27 Sep 2011 19:55:04 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1R8bs0-0005ye-PB; Tue, 27 Sep 2011 19:55:04 +0200
X-Mailer: git-send-email 1.7.7.rc0.75.g56f27
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 27 Sep 2011 19:53:05 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p8RHr49o030893
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1317750789.87814@kf3w5cXnLK4XPUMNgUskHg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182258>

Fix a whitespace issue (no space before :) and remove unused %status in
mw_push.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 contrib/mw-to-git/git-remote-mediawiki |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/contrib/mw-to-git/git-remote-mediawiki b/contrib/mw-to-git/git-remote-mediawiki
index 0ba88de..768b42d 100755
--- a/contrib/mw-to-git/git-remote-mediawiki
+++ b/contrib/mw-to-git/git-remote-mediawiki
@@ -656,7 +656,7 @@ sub mw_push_file {
 				  $mediawiki->{error}->{code} .
 				  ' from mediwiki: ' . $mediawiki->{error}->{details};
 		$newrevid = $result->{edit}->{newrevid};
-		print STDERR "Pushed file : $new_sha1 - $title\n";
+		print STDERR "Pushed file: $new_sha1 - $title\n";
 	} else {
 		print STDERR "$complete_file_name not a mediawiki file (Not pushable on this version of git-remote-mediawiki).\n"
 	}
@@ -666,7 +666,6 @@ sub mw_push_file {
 sub mw_push {
 	# multiple push statements can follow each other
 	my @refsspecs = (shift, get_more_refs("push"));
-	my %status;
 	my $pushed;
 	for my $refspec (@refsspecs) {
 		my ($force, $local, $remote) = $refspec =~ /^(\+)?([^:]*):([^:]*)$/
-- 
1.7.7.rc0.75.g56f27
