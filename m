Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB38E2037F
	for <e@80x24.org>; Tue,  9 Apr 2019 16:11:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbfDIQLp (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Apr 2019 12:11:45 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39539 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbfDIQLp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Apr 2019 12:11:45 -0400
Received: by mail-wm1-f66.google.com with SMTP id n25so3992650wmk.4
        for <git@vger.kernel.org>; Tue, 09 Apr 2019 09:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qnSOEALFd7PigILyzqQFEW1XBU+ZwLoHgd+LLhd8Ar0=;
        b=Fn2Eek6DerSbJi3qCeVNMEZjh76fCI5I4O1XmedWw+jWBYqTbBQNy3eVSCswqsgYAD
         mUNAZ7+ZgIiqGSRlF3T371PtTsgyvJ41q9ESw45evWirZ0NHgmlDlA21i7jjDZGUnfoB
         uTk1+FOdnO37ekYGAYjR60R/e44MFX2J/uoen5MKRVgQEdK6E3qpDUGqLwKWTMjS6OUy
         YFs1Qy22SAgeRU3Wc02SluGWkwCwjFyYnPUomwhGGzP49t+u9pn+hryhKp3aXQIoDq51
         XG/5nuj0Pk7cPLcQBeptZN4vQ+Hy7PtSjxomaSEEDk9GfRT6f5+NkLQRachaWb3spNHv
         bhTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qnSOEALFd7PigILyzqQFEW1XBU+ZwLoHgd+LLhd8Ar0=;
        b=hEKqwcWIZAtyzUdKV+wEWR4bAmAhw4Qg2fAomEAO2YDsyUUBg0qchIEfKPSKQOFVqi
         1bCFUzb4kiPusfjV6WuGa4XwbZ9Sm68GFtnm/WEWhs6ZuSGfnL8XqoB2RevQRqLwszC9
         JYoF+jihZTq2uINalOVMOksTA5NN+5VPr8H01CxGwLYcYfEmwOAkWjtBef+KpYhKj+NI
         o3EcO5B1ypSJQVDl8Z5Uf6RHLkFJFAJRLLL7QC7/dkJ7LOrOlg21Bgrh5K3KFegqFKVG
         h/3bdJ3iMVqoKq1f0WujMGZy5r/t5/Fxtnkv90nye2yt8ZzGcDuuMzJtGpBfsbFbWNPl
         h5uw==
X-Gm-Message-State: APjAAAXGM5C+e95jm7tK44w1bBQl8YCfAriAvAh5W3iaceg8ApjSzh6G
        5ZifCIbAMsst2Hq2AsJtxB1YLoMh
X-Google-Smtp-Source: APXvYqzOu7Ju+7/js8uGfiHEy9J+A6ToBuxSaYeczEgKv5GlGFQSRYJVMQDkOMfRH9rhOrL+1LjPow==
X-Received: by 2002:a05:600c:2199:: with SMTP id e25mr21710722wme.36.1554826302011;
        Tue, 09 Apr 2019 09:11:42 -0700 (PDT)
Received: from ubuntu-N750HU.booking.pcln.com (access-114.38.rev.fr.colt.net. [213.41.38.114])
        by smtp.gmail.com with ESMTPSA id i2sm4356012wmg.47.2019.04.09.09.11.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 09:11:40 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Beat Bolli <dev+git@drbeat.li>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v5 00/16] Many promisor remotes
Date:   Tue,  9 Apr 2019 18:11:00 +0200
Message-Id: <20190409161116.30256-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.21.0.750.g68c8ebb2ac
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series is based on:

763fb763b8 (Merge branch 'jt/batch-fetch-blobs-in-diff' into jch, 2019-04-08)

to avoid issues with jt/batch-fetch-blobs-in-diff.

Introduction
~~~~~~~~~~~~

This path series is a follow up from the "remote odb" patch series
that I sent last year, which were a follow up from previous
series. See the links section for more information.

The goal of this patch series is to make it possible to have and to
fetch missing objects from multiple remotes instead of only one.

For now the fetch order is the order of the remotes in the config,
except for the remote specified by extensions.partialclone config
option which comes last in the fetch order.

