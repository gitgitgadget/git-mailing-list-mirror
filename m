Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C5D520986
	for <e@80x24.org>; Wed, 28 Sep 2016 01:52:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934858AbcI1Bwu (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Sep 2016 21:52:50 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:34000 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933460AbcI1Bws (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2016 21:52:48 -0400
Received: by mail-it0-f65.google.com with SMTP id j69so1919334itb.1
        for <git@vger.kernel.org>; Tue, 27 Sep 2016 18:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ctFUHUuRuG97+LvEy/uQd7aXRwfT7aNlBaFxhEWT0+M=;
        b=McQ/7Ju0gBh709ctsR8A0RW0dlkmunqZTvrLqsr8cclK5THOVANGHPW8u6cHoxtl3J
         Wro6SsQBQ6vyPlj4Y8DY5+k+XIpU0SJWB0SICDkFDO0rNtvOGanZl3qt8G/cIawRqfMs
         V/qCMY5rGeUoqjpqY+RUdmV6/yvhUTjOr1RqN6qITeNV7G7KA3OMfrAaKypAiJL7fWFc
         SJIto0pARiwPTfEHErhE4Gu+lHZO3xUyifLt/kgWvgaF80EzjkxZsGD00AdUgKNvpD79
         Up5AjFygcEQFU35zqrkYGRGCWxAsE9nOyjcdFOGfDi0SRxUQU4EGHH8lay6DUsSsejct
         KlRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ctFUHUuRuG97+LvEy/uQd7aXRwfT7aNlBaFxhEWT0+M=;
        b=d7ZuFQbartR1yib8PFOebxFTgd6QfdygDo2647DhQRVBRQOcMN6IkN2w82buZjUWm6
         SWuasnJn52eVFWd/pyKoMEOlaOWxlCHl63EieQ3ig6JXuGOO19fEQYYFhRtBDe9HtQmt
         tNWJBPzO2tbv06+mnXgC2wIwKGxcGaK4myWwSgjfgPR459n03D5m+xqvOO0H7/oLjGFv
         VLQv4TvVah4OIEPT6fapNX9z3Qvphus7t2l1oaTgk2obIZ6LfRYIxnSgQ0+L6zLGHFpr
         /tPoKtzhvFMwQayiE+OMf8WBKjujpRIh8La/IWkRkxPTezDWg7L5onYa1I2lBhD4Wqat
         d9kg==
X-Gm-Message-State: AA6/9RnwVRGWXJdwm50xa2rUQxG7/lrxTupnV/rQH/hOnTzYiPx3amVBqZ8t/y4EHIzXFsmklMzbNaEqd80K4g==
X-Received: by 10.36.67.2 with SMTP id s2mr428149itb.50.1475027567889; Tue, 27
 Sep 2016 18:52:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.27.131 with HTTP; Tue, 27 Sep 2016 18:52:47 -0700 (PDT)
In-Reply-To: <xmqqoa39kn57.fsf@gitster.mtv.corp.google.com>
References: <010201576bfb6c7d-0b68228f-9503-4dd1-9721-713477fa2596-000000@eu-west-1.amazonses.com>
 <010201576d63f422-abe45938-0da1-4fc0-b0e7-3e552b59d10a-000000@eu-west-1.amazonses.com>
 <A9427F4400044104B47378E024C7C2A4@PhilipOakley> <xmqqoa39kn57.fsf@gitster.mtv.corp.google.com>
From:   Pranit Bauva <pranit.bauva@gmail.com>
Date:   Wed, 28 Sep 2016 07:22:47 +0530
Message-ID: <CAFZEwPMe=eLbazZcj8Ce5m01VCt+V2sSix5B_spYRzz7cqsOOw@mail.gmail.com>
Subject: Re: [PATCH v2] rev-list-options: clarify the usage of --reverse
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Philip Oakley <philipoakley@iee.org>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Junio,

On Wed, Sep 28, 2016 at 3:42 AM, Junio C Hamano <gitster@pobox.com> wrote:
> "Philip Oakley" <philipoakley@iee.org> writes:
>
>> micro-nit: 'first' and 'last' can be tricky to distinguish for lists...
>
> Let's do this then.
>
> -- >8 --
> From: Pranit Bauva <pranit.bauva@gmail.com>
> Date: Tue, 27 Sep 2016 20:44:09 +0000
> Subject: [PATCH] rev-list-options: clarify the usage of --reverse
>
> Users often wonder if the oldest or the newest n commits are shown
> by `log -n --reverse`.  Clarify that --reverse kicks in only after
> deciding which commits are to be shown to unconfuse them.
>
> Reported-by: Ruediger Meier <sweet_f_a@gmx.de>
> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---

Looks good! Thanks!

>  Documentation/rev-list-options.txt | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
> index 4f009d4..f8946d4 100644
> --- a/Documentation/rev-list-options.txt
> +++ b/Documentation/rev-list-options.txt
> @@ -638,8 +638,9 @@ avoid showing the commits from two parallel development track mixed
>  together.
>
>  --reverse::
> -       Output the commits in reverse order.
> -       Cannot be combined with `--walk-reflogs`.
> +       Output the commits chosen to be shown (see Commit Limiting
> +       section above) in reverse order. Cannot be combined with
> +       `--walk-reflogs`.
>
>  Object Traversal
>  ~~~~~~~~~~~~~~~~
> --
> 2.10.0-561-g98a6b79
>
