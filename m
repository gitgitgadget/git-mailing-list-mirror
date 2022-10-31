Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 259F4ECAAA1
	for <git@archiver.kernel.org>; Mon, 31 Oct 2022 19:53:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbiJaTxf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Oct 2022 15:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiJaTxe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Oct 2022 15:53:34 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB3213F46
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 12:53:33 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id y72so14916154yby.13
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 12:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WxQGVih8nxjmZ7H2E3GO0Og8107WpSoPSd7T8F11Wp0=;
        b=Mb1qT64ucx51jnwp9scSdg5UJUOI3s4QkupGSnwXXmgKsODCCnSVH6/p6lInIR9DJl
         syCUrJ85xH9lWBcTqfDlXa503BEe2ndarAPICWeNxbGM+TgVx/ACae2kvX2Ntfs/O5xB
         DL3tdBW2OZ+YqXN7wBjk8tIu4I51mYMeESEoE8TFW3I9XDR3zsLws6LcivfaY6YzbKiA
         4ZHaSOpFtWQ4VEVTlAP7/ZPwOadDTigrcDGRolACb0ioiSF9yWLQot76jAI0dl/qF/2v
         d7znsiPPEAn55zWV7eCIflYzkX47U7VJ8O0fM+ktkigaXC/BhpSTW+Q1IQSof68DbmVo
         c+gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WxQGVih8nxjmZ7H2E3GO0Og8107WpSoPSd7T8F11Wp0=;
        b=K+sRZmW1UtrBBUK7AxQh3xB5uXlFPdelqOnhDdM0F7kk/kjNLFGeuJ/ZswLa9Qad1v
         w5VFVQ6y47hdUzdbgy+YO+kz53hWfRrL+78Tq/IpkGxzfnZkQRG+aDsstig9GLOYJY0K
         utZsFueRPgVhm2TUpId3Qo0hNftGwn5zL3oYckGqNBCbJ6wQuH2p0DQeCfL/ceNGDrOu
         O8BtXzdOcJGkqlDMrlwbRCTZxJZDMzL4w4XWSOWvJqfJQLjxyqXv8YUiX2ZwY5Hn0qsX
         r+qL/U9odbdrX+nkUgTw2y57HWTzyX/3w0Erw+1AgxHpHTooA6LaD9oxag3fpiCvcYRR
         w4+g==
X-Gm-Message-State: ACrzQf34g+C3GIloFtvnFlFdT8vb9692pW8r4CMVYHikzcJZIGAnvD3g
        NC3Hf1Ljex9VogOKTbZFIPaTa0t6s+4VYiHn36u+43cr4XM=
X-Google-Smtp-Source: AMsMyM4L174CT2eyMHOv4OyqXKQzfaqzCIXIj6saEomiwkk/uXr7RjAISLoRwXQMcyxievdySIHNPbARYzQ6vpwQXHs=
X-Received: by 2002:a25:8d0b:0:b0:6cc:d066:9e75 with SMTP id
 n11-20020a258d0b000000b006ccd0669e75mr2570766ybl.366.1667246012356; Mon, 31
 Oct 2022 12:53:32 -0700 (PDT)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 31 Oct 2022 20:53:21 +0100
Message-ID: <CAP8UFD0uz40bsYTOpRqyjSNmuO+UtD5Qxw+PB0rHMkLTVMKONg@mail.gmail.com>
Subject: [ANNOUNCE] Git Rev News edition 92
To:     git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        lwn@lwn.net, Arthur Chan <arthur.chan@adalogics.com>,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Siddharth Asthana <siddharthasthana31@gmail.com>,
        Bruno Brito <bruno@git-tower.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

The 92nd edition of Git Rev News is now published:

  https://git.github.io/rev_news/2022/10/26/edition-92/

Thanks a lot to Dscho and Bruno Brito who helped this month!

Enjoy,
Christian, Jakub, Markus and Kaartic.

PS: An issue for the next edition is already opened and contributions
are welcome:

  https://github.com/git/git.github.io/issues/614
