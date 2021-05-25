Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E3CC47086
	for <git@archiver.kernel.org>; Tue, 25 May 2021 20:02:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B9BB613B6
	for <git@archiver.kernel.org>; Tue, 25 May 2021 20:02:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233074AbhEYUE1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 May 2021 16:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233038AbhEYUE0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 May 2021 16:04:26 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D78C061574
        for <git@vger.kernel.org>; Tue, 25 May 2021 13:02:56 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id p24so47996210ejb.1
        for <git@vger.kernel.org>; Tue, 25 May 2021 13:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=rtMlUitFRBZsRz5yvBpPsO1oDbqYkaCPHuHMNXxP93c=;
        b=qnt4Nbl6qENMac0q/X2zcd2Z8qte0TRdruH2w2NOOf8+quOy7yVGhzidmKk1GgOYjb
         B7RiPXRw0gl+Bmy02M5ayHWWLI1UisqSlXMvvn0R50oCUapSYamJEjSLIQMMWFlT/GiK
         W5xBYhFC7R2vi3944A6IOlcqnpELcVVHCBxrCqJpZtc2trTtxUwgnHn2lRsDNPmNVEk8
         ZQC6+38ckz+3FobBhXizsYXTo5HVd/TMVjPgBnXh/F0BfFa3neih9qZNwwff9Kcp35VV
         VRSsEx5lXT+n5BAvXRZ1TQhdzrWzicFDG6MDv28rQF+mktdKzOpkRx6FJH0D5UML3BMe
         DizQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=rtMlUitFRBZsRz5yvBpPsO1oDbqYkaCPHuHMNXxP93c=;
        b=p1IoboHISsL6r0RjRyVwUc6J5T71aFBOu56FIJTMKXI99Hvjt+L4nOaVVOb7GNYqjE
         mAS7SvhEf5f0aSejC63OPKKP0mQFvhIyQdCQ4vm0JH2PNXhlAGPBLJ/R3V3q66R1Jdgg
         FjGFI/QVrHo+MbLKyIpi4ZbqL0vJvOVxLa7ldB9Zc8WLAmUJy9nYtK9rf2a+y47uP32Y
         Ytc408ck2CzuAnQcRUaJN9TZ9uBv2m6hFui8p9WZYiYM0h8nMhyNGe3U9XlTcO+ffjVu
         7BUB0+/52lqVoW6Bg8RsmjC5juRvGQkN0QzEhNOdRzGjCqyAZoHpamBl30Ondzy+meu9
         Rbyw==
X-Gm-Message-State: AOAM533itgJdd6qfNOXx75Vb71xtmQn92RD5gaI+zrfo6KNxoxF1WQyc
        dKU1s/izj+U2Uw6Nm9DwUs4sp9l2OlQUVVKPpNK0t2lMThubbg==
X-Google-Smtp-Source: ABdhPJyum1pUeuGmnAKwjCoM/uHOZjEA79wtLt9uSB4XzB2XU8it2alS+DO3QPMzzFQ/xmle81BDd1Z/5CtzeITzQuU=
X-Received: by 2002:a17:906:ca4f:: with SMTP id jx15mr17589014ejb.160.1621972974869;
 Tue, 25 May 2021 13:02:54 -0700 (PDT)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 25 May 2021 22:02:43 +0200
Message-ID: <CAP8UFD3i99kT45gpn7NhgboFDS5OoVDizYJCP7BzuFA6iu1vOA@mail.gmail.com>
Subject: Draft of Git Rev News edition 75
To:     git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Taylor Blau <me@ttaylorr.com>,
        Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>,
        Hariom verma <hariom18599@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone!

A draft of a new Git Rev News edition is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-75.md

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

  https://github.com/git/git.github.io/issues/500

You can also reply to this email.

In general all kinds of contributions, for example proofreading,
suggestions for articles or links, help on the issues in GitHub, and
so on, are very much appreciated.

I tried to Cc everyone who appears in this edition, but maybe I missed
some people, sorry about that.

Jakub, Markus, Kaartic and me plan to publish this edition on Thursday
May 27th.

Thanks,
Christian.
