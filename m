Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98F5C1F461
	for <e@80x24.org>; Thu, 16 May 2019 18:05:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728996AbfEPSFc (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 May 2019 14:05:32 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54342 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbfEPSFc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 May 2019 14:05:32 -0400
Received: by mail-wm1-f67.google.com with SMTP id i3so4539232wml.4
        for <git@vger.kernel.org>; Thu, 16 May 2019 11:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3YXGcZDpsgWltXH4Mtk5AGSKE+IrzDYj5VAjrEl8E9s=;
        b=Ua3RjrVWG4rp7qoQfaASq78rrCDSdutodJoXuFbQ8X5Ou1m+OIYzNDtZljTA09Kw9U
         SPsQAEWL4qfQ3f0jMHSRMpGsJkVMKrOi8zDYA5yOK4t7IQNAODmtNEksK0snm0QEnnUa
         XQesCIoCwwX6+DkGx+5uv0xGqmvdJ6owkoQEgyLxSKkUGzN63eAvmGkVLtrzObioxCYQ
         AGM4Bv5KvILZAKDYeqKIwgEyJmtmfVjy/dgZxHkkQC/7xdZQHGrLhjbysjQ/8kax5/ac
         ZEdjkTHQTyr5djJqFVb3pn4fe1J4m0CNiCWMJgxgM9Y64nDQAHNLKAAlkQCc/31hVsRP
         07YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3YXGcZDpsgWltXH4Mtk5AGSKE+IrzDYj5VAjrEl8E9s=;
        b=sKjS+CM+6/eARhVg0WTaS3GTy0lLvUDsVRVMGP/9rKt/H0xN+viIsVktSWMqTIv8EP
         3/kOu9EKWji+CA5b/nsrtln5L531gj0eVehHWgClaIKQzh3F+x2Mz7IKVPNcNRLB2X+T
         SBifoMPGdodwMyMXZy1XjitoZkFA7yH/ITDb8VIbWmb+MArUVQ7AZietvGk8qt0f06Oc
         rI7YH76O+hccOi0nDSrg+xdvdjHLgJl1icd730rVgNtbUBMPokHNxylMWmrfaTPnuU6h
         +Cymu0nFiJTjAdbPwJmdJPAZb6Gizguq6vSEW7uSAqOBeHIvsd9VsRqIZdxfcWh9baVx
         gj8A==
X-Gm-Message-State: APjAAAXAyHF56lKgWu/r+XbjsxvI2x7SM/xwGVVKB3dKassoRaHUrpTP
        aIFf7JVUFhYYElBbTn9mBbNO9osgk2k=
X-Google-Smtp-Source: APXvYqzZ8usqjM1aS2P4WXc1mkmTOMbJ5cliLQBgv6NrVW4Bh9Kr3COucjyShsv3tF6wke+qFGyxRQ==
X-Received: by 2002:a1c:7e10:: with SMTP id z16mr17298462wmc.98.1558029929780;
        Thu, 16 May 2019 11:05:29 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o4sm5317591wmc.38.2019.05.16.11.05.28
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 16 May 2019 11:05:29 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Osipov <michael.osipov@siemens.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] Makefile: remove the NO_R_TO_GCC_LINKER flag
Date:   Thu, 16 May 2019 20:05:21 +0200
Message-Id: <20190516180521.1933-1-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a
In-Reply-To: <20190516093412.14795-1-avarab@gmail.com>
References: <20190516093412.14795-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the NO_R_TO_GCC_LINKER flag, thus switching the default to
"-Wl,-rpath,$LIBPATH" instead of our current "-R$LIBPATH". This is a
relatively obscure thing that only kicks in when using one of the
LIBDIR flags, e.g. LIBPCREDIR or CURLDIR.

How we invoke the linker to do this can still be overridden with
CC_LD_DYNPATH, as seen in our configure.ac script.

