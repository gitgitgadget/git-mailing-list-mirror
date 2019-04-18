Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F3CD20248
	for <e@80x24.org>; Thu, 18 Apr 2019 08:28:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388195AbfDRI2w (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Apr 2019 04:28:52 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37207 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728074AbfDRI2v (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Apr 2019 04:28:51 -0400
Received: by mail-lj1-f196.google.com with SMTP id v13so1180372ljk.4
        for <git@vger.kernel.org>; Thu, 18 Apr 2019 01:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RQFV9VsonhYbFMaA9Ngx3Ze0QStFd9I3FgRKxEYLO4A=;
        b=EKxei3ZDMJ1D9VMS3N63aB+xj/xfR3XsvMg7ZJnyEd+Ygm4QmfXUWgkVCitozBXFoC
         /7KHm2QzKj3UYP+ZohKIL5EhKZaUp1sR7AysHgiiH7lAYSpdZonqH4Re827TX/NePlHX
         N8bejgotFyBMcwWSd11lN+v/6dSc3QwpQEd9yRN4mGRAxwoRhOwvRXAYmk/g6O7QBG6O
         H0H8Czc56t2PBFuS9VtH76LbkdGaaiF3PkhFcGAtF2HoX3WjJBW6umqfPfkzT62DkXYN
         iMeizqO9QLzrFcMbkqC/Gs0lLcxPUjpLk3J3K+QzOiJ/3Rc5ZGkQ4cB76EaOPoO3Y4+q
         NjNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RQFV9VsonhYbFMaA9Ngx3Ze0QStFd9I3FgRKxEYLO4A=;
        b=JC4U1iA2bu2BEG6Viq/Dybnawf1uPfuJ6BoT/sR/m125ih6vEIznI9KEj/KYW3y/Sw
         wkbWt7+prq8+qnwVxp0VRR1245wgvPcWPLfcr08K/Lgl7gd4hL3uQA65yuGNrPsy1v0M
         m+gAAakx+B0LIANNsExH7zdcKxu9gimxoe9FZzlu2/KTNVVDQ6DCYe8Z6+XGUz5Pp33Z
         MqEOhgOMmMcKwOgUGC62xpMBd/eTwaJPDV5PjKv9AbxSl5Ziswk5yrTSx8on73bVEexU
         skBads/oWpZB8cWTYewUCsa9HXybHFWCGk/ktrSRID7YwUW5FfbVcSSMXPieFKFfqjNz
         67+w==
X-Gm-Message-State: APjAAAWLR5e6x1+E+sfyIUUMPrS/luCBui61Ibi8qhzXzmnUvKFu70v5
        k1SqalkztNfc0/VrVZjYDvwJV3dQ
X-Google-Smtp-Source: APXvYqywZg0gxeb7b83xzseCFRgGZMtRPzHIIWEA+4kfdjv0BdElPtnlOpIMGGDAo5aYzlW+EF5AEA==
X-Received: by 2002:a2e:8618:: with SMTP id a24mr2733092lji.192.1555576129695;
        Thu, 18 Apr 2019 01:28:49 -0700 (PDT)
Received: from lwo1-lhp-f71841 ([195.234.74.207])
        by smtp.gmail.com with ESMTPSA id d3sm267513ljc.15.2019.04.18.01.28.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 01:28:48 -0700 (PDT)
Date:   Thu, 18 Apr 2019 11:28:44 +0300
From:   Vadym Kochan <vadim4j@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/1] configure.ac: Properly check for libintl
Message-ID: <20190418082844.GA10068@lwo1-lhp-f71841>
References: <20190418050419.21114-1-vadim4j@gmail.com>
 <xmqqftqfhnmz.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqftqfhnmz.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, Apr 18, 2019 at 02:45:56PM +0900, Junio C Hamano wrote:
> Vadim Kochan <vadim4j@gmail.com> writes:
> 
> > Some libc implementations like uclibc or musl provides
> > gettext stubs via libintl library but this case is not checked
> > by AC_CHECK_LIB(c, gettext ...) because gcc has gettext as builtin
> > which passess the check.
> >
> > So check it with included libintl.h where gettext may unfold into
> > libintl_gettext which will cause check to fail if libintl_gettext are
> > needed to be linked with -lintl.
> 
> Let me make sure I can understand the above correctly (otherwise,
> that is a sign that the proposed log message is lacking) by trying
> to rephrase (iow, this is not me saying "your log message should be
> rewritten like so"; it is "if I read what you wrote above correctly,
> I think what I am going to write here is also correct"):
> 
>     Some libc implementations have function called gettext() that
>     can be linked via -lc without -lintl, but these are mere stubs
>     and do not do useful i18n.  On these systems, if a program that
>     calls gettext() is built _with_ "#include <libintl.h>", the
>     linker calls for the real version (e.g. libintl_gettext()) and
>     that can be satisfied only by linking with -lintl.
> 
>     The current check to see if -lc provides with gettext() is
>     sufficient for libc implementations like GNU libc that actually
>     has full fledged gettext(); to detect libc with stub gettext()
>     and libintl with real gettext(), aliased via <libintl.h>, the
>     check to see if -lintl is necessary must be done with a sample
>     source that #include's the header file.
> 
> Is that what is going on and why this patch is needed?
> 
> I think the only possibile kind of system this change could break
> that currently is working is the one that has a usable gettext()
> in -lc, but does not offer <libintl.h>, as the new test program
> added by this patch will fail to compile, but I do not think that
> is possible in practice---our own gettext.c #include's <libintl.h>
> so there is no way such a hypothetical system that would be broken
> by this change could possibly have built Git successfully.
> 
> Assuming that the way I read your log message is in line with what
> you wanted to say, I think the patch looks good.
> 
> Thanks.

Yes you are correct. 'gettext' even might be defined as libintl_gettext.
When I got build error I checked config.log and I saw that gcc claims
that gettext builtin is used, so I think that was the reason why test
passed for non-glibc. So, if to use <libintl.h> then gettext might be
preprocessed to libintl_gettext in the test. The original error which I
was fixing is:

	http://autobuild.buildroot.net/results/8eeac7f7ddd97576eaeb87311bf0988d59d8b132/build-end.log

> 
> 
> > Signed-off-by: Vadim Kochan <vadim4j@gmail.com>
> > ---
> >  configure.ac | 16 +++++++++++++---
> >  1 file changed, 13 insertions(+), 3 deletions(-)
> >
> > diff --git a/configure.ac b/configure.ac
> > index e0d0da3c0c..be3b55f1cc 100644
> > --- a/configure.ac
> > +++ b/configure.ac
> > @@ -763,9 +763,19 @@ AC_CHECK_LIB([c], [basename],
> >  GIT_CONF_SUBST([NEEDS_LIBGEN])
> >  test -n "$NEEDS_LIBGEN" && LIBS="$LIBS -lgen"
> >  
> > -AC_CHECK_LIB([c], [gettext],
> > -[LIBC_CONTAINS_LIBINTL=YesPlease],
> > -[LIBC_CONTAINS_LIBINTL=])
> > +AC_DEFUN([LIBINTL_SRC], [
> > +AC_LANG_PROGRAM([[
> > +#include <libintl.h>
> > +]],[[
> > +char *msg = gettext("test");
> > +]])])
> > +
> > +AC_MSG_CHECKING([if libc contains libintl])
> > +AC_LINK_IFELSE([LIBINTL_SRC],
> > +	[AC_MSG_RESULT([yes])
> > +	LIBC_CONTAINS_LIBINTL=YesPlease],
> > +	[AC_MSG_RESULT([no])
> > +	LIBC_CONTAINS_LIBINTL=])
> >  GIT_CONF_SUBST([LIBC_CONTAINS_LIBINTL])
> >  
> >  #
