Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43335C433F5
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 19:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10AB460EFF
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 19:20:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbhJ3TWb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Oct 2021 15:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbhJ3TWb (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Oct 2021 15:22:31 -0400
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1864C061570
        for <git@vger.kernel.org>; Sat, 30 Oct 2021 12:20:00 -0700 (PDT)
Received: by mail-ua1-x932.google.com with SMTP id u9so24461256uac.8
        for <git@vger.kernel.org>; Sat, 30 Oct 2021 12:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9YOvOmM2vf9bUFPcLHZw/Efi2mmaBEkI0VPt89x6cQo=;
        b=nENdH95/Jm2brKMvs2lwl/sPFEp3zOHqdtD8OVq4BivoNReRPz4V1Y1zD7+Jl0eaVa
         ae8r0XPkhCl+Ao8vmc0YUkmZEfZwIiQSkr6Q7GDo9EfW+XMhbue3lV8KDZKCBPbiLY+d
         fE5i7rKkQXFmASnGWHgBtknr43P6SkqPAMa0n8Ctji0n6DN0lx38IDuYMDwVVtp9gH11
         rmS9jXDXc0j4bJoESTAqMMQqYnFTYbNmfz9MYlRHUO+8MMtEWzkUeCMFjP99UDi3ck3c
         c4AwmjFXPqDeKj20RnboPkxJrH1iEgQcQxj+w6FpCXe/Dz5+splecE/w6eT1nZHufaar
         N5ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9YOvOmM2vf9bUFPcLHZw/Efi2mmaBEkI0VPt89x6cQo=;
        b=7ppWDLV7n1p1Bo/DZwf0CPJibCsWivWteHMNo43P6t0mqxUAxiPwJRxiBOqAhZXXHe
         XoBBH1rwtA10YqUGqjkA2tXQfbEAqR/UCmdz7NS3pcAzsdTmlbS/Mk8b2S7xsEXrTTM+
         JT7ghkv1qE2nn/xwxiJl6cnOKDXkHfuAuqTZNFMaTBRyLCrwq2Oc8cm+CzZi3QTEj5fS
         gGGtRIJBg3rmrOPiTI8ZrwhGRin2qnbtkA18YiNxwLcciket3bzWLSrdIiivNOAcbgO8
         MxeIqEWrP7JICWMeOHZOZJcBxL+ws7gqjxTPCP7ikuvfxDJehFuUwVN2l6wCiVO7U88Z
         N+uQ==
X-Gm-Message-State: AOAM532OOU6cDTZ/urtYWm40Oo/rGf3flDaSs6GFgQFQRPdShC9pUROR
        ioxelwMJgpdC9BFtS64Z0ByBhvB1xB44iKqhwrU=
X-Google-Smtp-Source: ABdhPJzUOqM0cdAG6lTeMB7+Cy6JncUEPYIWVW3q85coJDmseYd3BzN08HSClV4qZn+/mny5jEsiDn6jpB9fe/xOE/M=
X-Received: by 2002:a67:d20b:: with SMTP id y11mr5626149vsi.3.1635621599835;
 Sat, 30 Oct 2021 12:19:59 -0700 (PDT)
MIME-Version: 1.0
References: <20211030163005.5734-1-johannes.schindelin@gmx.de>
In-Reply-To: <20211030163005.5734-1-johannes.schindelin@gmx.de>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Sat, 30 Oct 2021 12:19:48 -0700
Message-ID: <CAPUEspjD_aVXdRrRAxoDG8p4tykJbgLAdknBX7aUY-QaSR1sSA@mail.gmail.com>
Subject: Re: [ANNOUNCE] Git for Windows 2.34.0-rc0
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Also "fixes" the issues some were having when using the default vi
editor (against all advice and common sense) and that were more
visible when under the experimental Windows Terminal[1]

Carlo

[1] https://github.com/microsoft/terminal/issues/9359
