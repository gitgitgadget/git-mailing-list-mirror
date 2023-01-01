Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85C27C4167B
	for <git@archiver.kernel.org>; Sun,  1 Jan 2023 20:37:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbjAAUhz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Jan 2023 15:37:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjAAUhy (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Jan 2023 15:37:54 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE2962AC8
        for <git@vger.kernel.org>; Sun,  1 Jan 2023 12:37:52 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id j206so28643796ybj.1
        for <git@vger.kernel.org>; Sun, 01 Jan 2023 12:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0DQtwP4+GJ3qTt2uRvyj/50o2Rm9nldKgqlQ92QQvb4=;
        b=MKK+JMKDOIh/MHSCTbCsMDBQPJm2vMrcV3h4gL6sO9ow5MMnV2WzFg0+CmkNW5eQcw
         wjhFTej2DtLFtuoDoXNugvb3q5H2XSIcu46EA8xt0LdjazK2zg+7B5o4osnFuhkQhOy5
         fOf6WCAPOTOa6Ff91eoKfE7drAWlyBgG4bwV6/QogtqkfIXrdaH6PjKShGOzJmoRtPNo
         FW7+0q6cRMr9/z/wBOovVDYV6o3wmC9lo5DkQOzgmaWtCEpgsnJbKP/z+zpQEbOjzf6B
         AlICtXHKqCBMYTAQhGph2AY+r+6mRKSD3HXijU+eAsQ/0vb3weg5kjT7/5bniCmJysip
         iupQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0DQtwP4+GJ3qTt2uRvyj/50o2Rm9nldKgqlQ92QQvb4=;
        b=O5mrxWsEFb1w1ZR3xLQEVBxkw3uH8TrbcACuapHNeIPOqz9yBDwhv3u3EI7IVgmYvd
         nGY1AN410ahXmKKiAnmsHCgetqQbc4PcFwHEhVQkGz27I9dQKsf1zvzO7HmzEHAYnlIM
         91zSKfMgKP327wIcFepaNQ6GM/TBP6FrF5N7j0/F0lRr+LUSCRBsSIl7bFmLHIdYyq5e
         Y3AG1Xiih0RuoWp2MyvuDCDDiMzWSo5EF4n8PF3MDpHArAZxeHan3zj4YAZXWypnyjsb
         N4gYp9M5WUm0wSEeuWAmlxs8AN5OhN8pV05sJ+JzsDPqXOcQFwd3gxM6yrv2I6qv+L99
         +kSA==
X-Gm-Message-State: AFqh2krXz9OODv5rWB0B1D9u+ZuslQ8amFtBSf0weAfJUScONbs/HPum
        NKwdOpXf/lrHeDw+WJuLpbk+vw2k+D7arrY8OKeqjisKj1w=
X-Google-Smtp-Source: AMrXdXtZc6x6MWJV4omrUYZgjH32rWAX9oFa9MQ5/vEQQiZ3bPTYLwx/XK+SCgi1GWU/vwgz9GiNJkV6569kXAIaAIo=
X-Received: by 2002:a05:6902:3ce:b0:6f8:92de:92e3 with SMTP id
 g14-20020a05690203ce00b006f892de92e3mr3775619ybs.105.1672605471944; Sun, 01
 Jan 2023 12:37:51 -0800 (PST)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 1 Jan 2023 21:37:40 +0100
Message-ID: <CAP8UFD2WnuwfbD3Jte-YrrfuqYeypvaa2YjXX_On+K5ktS=B+g@mail.gmail.com>
Subject: [ANNOUNCE] Git Rev News edition 94
To:     git <git@vger.kernel.org>
Cc:     lwn@lwn.net, Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Martin Englund <martin@englund.nu>,
        Philip Oakley <philipoakley@iee.email>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>,
        Siddharth Asthana <siddharthasthana31@gmail.com>,
        Mirth Hickford <mirth.hickford@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

The 94th edition of Git Rev News is now published:

  https://git.github.io/rev_news/2022/12/31/edition-94/

Thanks a lot to ZheNing Hu, Philip Oakley, Junio Hamano and
Mirth Hickford. who helped this month!

Enjoy,
Christian, Jakub, Markus and Kaartic.

PS: An issue for the next edition is already opened and contributions
are welcome:

  https://github.com/git/git.github.io/issues/623
