Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DAD4C1FAF4
	for <e@80x24.org>; Sat, 11 Feb 2017 13:55:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753600AbdBKNzT (ORCPT <rfc822;e@80x24.org>);
        Sat, 11 Feb 2017 08:55:19 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33150 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753519AbdBKNzS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Feb 2017 08:55:18 -0500
Received: by mail-wm0-f66.google.com with SMTP id v77so10942219wmv.0
        for <git@vger.kernel.org>; Sat, 11 Feb 2017 05:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=y4PBatYb2Zp7pcNG1Ya67ZGTTYF25nntA/6176iKCXM=;
        b=BpkimkhHSIb+t1XSWWojXyN2LG509B1FtoFAfzxt9TY9cOn2JTJLdgEVoAlL4bwXvC
         npDyLrM8xI97oW5LW3NjmzP7pgOeYOU0Bh5T1naKs+mD+JDo+kw2AYAcg4gRU1NiFfb2
         QDuWBcXJycc+8dRd+aQkU3WK9/nAnmo6lw0/KIe3ir7bcwa3U//ejQDF3Zd2iVP+d8FT
         zR4M/nxV7v0HCwMIy/h+NhCOrf0pPus6vDhGXB64+ywF1RDs5I+YD7UE8N4LC4AZYWRn
         nVMZGJNp/maUtzG/Mai3Qux38MJkPMcx/Suw2IB4Mi8UU9kzICHk/8Hl1r65iliQaRGj
         a4Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=y4PBatYb2Zp7pcNG1Ya67ZGTTYF25nntA/6176iKCXM=;
        b=heTDoY0qJGD2aUdpWTBg+iXr4ANtkgnXrNsuDrjjXwHg5znG0XMO9afvWE9xJPhR13
         BLFGMlHgbT2T6obz3ayqUMg+9BxoX+Z+HwX9sr/pHM5aRtTELYYnp50T5v8qBmtYM7hn
         aq3VQjD3tPCG7VVquCOKw/sZIXloOA83oXbisv6E8+sGga7hxucs+pClHfrMBbAVlKtY
         VmcFzsP8UWuMqVN7GRtvb/CxMrf2BxWntUtBEComncpAUpzJVo2W6TSzYyFeOgfi0t6S
         Y1liWuNR9ZaUe4B8VH0khl62HPUNfK6Uw7zWgTKCEvSHV03zDFmX/KtMhz0B6yCc3xj/
         qKLQ==
X-Gm-Message-State: AMke39ndb7QEWxFz8YoQD5fvYWP/rxbYvNFJJW4rXzHp5VgSUoiZ/khHzullnGezw69jdA==
X-Received: by 10.28.65.196 with SMTP id o187mr11128013wma.37.1486821316928;
        Sat, 11 Feb 2017 05:55:16 -0800 (PST)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id c9sm5242944wmf.18.2017.02.11.05.55.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 11 Feb 2017 05:55:16 -0800 (PST)
Date:   Sat, 11 Feb 2017 13:55:49 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Stephan Beyer <s-beyer@gmx.net>,
        Junio C Hamano <gitster@pobox.com>,
        Marc Strapetz <marc.strapetz@syntevo.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?iso-8859-1?Q?=D8yvind_A_=2E?= Holm <sunny@sunbase.org>,
        Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: [PATCH v3 3/5] stash: add test for the create command line
 arguments
Message-ID: <20170211135549.GJ31189@hank>
References: <20170129201604.30445-1-t.gummerer@gmail.com>
 <20170205202642.14216-1-t.gummerer@gmail.com>
 <20170205202642.14216-4-t.gummerer@gmail.com>
 <20170206155012.rb2vydjvlquchwk2@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170206155012.rb2vydjvlquchwk2@sigill.intra.peff.net>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/06, Jeff King wrote:
> On Sun, Feb 05, 2017 at 08:26:40PM +0000, Thomas Gummerer wrote:
> 
> > +test_expect_success 'create stores correct message' '
> > +	>foo &&
> > +	git add foo &&
> > +	STASH_ID=$(git stash create "create test message") &&
> > +	echo "On master: create test message" >expect &&
> > +	git show --pretty=%s ${STASH_ID} | head -n1 >actual &&
> > +	test_cmp expect actual
> > +'
> 
> This misses failure exit codes from "git show" because it's on the left
> side of a pipe. Perhaps "git show -s" or "git log -1" would get you the
> same output without needing "head" (and saving a process and the time
> spent generating the diff, as a bonus).
> 
> Ditto in the other tests from this patch and later ones.

Good catch, will fix.

> -Peff
