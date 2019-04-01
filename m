Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 60A0920305
	for <e@80x24.org>; Mon,  1 Apr 2019 16:41:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728040AbfDAQlJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Apr 2019 12:41:09 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53759 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727021AbfDAQlJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Apr 2019 12:41:09 -0400
Received: by mail-wm1-f67.google.com with SMTP id q16so90578wmj.3
        for <git@vger.kernel.org>; Mon, 01 Apr 2019 09:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2Ah2FrkndEo6divvpICv2Tt5UQ6LiUzi20Yi8ad6iWs=;
        b=Os7+uVzr2p913aKrxkmpPvk6f0oiwI8pk4rs0PjsuQETACGuX00boYLNZfuYbbb7Bm
         Npddo8cW0ZWdVQYeB+eXvZZqDV+B8U6+HYJEOxxf7z47aN7viw231GcVKOmZmcBAwsmL
         +tRKCylGBUfTPliCLEQSvCmEne9ZG4Fg+UploNBXk5Vgj+kJmW+QGKGnUSbSvV91YYu6
         3YFJ9I571CW4kEhfKkMLIHKbgb2E6iGuw4qu4A448qYweOx85h/VlSn7BlZBRE5Sq47Y
         jEPdMbMapZLIFy03Uy7QIZvdGOD/qKevKEd2dG2mz1ebgJoTyBIDrwvbYyLFjE5wOBsi
         g70g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2Ah2FrkndEo6divvpICv2Tt5UQ6LiUzi20Yi8ad6iWs=;
        b=i8/XbmykxPghkwsb3I3hLgs+73LbHey7IhHCILivsHx8Jc6L8/Lwmun0Pt9GfoicGi
         SOW8bjgcF3PUE6c91Gvv6Drfn2P3rqCwlBq0gXznUmo8YxFfhwAJdc0wU73T1DFGb4oe
         C2qfmShFVkMJzl+XkGxbiub9nsGd9CN+Y/Ul+QkoAwVwg0wm9f9BLKq2X+vkf12maYLj
         LNXRI9YOjVf6K08b3hTn3wlRDkIFPllVk6lxbK/SU/Igvkp05rlqpVln4JLpCqpkoXvq
         3B0DbPUEhSD8XS0z7f4sqWBF7cj8cOqLdPXYG6D4TNDYSOtME38sSaLeomTNczkCRdhd
         mw4g==
X-Gm-Message-State: APjAAAV9okVMCKju4uQkpEMzjaUuFgjUDbBE/AhilUu5uHHO0qH5SDCQ
        ygMOi19r/zVeTDBfoR+5B4JQqJU8
X-Google-Smtp-Source: APXvYqxA6XBwLoygBk+zfAsDZdp5dK8niup1mHEIdNyjtGgu55U7KjUnRQDE6ZPF2pCVwD76UHpmGg==
X-Received: by 2002:a1c:7208:: with SMTP id n8mr365516wmc.46.1554136866455;
        Mon, 01 Apr 2019 09:41:06 -0700 (PDT)
Received: from localhost.localdomain ([2a04:cec0:101d:3e80:8542:d1d4:667f:a0da])
        by smtp.gmail.com with ESMTPSA id s10sm11749070wmh.0.2019.04.01.09.41.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 09:41:05 -0700 (PDT)
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
        Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH v4 00/11] Many promisor remotes
Date:   Mon,  1 Apr 2019 18:40:34 +0200
Message-Id: <20190401164045.17328-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.21.0.203.gd44fa53258
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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

In general I have tried to change as few things as possible.

High level changes since the V3
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The number of patches didn't change. Their title and purpose didn't
change either.

The changes were all suggested by Junio.

everywhere:
  - changed name of promisor remote variables from "o" to "r"

patch 2/11:
  - made promisor_remote_new() static
  - changed promisor_remote_look_up() to promisor_remote_lookup()
  - changed struct promisor_remote to use a flex array
  - added check that promisor remote names doesn't start with "/"

patch 3/11:
  - implemented fetching only what is still missing
  - removed trailing blank line

4/11:
  - made "initialized" file static instead of function static
  - added purge of promisor remote list in promisor_remote_reinit()

5/11:
  - improve commit message

High level overview of this patch series
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  - Patch 1/11:

This patch, makes functions in fetch-object.c return an error code,
which is necessary to later tell that they failed and try another
promisor remote when there is more than one. This could also just be
seen as a fix to these functions.

  - Patch 2/11:

This introduces the minimum infrastructure for promisor remotes.

  - Patch 3/11, 4/11 and 5/11:

This add a few missing bits in the promisor remote infrastructure that
will be needed in the following patches.

  - Patch 6/11:

This replaces the previous interface that used only one promisor
remote defined in extensions.partialclone with the new interface
created by the previous patches.

  - Patch 7/11:

This replaces the way a partial clone filter was handled by a new way
based on the previous patches that support more than one partial clone
filter.

  - Patch 8/11:

This patch removes the limitation in builtin/fetch.c to have only one
promisor remote.

  - Patch 9/11:

This adds test cases that shows that now more than one promisor remote
can be used and that remote.<name>.promisor is set to "true" when
fetching from a new promisor remote.

  - Patch 10/11 and 11/11:

These documentation patches explain how things can work with more than
one promisor remote.

Links
~~~~~

This patch series on GitHub:

V3: https://github.com/chriscool/git/commits/many-promisor-remotes
V3: https://github.com/chriscool/git/commits/many-promisor-remotes40
V2: https://github.com/chriscool/git/commits/many-promisor-remotes35
V1: https://github.com/chriscool/git/commits/many-promisor-remotes17

On the mailing list:

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


Christian Couder (11):
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

 Documentation/config/remote.txt           |   8 +
 Documentation/technical/partial-clone.txt |  83 ++++++---
 Makefile                                  |   1 +
 builtin/cat-file.c                        |   5 +-
 builtin/fetch.c                           |  29 +--
 builtin/gc.c                              |   3 +-
 builtin/repack.c                          |   3 +-
 cache-tree.c                              |   3 +-
 connected.c                               |   3 +-
 fetch-object.c                            |  13 +-
 fetch-object.h                            |   4 +-
 list-objects-filter-options.c             |  51 +++---
 list-objects-filter-options.h             |   3 +-
 packfile.c                                |   3 +-
 promisor-remote.c                         | 212 ++++++++++++++++++++++
 promisor-remote.h                         |  21 +++
 sha1-file.c                               |  14 +-
 t/t0410-partial-clone.sh                  |  49 ++++-
 t/t5601-clone.sh                          |   3 +-
 t/t5616-partial-clone.sh                  |   4 +-
 unpack-trees.c                            |   6 +-
 21 files changed, 425 insertions(+), 96 deletions(-)
 create mode 100644 promisor-remote.c
 create mode 100644 promisor-remote.h

-- 
2.21.0.203.gd44fa53258

