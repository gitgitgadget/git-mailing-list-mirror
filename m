Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8465D1F404
	for <e@80x24.org>; Mon,  3 Sep 2018 14:49:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726022AbeICTKK (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Sep 2018 15:10:10 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43494 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbeICTKK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Sep 2018 15:10:10 -0400
Received: by mail-wr1-f68.google.com with SMTP id k5-v6so918112wre.10
        for <git@vger.kernel.org>; Mon, 03 Sep 2018 07:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SoUwMXfjGswxtqqTa4Pk08budeYbV58Q0HxiXOLIuzs=;
        b=k4E1QEfmqjAoK2vtA7EuMUDL0ERI2spb1nvdFE+ePHlBzbMUuB2VgIvhsNoGFRkfmN
         DdUubfXpzDzFQjvLkLO1DPHyzk1fz/fkvwhPItsbQVa9jNQS/Xu4uv/HqFjuLEAC827d
         zyvORUhkVTrzKlOVZwGMeZ3RH0NLTlCSSkqUy9Y3YvBnvGBuM3Y5tsMiBcohyBkwqaIR
         T5A4N6w8w3yAfEA7voA7KdvO19RkHzfHCoYmxAVvzD0f36dy8Hg96QiqsI4eWpxIztnR
         Mf281t2cvFSiKyJtk9QlgEXYiGW0Y6wags9z1gwlpRRHxgryS2Ae5rT51qC6/vDMG5/S
         2LCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SoUwMXfjGswxtqqTa4Pk08budeYbV58Q0HxiXOLIuzs=;
        b=CX1pF/7HgKHMrqujtjRJY7PjIezdF5zBF+2w18PEy2ryxz3jIUv+QJ+hkIGvqozcXq
         M/qDoV89ZoZ2N1Lsb1F5g/09gAHjpPm6s8sa1BgaIbtp00NqoADBKiSEWXO7SFUGFVes
         uf+gdKMg0PLXne51tbYDUcAfVASRHJyzHKrvUHQiwit0jzIt7wGDB6aOVuRksRGZnSl9
         jevcaoLdh1/nqfGS0GATMopfeeHPPZ4Y2DOUeLN5L2tibVMU3e85xI5QXBi46nbkvb9V
         j1wmUbD/g3/bNzfTMkSJEOQbtuORPUiwYAW+yqQq97sOLl5uSqRG9Kn6+SRDveSuyRy2
         gRNw==
X-Gm-Message-State: APzg51DtSXv31M9hMgjpDg45CC5qesrOGLrKx4AKB6LVuCgkFx4PxWDc
        YKeH6hOWf7Rl8NOKzU3+TwycONzc
X-Google-Smtp-Source: ANB0VdZar8VPeTfxbT7ihw4dUTnAClG1KbvreiD+Ah9z2MbfrqvhigMKT+MJgMpk+KZBXIlEgNIdKA==
X-Received: by 2002:adf:b69a:: with SMTP id j26-v6mr19588982wre.55.1535986178911;
        Mon, 03 Sep 2018 07:49:38 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id e133-v6sm23841649wma.33.2018.09.03.07.49.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Sep 2018 07:49:38 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 00/10] use oidset for skiplist + docs + tests + comment support
Date:   Mon,  3 Sep 2018 14:49:18 +0000
Message-Id: <20180903144928.30691-1-avarab@gmail.com>
X-Mailer: git-send-email 2.19.0.rc1.350.ge57e33dbd1
In-Reply-To: <2b31e12e-20e9-3d08-58bd-977f8b83e0a7@web.de>
References: <2b31e12e-20e9-3d08-58bd-977f8b83e0a7@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Addresses feedback René had on v4. Notes below:

René Scharfe (3):
  fsck: add a performance test for skipList
  fsck: use strbuf_getline() to read skiplist file

No changes.

  fsck: use oidset instead of oid_array for skipList

Now we note in the commit message that the skipList is re-consulted
for .gitmodules blobs, as René pointed out.

Ævar Arnfjörð Bjarmason (7):
  fsck tests: setup of bogus commit object
  fsck tests: add a test for no skipList input

No changes.

  fsck: document and test sorted skipList input

Trivial whitespace change in new docs paragraph.

  fsck: document and test commented & empty line skipList input

No changes.

  fsck: document that skipList input must be unabbreviated

NEW: Now we document & test for the SHA-1s on the skip list being
unabbreviated. It was always like this, but let's say so / test for
it.

  fsck: add a performance test

NEW: Add a generic new fsck perf test while I'm at it, in addition to
the more specific one René wrote.

  fsck: support comments & empty lines in skipList

The major change this time around, we now support trailing comments,
leading whitespace before comments, whitespace-only lines etc. I went
one step further than what René suggested and decided to just call
strbuf_trim() so now we also support SHA-1s with leading spaces. I
don't see a good reason to go out of our way to ban those, and it's
consistent with other formats we use (and perhaps people will use this
to align them in some way).

 Documentation/config.txt        | 23 ++++++++---
 fsck.c                          | 60 +++++++++++++--------------
 fsck.h                          |  8 ++--
 t/perf/p1450-fsck.sh            | 13 ++++++
 t/perf/p1451-fsck-skip-list.sh  | 40 ++++++++++++++++++
 t/t5504-fetch-receive-strict.sh | 72 +++++++++++++++++++++++++++++++--
 6 files changed, 171 insertions(+), 45 deletions(-)
 create mode 100755 t/perf/p1450-fsck.sh
 create mode 100755 t/perf/p1451-fsck-skip-list.sh

-- 
2.19.0.rc1.350.ge57e33dbd1

