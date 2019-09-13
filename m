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
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E9B21F464
	for <e@80x24.org>; Fri, 13 Sep 2019 18:00:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387471AbfIMSAW (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Sep 2019 14:00:22 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35706 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbfIMSAW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Sep 2019 14:00:22 -0400
Received: by mail-wm1-f67.google.com with SMTP id n10so3697232wmj.0
        for <git@vger.kernel.org>; Fri, 13 Sep 2019 11:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=77bPQiXQhu+4hD3wd1sjfkehG2GiGuRjg3OFTYk2eFA=;
        b=jrH+g5W2ycXEBvBScOTctQd0EObMGEA2newTt7pa+KrtIgH80wH68uam1bKDaZ8Kbi
         Pt9Mv01XgdKJ2Czhv+85Xq3+OJfhdf4qli8r0Ch7CEl6CSA95jgYf0MQpJlTQmeGKnD/
         +nuzeL9POgNjKSgG92OQwsi2wVSwXa8Fd4kZqAn6QcqETZcEpuYXmcnPX3xaS6UQ83zj
         DDJ1cC8AP9Nvd8noB9BCLYxiXJSuKpnaY73dTnHregoB9mMviu1Erirn9fuoHz8R91Lx
         VZuhLlxznErvsUz+U9l819E9SuDMT5tyVbfdBi+5CrnDtyRKoxRmt/b0y21r67zm14LK
         cdtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=77bPQiXQhu+4hD3wd1sjfkehG2GiGuRjg3OFTYk2eFA=;
        b=Dk3TAApoXrnA1n/pVW7CUT3pe42kXK25gmmCOJLi4Lv4XN+H+9Jc1+KYnXQ/OiLFS6
         Is0RLqifZcMtvvxcvn/jHT6DKzARV0JUfKLlLRcslfSJ6Y3yGjSklfDUGW1EuRMRb1C4
         I0cxrqTluQ1uwyOZu5/60Cjwe0Er0T7dhZqLMO2+LtpoiAlRUzTOg6cqZ1N6+01w31E/
         Zp1ySHco4C204t7pVb3nt0CWkmbdDl9sm6wbqpUFxBtUR0RamzIAoDr3Ci0UxN5feiNx
         rnzh0cHHd6GYdPedLmL9zAcq2JOwtDOFahWMb3q7izgTiVMLcsiWBSm/zOqTZz1jQ8l6
         dv6w==
X-Gm-Message-State: APjAAAVin7i5+50J8bLSKAPbs6VGlVPA6fmZ12UxUSx+Of3qwuuBw4X0
        Y1hUQsGcXmKN14X+9fI+GmI=
X-Google-Smtp-Source: APXvYqwaLjFeVDYIamKSN2q86paN5lZMrI6fsUK/GqaKgNKY9QpG1ESfOSEBvTOemmAyDRE5OWz6Og==
X-Received: by 2002:a1c:c789:: with SMTP id x131mr4456829wmf.20.1568397618899;
        Fri, 13 Sep 2019 11:00:18 -0700 (PDT)
Received: from szeder.dev (x4dbd0815.dyn.telefonica.de. [77.189.8.21])
        by smtp.gmail.com with ESMTPSA id g15sm2344954wmk.17.2019.09.13.11.00.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Sep 2019 11:00:18 -0700 (PDT)
Date:   Fri, 13 Sep 2019 20:00:14 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 3/3] Makefile: run coccicheck on more source files
Message-ID: <20190913180014.GQ32087@szeder.dev>
References: <cover.1568101393.git.liu.denton@gmail.com>
 <cover.1568309119.git.liu.denton@gmail.com>
 <89b7e17469e19c9dca8afa729ec1a70f4e06a2b7.1568309119.git.liu.denton@gmail.com>
 <xmqqtv9hfjdn.fsf@gitster-ct.c.googlers.com>
 <20190913114952.GO32087@szeder.dev>
 <20190913171401.GA63368@dentonliu-ltm.internal.salesforce.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190913171401.GA63368@dentonliu-ltm.internal.salesforce.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 13, 2019 at 10:14:01AM -0700, Denton Liu wrote:
