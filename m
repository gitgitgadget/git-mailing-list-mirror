Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3F321F463
	for <e@80x24.org>; Thu, 26 Sep 2019 17:32:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727744AbfIZRcE (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Sep 2019 13:32:04 -0400
Received: from mail-lj1-f179.google.com ([209.85.208.179]:43797 "EHLO
        mail-lj1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727579AbfIZRcE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Sep 2019 13:32:04 -0400
Received: by mail-lj1-f179.google.com with SMTP id n14so3023375ljj.10
        for <git@vger.kernel.org>; Thu, 26 Sep 2019 10:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=2b5xIg1s1utjoAlEYdv58WuoaeZ1piJeeZYlBm4QeXg=;
        b=sP4NzvGMnb5YgKzYjhGDoBMNAqYiafwGCzo6PPNeHHncmL+A9JjJ4eutqjtMATFzRF
         KqQWyxhZFZ0ZOr33mdXDPiTVSOCS1PxpyveqYB1s7Oa1z54j3NScgCSIK2V6SaCJi9Ar
         gDyJ39tLN35C5PSXmJPueYXARuacwHg0SGXY2EXy1g/jrOHFgn4BB+JQ7fySwbfyBxAs
         0l2ZGdB3sL462IhVPZrXWlbgHsZ6RJ/ajTXWw1JMpPDRHyOamZ8Ty28xi7ppYWe4/fG6
         EGyPVNFMgzIxlGB8pEcgrMiTOKJCKSNuHaj5Y+9FvLbq4hSk8yp2e9ZPMMODc9E9ITUJ
         UZ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=2b5xIg1s1utjoAlEYdv58WuoaeZ1piJeeZYlBm4QeXg=;
        b=AsZPXqmT9N6bBGFgaql6gZc/vuE3CI9RRNBTMg9kLcZ/HsPP9EgpaIHWZ6f488Hvcs
         DTTTkl6qd/H5+ymTC4/ZFw0XMZWiOPfgmcqmzSTi0daoZ7HBbR3vUQ/E3QTpca7aCPiV
         dtJ3tY8PoXltSw727yNfT0F0vDh8OgOUgQlH/4SmRgjjdXruni7d9O94jz7c5BmTv2bg
         iF3mgJpnMELVx4qdbOt+TYGncqpdsu66et89JbHIyd0S11FEpd8peV3HXypdcbpElVNc
         rsaagQPjtuyvDuWEV6fJ1Pefreq44ssXkKWegmixk2Gpbeqkm4blcuR6wo5rXNAWjzEB
         KRIw==
X-Gm-Message-State: APjAAAUPA8sv4G/zQ0Hl/E+38qVNigfVZE3l4rKjz2a5xjBT/TgWpago
        vMLEcmRQ8qrx36wrGa60DQhTirQv6KcSoc55vfbfxOB2c7g=
X-Google-Smtp-Source: APXvYqzPFeNtfPpl33Hf13f8LUa682KZHSgRnvDwNSbuxWp4Hh+5j+SX4UcVAc/zRDJz7kImBtPUtuB2gOjka0JtD3I=
X-Received: by 2002:a2e:86d5:: with SMTP id n21mr3347503ljj.1.1569519121103;
 Thu, 26 Sep 2019 10:32:01 -0700 (PDT)
MIME-Version: 1.0
From:   Birger Skogeng Pedersen <birger.sp@gmail.com>
Date:   Thu, 26 Sep 2019 19:31:46 +0200
Message-ID: <CAGr--=K15nUcnsJWOP87uMMjeQmTgAeO_6hnr12k2zuNQjNyBw@mail.gmail.com>
Subject: git-gui: disable the "loose objects popup" dialog?
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,


Every once in a while, I get the "This repository currently has
approximately (some number) loose objects." popup dialog.

I don't want to sound arrogant, but I find this popup along with the
dialog showing after that prints the result of the compression,
immensely annoying. And I've seen people mention before that they
would, in some casese, rather not have to deal with the dialog[0].

[0] https://stackoverflow.com/questions/1106529/how-to-skip-loose-object-popup-when-running-git-gui

I get that git-gui merely wants to resolve a performance issue. But
personally I'd prefer if git could just assume I always wanted to
compress the database, and automatically do it without bugging me with
the popups.

I propose we implement the following options in git-gui:
- ignore loose objects (do not show the popup), disabled by default.
- automatically, silently compress the database, without prompt. Also
disabled by default.


Thoughts?

Birger
