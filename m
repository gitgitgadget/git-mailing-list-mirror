Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D8C11F463
	for <e@80x24.org>; Tue, 10 Sep 2019 13:28:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730225AbfIJN2S (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Sep 2019 09:28:18 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34065 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726394AbfIJN2S (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Sep 2019 09:28:18 -0400
Received: by mail-wr1-f67.google.com with SMTP id a11so10498221wrx.1
        for <git@vger.kernel.org>; Tue, 10 Sep 2019 06:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=b9DiTBbqoZZIUCBS7+xbW7oUtNLjiF1zON8jitOOW2o=;
        b=qIkdqYiUyLYjpv+gJy+4u2tA6Xc9I3Cx8M6Kw1Oe2zQyuezIbBCPda7yr2Voz0rCSq
         CL2WyYXVYtNMrovbLAY6wPBnd6EtvBKjkJsmqEHsCGsiEtGpXHCZU9RHsL/5g0R2bvv4
         VshReJt8+BAwUBTwg6YzNOCCMyxWPNqEwaHBMv5fQbZU8EvOae1SMvUh0NIkZL4K6P/p
         Cic5XjS8lhQp9ojdd2JRTlgfWxB8dOBx/Aai3YmvRh55AIir06vcIQVYv8J5lyZp+fbR
         tQozQOc135C2L6oJV40pvJhmHSsMw16HaMCQBdDPzmkGOlH/SAlCLyqatw9sgeU3UTu5
         sbqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=b9DiTBbqoZZIUCBS7+xbW7oUtNLjiF1zON8jitOOW2o=;
        b=qDNZQ+r7r6IQZILixLItrFFNCmpubx6aMdTzLouQJxaxv5NJdAXqxwZU73phEzXAJY
         dHVUN0AGkttXUfo+yv10prNIFQBDxlrhLoazwhiAYoCcFdkoPs0NdJ+O+NNtp95y0004
         WAB73zERsqHWvZ4qoh3CG8/v8ZVertTNBMZoaUcxP0pOI54b5AinTcRqUqT/5MNXJZqU
         SvPAzP4DQq7TxwJ4RUKx3oBjFBPzfZGATgywzexTRy9NqzkA8C1472EgTfd3H4GbAYyi
         nhLTwTnuhTStkn7OMaxWkSzJhKjCaQ/T/WHH58u2H0otYknygMNVxwQco8qkcwQ+MuQa
         jupQ==
X-Gm-Message-State: APjAAAUb26IMmHzprMus1L/srpNQj3Ab0i2tKylO5rbE3lV1MpW6h0GK
        PVL0PUDuhrm/4GuduKFlq1s=
X-Google-Smtp-Source: APXvYqxDsY9cRKp9WAEn9ZvaUA/tDDUx7bBoOSIPMh0bxS7SCd5sjBweyBSpb4EFecG5FZL11CiTVA==
X-Received: by 2002:adf:828d:: with SMTP id 13mr13836093wrc.115.1568122096403;
        Tue, 10 Sep 2019 06:28:16 -0700 (PDT)
Received: from szeder.dev (x4dbe1e6e.dyn.telefonica.de. [77.190.30.110])
        by smtp.gmail.com with ESMTPSA id c74sm2722682wme.46.2019.09.10.06.28.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Sep 2019 06:28:15 -0700 (PDT)
Date:   Tue, 10 Sep 2019 15:28:13 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Makefile: run coccicheck on more source files
Message-ID: <20190910132813.GJ32087@szeder.dev>
References: <cover.1568101393.git.liu.denton@gmail.com>
 <f62b0c7d1774cefc66e519430515eeb64acad1e0.1568101393.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f62b0c7d1774cefc66e519430515eeb64acad1e0.1568101393.git.liu.denton@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 10, 2019 at 12:44:31AM -0700, Denton Liu wrote:
> Before, when running the "coccicheck" target, only the source files
> which were being compiled would have been checked by Coccinelle.
> However, just because we aren't compiling a source file doesn't mean we
> have to exclude it from analysis. This will allow us to catch more
> mistakes, in particular ones that affect Windows-only sources since
> Coccinelle currently runs only on Linux.
> 
> Make the "coccicheck" target run on all C sources except for those that
> are taken from some upstream. We don't want to patch these files since
> we want them to be as close to upstream as possible so that it'll be
> easier to pull in upstream updates.
> 
> This results in the following sources now being checked:
> 
> * block-sha1/sha1.c
> * compat/access.c
> * compat/basename.c
> * compat/fileno.c
> * compat/gmtime.c
> * compat/hstrerror.c
> * compat/memmem.c
> * compat/mingw.c

When applying 'array.cocci' to 'compat/mingw.c' Coccinelle 1.0.4 (the
version shipped in Ubuntu 16.04, i.e. what is used in our static
analysis CI job) suggests to use the COPY_ARRAY macro instead of
memcpy():

diff -u -p a/compat/mingw.c b/compat/mingw.c
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1265,7 +1265,7 @@ static wchar_t *make_environment_block(c
 		}
 
 		ALLOC_ARRAY(result, size);
-		memcpy(result, wenv, size * sizeof(*wenv));
+		COPY_ARRAY(result, wenv, size);
 		FreeEnvironmentStringsW(wenv);
 		return result;
 	}
@@ -1309,7 +1309,7 @@ static wchar_t *make_environment_block(c
 			continue;
 
 		size = wcslen(array[i]) + 1;
-		memcpy(p, array[i], size * sizeof(*p));
+		COPY_ARRAY(p, array[i], size);
 		p += size;
 	}
 	*p = L'\0';

This patch series should apply these suggestions in preparatory
patches to make sure that our CI builds still pass.

> * compat/mkdir.c
> * compat/mkdtemp.c
> * compat/mmap.c
> * compat/msvc.c
> * compat/pread.c
> * compat/precompose_utf8.c
> * compat/qsort.c
> * compat/setenv.c
> * compat/sha1-chunked.c
> * compat/snprintf.c
> * compat/stat.c
> * compat/strcasestr.c
> * compat/strdup.c
> * compat/strtoimax.c
> * compat/strtoumax.c
> * compat/unsetenv.c
> * compat/win32/dirent.c
> * compat/win32/path-utils.c
> * compat/win32/pthread.c
> * compat/win32/syslog.c
> * compat/win32/trace2_win32_process_info.c
> * compat/win32mmap.c
> * compat/winansi.c
> * ppc/sha1.c
> 
> This also results in the following source now being excluded:
> 
> * compat/obstack.c

Why mention this file here, and, more importantly, why mention _only_
this file here?  According to the previous patch, there should be a
few more excluded files...

> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
>  Makefile | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 708df2c289..d468b7c9c4 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2802,12 +2802,8 @@ check: command-list.h
>  		exit 1; \
>  	fi
>  
> -C_SOURCES = $(patsubst %.o,%.c,$(C_OBJ))
> -ifdef DC_SHA1_SUBMODULE
> -COCCI_SOURCES = $(filter-out sha1collisiondetection/%,$(C_SOURCES))
> -else
> -COCCI_SOURCES = $(filter-out sha1dc/%,$(C_SOURCES))
> -endif
> +FIND_C_SOURCES = $(filter %.c,$(shell $(FIND_SOURCE_FILES)))
> +COCCI_SOURCES = $(filter-out $(UPSTREAM_SOURCES),$(FIND_C_SOURCES))
>  
>  %.cocci.patch: %.cocci $(COCCI_SOURCES)
>  	@echo '    ' SPATCH $<; \
> -- 
> 2.23.0.248.g3a9dd8fb08
> 
