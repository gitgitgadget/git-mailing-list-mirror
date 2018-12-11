Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 07E0D211B4
	for <e@80x24.org>; Tue, 11 Dec 2018 05:28:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728627AbeLKF2H (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Dec 2018 00:28:07 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44959 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727711AbeLKF2G (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Dec 2018 00:28:06 -0500
Received: by mail-wr1-f66.google.com with SMTP id z5so12682370wrt.11
        for <git@vger.kernel.org>; Mon, 10 Dec 2018 21:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0EWF9TfGnY2HmvwCIsPGYCJBiwv2YbYNgce7mls2rrw=;
        b=r4vmXEKpu5/5+/63aKJJ58PQD8i0msHDOX2Yrnf6hrKbNz438Gvw1ywATZAUD1NrBs
         Qo0AE/O58jFtctOn2gsqkcLAodw9TgvgACS9c/c5JeU4HnFL+zIPJ5LaCDdJC7JP9iT+
         pSsfAfz2lHbMbrZ85GJgUUkx9RQLN/s0GmmBNXuPMElS5q7RyvD7kcPI1ZuC83oUTpVA
         G9+EQ3MoiYnzQc3ruo4OCVc83NsAz3Wk4nwlIyY+167twdhBo04i8uN2fUZGkpj70EPQ
         CAqUyVaUC/Kw4j4+grpByJ9yLNL+iPewsddWDb0I/abBu2xtHH5IJNwTLG2bTIEHAkcM
         mJ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0EWF9TfGnY2HmvwCIsPGYCJBiwv2YbYNgce7mls2rrw=;
        b=gbnq6J/T+uD0HwpluJViu70jccVJIXb9FnVb7p5ZSVkmrc3a5xKYLvj8rxgegWzphO
         F8zsHOlWmxWUc8ael8YQm+Us4eSgWbxU2960IrTAhAXPGcskVFcJMbSElhHZH8v3kjxV
         u3133tDwI1FxrtNx461bAmlLC1evNKNnv6iHgzrij4L3ZaAe0P3PpyaneugNrp4ke39G
         uTUVoxYuG7cn4iO+9sXR6NVF47UZmnGJSLpZzQCdlBIYVTUDAoGQ3NgEaW1cq8G659lq
         u0m+y2SkE+NBiDO3YrYBWD9mdjNtmHYqAUoHybPq7YnyiZeCwa06Rz3DRNMTr7r3XpFV
         xk+Q==
X-Gm-Message-State: AA+aEWYWe8dQ7tuJDLRxuvtT+X69DZsDmcv5bGRBUmSF90lxUBjh4DQv
        xPr4439G8JVi6LPOiYyx++jMFS8v
X-Google-Smtp-Source: AFSGD/UGgvINHib/qhey+9dVdU2fkC873VHEZ6WoJqi7yEOk6xS5UZ1PDyCOHhDSoimYbiJ7o0zXIA==
X-Received: by 2002:a05:6000:120a:: with SMTP id e10mr12237873wrx.85.1544506084284;
        Mon, 10 Dec 2018 21:28:04 -0800 (PST)
Received: from localhost.localdomain (89-95-107-230.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id l197sm3708185wma.44.2018.12.10.21.28.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 21:28:03 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH v1 0/8] Many promisor remotes
Date:   Tue, 11 Dec 2018 06:27:38 +0100
Message-Id: <20181211052746.16218-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.20.0.rc2.14.g1379de12fa.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This path series is a follow up from the "remote odb" patch series
that I sent earlier this year, which were a follow up from previous
series. See the links section for more information.

The goal of this patch series is to make it possible to have and to
fetch missing objects from multiple remotes instead of only one.

For now the fetch order is the order of the remotes in the config.

I selected the name "Promisor remote" over "Partial clone remote"
because it is shorter and because it is not only about cloning.

The existing extensions.partialclone is respected, but it is not
written in the config when a partial clone or fetch is made. Instead
remote.<name>.promisor is set to "true". This may create a
compatibility issue, but it makes it possible to start using many
promisor remotes by just cloning and fetching from different remotes
with partial clone filters. The compatibility issue could be resolved
in a future iteration by just setting extensions.partialclone instead
of remote.<name>.promisor the first time a promisor remote is used.

In general I have tried to change as few things as possible.

Yeah, this is missing documentation for now.

High level overview of this patch series
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  - Patch 1/8:

This makes functions in fetch-object.c return an error code, which is
necessary to later tell that they failed and try another promisor
remote when there is more than one. This could also just be seen as a
fix to these functions.

  - Patch 2/8:

This introduces the minimum infrastructure for promisor remotes.

  - Patch 3/8, 4/8 and 5/8:

This add a few missing bits in the promisor remote infrastructure that
will be needed in the following patches.

  - Patch 6/8:

This replaces the previous interface to use only one promisor remote
defined in extensions.partialclone by the new interface created by the
previous patches.

  - Patch 7/8:

This replaces the way a partial clone filter was handled by a new way
based on the previous patches that support more than one partial clone
filter.

  - Patch 8/8:

This adds a test case that shows that now more than one promisor
remote can be used.

Links
~~~~~

This new patch series is a follow up from the discussions related to
the remote odb V4 patch series:

https://public-inbox.org/git/20180802061505.2983-1-chriscool@tuxfamily.org/

Especially in:

https://public-inbox.org/git/CAP8UFD3nrhjANwNDqTwx5ZtnZNcnbAFqUN=u=LrvzuH4+3wQQA@mail.gmail.com/

I said that I would like to work on things in the following order:

  1) Teaching partial clone to attempt to fetch missing objects from
multiple remotes instead of only one using the order in the config.

  2) Simplifying the protocol for fetching missing objects so that it
