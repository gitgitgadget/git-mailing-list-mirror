Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE4A6207DF
	for <e@80x24.org>; Fri, 16 Sep 2016 15:40:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757803AbcIPPku (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Sep 2016 11:40:50 -0400
Received: from mail-yb0-f170.google.com ([209.85.213.170]:35509 "EHLO
        mail-yb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754118AbcIPPks (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Sep 2016 11:40:48 -0400
Received: by mail-yb0-f170.google.com with SMTP id d69so53719143ybf.2
        for <git@vger.kernel.org>; Fri, 16 Sep 2016 08:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=2IpiMF+Ip7GpF4A49FR72Gbxy+8U/NTZEuG57OQWQTg=;
        b=e7WeplB1uP3E3ZM8GpCKUm1S/9lP4OOKc2A0qJv8qftXCbujaf7MEIWVGBKyJYng5T
         AZfBUU4DPbrEoeYldMls/1gp8m8X/AIId7XvyyEVpw4pQoYBuGWZJ12xdb0W/mpQgT8B
         sWieP5DPKt1a5aPdQrTj1Lq8w7H/xZImfPNdmGApZGhtudUx/pwWg0OL+Oh2/ML9A802
         dEcokbZHYQ7cavwWopIhQoVvwYmrzTdmDWLF0pR8uiq65zivGv4UL6x9O9pwZNBKhnYY
         aWPm4KEni9Grhe9z4gpBOeCoiWaxk5cqAnaZLr5olXzyCXDBbX6pYyWdYjwmiq7eDq2u
         1PUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=2IpiMF+Ip7GpF4A49FR72Gbxy+8U/NTZEuG57OQWQTg=;
        b=H8vTAm0USAwbY76VSTkvFJ4luTNTWi4hh7P/hn+0Kie08CW33aRzkxMufZTdEl7l6l
         Y4iZqrVVgci4fPuKwULw16CzIKueIr5zho3NQM56Hi1YkSnpyhcLGvBk3m7Y6JXGMiYy
         hoq7Vumg2Zu1yl3ihNVbvRb6V4fUL7obZKDi86EVYYuB2OY24S0Xd+xVuBEiiCwDTs+e
         BnDUpus1nk/BO8hgAB2uRbF13MqB1VwZEwDcXx+vlOzby7M+tYIHGtkWnMcawy7SkYm0
         bmflJjuszg36ZJRxAREURhyLZ8kWYtHVxCq+FUyMR45CyzDJq4gzv7YDuAMRZGW7vv6w
         Twlw==
X-Gm-Message-State: AE9vXwO+whkvSEg0IpFU2/pgLXFab0hKcJlDeOPOXDewyPWeWVFZxpu2WXbcjJ+pLFabxrwcrfPtU2Lhupb1pA==
X-Received: by 10.37.47.211 with SMTP id v202mr6887386ybv.194.1474040447681;
 Fri, 16 Sep 2016 08:40:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.96.195 with HTTP; Fri, 16 Sep 2016 08:40:27 -0700 (PDT)
In-Reply-To: <20160916141143.GA47240@book.hvoigt.net>
References: <20160915130233.GC9833@onerussian.com> <CAGZ79kZLdsKcf0t=dDB24VVe+V=uqQCW_VNQwSJ638m5Keu2nQ@mail.gmail.com>
 <xmqqwpidniry.fsf@gitster.mtv.corp.google.com> <CAGZ79kbYEqbr0h_0U=Ed-NRrsjb4XmznL8C45gTyJCVx+X-LTQ@mail.gmail.com>
 <xmqqsht1nhlh.fsf@gitster.mtv.corp.google.com> <20160916141143.GA47240@book.hvoigt.net>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Fri, 16 Sep 2016 08:40:27 -0700
Message-ID: <CA+P7+xpyZWqyqnNLaheU=bmyCr3wYFFO3XXKCf56E1-_-sFRAA@mail.gmail.com>
Subject: Re: [wishlist?] make submodule commands robust to having
 non-submodule Subprojects
To:     Heiko Voigt <hvoigt@hvoigt.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Yaroslav Halchenko <yoh@onerussian.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 16, 2016 at 7:11 AM, Heiko Voigt <hvoigt@hvoigt.net> wrote:
> How about just
>
>    git submodule add <submodulepath>
>
> ? I remember back in the days when I started with submodules thats the
> way I imagined submodules would work:
>
> 1. clone the submodule into a directory
> 2. git submodule add it
> 3. git commit everything
>
> Because that how you basically work with files.  So instead of adding
> another option I would rather like to autodetect that:
>
>  * its a relative path inside this repo that is passed to
>    'git submodule add'
>  * there is no .gitmodules entry
>  * and no .git/config
> ==> create those from a remote in the submodule
>
> Corner cases:
>
>  * If there is more than one remote we could tell the user to use an
>    option to specify which one to use.
>  * Barf in case there is no remote (not adding the submodule except -f
>    is used).
>  * If the gitlink is already there but no .gitmodules entry, 'git
>    submodule add' will just add the entry as if it was initially added.
>
> Instead of giving an error message that the submodule is already added
> we could actually be nicer to the user and try to fix things for him
> instead.
>

This makes sense to me. Possibly we could warn in this case, so that
the user knows that something was "off" but I don't think we should be
failing here...

Regards,
Jake

> Cheers Heiko
