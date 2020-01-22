Return-Path: <SRS0=mjbR=3L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	PDS_TONAME_EQ_TOLOCAL_SHORT,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3618C33CAF
	for <git@archiver.kernel.org>; Wed, 22 Jan 2020 16:02:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FD262465B
	for <git@archiver.kernel.org>; Wed, 22 Jan 2020 16:02:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fi8IR4FI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbgAVQCp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jan 2020 11:02:45 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:34896 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbgAVQCp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jan 2020 11:02:45 -0500
Received: by mail-ed1-f67.google.com with SMTP id f8so93823edv.2
        for <git@vger.kernel.org>; Wed, 22 Jan 2020 08:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=BcbfzCAE1RUoqeu7s8RgMQofRpngubcHUG2nebbfb9k=;
        b=Fi8IR4FIXpTQ7v+k1Vr4Y4S/b2qG0BvMQ+pb4LBv4F+jSVDpXdqRnut61tdZkJrFAJ
         l999rLY1Z7RBcWEXOpAg8xjcm8De2cnqHuJOJR6S9Jihy1yKuqkHbCskhtcMj6AxJYLx
         CQa4V5chu30ZkAAi1Ai3F3zdxcWs+lVff1aLse8DGMWmq07bem8lldNQ5JUx+Q5BZfaw
         XcQaO2gJaS+B4BRC8rdKz6VB9Th6aCmpnVFXRziFl87yCI6RP4YHv0NKta2aiuujinJC
         bLACTxeV+nBbC+LVy4xOKLqXlFTpOQKD68miqlaKQtBahxJ0zcMHQtW1LgLTTan/gP5D
         2QtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=BcbfzCAE1RUoqeu7s8RgMQofRpngubcHUG2nebbfb9k=;
        b=Q8OutnbaPiN76ATMRZympKezfe2nay6zxldVoTUPxezmqJwOIEcjsbjMOHnndC3Rwb
         6BaKn5K8mUuql3moEVktiTRoVozaI+hhaueu6sa792UPohfe97Ba14D3xSCNZ7QeoW+L
         ACaFG127NsCbiGAH2SFnP9q61MUkD5vgxXKXz9pkLsNjx/ZubDCoYYZRTENQfHHc334D
         U01fP/cq5Zz6xZZWzNE5Nf1i7wJPCTJtZgxPvUuUjVWA8EbxFH9GZVMBOe6MtmIYVaoD
         /f/5R1mYcbwsjPaJnxTFd9hzEbeOT/YxN4eBiI+cvrp40vssFH/G5H06k08lpNnJ79Ts
         WD0w==
X-Gm-Message-State: APjAAAVZIfjAxtQE3kGTBLjbqNNn81bPDJSJ9p+fHHRTu9USloEtQgDL
        vm0OZPrZFQHuQV6ABU8GL8aubmcweelOk9j1VGaDEt+p58I=
X-Google-Smtp-Source: APXvYqzIzPInz5kIwFjRbN8tLS8bCkUrVsWTme+n1eFyusW5L2LAwi7mSiJaRND+b7QfBJD3hxf79YrXVoxC8eq4pec=
X-Received: by 2002:aa7:c890:: with SMTP id p16mr3170293eds.127.1579708963042;
 Wed, 22 Jan 2020 08:02:43 -0800 (PST)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 22 Jan 2020 17:02:31 +0100
Message-ID: <CAP8UFD2=cPthUAgxFhtuZArfuAU4H63kFD7xfGtPMxDAq9au8Q@mail.gmail.com>
Subject: [ANNOUNCE] Git Rev News edition 59
To:     git <git@vger.kernel.org>
Cc:     lwn@lwn.net, Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "Patrick Marlier (pamarlie)" <pamarlie@cisco.com>,
        Mike Hommey <mh@glandium.org>, Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

The 59th edition of Git Rev News is now published:

  https://git.github.io/rev_news/2020/01/22/edition-59/

Enjoy,
Christian, Jakub, Markus and Kaartic.

PS: An issue for the next edition is already opened and contributions
are welcome:
https://github.com/git/git.github.io/issues/410