I selected the name "Promisor remote" over "Partial clone remote"
because it is shorter and because it is not only about cloning.

The existing extensions.partialclone config option is respected, but
it is not written in the config when a partial clone or fetch is
made. Instead remote.<name>.promisor is set to "true". This may create
a compatibility issue, but it makes it possible to start using many
promisor remotes by just cloning and fetching from different remotes
with partial clone filters. The compatibility issue could be resolved
in a future iteration by just setting extensions.partialclone instead
of remote.<name>.promisor the first time a promisor remote is used.

The code might not work with many promisor remotes that don't all have
all the promised objects, as that would require the fetch protocol to
send packs with best effort, as described by Junio in:

https://public-inbox.org/git/xmqqpnqve71d.fsf@gitster-ct.c.googlers.com/

In general I have tried to change as few things as possible in the
first patches of the series, though the last patches try to hide the
old features that only made sense for the general code to use when
there was only one promisor remote.

High level view of new patches since the V4
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

There are 5 new patches in this series compared to V4. They are:

  - Patch 1/16 (t0410: remove pipes after git commands) 

This is a preparatory cleanup patch to improve t0410 as suggested by
Szeder Gábor.

  - Patch 8/16 (diff: use promisor-remote.h instead of fetch-object.h)

This patch applies to diff.c the same changes that are made in patch
7/11. They are in a separate patch because the changes need to be made
only if the jt/batch-fetch-blobs-in-diff series is merged. So
depending on what happens to jt/batch-fetch-blobs-in-diff, this patch
can either be squashed into 7/11, be squashed in to
jt/batch-fetch-blobs-in-diff, or be dropped.

  - Patch 14/16 (Remove fetch-object.{c,h} in favor of promisor-remote.{c,h})
  - Patch 15/16 (Move repository_format_partial_clone to promisor-remote.c)
  - Patch 16/16 (Move core_partial_clone_filter_default to promisor-remote.c)

These patches try to hide the old features (fetch_objects(),
repository_format_partial_clone and core_partial_clone_filter_default)
that only made sense for the general code to use when there was only
one promisor remote. This ensures that there will be compilation
errors rather than bugs or test failures if the old features are used
in the old fashion way.

High level view of other changes since the V4
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The title and purpose of the old patches didn't change, but the
following changes were made:

  - Patch 3/16 (Add initial support for many promisor remotes)

Remove check for "r->name" as "name" became a flex array in struct
promisor_remote as suggested by Szeder Gábor and Junio.

  - Patch 4/16 (promisor-remote: implement promisor_remote_get_direct())

Added call to free() "missing" array.

Added "struct object_id;" declaration in "promisor-remote.h".

  - Patch 6/16 (promisor-remote: use repository_format_partial_clone)

Improved explanation about why the remote specified using the
extensions.partialClone config option is tried last.

  - Patch 7/16 (Use promisor_remote_get_direct() and has_promisor_remote())

Remove now useless includes of "fetch-object.h" as suggested by Junio.

  - Patch 11/16 (t0410: test fetching from many promisor remotes)

Improve tests as suggested by Szeder Gábor.

  - Patch 12/16 (partial-clone: add multiple remotes in the doc)

Add explanation in the doc about why the remote specified using the
extensions.partialClone config option is tried last as suggested by
Junio.

Other doc improvements.

High level overview of old patches in this patch series
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  - Patch 2/16 (fetch-object: make functions return an error code)

This patch, makes functions in fetch-object.c return an error code,
which is necessary to later tell that they failed and try another
promisor remote when there is more than one. This could also just be
seen as a fix to these functions.

  - Patch 3/16 (Add initial support for many promisor remotes)

This introduces the minimum infrastructure for promisor remotes.

  - Patch 4/16 (promisor-remote: implement promisor_remote_get_direct())  
  - Patch 5/16 (promisor-remote: add promisor_remote_reinit())
  - Patch 6/16 (promisor-remote: use repository_format_partial_clone)

These patches add a few missing bits in the promisor remote
infrastructure that will be needed in the following patches.

  - Patch 7/16 (Use promisor_remote_get_direct() and has_promisor_remote())