> On Fri, Sep 13, 2019 at 01:49:52PM +0200, SZEDER Gábor wrote:
> > On Thu, Sep 12, 2019 at 11:40:36AM -0700, Junio C Hamano wrote:
> > > Denton Liu <liu.denton@gmail.com> writes:
> > > 
> > > > +FIND_C_SOURCES = $(filter %.c,$(shell $(FIND_SOURCE_FILES)))
> > > > +COCCI_SOURCES = $(filter-out $(THIRD_PARTY_SOURCES),$(FIND_C_SOURCES))
> > > 
> > > The former is somewhat misnamed.  FIND_SOURCE_FILES is *not* a list
> > > of source files---it is a procedure to list source files to its
> > > standard output.  FIND_C_SOUCRES sounds as if it is a similar
> > > procedure, which would be implemented much like
> > > 
> > > 	FIND_C_SOURCES = $(FIND_SOURCE_FILES) | sed -n -e '/\.c$/p'
> > > 
> > > but that is not what you did and that is not what you want to have.
> > > Perhaps call it FOUND_C_SOURCES?
> > > 
> > > I wonder if we can get rid of FIND_SOURCE_FILES that is a mere
> > > procedure and replace its use with a true list of source files.
> > > Would it make the result more pleasant to work with?
> > > 
> > > Perhaps something like the attached patch, (which would come before
> > > this entire thing as a clean-up, and removing the need for 2/3)?
> > > 
> > > I dunno.
> > > 
> > > Using a procedure whose output is fed to xargs has an advantage that
> > > a platform with very short command line limit can still work with
> > > many source files, but the way you create and use COCCI_SOURCES in
> > > this patch would defeat that advantage anyway,
> > 
> > COCCI_SOURCES is only used as an input to 'xargs', so that advantage
> > is not defeated.
> 
> I think it still does matter; the relevant snippet is as follows:
> 
> 	if ! echo $(COCCI_SOURCES) | xargs $$limit \
> 		$(SPATCH) --sp-file $< $(SPATCH_FLAGS) \
> 		>$@+ 2>$@.log; \
> 
> which means that a really big COCCI_SOURCES could exceed the limit.

Oh, you're both right.

> That being said, COCCI_SOURCES should be smaller than the future
> SOURCE_FILES variable since we're only taking %.c files (and filtering
> out some of them too!).

We could also argue that Coccinelle only runs on platforms that have a
reasonably large command line arg limit, and the number of our source
files is way below that, so it won't matter in the foreseeable future.

(Furthermore, 'echo' is often a shell builtin command, and I don't
think that the platform's argument size limit applies to them.  At
least the 'echo' of dash, Bash, ksh, ksh93, mksh, and BusyBox sh can
deal with at least 10 million arguments; the platform limit is
somewhere around 147k)

> > > diff --git a/Makefile b/Makefile
> > > index f9255344ae..9dddd0e88c 100644
> > > --- a/Makefile
> > > +++ b/Makefile
> > > @@ -2584,7 +2584,7 @@ perl/build/man/man3/Git.3pm: perl/Git.pm
> > >  	$(QUIET_GEN)mkdir -p $(dir $@) && \
> > >  	pod2man $< $@
> > >  
> > > -FIND_SOURCE_FILES = ( \
> > > +SOURCE_FILES = $(patsubst ./%,%,$(shell \
> > >  	git ls-files \
> > >  		'*.[hcS]' \
> > >  		'*.sh' \
> > > @@ -2599,19 +2599,19 @@ FIND_SOURCE_FILES = ( \
> > >  		-o \( -name 'trash*' -type d -prune \) \
> > >  		-o \( -name '*.[hcS]' -type f -print \) \
> > >  		-o \( -name '*.sh' -type f -print \) \
> > > -	)
> > > +	))
> > >  
> > >  $(ETAGS_TARGET): FORCE
> > >  	$(RM) $(ETAGS_TARGET)
> > > -	$(FIND_SOURCE_FILES) | xargs etags -a -o $(ETAGS_TARGET)
> > > +	etags -a -o $(ETAGS_TARGET) $(SOURCE_FILES)
> > >  
> > >  tags: FORCE
> > >  	$(RM) tags
> > > -	$(FIND_SOURCE_FILES) | xargs ctags -a
> > > +	ctags -a $(SOURCE_FILES)
> > >  
> > >  cscope:
> > >  	$(RM) cscope*
> > > -	$(FIND_SOURCE_FILES) | xargs cscope -b
> > > +	cscope -b $(SOURCE_FILES)

Here, however, the list of source files is passed as argument to
non-builtin commands, that also might be used on
cmdline-arg-limit-challenged platforms.

