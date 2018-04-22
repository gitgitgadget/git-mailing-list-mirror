Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 849001F424
	for <e@80x24.org>; Sun, 22 Apr 2018 20:36:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753560AbeDVUg2 (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Apr 2018 16:36:28 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:41130 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753529AbeDVUg1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Apr 2018 16:36:27 -0400
Received: by mail-wr0-f195.google.com with SMTP id g21-v6so8294027wrb.8
        for <git@vger.kernel.org>; Sun, 22 Apr 2018 13:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wb9vopGMpecDR65LbbZJWsIVzY6SZbfMgZYyYv3ooJ0=;
        b=uy9DmTM9Dy3JyH/3+MCtwK+TfHcllI713QLhnd4/1AQHZmKldZwBJlxcuemJu5upac
         nsfqC+Q/aZD28NLKzosTGSiFzlIqEySjPwhlv8iQtHxa3k+PYS9/R2MLE3uPPEf9lvyb
         mmlxFJWZuMC+/KA9Vqbpfr5hwzZ+BZX0RzlyvdjG4IM9IIkIWeDNVipD0f6qDVvzOAkd
         9MPcV7p5w64Sz5e7zqAUIeCkgOH/Xc9Ch/JwNzDqm/F4liF0xpQWGJyc5K3vmoTVkXLX
         7EAycDCF5VET59WjEG/a07kypxKotO+J2ojgy++kJb+n6ARpVluO9QF5LBzVJFfUejVu
         X+fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wb9vopGMpecDR65LbbZJWsIVzY6SZbfMgZYyYv3ooJ0=;
        b=lEGMlaLg/2OgwPcKBFChrBORQGt9CdqTmumALDQn0iVjhXPExMN+ko5UuIQaF6UyR4
         AVtf7yZuVo+HWQVxSDL4E+2LfyOJEtwrC4Nwp5UPYteFQ4UHrjXe5Ht3ck5ppeputv2R
         RWGmSIoskL67+YNX79l0uBzmxLEMBE2dbZoqZRHYu4Wh69tEbPljfr6TbNIFuCQlBqps
         RaK3O/WU8UhPOUAX3N3yLF9zZxwXvElXOc4Yo47aHowgHICUTahifC1LODBEpDepNjcj
         XkOavhARYbjT1ncrBfvz0dWUP6x1xPySgs3Ta0YazRBeB/Cusy456C89eOc97T5aD8Tf
         pkYQ==
X-Gm-Message-State: ALQs6tCXqcd55jNSLuen4qNFxvTXxV/C12PfkhUIjLC5vXEZlsYa7zjO
        5Ib7U0Mu0fArB1EQKfusNSc=
X-Google-Smtp-Source: AIpwx4+ZddO8kHJztFy8RdSuuctdhkKVQOl8PXES8YCNuVDsh/B3Ex/FZ02hHmJMBmo1yPqs1QXY4w==
X-Received: by 2002:adf:88b6:: with SMTP id f51-v6mr14390081wrf.55.1524429386590;
        Sun, 22 Apr 2018 13:36:26 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id l73sm18375177wma.10.2018.04.22.13.36.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 22 Apr 2018 13:36:25 -0700 (PDT)
Date:   Sun, 22 Apr 2018 21:36:32 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/2] completion: stop showing 'save' for stash by
 default
Message-ID: <20180422203632.GA25294@hank>
References: <20180417212945.24002-1-t.gummerer@gmail.com>
 <20180419232514.16572-1-t.gummerer@gmail.com>
 <20180419232514.16572-2-t.gummerer@gmail.com>
 <CACsJy8BByBCh_DuDu9otO4RLpCnQ+HY-vHi4EDC3_dNQHjM1dg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACsJy8BByBCh_DuDu9otO4RLpCnQ+HY-vHi4EDC3_dNQHjM1dg@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/20, Duy Nguyen wrote:
> On Fri, Apr 20, 2018 at 1:25 AM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> > The 'save' subcommand in git stash has been deprecated in
> > fd2ebf14db ("stash: mark "git stash save" deprecated in the man page",
> > 2017-10-22).
> >
> > Stop showing it when the users enters 'git stash <tab>' or 'git stash
> > s<tab>'.  Keep showing it however when the user enters 'git stash sa<tab>'
> > or any more characters of the 'save' subcommand.
> 
> I don't think this is worth it. You only save two keystrokes for 've'
> and already waste one on <tab>.

I think the main reason for keeping the completion is not actually
saving keystrokes, but rather not giving the users the false
impression that we removed the command, or that something is wrong
with it, without properly warning them before.  That was the main
reason given in [1] why the completion is useful even for short
commands such as 'rm'.

So while I had the same impression before re-reading that thread, I
think keeping the completion for 'git stash sa<tab>' is the right
thing to do, and we can remove it some time after we started warning
about 'git stash save' being deprecated.

[1]: <01020160a0004473-277c3d7c-4e3b-4c50-9d44-4a106f37f1d9-000000@eu-west-1.amazonses.com>

> -- 
> Duy
