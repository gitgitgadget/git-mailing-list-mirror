From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 2/2] Remove NO_ACCURATE_DIFF options from build systems
Date: Fri, 22 Dec 2006 22:18:03 -0800
Message-ID: <1166854684559-git-send-email-normalperson@yhbt.net>
References: <11668546833727-git-send-email-normalperson@yhbt.net>
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sat Dec 23 07:18:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gy0D0-0003F4-Ks
	for gcvg-git@gmane.org; Sat, 23 Dec 2006 07:18:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752501AbWLWGSK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Dec 2006 01:18:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752532AbWLWGSK
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Dec 2006 01:18:10 -0500
Received: from hand.yhbt.net ([66.150.188.102]:38622 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752563AbWLWGSH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Dec 2006 01:18:07 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 1848B7DC031;
	Fri, 22 Dec 2006 22:18:05 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Fri, 22 Dec 2006 22:18:04 -0800
To: Junio C Hamano <junkio@cox.net>
X-Mailer: git-send-email 1.4.4.3.gc902c
In-Reply-To: <11668546833727-git-send-email-normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35273>

The code no longer uses it, as we have --inaccurate-eof in
git-apply.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 Makefile     |    6 ------
 configure.ac |    3 ---
 2 files changed, 0 insertions(+), 9 deletions(-)

diff --git a/Makefile b/Makefile
index 5492836..ebc1a17 100644
--- a/Makefile
+++ b/Makefile
@@ -79,9 +79,6 @@ all:
 #
 # Define NO_ICONV if your libc does not properly support iconv.
 #
-# Define NO_ACCURATE_DIFF if your diff program at least sometimes misses
-# a missing newline at the end of the file.
-#
 # Define USE_NSEC below if you want git to care about sub-second file mtimes
 # and ctimes. Note that you need recent glibc (at least 2.2.4) for this, and
 # it will BREAK YOUR LOCAL DIFFS! show-diff and anything using it will likely
@@ -549,9 +546,6 @@ else
 endif
 endif
 endif
-ifdef NO_ACCURATE_DIFF
-	BASIC_CFLAGS += -DNO_ACCURATE_DIFF
-endif
 ifdef NO_PERL_MAKEMAKER
 	export NO_PERL_MAKEMAKER
 endif
diff --git a/configure.ac b/configure.ac
index e153d53..7cfb3a0 100644
--- a/configure.ac
+++ b/configure.ac
@@ -235,9 +235,6 @@ AC_SUBST(NO_SETENV)
 #
 # Define NO_SYMLINK_HEAD if you never want .git/HEAD to be a symbolic link.
 # Enable it on Windows.  By default, symrefs are still used.
-#
-# Define NO_ACCURATE_DIFF if your diff program at least sometimes misses
-# a missing newline at the end of the file.
 
 ## Site configuration (override autodetection)
 ## --with-PACKAGE[=ARG] and --without-PACKAGE
-- 
1.4.4.3.gc902c
