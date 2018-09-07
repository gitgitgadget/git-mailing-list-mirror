Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 207F51F404
	for <e@80x24.org>; Fri,  7 Sep 2018 06:32:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbeIGLMJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Sep 2018 07:12:09 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43776 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbeIGLMI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Sep 2018 07:12:08 -0400
Received: by mail-pf1-f193.google.com with SMTP id j26-v6so6510425pfi.10
        for <git@vger.kernel.org>; Thu, 06 Sep 2018 23:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iekKNbBNQdW1BGdByuXgmFqyO3cJxpQCvM5iZrOYQG8=;
        b=ddzsxVlLJnCydOBTjAo0vR7gXMSytlBHJ2TxvYORp2ALpriRBsNXIcvHQ6H2kWE9LF
         RdZ7/F+2qJqkfhWtYHgTb9jRP/RGy9nz3tyC3lUVoWMu2y1BVHuP9v1F33AmYifwX7Mg
         FhxIwfVwJ/7MI6tsU+lf3fKwF3z4KA/klCoFlMybZSQuo1auAX8QJFkhrE3MPglZd3RA
         UgxWVLJzTWNSE/qSjPqKcqrwpCt/DDHHmdYDqpRcxl/WebB6oL3iDmYRgqRPdJw05o38
         S33Q27f1w9MWVB8RaJ8/P1zabYRSiqpgKzgM42j6NVnI19/eKkisM4IGdpBM/TpvQQWi
         PyqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iekKNbBNQdW1BGdByuXgmFqyO3cJxpQCvM5iZrOYQG8=;
        b=WdJHP2uy7Hz3Oa+D1m85qhTUlNBo0Y/kEyaapbhkqDxL1Ncl6uN+FfkhiQjXcTkdTM
         vBjGbvmELzOTTKpu+WaOo1BlhjODdzlBfYgPqmBhO0chMnDGYVhGt96EansggNFEH4uf
         gfT4VSNxqtt2s1LJFjhV7Qd6t5ocmH/eozbrdmBw6/suHcWgcH8H4+hXtcN4BVMxRDs2
         YKGcSPgEmBwq2tM0NZeaS+hinvfvCgu2OLGFUg1kbGYAegPUWqLaxNX8lz7LScR+g8To
         Z3OneXloGV8FeQZFHBYJw01eMtmd2isNloifs1mlzST8Uxb1TyjzfNzXMVzWfjpBdD1a
         SOGQ==
X-Gm-Message-State: APzg51D1qe21qIf6tGN18+F7R8dNzrs1sbT419MqiFj30VDgJJTASr1+
        BfZj0P++4yFMHFM0mAyrF2g=
X-Google-Smtp-Source: ANB0VdYmN+IMbKAo2uBPF25yddeEIQUnrCq462Qy3BSPMrQcXnsZMqx7/t3m6iPCkV4rSplYkG0vCQ==
X-Received: by 2002:a63:28c7:: with SMTP id o190-v6mr6616670pgo.84.1536301963462;
        Thu, 06 Sep 2018 23:32:43 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id u25-v6sm9659533pfk.177.2018.09.06.23.32.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Sep 2018 23:32:42 -0700 (PDT)
Date:   Thu, 6 Sep 2018 23:32:41 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Tim Schumacher <timschumi@gmx.de>,
        gitster@pobox.com, pclouds@gmail.com
Subject: Re: ordered string-list considered harmful, was Re: [PATCH v3] Allow
 aliases that include other aliases
Message-ID: <20180907063241.GA172953@aiede.svl.corp.google.com>
References: <20180906191203.GA26184@sigill.intra.peff.net>
 <20180906192021.GB26575@sigill.intra.peff.net>
 <20180906235033.GA100309@aiede.svl.corp.google.com>
 <20180907032401.GB31728@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180907032401.GB31728@sigill.intra.peff.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:

> I don't see any point in generating a sorted list and _then_ making an
> auxiliary hashmap. My idea was that if you're using a sorted string-list
> for lookup, then you can replace the whole thing with a hash (inserting
> as you go, rather than sorting at the end).

What if I'm sorting a string list in preparation for emitting a sorted
list, and I *also* want to perform lookups in that same list?  In
other words:

[...]
> I think Stefan pointed out a "case 4" in the other part of the thread:
> ones where we really care not just about fast lookup, but actual
> iteration order.

I had assumed that that was the whole point of this data structure.
Anything else that is using it for lookups should indeed use a hash
map instead, and I can take my share of blame for missing this kind of
thing in review.

[...]
> I think I like the hashmap way, if the conversion isn't too painful.

If we don't have any callers that actually need the sort-and-lookup
thing, then yay, let's get rid of it.  But I don't actually think of
this as the hashmap way.  It's the get-rid-of-the-unneeded-feature
way.

In other words, *regardless* of what else we should do, we should
update any callers that want a hashmap to use a hashmap.  Please go
ahead, even if it doesn't let us simplify the string list API at all.

Thanks,
Jonathan
