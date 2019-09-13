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
	by dcvr.yhbt.net (Postfix) with ESMTP id 229F31F463
	for <e@80x24.org>; Fri, 13 Sep 2019 21:38:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389855AbfIMViX (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Sep 2019 17:38:23 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39146 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389717AbfIMViX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Sep 2019 17:38:23 -0400
Received: by mail-pl1-f194.google.com with SMTP id bd8so13790534plb.6
        for <git@vger.kernel.org>; Fri, 13 Sep 2019 14:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=mr6JDPSyvTp4CCz6YS3AlxGHtbBjfJkXUrzDG01qBaY=;
        b=dpMsH89URzri7lC21+HLOg37NIwfbEbUThkJrg1xHP71wdLZ72BxAknlIuYU8k3qH4
         0vjm4Gtpw4WMF6xwApOTK9MBFtpzUbT20D1GXe4E1W0yDgNJRchbtIKEf9LRPQcVMt7b
         Iq5Iamgf22MCPxB3KoNLvgya9vhn4KCGJ1fW9JhUl5PY/Eoxh3/UWvybVx0P1w/wSQ2Z
         +EZRx9MATBwU7mf8BvdzvcXjHfGx1FgOuzZ+38qv80ypHoK0BqGf9nlxpRXBwdyX2Nk4
         wmaI3oBPVz1ZdcpvWfqyO4Y4DFM3/Cu5O/2fshJ0KzslMi8nIENsS+4kdjQ9Fz3zri3J
         8OmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=mr6JDPSyvTp4CCz6YS3AlxGHtbBjfJkXUrzDG01qBaY=;
        b=UKkS5I2uR9oO5LMxkifwr08XpLE+5lbxqbY9uBHMQTdJRDiaUnRgvwdE6vuNVAKT/V
         xiG7G++UQkniWcMa9qXSOaw0+cWxVokPBXxbuhlJxduOkg9+vsuynU+AJYG2tw58DRnf
         xrjHLfFJMaOi4aRlp2brN+I/vJPdHwv1pyJJpwy62PUd/Zdh+R5NLe/PhvI7RIUh1sd3
         vHw6nyGJa+XmUsOAfy+CVVCnspNmd3Tfkyv7UdBjrPubRfPDvXRTnPjjSQdXQYaBLoOW
         hQU4ZbT0BTK6cQzFs9IOTzOjo3x2cjjLbdd5+7OHloi4M1czPsim8oKbg9eTlY+ni6Zd
         Qvzw==
X-Gm-Message-State: APjAAAVkph1tJ7hG+pGr8YhRGvb6Awca6/UappVooDmAIs103GH/1Rcv
        3hiD24UEtsLKioKStrBnhJMhgYgFD18=
X-Google-Smtp-Source: APXvYqzPSggB3UrwoizSneYi6q/RXwi1oKNUUB+TTg1A/rUVIXi10c8rJ50wCVo1DzR3iTo7czc6qg==
X-Received: by 2002:a17:902:860b:: with SMTP id f11mr50901417plo.48.1568410701840;
        Fri, 13 Sep 2019 14:38:21 -0700 (PDT)
Received: from dentonliu-ltm.internal.salesforce.com ([204.14.239.138])
        by smtp.gmail.com with ESMTPSA id k10sm18932840pga.9.2019.09.13.14.38.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Sep 2019 14:38:20 -0700 (PDT)
Date:   Fri, 13 Sep 2019 14:38:18 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 3/3] Makefile: run coccicheck on more source files
Message-ID: <20190913213818.GA88412@dentonliu-ltm.internal.salesforce.com>
References: <cover.1568101393.git.liu.denton@gmail.com>
 <cover.1568309119.git.liu.denton@gmail.com>
 <89b7e17469e19c9dca8afa729ec1a70f4e06a2b7.1568309119.git.liu.denton@gmail.com>
 <xmqqtv9hfjdn.fsf@gitster-ct.c.googlers.com>
 <20190913114952.GO32087@szeder.dev>
 <20190913171401.GA63368@dentonliu-ltm.internal.salesforce.com>
 <20190913180014.GQ32087@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190913180014.GQ32087@szeder.dev>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 13, 2019 at 08:00:14PM +0200, SZEDER Gábor wrote:
