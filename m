Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A5331F453
	for <e@80x24.org>; Wed, 26 Sep 2018 01:18:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbeIZH26 (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Sep 2018 03:28:58 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40089 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726456AbeIZH26 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Sep 2018 03:28:58 -0400
Received: by mail-pg1-f195.google.com with SMTP id n31-v6so5962450pgm.7
        for <git@vger.kernel.org>; Tue, 25 Sep 2018 18:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8pPXKozZOxLsnUjBI1DiJWKwNgDZcRwQdGoPo126TBc=;
        b=0n0WS5fSmyZ8iVLf2Y1pmEHPvVp+cA+CcI/+82Apc1A9gE/x2iP4r9ggv0Q7tw7OpM
         sTqrhChU0C8CESwm445kYPjCoNJxy5YrEYztQO1/n9SyMBXWeJFl4Kto2HWrQD7L+6uw
         N3l+MZcH2JnJroTti2OsyTAJYgMpA9FitnXt4OOyDJFbIesRMzDgoZHajpZSk3ds8qoU
         lwEMIOLhHgJZAreNmKusapa273EIRepHkNqNnuf2x1cA3T+WCr8c6HdJsdK7QOR9rTGq
         MkCxMgbrz31B9BkLglZlzlqIHYTqGMf0bcgLWony0RNa1y79kuyNgSFUIS4lyyIopYgF
         FgGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8pPXKozZOxLsnUjBI1DiJWKwNgDZcRwQdGoPo126TBc=;
        b=P8vRa/w5YnTlgeEvzYKeMyncxdfIHQEQR4ARKBQZw+DeV9NAYvDGplwy+fIYsRT/or
         tBfaqI8f8+s/M4Uk9cdsabfcTsXvLwN0LAHehGn6SzWwQjxoS+M+AmcSW5kmIIlim/tZ
         PnLu1IvewNA0M7x0quk1t8JL5ECObdvEmccfLjoYDJsjuwX5Ts6cUVvtTf6srhI1yWup
         +AyTBIFkxBrKwBWbj60ryhS6f4kubLfGd1AupfHfzYgMfbDYjmOP0obqIaSPPsPwZXZi
         KLeEZkzafplm5+xtuNEDm8lQ/vqPWf6vIfBeJv/GtEHFhQq7gsnkzkf5RSwc28wpgoen
         EhSA==
X-Gm-Message-State: ABuFfogdwFnqcvCsE6DJK9bwPzYrbRSob2rotZnL7N54JAb84Vy0Udoh
        oZ5VhhygHCYl15UJq7Ln4Rtc1w==
X-Google-Smtp-Source: ACcGV60lhUVOQLLAAqKV0cpCYyHjcG/s3Idjofu2GGel1f5U8tfCHcG78A/6ightoDmbiagwNkTNJQ==
X-Received: by 2002:a62:7788:: with SMTP id s130-v6mr3631563pfc.189.1537924721220;
        Tue, 25 Sep 2018 18:18:41 -0700 (PDT)
Received: from localhost ([2601:602:9200:32b0:d190:33d6:11d2:d23b])
        by smtp.gmail.com with ESMTPSA id h20-v6sm4403684pgg.3.2018.09.25.18.18.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 18:18:39 -0700 (PDT)
Date:   Tue, 25 Sep 2018 18:18:38 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        git@vger.kernel.org, sunshine@sunshineco.com, sbeller@google.com
Subject: Re: [PATCH v2 3/3] transport.c: introduce core.alternateRefsPrefixes
Message-ID: <20180926011838.GL4364@syl>
References: <20180921221832.GC11177@sigill.intra.peff.net>
 <xmqqftxzsz5x.fsf@gitster-ct.c.googlers.com>
 <20180924181011.GA24781@sigill.intra.peff.net>
 <xmqqa7o6skkl.fsf@gitster-ct.c.googlers.com>
 <20180924205022.GA26936@sigill.intra.peff.net>
 <xmqqva6ur24y.fsf@gitster-ct.c.googlers.com>
 <20180924231455.GA7702@sigill.intra.peff.net>
 <xmqq1s9hqxtt.fsf@gitster-ct.c.googlers.com>
 <20180925224645.GG4364@syl>
 <xmqq4lednnc4.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq4lednnc4.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 25, 2018 at 04:56:11PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > My reading of this is threefold:
> >
> >   1. There are some cosmetic changes that need to occur in t5410 and
> >      documentation, which are mentioned above. Those seem self
> >      explanatory, and I've applied the necessary bits already on my
> >      local version of this topic.
> >
> >   2. The core.alternateRefsCommand vs transport.* discussion was
> >      resolved in [1] as "let's use core.alternateRefsCommand and
> >      core.alternateRefsPrefixes" for now, and others contributors can
> >      change this as is needed.
> >
> >   3. We can apply Peff's patch to remove the refname requirement before
> >      mine, as well as any relevant changes in my series as have been
> >      affected by Peff's patch (e.g., documentation mentioning
> >      '%(refname)', etc).
>
> I do think it makes sense to allow alternateRefsCommand to output
> just the object names without adding any refnames, and to keep the
> parser simple, we should not even make the refname optional
> (i.e. "allow" above becomes "require"), and make the default one
> done via an invocation of for-each-ref also do the same.
>
> I do not think there was a strong concensus that we need to change
> the internal C API signature, though.  If the function signature for
> the callback between each_ref_fn and alternate_ref_fn were the same,
> I would have opposed to the change, but because they are already
> different, I do not think it is necessary to keep the dummy refname
> parameter that is always passed a meaningless value.
>
> The final series would be
>
>  1/4: peff's "refnames in alternates do nto matter"
>
>  2/4: your "hardcoded for-each-ref becomes just a default"
>
>  3/4: your "config can affect what command enumerates alternate's tips"
>
>  4/4: your "with prefix config, you don't need a fully custom command"
>
> I guess?

Perfect -- we are in agreement on how the rerolled series should be
organized. I don't anticipate much further comment on v2 in this thread,
but I'll let it sit overnight to make sure that the dust has all settled
after my new mail.

I have a version of what will likely become 'v3', pushed here: [1].

Thanks,
Taylor

[1]: https://github.com/ttaylorr/git/tree/tb/alternate-refs-cmd
