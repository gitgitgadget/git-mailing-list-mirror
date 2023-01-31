Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5608DC636CC
	for <git@archiver.kernel.org>; Tue, 31 Jan 2023 21:19:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232147AbjAaVT4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Jan 2023 16:19:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232163AbjAaVTx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jan 2023 16:19:53 -0500
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D7CEC62
        for <git@vger.kernel.org>; Tue, 31 Jan 2023 13:19:52 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-50e7a0f0cc8so158598967b3.2
        for <git@vger.kernel.org>; Tue, 31 Jan 2023 13:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZegPfFIPwpUeHXMY6Y93XTFpLoo1F/eA6URJ/JPNSF0=;
        b=QsNzPJzaNTUJeqd5b7WC06d1vJ4547yQPit6cvz17vQwOAYLoRrrHYcWeSJv+DrSBr
         ICTVll49AJrrW4ASusLGNZg6dQYxMYwbbw9Sgr4AEJruThCE6QDjxPKQiFZAAMIioSfD
         k4iwqDWpRdGOAn+M+ZtYbHQx/+VHHyFE25C4d1XULFc45MkVeUX9Ir6fPQiJ7PUa3KZf
         gAofPT+gb6lXofN3DOCyf+aNRY+6Ow6dp2+DbXmbhKIx/kRgM2puOb1322FNSNihQvbV
         T1oH0uQTWGco8korfBVqbSMZ7EYBfZtuRBqwQbXFK07WcgqbDxyN2gjrpl5FqFoLdbnr
         g7EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZegPfFIPwpUeHXMY6Y93XTFpLoo1F/eA6URJ/JPNSF0=;
        b=6Zn8nZhg2rNLLvBZ/W507vKH+udVt7OrRnZFjXa8qsPlRtLj1rupgl+fVBBKenPxfH
         uiYshb2FGovRXlQcShqbOP6mnmafOKYGhkr96qIbyGY0nPT3Ug+hyA0xIVyD03xHD68G
         TOfSHvx7HWxdcuS3IjoqZWA7PtV4a+IcguD3wMaqmRjMpiM9jH4e6T+kPDr2B0JEKjEK
         nHefQjysQanqWE81GOqGd0VjJM2DMtjY2rN82NHXAQ7oQQq9y2zYQ28zgUXWN7gWWRLJ
         Jmb7fejnAYZzdlLgOecHAqW2z+Y3OWOYQwwwb0AiTaI0Vmg5O0C964D1f3a6kAd7BR2e
         ZXlQ==
X-Gm-Message-State: AFqh2kpKA3i5YIwEsB8mk8mxim/AkNZ6fvvrTh6UjUIOsL5KzCLXwnuv
        hBFYRtxobf3nkpNRlSIzohAGJPbD3xeUJ0Aj5YT0yJObiEw=
X-Google-Smtp-Source: AMrXdXuIWGQ9nS9r9cnQYVrSog0UQi+LT9sch/6l3w/0/Fr5yoJhWKo/Ew51uiDGf3tpxYlr+Ez47wIjBO0Bse3l6F0=
X-Received: by 2002:a05:690c:86:b0:4fe:3a3c:d911 with SMTP id
 be6-20020a05690c008600b004fe3a3cd911mr5391914ywb.311.1675199991139; Tue, 31
 Jan 2023 13:19:51 -0800 (PST)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 31 Jan 2023 22:19:39 +0100
Message-ID: <CAP8UFD06by1UNFxYLmNA6ysk+f-RqvmEgbdK29TpVywimYnEQQ@mail.gmail.com>
Subject: [ANNOUNCE] Git Rev News edition 95
To:     git <git@vger.kernel.org>
Cc:     lwn@lwn.net, Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Teng Long <dyroneteng@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>,
        =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

The 95th edition of Git Rev News is now published:

  https://git.github.io/rev_news/2023/01/31/edition-95/

Thanks a lot to Teng Long who helped this month!

Enjoy,
Christian, Jakub, Markus and Kaartic.

PS: An issue for the next edition is already opened and contributions
are welcome:

  https://github.com/git/git.github.io/issues/625
