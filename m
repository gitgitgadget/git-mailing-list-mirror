Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 064761F461
	for <e@80x24.org>; Mon, 19 Aug 2019 14:16:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbfHSOQ4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Aug 2019 10:16:56 -0400
Received: from mail-ed1-f54.google.com ([209.85.208.54]:39865 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfHSOQz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Aug 2019 10:16:55 -0400
Received: by mail-ed1-f54.google.com with SMTP id g8so1813750edm.6
        for <git@vger.kernel.org>; Mon, 19 Aug 2019 07:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=pV44DjlJ83QKr4znWcK8+1gFR6AkDT+adiZcQ/jGt1I=;
        b=JsqlvLn50gsR4HQ054RnH42Bbo1xtWU6TBdA1+HY00uG5EeYxapI69AKo+LkJu0f4i
         Fl5hwgn8hRycWn/h3vayK/9kTio6CedhN4UchMXCs4XNTWF7lWURPMCWrf2iEwb4Ov1r
         GXGh/WmCARFHF3bHMw67cnphVeYl4hkNj4TzsCF4WAXhADbf3gViPvVKqxUsssjZBmrD
         w6mrKdKYBge30Q+iNqd4Fmwc5gYEpdOLcuqqVK7VndSkWgEHQsu11mpe6lz/B0z1RCib
         n11+NXgrQ24+KHpAQIjw0FXWjUgcWyuC4hwIjyLjPNsKydvMr1JhjYWYSjcRyiMGZKCb
         ULXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=pV44DjlJ83QKr4znWcK8+1gFR6AkDT+adiZcQ/jGt1I=;
        b=GLDB4nLcnwlDk4Ze3d0x/Rf4WYL7JCSzToJLzY37iwZWUucYikCLW3+lKqzdPZQOH2
         kXFOUQOplsjfbg/Cb2rcSwP8YkpwZIFeu9LN/RRcbIduWo78d8uNUDd/0O0Fg5aW/mu1
         AdhTz+8cSPFFsEI10tNmFerywS/78fYXdoC/7i6VF5mHYh+jpa4HsufcedRkwOFE+czC
         eitmK+m3k91Maypz21utdkLG3tHuTedJMSHCTrNK7XYYd5WWZywOyaur/dCYDG8E6y9Q
         UyMBfbRq4Sp4tEH5Tf+LchNxWa6ewc8qN0P0X8BG0AV3/LN+m/QZ7+R+pYemtcwtA4JU
         EYpw==
X-Gm-Message-State: APjAAAXhMyKE8xI5pEcS8FsRPCVVhiu7q359/CSuQpuX2QCodqzJ3RJx
        e+5zUH2rrb/9w3LtBQBqv0anw4AYNktMvfII07/m64xq
X-Google-Smtp-Source: APXvYqzmJ0pr9w6xvIFZAxSWd1cZXuuy5mdSJWxdkfpABNKnCSL6CtoUCXFcXfGC8PhE62huucT+RACuuRl5vmIFGSw=
X-Received: by 2002:a17:906:3c7:: with SMTP id c7mr21697911eja.187.1566224213260;
 Mon, 19 Aug 2019 07:16:53 -0700 (PDT)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 19 Aug 2019 16:16:42 +0200
Message-ID: <CAP8UFD0bGOUmhRZx9x_-PLtF9MZg1xSAYoT=77k0HoBgT_DX_Q@mail.gmail.com>
Subject: Draft of Git Rev News edition 54
To:     git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Gabriel Alcaras <gabriel.alcaras@telecom-paristech.fr>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Carlo Arenas <carenas@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Bryan Turner <bturner@atlassian.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone!

A draft of a new Git Rev News edition is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-54.md

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

  https://github.com/git/git.github.io/issues/387

You can also reply to this email.

In general all kinds of contribution, for example proofreading,
suggestions for articles or links, help on the issues in GitHub, and
so on, are very much appreciated.

I tried to cc everyone who appears in this edition, but maybe I missed
some people, sorry about that.

Jakub, Markus, Gabriel and me plan to publish this edition late on
Wednesday August 21st.

Thanks,
Christian.
