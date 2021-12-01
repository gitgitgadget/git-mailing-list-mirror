Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B333C433F5
	for <git@archiver.kernel.org>; Wed,  1 Dec 2021 21:24:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231824AbhLAV1t (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Dec 2021 16:27:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbhLAV1t (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Dec 2021 16:27:49 -0500
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9F84C061574
        for <git@vger.kernel.org>; Wed,  1 Dec 2021 13:24:27 -0800 (PST)
Received: by mail-ua1-x934.google.com with SMTP id r15so51935585uao.3
        for <git@vger.kernel.org>; Wed, 01 Dec 2021 13:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eb5MkduL+kBFwvuASq57A1HOUVtdYoV2Tr/oAR7pNd0=;
        b=YzEHnyUs5TH9UiPGCxEgYtn5L1uMcIQ6KDFCknGiQpOP0MYmlBRE+Go0IT+86PWuOg
         0MsJpmpkrLpoOBOCW++9ydlN73gMLsR5MOB1X6wVEcscuX0dAVghKzYEFJsV6ENGl7FL
         dGNlG2Zoiy2LMYVLc+Tq8Lk2unvOcd61XcATqxo/0M94aTaU9H2gdt9OTi0E5iQx5dY3
         pyCJ6ePY+LSxNRqmmZUFq8cc2jSkfDE/DRaozKJRZsTyqn+Waoibft55Z+mLOXrkp/Ah
         FEIclQHfidA/4hkwnWhv39qg2BFiESQMsiD1HRjJ9h/69/HN2ZBKiV4AfUAJpZ1574Ag
         GkNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eb5MkduL+kBFwvuASq57A1HOUVtdYoV2Tr/oAR7pNd0=;
        b=AifQyiWndOXu5lztoApmvlUDHgUkJBgCxf1+Wr5BKBpG1J/gX9pJSJJ5kydTcKwKV9
         MvWGO4T4klYJdg9819mM7jXp9kbDV0H9GkWM6KD1akI7oHWXWwijVkyqhgIlXMiRmylD
         i6uDwVANOcpAPbKrI9MfB4NZOgKqotUN/Emxfx/2O6Nsftoet4FrLIt+hTfT4g7Aawfz
         9CphGsndGIKkF17rP0onVAx+rB8msju9Xt5mXtDZDVRkasR5addX4hfgxT3+Xwl8ssL2
         Hyaz+34qCEPgVNMxnubhToILAen+1XKewrLtj4Jmkqa009arwi4CtXC1rOj13jsDGfC8
         1fIA==
X-Gm-Message-State: AOAM532UO5LMALFOhXAKnzID+lkQrVAXWvvnotto/n2xiSF603HdL1bo
        GpBV5Pi2AxTDJcAoQK2Ox55k02hieLMlR1hJnp0=
X-Google-Smtp-Source: ABdhPJwRpPf0/a+7vdweu1fAJ9yv+wkfbiVSYoBLHbHtoWjO7rsRBmCpzp9xzSO+7ra7SyM8ToVUgUj6PWDIi+LzUuE=
X-Received: by 2002:a67:bb11:: with SMTP id m17mr10488852vsn.5.1638393866783;
 Wed, 01 Dec 2021 13:24:26 -0800 (PST)
MIME-Version: 1.0
References: <pull.1087.git.1638281655.gitgitgadget@gmail.com>
In-Reply-To: <pull.1087.git.1638281655.gitgitgadget@gmail.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Wed, 1 Dec 2021 13:24:15 -0800
Message-ID: <CAPUEsphxCcfOgPQP9ci6sSn87g5=w+8kjh21=QywTX=on5vTdw@mail.gmail.com>
Subject: Re: [PATCH 0/2] Use the built-in implementation of the interactive
 add command by default
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?U2xhdmljYSDEkHVracSH?= <slawica92@hotmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 1, 2021 at 12:40 AM Johannes Schindelin via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> It is time to declare this implementation robust, to use it by default, and
> to start deprecating the scripted implementation.
>
> Johannes Schindelin (2):
>   t2016: require the PERL prereq only when necessary
>   add -i: default to the built-in implementation

Sadly this implementation has a few bugs that still need fixing, with
at least one IMHO being a showstopper.

The way macOS implements stdin (through a device) it will always
timeout in poll(), so escape keys that are left in the unread buffer
and that could match some of the entries will result in the wrong
entry being selected.

I have a series[1] that reimplements this and that seemed to work fine
in my tests while making the code simpler, but that I didn't
prioritize (and wanted to clean up further) since I wanted to
prioritize the EDITOR fixes in the same area.

Carlo

[1] https://github.com/git/git/pull/1150
