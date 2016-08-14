Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11C5E1F859
	for <e@80x24.org>; Sun, 14 Aug 2016 09:15:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752607AbcHNJPK (ORCPT <rfc822;e@80x24.org>);
	Sun, 14 Aug 2016 05:15:10 -0400
Received: from mail-yw0-f180.google.com ([209.85.161.180]:35815 "EHLO
	mail-yw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751505AbcHNJPI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Aug 2016 05:15:08 -0400
Received: by mail-yw0-f180.google.com with SMTP id j12so13750597ywb.2
        for <git@vger.kernel.org>; Sun, 14 Aug 2016 02:15:08 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=SXX1xtK/lfaazR47gVhopPT6iFOhmUroQztpBYU/Pbk=;
        b=S4C8G1OmKkQK4aSXMxfANKMYmsIv23GTrMkZ9NVAqrXqe8OQjV/t9mSlBfZRDbi3Ys
         F2Iou0Y7lMeEcE/EnESsrztK9w1YDiUpZ2/K6z35bQVCqNdVd2GG3E5eZbaENLmtsLwb
         Ynqu8LG70QtSQYOMyYSDojHGRkTcV8nYfpz5YCNz+dEbA1vbgz8AjsNMeSHGKiVbRIyK
         2wKm/RSfdSVcesx49F/yFbqK+k9OsmY2nlKFGdH5DnEp5OTPlUboUx12qRSU9qYoZEb/
         ZI4DcgHiVdulGjPrHRUzFAPOgzmDKzQjURNZoRayFj4w/VKsUHCje0bIeBesICJg6sOq
         RteQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=SXX1xtK/lfaazR47gVhopPT6iFOhmUroQztpBYU/Pbk=;
        b=hYsvZzNo/bpAkXRImMIc6HH0qbRJNcLD7vn4ujiBUHqjf197nrxvOaZp5EPjFTE7Ex
         YrQZ7j/BU4/T5qo7gzJkPJFs2MQnxZ3zHMeiML4lhLmLZxIzc1WFunOOFxe/hFXIrhk6
         c2+900WeuFFzmQVH48+jVPhxAgebMGp0GiuRQufJ4oqWEZhOI/xg9sx12YUjDLb6KxjN
         cbCgHkwtsatAhWn6K3if2Tp6h6Y9oyng2lipynPh2WSimQDYf2kejfZai28louVw77Zf
         l7FUMCZZ9NQHFx1w567lTo2GcRApN/vWvr+vv1lYhrqwDJhSC+F/HcJJmHUbcFlrunSD
         cxgQ==
X-Gm-Message-State: AEkoous9u9xh7jPuQluUhLYMa4vcZL1foA0lRqy6DGyv6MyGrG8I28mk7rMFJJxNernqzNgFZm+Z1RW5/CjE5Q==
X-Received: by 10.13.228.196 with SMTP id n187mr17177270ywe.83.1471159320827;
 Sun, 14 Aug 2016 00:22:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.50.196 with HTTP; Sun, 14 Aug 2016 00:21:40 -0700 (PDT)
In-Reply-To: <xmqqoa4wu0bm.fsf@gitster.mtv.corp.google.com>
References: <cover.1470259583.git.mhagger@alum.mit.edu> <7b0680ed7a10fc13acd8d7816a75ed05a5f9e28c.1470259583.git.mhagger@alum.mit.edu>
 <20160804075631.jakbi5dbsbxsqcpr@sigill.intra.peff.net> <e4232cba-aae8-8426-c730-7914bb750363@alum.mit.edu>
 <20160813085904.lykoihh4v2lf4yuj@sigill.intra.peff.net> <xmqqoa4wu0bm.fsf@gitster.mtv.corp.google.com>
From:	Jacob Keller <jacob.keller@gmail.com>
Date:	Sun, 14 Aug 2016 00:21:40 -0700
Message-ID: <CA+P7+xrsz27Hhk12dwDrUEpn0L7R8F5z-XASS2JkoY6sqK7u5A@mail.gmail.com>
Subject: Re: [PATCH 8/8] diff: improve positioning of add/delete blocks in diffs
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
	Git mailing list <git@vger.kernel.org>,
	Stefan Beller <sbeller@google.com>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sat, Aug 13, 2016 at 8:59 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>
>> So assuming everything I just said isn't complete bollocks, I think we
>> can move to a future where nobody uses the compaction heuristic. And
>> there are three ways to deal with that:
>>
>>   1. The knob and feature stay. It might be useful for somebody who
>>      wants to experiment in the future.
>>
>>   2. The knob and feature go away completely. It was an experiment, but
>>      now we have something more useful.
>>
>>   3. The feature goes away, but the knob stays as noop, or maybe as an
>>      alias for the indent heuristic, just because we did ship a version
>>      that accepts "--compaction-heuristic", and maybe somebody somewhere
>>      put it in a script?
>>
>> I think I'd be in favor of (2).
>
> I am all for (2) [*1*]
>

I also am in favor of (2). I understand the reasoning for maintaining
compatibility, but this was a known experimental feature that was
unlikely used by many people. Even if it was, these are the very sorts
of people who should be aware that the experimental feature is going
away. It reduces code complexity if it just goes away, and I believe
the new heuristic is much better (Thank you Michael!!!!!)

As for a knob on the new feature, I think it can become the default
with a way to disable the feature via command line. I'm not really
sure it needs a config option at all.

> This and the previous "take a blank line as a hint" are both
> heuristics.  As long as the resulting code does not tax runtime
> performance visibly and improves the resulting output 99% of the
> time, there is no reason to leave end-users a knob.  "Among 9 hunks
> in this patch that touch hello.c, 7 are made much more readable but
> 2 are worse" cannot even be helped with a command line option.
>

Yea I agree. It might be worth having it disabled via the stable patch
IDs (? I don't know if we guarantee this?) but otherwise I don't see
it being important either way. I would vote for a way to disable it
via command line just because we *are* changing behavior here. But I
don't think it needs to be a config option at all.

>
> [Footnote]
>
> *1* I am also strongly against (3), if only to teach people a
>     lesson ;-).
