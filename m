Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DEE7EB64DA
	for <git@archiver.kernel.org>; Fri, 30 Jun 2023 20:13:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbjF3UNK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Jun 2023 16:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbjF3UNI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2023 16:13:08 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5CD213E
        for <git@vger.kernel.org>; Fri, 30 Jun 2023 13:13:06 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fbc0981755so22411035e9.1
        for <git@vger.kernel.org>; Fri, 30 Jun 2023 13:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688155985; x=1690747985;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KX0EmDi0LTf0q2vduPINQdJ0O5pas3gVuU0mnNNW+J8=;
        b=EneN0Q2wBMyZF/LRqiKopfPgrRqrfiyfh3owrKVppF34GwmmU7HYMJUKLylzZZAgHq
         ucTqYY0i6OLPX1wb5ySRohZumuj7hC3TEddulcZwG6lIZHFFMzc0SLO/KiSOyo4a6w/N
         xYlQ+7lZqoUwNNxPhid2wQ01pnUFv2wvuNKEupcbSqw8lOhoDbhQJgor1vBp/0yxWszg
         PIZVXu0Mxmd3OmuzSczPUtLkAMYfWVychXRDOJkSJlIsOLMEA+5OGnpRlV5aiTmqyX1h
         /PJaQIb6agjC20T2MQSMtSm0wBDObftjZk8HJXczonDe3RHTBZlT1S0kKcClVEwhSF2H
         gH+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688155985; x=1690747985;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KX0EmDi0LTf0q2vduPINQdJ0O5pas3gVuU0mnNNW+J8=;
        b=aozBNTsxzvJ+MVFIzj3nsOpAQa1D3rVoFNd8FLZ4xYhvrpNQ3a8+XyYz9AAdqmpdH9
         0CI1nnIW4NU956UPW5ya0mEkPDQRFZv8tfgxbYdPfFGFbopaROztmrSuSwSYyFmTzv4b
         KI0ZuCkVmHVFJzhaaP9C4gIzj0mk1IlcmcRHTdQpSotDksHxw0MfvwaeHRtM9BJAAcWI
         z0T3aWa1KSqv9nq9hKyCc8J1Tz5rrJbM471mwNbYhawef/TvUeSdil2BCvNWSNSdp5iE
         O6U1BVOfG1Wb+JRzjEOo5qoMstw99k80c90oeKvFTCVWpjLX4h5QkEvnkndtr/VsJuB1
         eF2A==
X-Gm-Message-State: AC+VfDwox+aL+hMPNoKOC4ccdO2+MVdtgQjSMdhZ1hFBnbRLqa68kRfn
        e5mNS9ynEiq0iNOiMB6cu0/JnUCF5ukIJ5bjoddnK5TlYw8=
X-Google-Smtp-Source: ACHHUZ5SjUBrA2upgAnVMeDHRq7HxPoMO7IDmsk5AySgBY45aQ1FwJZjFGtTmWabSm/2eJoXsADlZjt5DNYUcvWXrMI=
X-Received: by 2002:a7b:cc82:0:b0:3fb:b008:2002 with SMTP id
 p2-20020a7bcc82000000b003fbb0082002mr2827303wma.0.1688155984634; Fri, 30 Jun
 2023 13:13:04 -0700 (PDT)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 30 Jun 2023 22:12:52 +0200
Message-ID: <CAP8UFD3GX8or4bMf=2sBnpdTs4P2G=PdwRf3q+r2CLfNswTXXw@mail.gmail.com>
Subject: [ANNOUNCE] Git Rev News edition 100
To:     git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Victoria Dye <vdye@github.com>,
        Bruno Brito <bruno@git-tower.com>,
        Calvin Wan <calvinwan@google.com>,
        Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>, lwn@lwn.net
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

The 100th edition of Git Rev News is now published:

  https://git.github.io/rev_news/2023/06/30/edition-100/

Thanks a lot to Bruno Brito and Victoria Dye who helped this month!

Thanks also to the readers who took the time to take the Reader Survey!

Enjoy,
Christian, Jakub, Markus and Kaartic.

PS: An issue for the next edition is already opened and contributions
are welcome:

  https://github.com/git/git.github.io/issues/652
