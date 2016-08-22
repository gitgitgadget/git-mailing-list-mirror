Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 783FD1F859
	for <e@80x24.org>; Mon, 22 Aug 2016 13:33:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755376AbcHVNde (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Aug 2016 09:33:34 -0400
Received: from mail-it0-f47.google.com ([209.85.214.47]:37980 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754805AbcHVNdd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2016 09:33:33 -0400
Received: by mail-it0-f47.google.com with SMTP id n128so82291220ith.1
        for <git@vger.kernel.org>; Mon, 22 Aug 2016 06:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=iRCvrbpGafDEsK5T6EV/6ZnWkenFgMXm2hTiFguwP34=;
        b=PEo1Wx4VR583jgOpexc3Ck+/mVAeBgQgcXfDZ4KanZty2PAIPxxFyXAIXSBZf8tmnY
         nVD+aP3TpsHmjMVgJBF38i3zrHDWK0usLGv60rT2NLFHuHl3IyfibOzCf2wr3u7jSDsW
         DkRh0wugoLqSEzB/+F/q3mI4H23iuNT+sGVUvrQ5DYw2CepMtInBoicKhAFj5ke027gt
         YV3sHd0QvLMMwfwJVGyGaNco0oGA24VjrM4q/aGxapvEbaFpGNkBg7vttRzsWf40yKev
         R4S2FOv5hdnnrI63glWrMqvKcVW/l/QSwmQP7qk9r3Cd07eMDJXd7iQUDFhopTdeubZ0
         MQJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=iRCvrbpGafDEsK5T6EV/6ZnWkenFgMXm2hTiFguwP34=;
        b=iPJ+qbqNtmFv3KPfsOwgwKtUdys4Z89eK+IxqaTUMNzYqmucEQ4d6FELEcklOaT9HC
         ZijgtQSmb1B8UaO4Q1xl6U9BE9Tm8zOvXVp4dNeqW6Kt6+I1ghaiuP5h59E3ifCjPtdK
         nUMbNs5yqWqzmo3sqi6VYvzoQcjn2xjmFGOJfy/Xi85XbC7k7rHY7g+74Q+VGIU/+YJi
         UquqPwvvTGP0e5Y8bT6PCGXrbrEL4Rirx00Ns4fRDWnuis9hULFNasHJCGdkc4SlHJmw
         WIkLPvgMTbBScVhLZcn8Ib3rYgXl4A0f9mfwrQpIQ1ygN2Yg7P9cdDZyGxUdZZYvcMKo
         7pXQ==
X-Gm-Message-State: AEkoousoIFeKCDEKGuiLydFPfjq/4R5cPW7Qaj7GuzYnWvlvpxJmS+IQ9YJocYneMVMweGo7JvEZKEhLst1eIA==
X-Received: by 10.36.207.8 with SMTP id y8mr21287452itf.63.1471872792772; Mon,
 22 Aug 2016 06:33:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.125.199 with HTTP; Mon, 22 Aug 2016 06:32:42 -0700 (PDT)
In-Reply-To: <vpqlgzp9bw1.fsf@anie.imag.fr>
References: <20160712164216.24072-1-pclouds@gmail.com> <20160714153311.2166-1-pclouds@gmail.com>
 <CACsJy8Bw0ZNu-6SB0P3dBZCLMJWJkbUqb64H_QOcn4UH+_AcNA@mail.gmail.com>
 <20160819135408.ckyw6ruseicvg2jt@sigill.intra.peff.net> <5c131421-ae7f-8a37-76ab-0fd05cbe3530@gmail.com>
 <CACsJy8C30=-LGMYQJ6MO17L8Vv1q=iQGC=R8TDhC5qM1f5Lh5A@mail.gmail.com>
 <vpqr39harit.fsf@anie.imag.fr> <CACsJy8BNP8GDRxDGTQwcYWTovN9o11TCkUJ28=5zav3QnGv9nQ@mail.gmail.com>
 <vpqlgzp9bw1.fsf@anie.imag.fr>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 22 Aug 2016 20:32:42 +0700
Message-ID: <CACsJy8BokiiDbheN1_CqWWgK3xRn8YP30t7ojjVeDnok5_M4Ow@mail.gmail.com>
Subject: Re: [PATCH v4] config: add conditional include
To:     Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Cc:     =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Jeff King <peff@peff.net>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Sebastian Schuberth <sschuberth@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 22, 2016 at 8:22 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
>>> I think the syntax should be design to allow arbitrary boolean
>>> expression later if needed.
>>
>> I would be against that. We may extend it more in future, but it
>> should be under control, not full boolean expressions.
>
> Why?
>
> I'm not saying we absolutely need it, but if we allow several kinds of
> conditions (gitdir-is:... and others in the future), then it's natural
> to allow combining them, and arbitrary boolean expression is both simple
> and powerful (operators and/or/not and parenthesis and you have
> everything you'll ever need).

For starter, we don't want another debate "python vs ruby vs lua vs
..." as the scripting language :) (for the record I vote Scheme! maybe
with infix syntax)

Seriously though, for things that are evaluated in the background
every single time a command is executed and things that come from many
different places (/etc, $HOME, $XDG, $GIT_DIR) I think absolute
flexibility just makes it harder to pinpoint when things go wrong.
Combination in this case would be a bad thing, not a good one. By
judging case by case before introducing a new condition type, we
probably can see what sort of combination would be and whether we
could accept that.
-- 
Duy
