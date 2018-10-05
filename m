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
	by dcvr.yhbt.net (Postfix) with ESMTP id DA10E1F97E
	for <e@80x24.org>; Fri,  5 Oct 2018 20:01:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728583AbeJFDBt (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Oct 2018 23:01:49 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34512 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728139AbeJFDBt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Oct 2018 23:01:49 -0400
Received: by mail-ed1-f66.google.com with SMTP id q19-v6so12690827edr.1
        for <git@vger.kernel.org>; Fri, 05 Oct 2018 13:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=0FqMbyfluT3wKMzerE/4er4ZZKLnaFTyj+FQoFarapQ=;
        b=buIQVTnQDUaBpw2JCSjdbdkBGxI26/F6Dkv8+u4PxwxMk29ZYfc7/uL9Q/LFWfnY8y
         bvmaihR0OsHtS8A9KWoHUT591MAw8ZzL23TJCaAV//NNWXiywDjV2nWYif9xCGIBTQcP
         U2bG34U/VIwBozkBxlXs6YKdIKatSDJ57tCyv8M6kbOtWiqmk/9smng4f9AeQlU12LFj
         +mfr59u6cD6wpepWTLYk+VKkmBN3KHCL+LgD3mDVRCoYTtYX9mcPA+wF2GSXxL6RMQSF
         DSqOM1yc0FdnUZVBcyy7DfF59/db/0QG/UAFLg0LgSVAZDQTU5Gc76lB+aTpYMg1Easn
         EUmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=0FqMbyfluT3wKMzerE/4er4ZZKLnaFTyj+FQoFarapQ=;
        b=sXwIsNef7z13FYa2THcDOhFqNEOuVqxymO/1d0dTovQWVMlXCEG02dUdh0nIgrhjLH
         Zb4iEIF+sjQwPFM82gdXXIiwJ5TvbFMsjZUled6CLOIuQsaYBVCwsoF0ddh6W+0C/hBZ
         Dyi5PDnLeZEMDf3IBvw+2/xg9PzXRwNX7I85K0RBtABp5MkWveugzh9VeAZaJLV7NJjK
         cZVNzGr6W2IgqL4Xg2s7iPotI0oMZ2UXYSw3kI0BBa2CTGExAgkYye0PFwsHhtwZwR7x
         TRZaBG6qmONEjR41PWA6dSNDL1GrxRwoMXTA64zwEC+E0XnkIC3zrGsK8K7UyhNJ6gkm
         YSQg==
X-Gm-Message-State: ABuFfogRBMWkrixm+iqI1naFelg3RqmyObOJqW8uYe71arWFXtK0MDtZ
        TDDza5lgBg3oP4wvisOXyfc=
X-Google-Smtp-Source: ACcGV63sUZhLeAClhQG4QgmmtTo+AazD0BkiyECYhJioIBggMdztrSe181b0pYLt1qn7bRjhmmu5VA==
X-Received: by 2002:a17:906:22c4:: with SMTP id q4-v6mr12807537eja.160.1538769692569;
        Fri, 05 Oct 2018 13:01:32 -0700 (PDT)
Received: from evledraar (g74155.upc-g.chello.nl. [80.57.74.155])
        by smtp.gmail.com with ESMTPSA id u57-v6sm137445edm.97.2018.10.05.13.01.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Oct 2018 13:01:31 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee <stolee@gmail.com>, Git List <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [RFC PATCH] We should add a "git gc --auto" after "git clone" due to commit graph
References: <87tvm3go42.fsf@evledraar.gmail.com>
        <87in2hgzin.fsf@evledraar.gmail.com>
        <dcb8f115-ce3c-64fa-50cc-dd03569c0164@gmail.com>
        <87ftxkh7bf.fsf@evledraar.gmail.com>
        <05fefab0-4012-4ef0-5df1-2430eea2bf4d@gmail.com>
        <20181005192154.GD17482@sigill.intra.peff.net>
        <934fa00e-f6df-c333-4968-3e9acffab22d@gmail.com>
        <20181005194703.GA19735@sigill.intra.peff.net>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20181005194703.GA19735@sigill.intra.peff.net>
Date:   Fri, 05 Oct 2018 22:01:31 +0200
Message-ID: <875zyggo2s.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Oct 05 2018, Jeff King wrote:

> On Fri, Oct 05, 2018 at 03:41:40PM -0400, Derrick Stolee wrote:
>
>> > So can we really just take (total_objects - commit_graph_objects) and
>> > compare it to some threshold?
>>
>> The commit-graph only stores the number of _commits_, not total objects.
>
> Oh, right, of course. That does throw a monkey wrench in that line of
> thought. ;)
>
> There's unfortunately not a fast way of doing that. One option would be
> to keep a counter of "ungraphed commit objects", and have callers update
> it. Anybody admitting a pack via index-pack or unpack-objects can easily
> get this information. Commands like fast-import can do likewise, and
> "git commit" obviously increments it by one.
>
> I'm not excited about adding a new global on-disk data structure (and
> the accompanying lock).

You don't really need a new global datastructure to solve this
problem. It would be sufficient to have git-gc itself write out a 4-line
text file after it runs saying how many tags, commits, trees and blobs
it found on its last run.

You can then fuzzily compare object counts v.s. commit counts for the
purposes of deciding whether something like the commit-graph needs to be
updated, while assuming that whatever new data you have has similar
enough ratios of those as your existing data.

That's an assumption that'll hold well enough for big repos where this
matters the most, and who tend to grow in fairly uniform ways as far as
their object type ratios go.

Databases like MySQL, PostgreSQL etc. pull similar tricks with their
fuzzy table statistics.
