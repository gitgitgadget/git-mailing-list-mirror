Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 715CCC05027
	for <git@archiver.kernel.org>; Sun, 29 Jan 2023 18:28:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235115AbjA2S17 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Jan 2023 13:27:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235056AbjA2S14 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Jan 2023 13:27:56 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B077618F
        for <git@vger.kernel.org>; Sun, 29 Jan 2023 10:27:53 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id a9so11650254ybb.3
        for <git@vger.kernel.org>; Sun, 29 Jan 2023 10:27:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PCGZr+Ii+wBeU950IPeELeDHZmAKkuPWv0wS2lFgLYU=;
        b=ppnGJwwBN93F9I5b2LoSb1XaFttkzYJ/T+qHVQ27sEbwyp5YkyYfF8R8FY7wHy6Jl1
         9RUsp3usde37FVDZ2F0pAYlAY293H+PObljuMKWkYQkeMuLweoqkN6080McINz5ZNkDl
         2c+duKB9jfdUMfC3qi3WBy5K+N5//QJXaIRKKdc7NQyj3mMBLsJUfJm3gDRT+29eZ4vq
         KxM3pz1/jRaY9u8tHmwHUlOdEzGd26/akJ9Facmvs8aGZ250a8wdiy9T8IwxzvQXqXvg
         4U9iAtHc1yHMXQUH6OxveFDaxiERMBLqx8nqgb31elRoIYO6z1uAQ6ytXIVpx16cCLaq
         /kjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PCGZr+Ii+wBeU950IPeELeDHZmAKkuPWv0wS2lFgLYU=;
        b=4HzYgK7ZskPejZKsuRANT8qSno6bGJd9yZGpf+ws8/nHNS9tfdvJI1mNvRRcVBtanG
         RXxNxf0K+zS/CGZ5sxdCC1HdWcSPvyg2yKF4T3SXP1JidYbciaOvqwstZU6iIU5lZGbN
         KxT/pCo2Ndzq6eUce29QeVghc7dhattXiwz6KvuoVjHglyWnpOX9KKERYDAfZzapUqB8
         sKXvdfO1UqRGMVBv0FcSawGm0IopCIztlbIgzBWJwopySqapmbTWZANjI3JJJBooAL1u
         B5O7+xVYR8pe/DGmM2qVdngfvQw+getydNYuw5z+WDq8c6Hwsx5WHqG4CMpBOAxYtGLl
         tESQ==
X-Gm-Message-State: AFqh2krnZS/MPm45/W2iLNC1vSyoFD0lA9sQniOKOj6+ivpbJVH/Rl2l
        e74qff6yX5l4uRSmvczKZVuY2jRW0usVolCVPgWgy8p8f7Q=
X-Google-Smtp-Source: AMrXdXuM1BsmyPZCW2+SirkHKV9UelRrLl0w9a0vHeFQ/cy3BFqPCvwuaLAWd3leuOYtHtb9unjYhDUbs7WLeFUiink=
X-Received: by 2002:a25:2e41:0:b0:802:4849:af69 with SMTP id
 b1-20020a252e41000000b008024849af69mr3297863ybn.13.1675016872408; Sun, 29 Jan
 2023 10:27:52 -0800 (PST)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 29 Jan 2023 19:27:41 +0100
Message-ID: <CAP8UFD0hhCKOWMH=8hhFiZ+MHg7igphx6GzHP5ecZa1XJq3EuA@mail.gmail.com>
Subject: Draft of Git Rev News edition 95
To:     git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>,
        =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>,
        Teng Long <dyroneteng@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone!

A draft of a new Git Rev News edition is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-95.md

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

  https://github.com/git/git.github.io/issues/623

You can also reply to this email.

In general all kinds of contributions, for example proofreading,
suggestions for articles or links, help on the issues in GitHub,
volunteering for being interviewed and so on, are very much
appreciated.

I tried to Cc everyone who appears in this edition, but maybe I missed
some people, sorry about that.

Jakub, Markus, Kaartic and I plan to publish this edition on Tuesday
January 31st in the evening.

Thanks,
Christian.
