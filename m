Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5710DC433EF
	for <git@archiver.kernel.org>; Sun, 31 Oct 2021 04:18:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2789860FC4
	for <git@archiver.kernel.org>; Sun, 31 Oct 2021 04:18:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbhJaEUk (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 31 Oct 2021 00:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhJaEUk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 31 Oct 2021 00:20:40 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 155B5C061570
        for <git@vger.kernel.org>; Sat, 30 Oct 2021 21:18:09 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id q74so29575555ybq.11
        for <git@vger.kernel.org>; Sat, 30 Oct 2021 21:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=pa2fYWt+qkoXV3/tUSNn4XHX9Ruoo/BcjKpBWQwQpmg=;
        b=MMK/U47H5j34Abtd25YVyQMRzg+kfBvnFFhjHl0Zx+xD4uNmwUfvzkHE6Mza4F11Op
         bnL9ZSDJcOJ0BtXUFzSuuOqRQca30+HGtUO607gzlEyY+JmIEAedBJJiBqMK2Xg0j2qt
         CXzrvYcax1YnZ7BV5NmfZrkRplyxSyt7OJ6Mrj4uwuJK57cOdNSxN56A6c+lp0sSsuZI
         839ktQb0ZaRn2X8mflUgg47gY5PGf1b7M4qIGTfWDHU7Oi04Up7XeDtlLPuzsYVyrFV5
         EdCGCGGO9xk26h8cNuioy/azLU+g7hIHcVdyxyWgN0to9Vh/rLnD6wFzSGoJ0yzv/86K
         cNRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=pa2fYWt+qkoXV3/tUSNn4XHX9Ruoo/BcjKpBWQwQpmg=;
        b=dHXrQ2Ow14/FLH71dMzmSlMFd53OLtOOcmN35dH+CjANOXaogKpyw98XTRvaXztEA6
         FDU/QQe8cwoJBo/yHHaZY/TgyyH9T/FbRf8Lz0TxKnZnKB1KFYm3MxO08XVNV8xKkSFL
         7/fNTDJiPBUaHjumBKBk9mRywZb7GMJlSpnjro7TQYd6a6RRaFE97t+MtDO6FnaRNoDu
         GADegW4mUmrFAWVTlOAFg0c5ct+CktRbwY2f8txr16TKhp7ES2wGtTUKoHfW14fxh/Cn
         hMFY8GjDKbT4ihV8VmeVCOkzTVnF60qBEEsCGMKwcdydgUHQfIAL9OEYoze24+SUxdRu
         3CPQ==
X-Gm-Message-State: AOAM531zyXlzj5YVMN7geX24VSm51TNXkDITkz6Sd2octstiHOFMj1jd
        ab1JKpuQ/rVHFQ3jXdsLuHsaf27DM7KoMMchfaxg5hj9CuA=
X-Google-Smtp-Source: ABdhPJxE5gE6t5yl1X1hIj4sE/VQClcPMX4NjPY8ZmGyuRZdrVPkH9PntBFEEgLR5d+bKfgl/D8fJ3mzONo5NMKE+Q8=
X-Received: by 2002:a25:2205:: with SMTP id i5mr21338842ybi.203.1635653886683;
 Sat, 30 Oct 2021 21:18:06 -0700 (PDT)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 31 Oct 2021 05:17:56 +0100
Message-ID: <CAP8UFD17zQ1NpWDC9n68GC4X4muxSoiQhNXbTLo87eX_8epsMg@mail.gmail.com>
Subject: [ANNOUNCE] Git Rev News edition 80
To:     git <git@vger.kernel.org>
Cc:     Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>, lwn@lwn.net,
        Glen Choo <chooglen@google.com>,
        David Aguilar <davvid@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Johannes Altmanninger <aclopte@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

The 80th edition of Git Rev News is now published:

  https://git.github.io/rev_news/2021/10/30/edition-80/

Thanks a lot to David Aguilar and Johannes Altmanninger who helped this month!

Enjoy,
Christian, Jakub, Markus and Kaartic.

PS: An issue for the next edition is already opened and contributions
are welcome:

  https://github.com/git/git.github.io/issues/529
