Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A864C433F5
	for <git@archiver.kernel.org>; Thu, 30 Dec 2021 23:25:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240812AbhL3XZ6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Dec 2021 18:25:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240325AbhL3XZ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Dec 2021 18:25:58 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DFC2C061574
        for <git@vger.kernel.org>; Thu, 30 Dec 2021 15:25:58 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id y130so51777427ybe.8
        for <git@vger.kernel.org>; Thu, 30 Dec 2021 15:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=vhEhX1zR2z0NJC2ABya1J2t03n/0WKtu6zSvzddsfOA=;
        b=bcVLOKN7uylL2QSolvvyY2ti6mDoryFrONq0+dlLBtuEJfq6TI+JkepnEvlicZmIe1
         5LwajM2/BS+jCjAGi1qxW0M4DMDtg4XZ4pu/QrMg/gBY/AIqDfe0k88UuC2mgTCa4Rz/
         +bqLqag3qw4EKeI8bjAB+BZKFgp65KjEf2JeYEkaDt0T1OFwNEeXOXqItXoS3ZuChkTI
         VnUPRsZbHcBAcfizZ4b7r5xU9ALmdUF7RtJr6nqgM9jzN/bDe6nHMMVYpOipwNGsZ+0N
         WeGLblL7dmmEJlq/rAjKeWKyHwI3OZEyDeVTIjrtjOXiTN/0CLtdmUejfpG7+IaS+Am9
         3VIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=vhEhX1zR2z0NJC2ABya1J2t03n/0WKtu6zSvzddsfOA=;
        b=XZ6joS3Qf2TO9sk9UUEHFYa5ZwAfYLRRP4MfPkZRE+syZH+ODnvhP3ctd9SNG+Zi2d
         hXhuvhYfS9jkxRsX5kY6eO46z0yHxzdmCdpcVM1zqoGwFMpwXHBBE2Z2ZpsPlJfIlhqw
         eLKLw8/UETqFXCJf/ALNdPMmAK3/VBEB/g/gDG8JWpji513kgPKupxfRJY2vG8Y24SuE
         j9yEQHSjTtU2MeGKIbxkWQTJ+Pj2TzrfGu2Bz9aJw1P7g+ssKFrq3E4ErJfY0fQFAtB3
         DH9y1tzG1bRF8L7N8oLtU8aEt1pO7HrieVFLLDMWfhtuGTb3ctpQ0JPvP1RGxWHw9n+G
         ilqQ==
X-Gm-Message-State: AOAM533OGrDe0KPeFsG7Y79KGq7TPCHGEQWaCfEiWVbg3MTyOQhYCc/Z
        ta1xU9NpRjZGdFXFwgdkkg0tdrV6DTQTSfzFJtxs3F5LD2w=
X-Google-Smtp-Source: ABdhPJxhBkkLyDnl767ynfX2JbHQEEzm4xXM/4hyEEqWz7yec7YIpFpSsJC/fhwcB4geEpcnkBgns+wKw34fz1IFYmc=
X-Received: by 2002:a25:f04:: with SMTP id 4mr24497378ybp.50.1640906757118;
 Thu, 30 Dec 2021 15:25:57 -0800 (PST)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 31 Dec 2021 00:25:46 +0100
Message-ID: <CAP8UFD18z90w3s2ntSd8VpcJnNCG72cGKYw-CkRaLhKKgd1B4A@mail.gmail.com>
Subject: [ANNOUNCE] Git Rev News edition 82
To:     git <git@vger.kernel.org>
Cc:     lwn@lwn.net, Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Baruch Burstein <bmburstein@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Philip Oakley <philipoakley@iee.email>,
        Fabian Stelzer <fs@gigacodes.de>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

The 82nd edition of Git Rev News is now published:

  https://git.github.io/rev_news/2021/12/30/edition-82/

Thanks a lot to Randall S. Becker who helped this month!

Enjoy,
Christian, Jakub, Markus and Kaartic.

PS: An issue for the next edition is already opened and contributions
are welcome:

  https://github.com/git/git.github.io/issues/534
