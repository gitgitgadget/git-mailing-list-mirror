Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C7A4F1F404
	for <e@80x24.org>; Fri, 19 Jan 2018 17:35:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932672AbeASRfH (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Jan 2018 12:35:07 -0500
Received: from sonic310.consmr.mail.bf2.yahoo.com ([74.6.135.253]:35093 "EHLO
        sonic310-17.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932525AbeASReW (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 19 Jan 2018 12:34:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rogers.com; s=s2048; t=1516383261; bh=aaUWQvFxEQgZFHsSxR32XneR7FflkUYof+aVbZvWh20=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=MVO6Z2ATjTC5Y/Vo1ziXgmjGVXPpzIRl1FrvbJAVhZ+Obe0Rj8lCCjl2yvD5qHC5/MXNpnPx1sn4epqOZFdFkBk1SfIqa6oF4AgoDO0rriYtpNzlVtiD+SGYsLfhhjNZdtwnYkh2NHAvmZ5YKfZyH3GDniFrep89vLW0G28ajOk+bMozf+PKXQQYwJKZoKUagjble5UMo5DzscAx6vVLreNoww5f4NoQ49dx5uD7gruFu4zcHzXSHvmaXJZETx0TvH2pPKVgbvMV4IDMtP4BesEBMbJaSr/MdOicbboLCwn67WMBk9eKk+Bq1xCR+M+u+X9pR1i4dG3pmZyCG0UIKQ==
X-YMail-OSG: 1EJpXe8VM1l6QykFxhOweccsUW158tDlACIzmy.5jbrjdg1jwjX9f4AMHuqF1AB
 UlSGXhS56XsjlP9klVGM3UeIAJD81nQeN8UWm8WdVkus.D50Z6WOnWAg.oKpnQqvz3P01kVsaBOC
 9h85xW12eMDzTHKgQewe1oiDWdqIPkyWUyGKXHthvyoGCKeVgxRuSV43BAlJLiebqOAx8KMoBr93
 7nCoXI8DuAz0p6RWX_1SQ8NpC0lGhJGqEnTl_X1uMTBfbxmmeLOAlHPXnJ8NqMr0sjhD4wp0VDp4
 p9y4uDTJ9DV3Z7croMM_XVEruUFt_mM5SW8ECQ1w3meFYtLOf.gRlUeyWzdt9FTAqY6Y_a7mTC25
 hl5u8y6OscXqbVJXwRD..mMvqH0NH1eZC9I4kAPewOjZbOxqrXkpqOCDBRcn.OlxDqaoT6JN2i8e
 .fDSuXuxgatDPLQx0Mr_jXoR7Z4ylbHm0WhG6YxN85gBp3uIZ4cRggFbNR1KJuAGx.VLamAnk4ij
 sWyw36KFJbU.zepYZKR83NE4UMh6OegTe8V9XSjGYzScNdDdRDw--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.bf2.yahoo.com with HTTP; Fri, 19 Jan 2018 17:34:21 +0000
Received: from smtpgate102.mail.bf1.yahoo.com (EHLO localhost.localdomain) ([72.30.28.113])
          by smtp406.mail.bf1.yahoo.com (JAMES SMTP Server ) with ESMTPA ID e78d06b6c08cf8709c5b5470ad5cf24d;
          Fri, 19 Jan 2018 17:34:19 +0000 (UTC)
From:   randall.s.becker@rogers.com
To:     git@vger.kernel.org
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: [PATCH v2 3/6] Define config options required for the HPE NonStop NSX and NSE platforms
Date:   Fri, 19 Jan 2018 12:34:03 -0500
Message-Id: <20180119173406.13324-5-randall.s.becker@rogers.com>
X-Mailer: git-send-email 2.12.3
In-Reply-To: <20180119173406.13324-1-randall.s.becker@rogers.com>
References: <20180119173406.13324-1-randall.s.becker@rogers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Randall S. Becker" <rsbecker@nexbridge.com>

* config.mak.uname: upgrade old options to currently supported
  NonStop operating system versions (J06.21 and L17.xx).

Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
---
 config.mak.uname | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/config.mak.uname b/config.mak.uname
index 685a80d13..d9f8d57e3 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -428,27 +428,37 @@ ifeq ($(uname_S),NONSTOP_KERNEL)
 	# INLINE='' would just replace one set of warnings with another and
 	# still not compile in c89 mode, due to non-const array initializations.
 	CC = cc -c99
+	# Build down-rev compatible objects that don't use our new getopt_long.
+	ifeq ($(uname_R).$(uname_V),J06.21)
+		CC += -WRVU=J06.20
+	endif
+	ifeq ($(uname_R).$(uname_V),L17.02)
+		CC += -WRVU=L16.05
+	endif
 	# Disable all optimization, seems to result in bad code, with -O or -O2
 	# or even -O1 (default), /usr/local/libexec/git-core/git-pack-objects
 	# abends on "git push". Needs more investigation.
-	CFLAGS = -g -O0
+	CFLAGS = -g -O0 -Winline
 	# We'd want it to be here.
 	prefix = /usr/local
 	# Our's are in ${prefix}/bin (perl might also be in /usr/bin/perl).
-	PERL_PATH = ${prefix}/bin/perl
-	PYTHON_PATH = ${prefix}/bin/python
-
+	PERL_PATH = /usr/bin/perl
+	PYTHON_PATH = /usr/bin/python
+	RM = /bin/rm -f
 	# As detected by './configure'.
 	# Missdetected, hence commented out, see below.
 	#NO_CURL = YesPlease
 	# Added manually, see above.
 	NEEDS_SSL_WITH_CURL = YesPlease
+	NEEDS_CRYPTO_WITH_SSL = YesPlease
+	HAVE_DEV_TTY = YesPlease
 	HAVE_LIBCHARSET_H = YesPlease
 	HAVE_STRINGS_H = YesPlease
 	NEEDS_LIBICONV = YesPlease
 	NEEDS_LIBINTL_BEFORE_LIBICONV = YesPlease
 	NO_SYS_SELECT_H = UnfortunatelyYes
 	NO_D_TYPE_IN_DIRENT = YesPlease
+	NO_GETTEXT = YesPlease
 	NO_HSTRERROR = YesPlease
 	NO_STRCASESTR = YesPlease
 	NO_MEMMEM = YesPlease
@@ -458,8 +468,13 @@ ifeq ($(uname_S),NONSTOP_KERNEL)
 	NO_MKDTEMP = YesPlease
 	# Currently libiconv-1.9.1.
 	OLD_ICONV = UnfortunatelyYes
-	NO_REGEX = YesPlease
+	NO_REGEX=NeedsStartEnd
 	NO_PTHREADS = UnfortunatelyYes
+	ifdef NO_PTHREADS
+	else # WIP, use Posix User Threads
+		PTHREAD_CFLAGS = -D_PUT_MODEL_ -I/usr/include
+		PTHREAD_LIBS = -lput
+	endif
 
 	# Not detected (nor checked for) by './configure'.
 	# We don't have SA_RESTART on NonStop, unfortunalety.
@@ -477,9 +492,7 @@ ifeq ($(uname_S),NONSTOP_KERNEL)
 	# RFE 10-120912-4693 submitted to HP NonStop development.
 	NO_SETITIMER = UnfortunatelyYes
 	SANE_TOOL_PATH = /usr/coreutils/bin:/usr/local/bin
-	SHELL_PATH = /usr/local/bin/bash
-	# as of H06.25/J06.14, we might better use this
-	#SHELL_PATH = /usr/coreutils/bin/bash
+	SHELL_PATH = /usr/coreutils/bin/bash
 endif
 ifneq (,$(findstring MINGW,$(uname_S)))
 	pathsep = ;
-- 
2.16.0.31.gf1a482c

