Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D4ECA207B9
	for <e@80x24.org>; Tue, 18 Apr 2017 21:37:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753440AbdDRVhk (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Apr 2017 17:37:40 -0400
Received: from mail-pg0-f54.google.com ([74.125.83.54]:34152 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751691AbdDRVhj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2017 17:37:39 -0400
Received: by mail-pg0-f54.google.com with SMTP id s64so2403995pgb.1
        for <git@vger.kernel.org>; Tue, 18 Apr 2017 14:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=f+6aEBb+ifFFPzzSSvX6mie9dqzBLfB/46kwU9CHvA4=;
        b=qjt620ubHVAbU5ey0JMjmtn3VpBT1SR21WMM9v4rH6hQrZKgTJTZnALlO5Yl3HsXI0
         cvLjiOS3by0YQNBmZ029rJNXdrAx22qn0IDcU/ncwPh9xRvqnG67upZzBBZccDRbfiJf
         Ba7STCQdRCdYxNSynrg87GQmyQ8VooeBr6JOMk/FX6kHdeSFKJQPciSEMIVDg1r0Xyu9
         N33+nCPpZrzn115tL69+qTEDHr3VukH/2/VlAEjn4ldFGgk4vzZOMbWUBzguQXPIZRaD
         rSTFBJV6p/HUxg555Qklifxs98R2hlHHgOyomc3GyRPJpHWcMnjL+h3agkIqD5LWO2pG
         eV/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=f+6aEBb+ifFFPzzSSvX6mie9dqzBLfB/46kwU9CHvA4=;
        b=mG2Cds2CtKWn64j8mS5Ze1yqTG9GgFhndigt+rWOpEtzQuztavXQN8REkON3n8YvJJ
         7zAtUufldO/imRfzt8WIXhAGmMJhFMuF+VPIE4UZKQN5M20uuYnLdpsMFgrJPyEK4glT
         eyMwn8Qj7eQlxAarKZyMSEU84jgxVex8ioNu4uilIZBtjZhgp01vn1p4HoXRQs/cbcbW
         jBgmA/wUH0HvCIIh4qsdmOZjGjzQfTAl218W+LexNqAT2gFECHnZsb4sqqPdpLzT0I0k
         mT9UnQoqBgdhhogwPjWhhSuUojCCgGRc+sScEWFaeL8ihMyqw2a20Tjfgp3o9w5hf3ma
         g9BA==
X-Gm-Message-State: AN3rC/7vspPPKgbJWL9XEgiHxfbEe31SSeJJesbBG1F5jykdsa/awiW8
        w7C8bu3liyZzSpXyfk0Sbg==
X-Received: by 10.84.230.131 with SMTP id e3mr26652127plk.100.1492551457219;
        Tue, 18 Apr 2017 14:37:37 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:c47b:4f4d:6233:ff9f])
        by smtp.gmail.com with ESMTPSA id f6sm333512pfe.57.2017.04.18.14.37.36
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 18 Apr 2017 14:37:36 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     bmwill@google.com
Cc:     git@vger.kernel.org, jrnieder@gmail.com, gitster@pobox.com,
        jonathantanmy@google.com, philipoakley@iee.org,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 0/4] recursive submodules: git-reset!
Date:   Tue, 18 Apr 2017 14:37:21 -0700
Message-Id: <20170418213725.7901-1-sbeller@google.com>
X-Mailer: git-send-email 2.12.2.642.g1b8cc69eee.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v2:
* improved commit message to be proper English (Thanks, Philip!)
* clarified why the patch 2 is so short (i.e. it doesn't matter if the submodule
  is initialized in the preparation repo, we care about the actual testing repo!
  Thanks, Brandon)
* reworded patch 1 (Thanks Jonathan)

Thanks,
Stefan

v1: https://public-inbox.org/git/20170411234923.1860-1-sbeller@google.com/

Now that the BIG one has landed, e394fa01d6 (Merge branch
'sb/checkout-recurse-submodules', 2017-03-28), you would expect that
teaching to recurse into submodules is easy for all the remaining 
working tree manipulations?

It turns out it is. See the last patch how we teach git-reset to recurse
into submodules.

However when thinking more about what git-reset is expected to do,
I added tests and some fixes for them (patch 2+3).

patch 1 is a correctness thing, required for patch 3.

Thanks,
Stefan

Stefan Beller (4):
  entry.c: submodule recursing: respect force flag correctly
  submodule.c: uninitialized submodules are ignored in recursive
    commands
  submodule.c: submodule_move_head works with broken submodules
  builtin/reset: add --recurse-submodules switch

 builtin/reset.c            | 30 ++++++++++++++++++++++++++++++
 entry.c                    |  8 ++++----
 submodule.c                | 31 +++++++++++++++++++++++++++----
 t/lib-submodule-update.sh  | 24 +++++++++++++++++++++---
 t/t7112-reset-submodule.sh |  8 ++++++++
 unpack-trees.c             |  7 ++++++-
 6 files changed, 96 insertions(+), 12 deletions(-)


