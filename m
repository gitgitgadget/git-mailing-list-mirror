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
	by dcvr.yhbt.net (Postfix) with ESMTP id EDA051F463
	for <e@80x24.org>; Fri, 13 Sep 2019 17:14:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730773AbfIMROI (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Sep 2019 13:14:08 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45155 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728890AbfIMROI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Sep 2019 13:14:08 -0400
Received: by mail-pf1-f193.google.com with SMTP id y72so18433980pfb.12
        for <git@vger.kernel.org>; Fri, 13 Sep 2019 10:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Vjmo16/5JhgZThXB5AjVFTq3DgolUraTTHgCvO5IP88=;
        b=eFxsOZHGZGalwQvh6x6XHBPsqyQfdByHGxJMHMcxbEb8Qugd6OIuY/0LOUlaSRYSO6
         cyg1KlFG14z78sLN/mth4nP7zP9QMy8/WXkNjRz36sGFUgiesvdzjUC2T3jHudEeNEj3
         vrAWn+Il9NJlfiL6zkTKKX0JMTsZoDgSYxUE4U1nfKLt8SkvGDIUgMdPRvcs8URMNrD8
         eY4uxz8RXh63TxiDBK5WpnpwlfwX5LMcPGvgonegQ733b6MqDQqvyVPkVTYgAe4reN6P
         TqY4y0CJg4R1Ku4Nq1Xo1US3UJe/ZCmAl1VlVGkp674CIeJHrOWMkpoA9TZmv0F6/8xL
         BScA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Vjmo16/5JhgZThXB5AjVFTq3DgolUraTTHgCvO5IP88=;
        b=KCvzbBvRcVdAxCdqK9J1k3LWF6q+uvlUQ4bwxh7qMy6TjnDWaqPYCBG8CJ/Gu0LESD
         t4ypffRYZYevjr117ldnN5MiHf8EP/DjsY/S30PaSxIBZez29KhtgAvZLWBdC6l274fP
         kUxFRPwn6uT4SPyXFzVOGZwm3QFf6b9ctJU+DB5BxNzjFQvv8ffgQ34V97dP6RzaBG+b
         2fi4cu+gwUhED13DshadzPF6xN5I7TUaaokgib3kqv25+BzQjoxCX621kmhCpijb44K0
         F5cROCsJ9vdet+Pfv18K/GXJod1o4MfiCdt92dFQ6Plr5m7cpeV9CHupUnfexouxLGf5
         Q0xA==
X-Gm-Message-State: APjAAAWWTKSdzosjWuIT6MoS3/seg16nS7Op5OAR7n01kLzdM1ZaJWvs
        xDUuB2eGeLBvdjVsTlpaOSI=
X-Google-Smtp-Source: APXvYqwZzcCaOzxQdeyhX4p76PF9XFrKkDIHbr/0H5U/8dihuzmVEuQ/M1H3va/XWMOCYKKsEXWLuQ==
X-Received: by 2002:a17:90a:db4c:: with SMTP id u12mr1988803pjx.38.1568394845234;
        Fri, 13 Sep 2019 10:14:05 -0700 (PDT)
Received: from dentonliu-ltm.internal.salesforce.com ([204.14.239.138])
        by smtp.gmail.com with ESMTPSA id c11sm59625241pfj.114.2019.09.13.10.14.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Sep 2019 10:14:04 -0700 (PDT)
Date:   Fri, 13 Sep 2019 10:14:01 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 3/3] Makefile: run coccicheck on more source files
Message-ID: <20190913171401.GA63368@dentonliu-ltm.internal.salesforce.com>
References: <cover.1568101393.git.liu.denton@gmail.com>
 <cover.1568309119.git.liu.denton@gmail.com>
 <89b7e17469e19c9dca8afa729ec1a70f4e06a2b7.1568309119.git.liu.denton@gmail.com>
 <xmqqtv9hfjdn.fsf@gitster-ct.c.googlers.com>
 <20190913114952.GO32087@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190913114952.GO32087@szeder.dev>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 13, 2019 at 01:49:52PM +0200, SZEDER Gábor wrote:
