Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 148CB202AB
	for <e@80x24.org>; Thu, 29 Jun 2017 23:53:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751827AbdF2Xxw (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Jun 2017 19:53:52 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:35919 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751782AbdF2Xxr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jun 2017 19:53:47 -0400
Received: by mail-pg0-f44.google.com with SMTP id u62so54990055pgb.3
        for <git@vger.kernel.org>; Thu, 29 Jun 2017 16:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mgsXa6vXuG4PYdMeEAESmOKyJ7K99KLJ2YHDSrkUAWU=;
        b=FID2I+sugBESfwj4GAqnw2cAs32bbpMKUS4h+pzBgbOoKGVigxBbFoIWxU0YP0+2Zr
         61MX110ex3xwYZ4dwXsNnvi/scYNaitfdLuFvJp7mAkU4sppygEhxRWg0iS9N0ZMiehr
         KI3vjPsgZpNF0CLtuvbxLwsgw8mB2JteTLQREOx92fXf4ToiR/byZxxwezhpgJfFdnOq
         7F9DX0c1mKKr93AEyXJHieuGBv6HmEAiE1PWCTUVhjsGmo7B9GO7zyx/XF14n+bHi8Ar
         eI+Up+XKFWSXLBvFG7rjU0uAL4fl8nHYozcMkCTkxyTR3HvP3BbYOx0fOTo/S7/0nNnO
         Najg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mgsXa6vXuG4PYdMeEAESmOKyJ7K99KLJ2YHDSrkUAWU=;
        b=mtz6mCnK9zGXmGiqOR1ViJECehf/2z+ou5JM3YgC+Gn0Pv/2dZRRHaQ6pDhydp0jhh
         p4IwJa0JI2JXcWNk2zeo9ybV+m+69MTb8Su9vzhH5qqqEV6PuCdMrx61tMQsXq2Frvu+
         LzXtkS1kvuh61Xshdp/aevO9MK9D3djvRsYiFIbBr+xjGGRq3L9iJqhjzR1Jt8eLVUex
         U5S8qUjZI4Yeo7BXX+/lcrjqqHUgI3gOYyPlcUn/6jf5saacpAVHVYgysmOEwTgbDy75
         aJey1IJQBc2AQHxCXhKGJoSRTNg1iD3yxk8k6u2NZq3gd7owrRyVlcYVFHAuFmdZ/MWD
         Ghsw==
X-Gm-Message-State: AKS2vOwQ86V7dmP9Dj2M1vDoVokBbXIBqCQ6qyenqjFle+11BZm8+9xD
        02yby1Xsz7q9fMz6
X-Received: by 10.98.89.13 with SMTP id n13mr19551341pfb.184.1498780421177;
        Thu, 29 Jun 2017 16:53:41 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:c3c:7a18:f5d8:50e0])
        by smtp.gmail.com with ESMTPSA id q127sm11033788pga.62.2017.06.29.16.53.40
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 29 Jun 2017 16:53:40 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, jrnieder@gmail.com,
        git@jeffhostetler.com
Subject: [PATCHv2 0/2] Introduce data field in hashmap and migrate docs to header
Date:   Thu, 29 Jun 2017 16:53:34 -0700
Message-Id: <20170629235336.28460-1-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.31.g9b732c453e
In-Reply-To: <20170629011334.11173-1-sbeller@google.com>
References: <20170629011334.11173-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v2:

addressed all but the last point of Jonathan Nieder.

Thanks,
Stefan

v1:

https://public-inbox.org/git/xmqqpodnvmmw.fsf@gitster.mtv.corp.google.com/
for context why we need a new data field.  Implement that.

Once upon a time we had a long discussion where to put documentation best.
The answer was header files as there documentation has less chance
to become stale and be out of date.  Improve the docs by
* migrating them to the header
* clarifying how the compare function is to be used
* how the arguments to hashmap_get/remove should be used.

Thanks,
Stefan

Stefan Beller (2):
  hashmap.h: compare function has access to a data field
  hashmap: migrate documentation from Documentation/technical into
    header

 Documentation/technical/api-hashmap.txt | 309 ---------------------------
 attr.c                                  |   4 +-
 builtin/describe.c                      |   6 +-
 builtin/difftool.c                      |  20 +-
 builtin/fast-export.c                   |   5 +-
 config.c                                |   7 +-
 convert.c                               |   3 +-
 diffcore-rename.c                       |   2 +-
 hashmap.c                               |  17 +-
 hashmap.h                               | 358 ++++++++++++++++++++++++++++----
 name-hash.c                             |  12 +-
 oidset.c                                |   5 +-
 patch-ids.c                             |   6 +-
 refs.c                                  |   4 +-
 remote.c                                |   7 +-
 sha1_file.c                             |   5 +-
 sub-process.c                           |   5 +-
 sub-process.h                           |   6 +-
 submodule-config.c                      |  10 +-
 t/helper/test-hashmap.c                 |  15 +-
 20 files changed, 412 insertions(+), 394 deletions(-)
 delete mode 100644 Documentation/technical/api-hashmap.txt

-- 
2.13.0.31.g9b732c453e

