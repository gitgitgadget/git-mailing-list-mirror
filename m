Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1E751F404
	for <e@80x24.org>; Sat, 17 Mar 2018 14:59:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752692AbeCQO72 (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Mar 2018 10:59:28 -0400
Received: from mail-lf0-f48.google.com ([209.85.215.48]:40591 "EHLO
        mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752077AbeCQO71 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Mar 2018 10:59:27 -0400
Received: by mail-lf0-f48.google.com with SMTP id e5-v6so15408180lfb.7
        for <git@vger.kernel.org>; Sat, 17 Mar 2018 07:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=v0VVeKTFnusa34eJsH5EQp4j4gkubnsuQ9csQ8b9tCk=;
        b=iChbIpQIKmkEyuM+JoUaPZcCuRLU8jWOsArMwH8adTFAcXPOYvAZmDbZXsi7n8sTcl
         ll7kg8eT0HZVQbweYWLl73ciqRCpjErSrD2Jdd4Bbq8eDHOC3PzqDwfDp8nPKN0mCDrK
         OTW8TvvMHHJxQc5KSVYXkE0nbX0F/jHgDFupFGDFI3yHFbqjfPMDq7BxINhGGXlNKvPK
         zdYbr0dCXQGx3dx+/ku9nmq/N/Ais71INn8gjosznxSn74dpp3GTyEdI/YDC6USCYWYq
         3/nHMTngl6nGQqFCUYZUNCBmjcZxJ1UjEIfpMrQzWBH6z3wm9Wdx45FqGshbb6CjXweR
         w5sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=v0VVeKTFnusa34eJsH5EQp4j4gkubnsuQ9csQ8b9tCk=;
        b=pI8hBoWu102/bCxxYNEJNQU2mHak3RdqwszA6AJ/ATZ8VzWZCWgD+Y1exQpxg9K1RY
         M7gLA+n2ryVqg+3gmQhxEqOLYG20xygMuzRTu6yvmKywUbLBrWYwNU3Em5y8aZoAWCkP
         Tpt1nClIychH0fbfjorcKRXU8FrsnX7NDe3/Hl/x7QeBN6OLgRvSQu9j8rpSGxdx/nQd
         A63ZMGlOIHBpmBbts8g9VLLGZic9XptwAx+kEQwyXxHWyw+Z5qyvcLgv2Sl9moGEU0l8
         Gtpg933V25dCsHanRP8rXHoU2OY/u2gszZeOUBxqfM65A+aQC1igmqSxsrPYHgJgmcAU
         QjqQ==
X-Gm-Message-State: AElRT7HkixkI7SGC7WfV/qUr76XOWd/eIlEWUrMh3itOLVW2QuUjQ1oM
        iTrSkg11IygKlEkqAnOlTPE=
X-Google-Smtp-Source: AG47ELtU5j59B2TAyXA4ZaGhcPHqh75iWfV49KWbcx3YAkB5C8vS02ixP9MM1QKy4OSgTzw4EGt5rA==
X-Received: by 10.46.155.135 with SMTP id z7mr3876390lji.125.1521298766405;
        Sat, 17 Mar 2018 07:59:26 -0700 (PDT)
Received: from duynguyen.home (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id z6sm2193808ljc.23.2018.03.17.07.59.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Mar 2018 07:59:25 -0700 (PDT)
Date:   Sat, 17 Mar 2018 15:59:23 +0100
From:   Duy Nguyen <pclouds@gmail.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v2] travis-ci: enable more warnings on travis linux-gcc
 job
Message-ID: <20180317145923.GA24689@duynguyen.home>
References: <20180303014605.10603-1-pclouds@gmail.com>
 <20180316193355.20161-1-pclouds@gmail.com>
 <20180316212208.GC12333@sigill.intra.peff.net>
 <CACsJy8A3_itjs0MRar+Aog=0yZDuAK2-x4MU=Rvqh2C6Le-7Aw@mail.gmail.com>
 <D8137CD9-9E11-4FBC-B89B-907C007FC6E9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D8137CD9-9E11-4FBC-B89B-907C007FC6E9@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 17, 2018 at 03:29:31PM +0100, Lars Schneider wrote:
> I interpreted Peff's comment like this:
> 
> If DEVELOPER=1 is set and we detect a gcc-6 in the makefile, 
> then we could set your additional flags in the makefile.
> 
> This way every developer with a new compiler would run these
> flags locally (if DEVELOPER=1 is set).

Aha. Something like this? I split developer cflags out to a separate
file because I imagine people may start to add gcc7, clang....

-- 8< --
diff --git a/.travis.yml b/.travis.yml
index 5f5ee4f3bd..0b3c50f5e7 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -16,10 +16,13 @@ compiler:
 
 addons:
   apt:
+    sources:
+    - ubuntu-toolchain-r-test
     packages:
     - language-pack-is
     - git-svn
     - apache2
+    - gcc-6
 
 matrix:
   include:
diff --git a/Makefile b/Makefile
index de4b8f0c02..e8321e44d6 100644
--- a/Makefile
+++ b/Makefile
@@ -436,15 +436,6 @@ GIT-VERSION-FILE: FORCE
 # CFLAGS and LDFLAGS are for the users to override from the command line.
 
 CFLAGS = -g -O2 -Wall
-DEVELOPER_CFLAGS = -Werror \
-	-Wdeclaration-after-statement \
-	-Wno-format-zero-length \
-	-Wold-style-definition \
-	-Woverflow \
-	-Wpointer-arith \
-	-Wstrict-prototypes \
-	-Wunused \
-	-Wvla
 LDFLAGS =
 ALL_CFLAGS = $(CPPFLAGS) $(CFLAGS)
 ALL_LDFLAGS = $(LDFLAGS)
@@ -1045,7 +1036,8 @@ include config.mak.uname
 -include config.mak
 
 ifdef DEVELOPER
-CFLAGS += $(DEVELOPER_CFLAGS)
+include config.mak.dev
+CFLAGS += $(DEV_CFLAGS)
 endif
 
 comma := ,
diff --git a/config.mak.dev b/config.mak.dev
index e69de29bb2..644d0d581f 100644
--- a/config.mak.dev
+++ b/config.mak.dev
@@ -0,0 +1,23 @@
+DEV_CFLAGS =
+DEV_CFLAGS += -Werror
+DEV_CFLAGS += -Wdeclaration-after-statement
+DEV_CFLAGS += -Wno-format-zero-length
+DEV_CFLAGS += -Wold-style-definition
+DEV_CFLAGS += -Woverflow
+DEV_CFLAGS += -Wpointer-arith
+DEV_CFLAGS += -Wstrict-prototypes
+DEV_CFLAGS += -Wunused
+DEV_CFLAGS += -Wvla
+
+GCC_VER := $(shell sh -c '$(CC) --version | grep ^gcc >/dev/null && $(CC) -dumpversion | cut -f 1 -d .')
+
+ifeq ($(GCC_VER),6)
+DEV_CFLAGS += -Wextra
+DEV_CFLAGS += -Wmissing-prototypes
+DEV_CFLAGS += -Wno-empty-body
+DEV_CFLAGS += -Wno-maybe-uninitialized
+DEV_CFLAGS += -Wno-missing-field-initializers
+DEV_CFLAGS += -Wno-sign-compare
+DEV_CFLAGS += -Wno-unused-function
+DEV_CFLAGS += -Wno-unused-parameter
+endif
-- 8< --
