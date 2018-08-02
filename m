Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FCA8208E9
	for <e@80x24.org>; Thu,  2 Aug 2018 06:15:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbeHBIFA (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Aug 2018 04:05:00 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40434 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbeHBIE7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 04:04:59 -0400
Received: by mail-wr1-f68.google.com with SMTP id h15-v6so862096wrs.7
        for <git@vger.kernel.org>; Wed, 01 Aug 2018 23:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uY7pL4CWZ41sUBzqfwoiCsH00ehOTjsTgwg123I02Dc=;
        b=KYbdT4zdg7ebKPJIXiyKxlNj0L+sB5iee9Byd7OHdO2iGz9TSkKeSZlO6b0snjSwvn
         YAHQwitO4xoYsC195qPRApbsPxEJA666qoAq0XUQfRPf5CqOkdgaJC4lQ6bg8ExECLlv
         9+/QroRarjvTj3jyWYieDOrOsI1A4M3TdFFGOhrY6ZjjUwI392YuaPHlk8yBW5Zzxaq0
         yX/WPJQMXqjriV59L/y/1uWwdNH2bJb46/L1PvuZKG5bCcbQHXOM/++toWV+yTkhdSkS
         oYd6yTH/LCKwjIEK9mse2bZoC1iQYRP6aGQQ1wi/vu6+P8zcsjgAdMo95P4o0Ole8X6I
         R7Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uY7pL4CWZ41sUBzqfwoiCsH00ehOTjsTgwg123I02Dc=;
        b=MEbeL4fEb8sEbda+n8O8epI3UtZ2BN2XBEooGYX8v8U4e1tMvm6Hv0C0fsjwBVbRxe
         gvn3X3Xr6AJnVrmrK0KgFUIQ9+8j5BagIC7EqF7MHOOaw0K6oYm/iBQ0O4XQFgcBLU+X
         P9AbbTMnjJVO/phzdzJshz37T0ekfKLoJHdGfiGHNjzlsz7/CBgZd5xmq/HlDzQIM2Ks
         /TWozzsVTxd1P9syDP9DD/5AmxHGSX4s1VbZXVtZ9+0rwAYnJY8H32jRYt+kwdEc6R8b
         nF+ZH/XZCX9i8cDYVGmcxgWQVlTgeMv7ObaL+DZinfSJKRECUx1+Tcla3Gg5nc172H8E
         xsAA==
X-Gm-Message-State: AOUpUlHwuekB39BGp263/HQnWcE4KwYZ9518cgU5ugrLzPh8tujD2lWb
        O7daoOMy6Z/xK4SWC+19ELjP0/iw
X-Google-Smtp-Source: AAOMgpdJgsYH+p9Xcf4EhY7UCr6xpnQZcL/GXmyjpg2BYp/oIoX7Hn+9NwbNIiBJglTgpqa9V5lwtg==
X-Received: by 2002:a5d:694e:: with SMTP id r14-v6mr856182wrw.278.1533190525811;
        Wed, 01 Aug 2018 23:15:25 -0700 (PDT)
Received: from localhost.localdomain ([2a04:cec0:109f:b149:1092:6e1:496b:fd26])
        by smtp.gmail.com with ESMTPSA id m200-v6sm1093018wma.32.2018.08.01.23.15.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Aug 2018 23:15:25 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH v4 0/9] Introducing remote ODBs
Date:   Thu,  2 Aug 2018 08:14:56 +0200
Message-Id: <20180802061505.2983-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.18.0.330.g17eb9fed90
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This path series is a follow up from the patch series called "odb
remote" that I sent earlier this year, which was itself a follow up
from previous series. See the links section for more information.

As with the previous "odb remote" series, this series is only about
integrating with the promisor/narrow clone work and showing that it
makes it possible to use more than one promisor remote. Everything
that is not necessary for that integration has been removed for now
(though you can still find it in one of my branches on GitHub if you
want).

There is one test in patch 8/9 that shows that more than one promisor
remote can now be used, but I still feel that it could be interesting
to add other such tests, so I am open to ideas in this area.

Changes compared to V3 of this patch series
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  - the remote_odb_reinit() function is not "inline" anymore in patch
    5/9 as suggested by Beat Bolli in:

    https://public-inbox.org/git/20180724215223.27516-3-dev+git@drbeat.li/

High level overview of this patch series
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

All the patches except 5/9 are unchanged compared to V3.

  - Patch 1/9:

This makes functions in fetch-object.c return an error code, which is
necessary to later tell that they failed and try another remote odb
when there is more than one. This could also just be seen as a fix to
these functions.

  - Patch 2/9:

