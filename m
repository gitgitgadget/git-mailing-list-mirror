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
	by dcvr.yhbt.net (Postfix) with ESMTP id 5EF221F463
	for <e@80x24.org>; Tue, 10 Sep 2019 16:07:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394124AbfIJQHG (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Sep 2019 12:07:06 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43599 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394120AbfIJQHG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Sep 2019 12:07:06 -0400
Received: by mail-pg1-f194.google.com with SMTP id u72so9966818pgb.10
        for <git@vger.kernel.org>; Tue, 10 Sep 2019 09:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=62QPl/eATxJLwhXUCVdc9ZFRrSw9g0cTr5KQhJsoS58=;
        b=tJ69NJm/EU+K2Ld5qtGCUsOCYVss37kCdGvmrHHwB9+SKZ73kbCCt49YgWC6eq4H1z
         wiysL/GsRCtXzQeYPRNPU0ATpjWb/mhY3ifMiKSRzJcauIjrIgW+jJCkXANvlv+ca/Ba
         W+f1RwDv9WdohVaNzkEEOrf9NLUb1+CeWx4pcJadZiWbBLb0FcbPkYuyP1Qs89X9xP9w
         rTjiyS5cHiMQar+MfwsN4YxhrV48zbfsU8p4E1D2l94b32QOfg7ZgrUmxZkDKAvil2ak
         7X0iMWcPBmeet458hlAB7Jtq+Xts2M1kRDqQaVAwNNg0nXye2RdgHl4kp1a/5EFQUh83
         bC7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=62QPl/eATxJLwhXUCVdc9ZFRrSw9g0cTr5KQhJsoS58=;
        b=Sp+wp9SAV787OFg21Md81EnJ/INPcbxFY8ppX/il8f+PWxm/vq1uhkcsqkVFCIGsQF
         CCR4nJy0FnU4TdcfPlmt8HEKYPiokvsS2VNnTUFsq8gKbr9/anY5PSAvrHKNweGvExcE
         YX18QFY17io5hMPnRhMVf8BSPonBJjLwTmvoJbkBs0nKFwf3YKPyufuKqcHGVD1fB9Uc
         ugfWXQtx5Kj0mftIlZ4qILJhW7V7LhViFaqQYLU9giJ+QrNTADE+2F9ajKNGnDcSlfe9
         0jV9ELMO8F+iue/x3hnl1FrxkP9yxwfO/nOtorGQ0VTkGTb2/vGdVDGybSXwpFuxsSsF
         eEGQ==
X-Gm-Message-State: APjAAAWxpDwWFOG2zooGFO89kTz1lFLM85K960BfKUPbKqy+ChaYeu4L
        n6ZpLJ/9iGBxUJZeNkGI83A=
X-Google-Smtp-Source: APXvYqz1vQc3QUdov6iXeC2SGvktE+6WpI0FILh+V43V8qQsLu3bB9olQrdWsPXCNYgLhS8GjftHYg==
X-Received: by 2002:a62:cb:: with SMTP id 194mr38139195pfa.130.1568131625093;
        Tue, 10 Sep 2019 09:07:05 -0700 (PDT)
Received: from archbookpro.localdomain ([2601:646:280:1b30::6486])
        by smtp.gmail.com with ESMTPSA id t6sm17082094pgu.23.2019.09.10.09.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2019 09:07:03 -0700 (PDT)
Date:   Tue, 10 Sep 2019 09:07:02 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Makefile: run coccicheck on more source files
Message-ID: <20190910160702.GA111040@archbookpro.localdomain>
References: <cover.1568101393.git.liu.denton@gmail.com>
 <f62b0c7d1774cefc66e519430515eeb64acad1e0.1568101393.git.liu.denton@gmail.com>
 <20190910132813.GJ32087@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190910132813.GJ32087@szeder.dev>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 10, 2019 at 03:28:13PM +0200, SZEDER Gábor wrote:
> On Tue, Sep 10, 2019 at 12:44:31AM -0700, Denton Liu wrote:
> > Before, when running the "coccicheck" target, only the source files
> > which were being compiled would have been checked by Coccinelle.
> > However, just because we aren't compiling a source file doesn't mean we
> > have to exclude it from analysis. This will allow us to catch more
> > mistakes, in particular ones that affect Windows-only sources since
> > Coccinelle currently runs only on Linux.
> > 
> > Make the "coccicheck" target run on all C sources except for those that
> > are taken from some upstream. We don't want to patch these files since
> > we want them to be as close to upstream as possible so that it'll be
> > easier to pull in upstream updates.
> > 
> > This results in the following sources now being checked:
> > 
> > * block-sha1/sha1.c
> > * compat/access.c
> > * compat/basename.c
> > * compat/fileno.c
> > * compat/gmtime.c
> > * compat/hstrerror.c
> > * compat/memmem.c
> > * compat/mingw.c
> 
> When applying 'array.cocci' to 'compat/mingw.c' Coccinelle 1.0.4 (the
> version shipped in Ubuntu 16.04, i.e. what is used in our static
> analysis CI job) suggests to use the COPY_ARRAY macro instead of
> memcpy():
> 
> diff -u -p a/compat/mingw.c b/compat/mingw.c
> --- a/compat/mingw.c
> +++ b/compat/mingw.c
> @@ -1265,7 +1265,7 @@ static wchar_t *make_environment_block(c
>  		}
>  
>  		ALLOC_ARRAY(result, size);
> -		memcpy(result, wenv, size * sizeof(*wenv));
> +		COPY_ARRAY(result, wenv, size);
>  		FreeEnvironmentStringsW(wenv);
>  		return result;
>  	}
> @@ -1309,7 +1309,7 @@ static wchar_t *make_environment_block(c
>  			continue;
>  
>  		size = wcslen(array[i]) + 1;
> -		memcpy(p, array[i], size * sizeof(*p));
> +		COPY_ARRAY(p, array[i], size);
>  		p += size;
>  	}
>  	*p = L'\0';
> 
> This patch series should apply these suggestions in preparatory
> patches to make sure that our CI builds still pass.

