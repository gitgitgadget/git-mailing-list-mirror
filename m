Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,URIBL_SBL,URIBL_SBL_A shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BDB71F461
	for <e@80x24.org>; Wed,  4 Sep 2019 19:56:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729278AbfIDT4J (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Sep 2019 15:56:09 -0400
Received: from mail-vk1-f180.google.com ([209.85.221.180]:33006 "EHLO
        mail-vk1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728152AbfIDT4I (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Sep 2019 15:56:08 -0400
Received: by mail-vk1-f180.google.com with SMTP id q186so3426545vkb.0
        for <git@vger.kernel.org>; Wed, 04 Sep 2019 12:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Lw+bE2dwOegIoQzkUNBSmlLs7PAi0krdv69bCcZfmzI=;
        b=CC0PEMa2yfDEicu6aG0RDYvp97etCZLxZxdxeG+WBilSpFh8yFbjtPu2+6AA6krDmB
         ClppHs50pKqqklYt2zDkt8dwthwRGp3VAooqD9/ymVyMliKGso1eCj+9+833kmjs9r6W
         ThOowPWx4/ud0tMC9T1ikUewDDNQ5jIquCJRjjQ+U0itZwmQMQZowJvUs0MtiA/bimvc
         OCqbujH5VvqjcB+XrwHIBwq4vMBWJjy0SHjiw9dtX9B7hLm9VA3CFNJ6Fo+jIGs0ufIi
         7sK5cgG8JZtW+D/wcem4exNv2GGnc60yEPHpORFeOiiGjQTqOx5HekuvqaBhCZ4KAaoQ
         dEZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Lw+bE2dwOegIoQzkUNBSmlLs7PAi0krdv69bCcZfmzI=;
        b=i5/5LBi5Fd6JM9vCn3ZAbOrX0IPBW8mqTlW5qUaY9GCuo9rZGb7RjiAPJnhnWwXDey
         JM6/SW4tlJ4T5U0w9EL1XBHu/eT66501bBkMBa1oEX2vK25wI53iH6OsXK5mg232ULoK
         q6fBrswenUjfpol5LWWUgKx4mYzIzKy3PzLWGepEt9MrO4agyD4JdmlwrcfJp6JhNXr+
         uXxU8O8Kz9XdvOMu6xuk4D9SHoHOyIbMm2/N/29SaV0PRIRbdTNiH5Y0Q6lwQWukA+yH
         ZRV1sBCNOfefpETZTwVNK18CaQ5iazfpW3/bQze8K+h/c/ES8ykGWnKa9ioPWNl5funx
         Xq8A==
X-Gm-Message-State: APjAAAU3Rtec1V8PqOUuWBmll14lYip2IYn3dOevgB9n61cTI+O0si4m
        9aVZhsOrnJ3WNNl1lxlw7Wj2SrnB6Xnq25EYMxso7J6U
X-Google-Smtp-Source: APXvYqwvp1BUBIlPlKadBToAP27Y0X+qT4bQ1IFfD1WBaiJ86h6Z9ofUEnJyCCpVHfa+CZMyAZmkJWpbVNchkZY55/g=
X-Received: by 2002:a1f:78c5:: with SMTP id t188mr11030147vkc.87.1567626967462;
 Wed, 04 Sep 2019 12:56:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190903214942.ubcbdgtphpwnaxs6@yadavpratyush.com>
 <20190904143055.11400-1-birger.sp@gmail.com> <510e80f4-a8e1-329d-2395-b1268bf7c1f8@kdbg.org>
In-Reply-To: <510e80f4-a8e1-329d-2395-b1268bf7c1f8@kdbg.org>
From:   Bert Wesarg <bert.wesarg@googlemail.com>
Date:   Wed, 4 Sep 2019 21:55:56 +0200
Message-ID: <CAKPyHN3WNPbJUX-xhMPVg-WigJkMg=NU9HHm98Z6wn8xeHKv7g@mail.gmail.com>
Subject: Re: [PATCH v5] git-gui: Add hotkeys to set widget focus
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Birger Skogeng Pedersen <birger.sp@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Pratyush Yadav <me@yadavpratyush.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Hannes,

On Wed, Sep 4, 2019 at 8:59 PM Johannes Sixt <j6t@kdbg.org> wrote:
>
> Am 04.09.19 um 16:30 schrieb Birger Skogeng Pedersen:
> > The user cannot change focus between the list of files, the diff view and
> > the commit message widgets without using the mouse (clicking either of
> > the four widgets).
> >
> > With this patch, the user may set ui focus to the previously selected path
> > in either the "Unstaged Changes" or "Staged Changes" widgets, using
> > ALT+1 or ALT+2.
> >
> > The user may also set the ui focus to the diff view widget with
> > ALT+3, or to the commit message widget with ALT+4.
>
> Many keyboards do not have a right Alt-key. That means that Alt+1 to
> Alt+4 combinations must be typed single-handed with the left hand. This
> is mildly awkward for Alt+4. Can we please have the very important
> commit widget *not* at Alt+4? I could live with Alt+3.
>

I use my left thumb to press the left Alt key and it does not feel
mildly awkward. As Alt is also used for the mnemonics, there will
probably more of mildly awkward key combinations, wont there?

Bert

> -- Hannes
