Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5CCF31F453
	for <e@80x24.org>; Wed,  3 Oct 2018 14:17:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbeJCVGM (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Oct 2018 17:06:12 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40281 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726543AbeJCVGM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Oct 2018 17:06:12 -0400
Received: by mail-wr1-f66.google.com with SMTP id d2-v6so1918760wro.7
        for <git@vger.kernel.org>; Wed, 03 Oct 2018 07:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=MXMkjowuT7HAHj8XsQqlQV/k8NjLHf1QaQ9nNPxLNCw=;
        b=KIXMrlB7BTPxmz/GYA0frpEwFxfcm4h8xE5L33ggA4TMg2f4xTY2aZgWHfC+9KRup3
         QC8qxRJBR5TfK99OybATXfJm0sX9ICFYBzUmxFkNP53vaS6MYxaN5O+olvMkOoxRHSyV
         x5NsrxDI3nx6wCVHlOHryJMfwsZWCloTb88CQagoJ6neA0rTWpn5EJcrLsundnLf1WdM
         RZSlWpYIw3mckjXZiUfieh8OIdiU/GUMqDXm9qQpTgCxduyD4jODvXZAzwXil6kkYuRY
         2nkzWyXYCrQB+7XIa2qkTj+IayvPhvnE4nP+/V4Ur//2wty0xBwi3JYj6SSCGqaGI2qY
         N2hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=MXMkjowuT7HAHj8XsQqlQV/k8NjLHf1QaQ9nNPxLNCw=;
        b=uX541c3OUhyzzmkkq97HU7y+hpmVOWm8FPkdUOaKmKQ6opKu0epVil6X3QO+Ba0jnS
         guSisX2KG4nTe2zNrhBwNayLLPR/jve/9fKvQKf5Jc/di3kazBvYX39Bm7SGjxsTeqGS
         2YoUlrtoNyKrRINd1ekafsiF6rLMaxyYfK/bFxI7SS1s8xsFIBPCe1gcVDgiL9+Kq6nG
         Y/gk1KuecEUf3jGJSwPRueCjuhlkLBFM0shn7dCOzV6In/KAUM1+BH9Cn03+Dsv0oOGJ
         pSzKXqSUkT+DNn30nXLEV54mIpopTSiV1REJ6aR5A8XNGMGMGWF0XY8KRO9H9HyFgCi9
         Hf/Q==
X-Gm-Message-State: ABuFfoiLNtYxvXGEoDuAicDOeQp5Ohweopkypij3ihAHF+ibxVdejcES
        8K/ADXvPKvWvW23GRMJHfPg=
X-Google-Smtp-Source: ACcGV61SrTuMkBRir8pze7WqVcs90Lm1cOA6Y1tXc5YM9ckHXGih1/E4C13Bz7bPErqiQ/sbPf68lg==
X-Received: by 2002:adf:decb:: with SMTP id i11-v6mr1498365wrn.270.1538576255308;
        Wed, 03 Oct 2018 07:17:35 -0700 (PDT)
Received: from localhost (x4dbea401.dyn.telefonica.de. [77.190.164.1])
        by smtp.gmail.com with ESMTPSA id 188-v6sm2430926wmg.13.2018.10.03.07.17.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 07:17:34 -0700 (PDT)
Date:   Wed, 3 Oct 2018 16:17:32 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>, Git List <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: We should add a "git gc --auto" after "git clone" due to commit
 graph
Message-ID: <20181003141732.GO23446@localhost>
References: <87tvm3go42.fsf@evledraar.gmail.com>
 <20181003133650.GN23446@localhost>
 <87r2h7gmd7.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87r2h7gmd7.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 03, 2018 at 04:01:40PM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> On Wed, Oct 03 2018, SZEDER Gábor wrote:
> 
> > On Wed, Oct 03, 2018 at 03:23:57PM +0200, Ævar Arnfjörð Bjarmason wrote:
> >> Don't have time to patch this now, but thought I'd send a note / RFC
> >> about this.
> >>
> >> Now that we have the commit graph it's nice to be able to set
> >> e.g. core.commitGraph=true & gc.writeCommitGraph=true in ~/.gitconfig or
> >> /etc/gitconfig to apply them to all repos.
> >>
> >> But when I clone e.g. linux.git stuff like 'tag --contains' will be slow
> >> until whenever my first "gc" kicks in, which may be quite some time if
> >> I'm just using it passively.
> >>
> >> So we should make "git gc --auto" be run on clone,
> >
> > There is no garbage after 'git clone'...
> 
> "git gc" is really "git gc-or-create-indexes" these days.

Because it happens to be convenient to create those indexes at
gc-time.  But that should not be an excuse to run gc when by
definition no gc is needed.

> >> and change the
> >> need_to_gc() / cmd_gc() behavior so that we detect that the
> >> gc.writeCommitGraph=true setting is on, but we have no commit graph, and
> >> then just generate that without doing a full repack.
> >
> > Or just teach 'git clone' to run 'git commit-graph write ...'
> 
> Then when adding something like the commit graph we'd need to patch both
> git-clone and git-gc, it's much more straightforward to make
> need_to_gc() more granular.
> 
> >> As an aside such more granular "gc" would be nice for e.g. pack-refs
> >> too. It's possible for us to just have one pack, but to have 100k loose
> >> refs.
> >>
> >> It might also be good to have some gc.autoDetachOnClone option and have
> >> it false by default, so we don't have a race condition where "clone
> >> linux && git -C linux tag --contains" is slow because the graph hasn't
> >> been generated yet, and generating the graph initially doesn't take that
> >> long compared to the time to clone a large repo (and on a small one it
> >> won't matter either way).
> >>
> >> I was going to say "also for midx", but of course after clone we have
> >> just one pack, so I can't imagine us needing this. But I can see us
> >> having other such optional side-indexes in the future generated by gc,
> >> and they'd also benefit from this.
> >>
> >> #leftoverbits
