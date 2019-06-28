Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 590101F461
	for <e@80x24.org>; Fri, 28 Jun 2019 23:04:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbfF1XEW (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Jun 2019 19:04:22 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40062 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbfF1XEW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jun 2019 19:04:22 -0400
Received: by mail-wr1-f68.google.com with SMTP id p11so7791066wre.7
        for <git@vger.kernel.org>; Fri, 28 Jun 2019 16:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=owWB8AspTuZ7c4EHfks+no0RI0mxk6iMi8F2NWy5bwc=;
        b=PMQKbEXiIQzdT7zUYAKjSesMLuw28LnpCZpxbpmtdGahFpfiPSa9oP0m2iyswGrtdg
         eaNsjDxpq7Z2Fgx0HdaRDJjcX/pqWHaHrzggdFvHOKD0kBFK91/P6I+9ukKvn08V2JKl
         TJSnLPc/kQOuRGYiSuE3/JQfoZsyyCikwh8d/XANouaB6DR3/Umxdh7FGDdeFyTcOBq6
         iY8fWIwTtwSXZbqAkViNIlEXPhkdM21635nkhS38mzaYXwxl7e3GVspOq8iLIH3A2n9j
         spJVe2y6sUVNIK2BAFulKu//rGqsZRWaXmKm3mhCjpJXYIrA+EjB/u03j4+nPQNKcQwY
         og2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=owWB8AspTuZ7c4EHfks+no0RI0mxk6iMi8F2NWy5bwc=;
        b=QhnwjQjvjZtL7rlfDfdBsQ0mA3BPHUaoJP9VH17ODrcB4lTm7tnzIvZ6JXkP+pV3hX
         yfwLBmSE4bFXM/geKox61YbWjHwWi4anf2aNaCrgU774U15lm09h9KQPGp9UfAG8iSH+
         M3Y+uUfCF10uqqzT38WT72izeG+6YgBSslAKRCwV1ryJ7fPzTmczP9R2Dw0jOJbl0xE1
         MVQfClaD1ewyym9W6nMLHoWnEjiwev6dUrllGW3Sdig2TE+WiBN5YzuiEzAlenVzoUk6
         ZI6d3f1Oe1QSYlRAplM7rOUmc3fdEgtgba9KJedm1NrL776iii8nQJZWTDX41PfghIGy
         Sv6g==
X-Gm-Message-State: APjAAAUax7ainNP9xoW0M5pqKNUqX3WfMmjJHfUSGyuSSvj3xHMf+33/
        w6FV/jMf37+plP62rPh+bn0=
X-Google-Smtp-Source: APXvYqyLhLsUJNKdm4P8AZjTcTN9hW3gEMWo+g8PeqBYb9XooCJ7ScxEZFLSVBpWiRxaUE2kmZQRnw==
X-Received: by 2002:a5d:5342:: with SMTP id t2mr2066328wrv.126.1561763060077;
        Fri, 28 Jun 2019 16:04:20 -0700 (PDT)
Received: from szeder.dev (x4db437bb.dyn.telefonica.de. [77.180.55.187])
        by smtp.gmail.com with ESMTPSA id h6sm2760960wre.82.2019.06.28.16.04.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jun 2019 16:04:19 -0700 (PDT)
Date:   Sat, 29 Jun 2019 01:04:17 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Jeff King <peff@peff.net>, Derrick Stolee <stolee@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH 1/6] test-lib: introduce test_commit_bulk
Message-ID: <20190628230417.GC21574@szeder.dev>
References: <20190628093751.GA3569@sigill.intra.peff.net>
 <20190628093911.GA27329@sigill.intra.peff.net>
 <CAPig+cQAKVOqYH-CcqzViP_zuKwg5fWO2_i8=Z5t=BVf9uoAXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cQAKVOqYH-CcqzViP_zuKwg5fWO2_i8=Z5t=BVf9uoAXQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 28, 2019 at 05:32:35PM -0400, Eric Sunshine wrote:
> On Fri, Jun 28, 2019 at 5:39 AM Jeff King <peff@peff.net> wrote:

> > +# to have every commit touch the same file, but with unique content. Spaces are
> > +# OK, but you must escape any metacharacters (like backslashes or
> > +# double-quotes) you do not want expanded.
> > +#
> > +test_commit_bulk () {
> > +       [...]
> > +       in_dir=${indir:+-C "$indir"}
> 
> Doesn't this suffer the problem in which some older/broken
> shells[1][2][3][4] incorrectly expand this to:
> 
>     "-C <dir>"
> 
> rather than the expected:
> 
>     -C "<dir>"
> 
> ? Is this something we still care about?
> 
> Same comment applies to other instances of ${indir:+-C "$indir"} below.

I think we don't need any of those "${indir:+-C "$indir"}" parameter
expansions and could simply use 'git -C "$indir" cmd...' everywhere.
$indir is set to empty right at the start of the function, and 'git -C
"" ...' works and doesn't change the working directory.

