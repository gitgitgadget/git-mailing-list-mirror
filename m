Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E393520A21
	for <e@80x24.org>; Thu, 14 Sep 2017 18:49:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751705AbdINStU (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Sep 2017 14:49:20 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:51925 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751553AbdINStT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Sep 2017 14:49:19 -0400
Received: by mail-pf0-f173.google.com with SMTP id b70so130649pfl.8
        for <git@vger.kernel.org>; Thu, 14 Sep 2017 11:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fmRwkEHLaUxsm68HLbW2sGfkpF5I1pOO2JtwS4zRxCE=;
        b=oVFMHQg+FU+V/gx+vCWvQAGITpWmZ8krNCfmJEQUO/gAam3HXcj988KiXZ5tAbURFT
         C+6ulzruV9eXgi47mOpPS23CFiT2SaCdTxeExiXiLqabFUGU7lLg9TIYqBninmUYlTmZ
         a3NMCFOFL00IHatSG/JIuNYrxwjwmkzI2CSkJn5FLztkDOx8kunSDFGKfqgK5xqwQn86
         rcS17b1/1RqenluyFh1EuzNw0P7MMa+aXzFVmB5oLz3ALhVIk73mhARwy3QB7rYAXnU/
         DPL9+IKwWnGyBDhTziu2kJsur0Ibd+D3W6PeknL5iZV5USprUEqDu4XIr83FIEHIa5T8
         vU8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fmRwkEHLaUxsm68HLbW2sGfkpF5I1pOO2JtwS4zRxCE=;
        b=ECPOHTKuowsZjdVHE+rlmpQl28rxrXrrIGrYG0wRNf8Be0l4MBY1ioNsdmcxGYGeM7
         ZLoCQf1QHxb+5+5Ca9fTcO/MQ3V9ggSfw3HQGPkPy87yFxWfsmRZoJ/toAuLoRUEJFsj
         XmuVq/yS3BfbXE6KORhNVzNuLEwN4CyqYapzeFIc3aRdIvm94LfIkagqN1O/kly3UJks
         OXyupawvsqRYPHEevbvwktL/mSKuKDqdB9jTsYE/d7zBtTEyVo1RLmNjlb3Jc1LkLO+w
         itSjMjJiNGMnDvwZWJ6wKojzKmpZf9u1Y2eg18tIhFJS7S3M7D/sNrEuza8pM0fxKaLN
         OT4A==
X-Gm-Message-State: AHPjjUiZHGeFUMJO3GIOJNzXR4Vxzhx88wZ+rNZV7OywIxqzX6VofjXj
        S1ftYy4Q/lBszw==
X-Google-Smtp-Source: ADKCNb7uV3vbX1EvStJ9DXmC4ZSYxKUoELknuhloptLhY/LEPWVngEw2zwMpF4qPcO4/DBKlMRbvtQ==
X-Received: by 10.99.183.4 with SMTP id t4mr22149479pgf.128.1505414958309;
        Thu, 14 Sep 2017 11:49:18 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:539:86cc:e014:7a2])
        by smtp.gmail.com with ESMTPSA id n83sm33315006pfi.163.2017.09.14.11.49.17
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 14 Sep 2017 11:49:17 -0700 (PDT)
Date:   Thu, 14 Sep 2017 11:49:15 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>, jonathantanmy@google.com,
        Jeff King <peff@peff.net>, David Lang <david@lang.hm>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: RFC v3: Another proposed hash function transition plan
Message-ID: <20170914184915.GC78683@aiede.mtv.corp.google.com>
References: <20170304011251.GA26789@aiede.mtv.corp.google.com>
 <CA+55aFz+gkAsDZ24zmePQuEs1XPS9BP_s8O7Q4wQ7LV7X5-oDA@mail.gmail.com>
 <20170307001709.GC26789@aiede.mtv.corp.google.com>
 <xmqqa828733s.fsf@gitster.mtv.corp.google.com>
 <xmqq1snh29re.fsf@gitster.mtv.corp.google.com>
 <20170911185913.GA5869@google.com>
 <alpine.DEB.2.21.1.1709131340030.4132@virtualbox>
 <20170913163052.GA27425@aiede.mtv.corp.google.com>
 <alpine.DEB.2.21.1.1709141119140.4132@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1.1709141119140.4132@virtualbox>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin wrote:
> On Wed, 13 Sep 2017, Jonathan Nieder wrote:

>> As a side note, I am probably misreading, but I found this set of
>> paragraphs a bit condescending.  It sounds to me like you are saying
>> "You are making the wrong choice of hash function and everything else
>> you are describing is irrelevant when compared to that monumental
>> mistake.  Please stop working on things I don't consider important".
>> With that reading it is quite demotivating to read.
>
> I am sorry you read it that way. I did not feel condescending when I wrote
> that mail, I felt annoyed by the side track, and anxious. In my mind, the
> transition is too important for side tracking, and I worry that we are not
> fast enough (imagine what would happen if a better attack was discovered
> that is not as easily detected as the one we know about?).

Thanks for clarifying.  That makes sense.

[...]
> As to *my* opinion: after reading https://goo.gl/gh2Mzc (is it really
> correct that its last update has been on March 6th?), my only concern is
> really that it still talks about SHA3-256 when I think that the
> performance benefits of SHA-256 (think: "Git at scale", and also hardware
> support) really make the latter a better choice.
>
> In order to be "ironed out", I think we need to talk about the
> implementation detail "Translation table". This is important. It needs to
> be *fast*.
>
> Speaking of *fast*, I could imagine that it would make sense to store the
> SHA-1 objects on disk, still, instead of converting them on the fly. I am
> not sure whether this is something we need to define in the document,
> though, as it may very well be premature optimization; Maybe mention that
> we could do this if necessary?
>
> Apart from that, I would *love* to see this document as The Official Plan
> that I can Show To The Manager so that I can ask to Allocate Time.

Sounds promising!

Thanks much for this feedback.  This is very helpful for knowing what
v4 of the doc needs.

The discussion of the translation table in [1] didn't make it to the
doc.  You're right that it needs to.

Caching SHA-1 objects (and the pros and cons involved) makes sense to
mention in an "ideas for future work" section.

An implementation plan with well-defined pieces for people to take on
and estimates of how much work each involves may be useful for Showing
To The Manager.  So I'll include a sketch of that for reviewers to
poke holes in, too.

Another thing the doc doesn't currently describe is how Git protocol
would work.  That's worth sketching in a "future work" section as
well.

Sorry it has been taking so long to get this out.  I think we should
have something ready to send on Monday.

Thanks,
Jonathan

[1] https://public-inbox.org/git/CAJo=hJtoX9=AyLHHpUJS7fueV9ciZ_MNpnEPHUz8Whui6g9F0A@mail.gmail.com/
