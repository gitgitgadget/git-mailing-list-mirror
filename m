Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61DA820899
	for <e@80x24.org>; Wed,  2 Aug 2017 15:17:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752645AbdHBPRw (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Aug 2017 11:17:52 -0400
Received: from mail-ua0-f182.google.com ([209.85.217.182]:38103 "EHLO
        mail-ua0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752617AbdHBPRv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Aug 2017 11:17:51 -0400
Received: by mail-ua0-f182.google.com with SMTP id w45so22025678uac.5
        for <git@vger.kernel.org>; Wed, 02 Aug 2017 08:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=19aH8vcOv9ETNZ5I6XRmiv+qbDRp4MQho34GSvNBif4=;
        b=U76jlyvXfRKSm75k0NQ1129+nHy/Fc4SjCCQNl0mCiresUcOuY8PrkkTQ+arrd5c1g
         B4KvhtNGbkcSK0FqTO1fBLAbu1hlEAgBxkkaZfG5OxpAgGlAkYBPCudhNzakaz9Uk4YL
         cRkVq3cXX25jQ7hR3r/EnK/UNvRn41wgWxdpQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=19aH8vcOv9ETNZ5I6XRmiv+qbDRp4MQho34GSvNBif4=;
        b=bog2g29Ma0iZubVc4eK5VI/3jwlKQ91rk+xLrOGEYtoAT5dmeA9CimtNgj1QtHZffz
         hFk+cPVwOXkLgh+AGBh4TR9hnfbGxLzVAmvd1ovJuc3cG++COKNNWfEfbMCWPVRBHJ9P
         qyu6rX5+jheZaGKDRcraNvw8IUPXbm/3xwJ9z50uaYrckw5RN1PTSJsdVh2JrDo37pTl
         KhDe/qnvWZJXgzI+yOn7uulKWQQhz9wSJDnT5Kl1W2l65dihUpEn9mVuvxomGa3My+03
         2hdUL9v4OvrZvOOYzkW5IEw6Tt7vLinR2Fo6etrs6AcISrSSAdDcc0GW9V373rL4u9ip
         eF1g==
X-Gm-Message-State: AIVw112JSmFdYxRg3DYijl6sdHAk9YgZ1hvTN02VLzqOCbCo/A+aLb28
        UUl52l1cUmdst83IuqdFWxVWWH7oJ6HAqoM=
X-Received: by 10.176.82.68 with SMTP id j4mr13714777uaa.72.1501687070244;
 Wed, 02 Aug 2017 08:17:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.83.7 with HTTP; Wed, 2 Aug 2017 08:17:29 -0700 (PDT)
In-Reply-To: <20170802092846.u4lyiogvvl7ezdfq@sigill.intra.peff.net>
References: <CAJo=hJv7scc1L0_MdRkFeLAJGjYm2UkTFNOgj2e4+9Zj7KSiiQ@mail.gmail.com>
 <CAMy9T_HCnyc1g8XWOOWhe7nN0aEFyyBskV2aOMb_fe+wGvEJ7A@mail.gmail.com>
 <CAJo=hJvFRJ7honjenB6sUofK14xiUXGwJ1DQHZyTauVKA5v5vw@mail.gmail.com>
 <CAMy9T_HUoD4--s1gNTUjnCgdiAqfYbX-GSqygDwNO-JRwdh4NQ@mail.gmail.com>
 <CAJo=hJv=zJvbzfAZwspxECXrnBJR4XfJbGZegsNUCx=6uheO2Q@mail.gmail.com> <20170802092846.u4lyiogvvl7ezdfq@sigill.intra.peff.net>
From:   Shawn Pearce <spearce@spearce.org>
Date:   Wed, 2 Aug 2017 08:17:29 -0700
Message-ID: <CAJo=hJu1rud5pEZ93HDty1qyaCOHmwn89aEvPFe2ER0JD1ExwQ@mail.gmail.com>
Subject: Re: reftable [v4]: new ref storage format
To:     Jeff King <peff@peff.net>
Cc:     Michael Haggerty <mhagger@alum.mit.edu>, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        David Borowitz <dborowitz@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 2, 2017 at 2:28 AM, Jeff King <peff@peff.net> wrote:
> On Tue, Aug 01, 2017 at 07:38:37PM -0700, Shawn Pearce wrote:
>
>> > OBJS blocks can also be
>> > unbounded in size if very many references point at the same object,
>> > thought that is perhaps only a theoretical problem.
>>
>> Gah, I missed that in reftable. The block id pointer list could cause
>> a single object id to exceed what fits in a block, and that will cause
>> the writer to fail unless its caller sets the block size larger. I
>> basically assumed this overflow condition is very unlikely, as its not
>> common to have a huge number of refs pointing to the same object.
>
> It's actually quite common for us, as we have big shared-object repos
> that contain a copy of the refs of all of their child repos (for
> reachability during packing, etc). So tags, where the value is the same
> in each fork, you have one ref per fork pointing to it.
>
> Just peeking at torvalds/linux, we have some objects with ~35K refs
> pointing to them (e.g., the v2.6.11 tag).

Oy. I'll bet that every occurrence winds up in its own block due to
the layout of the namespace, and so the obj block list needs 35k
varint pointers. That requires a larger block size if it has any
chance of fitting into the reftable format.

Another option is disable the obj table for these shared-object repos.
Its an optional part of the format and can be omitted if the reader
isn't likely to need to lookup by SHA-1, or is willing to pay the
brute force cost of scanning every ref.
