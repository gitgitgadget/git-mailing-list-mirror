From: Guillaume Sasdy <guillaume.sasdy@ensimag.imag.fr>
Subject: [PATCH 1/3] FIX: cmd_* moved to wiki_* in test-gitmw-lib.sh and other files
Date: Thu, 31 May 2012 20:31:50 +0200
Message-ID: <1338489110-4843-1-git-send-email-guillaume.sasdy@ensimag.imag.fr>
References: <4FC64B0C.6070507@ensimag.imag.fr>
Cc: Matthieu.Moy@imag.fr, simon.cathebras@ensimag.imag.fr,
	charles.roussel@ensimag.imag.fr, Julien.Khayat@ensimag.imag.fr,
	Simon.Perrat@ensimag.imag.fr
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 31 20:32:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SaAAF-0005ng-68
	for gcvg-git-2@plane.gmane.org; Thu, 31 May 2012 20:32:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758323Ab2EaSb7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 May 2012 14:31:59 -0400
Received: from mx1.imag.fr ([129.88.30.5]:51051 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758304Ab2EaSb6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 May 2012 14:31:58 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q4VINXv6000406
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 31 May 2012 20:23:33 +0200
Received: from ensibm.imag.fr (ensibm [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id q4VIVs3F031686;
	Thu, 31 May 2012 20:31:54 +0200
Received: from ensibm.imag.fr (localhost [127.0.0.1])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id q4VIVsqn004885;
	Thu, 31 May 2012 20:31:54 +0200
Received: (from sasdygu@localhost)
	by ensibm.imag.fr (8.13.8/8.13.8/Submit) id q4VIVsIa004884;
	Thu, 31 May 2012 20:31:54 +0200
X-Mailer: git-send-email 1.7.10.2.568.g4c26a3a
In-Reply-To: <4FC64B0C.6070507@ensimag.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 31 May 2012 20:23:33 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q4VINXv6000406
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: guillaume.sasdy@ensimag.imag.fr
MailScanner-NULL-Check: 1339093415.96508@boSSHvXEN92/aYpYOtSQqw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198937>

From: Simon Cathebras <simon.cathebras@ensimag.imag.fr>

Function cmd_* has been renamed in wiki_* in t/install-wiki.sh.
Change the calls in t/test-gitmw-lib.sh
---
 t/install-wiki.sh   |  4 ++--
 t/test-gitmw-lib.sh | 10 +++++-----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/t/install-wiki.sh b/t/install-wiki.sh
index 725346e..322f46d 100755
--- a/t/install-wiki.sh
+++ b/t/install-wiki.sh
@@ -19,11 +19,11 @@ usage () {
 # Argument: install, delete, --help | -h
 case "$1" in
 	"install")
-		cmd_install
+		wiki_install
 		exit 0
 		;;
 	"delete")
-		cmd_delete
+		wiki_delete
 		exit 0
 		;;
 	"--help" | "-h")
diff --git a/t/test-gitmw-lib.sh b/t/test-gitmw-lib.sh
index 8698625..b89b45a 100755
--- a/t/test-gitmw-lib.sh
+++ b/t/test-gitmw-lib.sh
@@ -136,7 +136,7 @@ fail()
 
 
 # Install a wiki in your web server directory.
-cmd_install () {
+wiki_install () {
 
 	# Copy the generic LocalSettings.php in the web server's directory
 	# And modify parameters according to the ones set at the top
@@ -206,7 +206,7 @@ cmd_install () {
 # Argument $1 is the relative path to the folder $FILES_FOLDER
 #
 # Warning: This function should be not called by user. This is a private
-# function used by cmd_install and cmd_delete
+# function used by wiki_install and wiki_delete
 reset_db_wiki () {
 
 	# Copy initial database of the wiki
@@ -221,7 +221,7 @@ reset_db_wiki () {
 # Set the admin WikiAdmin with password AdminPass in the database.
 #
 # Warning: This function should be not called by user. This is a private
-# function used by cmd_install and cmd_delete
+# function used by wiki_install and wiki_delete
 set_admin_wiki () {
 
 	#Add the admin
@@ -237,14 +237,14 @@ set_admin_wiki () {
 # Reset the database of the wiki and the password of the admin
 #
 # Warning: This function must be called only in a subdirectory of t/ directory
-cmd_reset () {
+wiki_reset () {
 	reset_db_wiki ".."
 	set_admin_wiki
 }
 
 # Delete the wiki created in the web server's directory and all its content
 # saved in the database.
-cmd_delete () {
+wiki_delete () {
 	# Delete the wiki's directory.
 	rm -rf "$WIKI_DIR_INST/$WIKI_DIR_NAME" ||
 		fail "Wiki's directory $WIKI_DIR_INST/" \
-- 
1.7.10.2.568.g4c26a3a
