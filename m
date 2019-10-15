Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B4941F4C0
	for <e@80x24.org>; Tue, 15 Oct 2019 20:00:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbfJOUAs (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Oct 2019 16:00:48 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:32855 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbfJOUAs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Oct 2019 16:00:48 -0400
Received: by mail-pf1-f195.google.com with SMTP id q10so13175986pfl.0
        for <git@vger.kernel.org>; Tue, 15 Oct 2019 13:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=duE75I+o6PCrL7aEu3phsFRdZRF7Jg5P1//6eNuTe+0=;
        b=bNhvT4JFR/1ozdQ6waKpFA7w4wpkK+R5PuB0IGtotR39s+uMvDTBETZgjZt6w807ZU
         iMMpYr2a3COfUVOY6NrWo6f4QvbL/RUbLE6JQtq7BXI7h22Y3VmOMXwHFnHTU8Aoo3wE
         AX3HHdIwAGC+sX+nAU6cP0gK70H3iVszRwOxvrhujd+JKE2c0J6Uyr0LzirNl9qbuMJ7
         1SP0mRPtUVeOOjpd+A5QE/sie9A9nNuYs3PfiHCdfoEeF9OAnkgaQWWO5iGoh9UvZml1
         l1RdC4TGL03TyMHOhL09ExhHRjuyjE5TmU5QD/pguDy0bSxURsJoqx8wrj/SVxFPSA6T
         fU5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=duE75I+o6PCrL7aEu3phsFRdZRF7Jg5P1//6eNuTe+0=;
        b=arjsSRssRXDXvQuKb5jIdfC8/MZB+IwupUSu5hYpPa7UfGP4KoeAKps65jU9m/NbnF
         P+F4QE5/Il9sHqF8Ke+cC2dwamONA6ks9QvxhBrnQn3k/tMoGrN2XQ96xgUZ27tFPR+1
         Kf8OPzI1++FIkKynR85FwI2ZvfvpjZtSfyxyIGuLBJJB6yXiipmxtVtGfN3uKVEjUZyY
         zLhLjNjl2Fa4frYJ/J/nRJlkZRnMZPmCLIkKl4CreO+5P4f3j7NmJKW/qHAJJpXVoSKC
         jp8yP8vODEz1sYW1eHZMskr+RjsWNwJUJknHNXYY6Nl9n+qb746YkaCUZWLtjj6VcfeZ
         vV5g==
X-Gm-Message-State: APjAAAXpJtelh+T5Wf3l8IEpDspVu4Q2C7CNLkM/07jy3Waf8Eb73eXF
        alSQ1obaDY6+O0PD3DdRI4I=
X-Google-Smtp-Source: APXvYqxyXdXNDl+y3X4WSAYGHDKQJ4IKW0WhnBPeCHrONJxuZ2uhKGGkrg2dZbTtbE4MItEfQ/nEVQ==
X-Received: by 2002:aa7:8249:: with SMTP id e9mr39535458pfn.46.1571169647493;
        Tue, 15 Oct 2019 13:00:47 -0700 (PDT)
Received: from GVFSs-MBP.guest.corp.microsoft.com ([2001:4898:80e8:7:edf1:7ee7:ed2b:8e04])
        by smtp.gmail.com with ESMTPSA id p11sm23182177pgs.51.2019.10.15.13.00.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2019 13:00:46 -0700 (PDT)
Subject: Re: [PATCH v2 1/6] midx: add MIDX_PROGRESS flag <snip>
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     William Baker via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, stolee@gmail.com, jeffhost@microsoft.com,
        William Baker <William.Baker@microsoft.com>
References: <pull.337.git.gitgitgadget@gmail.com>
 <pull.337.v2.git.gitgitgadget@gmail.com>
 <6badd9ceaf4851b2984e78a5cfd0cb8ec0c810f5.1568998427.git.gitgitgadget@gmail.com>
 <20190921121104.GA6787@szeder.dev>
 <xmqqlfu9krzv.fsf@gitster-ct.c.googlers.com>
 <20191007172951.GC11529@szeder.dev>
 <xmqqk19fn9jp.fsf@gitster-ct.c.googlers.com>
 <20191009013231.GF29845@szeder.dev>
From:   William Baker <williamtbakeremail@gmail.com>
Message-ID: <04342d12-fffc-afb6-fa4e-c2e2bf88d1b6@gmail.com>
Date:   Tue, 15 Oct 2019 13:00:45 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191009013231.GF29845@szeder.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/8/19 6:32 PM, SZEDER Gábor wrote:
>>> No, they tend to show (PROGRESS | REGRESS), at least both gdb and lldb
>>> do.
> 
> I was wrong here, gdb does this, but lldb, unfortunately, doesn't; see
> my other reply in this thread.
>
>> What I was worried about is that the constants that are used to
>> represent something that are *NOT* set of bits (hence "PROGRESS * 3"
>> may be perfectly a reasonable thing for such an application)
> 
> I don't really see how that could be reasonable, it's prone to break
> when changing the values of the enum constants.
> 
>> may be
>> mistaken by an overly clever debugger and "3" may end up getting
>> shown as "PROGRESS | REGRESS".  When there are only two constants
>> (PROGRESS=1 and REGRESS=2), we humans nor debuggers can tell if that
>> is to represent two bits that can be or'ed together, or it is an
>> enumeration.
>>
>> Until we gain the third constant, that is, at which time the third
>> one may likely be 3 (if enumeration) or 4 (if bits).
> 
> Humans benefit from context: they understand the name of the enum type
> (e.g. does it end with "_flags"?), the name of the enum constants, and
> the comment above the enum's definition (if any), and can then infer
> whether those constants represent OR-able bits or not.  If they can't
> find this out, then that enum is poorly named and/or documented, which
> should be fixed.  As for the patch that I originally commented on, I
> would expect the enum to be called e.g. 'midx_flags', and thus already
> with that single constant in there it'll be clear that it is intended
> as a collection of related OR-able bits.
> 
> As for the debugger, if it sees a variable of an enum type whose value
> doesn't match any of the enum constants, then there are basically
> three possibilities:
> 
>   - All constants in that enum have power-of-two values.  In this case
>     it's reasonable from the debugger to assume that those constants
>     are OR'ed together, and is extremely helpful to display the value
>     that way.
> 
>   - The constants are just a set of values (1, 2, 3, 42, etc).  In
>     this case the variable shouldn't have a value that doesn't match
>     one of the constants in the first place, and I would first suspect
>     that the program might be buggy.
> 
>   - A "mostly" power-of-two enum might contain shorthand constants for
>     combinations of a set of other constants, e.g.:
> 
>       enum flags {
>               BIT0 = (1 << 0),
>               BIT1 = (1 << 1),
>               BIT2 = (1 << 2),
> 
>               FIRST_TWO = (BIT0 | BIT1),
>       };
>       enum flags f0 = BIT0;
>       enum flags f1 = BIT0 | BIT1;
>       enum flags f2 = BIT0 | BIT2;
>       enum flags f3 = BIT0 | BIT1 | BIT2;
> 
>     In this case, sadly, gdb shows only matching constants:
> 
>       (gdb) p f0
>       $1 = BIT0
>       (gdb) p f1
>       $2 = FIRST_TWO
>       (gdb) p f2
>       $3 = 5
>       (gdb) p f3
>       $4 = 7
> 

I believe this is the last open thread/discussion on the "midx: add MIDX_PROGRESS
flag" patch series.  

A quick summary of where the discussion stands:

- The patch series currently uses #define for the new MIDX_PROGRESS flag.
- The git codebase uses both #defines and enums for flags.
- The debugger always shows the enum value's name if there is a match, if values
  are OR-ed together there a few possibilities (see discussion above and earlier
  in the thread).
- There are concerns regarding misinterpreting constants that are not a set of
  bits (e.g. "PROGRESS * 3").

Are there any other details I can provide that would help in reaching a
conclusion as to how to proceed?

At this time there are no other MIDX_* flags and so there's always the option
to revisit the best way to handle multiple MIDX_* flags if/when additional
flags are added.

Thanks,
William

