Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9EEC01F404
	for <e@80x24.org>; Thu,  5 Apr 2018 01:53:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752765AbeDEBxH (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Apr 2018 21:53:07 -0400
Received: from mail-pl0-f51.google.com ([209.85.160.51]:38681 "EHLO
        mail-pl0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752642AbeDEBxG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Apr 2018 21:53:06 -0400
Received: by mail-pl0-f51.google.com with SMTP id k6-v6so11793139pls.5
        for <git@vger.kernel.org>; Wed, 04 Apr 2018 18:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Fmhxc6RP5rQIXkQalzTJXrB7s+qkORJ+xeX9PO8AE8M=;
        b=i2WYc4d9Q+TSLM92+1+LG2TP9Dj+JXD91jJ0BcE8jmkoc4JwUNyeGmXlYKxFPi4Fac
         ie2pRh8DjklgPwXCwq2aF/DtSOFv/Jn8GGGnNRk+aCMsgV/KMgagN45GF7evdXHLwyRZ
         rhMzOprJEAwg8Kgft3ri0htn1TXoKUSQuOl4Cj10pkNOg+7XWZUm2rKSb3mUTjnwsVGB
         hDjqwn3+ABetVIFKvbF7JLhZPT05lakDXrBNvC9Yp0surLP2CF4iEhf44y+pbGedIfz/
         wbe+oUgYNuRbDdnxroW2jzt7GRLF+rI1vigcTGdc6vXmYrHAuF0pvT2x5cKBfUA3REY4
         pmEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Fmhxc6RP5rQIXkQalzTJXrB7s+qkORJ+xeX9PO8AE8M=;
        b=p1m1UJZfTa8EVAMMPRD+XTYDsplVik49c486CZ6hIzM85em5uQhyAZnE76nyFKWRVO
         z5t72vTC80+3ReFfxJvrlhOVlHGFzGx4ZXonK7pT0NJmFLkcOV0U2mwL4ats4/shZkJB
         mR1hVucFc6D7ciEURMZhJlcrOu56Q/RFM/3x0OK1Gro5aA+ejZ4YDQ9J1EpLEzITPEBv
         PHd/nDtaj7nbGY9cxwxt9p1dEzsjLPrUrmN0Ehjmvgx1AGzTErEGO3ea9U3hsb14q+Yg
         63I86eYosM0o8B8xgPJyHpTmhUzU3WBX/PqPGGwAhDRP6r5etkRWWh97eMAehg/GqMOQ
         kMvQ==
X-Gm-Message-State: AElRT7GAApnhTa8xjOBDlV403W+hyp7wiwe6wgmB5dm7StzJbzpZ6aAC
        UgUH6nJTzW5C5xOnsEz3RJc8PA==
X-Google-Smtp-Source: AIpwx48X8HSnlS65pO5PInu6CJ00s3zt9d7RnYnZFazugNH3kxRaR7QBhP9ytUj50/n9psmHUKJt9g==
X-Received: by 2002:a17:902:864a:: with SMTP id y10-v6mr21529199plt.45.1522893186229;
        Wed, 04 Apr 2018 18:53:06 -0700 (PDT)
Received: from localhost ([2601:602:9500:3a4f:dc75:c2ae:e99:b3d1])
        by smtp.gmail.com with ESMTPSA id l11sm10106131pgq.83.2018.04.04.18.53.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Apr 2018 18:53:04 -0700 (PDT)
Date:   Wed, 4 Apr 2018 18:53:04 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v3 1/2] builtin/config.c: treat type specifiers singularly
Message-ID: <20180405015304.GB4671@syl.local>
References: <20180328234719.595-1-me@ttaylorr.com>
 <20180404060743.39278-1-me@ttaylorr.com>
 <20180404060743.39278-2-me@ttaylorr.com>
 <CAPig+cRNSYz_guBS9yNEXdAbfG+FWtvnzwsWRu0DRe0N_VkiOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPig+cRNSYz_guBS9yNEXdAbfG+FWtvnzwsWRu0DRe0N_VkiOQ@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 04, 2018 at 03:57:12AM -0400, Eric Sunshine wrote:
> On Wed, Apr 4, 2018 at 2:07 AM, Taylor Blau <me@ttaylorr.com> wrote:
> > [...]
> > In fact, `git config` will not accept multiple type specifiers at a
> > time, as indicated by:
> >
> >   $ git config --int --bool some.section
> >   error: only one type at a time.
> >
> > This patch uses `OPT_SET_INT` to prefer the _last_ mentioned type
> > specifier, so that the above command would instead be valid, and a
> > synonym of:
> >
> >   $ git config --bool some.section
> >
> > This change is motivated by two urges: (1) it does not make sense to
> > represent a singular type specifier internally as a bitset, only to
> > complain when there are multiple bits in the set. `OPT_SET_INT` is more
> > well-suited to this task than `OPT_BIT` is. (2) a future patch will
> > introduce `--type=<type>`, and we would like not to complain in the
> > following situation:
> >
> >   $ git config --int --type=int
>
> I can understand "last wins" for related options such as "--verbose
> --quiet" or "--verbose=1 --verbose=2", but I have a lot of trouble
> buying the "last wins" argument in this context where there is no
> semantic relationship between, say, --bool and --expiry-date.
> Specifying conflicting options together is likely to be unintentional,
> thus reporting it as an error seems sensible, so I'm not convinced
> that patch's removal of that error is a good idea.
>
> I understand that you're doing this to avoid complaining about "--int
> --type=int", but exactly how that case is supported should be an
> implementation detail; it doesn't need to bleed into the UI as an
> unnecessary and not-well-justified loosening of an age-old
> restriction. There are other ways to support "--int --type=int"
> without "last wins". Also, do we really need to support "--int
> --type=int"? Is that an expected use-case?

This is a fair concern, though I view the problem slightly differently.
I see this change as being motivated by the fact that we are adding
"--type", not removing an age-old restriction.

Peff's motivation for this--as I understand it--is that "--type=int"
should be a _true_ synonym for "--int". Adopting the old-style
"OPT_SET_BIT" for this purpose makes "--type=int" and "--int" _mostly_ a
synonym for one another, except that "--type=bool --type=int" will not
complain, whereas "--bool --int" would.

Loosening this restriction, in my view, brings us closer (1) to the new
semantics of multiple "--type"'s, and (2) to the existing semantics of
"--verbose=1 --verbose=2" as you mentioned above.

I would like to hear Peff's take on this as well, since he suggested the
patch originally, and would likely provide the clearest insight into
this.


Thanks,
Taylor