This introduces the minimum infrastructure for remote odbs.

  - Patches 3/9 and 4/9:

These patches implement remote_odb_get_direct() and
remote_odb_get_many_direct() using the functions from fetch-object.c.
These new functions will be used in following patches to replace the
functions from fetch-object.c.

  - Patch 5/9:

This implement remote_odb_reinit() which will be needed to reparse the
remote odb configuration.

  - Patches 6/9 and 7/9:

These patches integrate the remote odb mechanism into the
promisor/narrow clone code. The "extensions.partialClone" config
option is replaced by "odb.<name>.promisorRemote" and
"core.partialCloneFilter" is replaced by
"odb.<name>.partialCloneFilter".

  - Patch 8/9:

This adds a test case that shows that now more than one promisor
remote can be used.

  - Patch 9/9:

This starts documenting the remote odb mechanism.

Discussion
~~~~~~~~~~

I am not sure that it is ok to completely replace the
"extensions.partialclone" config option. Even if it is fully replaced,
no "extensions.remoteodb" is implemented in these patches, as maybe
the "extensions.partialclone" name could be kept even if the
underlying mechanism is the remote odb mechanism.

Anyway I think that the remote odb mechanism is much more extensible,
so I think using "extensions.partialclone" to specify a promisor
remote should be at least deprecated.

Links
~~~~~

This patch series on GitHub:

V4: https://github.com/chriscool/git/commits/remote-odb
V3: https://github.com/chriscool/git/commits/remote-odb3
V2: https://github.com/chriscool/git/commits/remote-odb2
V1: https://github.com/chriscool/git/commits/remote-odb1

Discussions related to previous versions:

V3: https://public-inbox.org/git/20180713174959.16748-1-chriscool@tuxfamily.org/
V2: https://public-inbox.org/git/20180630083542.20347-1-chriscool@tuxfamily.org/
V1: https://public-inbox.org/git/20180623121846.19750-1-chriscool@tuxfamily.org/

Previous "odb remote" series:

https://public-inbox.org/git/20180513103232.17514-1-chriscool@tuxfamily.org/
https://github.com/chriscool/git/commits/odb-remote

Version 1 and 2 of the "Promisor remotes and external ODB support" series:

https://public-inbox.org/git/20180103163403.11303-1-chriscool@tuxfamily.org/
https://public-inbox.org/git/20180319133147.15413-1-chriscool@tuxfamily.org/

Version 1 and 2 of the "Promisor remotes and external ODB support" series on GitHub:

https://github.com/chriscool/git/commits/gl-small-promisor-external-odb12
https://github.com/chriscool/git/commits/gl-small-promisor-external-odb71

Christian Couder (9):
  fetch-object: make functions return an error code
  Add initial remote odb support
  remote-odb: implement remote_odb_get_direct()
  remote-odb: implement remote_odb_get_many_direct()
  remote-odb: add remote_odb_reinit()
  Use remote_odb_get_direct() and has_remote_odb()
  Use odb.origin.partialclonefilter instead of core.partialclonefilter
  t0410: test fetching from many promisor remotes
  Documentation/config: add odb.<name>.promisorRemote

 Documentation/config.txt      |   5 ++
 Makefile                      |   2 +
 builtin/cat-file.c            |   5 +-
 builtin/fetch.c               |  13 ++--
 builtin/gc.c                  |   3 +-
 builtin/repack.c              |   3 +-
 cache.h                       |   2 -
 connected.c                   |   3 +-
 environment.c                 |   1 -
 fetch-object.c                |  15 ++--
 fetch-object.h                |   6 +-
 list-objects-filter-options.c |  51 +++++++------
 list-objects-filter-options.h |   3 +-
 odb-helper.c                  |  45 +++++++++++
 odb-helper.h                  |  24 ++++++
 packfile.c                    |   3 +-
 remote-odb.c                  | 137 ++++++++++++++++++++++++++++++++++
 remote-odb.h                  |  10 +++
 setup.c                       |   7 +-
 sha1-file.c                   |  14 ++--
 t/t0410-partial-clone.sh      |  58 +++++++++-----
 t/t5500-fetch-pack.sh         |   4 +-
 t/t5601-clone.sh              |   2 +-
 t/t5616-partial-clone.sh      |   4 +-
 t/t5702-protocol-v2.sh        |   2 +-
 unpack-trees.c                |   6 +-
 26 files changed, 342 insertions(+), 86 deletions(-)
 create mode 100644 odb-helper.c
 create mode 100644 odb-helper.h
 create mode 100644 remote-odb.c
 create mode 100644 remote-odb.h

-- 
2.18.0.330.g17eb9fed90

