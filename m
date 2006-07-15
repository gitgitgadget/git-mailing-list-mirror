From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH 1/2] Quote all calls to GIT_CONF_APPEND_LINE
Date: Sat, 15 Jul 2006 01:29:19 -0400
Message-ID: <20060715052919.19165.19665.stgit@dv.roinet.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Sat Jul 15 07:29:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G1ciY-0003sr-0s
	for gcvg-git@gmane.org; Sat, 15 Jul 2006 07:29:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932445AbWGOF3Z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 15 Jul 2006 01:29:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932457AbWGOF3Z
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Jul 2006 01:29:25 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:2513 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S932445AbWGOF3Y
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Jul 2006 01:29:24 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1G1ciQ-0007OO-Up
	for git@vger.kernel.org; Sat, 15 Jul 2006 01:29:23 -0400
Received: from [127.0.0.1] (helo=dv.roinet.com)
	by dv.roinet.com with esmtp (Exim 4.62)
	(envelope-from <proski@gnu.org>)
	id 1G1ciN-0004zE-Su
	for git@vger.kernel.org; Sat, 15 Jul 2006 01:29:19 -0400
To: git@vger.kernel.org
User-Agent: StGIT/0.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23923>

From: Pavel Roskin <proski@gnu.org>

Not quoting macro arguments that contain other macros is a big no-no in
Autoconf.  It can break at any time.

Signed-off-by: Pavel Roskin <proski@gnu.org>
---

 configure.ac |   24 ++++++++++++------------
 1 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/configure.ac b/configure.ac
index 2932d0e..c1f7751 100644
--- a/configure.ac
+++ b/configure.ac
@@ -39,30 +39,30 @@ # Define NO_OPENSSL environment variable
 # Define NEEDS_SSL_WITH_CRYPTO if you need -lcrypto with -lssl (Darwin).
 AC_CHECK_LIB([ssl], [SHA1_Init],[],
 [AC_CHECK_LIB([crypto], [SHA1_INIT],
- GIT_CONF_APPEND_LINE(NEEDS_SSL_WITH_CRYPTO=YesPlease),
- GIT_CONF_APPEND_LINE(NO_OPENSSL=YesPlease))])
+ [GIT_CONF_APPEND_LINE(NEEDS_SSL_WITH_CRYPTO=YesPlease)],
+ [GIT_CONF_APPEND_LINE(NO_OPENSSL=YesPlease)])])
 #
 # Define NO_CURL if you do not have curl installed.  git-http-pull and
 # git-http-push are not built, and you cannot use http:// and https://
 # transports.
 AC_CHECK_LIB([curl], [curl_global_init],[],
-GIT_CONF_APPEND_LINE(NO_CURL=YesPlease))
+[GIT_CONF_APPEND_LINE(NO_CURL=YesPlease)])
 #
 # Define NO_EXPAT if you do not have expat installed.  git-http-push is
 # not built, and you cannot push using http:// and https:// transports.
 AC_CHECK_LIB([expat], [XML_ParserCreate],[],
-GIT_CONF_APPEND_LINE(NO_EXPAT=YesPlease))
+[GIT_CONF_APPEND_LINE(NO_EXPAT=YesPlease)])
 #
 # Define NEEDS_LIBICONV if linking with libc is not enough (Darwin).
 AC_CHECK_LIB([c], [iconv],[],
 [AC_CHECK_LIB([iconv],[iconv],
- GIT_CONF_APPEND_LINE(NEEDS_LIBICONV=YesPlease),[])])
+ [GIT_CONF_APPEND_LINE(NEEDS_LIBICONV=YesPlease)],[])])
 #
 # Define NEEDS_SOCKET if linking with libc is not enough (SunOS,
 # Patrick Mauritz).
 AC_CHECK_LIB([c], [socket],[],
 [AC_CHECK_LIB([socket],[socket],
- GIT_CONF_APPEND_LINE(NEEDS_SOCKET=YesPlease),[])])
+ [GIT_CONF_APPEND_LINE(NEEDS_SOCKET=YesPlease)],[])])
 
 
 ## Checks for header files.
@@ -73,19 +73,19 @@ AC_MSG_NOTICE([CHECKS for typedefs, stru
 #
 # Define NO_D_INO_IN_DIRENT if you don't have d_ino in your struct dirent.
 AC_CHECK_MEMBER(struct dirent.d_ino,[],
-GIT_CONF_APPEND_LINE(NO_D_INO_IN_DIRENT=YesPlease),
+[GIT_CONF_APPEND_LINE(NO_D_INO_IN_DIRENT=YesPlease)],
 [#include <dirent.h>])
 #
 # Define NO_D_TYPE_IN_DIRENT if your platform defines DT_UNKNOWN but lacks
 # d_type in struct dirent (latest Cygwin -- will be fixed soonish).
 AC_CHECK_MEMBER(struct dirent.d_type,[],
-GIT_CONF_APPEND_LINE(NO_D_TYPE_IN_DIRENT=YesPlease),
+[GIT_CONF_APPEND_LINE(NO_D_TYPE_IN_DIRENT=YesPlease)],
 [#include <dirent.h>])
 #
 # Define NO_SOCKADDR_STORAGE if your platform does not have struct
 # sockaddr_storage.
 AC_CHECK_TYPE(struct sockaddr_storage,[],
-GIT_CONF_APPEND_LINE(NO_SOCKADDR_STORAGE=YesPlease),
+[GIT_CONF_APPEND_LINE(NO_SOCKADDR_STORAGE=YesPlease)],
 [#include <netinet/in.h>])
 
 
@@ -95,15 +95,15 @@ AC_MSG_NOTICE([CHECKS for library functi
 #
 # Define NO_STRCASESTR if you don't have strcasestr.
 AC_CHECK_FUNC(strcasestr,[],
-GIT_CONF_APPEND_LINE(NO_STRCASESTR=YesPlease))
+[GIT_CONF_APPEND_LINE(NO_STRCASESTR=YesPlease)])
 #
 # Define NO_STRLCPY if you don't have strlcpy.
 AC_CHECK_FUNC(strlcpy,[],
-GIT_CONF_APPEND_LINE(NO_STRLCPY=YesPlease))
+[GIT_CONF_APPEND_LINE(NO_STRLCPY=YesPlease)])
 #
 # Define NO_SETENV if you don't have setenv in the C library.
 AC_CHECK_FUNC(setenv,[],
-GIT_CONF_APPEND_LINE(NO_SETENV=YesPlease))
+[GIT_CONF_APPEND_LINE(NO_SETENV=YesPlease)])
 #
 # Define NO_MMAP if you want to avoid mmap.
 #
