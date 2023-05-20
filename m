Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CBEEC77B7D
	for <git@archiver.kernel.org>; Sat, 20 May 2023 08:02:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbjETICZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 May 2023 04:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjETICY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 May 2023 04:02:24 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC3C11A4
        for <git@vger.kernel.org>; Sat, 20 May 2023 01:02:22 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4efe8b3f3f7so4599330e87.2
        for <git@vger.kernel.org>; Sat, 20 May 2023 01:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684569740; x=1687161740;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DnhNG5h367bM0wT4poDUmKkMG/afB5k0LYkvulkU380=;
        b=D/CoLQtqS5FkXie+9cTB1dtFYEVU2TYti6/FRuidEsHwmAs784cMCp4GZLwJC0WAPJ
         p1LxIQXPa+fsCFmwNZJadnTUzUEW/dXC9jRCA+kgMky43Yj+mOWkH2mXI2wvKIVDPyoM
         TqzwMwZ0KLrSC7O3ZkOVpmwhTD2doYUwL9SQ5xowvKANUuMj1GBZpU0QZhdct/8I3CfS
         ZGjWtUNGcQN3ziEBtkIiFhwx1MhweQksfbkFZPG7i245obMtrbMIRXfwz7ZqxD5GmqL8
         d0iEJ9sJJUmd2xx0GD+NZMBgt9m4dvHo8JTZgEwo6EaoL5Mye+X53Nc9TJ0w0O8Iftvc
         3FGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684569740; x=1687161740;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DnhNG5h367bM0wT4poDUmKkMG/afB5k0LYkvulkU380=;
        b=W4NvwsHvwxmgTbVVtrH1vrYnl1BEz+01x4o6AQUHwIhSM6LE8DqAFXFr3KjJnqknqI
         fAYwG0rb+0xpQ0unaTrWdi3BdcfQs5MDX/kaP+h6p437pwD9KnnoCh1jZy1pHHCJTpnn
         xrVO0lAObKp3Q07obeZvjkF7HyESCh48YNzAp45SPOI1hAPd1+FvYJzqxpU9WR60f7M7
         WZucY9jt2JZbCPYmkN2d7IXbZEsy1f5MYpy36xbk03Y9tUTv9b5nLdwjKyoyD2MbNm2M
         bvzxV6BS1Pg8puU+xJuHT2p9XRbwNepdexbEL6guSu0vErnD0xPxQBrCFuMGRDKkvTP6
         8iLg==
X-Gm-Message-State: AC+VfDyr1/pRZr364oAKNn247bc1S3MC42AQUSWB+4bkFx62HxOpFEVl
        oxweIm07LOdb0kmnnbGdp/vYm9seR0F5jzTCAI+I7O0U2Qg=
X-Google-Smtp-Source: ACHHUZ5vqIIf6mRUIpPk25PGbe/x2ygPwvc32uWKjioOWuyP2pvEm53Dre+XWDKeRWKcquuT+W5Cjd4h5cw0vun9bgk=
X-Received: by 2002:ac2:41c3:0:b0:4ec:8787:d52b with SMTP id
 d3-20020ac241c3000000b004ec8787d52bmr1293441lfi.62.1684569740455; Sat, 20 May
 2023 01:02:20 -0700 (PDT)
MIME-Version: 1.0
From:   Minnie Shi <minnie.shi@gmail.com>
Date:   Sat, 20 May 2023 10:01:55 +0200
Message-ID: <CAOQx3AYx+sSD4REfTdQ0muY2zRgzE2nR7RgG7cxNgXvwzYzixg@mail.gmail.com>
Subject: I think there is error in merge documents - current branch
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi team,
In there git merge document: https://git-scm.com/docs/git-merge

If you search the word =E2=80=9Ccurrent=E2=80=9D, you will see the paragrap=
h
describing a situation which changed the context.
More specifically below the screenshot, the last one should be commit
H instead of commit C , because the description talks about the
`current branch is master`, and `git merge topic`` is being described.

in summary the sentence should be read as

Before the operation, ORIG_HEAD is set to the tip of the current branch (H)=
.
instead of
Before the operation, ORIG_HEAD is set to the tip of the current branch (C)=
.


Kind regards
Min
