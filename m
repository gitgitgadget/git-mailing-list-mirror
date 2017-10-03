Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C193020365
	for <e@80x24.org>; Tue,  3 Oct 2017 10:15:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751156AbdJCKPC (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Oct 2017 06:15:02 -0400
Received: from mail-qt0-f173.google.com ([209.85.216.173]:49822 "EHLO
        mail-qt0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750787AbdJCKPC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2017 06:15:02 -0400
Received: by mail-qt0-f173.google.com with SMTP id o3so12026927qte.6
        for <git@vger.kernel.org>; Tue, 03 Oct 2017 03:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=8qVqUXCRS2qgt2jU781420Sm/yLqTdYiMQ+3Vww2gi8=;
        b=pDarvRhtxNFyh/DvoL7byLp3EQP+sNrxZXYu6NsJwebq3HJ+v3RE1qx1OGj6plrfkX
         Lmy3ZaHCwKKNV4ZHYNwM1mG/fCdp58u2P4NvvNq3O4WuSdg9UjCsMabp6xOtu2UA8Yx8
         ppaT0m0PVnLVM30YuDRCs69RXfBYXTV072PpapGVFJB8uXB1Tn/avD+c26MigCNtTE1m
         DnUuipcLPZsp4/kxlNb/CbozojgD/8P2NZy7MPrFT/EEQN6xwS0VCufwCEvAHKRheSZ/
         bu92tk0NGIDfOxuWuOpMfIYDV3kMtc6t2cp6u7iHWl0SnmrV06yEAJj/VizmLw5e0r1N
         8LdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=8qVqUXCRS2qgt2jU781420Sm/yLqTdYiMQ+3Vww2gi8=;
        b=A7fF22Z1ubqQHQ7PFhLRtQgEuQ0DluAefhRqnZD+Y4fNRRYaqGcb6yxPe6bBS2ruzL
         xIjX0ifHwsjtdu8fTcHIgJG+1Y3Xy1j9FLgP9DWmTSGEMjYVjvXSioKywSryxzxB+zEM
         WTPno5hvxx0AkPEJXiF5v4R9e8z2FAfQc9b6318aa53fQdhK5TB+ryegPEA27jPtoIzP
         OmoMPQAGlCCGIjOlZqY/V09G2AwARIlfsE87FXXOlHv6BWQowpheSpAnoB5puddR2wrO
         b8RBdRo1yiRqN1R9W1wfmTzK1LYj/NTjBu9j0tNx9McScca/dYK5EQVUR+x51+W0XxoX
         VPjQ==
X-Gm-Message-State: AMCzsaXOLxhoQKSvq9tZfjU3UG2pumPvI/VYLsiN/YjXfMafLqrQiATF
        xYxrCGeA5/R0/bMq2NF7Yr6+7Ulxi3iEdHuHwFhJhTYb
X-Google-Smtp-Source: AOwi7QBZzsgkAZ1RUxMD85kWt8XRHJtwVa0ZHUVWNSBulNe7/HxugGt3En/KXibR/Xj4sqFtTgON5I4IrKY3dymC1N8=
X-Received: by 10.200.0.89 with SMTP id i25mr1208904qtg.88.1507025701308; Tue,
 03 Oct 2017 03:15:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.101.178 with HTTP; Tue, 3 Oct 2017 03:15:00 -0700 (PDT)
From:   Marius Paliga <marius.paliga@gmail.com>
Date:   Tue, 3 Oct 2017 12:15:00 +0200
Message-ID: <CAK7vU=0ztEwMPsGO4Cd1A5JEnxmwkF57QPKjjvjD8rBUB79dRA@mail.gmail.com>
Subject: Enhancement request: git-push: Allow (configurable) default push-option
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There is a need to pass predefined push-option during "git push"
without need to specify it explicitly.

In another words we need to have a new "git config" variable to
specify string that will be automatically passed as "--push-option"
when pushing to remote.

Something like the following:

git config push.optionDefault AllowMultipleCommits

and then command
  git push
would silently run
  git push --push-option "AllowMultipleCommits"
