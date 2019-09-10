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
	by dcvr.yhbt.net (Postfix) with ESMTP id A6F761F463
	for <e@80x24.org>; Tue, 10 Sep 2019 07:44:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390775AbfIJHoe (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Sep 2019 03:44:34 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44982 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbfIJHoe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Sep 2019 03:44:34 -0400
Received: by mail-pg1-f193.google.com with SMTP id i18so9331334pgl.11
        for <git@vger.kernel.org>; Tue, 10 Sep 2019 00:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mgvKlZQ+caBVrkuSI3jsJDi8Z2HXTA6KVkaVmscn5V8=;
        b=fwOJlQNS/J23KdUf/bdvExo1c1t2jbGUfr98s0+GVIAQbgj1T0UTKwog3uo1bJN8mc
         CGtGgiApAvOEydfAa/b2XCsEAVJgnuqZg3Dx8mhQ3WSbKf0Op7Xbg3Lo/wt2mo9lzqVI
         k/6hhgUicgGUu6tYmLiT3DfevutOyrCxIY010wa6oEM3Fap++TQbLuo2RVOgi0CORP+l
         OqmyMO5CkVYidl2IXVdL28nJY1dXqhLoubmCuh3eoUN1MVA/FhY+Brt4KZUgBVlBqK/a
         L+BpAhpoxHedtKv+l5ZSxr8yAn5oYq7Xl5hMxxp4VmlqoE0nKBhftgdl+qXgBFcU/qr/
         PwmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mgvKlZQ+caBVrkuSI3jsJDi8Z2HXTA6KVkaVmscn5V8=;
        b=gQpQx8e+kHBVqEtsCC4xdWiOYoSjyCYeYK0aPcwPEWR1NRH55Du/mhuZNIwqXqaZZl
         5VRATEB1NxgqjoWJ1nz/6LqHYj5Bj/RTB39HUqVE8UrVyksqjT8oLn+txzJyNVAtC3i5
         OxCcl0hl7wcNIGUBnyhdjCHTd2/Lw6tRq5aq3TPzy8HChq2XROtjncTlslHQLPwmPYdf
         B3BkW8f6JClpOL4rEH4Yf0lNcLesG6SoXE8NLskvcY6WI3LRlhf668ljhQ/Evh2CcCkF
         f3AS2gZWw74HA4iTBLHP9RQMIuWiXnbqFpdl9Ln+xQ7KN3vlElHpiREkoS66G9LiPEE5
         m7LA==
X-Gm-Message-State: APjAAAUBSJlumz47u4O50eOAvg/v9Pa6XcnU0+TD9te5yloqHSpZM4LN
        sfdFG3lETq8n9WBu1M5E8ZJ9U8HJJrA=
X-Google-Smtp-Source: APXvYqx9zTfFTvZyxiYNtuDmV/tAYzh7aOEcDNJiUWZlLET1TQh9+rnJ8AS0k3xkQsayOHCbJzVIIA==
X-Received: by 2002:aa7:9e05:: with SMTP id y5mr34919984pfq.38.1568101473241;
        Tue, 10 Sep 2019 00:44:33 -0700 (PDT)
Received: from archbookpro.localdomain ([2601:646:280:1b30::6486])
        by smtp.gmail.com with ESMTPSA id v21sm1776078pjy.3.2019.09.10.00.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2019 00:44:32 -0700 (PDT)
Date:   Tue, 10 Sep 2019 00:44:31 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] Makefile: run coccicheck on more source files
Message-ID: <f62b0c7d1774cefc66e519430515eeb64acad1e0.1568101393.git.liu.denton@gmail.com>
References: <cover.1568101393.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1568101393.git.liu.denton@gmail.com>
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
are taken from some upstream. We don't want to patch these files since
we want them to be as close to upstream as possible so that it'll be
easier to pull in upstream updates.

This results in the following sources now being checked:

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
index 708df2c289..d468b7c9c4 100644
--- a/Makefile
+++ b/Makefile
@@ -2802,12 +2802,8 @@ check: command-list.h
 		exit 1; \
 	fi
 
-C_SOURCES = $(patsubst %.o,%.c,$(C_OBJ))
-ifdef DC_SHA1_SUBMODULE
-COCCI_SOURCES = $(filter-out sha1collisiondetection/%,$(C_SOURCES))
-else
-COCCI_SOURCES = $(filter-out sha1dc/%,$(C_SOURCES))
-endif
+FIND_C_SOURCES = $(filter %.c,$(shell $(FIND_SOURCE_FILES)))
+COCCI_SOURCES = $(filter-out $(UPSTREAM_SOURCES),$(FIND_C_SOURCES))
 
 %.cocci.patch: %.cocci $(COCCI_SOURCES)
 	@echo '    ' SPATCH $<; \
-- 
2.23.0.248.g3a9dd8fb08

