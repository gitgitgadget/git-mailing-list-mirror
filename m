Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C4FA1F404
	for <e@80x24.org>; Sun, 12 Aug 2018 05:12:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbeHLHsx (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Aug 2018 03:48:53 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39319 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726883AbeHLHsx (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Aug 2018 03:48:53 -0400
Received: by mail-wr1-f66.google.com with SMTP id h10-v6so11456862wre.6
        for <git@vger.kernel.org>; Sat, 11 Aug 2018 22:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QBjpG5KlsEV5/ZVzaP0fiSUCTRw+e44hTazfV2nHllE=;
        b=RiGpAjfbvJrdl3gbyNTZ4NY/j+IGC7HYTmNVC1zopQIJdzCuCGsRlIjwjTzZZmp69B
         yOFyfhXIMX7qWhF3ES9dgqU/ow8nEC5YCuwIRQgaF1JqNfvH2OvsLJICyRhzFZtee60l
         h0EFdxGnBFaR1qTvMoE9NnCD3XywOKRRx0NIVOR7hvPrKtfLgpq0ek5cTgRpoO0y825G
         mV0z1h0X7kYEpzMAFWiPOzjo8tKzW9AFdv74rRZfILT3y0bP8tdZYBeXxxSez+4Tzb2q
         oYT0iM0Ivq3J4NEnztdZIHY6STT7bcnQBuNAC52dUe5SSJMlqvK5dBsdRDUys+axJny7
         mDzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QBjpG5KlsEV5/ZVzaP0fiSUCTRw+e44hTazfV2nHllE=;
        b=m0QT980KOFYNUGKWW97wLsYQEUcj2BrXUB3cjC96AFHaWNoUOqBuxGFjvnOBqMFrv9
         ytQChAKYTSuhNkwzj08017SGHjS/Zqr/tvr/Wn74JEPGMsXjQhQ4Jc8otFKzETimlWkS
         E5jPSYxfSqWfrNZ9VhuIU/ZSzTOkgSkaArK79CRVzWWy3C6r7OICCSuhiS2vDpsEy/P7
         elmyWSAGhuydDQhHIOJlysFPF+gkMVxiQ8zSPAsKGG8nvhnNhKbX/3y9rVtzKNBkdbFu
         GMFcYRt+3m7P1K89BIPQuIlhuWFFHceWuftJbf899VVVJAzsvLL1LPYp+FlC8UCi2ryE
         QDyg==
X-Gm-Message-State: AOUpUlEvD6DJ8+z40zMCU7SMUJMiWB5jyo///Nz5lClG9amsb3iYQnTt
        sxSayqIfUgiXZbAS1VBDiqK0X8Uk
X-Google-Smtp-Source: AA+uWPyLtZPJR8+0FMCKPdcQ3ugjXPOw/bpns+s6xjLbwMCTExxPz1WR13rpn9KK88xSyb8MD2lnRQ==
X-Received: by 2002:a5d:51cf:: with SMTP id n15-v6mr7915394wrv.107.1534050730212;
        Sat, 11 Aug 2018 22:12:10 -0700 (PDT)
Received: from localhost.localdomain (228.14.112.78.rev.sfr.net. [78.112.14.228])
        by smtp.gmail.com with ESMTPSA id g10-v6sm13281205wrv.90.2018.08.11.22.12.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 11 Aug 2018 22:12:09 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        SZEDER Gabor <szeder.dev@gmail.com>
Subject: [PATCH v4 0/7] Add delta islands support
Date:   Sun, 12 Aug 2018 07:11:44 +0200
Message-Id: <20180812051151.6425-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.18.0.554.gdb07901040.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series is upstreaming work made by GitHub and available in:

https://github.com/peff/git/commits/jk/delta-islands

The above work has been already described in the following article:

https://githubengineering.com/counting-objects/

The above branch contains only one patch. In this patch series the
patch has been split into 4 patches (1/7, 3/7, 4/7 and 5/7) with their
own commit message, and on top of that 3 new patches (2/7, 6/7 and
7/7) have been added. The new patches implement things that have been
requested on the mailing list.

I kept Peff as the author of the original 4 patches and took the
liberty to add his Signed-off-by to them.

As explained in details in the "Counting Objects" article referenced
above, the goal of the delta island mechanism is for a hosting
provider to make it possible to have the "forks" of a repository share
as much storage as possible while preventing object packs to contain
deltas between different forks.

If deltas between different forks are not prevented, when users clone
or fetch a fork, preparing the pack that should be sent to them can be
very costly CPU wise, as objects from a different fork should not be
sent, which means that a lot of deltas might need to be computed
again (instead of reusing existing deltas).


The following changes have been made since the previous iteration:

* suggested by Ramsay: remove the first patch that made
  get_delta_base() in packfile.c non static as it is not necessary

* suggested by Peff: use ALLOC_GROW() in island_config_callback() in
  delta-islands.c in patch 1/7

* suggested by SZEDER Gabor: use ALLOC_ARRAY() in
  deduplicate_islands() in delta-islands.c in patch 1/7


This patch series is also available on GitHub in:

https://github.com/chriscool/git/commits/delta-islands

The previous versions are available there:

V3: https://github.com/chriscool/git/commits/delta-islands29
V2: https://github.com/chriscool/git/commits/delta-islands19
V1: https://github.com/chriscool/git/commits/delta-islands6

V3: https://public-inbox.org/git/20180809155532.26151-1-chriscool@tuxfamily.org/
V2: https://public-inbox.org/git/20180805172525.15278-1-chriscool@tuxfamily.org/
V1: https://public-inbox.org/git/20180722054836.28935-1-chriscool@tuxfamily.org/


Christian Couder (3):
  pack-objects: refactor code into compute_layer_order()
  pack-objects: move tree_depth into 'struct packing_data'
  pack-objects: move 'layer' into 'struct packing_data'

Jeff King (4):
  Add delta-islands.{c,h}
  pack-objects: add delta-islands support
  repack: add delta-islands support
  t: add t5319-delta-islands.sh

 Documentation/config.txt           |  19 ++
 Documentation/git-pack-objects.txt |  97 ++++++
 Documentation/git-repack.txt       |   5 +
 Makefile                           |   1 +
 builtin/pack-objects.c             | 137 +++++---
 builtin/repack.c                   |   9 +
 delta-islands.c                    | 502 +++++++++++++++++++++++++++++
 delta-islands.h                    |  11 +
 pack-objects.c                     |  12 +
 pack-objects.h                     |  39 +++
 t/t5319-delta-islands.sh           | 143 ++++++++
 11 files changed, 932 insertions(+), 43 deletions(-)
 create mode 100644 delta-islands.c
 create mode 100644 delta-islands.h
 create mode 100755 t/t5319-delta-islands.sh

-- 
2.18.0.554.gdb07901040.dirty

