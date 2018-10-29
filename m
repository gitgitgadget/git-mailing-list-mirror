Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A3A11F453
	for <e@80x24.org>; Mon, 29 Oct 2018 16:19:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727669AbeJ3BIw (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Oct 2018 21:08:52 -0400
Received: from mail-it1-f179.google.com ([209.85.166.179]:51783 "EHLO
        mail-it1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727516AbeJ3BIw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Oct 2018 21:08:52 -0400
Received: by mail-it1-f179.google.com with SMTP id y123-v6so4028949itc.1
        for <git@vger.kernel.org>; Mon, 29 Oct 2018 09:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vSBffKp5dQe2siIDvHTq8Jev5oF/gQq5RQ0wRg1D+MA=;
        b=P1+8vuJ2dR0N6lvEuTjTTr9UfBtREBSUWIWqZnqx9ejEvVYsd2h7iUbV0y9QErFU4n
         PY+Un/vTvb+9Z5PjawtZWEQ9lz0alJ1tBo+/CQnKYAtflINpAl9oyL3RFI4hI/fqfhSV
         OLlgJOHnaQBDUGEvQBUIfiaft2RzdJmIImhweS/Kt/y4ob1eIOa98TbPOXUrD7+faW8W
         PBbgoROiUgbf1gCw8f8dpxL462Io8LHtp8WpPd6BnZUEr0V9S2w8ii4KA33YHg5MjmCQ
         2EWB87/YwoZ8fgPdsmfoVtbquHcMIowxELf4djEeDVM4Z1H4jmHOr6V7wa1qvVHmWfNs
         Tnyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vSBffKp5dQe2siIDvHTq8Jev5oF/gQq5RQ0wRg1D+MA=;
        b=LoFFFvdHJ1Wh5Kd5XGudUTcBTJhSJ8OfK0vGvAy7TsorD6hsUxeEaqdqDmAh+f/XN8
         G0zCG1wtDGy83YdzNICK/DUg/ILbGT3KGdiVyGFb+czOS4E/SyJ1tCD9lQtXEjRcpz8T
         CilEpCO2Y6VtZM0952EZ3XYatWxFnSw4mC50AhijHMX8u7llNxDMOGjtRGilBCAQu9V0
         NDfkbbAxAx0/HronbGBTVdToOVt+FDdd0vdAbE3d0WQ1rzaUZ9By2hPEICVqlFQz44l5
         7FGA8fBa3bg/xA+TSswTzGC6XiOU67tqIaTaUDpbYZHU66Udt0EvKWRBF7aAm9m3mTLa
         2Ufw==
X-Gm-Message-State: AGRZ1gJ16Gvar5sD/6aISwOlPkVr4icVm4cJENSUMKw+c5NYyhtxEuf9
        tCPtFtVfsjO/nI//zFF9fagZOanioQQIg11aNGAGDw==
X-Google-Smtp-Source: AJdET5cWmKdoYgbbFPRANE1v7DnWIxYB4AqZttrxpdVUgm6XXi6Ln/BfIBugP5Fa3zucaL0zjbOACWb/kN7yvW59KFg=
X-Received: by 2002:a24:7804:: with SMTP id p4-v6mr10650806itc.123.1540829975131;
 Mon, 29 Oct 2018 09:19:35 -0700 (PDT)
MIME-Version: 1.0
References: <CACsJy8B=gxVMrZnr-BNp=VCHea8wpx+GCE4N76=vSGMnX2rSbA@mail.gmail.com>
 <20181028121517.GO30222@szeder.dev>
In-Reply-To: <20181028121517.GO30222@szeder.dev>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 29 Oct 2018 17:19:06 +0100
Message-ID: <CACsJy8CWkxfkOEzTBwuD0hyATuc+i3DWYZ2k+kA0CbxFhcgs6g@mail.gmail.com>
Subject: Re: t7405.17 breakage vanishes with GETTEXT_POISON=1
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 28, 2018 at 1:15 PM SZEDER G=C3=A1bor <szeder.dev@gmail.com> wr=
ote:
>
> On Sun, Oct 28, 2018 at 06:41:06AM +0100, Duy Nguyen wrote:
> > Something fishy is going on but I don't think I'll spend time hunting
> > it down so I post here in case somebody else is interested. It might
> > also indicate a problem with poison gettext, not the test case too.
>
> I haven't actually run the test under GETTEXT_POISON, but I stongly
> suspect it's the test, or more accurately the helper function
> 'test_i18ngrep'.
>
> The test in question runs
>
>   test_i18ngrep ! "refusing to lose untracked file at" err
>
> which fails in normal test runs, because 'grep' does find the
> undesired string; that's the known breakage.  Under GETTEXT_POISION,
> however, 'test_i18ngrep' always succeeds because of this condition:
>
>   if test -n "$GETTEXT_POISON"
>   then
>           # pretend success
>           return 0
>   fi
>
> and then in turn the whole test succeeds.

And this is something your poison-with-scrambling code does help ;-) ;-)
--=20
Duy
