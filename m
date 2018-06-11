Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 107271F403
	for <e@80x24.org>; Mon, 11 Jun 2018 19:01:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934523AbeFKTBI (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Jun 2018 15:01:08 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34287 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934038AbeFKTBH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jun 2018 15:01:07 -0400
Received: by mail-pg0-f68.google.com with SMTP id q4-v6so9133912pgr.1
        for <git@vger.kernel.org>; Mon, 11 Jun 2018 12:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lmV6k1FDGxnVSQ3Y4Nqrw9TqPV0/kNYdleQ08kJzhc0=;
        b=AJe7pCYIxYvd6gy24k+lOOkd3H1fUoDtyXpVM9HnXjZm0etw3aMPeFYF8b8Ff2vXtt
         Ovfxyzxy6kIrJxhES79EvxburjUvNFD5cNZ1m0WaXXtW9AJN4EyP5Ri/KUhfPr+YQp5v
         kwS3h/aQxo8sgrcKdtj6NP0rkRjabXt2RR7CRtnl8M+8+60/Z2EPDbPjTdVKdU0mx4me
         KtyeAQJNezwAHXcfgZNqBO3cuZEk83kV/ClF/XmaRBMJ82C8ImnvyRdH1aksg/EeapuJ
         1+NPKV+TeNZjJar4fon1S02TqkwQbWsVF3XxG4SBDpF0mLdKMiULlRcXxT0evCcztdID
         HWZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lmV6k1FDGxnVSQ3Y4Nqrw9TqPV0/kNYdleQ08kJzhc0=;
        b=MvRPPJNV3Eo+Tm/jTDZA2LlPM0f24vdJhyK55Opiuy7Mzl7fb+8aXgv+/rjxeIkf1P
         i+V/jQ6ofiXqIArNnaZ9A9qNa88KRG7LAPTVhn1jH0iAPm/HwAvTbKglR+vTBBKyURUE
         b6uGDn6CbKAPJpM6uRpg2169yq2CccQ6FlGZgjs/wIxtCiE/3MlcJWmYIMrUZ9Dc0sQj
         e/s7gm/2jp1MGgC4oT/cnftELvHu51ujZxmRXZ9upISA6e+C7FGKtyrxdL5B8X3237gy
         38vEuYzThzuZIh2pHIFhiIPjlUcLEtFvUf7r8aDLQx3NWIh/ZLmXbfF1np59AENKJo+A
         Q0kA==
X-Gm-Message-State: APt69E0G0yQXFdrk2ROMg3UwG00272wPKRkbEG3NW/OKDbBWLaxG1v3C
        Yw6hnI/ZM1M5kH52kje1hQ0=
X-Google-Smtp-Source: ADUXVKJDvSzZhW4tr8IvXtJjHGv+NYf1qcW3/6W91U2Zm8g7i+/trHOmP2mQf2XrZUouRrpEqHp6kQ==
X-Received: by 2002:a65:6559:: with SMTP id a25-v6mr347797pgw.82.1528743665331;
        Mon, 11 Jun 2018 12:01:05 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id z3-v6sm19444634pfn.36.2018.06.11.12.01.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Jun 2018 12:01:04 -0700 (PDT)
Date:   Mon, 11 Jun 2018 12:01:03 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>
Subject: Re: State of NewHash work, future directions, and discussion
Message-ID: <20180611190103.GB20665@aiede.svl.corp.google.com>
References: <20180609205628.GB38834@genre.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180609205628.GB38834@genre.crustytoothpaste.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

brian m. carlson wrote:

> Since there's been a lot of questions recently about the state of the
> NewHash work, I thought I'd send out a summary.

Yay!

[...]
> I plan on introducing an array of hash algorithms into struct repository
> (and wrapper macros) which stores, in order, the output hash, and if
> used, the additional input hash.

Interesting.  In principle the four following are separate things:

 1. Hash to be used for command output to the terminal
 2. Hash used in pack files
 3. Additional hashes (beyond (2)) that we can look up using the
    translation table
 4. Additional hashes (beyond (1)) accepted in input from the command
    line and stdin

In principle, (1) and (4) would be globals, and (2) and (3) would be
tied to the repository.  I think this is always what Duy was hinting
at.

All that said, as long as there is some notion of (1) and (4), I'm
excited. :)  Details of how they are laid out in memory are less
important.

[...]
> The transition plan anticipates a stage 1 where accept only SHA-1 on
> input and produce only SHA-1 on output, but store in NewHash.  As I've
> worked with our tests, I've realized such an implementation is not
> entirely possible.  We have various tools that expect to accept invalid
> object IDs, and obviously there's no way to have those continue to work.

Can you give an example?  Do you mean commands like "git mktree"?

[...]
> If you're working on new features and you'd like to implement the best
> possible compatibility with this work, here are some recommendations:

This list is great.  Thanks for it.

[...]
> == Discussion about an Actual NewHash
>
> Since I'll be writing new code, I'll be writing tests for this code.
> However, writing tests for creating and initializing repositories
> requires that I be able to test that objects are being serialized
> correctly, and therefore requires that I actually know what the hash
> algorithm is going to be.  I also can't submit code for multi-hash packs
> when we officially only support one hash algorithm.

Thanks for restarting this discussion as well.

You can always use something like e.g. "doubled SHA-1" as a proof of
concept, but I agree that it's nice to be able to avoid some churn by
using an actual hash function that we're likely to switch to.

Sincerely,
Jonathan
