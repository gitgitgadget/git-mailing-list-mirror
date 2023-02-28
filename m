Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A339C64EC7
	for <git@archiver.kernel.org>; Tue, 28 Feb 2023 23:59:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjB1X7E (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Feb 2023 18:59:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjB1X7C (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2023 18:59:02 -0500
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B604A31E06
        for <git@vger.kernel.org>; Tue, 28 Feb 2023 15:59:01 -0800 (PST)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-536bf92b55cso320268717b3.12
        for <git@vger.kernel.org>; Tue, 28 Feb 2023 15:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yuFDTfZXdhNJCTadVl6xrIMFZX3mDIHMFMjZDQWBp1U=;
        b=kc6R6TSl9L7ybti7krThNlMMEOTfk8WODtlUuUHmf7Q4Wxm/VqJxEuNX7gqrLWz4Eq
         CTkZrGWpICWLgKevC6hBO8E+yJ06bt2D+wz13t140b7YTQqysi/SGNeI0zrtMY9L0oVb
         z2I5Yd0Xnpp2L7/7hU+nFBKwnubyuzcV8E5tNczwYybGm5zMTfP0s7Zz0zRgklRp6fuN
         9osoqzQ5A8Mfp2Q8jzjjySX2TW0aNBgOISjjPVP3AbhceWrOrcGLCSP6GA/5P2YKsx+J
         32V8mPzgZHNJEaAMHWSE5Uv4Uy1lTU+JHLHZxxwL2f4ssUG6kmryX0XVylgxl8Gp9ht9
         EbGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yuFDTfZXdhNJCTadVl6xrIMFZX3mDIHMFMjZDQWBp1U=;
        b=zNkIzNxFh3z8/lrfmkdyfb/QcI3gDAgYzCtjkkPgSJRp2jkfjumLglvlZUqsto2tae
         KCvwhoauzSKUXgm8Lpldxy8az/X8sq1dByCYzpeaJlfrVqAGVoMTO3J89GKEbj3xey+g
         8CWa9+xlwxMhRc6fBya59hfW4H4Z8zws0XukrdlbVY4hNV4dbl6A9GDJd90MQCg8CAM1
         5A8/dln/KsOTrE3aJKye/L5UJAnEz2D7yWAmkMLaxxoMsIihgidvTbijtHwMo/N3rT9H
         eAM5b24g0rc0QJHUMICEbcnv/2mBNmF4iJawen6Lmh0yiC5jODbc4pos9ZkznpF72wgp
         nyiQ==
X-Gm-Message-State: AO0yUKU4X/U+VSNFlNtGwj1aIVVc5jtE4f6kSMIYUYaAMYBUCJbwz6La
        n6E679LLBO5mOpJ5D6B/93ww2zy8HwCumryckzj8n/D6vao=
X-Google-Smtp-Source: AK7set97PFn8C/UooT5hw97hkGWWdpjr3ldTVuGbwt19xSuqkA1FYw3ye7WUE7MqpXUwNgqxlIWMqirFENu9ljr+nBI=
X-Received: by 2002:a25:900d:0:b0:a1e:de8e:76b with SMTP id
 s13-20020a25900d000000b00a1ede8e076bmr2393028ybl.1.1677628740701; Tue, 28 Feb
 2023 15:59:00 -0800 (PST)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 1 Mar 2023 00:58:49 +0100
Message-ID: <CAP8UFD2UsPXffkWtgvVYE_1ZQvYnMkqRcXjAFHrC_vtBC8-FWA@mail.gmail.com>
Subject: [ANNOUNCE] Git Rev News edition 96
To:     git <git@vger.kernel.org>
Cc:     lwn@lwn.net, Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Erik Cervin Edin <erik@cervined.in>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Bruno Brito <bruno@git-tower.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

The 96th edition of Git Rev News is now published:

  https://git.github.io/rev_news/2023/02/28/edition-96/

Thanks a lot to Bruno Brito who helped this month!

Enjoy,
Christian, Jakub, Markus and Kaartic.

PS: An issue for the next edition is already opened and contributions
are welcome:

  https://github.com/git/git.github.io/issues/631
