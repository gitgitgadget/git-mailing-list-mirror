Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84EF11F4F8
	for <e@80x24.org>; Thu, 20 Oct 2016 18:14:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932222AbcJTSOT (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Oct 2016 14:14:19 -0400
Received: from mail-yb0-f177.google.com ([209.85.213.177]:35275 "EHLO
        mail-yb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752894AbcJTSOS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2016 14:14:18 -0400
Received: by mail-yb0-f177.google.com with SMTP id 184so31157400yby.2
        for <git@vger.kernel.org>; Thu, 20 Oct 2016 11:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=FGDnwZR2kRgk1XrUj6WfbQ3yqZkRh5iLjKWEhDHDrh0=;
        b=Xau4ZAd+R9JddiEZBUUJeq8kQXkRohGe9EuLKeofdcmI4VqslaPhUBEK0cEB44dOxa
         GJPxs/RYf1eDBWsvQugqP8Y4iKviEUjgzgdE24kGlVGtnsZZqnQi9xNnJv2MG9ubXmrg
         uF7l6L5TM5fYaOJPJrYn8GUF40QoZm1RFdrnhUw+wIw/z2ypQSDp9ReluKYTR1E2tPVx
         niuJ2lmV2UvVzoAvT85jyJlBWuH7ga2x09y/DM1hjCV3X+RicrTw0543Ae/VEa2a07X7
         FVJcRN5Ei6FDu7Egc7bSl0/+VIDdjXmwbkx3Z7dBEsM2S+uDhwCzW/8+4l2aDIA4r8Gt
         HYZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=FGDnwZR2kRgk1XrUj6WfbQ3yqZkRh5iLjKWEhDHDrh0=;
        b=EhpqQxRaHP7nraT9gbantMf4ZKJEZS5S1jRb3uf42fuLzRR0Y3txtfw1Mfut9Cyzgs
         i6yG4alDE3oNhZoEV+BCY6S1umCP+AroP4OnZEpbznKG4GAqfCw1udMxRXw96kxXu5M5
         lOfAtGFNWj6SrjD+rUbASfRPvHtzO+FhTdG6HVWuJAOynRStKi+OQI78doiChRwX+kmB
         pd9mwXiMVf6N2PGJ0ofbc91n43/EI5/s3SzfIh/M9/aHqyU5aDhxbH1Jd1EPqY12gSyN
         EPr4iDDju6gZdTI578z+LRtcwoZdBSb83xlYzq9W1h6FoGIgUDhsZUmMZeWtMKtzs8kP
         oo+Q==
X-Gm-Message-State: AA6/9RkXcrTh06/NT3hlFBIirsNkNohYLuTvSXPv7t/uKUiWZYUWTzQMjqgZmemyUciEJ9YsJuwCj81JoxxNXA==
X-Received: by 10.37.61.198 with SMTP id k189mr3380806yba.57.1476987257968;
 Thu, 20 Oct 2016 11:14:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.10.2 with HTTP; Thu, 20 Oct 2016 11:13:57 -0700 (PDT)
In-Reply-To: <xmqqwph2hqdg.fsf@gitster.mtv.corp.google.com>
References: <CA+P7+xqFOn4NSfZ2zpa_y1za3uHZrGGG3ktEtuOcvJLCrAYUhQ@mail.gmail.com>
 <20161019224211.k4anavgqrhmunz6p@sigill.intra.peff.net> <CA+P7+xprKV1Y7VShLR9uNgcpVdZk39xoTfkwiin1bVQYTe_TAA@mail.gmail.com>
 <20161020021323.tav5glu7xy4u7mtj@sigill.intra.peff.net> <xmqqa8dzhtki.fsf@gitster.mtv.corp.google.com>
 <CA+P7+xq25LcdmtzmBNChiGhGratcdp7m0EOsQuEh68=gJQ9HNQ@mail.gmail.com> <xmqqwph2hqdg.fsf@gitster.mtv.corp.google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 20 Oct 2016 11:13:57 -0700
Message-ID: <CA+P7+xqbqfCTOHJZJ9ZGXv3oeSvKUdJByc8mdzoAoXRd7UZ6HA@mail.gmail.com>
Subject: Re: tools for easily "uncommitting" parts of a patch I just commited?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 20, 2016 at 10:39 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Jacob Keller <jacob.keller@gmail.com> writes:
>
>> I still think we're misunderstanding. I want git commit to complain
>> *only* under the following circumstance:
>>
>> I run "git add -p" and put a partial change into the index in <file>.
>> There are still other parts which were not added to the index yet.
>> Thus, the index version of the file and the actual file differ.
>>
>> Then, I (accidentally) run "git commit <file>"
>
> I agree that this case is different.
>
> Again, users are different, and I also often do
>
>     $ edit file; think; decide it is a good enough first cut
>     $ git add file
>     $ edit file; think; decide it is getting better
>     $ git add file
>     $ edit file; think; decide it is now perfect
>     $ git commit file
>
> Because I do not think you can differentiate the above workflow from
> the case where "git add -p" was used earlier, I think your updated
> "git commit" needs to complain at this point.
>
> I am not sure if that is OK.  I think it is less not-OK than the use
> case I mentioned in my earlier message, in that this is not a case
> that "please don't do it" breaks.  It however is an inconvenience
> that the user has to say "git add file" before the "git commit" (or
> "git commit file") to conclude the sequence.
>
> So I dunno.

Hmmm.. Ya ok I don't think we can actually distinguish between these
two work flows.

Given that I now know how to fix my mistake easily (git reset -p) I
think I will just go ahead and not bother with this as it's much less
of a pain now.

Thanks,
Jake
