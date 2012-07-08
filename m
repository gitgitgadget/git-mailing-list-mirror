From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] git-remote-mediawiki: update comments to reflect credential support
Date: Sun,  8 Jul 2012 18:18:28 +0200
Message-ID: <1341764308-9508-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Jul 08 18:19:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SnuCp-0005C6-SP
	for gcvg-git-2@plane.gmane.org; Sun, 08 Jul 2012 18:19:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751226Ab2GHQSt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jul 2012 12:18:49 -0400
Received: from mx1.imag.fr ([129.88.30.5]:40643 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751148Ab2GHQSs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jul 2012 12:18:48 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q68GHREA029191
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 8 Jul 2012 18:17:28 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1SnuBz-0006Xa-L0; Sun, 08 Jul 2012 18:18:39 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1SnuBz-0002Uu-GW; Sun, 08 Jul 2012 18:18:39 +0200
X-Mailer: git-send-email 1.7.11.1.147.g47a574d
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Sun, 08 Jul 2012 18:17:28 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q68GHREA029191
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1342369053.31192@l+XgVxg+l3oQPWylRrF/yQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201183>


Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---

Junio, can you add this to mm/credential-plumbing in pu, or better,
squash it into the last patch of the serie (i.e. a7271ad1dccaf1,
git-remote-mediawiki: add credential support)?

Thanks,

 contrib/mw-to-git/git-remote-mediawiki | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/contrib/mw-to-git/git-remote-mediawiki b/contrib/mw-to-git/git-remote-mediawiki
index 539718e..c07b4f0 100755
--- a/contrib/mw-to-git/git-remote-mediawiki
+++ b/contrib/mw-to-git/git-remote-mediawiki
@@ -26,9 +26,6 @@
 # - Git renames could be turned into MediaWiki renames (see TODO
 #   below)
 #
-# - login/password support requires the user to write the password
-#   cleartext in a file (see TODO below).
-#
 # - No way to import "one page, and all pages included in it"
 #
 # - Multiple remote MediaWikis have not been very well tested.
@@ -74,9 +71,7 @@ my @tracked_categories = split(/[ \n]/, run_git("config --get-all remote.". $rem
 chomp(@tracked_categories);
 
 my $wiki_login = run_git("config --get remote.". $remotename .".mwLogin");
-# TODO: ideally, this should be able to read from keyboard, but we're
-# inside a remote helper, so our stdin is connect to git, not to a
-# terminal.
+# Note: mwPassword is discourraged. Use the credential system instead.
 my $wiki_passwd = run_git("config --get remote.". $remotename .".mwPassword");
 my $wiki_domain = run_git("config --get remote.". $remotename .".mwDomain");
 chomp($wiki_login);
-- 
1.7.11.1.147.g47a574d