This replaces the previous interface that used only one promisor
remote defined in extensions.partialclone with the new interface
created by the previous patches.

  - Patch 9/16 (promisor-remote: parse remote.*.partialclonefilter)

This replaces the way a partial clone filter was handled by a new way
based on the previous patches that support more than one partial clone
filter.

  - Patch 10/16 (builtin/fetch: remove unique promisor remote limitation)

This patch removes the limitation in builtin/fetch.c to have only one
promisor remote.

  - Patch 12/16 (t0410: test fetching from many promisor remotes)

This adds test cases that shows that now more than one promisor remote
can be used and that remote.<name>.promisor is set to "true" when
fetching from a new promisor remote.

  - Patch 13/16 (partial-clone: add multiple remotes in the doc)
  - Patch 14/16 (remote: add promisor and partial clone config to the doc)

These documentation patches explain how things can work with more than
one promisor remote.

Links
~~~~~

This patch series on GitHub:

V5: https://github.com/chriscool/git/commits/many-promisor-remotes
V4: https://github.com/chriscool/git/commits/many-promisor-remotes58
V3: https://github.com/chriscool/git/commits/many-promisor-remotes40
V2: https://github.com/chriscool/git/commits/many-promisor-remotes35
V1: https://github.com/chriscool/git/commits/many-promisor-remotes17

On the mailing list:

V4: https://public-inbox.org/git/20190401164045.17328-1-chriscool@tuxfamily.org/
V3: https://public-inbox.org/git/20190312132959.11764-1-chriscool@tuxfamily.org/
V2: https://public-inbox.org/git/20190122144212.15119-1-chriscool@tuxfamily.org/
V1: https://public-inbox.org/git/20181211052746.16218-1-chriscool@tuxfamily.org/

This patch series is a follow up from the discussions related to
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


Christian Couder (16):
  t0410: remove pipes after git commands
  fetch-object: make functions return an error code
  Add initial support for many promisor remotes
  promisor-remote: implement promisor_remote_get_direct()
  promisor-remote: add promisor_remote_reinit()
  promisor-remote: use repository_format_partial_clone
  Use promisor_remote_get_direct() and has_promisor_remote()
  diff: use promisor-remote.h instead of fetch-object.h
  promisor-remote: parse remote.*.partialclonefilter
  builtin/fetch: remove unique promisor remote limitation
  t0410: test fetching from many promisor remotes
  partial-clone: add multiple remotes in the doc
  remote: add promisor and partial clone config to the doc
  Remove fetch-object.{c,h} in favor of promisor-remote.{c,h}
  Move repository_format_partial_clone to promisor-remote.c
  Move core_partial_clone_filter_default to promisor-remote.c

 Documentation/config/remote.txt           |   8 +
 Documentation/technical/partial-clone.txt | 117 +++++++---
 Makefile                                  |   2 +-
 builtin/cat-file.c                        |   5 +-
 builtin/fetch.c                           |  29 +--
 builtin/gc.c                              |   3 +-
 builtin/repack.c                          |   3 +-
 cache-tree.c                              |   3 +-
 cache.h                                   |   2 -
 config.c                                  |   5 -
 connected.c                               |   3 +-
 diff.c                                    |   8 +-
 environment.c                             |   2 -
 fetch-object.c                            |  40 ----
 fetch-object.h                            |   9 -
 list-objects-filter-options.c             |  51 +++--
 list-objects-filter-options.h             |   3 +-
 packfile.c                                |   3 +-
 promisor-remote.c                         | 264 ++++++++++++++++++++++
 promisor-remote.h                         |  29 +++
 setup.c                                   |   3 +-
 sha1-file.c                               |  15 +-
 t/t0410-partial-clone.sh                  |  61 ++++-
 t/t5601-clone.sh                          |   3 +-
 t/t5616-partial-clone.sh                  |   4 +-
 unpack-trees.c                            |   7 +-
 26 files changed, 514 insertions(+), 168 deletions(-)
 delete mode 100644 fetch-object.c
 delete mode 100644 fetch-object.h
 create mode 100644 promisor-remote.c
 create mode 100644 promisor-remote.h

-- 
2.21.0.750.g68c8ebb2ac

