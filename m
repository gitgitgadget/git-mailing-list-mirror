Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E7C11F404
	for <e@80x24.org>; Fri, 30 Mar 2018 19:36:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752318AbeC3Tgn (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Mar 2018 15:36:43 -0400
Received: from mail-lf0-f53.google.com ([209.85.215.53]:46233 "EHLO
        mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752069AbeC3Tgm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Mar 2018 15:36:42 -0400
Received: by mail-lf0-f53.google.com with SMTP id j68-v6so13642205lfg.13
        for <git@vger.kernel.org>; Fri, 30 Mar 2018 12:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OrrM1DGm4otPa4GLV1FE+7vT/3rJ7mPDPkXytPKcpPU=;
        b=sxBXn1ijiWTuj/7WYJL75KLyhdQbQkrCOp3CnmiG2Kq+I/eejZ4hO9aWmCh2OvC59T
         wU0mrL0pUsp1+6yIeCnp7WpizcSk3A03xEsoVwO+PXlsveAcwH/TZpt4FNzoep1PHn1Y
         jqC9DzSykixUluTIc1sMfn24zwp2I6fldGVjnTOA1u8sMtu1KR8NR8itJqYcU5xAH/8T
         XIBnE6wVzeUycKoY9L4aubv9hhWRi6MQb3pqZnOHWS5Gda9u/9KebFcCAqRk1q9+tF+R
         HBhGfsoZlEc8/I2Ralu89T1mVQtcYfvfn0H2g3V3TxDHydfJr3LNazHxpcliDwP7qOnu
         eITA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OrrM1DGm4otPa4GLV1FE+7vT/3rJ7mPDPkXytPKcpPU=;
        b=X8p4m4ICFiRAI2kLUhkp+aOv6runvHKKWVyhC0hSFvb6C7dYp1VY/F6M9g1kXGhEDN
         jLH0OQd2nXXs0sKictUtTwUX9yIJSaaWNzpc/3S5oXmskV29IeIBIb7CHdp/CS7sYXSo
         EDmPQPz+fwEODJBKilIlXZMBdz+CNuwb8aG9b6XVvSX+IUdQVQ5LcuwRCGZBmeheX07x
         SnVtXEKe2e3kxfH5GHehEJG9w0sLDfaFFrf9qqkFXY3gs3O34B2yYLtLjhBX9o3S72w5
         Ra/TLSgV7Cj2B7G2zZ6W/toHieAJ/qJ9ScvMePmTxrIfRDlAcYZ2IoZUzFvlFkinh4w+
         q7Kg==
X-Gm-Message-State: ALQs6tAoa0v925wY0LxJ8cJ1y25YfsG8Mi3luuVajDeX0w6782bnF0IO
        TSvwTVkXB4yrxQAwiDa15OJtmA==
X-Google-Smtp-Source: AIpwx4+5/XUWHP4ihuSNifZewZqgGJA1zRpeb0Va6xpAg/pY9uym3xKlr2ZRFXxvwjoB8mJa5+2cxQ==
X-Received: by 10.46.156.207 with SMTP id g15mr137791ljj.95.1522438600681;
        Fri, 30 Mar 2018 12:36:40 -0700 (PDT)
Received: from duynguyen.home (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id c19-v6sm1788556lfb.54.2018.03.30.12.36.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Mar 2018 12:36:39 -0700 (PDT)
Date:   Fri, 30 Mar 2018 21:36:37 +0200
From:   Duy Nguyen <pclouds@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v2 0/5] re-parenting relative directories after chdir
Message-ID: <20180330193637.GA1620@duynguyen.home>
References: <CACUQV5_3Pw+vnyyNUL4oE4tMLG_wKVdqdVk01rg4V92ufUYHHA@mail.gmail.com>
 <20180327063137.GA24044@sigill.intra.peff.net>
 <CACsJy8DP53Og1crS1bLoJf6w8cJhjGKy=ggfbsqzJ6AU4eNhPA@mail.gmail.com>
 <20180327164757.GB24747@sigill.intra.peff.net>
 <CACsJy8Bog6U7X-jvzDhq14heQWx0HA_21HsSYR0nykU9aDsCYQ@mail.gmail.com>
 <20180327173024.GA5017@duynguyen.home>
 <20180328095203.GB1523@sigill.intra.peff.net>
 <CACsJy8AVcPi=0i7s9o8cy-XGFuOLr72fe9WLRnEqo1SwLJEBOw@mail.gmail.com>
 <20180328173656.GA29094@sigill.intra.peff.net>
 <20180330183425.GA30575@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180330183425.GA30575@sigill.intra.peff.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 30, 2018 at 02:34:25PM -0400, Jeff King wrote:
> On Wed, Mar 28, 2018 at 01:36:56PM -0400, Jeff King wrote:
> 
> > For those just joining us, this fixes a regression that was in v2.13 (so
> > nothing we need to worry about as part of the 2.17-rc track).
> > 
> >   [1/4]: set_git_dir: die when setenv() fails
> >   [2/4]: add chdir-notify API
> >   [3/4]: set_work_tree: use chdir_notify
> >   [4/4]: refs: use chdir_notify to update cached relative paths
> 
> Here's a re-roll based on the feedback I got, including:
> 
>  - fixes the memory leak and vague comment pointed out by Eric
> 
>  - adds in tracing code from Duy
> 
>  - I took Duy's suggestions regarding "least" surprise in some of the
>    functions (reparenting NULL is a noop, and registering a reparent
>    handler does so even for an absolute path).
> 
> I punted on the "registering the same path twice" thing. That is a
> potential way to misuse this API, but I don't think there's a good
> solution. The "reparent" helper could figure this out for you, but in
> the general case we actually install an arbitrary callback. So the
> caller really has to handle it there.

The series looks good to me.

> 
> I think in the long run we'd want to outlaw calling set_git_dir() twice
> anyway.

Oh yeah. With my latest WIP changes, the bottom of
setup_git_directory_gently() looks like this. Nowhere else in setup
code calls these functions anymore (except the current
setup_work_tree)

-- 8< --
	if (result.worktree)
		set_git_work_tree(result.worktree);
	if (result.gitdir)
		set_git_dir(result.gitdir);
	if (startup_info->have_repository)
		repo_set_hash_algo(the_repository, result.repo_fmt.hash_algo);
	...
	return result.prefix;
-- 8< --

From here on, it's not hard to see how to turn set_git_work_tree()
into setup_work_tree_gently() (without doing any set_git_dir) and the
last two calls into "repo_init_gitdir(gitdir, hash_algo)", which
should be where we allocate a new repository object and initialize
related object store, ref store...

But I still have a couple setup corner cases to deal with first :(
--
Duy
