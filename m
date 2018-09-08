Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 191471F404
	for <e@80x24.org>; Sat,  8 Sep 2018 13:09:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbeIHRzU (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Sep 2018 13:55:20 -0400
Received: from mail-io1-f50.google.com ([209.85.166.50]:46471 "EHLO
        mail-io1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726351AbeIHRzT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Sep 2018 13:55:19 -0400
Received: by mail-io1-f50.google.com with SMTP id y12-v6so3593134ioj.13
        for <git@vger.kernel.org>; Sat, 08 Sep 2018 06:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a/A6ITx26pIAECtveY9jYFMMJEhV0ZhqfPm6jOyD8gA=;
        b=Xrxbh1lAJ4XPzL84c8oELaoynXAN9H1i30cSO6ss35fqw/mBGjqC1SMKxYhaoxnocs
         CZlfsMPXFkZVeh5M2Jht0PSSoNcxnNCWFyLuquxtNVaZTSjGkhMu1vNVVvaXWK340TNp
         2ygpNIdU49oHHXCkYxfgUKAbJrKReRsyj7Uqibr9VZNHYbUeBaDl1MNdeTk8YjkEk5Yn
         6Bx8KYHtNW6dm/5usK9RAYf963phUrVEAO2XfEou9h1Z/c1SauWg7WSvtrZWXLTpUDqi
         1oO0wJUfxVXLD5ZZ2QqqWA1hqxfiQKp923ymQWCArVQ/4/XQy4madg7SRCSVjhHJF8+6
         qWWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a/A6ITx26pIAECtveY9jYFMMJEhV0ZhqfPm6jOyD8gA=;
        b=lfr4N+2aJmUUtDMefaTAqsXuMy4D3aL/gwlTgOGfyDyOPSQkHciBpxrUT/dnwWTZ2b
         acy6mJ/Ow1/u2Ln6kW7Da8TpESFxvRN8Aznj/yMNajF5WT6JWhKRluOHr1GdKYOhe37F
         HugEPCSU6HXDAYNQ8QEZlIwJYNZvfokRxDhNwJbalwkVrytheiJm1Iw4IAEkDYl8I0jy
         H9wievxQNnJ2Z9NK7OURpd3F62q7/4DHtgghEHfl1KfXaOEbSTXo5RUAX/+PvBosOoXT
         tfdjwpolO1uSaX5qW3E/a7No6WFUF4Y5EfZL4O8KDXQiCodcGVCcDlkuHl5wxjBLqdRD
         wxZg==
X-Gm-Message-State: APzg51Bca7I00ABylA1US0CyMm7UWSXlOGatdiCiVAhAuwXOnNSbasuL
        HPWZ7yC95bdGFl7Xo2zainkuwV+8BosXEqm6K95ZPg==
X-Google-Smtp-Source: ANB0VdaO/2RQywitaiLw7OrzSlkdNjJ7ez6ZQBiAmKIqOBh0SUQFQzkxOmx+4qL+dDLxhLQP72rlt8jNySZzVl7lQgA=
X-Received: by 2002:a6b:8fd0:: with SMTP id r199-v6mr9873011iod.118.1536412175532;
 Sat, 08 Sep 2018 06:09:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAJmnt9Yfed1W7F=C+dzac3AEe7nRq2cNP335MepTczboKJNoEg@mail.gmail.com>
 <xmqqbm99xngs.fsf@gitster-ct.c.googlers.com> <CACsJy8DymnKk+Xo6UPQyAsToNpkSX4Ae+jzc04+0qXrZ6bmb3w@mail.gmail.com>
 <CAJmnt9ZOCJfGFJ98xD17BYU1P=nRZ=eG16Oj5DjTMaF7H6WTvg@mail.gmail.com>
In-Reply-To: <CAJmnt9ZOCJfGFJ98xD17BYU1P=nRZ=eG16Oj5DjTMaF7H6WTvg@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 8 Sep 2018 15:09:09 +0200
Message-ID: <CACsJy8AMaUmWO2zi9+Dpr9_ZHE7A0rSs63h646w4uokyKRAdUg@mail.gmail.com>
Subject: Re: Temporary git files for the gitdir created on a separate drive in workdir
To:     hultqvist@silentorbit.com
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 8, 2018 at 11:28 AM Hultqvist <hultqvist@silentorbit.com> wrote:
>
> The bash commands are using a git and bash bundle that was installed
> in parallel with gitextensions(a gui for git)
>
> G:\Min enhet> set GIT_TRACE_SETUP=1
> G:\Min enhet> git st
> 10:40:28.881927 trace.c:318             setup: git_dir:
> C:/Users/hultqvist/Drive.git
> 10:40:28.881927 trace.c:319             setup: git_common_dir:
> C:/Users/hultqvist/Drive.git
> 10:40:28.881927 trace.c:320             setup: worktree: G:/Min enhet
> 10:40:28.881927 trace.c:321             setup: cwd: G:/Min enhet
> 10:40:28.881927 trace.c:322             setup: prefix: (null)
> 10:40:28.882930 chdir-notify.c:67       setup: chdir from 'G:/Min
> enhet' to 'G:/Min enhet'

Unfortunately this looks good. Whenever those files 'index',
'config'... are created, they should always be created in
C:\Users\hultqvist\Drive.git, not G:\Min enhet, including their
temporary versions. I don't know if there are any more changes on the
windows fork that could affect this though, I only checked git.git.
-- 
Duy
