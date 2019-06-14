Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE3F91F462
	for <e@80x24.org>; Fri, 14 Jun 2019 06:07:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbfFNGHA (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jun 2019 02:07:00 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:41793 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbfFNGHA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jun 2019 02:07:00 -0400
Received: by mail-vs1-f67.google.com with SMTP id g24so1044699vso.8
        for <git@vger.kernel.org>; Thu, 13 Jun 2019 23:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6PAzbRCGMRv+KQWxXsZdo02VCRwzmm551DIKSBZBAZ8=;
        b=TtPylxV9zvqvo/Xl2Y1QPhg/s0VM8wwkQmhJx0KZLwmGlxqjUlWKYxCIjJuRMa1olV
         /u1ti1nHgGiddctgBEyYrZQWK8o5qZA2GwJ9OTALED0aqc6AKoTvI1PjG9TaXgQgnU1q
         RbqpTK4IQrBVbCA8I/3R0byH7fpQUiORBxRKHcWhIY6RmfPeXLqCg3/vkt7/tjEYrtn2
         pvqGkpV8I0xFt+Hk7YjJ2iEd7mhV+XBoJ9v7h7lVrVX/YCOltPrp3dMCRspKoF1jSigx
         sc3XDEOfUxb5JleDysg7rEIubleRcoyV1gSIowgl2yrj4RCISKUxom/V2IavDliEkG5b
         WB7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6PAzbRCGMRv+KQWxXsZdo02VCRwzmm551DIKSBZBAZ8=;
        b=SVGM8CfVkhnb+DnIhGKna4jDN84efSYytZoKDYmP5KZoMLrKFoi23/ERQvuxv54nD5
         O1O0YW1PJN+1JqrOR0f/9w1oVIuvtSbBQ49f+fvFF4uL20KNaW7TqQUQ5s9jfVajtWnh
         2zY62nKfW7UvZM+2w5jyK+4FVVog6BWGcc9nYlExYjoxb+h0P+FOeJoJP4tJjsPjRiZk
         v7UXFQH+7gGBFk4UShDR60ssrtGyEF4avw1+X8WHGInBYrSGE2T1BpJQALUm7OKU+O2u
         ptqUuSxHSkrUO5RARLBGhxmkJBWFXBVyXmT1knsreJKVpC92HCPEjqsDkQIElITa5oMz
         Etiw==
X-Gm-Message-State: APjAAAWAZDMCdt2AdI7+H7TazeRxGL1pkwaLLnxtLhU/C/t4SkCRWZ09
        9d+ZuGaQwVWHLe78XDrbMDg1D0yMz3zLzJKHs/U=
X-Google-Smtp-Source: APXvYqy1p5Bb06jPuX4WZIZhVnhPbKdZew1QPyPlfexPry3JRih5IQjhh8XwdkxjlGFol2ST0xb3ozmcNxm1f4petII=
X-Received: by 2002:a67:ecd0:: with SMTP id i16mr5262286vsp.110.1560492419439;
 Thu, 13 Jun 2019 23:06:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190607022443.5706-1-felipe.contreras@gmail.com>
 <20190607093034.816-1-pclouds@gmail.com> <20190607100252.GA24208@szeder.dev>
 <CAMP44s3EsNzBtt_pG8HVp_RTMTTArk7Twhty4_tzf2iiZ7TKUQ@mail.gmail.com>
 <CACsJy8CGtZMn0aa7QRj7Dz-jZS2K2fviUJ_Lii48FRY4E84i5Q@mail.gmail.com>
 <CAMP44s2ewOJNYSqQ+8EiBJ8ik7rWMj9yaxWwzYk9nUO+A1gwcg@mail.gmail.com> <CACsJy8DThHXksARSM32fQ_8fdYqpQYnR5SQmC0i1oVZVc58fPw@mail.gmail.com>
In-Reply-To: <CACsJy8DThHXksARSM32fQ_8fdYqpQYnR5SQmC0i1oVZVc58fPw@mail.gmail.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Fri, 14 Jun 2019 01:06:48 -0500
Message-ID: <CAMP44s1RP8ERVX7EPt3oJyd8FP+4OjrGnWnaavnHuORoc+BGxw@mail.gmail.com>
Subject: Re: [PATCH] completion: do not cache if --git-completion-helper fails
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 13, 2019 at 9:53 PM Duy Nguyen <pclouds@gmail.com> wrote:
>
> On Fri, Jun 14, 2019 at 7:30 AM Felipe Contreras
> <felipe.contreras@gmail.com> wrote:

> > One way or the other, shouldn't my tests be merged? The issue is still
> > there, and it's nice to have tests for that.
>
> Is there any good reason to complete options when they are not going
> to work anyway (e.g. like checkout which needs $GIT_DIR)? Besides "it
> used to work before --git-completion-helper" which I don't consider a
> good reason given the maintenance tradeoff of --git-completion-helper.

No, there is no good reason that I can think of, except checking the
arguments, which is precisely how I found out the issue; not something
I usually do. But a newcomer might not know what commands don't work
outside a git directory.

But more importantly; is there a good enough reason not to? I seem to
recall to be annoyed by the fact that 'git command -h' failed on some
command with a fatal error. Similarly, I don't see any good reason why
'git help clone' should ever fail.

These are not dealbreakers by any means, just some kind of weird
corner cases. Such things never happen in in Mercurial BTW.

And of course --git-completion-helper is the way to go, I recall I
wanted to implement such a thing myself, this has the potential to
increase the power of the zsh completion incredibly, although not yet.

But that doesn't mean it's perfect and there are no regressions; there
are. I just think they should be documented in the testing framework.
They are not big enough to warrant going back from
--git-completion-helper though.

The only real issue I think has not been raised is that the completion
scripts are in "contrib", they are not considered part of the main
deliverables. So it's conceivable that somebody running Git v1.6 tries
the completion scripts of v1.20, and everything breaks. I'm still not
exactly sure what should be the way to solve this conundrum, but
again, I don't think going back from --git-completion-helper is a good
move. I don't think I suggested that.

Cheers.

-- 
Felipe Contreras
