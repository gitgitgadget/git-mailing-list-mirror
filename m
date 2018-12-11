Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7ED3E20A1E
	for <e@80x24.org>; Tue, 11 Dec 2018 15:40:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbeLKPkt (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Dec 2018 10:40:49 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:34139 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726499AbeLKPkt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Dec 2018 10:40:49 -0500
Received: by mail-it1-f196.google.com with SMTP id x124so11144789itd.1
        for <git@vger.kernel.org>; Tue, 11 Dec 2018 07:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UxVjGDuXxH3cpRFAk1JGA/WOXe9CQoV6O5pB25fG3Vc=;
        b=BmmG+IAKgu6A+/lGmaaHw9drCksliaOsFH5gvWM/cc7DatxTV23uVR8b7wE+A8J05Z
         purqoKoQzkYYeMUNGwJttpecTI+5fhuVSLTfYDcfo8iwmbagXeTrBh7GJ5gTHadDHUr1
         D/Q7v1u63alIESf0WLpHzwzAmBJF4gwVkAtbXeaQnUlD3Ansi7iSeh8HPtE25fFLB48v
         DqnOG0szynDwQUXEGtiM/tARoDUiB3iriVg2jyz8QE5KtkUGXdt3ENSuH4Q0GKaWxnst
         XoQRyxqIoeK7xJBzOsWdnMG04+iia5sOsMpkwlVXdEwHULb9QSJrsZuMaF/SLFiNH/4q
         qvqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UxVjGDuXxH3cpRFAk1JGA/WOXe9CQoV6O5pB25fG3Vc=;
        b=BwlrCEgkRED8t4xF9w52Y90Urb8afFy4jEUwscgtNcgLBpJZWVNE5IfrBMUF26IsOu
         GYyFfgiu5Mnb4moHBOrHgO1rN/e/lyDU3e6OyKP7ftCrmVvYQi91h5HChJ3mt71WmZGv
         cT2OdrGj7QT1xrmfahDF0865rhyKqAdf+kUisuyPTKgmYRv1QHfE19B1FFfWirsx1wyM
         Mca1mCVxT0gd26LtRxclhdURJaX/gfipKlvjhCX3eDE2NX4hSNha4cO6rbc7HBnHQNYy
         mHXWzAQqNALyerqYZKfvlWr6pGTsW41yNig45G0r/qba+PlHZC5soYe/SWfIDbprNEsc
         qQ7g==
X-Gm-Message-State: AA+aEWZSPnKk/8YUkIQxCc5q6gGbzVP7/EUjgfiug2cXkbZMr7WYJIND
        VRcRCUryHPlVVcKL2zU4sxCUExVfBqOC0735M/Q=
X-Google-Smtp-Source: AFSGD/W9ikE0AFhcWP42NalwT+hSgkxBH5XvuzTQR05UjQ7CXEvplNS69ggfW4fziZBdbA36gQKtt0yAyPdQrjJYSTQ=
X-Received: by 2002:a24:e1ce:: with SMTP id n197mr2547874ith.123.1544542847372;
 Tue, 11 Dec 2018 07:40:47 -0800 (PST)
MIME-Version: 1.0
References: <87va4cujtx.fsf@evledraar.gmail.com> <20181209102724.8707-1-pclouds@gmail.com>
 <xmqqy38xkhvd.fsf@gitster-ct.c.googlers.com> <20181210152642.GA16203@duynguyen.home>
 <xmqqk1kgn73c.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqk1kgn73c.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 11 Dec 2018 16:40:20 +0100
Message-ID: <CACsJy8BFn7xbJO8G_mTeeHBbZ3J52ZQkSAyrmyxe=BfVaapPEA@mail.gmail.com>
Subject: Re: [PATCH] parse-options: fix SunCC compiler warning
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 11, 2018 at 3:13 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Duy Nguyen <pclouds@gmail.com> writes:
>
> > The reason it's in parse_options_step() is because -h is also handled
> > in there. Although -h does not bury exit() deep in the call chain. So
> > how about this as a replacement?
>
> So just like -h returns PARSE_OPT_HELP and causes the calling
> parse_options() to exit(129), the new _COMPLETE can be used to
> trigger an early & successful return?
>
> We'd also have to cover builtin/{blame,shortlog,update-index}.c
> where they switch() on the return value from parse_options_step(),
> but other than that, it probably is a better approach.  The users of
> parse_options_step() that avoid parse_options() want to handle the
> various "we stopped by hitting a non-option" cases in their own
> ways, so treating this special action the same way as -h is treated
> would be sensible.

Yeah, I saw that shortly after sending the patch.

> We _might_ want to standardize some of the case
> arms in these custom switch statements that appear in these three
> built-in command implementations, but that can be done more easily
> if this step is done like you showed below, I think.

I have a better plan: stop exposing parse-options loop to outside.
What all these commands need is the ability to deal with unknown
options (or non-options in update-index case). They could register
callbacks to deal with those and keep calling parse_options() instead.
I'm converting rev-list to use parse_options() and as an intermediate
step, this callback idea should work well. The end game though is a
single parse_options() call that covers everything in, say, git-log.
But we will see.
-- 
Duy
