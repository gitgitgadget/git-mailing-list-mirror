Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB93F1F4B5
	for <e@80x24.org>; Tue, 12 Nov 2019 10:54:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725944AbfKLKyF (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Nov 2019 05:54:05 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54183 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbfKLKyF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Nov 2019 05:54:05 -0500
Received: by mail-wm1-f65.google.com with SMTP id u18so2588423wmc.3
        for <git@vger.kernel.org>; Tue, 12 Nov 2019 02:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=x48zE/BqdG5pODqf823UdmABIk6Yap/KUg3Qji5c4mw=;
        b=j71rrQkxgCJigWELCGHuwPWbSYij6Oqe6PKkhMF1P1LtftqgsfWfGDVLLB0MYXUJZa
         UN5x+07O17L7795ffNQ9TeWro7ifg6QEUWN/z2+epHzNczqso2FXOUKiHFqHzoN7gC+g
         XqClrjGj0w6rROUr/IasLYCEBdP5U+s+yKAB1VkDOYLiV20i/sZePpbZMxK0TOmRe0CX
         rayB8s7UgHp9pPlWZXU/a4kR59U4Q+Hau1i1+R++1VxoX5WXse2615NyF2xJKOUC5XmT
         3DR5mzliOtYgZZG6u/hX3PVvgUcp+g7GVafZ4T4TKYCDu7EGWDj3Y3vsO71ZkN2z2Kvz
         4YQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=x48zE/BqdG5pODqf823UdmABIk6Yap/KUg3Qji5c4mw=;
        b=cH1MuIH8JG0UdFgbbISLhi4hCw8hYSLSBSmlkuIy8OdI0/1kcWMGk3CLm7KWSjwCaC
         DRcAkvU43yno51C4nB6wvKHN4gchHEEtlmRGMYggfML2HqIXMZckHJzUvFsxExLfLk7W
         XB99KUvSB/RYMpQm7ltso5E7/KsNtOvGsYxV2htzKhv3mjHH1C4FGfB3abqkbIhusIZW
         6iuUESRCgVNbcLVAZETvEp3diSMOydHNFnbWCC/5inHFAiTmhR2F6mwSX1pgLGdvd+v4
         c9FTVTLNZuNL0cujeaREbxRT57qVh8bSMPkuRaNd7pxUPYmuOjFWXVyGGAfEk61S5jKE
         Bg8w==
X-Gm-Message-State: APjAAAU/OdvWmIAAzfN+vIhjFHHuvS8WCNj+KFLm+kCPw+kZBFIQJsUt
        KjM1xbvPKCLt4U8s4x2WM94=
X-Google-Smtp-Source: APXvYqwHpeSarnedS3Oa3TIJIjLelhau1EWY3E3Qx7HYllO3vTCHTnCzuTaYWU9UJgRFBrnwU+aTmw==
X-Received: by 2002:a1c:2155:: with SMTP id h82mr3220948wmh.94.1573556043428;
        Tue, 12 Nov 2019 02:54:03 -0800 (PST)
Received: from szeder.dev (x4d0c65ae.dyn.telefonica.de. [77.12.101.174])
        by smtp.gmail.com with ESMTPSA id u18sm11556592wrp.14.2019.11.12.02.54.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Nov 2019 02:54:02 -0800 (PST)
Date:   Tue, 12 Nov 2019 11:54:00 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        James Coglan <jcoglan@gmail.com>
Subject: Re: [PATCH] t4215: don't put git commands upstream of pipe
Message-ID: <20191112105400.GM4348@szeder.dev>
References: <20191018152121.GE29845@szeder.dev>
 <8e950ddfba3fa0f6d0551a153228548da6af6117.1573520653.git.liu.denton@gmail.com>
 <xmqqzhh1eg57.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqzhh1eg57.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 12, 2019 at 03:57:08PM +0900, Junio C Hamano wrote:
> Denton Liu <liu.denton@gmail.com> writes:
> 
> > A little late to the party but since this cleanup hasn't been done yet,
> > let's do it now. We can apply this patch to the tip of
> > 'jc/log-graph-simplify'.
> > ...
> > -	git log --graph --pretty=tformat:%s | sed "s/ *$//" >actual &&
> > +	git log --graph --pretty=tformat:%s >actual.raw &&
> > +	sed "s/ *$//" actual.raw >actual &&
> 
> Obviously good but I wonder if
> 
> 	show_graph () {
> 		git log --graph --pretty=tformat:%s >actual.raw &&
> 		sed "s/ *$//" actual.raw &&
> 		rm actual.raw
> 	}
> 
> would help to make it even more readable without too much repetition.

I think it would indeed, but then let's go one step further, and add
that 'test_cmp expect actual' to the function, too, and call it
'check_graph'.

> Will queue; thanks.
> 
> >  	test_cmp expect actual
> >  '
> >  
> > @@ -68,7 +69,8 @@ test_expect_success 'log --graph with left-skewed merge' '
> >  	git checkout 0_p && git merge --no-ff 0_s -m 0_G &&
> >  	git checkout @^ && git merge --no-ff 0_q 0_r 0_t 0_p -m 0_H &&
> >  
> > -	git log --graph --pretty=tformat:%s | sed "s/ *$//" >actual &&
> > +	git log --graph --pretty=tformat:%s >actual.raw &&
> > +	sed "s/ *$//" actual.raw >actual &&
> >  	test_cmp expect actual
> >  '
> >  
> > @@ -99,7 +101,8 @@ test_expect_success 'log --graph with nested left-skewed merge' '
> >  	git checkout 1_p && git merge --no-ff 1_r -m 1_G &&
> >  	git checkout @^^ && git merge --no-ff 1_p -m 1_H &&
> >  
> > -	git log --graph --pretty=tformat:%s | sed "s/ *$//" >actual &&
> > +	git log --graph --pretty=tformat:%s >actual.raw &&
> > +	sed "s/ *$//" actual.raw >actual &&
> >  	test_cmp expect actual
> >  '
> >  
> > @@ -139,7 +142,8 @@ test_expect_success 'log --graph with nested left-skewed merge following normal
> >  	git checkout -b 2_s @^^ && git merge --no-ff 2_q -m 2_J &&
> >  	git checkout 2_p && git merge --no-ff 2_s -m 2_K &&
> >  
> > -	git log --graph --pretty=tformat:%s | sed "s/ *$//" >actual &&
> > +	git log --graph --pretty=tformat:%s >actual.raw &&
> > +	sed "s/ *$//" actual.raw >actual &&
> >  	test_cmp expect actual
> >  '
> >  
> > @@ -175,7 +179,8 @@ test_expect_success 'log --graph with nested right-skewed merge following left-s
> >  	git checkout 3_p && git merge --no-ff 3_r -m 3_H &&
> >  	git checkout @^^ && git merge --no-ff 3_p -m 3_J &&
> >  
> > -	git log --graph --pretty=tformat:%s | sed "s/ *$//" >actual &&
> > +	git log --graph --pretty=tformat:%s >actual.raw &&
> > +	sed "s/ *$//" actual.raw >actual &&
> >  	test_cmp expect actual
> >  '
> >  
> > @@ -210,7 +215,8 @@ test_expect_success 'log --graph with right-skewed merge following a left-skewed
> >  	git merge --no-ff 4_p -m 4_G &&
> >  	git checkout @^^ && git merge --no-ff 4_s -m 4_H &&
> >  
> > -	git log --graph --date-order --pretty=tformat:%s | sed "s/ *$//" >actual &&
> > +	git log --graph --date-order --pretty=tformat:%s >actual.raw &&
> > +	sed "s/ *$//" actual.raw >actual &&
> >  	test_cmp expect actual
> >  '
> >  
> > @@ -250,7 +256,8 @@ test_expect_success 'log --graph with octopus merge with column joining its penu
> >  	git checkout 5_r &&
> >  	git merge --no-ff 5_s -m 5_H &&
> >  
> > -	git log --graph --pretty=tformat:%s | sed "s/ *$//" >actual &&
> > +	git log --graph --pretty=tformat:%s >actual.raw &&
> > +	sed "s/ *$//" actual.raw >actual &&
> >  	test_cmp expect actual
> >  '
