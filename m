Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 136C31F453
	for <e@80x24.org>; Thu, 27 Sep 2018 19:28:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728689AbeI1BsK (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Sep 2018 21:48:10 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51515 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728278AbeI1BsK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Sep 2018 21:48:10 -0400
Received: by mail-wm1-f65.google.com with SMTP id y25-v6so7023311wmi.1
        for <git@vger.kernel.org>; Thu, 27 Sep 2018 12:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=QrZ7GHGepm96Rjsio77vSDGx1d4h0K1xEjjwDUVHMmE=;
        b=qaSM/fgkbJHC89YYQoV/1QtAjZBqVnQo8wVK7Xj7RmRiUqKoPCxs38ynlUx5FuZ1gB
         vd1aTE3VwU1R54YROWijgfH3LQJ2uX0hePa0ZXJUlnW+c//fqA3f8ValE04gPH7SHHZ5
         rmbHigJgVf8amd+CZsGiBBYI43uxYHSBh7afeymoRU84uep7Dm6HQqNXohzYNTRrq/pQ
         MsNDVQrmtlorBnQK9tsmy29D+9KTPf37iH3RBLsZ3K99eriIR+lcMd4n/enIvxyHQKdI
         5OFj6ut1bJ3wF6GlDnL8AuESm7scnFsNDCrFC8TM3Ip7ZQwFqNycYW6usY3B+Ln+7Rng
         5lXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=QrZ7GHGepm96Rjsio77vSDGx1d4h0K1xEjjwDUVHMmE=;
        b=rWAYdkjAoEOqrA9qnV+7CsU82HxfczGPPm+3p2Eg1kz59GCfp5/Nl4kqfoiRbxWVQ3
         aHBPP7gZazK/FNa7JTAgko49Ajdi/JiUyaL+SFLjWu7hUNaDsz1N6GIVr/MzJft67cyV
         aTyerRirF30YP1jgxFDFAW5wOeMeT4fPhy3get1oGX1u8Myci7gmpemWdCG2blGpzBXz
         mrniM1MQNItBBaXQ33dpbv2VmkcYImjPnK9wAgxnMwxpbp2gmKX9R1pk7SsogcbX75YO
         dvQl0B49xYTRGxGSZ4YKzLGVul5xJCVfO2PQ15rXbrxh2pxZZFs6PmlfFPJH6P+Z0nAV
         UBFA==
X-Gm-Message-State: ABuFfoiHmqyX6DBZ0VRgJU9VcTLi1PNV7CCDLuROfbsxlobaAEppwDc8
        ygtMpdbmy5NsfkEM6SEh6uo=
X-Google-Smtp-Source: ACcGV63Vtq5fwGIYnhpAm6QlWwS4yacYJLbeV0wX5gupOxhtwopVi0ka6T9XQ+CiWiwKq5Ipa1uHaQ==
X-Received: by 2002:a1c:3545:: with SMTP id c66-v6mr50933wma.120.1538076500499;
        Thu, 27 Sep 2018 12:28:20 -0700 (PDT)
Received: from rigel (236.209.54.77.rev.vodafone.pt. [77.54.209.236])
        by smtp.gmail.com with ESMTPSA id f9-v6sm2591560wmc.24.2018.09.27.12.28.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 12:28:19 -0700 (PDT)
Date:   Thu, 27 Sep 2018 20:28:04 +0100
From:   Rafael =?iso-8859-1?Q?Ascens=E3o?= <rafa.almas@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Nickolai Belakovski <nbelakovski@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] branch: colorize branches checked out in a linked
 working tree the same way as the current branch is colorized
Message-ID: <20180927192804.GA27163@rigel>
References: <CAC05386q2iGoiJ_fRgwoOTF23exEN2D1+oh4VjajEvYQ58O1TQ@mail.gmail.com>
 <20180927181708.GA2468@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180927181708.GA2468@sigill.intra.peff.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 27, 2018 at 02:17:08PM -0400, Jeff King wrote:
> Do we want to limit this to git-branch, though? Ideally any output you
> get from git-branch could be replicated with for-each-ref (or with
> a custom "branch --format").
> 
> I.e., could we have a format in ref-filter that matches HEAD, but
> returns a distinct symbol for a worktree HEAD? That would allow a few
> things:

I was going to suggest using dim green and green for elsewhere and here
respectively, in a similar way how range-diff uses it to show different
versions of the same diff.

But if we're open to change how branches are displayed maybe a config
option like branch.format (probably not the best name choice) that can
be set to the 'for-each-ref --format' syntax would be way more flexible.

e.g.
    branch.format='%(if:equals=+)...'

I think the different symbol and dimmed color would be a nice addition,
but I am leaning towards giving the user the ultimate choice on how they
want to format their output. (Maybe with dimmed plus symbol as default).

--
Cheers,
Rafael Ascensão