> On Fri, Sep 13, 2019 at 10:14:01AM -0700, Denton Liu wrote:
> > On Fri, Sep 13, 2019 at 01:49:52PM +0200, SZEDER Gábor wrote:
> > > On Thu, Sep 12, 2019 at 11:40:36AM -0700, Junio C Hamano wrote:
> > > > Denton Liu <liu.denton@gmail.com> writes:
> > > > 
> > > > > +FIND_C_SOURCES = $(filter %.c,$(shell $(FIND_SOURCE_FILES)))
> > > > > +COCCI_SOURCES = $(filter-out $(THIRD_PARTY_SOURCES),$(FIND_C_SOURCES))
> > > > 
> > > > The former is somewhat misnamed.  FIND_SOURCE_FILES is *not* a list
> > > > of source files---it is a procedure to list source files to its
> > > > standard output.  FIND_C_SOUCRES sounds as if it is a similar
> > > > procedure, which would be implemented much like
> > > > 
> > > > 	FIND_C_SOURCES = $(FIND_SOURCE_FILES) | sed -n -e '/\.c$/p'
> > > > 
> > > > but that is not what you did and that is not what you want to have.
> > > > Perhaps call it FOUND_C_SOURCES?
> > > > 
> > > > I wonder if we can get rid of FIND_SOURCE_FILES that is a mere
> > > > procedure and replace its use with a true list of source files.
> > > > Would it make the result more pleasant to work with?
> > > > 
> > > > Perhaps something like the attached patch, (which would come before
> > > > this entire thing as a clean-up, and removing the need for 2/3)?
> > > > 
> > > > I dunno.
> > > > 
> > > > Using a procedure whose output is fed to xargs has an advantage that
> > > > a platform with very short command line limit can still work with
> > > > many source files, but the way you create and use COCCI_SOURCES in
> > > > this patch would defeat that advantage anyway,
> > > 
> > > COCCI_SOURCES is only used as an input to 'xargs', so that advantage
> > > is not defeated.
> > 
> > I think it still does matter; the relevant snippet is as follows:
> > 
> > 	if ! echo $(COCCI_SOURCES) | xargs $$limit \
> > 		$(SPATCH) --sp-file $< $(SPATCH_FLAGS) \
> > 		>$@+ 2>$@.log; \
> > 
> > which means that a really big COCCI_SOURCES could exceed the limit.
> 
> Oh, you're both right.
> 
> > That being said, COCCI_SOURCES should be smaller than the future
> > SOURCE_FILES variable since we're only taking %.c files (and filtering
> > out some of them too!).
> 
> We could also argue that Coccinelle only runs on platforms that have a
> reasonably large command line arg limit, and the number of our source
> files is way below that, so it won't matter in the foreseeable future.

Good point.

> 
> (Furthermore, 'echo' is often a shell builtin command, and I don't
> think that the platform's argument size limit applies to them.  At
> least the 'echo' of dash, Bash, ksh, ksh93, mksh, and BusyBox sh can
> deal with at least 10 million arguments; the platform limit is
> somewhere around 147k)
> 
> > > > diff --git a/Makefile b/Makefile
> > > > index f9255344ae..9dddd0e88c 100644
> > > > --- a/Makefile
> > > > +++ b/Makefile
> > > > @@ -2584,7 +2584,7 @@ perl/build/man/man3/Git.3pm: perl/Git.pm
> > > >  	$(QUIET_GEN)mkdir -p $(dir $@) && \
> > > >  	pod2man $< $@
> > > >  
> > > > -FIND_SOURCE_FILES = ( \
> > > > +SOURCE_FILES = $(patsubst ./%,%,$(shell \
> > > >  	git ls-files \
> > > >  		'*.[hcS]' \
> > > >  		'*.sh' \
> > > > @@ -2599,19 +2599,19 @@ FIND_SOURCE_FILES = ( \
> > > >  		-o \( -name 'trash*' -type d -prune \) \
> > > >  		-o \( -name '*.[hcS]' -type f -print \) \
> > > >  		-o \( -name '*.sh' -type f -print \) \
> > > > -	)
> > > > +	))
> > > >  
> > > >  $(ETAGS_TARGET): FORCE
> > > >  	$(RM) $(ETAGS_TARGET)
> > > > -	$(FIND_SOURCE_FILES) | xargs etags -a -o $(ETAGS_TARGET)
> > > > +	etags -a -o $(ETAGS_TARGET) $(SOURCE_FILES)
> > > >  
> > > >  tags: FORCE
> > > >  	$(RM) tags
> > > > -	$(FIND_SOURCE_FILES) | xargs ctags -a
> > > > +	ctags -a $(SOURCE_FILES)
> > > >  
> > > >  cscope:
> > > >  	$(RM) cscope*
> > > > -	$(FIND_SOURCE_FILES) | xargs cscope -b
> > > > +	cscope -b $(SOURCE_FILES)
> 
> Here, however, the list of source files is passed as argument to
> non-builtin commands, that also might be used on
> cmdline-arg-limit-challenged platforms.
> 

After doing a bit of research, I think that I agree with you. It seems
like the max command-line length for CMD on Windows is 8191 characters.

However, after running the following,

	$ git ls-files '*.[hcS]' '*.sh' ':!*[tp][0-9][0-9][0-9][0-9]*' ':!contrib' | wc -c
	   12779

we can see that the command-line length would definitely exceed the max
length so xargs would be required. As a result, we should probably just
keep the existing xargs invocations.