> On Thu, Sep 12, 2019 at 11:40:36AM -0700, Junio C Hamano wrote:
> > Denton Liu <liu.denton@gmail.com> writes:
> > 
> > > +FIND_C_SOURCES = $(filter %.c,$(shell $(FIND_SOURCE_FILES)))
> > > +COCCI_SOURCES = $(filter-out $(THIRD_PARTY_SOURCES),$(FIND_C_SOURCES))
> > 
> > The former is somewhat misnamed.  FIND_SOURCE_FILES is *not* a list
> > of source files---it is a procedure to list source files to its
> > standard output.  FIND_C_SOUCRES sounds as if it is a similar
> > procedure, which would be implemented much like
> > 
> > 	FIND_C_SOURCES = $(FIND_SOURCE_FILES) | sed -n -e '/\.c$/p'
> > 
> > but that is not what you did and that is not what you want to have.
> > Perhaps call it FOUND_C_SOURCES?
> > 
> > I wonder if we can get rid of FIND_SOURCE_FILES that is a mere
> > procedure and replace its use with a true list of source files.
> > Would it make the result more pleasant to work with?
> > 
> > Perhaps something like the attached patch, (which would come before
> > this entire thing as a clean-up, and removing the need for 2/3)?
> > 
> > I dunno.
> > 
> > Using a procedure whose output is fed to xargs has an advantage that
> > a platform with very short command line limit can still work with
> > many source files, but the way you create and use COCCI_SOURCES in
> > this patch would defeat that advantage anyway,
> 
> COCCI_SOURCES is only used as an input to 'xargs', so that advantage
> is not defeated.

I think it still does matter; the relevant snippet is as follows:

	if ! echo $(COCCI_SOURCES) | xargs $$limit \
		$(SPATCH) --sp-file $< $(SPATCH_FLAGS) \
		>$@+ 2>$@.log; \

which means that a really big COCCI_SOURCES could exceed the limit.

That being said, COCCI_SOURCES should be smaller than the future
SOURCE_FILES variable since we're only taking %.c files (and filtering
out some of them too!).

I dunno, either. I'm mostly in favour of this change since it makes a
lot of sense to keep lists in make variables if possible as opposed to
command invocations. I guess worst case, if someone complains in the
future, we can always change it back.

> 
> > so perhaps we can get
> > away with an approach like this.  Having a list of things in $(MAKE)
> > variable has a longer-term benefit that we could exploit more
> > parallelism if we wanted to, too.
> > 
> >  Makefile | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff --git a/Makefile b/Makefile
> > index f9255344ae..9dddd0e88c 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -2584,7 +2584,7 @@ perl/build/man/man3/Git.3pm: perl/Git.pm
> >  	$(QUIET_GEN)mkdir -p $(dir $@) && \
> >  	pod2man $< $@
> >  
> > -FIND_SOURCE_FILES = ( \
> > +SOURCE_FILES = $(patsubst ./%,%,$(shell \
> >  	git ls-files \
> >  		'*.[hcS]' \
> >  		'*.sh' \
> > @@ -2599,19 +2599,19 @@ FIND_SOURCE_FILES = ( \
> >  		-o \( -name 'trash*' -type d -prune \) \
> >  		-o \( -name '*.[hcS]' -type f -print \) \
> >  		-o \( -name '*.sh' -type f -print \) \
> > -	)
> > +	))
> >  
> >  $(ETAGS_TARGET): FORCE
> >  	$(RM) $(ETAGS_TARGET)
> > -	$(FIND_SOURCE_FILES) | xargs etags -a -o $(ETAGS_TARGET)
> > +	etags -a -o $(ETAGS_TARGET) $(SOURCE_FILES)
> >  
> >  tags: FORCE
> >  	$(RM) tags
> > -	$(FIND_SOURCE_FILES) | xargs ctags -a
> > +	ctags -a $(SOURCE_FILES)
> >  
> >  cscope:
> >  	$(RM) cscope*
> > -	$(FIND_SOURCE_FILES) | xargs cscope -b
> > +	cscope -b $(SOURCE_FILES)
> >  
> >  ### Detect prefix changes
> >  TRACK_PREFIX = $(bindir_SQ):$(gitexecdir_SQ):$(template_dir_SQ):$(prefix_SQ):\
> > 
> > 
> > 
> > 
