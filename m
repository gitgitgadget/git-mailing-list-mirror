Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8CB6C433F5
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 10:41:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351473AbhK2Kov (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 05:44:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbhK2Kmu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 05:42:50 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F7D2C061A30
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 02:06:08 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id r25so4111628edq.7
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 02:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=pDWVOF8AHkrUYI3bwRVmVYJLIjkfN1yG1Hn+U3E18W0=;
        b=a7hJgDje1r6C813fzX6KcWC/u94rhwGnf/6TD9jDE/k/qh2pEssUT2oUkRTc+v8P64
         wWj+GIyL7kfUdf/Hm+NQ9tYNf841us/kefVimm8GGGTg3i1GmAlDDfG9Ngy7sHcsxqjT
         Hbp9Dyvm4QV5sqFDJR8uK7a2K3ZRUs5bGwLkhPL8Uv4X0rbxk0H449sMVY33Yc2Mg8Sd
         P6vISmF9Thp4cXmKG8vFvWtfzZSWfgYPinqpdoy8jItwVOCcQ3HD0PIbYhQ29k4XMV0y
         G3GkRN79C/jtAEAdaEXVy0hrQdXWq9hBJNig1eWduJqQhvpOVCVrYh1r6dnX/MujVIV2
         eWvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=pDWVOF8AHkrUYI3bwRVmVYJLIjkfN1yG1Hn+U3E18W0=;
        b=MWNVoE3hOhAeY0BkHEmxusFGv6e0Snr1bF/uc40b/qaMUfgwjOtiHd0lZXFyXHcJ0U
         tUfob5Rz//TLM9sZnGXPlJqz9fqb/dAGXRUQpb/IqTt7Z3osHmI0dd3V/ILGbybCEJF1
         QxhmAfkr9YVLVX2rXZScO8oXseRQAa8CuwnVaEuIfsGMdTRhemKa5c2CRBlShF++BDX4
         eVEHLZGr1jAF0YfLohezK3NM5/UuizhHs30EQ4YDqxaKyZFbT/6TvxCayCT5ZZTQUQpQ
         dvt/8t9c1k7B9cdjknTWPNWM0HSZPdTcU3HMcXN1Kr/d2HPOoeZTtKPe5vFM2NwVdUXh
         HoHQ==
X-Gm-Message-State: AOAM532VxsguAidP4UEGHZLlke+Hp2IGkxvRHeeRo2StxEW2/3Tx6yRo
        YZJrDMIG8XHFCN4Ax/isRIftQOyLfU8DtXfykXO8BAmb
X-Google-Smtp-Source: ABdhPJx3supWDeSpW4Z/0VriLn1lfsKiklDf2KnG4nfBPmHmNjZFviTlCQKN2pwr5uKhifsNVqTwKaiVVcCF3Xp3ptY=
X-Received: by 2002:a17:907:608b:: with SMTP id ht11mr23548817ejc.80.1638180366372;
 Mon, 29 Nov 2021 02:06:06 -0800 (PST)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 29 Nov 2021 11:05:55 +0100
Message-ID: <CAP8UFD1evgGO6623r_gFqVL_aHJ+kgXKSrj9SJ2c-kSD4mhxYg@mail.gmail.com>
Subject: [ANNOUNCE] Git Rev News edition 81
To:     git <git@vger.kernel.org>
Cc:     Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>, lwn@lwn.net,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

The 81st edition of Git Rev News is now published:

  https://git.github.io/rev_news/2021/11/29/edition-81/

Thanks a lot to Dscho (Johannes Schindelin) and J6t (Johannes Sixt)
who helped this month!

Enjoy,
Christian, Jakub, Markus and Kaartic.

PS: An issue for the next edition is already opened and contributions
are welcome:

  https://github.com/git/git.github.io/issues/532
