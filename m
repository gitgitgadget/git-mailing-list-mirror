Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E8B7C1F461
	for <e@80x24.org>; Thu,  5 Sep 2019 03:23:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730190AbfIEDXV (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Sep 2019 23:23:21 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40643 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbfIEDXV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Sep 2019 23:23:21 -0400
Received: by mail-pg1-f195.google.com with SMTP id w10so571942pgj.7
        for <git@vger.kernel.org>; Wed, 04 Sep 2019 20:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=J9oDs0t7bk4kvuz/mSuMdQZbhfWOXvTbkCKY57Yjc40=;
        b=GOLEm76Qfud9AYxOZ0QetKr7SVwcGnmYtcZvHWNwkqZglhsSzbeIIt8Qx0kbN470P0
         bJb9LXqQqN59evjTbTg6IHrwv2xgYLys0ESlI7zkkBvAb7Xu4IgGlWqNQ0oY93yu+n3+
         k2eUzac3CQnL6aEl0xPqMwNKvMLvfOyeMjFsWWiRxGkhPMpAkhpb9CshlIJCAPrv1mgO
         YOtg/p4zSy3q1NI2KZxKxBYZq4rdzJuqhroo3p5+SN/S7LV99+Lq6gmq5oAQlwyF3o+4
         hiKsUx9KsJRRTTDWPc8dApwmWWbVkQ3qc48bGy4wL/PSGbGAN8h7M7eVlZngzHgfzdXr
         ofaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=J9oDs0t7bk4kvuz/mSuMdQZbhfWOXvTbkCKY57Yjc40=;
        b=FQEAkxRkCLIM08qICclI6MHb0TwL3YjLlBrNo/Bp8HGxnqUD5HIXn2Kbag1xeZTkIt
         OKMcN5hoqw6vGVRoRnNstHoqVIHU5ZFwWJm4UvKy0A2NMEmnOZZF/uW2CSrD4ts1FSP9
         +6o7GfnXZ1YORx42zLtl3cHSRxbWTPgOSxdPP5PoOgZc6T8GVdUAKRgsSR5hOuNJbIBO
         EMtcncEFDCmvJD9zjPFLhmJiR+qj71PcQVLYyQtJfT2ZoxZKwvaqVM3sUaExC11z1iCQ
         m/wbR0LmDJXWEAYrgPrN8KGWreObH/8H/TR0Wryb2aDP3On0uQ07KQlRwFIsD7aKRxoI
         ImJw==
X-Gm-Message-State: APjAAAWwR3pXFLIzV/bUsvks8q1mR5m9WlMP6Z3caQRhKrFLFPsUuMht
        rI218f1utwbyMf5q9YxOSGY=
X-Google-Smtp-Source: APXvYqyXk+j+obGIpAjSNZQgNnVJS6Vp8Vq8ucBKQGY+0zwUnggylGdCUpBWvJWiO5GuotpD7arZZA==
X-Received: by 2002:aa7:980c:: with SMTP id e12mr1107632pfl.79.1567653800390;
        Wed, 04 Sep 2019 20:23:20 -0700 (PDT)
Received: from archbookpro.localdomain ([2601:646:280:1b30::6486])
        by smtp.gmail.com with ESMTPSA id b24sm531747pfi.75.2019.09.04.20.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2019 20:23:19 -0700 (PDT)
Date:   Wed, 4 Sep 2019 20:23:17 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] compat/*.[ch]: remove extern from function
 declarations using spatch
Message-ID: <20190905032317.GA1381@archbookpro.localdomain>
References: <cover.1567595331.git.liu.denton@gmail.com>
 <3c08556231576d8dfe496b87ae8cdcb87c00df24.1567595331.git.liu.denton@gmail.com>
 <nycvar.QRO.7.76.6.1909042342220.5377@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1909042342220.5377@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

On Wed, Sep 04, 2019 at 11:43:06PM +0200, Johannes Schindelin wrote:
> Hi Denton,
> 
> On Wed, 4 Sep 2019, Denton Liu wrote:
> 
> > In 554544276a (*.[ch]: remove extern from function declarations using
> > spatch, 2019-04-29), we removed externs from function declarations using
> > spatch but we intentionally excluded files under compat/ since some are
> > directly copied from an upstream and we should avoid churning them so
> > that manually merging future updates will be simpler.
> >
> > In the last commit, we determined the files which taken from an upstream
> > so we can exclude them and run spatch on the remainder.
> >
> > This was the Coccinelle patch used:
> >
> > 	@@
> > 	type T;
> > 	identifier f;
> > 	@@
> > 	- extern
> > 	  T f(...);
> >
> > and it was run with:
> >
> > 	$ git ls-files compat/\*\*.{c,h} |
> > 		xargs spatch --sp-file contrib/coccinelle/noextern.cocci --in-place
> > 	$ git checkout -- \
> > 		compat/regex/ \
> > 		compat/inet_ntop.c \
> > 		compat/inet_pton.c \
> > 		compat/nedmalloc/ \
> > 		compat/obstack.{c,h} \
> > 		compat/poll/
> >
> > Coccinelle has some trouble dealing with `__attribute__` and varargs so
> > we ran the following to ensure that no remaining changes were left
> > behind:
> >
> > 	$ git ls-files compat/\*\*.{c,h} |
> > 		xargs sed -i'' -e 's/^\(\s*\)extern \([^(]*([^*]\)/\1\2/'
> > 	$ git checkout -- \
> > 		compat/regex/ \
> > 		compat/inet_ntop.c \
> > 		compat/inet_pton.c \
> > 		compat/nedmalloc/ \
> > 		compat/obstack.{c,h} \
> > 		compat/poll/
> 
> I wonder whether we want to make this part of the (slightly misnamed)
> "Static Analysis" job in our CI.

Do you mean running cocci on all of our source files as opposed to just
the files we compile? These two patches are part of an experimental (and
unsubmitted) patchset that does exactly that. Seeing that there's
interest, I'll try to send it in soon.

Thanks,

Denton

> 
> >
> > Signed-off-by: Denton Liu <liu.denton@gmail.com>
> > ---
> >  compat/mingw.h         | 6 +++---
> >  compat/win32/pthread.h | 6 +++---
> >  2 files changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/compat/mingw.h b/compat/mingw.h
> > index a03e40e6e2..9ad204c57c 100644
> > --- a/compat/mingw.h
> > +++ b/compat/mingw.h
> > @@ -11,7 +11,7 @@ typedef _sigset_t sigset_t;
> >  #undef _POSIX_THREAD_SAFE_FUNCTIONS
> >  #endif
> >
> > -extern int mingw_core_config(const char *var, const char *value, void *cb);
> > +int mingw_core_config(const char *var, const char *value, void *cb);
> >  #define platform_core_config mingw_core_config
> >
> >  /*
> > @@ -443,7 +443,7 @@ static inline void convert_slashes(char *path)
> >  			*path = '/';
> >  }
> >  #define PATH_SEP ';'
> > -extern char *mingw_query_user_email(void);
> > +char *mingw_query_user_email(void);
> >  #define query_user_email mingw_query_user_email
> >  #if !defined(__MINGW64_VERSION_MAJOR) && (!defined(_MSC_VER) || _MSC_VER < 1800)
> >  #define PRIuMAX "I64u"
> > @@ -580,4 +580,4 @@ int main(int argc, const char **argv);
> >  /*
> >   * Used by Pthread API implementation for Windows
> >   */
> > -extern int err_win_to_posix(DWORD winerr);
> > +int err_win_to_posix(DWORD winerr);
> > diff --git a/compat/win32/pthread.h b/compat/win32/pthread.h
> > index c6cb8dd219..f1cfe73de9 100644
> > --- a/compat/win32/pthread.h
> > +++ b/compat/win32/pthread.h
> > @@ -50,7 +50,7 @@ typedef struct {
> >  	DWORD tid;
> >  } pthread_t;
> >
> > -extern int pthread_create(pthread_t *thread, const void *unused,
> > +int pthread_create(pthread_t *thread, const void *unused,
> >  			  void *(*start_routine)(void*), void *arg);
> >
> >  /*
> > @@ -59,10 +59,10 @@ extern int pthread_create(pthread_t *thread, const void *unused,
> >   */
> >  #define pthread_join(a, b) win32_pthread_join(&(a), (b))
> >
> > -extern int win32_pthread_join(pthread_t *thread, void **value_ptr);
> > +int win32_pthread_join(pthread_t *thread, void **value_ptr);
> >
> >  #define pthread_equal(t1, t2) ((t1).tid == (t2).tid)
> > -extern pthread_t pthread_self(void);
> > +pthread_t pthread_self(void);
> 
> ACK!
> 
> Thanks,
> Dscho
> 
> >
> >  static inline void NORETURN pthread_exit(void *ret)
> >  {
> > --
> > 2.23.0.248.g3a9dd8fb08
> >
> >
