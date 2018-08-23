Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA6EB1F954
	for <e@80x24.org>; Thu, 23 Aug 2018 01:23:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbeHWEu6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Aug 2018 00:50:58 -0400
Received: from mail-pg1-f174.google.com ([209.85.215.174]:35651 "EHLO
        mail-pg1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbeHWEu6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Aug 2018 00:50:58 -0400
Received: by mail-pg1-f174.google.com with SMTP id z4-v6so1736069pgv.2
        for <git@vger.kernel.org>; Wed, 22 Aug 2018 18:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ib4J6LKITIsx9DYBNmf1hpj3Q5sYD5j8xuRcpTVGCUw=;
        b=Sh+SQlD3C3C9R9594naxexFz62DNVG9geEukF33PtflxBSpq7EK9qRfHUbolCj2ezJ
         cz45uyciEhlyoI2EihvKezB3ffppE5bXt6CTYlxS2cgVrbx9Cswg0EOmeeQosQGY65Ok
         uCMsFnP1ITBiS2PCurETq/W6Hj/+4/rmfA2JtAnQVKQiLkNLriMhy3O5YqwJFK9SXTRX
         VXv6GqJjN7rg8HhY2TXR6+aKo9+N2Qqa6+fLgC5atFyekjwSLWakweJg0DuZ/qoJBx52
         ponB+LbhZSB1B/9GkfAqfHXhgKM4sdpb/Nb8tlfa5gcPynt/2TIdDT7nAZ42bH6OLi4B
         XoKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ib4J6LKITIsx9DYBNmf1hpj3Q5sYD5j8xuRcpTVGCUw=;
        b=gXZm9HGbV8g7tKhRVb7OPbTZ6kvSmc75+9PfRon3e28Tcelg/yA7urebiYpobLB8pJ
         iddFyV8fuJYwM8/ZnwmR9UUdOlEEpbNLRQCPLTTpdCYzSMwGRr5do9Inx8Iqjwis67kr
         LnD4E6B7sdJcansFKe0r12A8lzVqioXhzGBkirZXMkpjbQ3slG46EJKTLlT2XeDsjHBU
         q32VkqQzkAXK7Pehr6JbRrOomMaX+X36qmoDEfyfvrrhTdDLCaffIe06tDG+3Gf7Ih4C
         iWikfx3gyiqkUtcONM0xqyk1PEeJpZHNvRUU8Pup0uG4QC2pOyisQkeJFtpkSRa95n33
         1IXQ==
X-Gm-Message-State: AOUpUlHWSwfhHGPSQcKgqL71AgInbjOWYBgoiIBGe+xdOSeGvZe9kMS3
        hdCeoo1IY3YTMC2DM8utXVA=
X-Google-Smtp-Source: AA+uWPwi4LRRM2Q2KQhpCBQvaIig2F/gDYy4Y/MMxltbcwgYqrfkHjZlAS+qCQsMVAFvKdRsYxfE9A==
X-Received: by 2002:a62:fc5:: with SMTP id 66-v6mr60425984pfp.237.1534987425998;
        Wed, 22 Aug 2018 18:23:45 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id i20-v6sm3823188pfj.82.2018.08.22.18.23.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Aug 2018 18:23:45 -0700 (PDT)
Date:   Wed, 22 Aug 2018 18:23:43 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Paul Smith <paul@mad-scientist.net>, git@vger.kernel.org,
        Derrick Stolee <stolee@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [ANNOUNCE] Git v2.19.0-rc0
Message-ID: <20180823012343.GB92374@aiede.svl.corp.google.com>
References: <xmqqwoskadpe.fsf@gitster-ct.c.googlers.com>
 <1b20b754-987c-a712-2594-235b845bc5d0@gmail.com>
 <20180821212923.GB24431@sigill.intra.peff.net>
 <20180822004815.GA535143@genre.crustytoothpaste.net>
 <20180822030344.GA14684@sigill.intra.peff.net>
 <814549a01074e89a4b26cb0cf13e4dddeb3a040a.camel@mad-scientist.net>
 <20180822152306.GC32630@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180822152306.GC32630@sigill.intra.peff.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Jeff King wrote:
>> On Tue, 2018-08-21 at 23:03 -0400, Jeff King wrote:

>>>  static inline int hashcmp(const unsigned char *sha1, const unsigned
>>> char *sha2)
>>>  {
>>> +       assert(the_hash_algo->rawsz == 20);
>>>         return memcmp(sha1, sha2, the_hash_algo->rawsz);
>>>  }
[...]
>              The bigger questions are:
>
>   - are we OK with such an assertion; and
>
>   - does the assertion still give us the desired behavior when we add in
>     a branch for rawsz==32?
>
> And I think the answers for those are both "probably not".

At this point in the release process, I think the answer to the first
question is a pretty clear "yes".

A ~10% increase in latency of some operations is quite significant, in
exchange for no user benefit yet.  We can continue to try to figure
out how to convince compilers to generate good code for this (and
that's useful), but in the meantime we should also do the simple thing
to avoid the regression for users.

Thanks,
Jonathan
