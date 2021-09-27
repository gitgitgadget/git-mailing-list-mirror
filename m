Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92082C433F5
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 10:20:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 779B960F6C
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 10:20:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233818AbhI0KVk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Sep 2021 06:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233757AbhI0KVi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Sep 2021 06:21:38 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51653C061575
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 03:20:01 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id 73so36214927qki.4
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 03:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jvHaAr257C3sJTzAAcb1QaraMUpKg/rBWw/oaYrilFg=;
        b=dthV27l8jeedVV3ELRZZsnsxRqOk+SkLdIj5MDFFfg1Ybd3eSiuqEC/OGpKaWJnn5G
         FLmpINXHjg1ye83z10A6U/YxRUL3TTL1LNjArwIW5SUBvHYq/Volj4zgqT7I0aG45Kxy
         cwHMSG1QRFD+RjiyFgrt1zNQO86LCYZdI1AogXEXIXQudzEW7iolBKLSuZbOjuMV/T8F
         yw9Pe8873F+jK4Ex2zpBjiODKeBBDFNeNnJ9mA/93zEAaj3NN2C6dB6nz4rU/539ObVT
         G+iKE2sEO1WNbo0DL9/YLnBDmoLcs/sLmVUlFgNtzk8+CKDEBiwfkhG1kX8Cw7FRqhm/
         eU8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jvHaAr257C3sJTzAAcb1QaraMUpKg/rBWw/oaYrilFg=;
        b=x9wELMy7KX/NYzuQu96lXWA5uWQ0AEAt59CH68/OqPutzLvaTIRbS5zU+1BYsCGDXV
         Ay5ihHs9MCqFqEAJOPiTsZmpafUZ12SiKpEvWrgLmTidr78mY1UFyDwOrIgmw1ES9kmq
         gLtD1Uv1XKM7YoX34T22sngdeTf2e9RYtryo8aAAPGf/72u8Y8sY2sd3jSpPvbSXB4eO
         3EYPY3LmUPj4AuYQoQ93p5WcsXYuYXOYa+4PwOhjqMD4G5xkUK4fo8oURoevngLUnQn6
         jgw1Su2hYGchpHCMmCcJvV05k2ldZ4KhDwzSe/yVTbVvAhxZ8i60NrSzBbcrkx+tKELH
         T6QQ==
X-Gm-Message-State: AOAM530E38qZo6oWGQGkSR3LGB3txViVHlKbF6GXKpBx4q4WMXWQw6Z5
        zlyywL+g7vAa4UFnjRL8pV6lGhn+Hgapb3Kc26FMF2BAGNFOHg==
X-Google-Smtp-Source: ABdhPJyULeoAjF4NHpZoaZwW6bTEeWGAJuJj/IekNK4e2Un2e/SOvdJvoonT7Sz/KvMeq/QxUWMYE+GQk9r4OPbcDT0=
X-Received: by 2002:a37:9e4b:: with SMTP id h72mr22632106qke.475.1632738000311;
 Mon, 27 Sep 2021 03:20:00 -0700 (PDT)
MIME-Version: 1.0
References: <CABkJDHFOMkf-Pouaw3rtjtM+KFhPxnYtCiMbqKYCraXFb_9qQw@mail.gmail.com>
 <7b4b59a4-7e58-3db2-d934-d570cdebbf31@gmail.com>
In-Reply-To: <7b4b59a4-7e58-3db2-d934-d570cdebbf31@gmail.com>
From:   Sashank Bandi <bandi.rao999@gmail.com>
Date:   Mon, 27 Sep 2021 15:49:51 +0530
Message-ID: <CABkJDHHDjwviVmCR=tu3JBx+7BMmbmesOrkymq0fH4PXE5=i1g@mail.gmail.com>
Subject: Re: [INFO] Does Git GUI support Dark Mode on Windows 10 ?
To:     git@vger.kernel.org
Cc:     bagasdotme@gmail.com, me@yadavpratyush.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 27, 2021 at 12:02 PM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>
> On 26/09/21 22.09, Sashank Bandi wrote:
> > Hello,
> >
> > I am new to the concept of mailing lists so please bear with me.
> >
> > I'm a JS developer. I love Git GUI for its minimalism in both size and
> > layout. I have been using Git and Git GUI on Windows for a long time.
> > I think the only thing missing from the "Official" Git GUI is dark
> > mode.
> >
> > I use dark mode on almost all places. Firefox, Discord, GitHub,
> > Outlook, Notepad++, VS Code and even Reddit too. The only place that
> > is missing dark mode in my workflow is Git GUI.
> >
> > Is there any way I can make Git GUI dark mode ?
> >
> > I don't know a lot of Tcl/Tk but I am currently trying to learn it. I
> > did a few edits and made the About page in dark mode.
> > You can look at it here:
> > https://user-images.githubusercontent.com/76554862/134190271-d861407a-31be-436d-aac4-9ea3d72f0fb0.png
> > .
> >
> > I have found two threads in the mailing list but those are just dead
> > ends for me. Hence I reached this mailing list.
> >
>
> I would rather like to see yourself posted PR to the dedicated subsytem
> at [1].
Nice to hear that you like my design.
I think this confirms my suspicion that there is no "Official" Git GUI Dark
Mode on Windows 10.

> I think you want to implement tri-state `Dark mode` option. When it is
> set to `Yes`, always use dark theme regardless of system settings; when
> it is `No` the opposite; and `Auto` use dark theme when it is enabled in
> system settings, normal the opposite.
Our interests conflict here.
I think we should rather provide 3 different options here.
1. System Default
2. Light Mode
3. Dark Mode
I find these options easy rather than the "Yes" or "No" options.

I'm currently planning to convert this into a C++ program as there is no
way from the Tcl itself to change the color and background color of the title
bar or menu of the Git GUI window.

I also CCed Pratyush Yadav as he is the official maintainer of the project.
