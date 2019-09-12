Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD0B61F463
	for <e@80x24.org>; Thu, 12 Sep 2019 17:28:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387591AbfILR2i (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Sep 2019 13:28:38 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37817 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387586AbfILR2h (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Sep 2019 13:28:37 -0400
Received: by mail-pf1-f193.google.com with SMTP id y5so13672679pfo.4
        for <git@vger.kernel.org>; Thu, 12 Sep 2019 10:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CuhcoxJiKt3J4npi8BuBrRMakJIaTV+bgoL1UldyRz8=;
        b=ngrNwlx9TITshCguUrnyPjY40MrV9mns30VTtZCba4CS6G45XiHNN/ysMtQWcEyQUL
         9mNlC+JXbr68ESKHtOGVlxwtZlehzuDO8ZQR891US8r276qmBcl3nOsxTWcY/MZEFsIs
         9VgrasnvTgF/Ysysu9It5zt3mQjbjFBYXRdDh77bGfiyi+vZl7G40a/baNP0oFp5b16k
         fzQWxUc/t6W6ltj2D8W6XLAkLOHx+H3PfLNfUFoUWRPUA/IHLifYcTMG0T/LsYcXnYby
         P4zmxCHgC+GZx0XyuYSAnBNEByUDO1F5QSl1XzNZWt1DXI4kk/RBvlYm1I5/29frrj5D
         pSmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CuhcoxJiKt3J4npi8BuBrRMakJIaTV+bgoL1UldyRz8=;
        b=IVK0hgP/XXOD3p5AwA4CRkf2I5nqvgm30BPeFNezBZxksL/RsGH/mgKHoI0mGDeYud
         +3DovRtflfSLdNBTBTzOMYSPgi+2pofKxrNLFDG+FLiwT0fFhP4nQBRCnXAOO0eCZUAO
         WVvOAd3qUGAWdaIVcsBrtnnIyrC6wyz+1B/92UdR13QCZZfOYSOL91IXFN7+oPcFtR5X
         kS76ck2g7g2r3kAe4L4Suz1ZlVnlrmpIssai2prEVOGBLI8k10oC7is8We3A3Hbxd/PI
         XK1lkaUKG6bJ3rUc3J6/w/0T66ge17B6OY5+/F4kSv4Y865bzGrjeiYU+lUMpTBb8hSn
         xF1A==
X-Gm-Message-State: APjAAAWDJp7r5iSk8FObalmc+9/zWHlhfVyNNaSIaTGTNddS12nFzxoE
        /q+SoMqxz0OGruNXgYdr0Ra/2rrZEQI=
X-Google-Smtp-Source: APXvYqwa7bEnKDEWpMtFRK8m8Mv5xn9yL7553cYgOnjhXlicfYIrL98Fb8JRJrGCvTY8K/xFTeGAWQ==
X-Received: by 2002:a63:1301:: with SMTP id i1mr3115447pgl.403.1568309316761;
        Thu, 12 Sep 2019 10:28:36 -0700 (PDT)
Received: from dentonliu-ltm.internal.salesforce.com ([204.14.239.55])
        by smtp.gmail.com with ESMTPSA id a6sm6163196pfc.141.2019.09.12.10.28.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Sep 2019 10:28:36 -0700 (PDT)
Date:   Thu, 12 Sep 2019 10:28:34 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 3/3] Makefile: run coccicheck on more source files
Message-ID: <89b7e17469e19c9dca8afa729ec1a70f4e06a2b7.1568309119.git.liu.denton@gmail.com>
References: <cover.1568101393.git.liu.denton@gmail.com>
 <cover.1568309119.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1568309119.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before, when running the "coccicheck" target, only the source files
which were being compiled would have been checked by Coccinelle.
However, just because we aren't compiling a source file doesn't mean we
have to exclude it from analysis. This will allow us to catch more
mistakes, in particular ones that affect Windows-only sources since
Coccinelle currently runs only on Linux.

Make the "coccicheck" target run on all C sources except for those that
are taken from some third-party source. We don't want to patch these
files since we want them to be as close to upstream as possible so that
it'll be easier to pull in upstream updates.

When running a build on Arch Linux with no additional flags provided,
after applying this patch, the following sources are now checked:

* block-sha1/sha1.c
* compat/access.c
* compat/basename.c
* compat/fileno.c
* compat/gmtime.c
* compat/hstrerror.c
* compat/memmem.c
* compat/mingw.c
* compat/mkdir.c
* compat/mkdtemp.c
* compat/mmap.c
* compat/msvc.c
* compat/pread.c
* compat/precompose_utf8.c
* compat/qsort.c
* compat/setenv.c
* compat/sha1-chunked.c
* compat/snprintf.c
* compat/stat.c
* compat/strcasestr.c
* compat/strdup.c
* compat/strtoimax.c
* compat/strtoumax.c
* compat/unsetenv.c
* compat/win32/dirent.c
* compat/win32/path-utils.c
* compat/win32/pthread.c
* compat/win32/syslog.c
* compat/win32/trace2_win32_process_info.c
* compat/win32mmap.c
* compat/winansi.c
* ppc/sha1.c

This also results in the following source now being excluded:

* compat/obstack.c

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Makefile | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/Makefile b/Makefile
index e2c693440b..7c88e0606f 100644
--- a/Makefile
+++ b/Makefile
@@ -2803,12 +2803,8 @@ check: command-list.h
 		exit 1; \
 	fi
 
-C_SOURCES = $(patsubst %.o,%.c,$(C_OBJ))
-ifdef DC_SHA1_SUBMODULE
-COCCI_SOURCES = $(filter-out sha1collisiondetection/%,$(C_SOURCES))
-else
-COCCI_SOURCES = $(filter-out sha1dc/%,$(C_SOURCES))
-endif
+FIND_C_SOURCES = $(filter %.c,$(shell $(FIND_SOURCE_FILES)))
+COCCI_SOURCES = $(filter-out $(THIRD_PARTY_SOURCES),$(FIND_C_SOURCES))
 
 %.cocci.patch: %.cocci $(COCCI_SOURCES)
 	@echo '    ' SPATCH $<; \
-- 
2.23.0.37.g745f681289

