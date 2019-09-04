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
	by dcvr.yhbt.net (Postfix) with ESMTP id F11211F461
	for <e@80x24.org>; Wed,  4 Sep 2019 17:54:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731712AbfIDRyl (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Sep 2019 13:54:41 -0400
Received: from mail-lj1-f174.google.com ([209.85.208.174]:39203 "EHLO
        mail-lj1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730323AbfIDRyk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Sep 2019 13:54:40 -0400
Received: by mail-lj1-f174.google.com with SMTP id j16so14365215ljg.6
        for <git@vger.kernel.org>; Wed, 04 Sep 2019 10:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DlU1oM3gGh8c93kwFtZjmNIfs+YQBdvUBpw1QPvqfNQ=;
        b=hX7a7ucjRoyRDxwcOn2xnLENrV39dS/Y+MiOIVL8J3IeARiG34uu6P19IsgCF9uU1E
         N+Nyt/U22xve5jy+sIQ2EpIQkRWAxP/mAUBU+jE8y/wbnBFp6GtGrTCfKdin4uoNhm+j
         LlWEwln2EF1jFMHq0RJDoG0YTvhojjypMV+5hz4nwlbYyQ5yflLrfw23PKf3W+9G7ULA
         yzbzDwTpvUVU3nkDMSaEtUhCFNzbCcRcr3mnqCLWATZN3tBy88vvzQa2B9y6gvU6CsCg
         X5bBAHC8AIY8s/nK2/6vOxT7AfvPXD3iHXAae1oTIsIkdZhyikpiDg/9oDmCVmq0q59Y
         eLUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DlU1oM3gGh8c93kwFtZjmNIfs+YQBdvUBpw1QPvqfNQ=;
        b=a3T2dEC+LsVVkDIaJRrM58T2tnvjYMCyDCernHcrpbbeZDUmeuGpwapqAbmGxew4an
         xcpDLv5brDk82x3yrOpisykOgIRzcmPYagn9GSw9p/eiOHXsSYvRoJlyhjKe0dOK9F7W
         pYopCZeOvTpSRbY5OLzxbeIaoX4p3c2zZ30zatmiUN4rKQ796dAvna8vufq/1gfVYrks
         feTUy/HBQjjaziOPwDIl2OoO4XuiTvTEnohTu6Ns6wv4u4iVHCMrKA9uW+xxXCCTtaY/
         tuJBZxVi67VtrpU3t6ar2vjmYrKnI4BGf7h+AHhmJebZiOauZYOGFqo1pFeXuXRMDlm+
         9FYg==
X-Gm-Message-State: APjAAAUzSeIEk1bOkxuKt80LtqcixA2N2Yy8tY7ID2uhgms5U6QUqTgd
        S3WJaahCFy0Nsg9iAKiY3M8uXnjYPZbpziVQCC3J6wKwximUCA==
X-Google-Smtp-Source: APXvYqxPu/xn3A6Rfg4BRoCgb6DGTWzjElHu5lN2y39YATgoJENu/fa5WNnBHlfnIm2KuTkG+1m1thfmr6YKPRWP9W8=
X-Received: by 2002:a2e:b16d:: with SMTP id a13mr1515539ljm.1.1567619678652;
 Wed, 04 Sep 2019 10:54:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAGr--=Jw4DAqTi3ROujtE=xBMYErMws6B6vhuXYMQA+5Q1ccow@mail.gmail.com>
 <CAGr--=JkNqcrcenp6F1_CHTun_9wPLVvEWGOFJW=ng=XfO+jHw@mail.gmail.com>
 <CAKPyHN3Zvf6gtKAq03s8AsguaOFG=g2huGRCTWmBVWioDBqFWw@mail.gmail.com>
 <CAGr--=JyJHTxtQWSnU7ivQ79qXcg7o4N142+5FSdre851xss6A@mail.gmail.com>
 <CAKPyHN3S-jLWmfHUyH9mCBPjHCEaBCbrkVQEKFqHv59U37=Kyg@mail.gmail.com>
 <CAKPyHN08Z_9oByA8ruKwwXRcAfYPU95JaMb=pqQWwGwPVG=_og@mail.gmail.com>
 <CAGr--=Jn87r_ySYkZmtqUBA40+fwdn0MbuN6_LNDO4mOWyoKTg@mail.gmail.com>
 <20190903124541.2p5hmknolh2dwqh5@yadavpratyush.com> <971bbc44-d3d4-552d-d18e-58a2315c6183@kdbg.org>
 <20190904174103.nrntgwv6zdqyjqsh@yadavpratyush.com>
In-Reply-To: <20190904174103.nrntgwv6zdqyjqsh@yadavpratyush.com>
From:   Birger Skogeng Pedersen <birger.sp@gmail.com>
Date:   Wed, 4 Sep 2019 19:54:27 +0200
Message-ID: <CAGr--=L0gp1XVbHzV9_rwYKFi9Xh-q+WFM2z_-=N0Ptj2aPFZQ@mail.gmail.com>
Subject: Re: feature request, git-gui: add hotkey to toggle amend/new
To:     Johannes Sixt <j6t@kdbg.org>, Pratyush Yadav <me@yadavpratyush.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

You could argue that A (as in "amend") makes quite an intuitive hotkey.
But personally I'm also leaning towards CTRL/CMD+E. The ALT+(letter)
combination is used to open a menu, for instance ALT+R opens
"Repository", ALT+E opens "Edit", etc. That's the behaviour on
Windows, anyways. So the hotkeys may seem a bit "mixed up" when
ALT+(some letter) opens the corresponding menu but ALT+A does
something quite different.

Birger