can be satisfied by a lighter weight object storage system than a full
Git server.

  3) Making it possible to explicitly define an order in which the
remotes are accessed.

  4) Making the criteria for what objects can be missing more
aggressive, so that I can "git add" a large file and work with it
using Git without even having a second copy of that object in my local
object store.

And this patch series is about the 1).

This patch series on GitHub:

https://github.com/chriscool/git/commits/many-promisor-remotes

The previous remote odb patch series on GitHub:

V5: https://github.com/chriscool/git/commits/remote-odb
V4: https://github.com/chriscool/git/commits/remote-odb5
V3: https://github.com/chriscool/git/commits/remote-odb3
V2: https://github.com/chriscool/git/commits/remote-odb2
V1: https://github.com/chriscool/git/commits/remote-odb1

Discussions related to previous versions of the odb patch series:

V4: https://public-inbox.org/git/20180802061505.2983-1-chriscool@tuxfamily.org/
V3: https://public-inbox.org/git/20180713174959.16748-1-chriscool@tuxfamily.org/
V2: https://public-inbox.org/git/20180630083542.20347-1-chriscool@tuxfamily.org/
V1: https://public-inbox.org/git/20180623121846.19750-1-chriscool@tuxfamily.org/



Christian Couder (8):
  fetch-object: make functions return an error code
  Add initial support for many promisor remotes
  promisor-remote: implement promisors_get_direct()
  promisor-remote: add promisor_remote_reinit()
  promisor-remote: use repository_format_partial_clone
  Use promisors_get_direct() and has_promisor_remote()
  promisor-remote: parse remote.*.partialclonefilter
  t0410: test fetching from many promisor remotes

 Makefile                      |   1 +
 builtin/cat-file.c            |   5 +-
 builtin/fetch.c               |  13 +--
 builtin/gc.c                  |   3 +-
 builtin/repack.c              |   3 +-
 cache-tree.c                  |   3 +-
 connected.c                   |   3 +-
 fetch-object.c                |  13 +--
 fetch-object.h                |   4 +-
 list-objects-filter-options.c |  51 ++++++------
 list-objects-filter-options.h |   3 +-
 packfile.c                    |   3 +-
 promisor-remote.c             | 147 ++++++++++++++++++++++++++++++++++
 promisor-remote.h             |  22 +++++
 sha1-file.c                   |  14 ++--
 t/t0410-partial-clone.sh      |  26 +++++-
 t/t5601-clone.sh              |   3 +-
 t/t5616-partial-clone.sh      |   4 +-
 unpack-trees.c                |   6 +-
 19 files changed, 269 insertions(+), 58 deletions(-)
 create mode 100644 promisor-remote.c
 create mode 100644 promisor-remote.h

-- 
2.20.0.rc2.14.g1379de12fa.dirty

