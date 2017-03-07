Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 461EC1FBEC
	for <e@80x24.org>; Tue,  7 Mar 2017 18:48:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756014AbdCGSsc (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Mar 2017 13:48:32 -0500
Received: from mail-pf0-f169.google.com ([209.85.192.169]:35290 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755947AbdCGSs3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Mar 2017 13:48:29 -0500
Received: by mail-pf0-f169.google.com with SMTP id j5so3873675pfb.2
        for <git@vger.kernel.org>; Tue, 07 Mar 2017 10:48:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=yrZ+WTEvOCD+sQm3uo9RZhRRzSahQwkgPnklOd9cD7Q=;
        b=FLIy0TbazbIjZ4U9VNjNrQEHJ4e7yMSm6zF+MWmsDtOO6gJqGePazTDAejwRWUMDUf
         lTJzk/IK3/ZFTw93/ScOXF5dtvdgnfN39W/fl19tinhNxb4Nnw1HMAIxUpxiJkBar1n3
         x30JnIYRyZlNnuETZaKTzSbC2wucbnHfAOzDEne048Gv4FUEp1HlQoPYdcKX7QWYyiDR
         ZbBQXuC3q1on1H1f1nHF2MLhXmy9xARELT1X8gSxDCAzTO3sV7lshruKvrLA8hsvbsVw
         +tJAVCS0hh9osa3qTl9MY3NWlBBh6QzpxoAXOxG77/VyNH5mapwYcZxesNx/Dx02MqhU
         8haQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=yrZ+WTEvOCD+sQm3uo9RZhRRzSahQwkgPnklOd9cD7Q=;
        b=OJZBQ/UjbsPSz4YbX7CrFaFCGC3Kavqp88L7u9PVpwCu07MGZvz5KsB4D2qksV2oXR
         MflEWrdcdf41Af+T/LAGJuJB2bXm1M2DbkXeDxcd+cvqJ8hFddSXWDIFYoL/bmTMy1e/
         fx2A1JSf0n2sPcdUnYa1qG+5HlMmlkHQ5HQeqv5lKJ3f3jwObeQf7eHs52GHb+T96Q4a
         0N9S4QC9O3fyQ6O7FsL+Y0WKhyLhoMba8NyKgLN1GIZNULSI/sBU+EmJiDN73sA5k1DC
         o1jw18aHyetFj664vaC1i+BEMGJ6LD5xe8EKMtC83DMRRFnpbpUs9e/AJ/JkJXuH7Mv6
         hI6A==
X-Gm-Message-State: AMke39ktfbrrqpOmCeXjeJp54wqLQDg+HTFDVBt8A78EauL0cUhqED/s1+KEQ274RAaOU76Ng28JNHiiY3irJxcQ
X-Received: by 10.98.149.80 with SMTP id p77mr1983739pfd.56.1488911969314;
 Tue, 07 Mar 2017 10:39:29 -0800 (PST)
MIME-Version: 1.0
Received: by 10.100.187.5 with HTTP; Tue, 7 Mar 2017 10:39:28 -0800 (PST)
In-Reply-To: <20170307084717.i2jru77v3rhd443e@sigill.intra.peff.net>
References: <20170223122346.12222-1-pclouds@gmail.com> <20170223122346.12222-2-pclouds@gmail.com>
 <CAGZ79kboaKfzMEyDjg-m2oK8CX6B56i52ZcWhCaq87ECE9x2Dw@mail.gmail.com> <20170307084717.i2jru77v3rhd443e@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 7 Mar 2017 10:39:28 -0800
Message-ID: <CAGZ79kbMP5n3Pteq1OtOzK69dZkv1QmpiFm8jhYV7+LKVHvi3A@mail.gmail.com>
Subject: Re: [PATCH v5 1/1] config: add conditional include
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Sebastian Schuberth <sschuberth@gmail.com>,
        Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 7, 2017 at 12:47 AM, Jeff King <peff@peff.net> wrote:
> On Mon, Mar 06, 2017 at 02:44:27PM -0800, Stefan Beller wrote:
>
>> > +static int include_condition_is_true(const char *cond, size_t cond_len)
>> > +{
>> ...
>> > +
>> > +       error(_("unrecognized include condition: %.*s"), (int)cond_len, cond);
>> > +       /* unknown conditionals are always false */
>> > +       return 0;
>> > +}
>>
>> Thanks for putting an error message here. I was looking at what
>> is currently queued as origin/nd/conditional-config-include,
>> which doesn't have this error()  (yet / not any more?)
>
> It's "not any more". It was in the original and I asked for it to be
> removed during the last review.

Okay. The joys of contradicting opinions on a mailing list. :)

>
>> I'd strongly suggest to keep the error message here as that way
>> a user can diagnose e.g. a typo in the condition easily.
>>
>> If we plan to extend this list of conditions in the future, and a user
>> switches between versions of git, then they may see this message
>> on a regular basis (whenever they use the 'old' version).
>
> That would make it unlike the rest of the config-include mechanism
> (which quietly ignores things it doesn't understand, like include.foo,
> or include.foo.path), as well as the config code in general (which
> ignores misspelt keys).
>
> Some of that "quiet when you don't understand it" is historical
> necessity. Older versions _can't_ complain about not knowing
> include.path, because they don't yet know it's worth complaining about.

agreed

> Likewise here, if this ships in v2.13 and a new condition "foo:" ships
> in v2.14, you get:
>
>   v2.12 - no complaint; we don't even understand includeIf at all
>   v2.13 - complain; we know includeIf, but not "foo:"
>   v2.14 - works as expected
>
> Which is kind of weird and inconsistent. But maybe the typo-detection
> case is more important to get right than consistency across historical
> versions.

Oh, I see. I was contemplating a future in which 2.12 is not used anymore.

When looking at other examples, such as url.<...>.insteadOf we also do not
warn about typos (well we can't actually).

In diff.<driver>.(command/binary/..) we know the limited set of drivers,
which is similar to the situation we have here.

Maybe a compromise between typo checking (edit distance < 2 -> warn;
silent for larger distances) and the consistency over time is desired.
But this is even more code to write.

So for now I retract my strong opinion and be happy with what is
presented as-is for the reasons Peff gave.

Thanks,
Stefan
