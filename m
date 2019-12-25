Return-Path: <SRS0=LPWw=2P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	PDS_TONAME_EQ_TOLOCAL_SHORT,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0451DC2D0C8
	for <git@archiver.kernel.org>; Wed, 25 Dec 2019 23:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDE222073B
	for <git@archiver.kernel.org>; Wed, 25 Dec 2019 23:24:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FkrZdljj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbfLYXYY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Dec 2019 18:24:24 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43034 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726516AbfLYXYX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Dec 2019 18:24:23 -0500
Received: by mail-ed1-f68.google.com with SMTP id dc19so21185432edb.10
        for <git@vger.kernel.org>; Wed, 25 Dec 2019 15:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=jfDZ1wSjs3lEQ4dhvT/hV5YfqdedxiiRYen2sUDmXbE=;
        b=FkrZdljjQyfUugN2SMKLyr51kapsE3+hOIW9TbonhEyM/9Fzt6qbWCc1QQPIMMJHXO
         H9dpvlQKCJi9SVroh4BQtvTk4HHeSWmuVIycYtpuZSXBNj0r8YsfakC9yVT1VMmx/0aQ
         1sFpDftsQpqYIWx24YMZzsbP1IG3cuX4rtyNpd7G26C8EgDaNZzrcjIMMqrsOx5Bu2F0
         zZ0oNUm00JJTDBM9a4yxTpq0fp+G39mP7JC8XQLaP6JLyepiR8nLT6tWocBIcBvZxl71
         ri7mRI9oZ1026fnvos5DF0+vDMa1piXl4Yv6etgzV8GvBZm0qelAyccRINIjrna/C4nd
         Gh6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=jfDZ1wSjs3lEQ4dhvT/hV5YfqdedxiiRYen2sUDmXbE=;
        b=LkMDncjXZvYIp7WADg1jhZ2BYf0zMkPwvqUGkfpGHmdVeeCzPWdyLiJY0mkqTQ++Fz
         ednAoZzKmW8QUfkvr7HT4IM56HMolN7DOfaUrbPcFk4a5C2xuOkow128UUtEx8JTkoyQ
         karV+IfAC3DLPkNjgIegw9jTSAxh13ej6DNZg+MDf7yt8353WHiZdl/jOjAQuwVjrqvd
         s4KA0jDDPp4woVc8BW5mZ+sMqiiDjYwecrbmGecGFtdaSjRhvrGAJtz+bJ/ccD3NETZO
         IGzKG2BiNpAUtjHRN7eeeM2JmpT9W1Pr4oF6Wj0LVAyZ7ZStkomE+ZAyJcnT2WBp9J9c
         oU8w==
X-Gm-Message-State: APjAAAU41zReNo2Acora8L5ARlOo4C2YBb5mEslPVxEw/wi1Bg9gz96q
        m6T9JkwVu8RvOZ0IQk0RIIbI5KzqyaWpJEadQ/lG2eMMnWE=
X-Google-Smtp-Source: APXvYqzwBJbrUc6CRtSv0clBCwW3MHpSIRMa8osHICsLvH/8CcLADqudv01C6NcFTTFRjjHVODG1CTQRDqXZOtxETZ4=
X-Received: by 2002:a50:e00a:: with SMTP id e10mr46667126edl.119.1577316261683;
 Wed, 25 Dec 2019 15:24:21 -0800 (PST)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 26 Dec 2019 00:24:10 +0100
Message-ID: <CAP8UFD3wVjAU7pn=jrWO_ApfjxDuY6R5S62Q5-f1ygN+-ESM8g@mail.gmail.com>
Subject: [ANNOUNCE] Git Rev News edition 58
To:     git <git@vger.kernel.org>
Cc:     lwn@lwn.net, Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        Matthew DeVore <matvore@google.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        "Miriam R." <mirucam@gmail.com>, Heba Waly <heba.waly@gmail.com>,
        Pratyush Yadav <me@yadavpratyush.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

The 58th edition of Git Rev News is now published:

  https://git.github.io/rev_news/2019/12/25/edition-58/

Thanks a lot to Emily Shaffer, Pratyush Yadav and Phillip Wood who
helped this month!

Enjoy,
Christian, Jakub, Markus and Kaartic.

PS: An issue for the next edition is already opened and contributions
are welcome:
https://github.com/git/git.github.io/issues/409
