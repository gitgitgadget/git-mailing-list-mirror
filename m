Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 259871F97E
	for <e@80x24.org>; Wed, 28 Nov 2018 04:31:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbeK1PcL (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Nov 2018 10:32:11 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39504 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbeK1PcL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Nov 2018 10:32:11 -0500
Received: by mail-pl1-f193.google.com with SMTP id 101so10449258pld.6
        for <git@vger.kernel.org>; Tue, 27 Nov 2018 20:31:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=x+rll4qk+ybw8+BWhYveiin9jlj+AW1+GsJAmzn4tXI=;
        b=ISSH8MmBc7W1/gFMwcqLh4RhPh/dO9Ajw5VknrHDanvCkZ99Bk2UTYc27SFyzcJKCD
         92qmTUooNSCgoaTtY0Joz+T0U6F17upK88Fc49nd3w3xiLKk9JjoUafxDwWe9lmnk2Yy
         o+ktO+48XNvQby1/5j19iPlRCklG7bpRuKk8znOC7AmADv5Svoe/RObq3kejYFxzoxa2
         eIVR//IRDvVmo/q+G2dtZtuaSGLt46UNLeFV3kqGY5mcTHkfY1BcP5mJWG9CahWtPQTb
         jvaTVnCoYIoRee7EQdzwYfOAU40Uz9xrF8kqBmUfu7ykivuH2I4ma1HygxpuphG5qh9q
         mI5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=x+rll4qk+ybw8+BWhYveiin9jlj+AW1+GsJAmzn4tXI=;
        b=FBGzEv4ZJjNp2B0QOMu2+xwgwVJ5Hhmu58kK3q/39dW38V9/ToTGYDuwV5fhc6x2oy
         P93WDaGw3axU7PfAewlvj9vrUUmdepMl40ElBr1mVyJapePYIwuFCoE7avxLZapWbrCf
         LjXl4CPNqa94JTEdTchQ0MhIfh/sMbUl1z3ttOEQHApBa4aojZp69hzJqHHLJ4bpjV0n
         mZ3ywPiIFcVWDd3oZXkrtLqqooV+k5kcEAZ9Ctr0suvizLE51zCvETNkZDyahVcJSNoz
         9+U+CEfN5Fo488o3QZWzIA38ZA0s8PvKO9CU5k577Rx2cyqLLC8Hk+vFBVdeuijYYwPa
         6lqA==
X-Gm-Message-State: AA+aEWYlYHHM0y+Ol5jEBAoQ3fF5QSPkM/TBz4hfS/bDP/TUOGBdlMfC
        0L0lw2uxY+odALq0oey66LAyAATotYk=
X-Google-Smtp-Source: AFSGD/XjqpWENOMxS9JZgBVpmMDwxqt1s8wmmgvNcLJYsHX4ce6WXMUBxGWVRqe9QAGkMYktb8AuSg==
X-Received: by 2002:a17:902:e290:: with SMTP id cf16mr36044802plb.81.1543379516809;
        Tue, 27 Nov 2018 20:31:56 -0800 (PST)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id 64-v6sm7374411pfa.120.2018.11.27.20.31.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Nov 2018 20:31:55 -0800 (PST)
Date:   Tue, 27 Nov 2018 20:31:54 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ian Jackson <ijackson@chiark.greenend.org.uk>
Subject: Re: [PATCH] rebase: mark the C reimplementation as an experimental
 opt-in feature (was Re: [ANNOUNCE] Git v2.20.0-rc1)
Message-ID: <20181128043154.GA34163@google.com>
References: <xmqqmuq25ufc.fsf@gitster-ct.c.googlers.com>
 <87y39w1wc2.fsf@evledraar.gmail.com>
 <877eh219ih.fsf@evledraar.gmail.com>
 <xmqq36rq2cp0.fsf@gitster-ct.c.googlers.com>
 <xmqq36roz7ve.fsf_-_@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq36roz7ve.fsf_-_@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Junio C Hamano wrote:
>> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

>>> Given that we're still finding regressions bugs in the rebase-in-C
>>> version should we be considering reverting 5541bd5b8f ("rebase: default
>>> to using the builtin rebase", 2018-08-08)?
>>>
>>> I love the feature, but fear that the current list of known regressions
>>> serve as a canary for a larger list which we'd discover if we held off
>>> for another major release (and would re-enable rebase.useBuiltin=true in
>>> master right after 2.20 is out the door).
[...]
> So, in a more concrete form, what you want to see is something like
> this in -rc2 and later?
>
> -- >8 --
> Subject: [PATCH] rebase: mark the C reimplementation as an experimental opt-in feature
>
> It turns out to be a bit too early to unleash the reimplementation
> to the general public.  Let's rewrite some documentation and make it
> an opt-in feature.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/config/rebase.txt | 16 ++++++----------
>  builtin/rebase.c                |  2 +-
>  t/README                        |  4 ++--
>  3 files changed, 9 insertions(+), 13 deletions(-)

I thought I should weigh in on how this would affect Debian's and
Google's deployments.

First of all, I've looked over the revert patch carefully and it is
well written and does what it says on the tin.

At https://bugs.debian.org/914695 is a report of a test regression in
an outside project that is very likely to have been triggered by the
new faster rebase code.  The issue has not been triaged, so I don't
know yet whether it's a problem in rebase-in-c or a manifestation of a
bug in the test.

That said, Google has been running with the new rebase since ~1 month
ago when it became the default, with no issues reported by users.  As
a result, I am confident that it can cope with what most users of
"next" throw at it, which means that if we are to find more issues to
polish it better, it will need all the exposure it can get.

In the Google deployment, we will keep using rebase-in-c even if it
gets disabled by default, in order to help with that.

From the Debian point of view, it's only a matter of time before
rebase-in-c becomes the default: even if it's not the default in 2.20,
it would presumably be so in 2.21 or 2.22.  That means the community's
attention when resolving security and reliability bugs would be on the
rebase-in-c implementation.  As a result, the Debian package will most
likely enable rebase-in-c by default even if upstream disables it, in
order to increase the package's shelf life (i.e. to ease the
maintenance burden of supporting whichever version of the package ends
up in the next Debian stable).

So with either hat on, it doesn't matter whether you apply this patch
upstream.

Having two pretty different deployments end up with the same
conclusion leads me to suspect that it's best for upstream not to
apply the revert patch, unless either

  (a) we have a concrete regression to address and then try again, or
  (b) we have a test or other plan to follow before trying again.

Thanks and hope that helps,
Jonathan
