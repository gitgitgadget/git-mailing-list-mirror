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
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D0EA1F4B7
	for <e@80x24.org>; Tue, 25 Jun 2019 13:41:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729416AbfFYNlI (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jun 2019 09:41:08 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39792 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727770AbfFYNlH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jun 2019 09:41:07 -0400
Received: by mail-ed1-f68.google.com with SMTP id m10so27234710edv.6
        for <git@vger.kernel.org>; Tue, 25 Jun 2019 06:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hRy5W7QDVuvekzZFtp8Me4yl8gfkz5JWoDxoqxZ3Nzs=;
        b=OpdsD2MJIXxNoDXYOjKrMxMYYTVUiWcwYO1I0sBPDRf1q2hJEuusbmMU298PFOjqqB
         czCYjObJr0YQ3JPPQDy4d48GFu768gUW1V9R7P4k2O8diM5JK5hBgBD5gRqO3pUvqJD4
         qMWXCoAyFamckVn8p8C3TV5/xyiHhOqkaIW5uGf8NnFwzWLKfTxmlPUS+hpsBSUOgI5o
         vU7HgtBAylDv4llQ0wJOMrvLJ8hnnWgf0BpmZAMStrDgBOYGIPXX3sqIUeEQwgcH+uea
         hboabEKZGQdrT0k9jJdmq7cd7nw75pWymf7RDu/F2NbcIlsXHAb6epoTZZvRsrjLCm1P
         1YSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hRy5W7QDVuvekzZFtp8Me4yl8gfkz5JWoDxoqxZ3Nzs=;
        b=eG5E5jZgSGwEaz0UNJMghs2E4rL9xJ6FYh2iP3CX0qVEJYM12mVnLvVBfE+ICRl+jS
         HUfnHLNo4u3pl86/fdYgopBeU0D+BZlGbKZNYhWra+ZrjAgKzSLYp08Jd8E4vc2XDum3
         C7IF+NeT5isdUsXhR6EleYnyeoZ5Pup7BOYE1b1wSmsTKy823O+C5NWh3HeJqEQraXtW
         p1ndqsTu6JOF8HeoB/NRUml2zm0LAzvDqnRdiuzuoqWeqMDZl5iXdBquqIYx0O95qCS2
         PpEC4Bs0dY7WpNyVvJTl3JGpG1WM4AnBI4rV6VZW+2cHODHzOiqVVwnbg6zuNdrEsgGy
         gRKw==
X-Gm-Message-State: APjAAAVfRjGxov/o2DAaMXBjZ1Q9y2AC9xq9OQwOfQfILXPfuuOXtaqA
        3HkWXCN1wtl9t4CXX7u93Op3QlXPpOw=
X-Google-Smtp-Source: APXvYqxM/SEFjOQlXmTM51s4MX7mX5urG9GZKdjYeCjnGwob2Ke+s0F5LO6fMzCWri/E2X0V+OrR9A==
X-Received: by 2002:a50:94b1:: with SMTP id s46mr71366101eda.188.1561470065154;
        Tue, 25 Jun 2019 06:41:05 -0700 (PDT)
Received: from ubuntu-N150ZU.booking.pcln.com (access-114.38.rev.fr.colt.net. [213.41.38.114])
        by smtp.gmail.com with ESMTPSA id v11sm2448445ejx.24.2019.06.25.06.41.04
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 25 Jun 2019 06:41:04 -0700 (PDT)
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
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: [PATCH v6 00/15] Many promisor remotes
Date:   Tue, 25 Jun 2019 15:40:24 +0200
Message-Id: <20190625134039.21707-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.22.0.229.ga13d9ffdf7.dirty
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series is based on master as of 8dca754b1e (The third batch, 2019-06-21).

It was previously based on jt/batch-fetch-blobs-in-diff, but this has
been merged into master.

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

I plan to take a look at improving that soon.

In general I have tried to change as few things as possible in the
first patches of the series, though the last patches try to hide the
old features that only made sense for the general code to use when
there was only one promisor remote.

High level view of changes since the V5
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The only patchs that changed since V5 are:  

  - Patch 4/15 (promisor-remote: implement promisor_remote_get_direct())

The new OBJECT_INFO_SKIP_FETCH_OBJECT flag is used instead of using
the ugly fetch_if_missing global variable as suggested by Stolee.

Also, "missing" in variable names has been replaced with "remaining"
as suggested by Stolee.

  - Patch 7/15 (Use promisor_remote_get_direct() and
    has_promisor_remote())

The changes to diff.c that were in patch 8/16 in V5 have been squashed
into this patch as the squashed patch applied to diff.c the same
changes that are made in this patch. They were in a separate patch
because the changes in diff.c needed to be made only if the
jt/batch-fetch-blobs-in-diff series was merged, which has happened.

Some similar changes in builtin/index-pack.c were also added to this
patch. They were necessary since 8a30a1efd1 (index-pack: prefetch
missing REF_DELTA bases, 2019-05-14) has been merged.

High level overview of old patches in this patch series
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

   - Patch 1/15 (t0410: remove pipes after git commands)

This is a preparatory cleanup patch to improve t0410 as suggested by
Szeder Gábor.

  - Patch 2/15 (fetch-object: make functions return an error code)

This patch, makes functions in fetch-object.c return an error code,
which is necessary to later tell that they failed and try another
promisor remote when there is more than one. This could also just be
seen as a fix to these functions.

  - Patch 3/15 (Add initial support for many promisor remotes)

This introduces the minimum infrastructure for promisor remotes.

  - Patch 4/15 (promisor-remote: implement promisor_remote_get_direct()) 
  - Patch 5/15 (promisor-remote: add promisor_remote_reinit())
  - Patch 6/15 (promisor-remote: use repository_format_partial_clone)

These patches add a few missing bits in the promisor remote
infrastructure that will be needed in the following patches.

  - Patch 7/15 (Use promisor_remote_get_direct() and has_promisor_remote())

This replaces the previous interface that used only one promisor
remote defined in extensions.partialclone with the new interface
created by the previous patches.

  - Patch 8/15 (promisor-remote: parse remote.*.partialclonefilter)

This replaces the way a partial clone filter was handled by a new way
based on the previous patches that support more than one partial clone
filter.

  - Patch 9/15 (builtin/fetch: remove unique promisor remote limitation)

This patch removes the limitation in builtin/fetch.c to have only one
promisor remote.

  - Patch 10/15 (t0410: test fetching from many promisor remotes)

This adds test cases that shows that now more than one promisor remote
can be used and that remote.<name>.promisor is set to "true" when
fetching from a new promisor remote.

  - Patch 11/15 (partial-clone: add multiple remotes in the doc)
  - Patch 12/15 (remote: add promisor and partial clone config to the doc)

These documentation patches explain how things can work with more than
one promisor remote.

  - Patch 13/15 (Remove fetch-object.{c,h} in favor of promisor-remote.{c,h})
  - Patch 14/15 (Move repository_format_partial_clone to promisor-remote.c)
  - Patch 15/15 (Move core_partial_clone_filter_default to promisor-remote.c)

These patches try to hide the old features (fetch_objects(),
repository_format_partial_clone and core_partial_clone_filter_default)
that only made sense for the general code to use when there was only
one promisor remote. This ensures that there will be compilation
errors rather than bugs or test failures if the old features are used
in the old fashion way.

Links
~~~~~

This patch series on GitHub:

V6: https://github.com/chriscool/git/commits/many-promisor-remotes
V5: https://github.com/chriscool/git/commits/many-promisor-remotes68
V4: https://github.com/chriscool/git/commits/many-promisor-remotes58
V3: https://github.com/chriscool/git/commits/many-promisor-remotes40
V2: https://github.com/chriscool/git/commits/many-promisor-remotes35
V1: https://github.com/chriscool/git/commits/many-promisor-remotes17

On the mailing list:

V5: https://public-inbox.org/git/20190409161116.30256-1-chriscool@tuxfamily.org/
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

Christian Couder (15):
  t0410: remove pipes after git commands
  fetch-object: make functions return an error code
  Add initial support for many promisor remotes
  promisor-remote: implement promisor_remote_get_direct()
  promisor-remote: add promisor_remote_reinit()
  promisor-remote: use repository_format_partial_clone
  Use promisor_remote_get_direct() and has_promisor_remote()
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
 builtin/index-pack.c                      |   8 +-
 builtin/repack.c                          |   3 +-
 cache-tree.c                              |   3 +-
 cache.h                                   |   2 -
 config.c                                  |   5 -
 connected.c                               |   3 +-
 diff.c                                    |   9 +-
 environment.c                             |   2 -
 fetch-object.c                            |  40 ----
 fetch-object.h                            |   9 -
 list-objects-filter-options.c             |  51 +++--
 list-objects-filter-options.h             |   3 +-
 packfile.c                                |   3 +-
 promisor-remote.c                         | 265 ++++++++++++++++++++++
 promisor-remote.h                         |  31 +++
 setup.c                                   |   3 +-
 sha1-file.c                               |  15 +-
 t/t0410-partial-clone.sh                  |  61 ++++-
 t/t5601-clone.sh                          |   3 +-
 t/t5616-partial-clone.sh                  |   4 +-
 unpack-trees.c                            |   8 +-
 27 files changed, 523 insertions(+), 172 deletions(-)
 delete mode 100644 fetch-object.c
 delete mode 100644 fetch-object.h
 create mode 100644 promisor-remote.c
 create mode 100644 promisor-remote.h

-- 
2.22.0.229.ga13d9ffdf7.dirty

