Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C5CF61F461
	for <e@80x24.org>; Sat, 24 Aug 2019 06:57:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbfHXG5e (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Aug 2019 02:57:34 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:37465 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbfHXG5e (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Aug 2019 02:57:34 -0400
Received: by mail-vs1-f67.google.com with SMTP id q188so7734709vsa.4
        for <git@vger.kernel.org>; Fri, 23 Aug 2019 23:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1DflDIQiDHrgB88Ac6e96GS7H5aEMHXr4dm+wAYwv3g=;
        b=t3QlOXRchTHh8SLcUehvDGa7MUUeikk/tDbesrzWDBSFUxGe4szJBgcxNKlZGdShsA
         gKk/A/aOFARSw4du07BsxGGNYrkpVnUvjBVujo0zRj/Xioz+LqM4TvPvTWbpsgqSbcw5
         ow/lnQkmYMmKqMFXOFAa/deah4ZCQry7l8vNu8ppse0dizhJwRxUee/UPyrXLZYDG8tX
         cjvA16BbMFf04nV5lSGoAS0ys647PkQgvI6ibtpbVTaYk9dxCk8PXrAaICNQsTXKtrPD
         dCpcoCV1po1Qrxxj5T8AB4O7OEqo0bkAKF0v8dJ8SBfHHe58hGgj8xMug+82uQWs4MXs
         g3eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1DflDIQiDHrgB88Ac6e96GS7H5aEMHXr4dm+wAYwv3g=;
        b=ACeSz9pstviLhBCCfSRvD6GG8U79xbDwUX1jTHn2uC6oLmG6znqPKX2q9vrtPCI3QS
         XICyo9vgrmoymh3jlGxMMi+1la9H6mH05eRmXZq7+TfBuotF91L9Xv3RSzi/FDP1otV/
         QDeKfC60Red4M/ARlAm90KhTWl5b7H44hLVBxT6w3zRfhWZ3vcLXQ9egfJ/ieR/1au6X
         nWIe8RM1vZW5OKT47p2Ei8V/6P2s+LR7sOC0+y2JjzyWiYcpAKt+tZBDmoXJpPwouRdi
         ImyzmowYpxsalcWBEN/xtJ6jWp/Q41QxJCzU3QGvioNU7xBY2Vb+3WwINGjzTJ/c/l67
         rO1w==
X-Gm-Message-State: APjAAAXhsjHPrj8tID/y4gWQCcnIBp3Uiky+nlec/D6abPaa6F8BUMjb
        XGXjGmG5RiExkxEI0AI7nrPPwH5zaGhiF+gb+xE=
X-Google-Smtp-Source: APXvYqzHkAGmsx4uF7PPJgUvZvXXJsU32ErshxIrxYGpTEAdgn9BG70LWn4cK65I2zDsJtT/3vG073RwsME+O0HS+n0=
X-Received: by 2002:a67:e45:: with SMTP id 66mr4896340vso.197.1566629853495;
 Fri, 23 Aug 2019 23:57:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190819214110.26461-1-me@yadavpratyush.com> <20190822220107.4153-1-me@yadavpratyush.com>
 <20190823234339.GA17088@gmail.com>
In-Reply-To: <20190823234339.GA17088@gmail.com>
From:   Bert Wesarg <bert.wesarg@googlemail.com>
Date:   Sat, 24 Aug 2019 08:57:22 +0200
Message-ID: <CAKPyHN1gA4zPL7=WYQotKmQf=hZR+gr1wH3t5GuMw9thiMTsKg@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] git-gui: Add ability to revert selected hunks and lines
To:     David Aguilar <davvid@gmail.com>
Cc:     Pratyush Yadav <me@yadavpratyush.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 24, 2019 at 1:43 AM David Aguilar <davvid@gmail.com> wrote:
>

> I have a very strong opinion about the confirmation dialog, so I'll just
> mention that here since Hannes is on this thread.
>
> In cola we do have a confirmation dialog, and I strongly believe this is
> the correct behavior because it's an operation that drops data that
> cannot be recovered.
>
> In the other thread, it was mentioned that this dialog would be a
> nuisance.  Perhaps that is true -- for the dialog that may have been
> implemented in this series (I haven't run it to verify).
>
> Let's dive into that concern.
>
> In git-cola we have a confirmation dialog and it is by no way a
> detriment to the workflow, and I use that feature all the time.
> Why?  The reason is that we focused on the keyboard interaction.
>
> The workflow is as follows:
>
>         Ctrl-u to initiate the revert action
>         The prompt appears immediately.
>                 - Hitting any of "enter", "y", or "spacebar" will
>                   confirm the confirmation, and proceed.
>                 - Hitting any of "escape" or "n" will cancel the action.
>
> So essentially the workflow for the power user becomes "ctrl-u, enter"
> and that is such a tiny overhead that it really is not a bother at all.
>
> On the other hand, if I had to actually move my hand over to a mouse or
> trackpad and actually "click" on something then I would be super
> annoyed.  That would be simply horrible with RSI in mind.
>

I take this as a point for*not* having a confirmation dialog when
doing the action per mouse. Which matches exactly my original
implementation.

> OTOH having to hit "enter" or "spacebar" (which is the largest key on
> your keyboard, and your thumbs have good hefty muscles) is totally
> acceptable in my book because it strikes the right balance between
> safety for a destructive operation and convenience.
>
> Now, let's consider the alternative -- adding an option to disable the
> prompt.  I don't like that.
>
> Why?  It's yet another option.  It's yet another thing to document, yet
> another code path, and yet another pitfall for a user who might run
> git-gui in a different configuration (and becomes surprised when revert
> doesn't prompt and suddenly loses their work).
>
> Do we really need an option, or do we need better usability instead?
> My opinion is that the latter is the real need.
>
>
> That's my $.02 from having used this feature in practice since 2013.

2012

Best,
Bert


> --
> David
