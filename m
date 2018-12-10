Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B5B320A1E
	for <e@80x24.org>; Mon, 10 Dec 2018 12:46:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbeLJMqI (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Dec 2018 07:46:08 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:42774 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726209AbeLJMqI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Dec 2018 07:46:08 -0500
Received: by mail-yb1-f193.google.com with SMTP id b4so2150896ybg.9
        for <git@vger.kernel.org>; Mon, 10 Dec 2018 04:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OoEv4QGc3ULuK0+djovW2gFhfciEJkQ3kGfAC+GkFLk=;
        b=jprVCG7gQLLhwmWwgB1flRi8I5uHBRt+LrLG7dQLfmM2E4aDKjdVqCgTLljf41ATNv
         MYUYS+R5mt9SPzy6XrGQTUMsRoBAFXIJbdTQ3aiYmHNv0iMd17CylVGdMwAn1KAHMIUx
         q/k63zy3mlp9UWUeq/0uISJspO3XohbNWdJEcP0xuo/smY6DTi9gvMepMvdJrbnYGVsj
         2ul5BsC27T5t2jAx4d8Wc5sjNsxwGIHbWcG+TVutNVE7wiUy20KKVaiEHhRaJFM2SbYc
         j34J5JlWj7tTwIGxlv4JJYLn2Ej7/WXVH6vPrtqWk30KkNqRpQR/bguPlYmDLpK118Kw
         8czQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OoEv4QGc3ULuK0+djovW2gFhfciEJkQ3kGfAC+GkFLk=;
        b=umofWZIQ39paXfChcM4rEQERcRjor7ASOw3RO+qw/WkVpSektMxLgJZeplsrHSsYZ2
         jKREnWHTLo1doEw3PhAkSbm5vE+k/DINxt6SUhhVmZnUD0gxaIe/areqCjJ4dMsshc3M
         qRDea2edwu945EeQRoWdQcgr9LlhU0kq0S4EJsB9rAjG1WIBAuu+d4SY6vd3QRn6kVTZ
         Mko5/VAxOujr1vp95UDlPcmSeOYXPi/RxFbqAitQ2ftFFFDlG0p7AJ7mTp2OVkdJS7A3
         nRHYhqop96H60bfflzsLJ8GbCAz94KLRlXL0HHNUm3WSl9ZhOn1Giliu4qwm+Ytt6Nqv
         as2w==
X-Gm-Message-State: AA+aEWYLd2d3r+QCq1tQK193YvsBnywmXRzUFN2e8NJgDd3ocZNpUehj
        SCB2cd6uLFIaZR+P2zbbnp1a7qAhHHFrWGfAGl4=
X-Google-Smtp-Source: AFSGD/W4syHjq21/m26UPZPeccZdAf5bV8btdjrGxk7GANP7P+xzUNZOE4UHv20QGSAaM66OXQJtrJUw9n0x/k8jReY=
X-Received: by 2002:a5b:9c2:: with SMTP id y2mr11690841ybq.464.1544445967046;
 Mon, 10 Dec 2018 04:46:07 -0800 (PST)
MIME-Version: 1.0
References: <5bf18396.1c69fb81.20780.2b1d@mx.google.com> <20181207170456.8994-1-tboegi@web.de>
 <CAAXzdLVTjCVDmBik-j9B_Z_2wgSj=_6baqmjmGEGBFOsjkyOsw@mail.gmail.com> <nycvar.QRO.7.76.6.1812100938140.43@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1812100938140.43@tvgsbejvaqbjf.bet>
From:   Steven Penny <svnpenn@gmail.com>
Date:   Mon, 10 Dec 2018 06:45:58 -0600
Message-ID: <CAAXzdLUKhCfvqdvsPryeMGJ2ttJxof4sUcyTx-xd5p2BaoryiQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] git clone <url> C:\cygwin\home\USER\repo' is
 working (again)
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 10, 2018 at 2:46 AM Johannes Schindelin wrote:
> please stop dropping me from the Cc: list. Thanks.

i dropped you specifically because i knew you were going to flame like you just
did below. oh well, i guess you cant avoid the inevitable.

> > - pc-windows
> > - pc-win
> > - win
>
> I find all of those horrible.

they arent great, but "win32" simply isnt valid. as soon as we started compiling
for 64-bit and using 64-bit APIs it didnt make sense to keep using it. if you
want to refer to all versions of the Microsoft OS you say "Windows", not
"Windows XP", as that would be confusing for people using Windows 10. In the
same vein you shouldnt refer to the current Windows API as "Win32" because its
no longer just 32-bit.

> ... except if you take into account that this has been our convention for,
> what, almost 9 years (since 44626dc7d5 (MSVC: Windows-native
> implementation for subset of Pthreads API, 2010-01-15), to be precise)? In
> that case, it makes a ton of sense, and one might be tempted to ask who
> the person wanting to change that thinks they are...

"That's the way it's always been done" is not a good reason to keep doing
something. I would say the justification goes the other way, as to why we should
keep using an old moniker when its past making sense.

> You may disagree all you want, but given that Torsten has been a lot more
> active on this code than you have been so far, I'll go with Torsten's
> taste. Which incidentally happens to match my tastes, so that's an added
> bonus.

in the end i dont really care what your taste is, or Torsten for that matter. I
care that the issue be fixed.