Our use of "-R" dates back to 455a7f3275 ("More portability.",
2005-09-30). Soon after that in bbfc63dd78 ("gcc does not necessarily
pass runtime libpath with -R", 2006-12-27) the NO_R_TO_GCC flag was
added, allowing optional use of "-Wl,-rpath=".

Then in f5b904db6b ("Makefile: Allow CC_LD_DYNPATH to be overriden",
2008-08-16) the ability to override this flag to something else
entirely was added, as some linkers use neither "-Wl,-rpath," nor
"-R".

From what I can tell we should, with the benefit of hindsight, have
made this change back in 2006. GCC & ld supported this type of
invocation back then, or since at least binutils-gdb.git's[1]
a1ad915dc4 ("[...]Add support for -rpath[...]", 1994-07-20). Most
people compiling git with a custom LIBDIR are going to be on a GNU-ish
system, and having to provide this NO_R_TO_GCC_LINKER flag on top of a
custom LIBDIR is annoying.

There are some OS's that don't support -rpath, e.g. AIX ld just
supports "-R". Perhaps we should follow this up with some
config.mak.uname changes, but as noted it's quite possible that nobody
on these platforms uses this (instead libraries in the system's search
path). We *could* also use "-Wl,-R", but let's not introduce something
new.

Further reading and prior art can be found at [2][3][4][5]. Making a
plain "-R" an error seems from reading those reports to have been
introduced in GCC 4.6 released on March 25, 2011, but I couldn't
confirm this with absolute certainty, its release notes are ambiguous
on the subject, and I couldn't be bothered to try to build & bisect it
against GCC 4.5.

1. git://sourceware.org/git/binutils-gdb.git
2. https://github.com/tsuna/boost.m4/issues/15
3. https://bugzilla.gnome.org/show_bug.cgi?id=641416
4. https://stackoverflow.com/questions/12629042/g-4-6-real-error-unrecognized-option-r
5. https://curl.haxx.se/mail/archive-2014-11/0005.html
6. https://gcc.gnu.org/gcc-4.6/changes.html

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

Looking at that HP/UX configure patch I was reminded of being annoyed
by the NO_R_TO_GCC_LINKER flag.

 Makefile | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/Makefile b/Makefile
index f965509b3c..ce7a489d64 100644
--- a/Makefile
+++ b/Makefile
@@ -265,10 +265,6 @@ all::
 #
 # Define NO_DEFLATE_BOUND if your zlib does not have deflateBound.
 #
-# Define NO_R_TO_GCC_LINKER if your gcc does not like "-R/path/lib"
-# that tells runtime paths to dynamic libraries;
-# "-Wl,-rpath=/path/lib" is used instead.
-#
 # Define NO_NORETURN if using buggy versions of gcc 4.6+ and profile feedback,
 # as the compiler can crash (http://gcc.gnu.org/bugzilla/show_bug.cgi?id=49299)
 #
@@ -1160,6 +1156,7 @@ endif
 # which'll override these defaults.
 CFLAGS = -g -O2 -Wall
 LDFLAGS =
+CC_LD_DYNPATH = -Wl,-rpath,
 BASIC_CFLAGS = -I.
 BASIC_LDFLAGS =
 
@@ -1287,16 +1284,6 @@ ifeq ($(uname_S),Darwin)
 	PTHREAD_LIBS =
 endif
 
-ifndef CC_LD_DYNPATH
-	ifdef NO_R_TO_GCC_LINKER
-		# Some gcc does not accept and pass -R to the linker to specify
-		# the runtime dynamic library path.
-		CC_LD_DYNPATH = -Wl,-rpath,
-	else
-		CC_LD_DYNPATH = -R
-	endif
-endif
-
 ifdef NO_LIBGEN_H
 	COMPAT_CFLAGS += -DNO_LIBGEN_H
 	COMPAT_OBJS += compat/basename.o
-- 
2.21.0.1020.gf2820cf01a

