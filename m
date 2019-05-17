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
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E15D1F461
	for <e@80x24.org>; Fri, 17 May 2019 21:59:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727367AbfEQV7A (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 May 2019 17:59:00 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39220 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbfEQV7A (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 May 2019 17:59:00 -0400
Received: by mail-wr1-f65.google.com with SMTP id w8so8561215wrl.6
        for <git@vger.kernel.org>; Fri, 17 May 2019 14:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3Uoycpqd2W82y3dKu1IxpyY08Hq+RMsZwZ3Vk6TJyLo=;
        b=As0s/dYsZLASedHX11xmt/aFBYZiSn/misj7YLqCmke9HQDKyPPlSWIhI/EKpNAKaP
         ZwycUo/uUq8bRS78DwJq1XVtONRLpUh4b06eNfhADmwVv7hAZyeyStpaOUK3DogcohuH
         ExoQvrEFMRR2S7rzh7we/o2Ghv03Vi1hKSSb8WjElFVQIfwARKoLVtaJpJTzRIpfpSnS
         kbKY3wQwjaYTTU4MsujOHRCslxP8/COZ0nB/klTDDGsr5bUHb9od6e0r4NsJulMyNLyT
         ELfX9w9H7dDbRH7ZzuHi9JQHrpaPU1IDyCP7B3MngyecSha4+t6263JOABGFigyKPS+R
         1uhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3Uoycpqd2W82y3dKu1IxpyY08Hq+RMsZwZ3Vk6TJyLo=;
        b=AJQ440GH0VLB/SNNkjWgS2BTwNT1ltOyIoBT6g2kXecDVRiaaXauTT6ZL08V22ns7E
         KL0PyZ+6wOV32PaWL4kxFmvSqwatY9+l5yvoaSKix9Dkl311pA5gMLIKAgbuDtqq6U9b
         SZo3vIfNPKqkCmnM0GcfB/5lkBC9T36AfuHzBdJt4fzqEC7W4a0hVCknDH7Rj3LDl4c3
         8CphTZ7Syazt4PdQmKMUM1GWPJw/prOtcHaHe+nieMwPNhzRDsAE92v1/Qy/o3UbfciL
         CjVLnoMzcJEeMWNPtR3l22Q4j/gR1lQh2x9DXut/fiZcLg+5YHIzLSrRxwGh4oiUZcpb
         edlQ==
X-Gm-Message-State: APjAAAWxcyK8e9O1lpxm8yta4PxLAQ3VUp4WuMa9TGaga5U04HPB5qQY
        yhtjBUKMpu8cRf9AtdXAwTRUb98gmGw=
X-Google-Smtp-Source: APXvYqyGiUurMnEohuHGQnbCLB4iv3axOURhW64fVb4Z0HYyOWKsyy4iqhzAHe/Bwu9Y6CFcnmk2uw==
X-Received: by 2002:adf:d089:: with SMTP id y9mr19279387wrh.239.1558130336782;
        Fri, 17 May 2019 14:58:56 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y40sm16640846wrd.96.2019.05.17.14.58.54
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 17 May 2019 14:58:54 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Michael Osipov <michael.osipov@siemens.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2] Makefile: remove the NO_R_TO_GCC_LINKER flag
Date:   Fri, 17 May 2019 23:58:47 +0200
Message-Id: <20190517215847.28179-1-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a
In-Reply-To: <xmqqd0ki3s0q.fsf@gitster-ct.c.googlers.com>
References: <xmqqd0ki3s0q.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change our default CC_LD_DYNPATH invocation to something GCC likes
these days. Since the GCC 4.6 release unknown flags haven't been
passed through to ld(1). Thus our previous default of CC_LD_DYNPATH=-R
would cause an error on modern GCC unless NO_R_TO_GCC_LINKER was set.

This CC_LD_DYNPATH flag is really obscure, and I don't expect anyone
except those working on git development ever use this.

It's not needed to simply link to libraries like say libpcre,
but *only* for those cases where we're linking to such a library not
present in the OS's library directories. See e.g. ldconfig(8) on Linux
for more details.

I use this to compile my git with a LIBPCREDIR=$HOME/g/pcre2/inst as
I'm building that from source, but someone maintaining an OS package
is almost certainly not going to use this. They're just going to set
USE_LIBPCRE=YesPlease after installing the libpcre dependency,
which'll point to OS libraries which ld(1) will find without the help
of CC_LD_DYNPATH.

Another thing that helps mitigate any potential breakage is that we
detect the right type of invocation in configure.ac, which e.g. HP/UX
uses[1], as does IBM's AIX package[2]. From what I can tell both AIX
and Solaris packagers are building git with GCC, so I'm not adding a
corresponding config.mak.uname default to cater to their OS-native
linkers.

Now for an overview of past development in this area:

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
invocation back then, or since at least binutils-gdb.git's[3]
a1ad915dc4 ("[...]Add support for -rpath[...]", 1994-07-20).

Further reading and prior art can be found at [4][5][6][7]. Making a
plain "-R" an error seems from reading those reports to have been
introduced in GCC 4.6 released on March 25, 2011[8], but I couldn't
confirm this with absolute certainty, its release notes are ambiguous
on the subject, and I couldn't be bothered to try to build & bisect it
against GCC 4.5.

1. https://public-inbox.org/git/20190516093412.14795-1-avarab@gmail.com/
2. https://www.ibm.com/developerworks/aix/library/aix-toolbox/alpha.html
3. git://sourceware.org/git/binutils-gdb.git
4. https://github.com/tsuna/boost.m4/issues/15
5. https://bugzilla.gnome.org/show_bug.cgi?id=641416
6. https://stackoverflow.com/questions/12629042/g-4-6-real-error-unrecognized-option-r
7. https://curl.haxx.se/mail/archive-2014-11/0005.html
8. https://gcc.gnu.org/gcc-4.6/changes.html

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

On Fri, May 17 2019, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
>
>> Far be it from me to care about AIX, but it seems like this is ripe for
>> regressions, because we don't know which platforms were relying on "-R"
>> instead of "-Wl,-rpath", and now everybody will be using the latter by
>> default.
>
> I do not have a stake in AIX, either, but I had the same reaction.

I did a bad job of summarizing why this change makes sense. Here's a
v2 with a changed commit message. The first 4 pargaraphs are most
relevant.

Range-diff:
1:  bd9558b1cf ! 1:  56abcd0fae Makefile: remove the NO_R_TO_GCC_LINKER flag
    @@ -2,13 +2,34 @@
     
         Makefile: remove the NO_R_TO_GCC_LINKER flag
     
    -    Remove the NO_R_TO_GCC_LINKER flag, thus switching the default to
    -    "-Wl,-rpath,$LIBPATH" instead of our current "-R$LIBPATH". This is a
    -    relatively obscure thing that only kicks in when using one of the
    -    LIBDIR flags, e.g. LIBPCREDIR or CURLDIR.
    +    Change our default CC_LD_DYNPATH invocation to something GCC likes
    +    these days. Since the GCC 4.6 release unknown flags haven't been
    +    passed through to ld(1). Thus our previous default of CC_LD_DYNPATH=-R
    +    would cause an error on modern GCC unless NO_R_TO_GCC_LINKER was set.
     
    -    How we invoke the linker to do this can still be overridden with
    -    CC_LD_DYNPATH, as seen in our configure.ac script.
    +    This CC_LD_DYNPATH flag is really obscure, and I don't expect anyone
    +    except those working on git development ever use this.
    +
    +    It's not needed to simply link to libraries like say libpcre,
    +    but *only* for those cases where we're linking to such a library not
    +    present in the OS's library directories. See e.g. ldconfig(8) on Linux
    +    for more details.
    +
    +    I use this to compile my git with a LIBPCREDIR=$HOME/g/pcre2/inst as
    +    I'm building that from source, but someone maintaining an OS package
    +    is almost certainly not going to use this. They're just going to set
    +    USE_LIBPCRE=YesPlease after installing the libpcre dependency,
    +    which'll point to OS libraries which ld(1) will find without the help
    +    of CC_LD_DYNPATH.
    +
    +    Another thing that helps mitigate any potential breakage is that we
    +    detect the right type of invocation in configure.ac, which e.g. HP/UX
    +    uses[1], as does IBM's AIX package[2]. From what I can tell both AIX
    +    and Solaris packagers are building git with GCC, so I'm not adding a
    +    corresponding config.mak.uname default to cater to their OS-native
    +    linkers.
    +
    +    Now for an overview of past development in this area:
     
         Our use of "-R" dates back to 455a7f3275 ("More portability.",
         2005-09-30). Soon after that in bbfc63dd78 ("gcc does not necessarily
    @@ -22,32 +43,24 @@
     
         From what I can tell we should, with the benefit of hindsight, have
         made this change back in 2006. GCC & ld supported this type of
    -    invocation back then, or since at least binutils-gdb.git's[1]
    -    a1ad915dc4 ("[...]Add support for -rpath[...]", 1994-07-20). Most
    -    people compiling git with a custom LIBDIR are going to be on a GNU-ish
    -    system, and having to provide this NO_R_TO_GCC_LINKER flag on top of a
    -    custom LIBDIR is annoying.
    -
    -    There are some OS's that don't support -rpath, e.g. AIX ld just
    -    supports "-R". Perhaps we should follow this up with some
    -    config.mak.uname changes, but as noted it's quite possible that nobody
    -    on these platforms uses this (instead libraries in the system's search
    -    path). We *could* also use "-Wl,-R", but let's not introduce something
    -    new.
    +    invocation back then, or since at least binutils-gdb.git's[3]
    +    a1ad915dc4 ("[...]Add support for -rpath[...]", 1994-07-20).
     
    -    Further reading and prior art can be found at [2][3][4][5]. Making a
    +    Further reading and prior art can be found at [4][5][6][7]. Making a
         plain "-R" an error seems from reading those reports to have been
    -    introduced in GCC 4.6 released on March 25, 2011, but I couldn't
    +    introduced in GCC 4.6 released on March 25, 2011[8], but I couldn't
         confirm this with absolute certainty, its release notes are ambiguous
         on the subject, and I couldn't be bothered to try to build & bisect it
         against GCC 4.5.
     
    -    1. git://sourceware.org/git/binutils-gdb.git
    -    2. https://github.com/tsuna/boost.m4/issues/15
    -    3. https://bugzilla.gnome.org/show_bug.cgi?id=641416
    -    4. https://stackoverflow.com/questions/12629042/g-4-6-real-error-unrecognized-option-r
    -    5. https://curl.haxx.se/mail/archive-2014-11/0005.html
    -    6. https://gcc.gnu.org/gcc-4.6/changes.html
    +    1. https://public-inbox.org/git/20190516093412.14795-1-avarab@gmail.com/
    +    2. https://www.ibm.com/developerworks/aix/library/aix-toolbox/alpha.html
    +    3. git://sourceware.org/git/binutils-gdb.git
    +    4. https://github.com/tsuna/boost.m4/issues/15
    +    5. https://bugzilla.gnome.org/show_bug.cgi?id=641416
    +    6. https://stackoverflow.com/questions/12629042/g-4-6-real-error-unrecognized-option-r
    +    7. https://curl.haxx.se/mail/archive-2014-11/0005.html
    +    8. https://gcc.gnu.org/gcc-4.6/changes.html
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     

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

