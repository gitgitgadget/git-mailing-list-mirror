Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFF611F404
	for <e@80x24.org>; Fri,  7 Sep 2018 07:23:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbeIGMDb (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Sep 2018 08:03:31 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41847 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbeIGMDb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Sep 2018 08:03:31 -0400
Received: by mail-pl1-f195.google.com with SMTP id b12-v6so6182234plr.8
        for <git@vger.kernel.org>; Fri, 07 Sep 2018 00:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=/oWtPLlOmFaDlyfLg+guQgsTFSfz71aN+h5sHGZz2Es=;
        b=dSUq+PLd0n7R9yfj7scw7A4D2ZDRmE7l6woUvn0X2EqmruF3BiNvDCqWJwKbq7F0nk
         LrEzJwyi2q/p+Dh0PsZnkosbKextPPPEsdg0RO3LNoH1XCZ7mqdYnYYiQw5rM088oRXQ
         pe9C1hyBdr596v+/D8sVptPG4LPfiOHHKy6KUS2M9+ovOndjSkIsKLa0kOwO4mLIvg6D
         xytzLZIutfUFk+BalVw6jWRzP6UTFH4m4475vXquka4UY7I/aoIbR5D76wuRA8QU3ruL
         xE8WBxOaovevPXrq6EZ2rTXKi+060lnIRqLs3lvXYJAPoiriAejbPodmQvJd94arit9e
         imrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=/oWtPLlOmFaDlyfLg+guQgsTFSfz71aN+h5sHGZz2Es=;
        b=UaOKFQeof5DaCcihqhpTK5QHXTffmXVMIEIUSDaHSsn9yO1NvznelhIyJgKezimwv3
         dQp385L3F8s2H8089HjwIqTVGVFRz0S5hk+HLKoF02tcbmXasDbjTakXbSErnOvuts/J
         UfwPqjaC9ouMPmJMAlwvTUSBfvE6qj2HvzPy7pM15m1eSWQKUpfhDmgn4Z15ts541wjf
         xZFMkmP6Oy6tu+brhBZsB/FcqHy8YEpu40obyPYl/Txo6NNVmwO9gwFTc9u1fy7D/rx1
         iFb2re3tt4CVImeLsAZM01Sq1rJ1ShebrS17LzHWLTVG3/7WjV9fKaagHYtGzXvuA0mp
         d7XA==
X-Gm-Message-State: APzg51CpayBiw4oTAfrt4rj6vMLhyeT6hK3C0RJZzDpxnFJXvuyYIGTW
        2MY74JAEQl4Zn8ATs6naMuA=
X-Google-Smtp-Source: ANB0VdY57+DV1WaX/QRadkI2KoYMcEwgWRktG1vTBj6ZqOzz3R/BdmB8rlKTjIf2CDWPIMT/MexthQ==
X-Received: by 2002:a17:902:b784:: with SMTP id e4-v6mr6639655pls.204.1536305036252;
        Fri, 07 Sep 2018 00:23:56 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id 5-v6sm9272094pgc.86.2018.09.07.00.23.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Sep 2018 00:23:55 -0700 (PDT)
Date:   Fri, 7 Sep 2018 00:23:53 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Tim Schumacher <timschumi@gmx.de>, gitster@pobox.com,
        pclouds@gmail.com
Subject: Re: ordered string-list considered harmful, was Re: [PATCH v3] Allow
 aliases that include other aliases
Message-ID: <20180907072353.GC172953@aiede.svl.corp.google.com>
References: <20180906191203.GA26184@sigill.intra.peff.net>
 <20180906192021.GB26575@sigill.intra.peff.net>
 <20180906235033.GA100309@aiede.svl.corp.google.com>
 <20180907032401.GB31728@sigill.intra.peff.net>
 <20180907063241.GA172953@aiede.svl.corp.google.com>
 <87in3hrcya.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87in3hrcya.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason wrote:
> On Fri, Sep 07 2018, Jonathan Nieder wrote:
>> Jeff King wrote:

>>> I don't see any point in generating a sorted list and _then_ making an
>>> auxiliary hashmap. My idea was that if you're using a sorted string-list
>>> for lookup, then you can replace the whole thing with a hash (inserting
>>> as you go, rather than sorting at the end).
>>
>> What if I'm sorting a string list in preparation for emitting a sorted
>> list, and I *also* want to perform lookups in that same list?  In
>> other words:
>
> If this turns out to be a common use-case perhaps the easiest way to
> support that would be to make the hashmap (optionally?) ordered, as Ruby
> 1.9 did with their hash implementation:
> https://www.igvita.com/2009/02/04/ruby-19-internals-ordered-hash/

That's about recording the order of insertion.  I'm talking about
something much simpler: sorting an array (as preparation for emitting
it) and binary searching to find an entry in that array.
