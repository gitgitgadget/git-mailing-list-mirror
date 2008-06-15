From: Johan Herland <johan@herland.net>
Subject: [PATCH 2/3] Consistency: Use "libcurl" instead of "cURL library" and
 "curl"
Date: Sun, 15 Jun 2008 12:14:12 +0200
Message-ID: <200806151214.12525.johan@herland.net>
References: <200806120920.31161.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 15 12:15:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7pGn-0003PU-JF
	for gcvg-git-2@gmane.org; Sun, 15 Jun 2008 12:15:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757019AbYFOKOh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jun 2008 06:14:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757021AbYFOKOh
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jun 2008 06:14:37 -0400
Received: from smtp.getmail.no ([84.208.20.33]:58322 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757013AbYFOKOg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jun 2008 06:14:36 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0K2I00L091S17E00@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Sun, 15 Jun 2008 12:14:25 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0K2I00IVW1RO1860@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Sun, 15 Jun 2008 12:14:12 +0200 (CEST)
Received: from alpha.herland ([84.215.102.95])
 by no-osl-m323-srv-009-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0K2I00IU41ROPXG0@no-osl-m323-srv-009-z1.isp.get.no> for
 git@vger.kernel.org; Sun, 15 Jun 2008 12:14:12 +0200 (CEST)
In-reply-to: <200806120920.31161.johan@herland.net>
Content-disposition: inline
User-Agent: KMail/1.9.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85075>

Signed-off-by: Johan Herland <johan@herland.net>
---
 Documentation/git-http-push.txt                    |    4 ++--
 Documentation/howto/setup-git-server-over-http.txt |    2 +-
 Makefile                                           |    2 +-
 configure.ac                                       |    2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-http-push.txt b/Documentation/git-http-push.txt
index 8d32a92..d69b205 100644
--- a/Documentation/git-http-push.txt
+++ b/Documentation/git-http-push.txt
@@ -15,8 +15,8 @@ DESCRIPTION
 Sends missing objects to remote repository, and updates the
 remote branch.
 
-*NOTE*: This command is temporarily disabled if your cURL
-library is older than 7.16, as the combination has been reported
+*NOTE*: This command is temporarily disabled if your libcurl
+is older than 7.16, as the combination has been reported
 not to work and sometimes corrupts repository.
 
 OPTIONS
diff --git a/Documentation/howto/setup-git-server-over-http.txt b/Documentation/howto/setup-git-server-over-http.txt
index b7d09c1..4032748 100644
--- a/Documentation/howto/setup-git-server-over-http.txt
+++ b/Documentation/howto/setup-git-server-over-http.txt
@@ -186,7 +186,7 @@ Step 3: setup the client
 ------------------------
 
 Make sure that you have HTTP support, i.e. your git was built with
-curl (version more recent than 7.10). The command 'git http-push' with
+libcurl (version more recent than 7.10). The command 'git http-push' with
 no argument should display a usage message.
 
 Then, add the following to your $HOME/.netrc (you can do without, but will be
diff --git a/Makefile b/Makefile
index 1937507..06ebebe 100644
--- a/Makefile
+++ b/Makefile
@@ -13,7 +13,7 @@ all::
 # Define NO_OPENSSL environment variable if you do not have OpenSSL.
 # This also implies MOZILLA_SHA1.
 #
-# Define NO_CURL if you do not have curl installed.  git-http-pull and
+# Define NO_CURL if you do not have libcurl installed.  git-http-pull and
 # git-http-push are not built, and you cannot use http:// and https://
 # transports.
 #
diff --git a/configure.ac b/configure.ac
index 82584e9..7c2856e 100644
--- a/configure.ac
+++ b/configure.ac
@@ -158,7 +158,7 @@ AC_CHECK_LIB([crypto], [SHA1_Init],
 AC_SUBST(NEEDS_SSL_WITH_CRYPTO)
 AC_SUBST(NO_OPENSSL)
 #
-# Define NO_CURL if you do not have curl installed.  git-http-pull and
+# Define NO_CURL if you do not have libcurl installed.  git-http-pull and
 # git-http-push are not built, and you cannot use http:// and https://
 # transports.
 AC_CHECK_LIB([curl], [curl_global_init],
-- 
1.5.6.rc2.128.gf64ae
