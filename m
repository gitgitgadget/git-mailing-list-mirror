Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D06620286
	for <e@80x24.org>; Wed, 13 Sep 2017 22:19:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751330AbdIMWS7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Sep 2017 18:18:59 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:46382 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751128AbdIMWS6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Sep 2017 18:18:58 -0400
Received: by mail-pg0-f44.google.com with SMTP id i130so2909974pgc.3
        for <git@vger.kernel.org>; Wed, 13 Sep 2017 15:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pQnns/zHlrmjxwweljUOufd5cxaWwVqowaJic+oQGew=;
        b=IM5STIKB0+7ssNlgnRleQGrenb9OCyWvrNJAmyOXtxwqPEAzpbw8wkj4Gj1Fz3m7XB
         zhVU+Fx8FUpdZSYmKbikCPlUwMk96cl0jK9/dhexqfaBSNftOrr4bcAn6FjWSs341tKD
         9QcA+IjcKF3YMM5bVGQltnzS2MowAW3mtHg8RLDZifJQcxgeH+uFCYQa6oBz0fmC7JUm
         bSX0aBP01K20OWO7AtLcU6fW18IwGz/1HQW7gX7T9cL+UU06TgWBdAdGTRah81GYrej/
         XuLcDUmUCdBR7CVCzJwGCOhTHn9DMhCjlbDh1zSiq/VQTbK7vEhXnRf1xQ1u6RyzfpaK
         FoJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pQnns/zHlrmjxwweljUOufd5cxaWwVqowaJic+oQGew=;
        b=CsO1skDxZjp4WAtcEM5o4M9Je+/af0krbkyGDKmMA35wCKcztcY2EHql3mjcuzKtnz
         o2se8XQDrYiu4Zwhic6dICvrLvFsxe7yG6PRaiqyuzlBXxIzYIL1yR/G/MqR1gxVnPBQ
         0VGnatY6fr3Gb2E+FjKlxTJnn1UDIo8m00AGlgsbjukihAjBHYUaZjXCKcciRvpKTbOn
         r48u2O8yNNq3NZ2jg7zT7idOKUzvBLhTDSSk0xwIeEOQZHxAYUglPA404JvhP9WAE+lm
         g+dudHy0nYEEb9vkCGD232czlTOxdWcVLBqhG+SFCsi4lihFQDlACdsnjIm0fFmCRm2l
         MNTA==
X-Gm-Message-State: AHPjjUiFJkl7iHbUHusu1z7RONWip8VjRv7++Cx+5+Vc5YpBQ4nQa3wI
        +pwq1PKBMMgIVA==
X-Google-Smtp-Source: ADKCNb6rHnfAQ4wwuYR3Zq8H4IP5pkD4t2ds2Vi6ZapJp7aXvXotPS0OKjQ+QrgCSP6aW/NcIO7MVA==
X-Received: by 10.99.120.8 with SMTP id t8mr13426992pgc.122.1505341137464;
        Wed, 13 Sep 2017 15:18:57 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:d132:98b:3ff1:a635])
        by smtp.gmail.com with ESMTPSA id 70sm27229312pfh.63.2017.09.13.15.18.56
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 13 Sep 2017 15:18:56 -0700 (PDT)
Date:   Wed, 13 Sep 2017 15:18:54 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Brandon Williams <bmwill@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>, David Lang <david@lang.hm>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: RFC v3: Another proposed hash function transition plan
Message-ID: <20170913221854.GP27425@aiede.mtv.corp.google.com>
References: <20170304011251.GA26789@aiede.mtv.corp.google.com>
 <CA+55aFz+gkAsDZ24zmePQuEs1XPS9BP_s8O7Q4wQ7LV7X5-oDA@mail.gmail.com>
 <20170307001709.GC26789@aiede.mtv.corp.google.com>
 <xmqqa828733s.fsf@gitster.mtv.corp.google.com>
 <xmqq1snh29re.fsf@gitster.mtv.corp.google.com>
 <20170911185913.GA5869@google.com>
 <alpine.DEB.2.21.1.1709131340030.4132@virtualbox>
 <20170913163052.GA27425@aiede.mtv.corp.google.com>
 <xmqq7ex21d2v.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kakGcMJ7HuH+MPsMrvw40uGchr6H-SQw9-p8pgi3Yk_Bw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kakGcMJ7HuH+MPsMrvw40uGchr6H-SQw9-p8pgi3Yk_Bw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Stefan Beller wrote:
> On Wed, Sep 13, 2017 at 2:52 PM, Junio C Hamano <gitster@pobox.com> wrote:

>> This is a tangent, but it may be fine for a shallow clone to treat
>> the cut-off points in the history as if they are root commits and
>> compute generation numbers locally, just like everybody else does.
[...]
> Locally it helps for some operations such as correct walks.
> For the network case however, it doesn't really help either.
>
> If we had global generation numbers, one could imagine that they
> are used in the pack negotiation (server advertises the maximum
> generation number or even gen number per branch; client
> could binary search in there for the fork point)
>
> I wonder if locally generated generation numbers (for the shallow
> case) could be used somehow to still improve network operations.

I have a different concern about locally generated generation numbers in
a shallow clone.  My concern is that it is slow to recompute them when
deepening the shallow clone.

However:

 1. That only affects performance and for some use cases could be
    mitigated e.g. by introducing some laziness, and, more
    convincingly,

 2. With a small protocol change, the server could communicate the
    generation numbers for commit objects at the edge of a shallow
    clone, avoiding this trouble.

So I am not too concerned.

More generally, unless there is a very very compelling reason to, I
don't want to couple other changes into the hash function transition.
If they're worthwhile enough to do, they're worthwhile enough to do
whether we're transitioning to a new hash function or not: I have not
heard a convincing example yet of a "while at it" that is worth the
complexity of such coupling.

(That said, if two format changes are worth doing and happen to be
implemented at the same time, then we can save users the trouble of
experiencing two format change transitions.  That is a kind of
coupling from the end user's point of view.  But from the perspective
of someone writing the code, there is no need to count on that, and it
is not likely to happen anyway.)

> If we'd get the transition somewhat right, the next transition will
> be easier than the current transition, such that I am not that concerned
> about longevity. I am rather concerned about the complexity that is added
> to the code base (whilst accumulating technical debt instead of clearer
> abstraction layers)

During the transition, users have to suffer reencoding overhead, so it
is not good for such transitions to need to happen very often.  If the
new hash function breaks early, then we have to cope with it and as
you say, having the framework in place means we'd be ready for that.
But I still don't want the chosen hash function to break early.

In other words, a long lifetime for the hash absolutely is a design
goal.  Coping well with an unexpectedly short lifetime for the hash is
also a design goal.

If the hash function lasts 10 years then I am happy.

Thanks,
Jonathan
