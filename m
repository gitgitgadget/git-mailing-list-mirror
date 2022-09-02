Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 235A9ECAAA1
	for <git@archiver.kernel.org>; Fri,  2 Sep 2022 21:31:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbiIBVbd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Sep 2022 17:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbiIBVb2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2022 17:31:28 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F609EF015
        for <git@vger.kernel.org>; Fri,  2 Sep 2022 14:31:27 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 130so4891364ybw.8
        for <git@vger.kernel.org>; Fri, 02 Sep 2022 14:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date;
        bh=izst4J6NRxlepDZ+gV7agy2rngMArI1yNlbFgdxru3Y=;
        b=f95gQ8m8cCcGGUDIgFMclAIP2PGSdgsc26BZSpNDdBCb6YXRn7jcYijYVzlSgi/x9L
         B+iECFuYGCHth39g3Yzbnse+jVbsDUJtpOVz7cuWBtH37TdzerJAXyMoxvNn28lNaLbs
         sHw9is3S32PoHcqjEugWdjLK70ILcfUIi321/TvUk0tUYfFNB0UeSQUvgEgy+AzRFOgk
         chf6mU83rqZ9nYNg3amW0G/nuC+DBL7dQsYc3hLmhhcf4zePcbXm+dmNmlilqaHj0ab9
         hbJAxogHCpbovZEHNOVWy35CnENkiScMo8YAPtGK9bgCEEKIua/3B8+iFqxslAW6Sp11
         giTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=izst4J6NRxlepDZ+gV7agy2rngMArI1yNlbFgdxru3Y=;
        b=MeM+4ywfy0+Lx+SgJVKSyvtzJJVVk7nP36Y0gyAODdmHMfMyJW+jl0X3GMbfWdEI/Z
         04P8qwUxnb8e3sRVKDT4MLD87PQoOb9jGkRlw54/hNUmc0Ww1qtoKHh8cuaDAircsOFz
         VkP4+t8P+ceEKtE551rrqnu9oBfW+3W2rg2GyN6G5Hvspz2ipvnTxUqtMo0jIZj2+yWi
         vX4VHCXBzD3RtV9vdywBTkCeA0qrvQQOJYVjKrPNBsqDr3h5DjaCDHc4GwusuwAELPBj
         /dVQYBE0zo4W8rYLpyuvucPUZTP3ZCWJsk/VyDrpkC1HTUBXrWrOn7QnCBBy/X23qcXn
         slPQ==
X-Gm-Message-State: ACgBeo0JLXa9PZKNNObpWqIXuZqRvfFgwQfT5t9Bdc5sfZgQ3sM62/XC
        FcdO0o6vhhKKLmWliyLnL2/bSNTxXi8QOKZZ+wom09YMH5FnFrs9
X-Google-Smtp-Source: AA6agR6hHJ+vgWsebv0KX3u4UJ/YxxfXHg1aum3jBupY2ZFu4KI+VHeS56mOvcl6fEk70Z5In2pF0HIchol3LEPz8C8=
X-Received: by 2002:a05:6902:2cb:b0:684:aebe:49ab with SMTP id
 w11-20020a05690202cb00b00684aebe49abmr25487660ybh.242.1662154285803; Fri, 02
 Sep 2022 14:31:25 -0700 (PDT)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 2 Sep 2022 23:31:14 +0200
Message-ID: <CAP8UFD2MDhwLd7yevK721Ln_JAeb2J4tti9io5rCdVFxZsdKPw@mail.gmail.com>
Subject: [ANNOUNCE] Git Rev News edition 90
To:     git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        lwn@lwn.net, Glen Choo <chooglen@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

The 90th edition of Git Rev News is now published:

  https://git.github.io/rev_news/2022/08/31/edition-90/

Thanks a lot to Glen Choo, Carlo Marcelo Arenas Bel=C3=B3n and Johannes
Schindelin who helped
this month!

Sorry about the small amount of content in the "Other News" section
this month due to vacations.

Enjoy,
Christian, Jakub, Markus and Kaartic.

PS: An issue for the next edition is already opened and contributions
are welcome:

  https://github.com/git/git.github.io/issues/598
