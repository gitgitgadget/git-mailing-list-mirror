Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24A8C1F87F
	for <e@80x24.org>; Fri, 16 Nov 2018 05:03:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbeKPPOW (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Nov 2018 10:14:22 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:35436 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727231AbeKPPOV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Nov 2018 10:14:21 -0500
Received: by mail-qk1-f193.google.com with SMTP id w204so35617716qka.2
        for <git@vger.kernel.org>; Thu, 15 Nov 2018 21:03:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gsA1BzneHRtMvEqRSG+7ZljSHDRQCYxh3FvR2nloow4=;
        b=OG2h2/nVzE+UFAEeoSWvhw+z9fc3z+tvAcDPDlfp93iqtFHzmWyOJfJPnuLdeM+d5s
         D3NVB40KalitwhWNM7Pfe0gcA48cn3A9Mv5kmoWgcz5dT9N6P2htGNSVxvBxf+Jmk46K
         vUgUuNkbzED/RKENZRq/gHE7tHp3DRj7rH+jQkDnmk30T5usTFpJh0J4lrITbc0PLZZw
         H+QD0deFAKLr8w7yXHuD6Ml5A5i/PY9wpqPUkdBO/Cd5RdF4ffZXwH+lOVS/9sZFM8pM
         ei2sfPByMw7jGmEVxzlMWChJy09MZjyuXoTIiLofjeM3hjeMKfwnQqsBATZSLY3OUyec
         o/ww==
X-Gm-Message-State: AGRZ1gLoPUGDmNqdxQkGrEwUdzPNeBWSVzood6eMibX9vB3xtakTurQV
        l5dWxncttdhP7I4CrkbQoxKwzqSCtMmp/3YJk2k=
X-Google-Smtp-Source: AJdET5cdL9/9PwbgwDcRe1pe9DMp0pSnbAehma37u12wsDSv4hZKjmu3wsdthWJ2ctuBxFIY2G17SjTcxrt+4/D6Uz4=
X-Received: by 2002:ac8:101a:: with SMTP id z26mr8833439qti.184.1542344610408;
 Thu, 15 Nov 2018 21:03:30 -0800 (PST)
MIME-Version: 1.0
References: <20181115120445.46277-1-yanke131415@gmail.com> <xmqqftw1ll7n.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqftw1ll7n.fsf@gitster-ct.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 16 Nov 2018 00:03:19 -0500
Message-ID: <CAPig+cSE69sTX9qDioG2XD7Zq8TpXGesthBLDbsOszLyDv0mLQ@mail.gmail.com>
Subject: Re: [[PATCH v2] ] INSTALL: add macOS gettext and sdk header
 explanation to INSTALL
To:     Junio C Hamano <gitster@pobox.com>
Cc:     yanke131415@gmail.com, Git List <git@vger.kernel.org>,
        jiu4majia2@163.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 15, 2018 at 11:07 PM Junio C Hamano <gitster@pobox.com> wrote:
> yanke131415@gmail.com writes:
> > * add macOS gettext explanation to get the i18n locale translation take effect in macOS, as the most polular way of gettext
> >   install in macOS, the gettext is not linked by default, this commit give a tip on this thing.
>
> Also I am not quite sure what it wants to say.  Perhaps you meant
> to say something like this?
>
>         Explain how to make the gettext library usable on macOS, as
>         with the most popular way to install it, it won't be linked
>         to /usr/local.
>
> I think the part that I had most trouble understanding was your use
> of the verb "link"; it was unclear (and I am guessing) that you
> meant there are missing links on the filesystem to make stuff from
> gettext package available to programs that want to build with it [...]

You inferred correctly, and your rewritten text conveys the needed information.

> > * add macOS Command Line Tool sdk header explanation to get correct build in macOS 10.14+, as the CLT not install
> >   the header by default, we need install it by self, this commit give a way to install the loss headers.
>
> Similarly, is
>
>         Explain how to install the Command Line Tool SDK headers
>         manually on macOS 10.14+ in order to correctly build Git, as
>         they are not installed by default.
>
> what you meant?

Also correct.

> > +    In macOS, can install gettext with brew as "brew install gettext"
> > +    and "brew link --force gettext", the gettext is keg-only so brew not link
> > +    it to /usr/local by default, so link operation is necessary, or you can
> > +    follow the brew tips after install gettext.
>
> My best guess of what you wanted to say is
>
>         On macOS, `gettext` can be installed with `brew install
>         gettext`, but because the `gettext` package is keg-only and
>         is not made available in `/usr/local` by default.  `brew

s/./,/

>         link --force gettext` must be run after `brew install
>         gettext` to correct this to use i18n features of Git.
>
> but now the sentence structure is quite different and I no longer
> know if that is what you meant to say.  And it does not help that I
> am not a Mac user.

Aside from the minor punctuation issue, your rewrite correctly
captures the intent and is understandable.

> > If not link gettext correctly,
> > +    the git after build will not have correct locale translations, english is the
> > +    default language.
>
> If my rephrasing above is correct, then these three lines become
> unnecessary, I think.

Yep.

> > +  - In macOs 10.14, the Command Line Tool not contains sdk headers as before, so
> > +    need install Command Line Tool 10.14 and install the headers with command
>
>         On macOS 10.14, the Command Line Tool no longer contains the
>         SDK headers; you need to also install them with the command:
>
> > +    If not install the sdk headers correctly, git build will get errors blew, factly is
> > +    is because of this problem.
>
> I can guess this wants to say "without sdk headers your attempt to
> build Git will blow up in your face", but not quite.
>
>         Unless you install the SDK headers, building git will fail
>         with error messages like the following:

Although, as you note for the other case, this sentence and the
following example error message are likely unnecessary.
