Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9727D1FAC8
	for <e@80x24.org>; Sat, 29 Dec 2018 22:25:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbeL2WZN (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Dec 2018 17:25:13 -0500
Received: from mail-it1-f173.google.com ([209.85.166.173]:37119 "EHLO
        mail-it1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727272AbeL2WZN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Dec 2018 17:25:13 -0500
Received: by mail-it1-f173.google.com with SMTP id b5so30747339iti.2
        for <git@vger.kernel.org>; Sat, 29 Dec 2018 14:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=Pf5Iv2Bjiq2XiBJsRycJ1DGHk+Xkf7yI+GhOZJa0SIs=;
        b=EG+1umXADx7GPuZHrbnAyRcSKHF94bKpIut16VptRMONP/TCi/JU3zY3oe4367GpyB
         2mRA3ujN4QELCoJFDJy5JuSq4Un689dckBrVDsNX9OUf7Zpun+4jjO0a0bvl7kiFTjxW
         35xlxI1NWDM3hpstGXlnlaLlzFjlqibf0Z0rZPcPV87tp1ruoCeTno42X3gXAaEjOFYR
         mSls5PgC9Ftc6lMc6st7pkt/DEIsYG/cRl2M5gSPd2BeaEcNL8UdLbFIKRZLbDQiYggX
         R3K8h5j5yI1IDiBupfoxkxpBgDTuVI1k+FkkxEt06E3/Cbm2fIe6M/e5pITfcR9LbJQw
         3GUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=Pf5Iv2Bjiq2XiBJsRycJ1DGHk+Xkf7yI+GhOZJa0SIs=;
        b=c89eztoHI4QKnCONPx7Eu2U35juTaKKRqvNYMLSA0iUCnlYLszmUpDC+zs1neOd882
         hyCBdqmiO0Q+OA2bj3kFwqDPPRTU908gPCgdrgn/n+VU7u4Gawj3XGNGg4UYy9vWblqx
         zFf9JGz45yIFG/6GNE/st1UR+q/hOw1h96g5bg6qpiFVsbns4Y5k3iK3B67T9iKKxb4E
         CO1Ujnq8PFNcGRVWmTiZT0UPyTWIrPhfEzeqPhPiL2lCwhwXSRlExNLFr4ztRVtkPyn7
         wunyvGMsmK5hJdwG+pLXlHSwu2EVNNuqPX50NvKNwrk/ivaOown0b+2OywNaYFbQRoX3
         XM2w==
X-Gm-Message-State: AA+aEWacHGlMN224M3iCZTwFyhjdzYGV2uGlBh4hzZWtWvGzvRTjmTlw
        sGIaqQpRH1mMppnz6K4VXANvrcIgu69pq+61/xzD1fw7
X-Google-Smtp-Source: AFSGD/X2K6HV4lNMouEMQUez31WlMVO0yaYZ8ACNwQ8xVei8OwImv7LdyLvGFBfSflD8wbhz2TGo+S2anrrBoBIr1gk=
X-Received: by 2002:a02:ac8c:: with SMTP id x12mr19693585jan.72.1546122312349;
 Sat, 29 Dec 2018 14:25:12 -0800 (PST)
MIME-Version: 1.0
Reply-To: noloader@gmail.com
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Sat, 29 Dec 2018 17:24:47 -0500
Message-ID: <CAH8yC8=zaL3ETrOSk_3xQobfG-z2VLMsGn8O-q0zCaqw6C_Bqg@mail.gmail.com>
Subject: Lack of debug info from git commit -vvv -S -am "..."
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm trying to determine why a new installation of GnuPG is having
trouble. The new install is in /usr/local. The other install is from
the distro and is OK.

Here's the new installation error message:

    $ git commit -vvv -S -am "Update GnuPG recipe"
    error: gpg failed to sign the data
    fatal: failed to write commit object

How can I obtain more information from git commit?
