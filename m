Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A08A1F4F8
	for <e@80x24.org>; Thu, 20 Oct 2016 20:03:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933536AbcJTUDw (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Oct 2016 16:03:52 -0400
Received: from mail-yw0-f182.google.com ([209.85.161.182]:32848 "EHLO
        mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933446AbcJTUDv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2016 16:03:51 -0400
Received: by mail-yw0-f182.google.com with SMTP id t192so70603231ywf.0
        for <git@vger.kernel.org>; Thu, 20 Oct 2016 13:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Fhzr1fjCOemcmQsJQrTNNuJwhH8mfubxXrLM2aH3ivE=;
        b=Lc54aQcZv/BFJf7WvFfjqjukpQqiNkH+c/MMAcLTwSm4XVgLguEUPtFbHEv+8ezTkc
         qkJkg9LQfK0+GacrljaPRHUG0007VeVYSJqf9e/bY30pfzuk81imvB7yR8BH+UE5VgVj
         2IdSllJVOFeyySdLiWlLdCFLHQKUmc2BlhYWWfxuCwXn4TSlE4fWUhLF3YHYK1fZPwxp
         9essPsUP8G+wk9aSygnleLK9hrb1n1yCCY7mu8F6J7QtI9JZKlNez5LKqlNtTLNONNXk
         sWEoD5ScLu9ytQzi0HCUc+7usV1aXTWmfHconY1aLoxaPWzkCTG/ae0/kBisrmb9fUCA
         LXQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Fhzr1fjCOemcmQsJQrTNNuJwhH8mfubxXrLM2aH3ivE=;
        b=fzcKlwWtuLZYTwgFowaDDI2sLivcq01YuW1cyaDxXoIhkMj9DuU8Gi9isaXfHIXJUM
         oCf8QI/RrZEf1/mOcsAJ1x4LFmbBXSBgH9vjYEVH1+2IWL/xcDiNFGBRu/OIOQ0RvTTH
         Ejejgrl6wwsDWiAka4oP25YjTwB/WSrByIgA58g5Aj770B6gLJcO4vg2eY0RG6XIX3kY
         e0bMmjpgWDY7ekmp2UGLPcivFrO4NRF5VBENFZZwwEQJGdtlGruyQIEUZJ+wDwEULtVj
         nc9VXijfRs/PSKSOs5ZcbhWsSqOcyz3CDaiU6p5rddjUhikKNHpqdSy/fmktKYZ2AS7c
         6Kwg==
X-Gm-Message-State: AA6/9Rm1wQGlo/9xxZqLkAL6hy8SGfUSKd4IO8Z2UZUP3L5JsVI6rVqIpvEx5Te+72CF69O1iP0ZDNYDiuDQsw==
X-Received: by 10.129.130.193 with SMTP id s184mr3360099ywf.276.1476993829512;
 Thu, 20 Oct 2016 13:03:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.10.2 with HTTP; Thu, 20 Oct 2016 13:03:28 -0700 (PDT)
In-Reply-To: <xmqqfunqhnhf.fsf@gitster.mtv.corp.google.com>
References: <CA+P7+xqFOn4NSfZ2zpa_y1za3uHZrGGG3ktEtuOcvJLCrAYUhQ@mail.gmail.com>
 <20161019224211.k4anavgqrhmunz6p@sigill.intra.peff.net> <CA+P7+xprKV1Y7VShLR9uNgcpVdZk39xoTfkwiin1bVQYTe_TAA@mail.gmail.com>
 <20161020021323.tav5glu7xy4u7mtj@sigill.intra.peff.net> <xmqqa8dzhtki.fsf@gitster.mtv.corp.google.com>
 <CA+P7+xq25LcdmtzmBNChiGhGratcdp7m0EOsQuEh68=gJQ9HNQ@mail.gmail.com>
 <xmqqwph2hqdg.fsf@gitster.mtv.corp.google.com> <CA+P7+xqbqfCTOHJZJ9ZGXv3oeSvKUdJByc8mdzoAoXRd7UZ6HA@mail.gmail.com>
 <xmqqfunqhnhf.fsf@gitster.mtv.corp.google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 20 Oct 2016 13:03:28 -0700
Message-ID: <CA+P7+xoHovFefort6gx6oT4WtT_Toey_0wmmaavLsM=Y1rjx8w@mail.gmail.com>
Subject: Re: tools for easily "uncommitting" parts of a patch I just commited?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 20, 2016 at 11:41 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Jacob Keller <jacob.keller@gmail.com> writes:
>
>>> I am not sure if that is OK.  I think it is less not-OK than the use
>>> case I mentioned in my earlier message, in that this is not a case
>>> that "please don't do it" breaks.  It however is an inconvenience
>>> that the user has to say "git add file" before the "git commit" (or
>>> "git commit file") to conclude the sequence.
>>>
>>> So I dunno.
>>
>> Hmmm.. Ya ok I don't think we can actually distinguish between these
>> two work flows.
>
> What we might want to have in "git commit <paths>" is a new mode
> that is totally different from -i/-o that says roughly "Start from
> the tree of HEAD, pretend as if you removed all the paths that match
> the given pathspec from the tree, and then added all the entries in
> the index that match that pathspec.  Write that tree and commit.
> Take nothing from the working tree".  I have a feeling that when
> people do
>
>         $ git add -p file1 file2 file3
>         $ git commit file2
>
> and ends up including _all_ changes made to file2, not just the ones
> they picked in the earlier part of the workflow, they are expecting
> such a behaviour.
>

Right now I think people who use it intentionally do expect it to work
that way. I just happen to not have wanted to add <file> but did so
anyways without considering, and thus I ended up including changes
that were for the next commit.

As long as there is a way to change "git commit" default from that
mode then we could make the default work and then let people configure
it to what makes sense.

I'll take a look at going this route.

Thanks,
Jake
