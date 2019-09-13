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
	by dcvr.yhbt.net (Postfix) with ESMTP id 519531F463
	for <e@80x24.org>; Fri, 13 Sep 2019 11:50:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729449AbfIMLt6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Sep 2019 07:49:58 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46949 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729421AbfIMLt6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Sep 2019 07:49:58 -0400
Received: by mail-wr1-f65.google.com with SMTP id o18so567777wrv.13
        for <git@vger.kernel.org>; Fri, 13 Sep 2019 04:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hFqKDgkDFSB4okksU/2C/WJMix7LVrUujWcgLoH9drg=;
        b=DC7oMRk2GnrLSpd88vwLBdXQLy0xEto+KK2vKck4Kc19IAZ/mWT7PCQCP8ykgBoWR5
         xtjBVMVpB6n5tTT9ZZ4mt5S9IMe2mRuiqlEwkHfG2bUDJhGbzN93J3QwRv1YQJQx+6eR
         Ht4kRassxhxIbSzuicSndp20qDw8FqZYX/9gdYk19hp7J2RGPmWrtzfb2S8GyMwNwMQe
         8dw9wYvGfNDlH5ksUTDJiJT9z+a0SePyDLLITN5EGKQjLsGPHchALANigkVHiC+xSi9W
         aATjyZJOKt5ZgGgGR27RASJDN7vI9jpEaFRJz0fe0RzH6Td0hEk3vezP89XQr2Wc7XJN
         e3ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hFqKDgkDFSB4okksU/2C/WJMix7LVrUujWcgLoH9drg=;
        b=WkOHEIHl3wbyNnsM+oddlPdki4LqMFjJetnPWvtbiovHpQgbPZEwvzlNI4pnIzI3MY
         J8Qh1unkorPaqb/7tBKeZpFuaSiKBK9Z8wXPZZR6HbDXJM8KN2ADqJlV49lLnkNMX676
         WJR/7OzH5nBlChDc+7kKoVhKiHbTYbypCNcYODG0iMa+/+WgrZVfkwnpXKqgT/HQN+5d
         nEIO+yeAHzqUy1d6Pk0+q6kO2Wx7JBo7NiUYPq5T0j/385YSblLDaxeDqH8s8sIxOywB
         /W5QtZQ6sxcQjzFhQmiBYBXKrpFxpDxwd81MLJprFaw62bprlV2nLzjiojtpdv2U/WBu
         zPfw==
X-Gm-Message-State: APjAAAWcuCOOXwvbfAIWVRnSeHBu12thjm6KpxaKYnO5M1Cus3tl81q4
        nUweKFkTuLkO+Tloac5qLu0=
X-Google-Smtp-Source: APXvYqwKc7IYL6diwLC5Ka1pmyCoJdePx3pHp5FQbZcrDN2URXRINEXHAMvvzS4fbs+Mi56JEkFaMg==
X-Received: by 2002:a5d:6242:: with SMTP id m2mr2204672wrv.261.1568375396040;
        Fri, 13 Sep 2019 04:49:56 -0700 (PDT)
Received: from szeder.dev (x4dbd0815.dyn.telefonica.de. [77.189.8.21])
        by smtp.gmail.com with ESMTPSA id a190sm2289495wme.8.2019.09.13.04.49.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Sep 2019 04:49:55 -0700 (PDT)
Date:   Fri, 13 Sep 2019 13:49:52 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 3/3] Makefile: run coccicheck on more source files
Message-ID: <20190913114952.GO32087@szeder.dev>
References: <cover.1568101393.git.liu.denton@gmail.com>
 <cover.1568309119.git.liu.denton@gmail.com>
 <89b7e17469e19c9dca8afa729ec1a70f4e06a2b7.1568309119.git.liu.denton@gmail.com>
 <xmqqtv9hfjdn.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqtv9hfjdn.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 12, 2019 at 11:40:36AM -0700, Junio C Hamano wrote:
> Denton Liu <liu.denton@gmail.com> writes:
> 
> > +FIND_C_SOURCES = $(filter %.c,$(shell $(FIND_SOURCE_FILES)))
> > +COCCI_SOURCES = $(filter-out $(THIRD_PARTY_SOURCES),$(FIND_C_SOURCES))
> 
> The former is somewhat misnamed.  FIND_SOURCE_FILES is *not* a list
> of source files---it is a procedure to list source files to its
> standard output.  FIND_C_SOUCRES sounds as if it is a similar
> procedure, which would be implemented much like
> 
> 	FIND_C_SOURCES = $(FIND_SOURCE_FILES) | sed -n -e '/\.c$/p'
> 
> but that is not what you did and that is not what you want to have.
> Perhaps call it FOUND_C_SOURCES?
> 
> I wonder if we can get rid of FIND_SOURCE_FILES that is a mere
> procedure and replace its use with a true list of source files.
> Would it make the result more pleasant to work with?
> 
> Perhaps something like the attached patch, (which would come before
> this entire thing as a clean-up, and removing the need for 2/3)?
> 
> I dunno.
> 
> Using a procedure whose output is fed to xargs has an advantage that
> a platform with very short command line limit can still work with
> many source files, but the way you create and use COCCI_SOURCES in
> this patch would defeat that advantage anyway,

COCCI_SOURCES is only used as an input to 'xargs', so that advantage
is not defeated.

> so perhaps we can get
> away with an approach like this.  Having a list of things in $(MAKE)
> variable has a longer-term benefit that we could exploit more
> parallelism if we wanted to, too.
> 
>  Makefile | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index f9255344ae..9dddd0e88c 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2584,7 +2584,7 @@ perl/build/man/man3/Git.3pm: perl/Git.pm
>  	$(QUIET_GEN)mkdir -p $(dir $@) && \
>  	pod2man $< $@
>  
> -FIND_SOURCE_FILES = ( \
> +SOURCE_FILES = $(patsubst ./%,%,$(shell \
>  	git ls-files \
>  		'*.[hcS]' \
>  		'*.sh' \
> @@ -2599,19 +2599,19 @@ FIND_SOURCE_FILES = ( \
>  		-o \( -name 'trash*' -type d -prune \) \
>  		-o \( -name '*.[hcS]' -type f -print \) \
>  		-o \( -name '*.sh' -type f -print \) \
> -	)
> +	))
>  
>  $(ETAGS_TARGET): FORCE
>  	$(RM) $(ETAGS_TARGET)
> -	$(FIND_SOURCE_FILES) | xargs etags -a -o $(ETAGS_TARGET)
> +	etags -a -o $(ETAGS_TARGET) $(SOURCE_FILES)
>  
>  tags: FORCE
>  	$(RM) tags
> -	$(FIND_SOURCE_FILES) | xargs ctags -a
> +	ctags -a $(SOURCE_FILES)
>  
>  cscope:
>  	$(RM) cscope*
> -	$(FIND_SOURCE_FILES) | xargs cscope -b
> +	cscope -b $(SOURCE_FILES)
>  
>  ### Detect prefix changes
>  TRACK_PREFIX = $(bindir_SQ):$(gitexecdir_SQ):$(template_dir_SQ):$(prefix_SQ):\
> 
> 
> 
> 