This patch series depends on the "dl/compat-cleanup" branch, which
should've already made these changes.

> 
> > * compat/mkdir.c
> > * compat/mkdtemp.c
> > * compat/mmap.c
> > * compat/msvc.c
> > * compat/pread.c
> > * compat/precompose_utf8.c
> > * compat/qsort.c
> > * compat/setenv.c
> > * compat/sha1-chunked.c
> > * compat/snprintf.c
> > * compat/stat.c
> > * compat/strcasestr.c
> > * compat/strdup.c
> > * compat/strtoimax.c
> > * compat/strtoumax.c
> > * compat/unsetenv.c
> > * compat/win32/dirent.c
> > * compat/win32/path-utils.c
> > * compat/win32/pthread.c
> > * compat/win32/syslog.c
> > * compat/win32/trace2_win32_process_info.c
> > * compat/win32mmap.c
> > * compat/winansi.c
> > * ppc/sha1.c
> > 
> > This also results in the following source now being excluded:
> > 
> > * compat/obstack.c
> 
> Why mention this file here, and, more importantly, why mention _only_
> this file here?  According to the previous patch, there should be a
> few more excluded files...

I guess this commit message is pretty weak since this only really
applies to my system. I'll mention in a reroll that this was for a
standard build with no additional flags on Arch Linux to be specific.

I got these lists by dumping the contents of $(COCCI_SOURCES) before and
after applying the patch and, with my "standard" build, it seems like
the only upstream file that was being checked before was
compat/obstack.c.

I don't have build options like, for example, NO_REGEX enabled so the
regex stuff wasn't being built in the first place but for users that
might want to run coccicheck on such a platform (do they even exist?),
this would benefit them.

> 
> > Signed-off-by: Denton Liu <liu.denton@gmail.com>
> > ---
> >  Makefile | 8 ++------
> >  1 file changed, 2 insertions(+), 6 deletions(-)
> > 
> > diff --git a/Makefile b/Makefile
> > index 708df2c289..d468b7c9c4 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -2802,12 +2802,8 @@ check: command-list.h
> >  		exit 1; \
> >  	fi
> >  
> > -C_SOURCES = $(patsubst %.o,%.c,$(C_OBJ))
> > -ifdef DC_SHA1_SUBMODULE
> > -COCCI_SOURCES = $(filter-out sha1collisiondetection/%,$(C_SOURCES))
> > -else
> > -COCCI_SOURCES = $(filter-out sha1dc/%,$(C_SOURCES))
> > -endif
> > +FIND_C_SOURCES = $(filter %.c,$(shell $(FIND_SOURCE_FILES)))
> > +COCCI_SOURCES = $(filter-out $(UPSTREAM_SOURCES),$(FIND_C_SOURCES))
> >  
> >  %.cocci.patch: %.cocci $(COCCI_SOURCES)
> >  	@echo '    ' SPATCH $<; \
> > -- 
> > 2.23.0.248.g3a9dd8fb08
> > 
