Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26E1B20286
	for <e@80x24.org>; Wed, 13 Sep 2017 22:07:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751317AbdIMWHM (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Sep 2017 18:07:12 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:43669 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751128AbdIMWHL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Sep 2017 18:07:11 -0400
Received: by mail-wm0-f49.google.com with SMTP id a137so1214836wma.0
        for <git@vger.kernel.org>; Wed, 13 Sep 2017 15:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=UOp6F3pMPRBV6EFKQqiwjb39dlrhDNeQ8Kpftzs5mnQ=;
        b=X0Ko+B1qk1KFlfNIn8tLPlbrDhT8uS/9ryz+3v4N8+VzBGxv5vjXGNy9q8U79H5LD+
         AXunVGoCVs+jwy64d735XhFgMP2tXtfQbBwKad0w5IYShx3blrzpe/tBSFZ+qtjpOtpb
         071s82kBdcAvw8z2ilSFuLEKfOydQ8ark/FSpAtXYDW6AcnZo1ffgsKhmOWl+vT177RP
         Ld/WvLPfHXp8ZnwB84ImGPqs4DaV1JSX/WkYCk5jPsqYN9ivWYPbTBI7gYCiE4LtYApS
         uahcV+LU7SQEONt5dA/ogPOjuLORQsvUuEsnMjYZmMa7EwRjKiF0dE9COe+QKigIhjup
         GAEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=UOp6F3pMPRBV6EFKQqiwjb39dlrhDNeQ8Kpftzs5mnQ=;
        b=BhVBcosZx/BTPQc6YWLaktrcuH/pCO2vQcU3RefExZ64mEkprvdeiFRRrxl06+gsrI
         BHsLpX+ARUs338O3yR4bLCc6+Lf9M6ZumBFzrvVPkQ3CYw4QbaX5vLtA1fuF+kpg347y
         Xzxy4qlYjJWU5HI1o/yXg3drnIKTu1SWw1RGMPAMIymwETS+CCiyMAAmjSo25ww5HvYA
         kRnazp8BMwNK9cZnvod3Gw9nzuYkMKAXzXCVZxF7v7A7cc8lpE+00CcmPSFirJ1D+5yP
         vrAKHppOpJ9Rt60S18PfNjeBZw69JXArKCIJuwKKHaMmrW312B38uwtHOII4aqCtCeex
         RFyg==
X-Gm-Message-State: AHPjjUgSEykQEpOlrnEamTTG4LcxE/r7iOkv5PdujDz2H4amCI9tY/iK
        UCkIwNzaNlvUusuGNIe/BTjP8iV5yTPo3BhDzm8Xeg==
X-Google-Smtp-Source: AOwi7QBiaKI9HvBQUNsrh5DUSAS5lCNHgGN3Zd2OPsgza2P7YOyLTl1XYi1cLhRFPlrCfFjje58ZrvBHbcwK6vGyD6M=
X-Received: by 10.28.73.133 with SMTP id w127mr102066wma.55.1505340429274;
 Wed, 13 Sep 2017 15:07:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.223.170.68 with HTTP; Wed, 13 Sep 2017 15:07:08 -0700 (PDT)
In-Reply-To: <xmqq7ex21d2v.fsf@gitster.mtv.corp.google.com>
References: <20170304011251.GA26789@aiede.mtv.corp.google.com>
 <CA+55aFz+gkAsDZ24zmePQuEs1XPS9BP_s8O7Q4wQ7LV7X5-oDA@mail.gmail.com>
 <20170307001709.GC26789@aiede.mtv.corp.google.com> <xmqqa828733s.fsf@gitster.mtv.corp.google.com>
 <xmqq1snh29re.fsf@gitster.mtv.corp.google.com> <20170911185913.GA5869@google.com>
 <alpine.DEB.2.21.1.1709131340030.4132@virtualbox> <20170913163052.GA27425@aiede.mtv.corp.google.com>
 <xmqq7ex21d2v.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 13 Sep 2017 15:07:08 -0700
Message-ID: <CAGZ79kakGcMJ7HuH+MPsMrvw40uGchr6H-SQw9-p8pgi3Yk_Bw@mail.gmail.com>
Subject: Re: RFC v3: Another proposed hash function transition plan
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Brandon Williams <bmwill@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>, David Lang <david@lang.hm>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 13, 2017 at 2:52 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>> Treating generation numbers as derived data (as in Jeff King's
>> preferred design, if I have understood his replies correctly) would
>> also be possible but it does not interact well with shallow clone or
>> narrow clone.
>
> Just like we have skewed committer timestamps, there is no reason to
> believe that generation numbers embedded in objects are trustable,
> and there is no way for narrow clients to even verify their correctness.
>
> So I agree with Peff that having generation numbers in object is
> pointless; I agree any other derivables like corresponding sha-1
> name is also pointless to have.
>
> This is a tangent, but it may be fine for a shallow clone to treat
> the cut-off points in the history as if they are root commits and
> compute generation numbers locally, just like everybody else does.
> As generation numbers won't have to be global (because we will not
> be embedding them in objects), nobody gets hurt if they do not match
> across repositories---just like often-mentioned rename detection
> cache, it can be kept as a mere local performance aid and does not
> have to participate in the object model.

Locally it helps for some operations such as correct walks.
For the network case however, it doesn't really help either.

If we had global generation numbers, one could imagine that they
are used in the pack negotiation (server advertises the maximum
generation number or even gen number per branch; client
could binary search in there for the fork point)

I wonder if locally generated generation numbers (for the shallow
case) could be used somehow to still improve network operations.



>> My assumption based on previous conversations (and other external
>> conversations like [1]) is that we are going to use SHA2-256 and have
>> a pretty strong consensus for that.  Don't worry!
>
> Hmph, I actually re-read the thread recently, and my impression was
> that we didn't quite have a consensus but were leaning towards
> SHA3-256.
>
> I do not personally have a strong preference myself and I would say
> that anything will do as long as it is with good longevity and
> availability.  SHA2 family would be a fine choice due to its age on
> both counts, being scrutinized longer and having a chance to be
> implemented in many places, even though its age itself may have to
> be subtracted from the longevity factor.

If we'd get the transition somewhat right, the next transition will
be easier than the current transition, such that I am not that concerned
about longevity. I am rather concerned about the complexity that is added
to the code base (whilst accumulating technical debt instead of clearer
abstraction layers)
