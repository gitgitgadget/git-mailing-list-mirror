Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED2551F660
	for <e@80x24.org>; Sat, 30 Jun 2018 08:36:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932357AbeF3IgF (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Jun 2018 04:36:05 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34103 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752046AbeF3IgC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Jun 2018 04:36:02 -0400
Received: by mail-wm0-f68.google.com with SMTP id l15-v6so3691953wmc.1
        for <git@vger.kernel.org>; Sat, 30 Jun 2018 01:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=W90I7mQu7w/16qCdL/BrUe42I0T9vVcP3s5C9T0ym2s=;
        b=FDaix64TTKHzMBW8eRmTRk0/oYPH3qLzSoPNf70+t8QRvnAeWzsbmNpNBEg8VOGFpB
         sKkH681dK2TCfcOkeejIDpBco+PlDS7UNc+HOzoo5EvwtUCCoo9NucE+f257v8oFw3Xk
         3QA9UDoZ+fmRORIvIkeMRqjxehEOOET20U/aQtumjfkCmwRwx5+ivrhC7ZnpvAqf1pLR
         J78SFYNU35H7ki8Wgge7+hvonIYYpbZEYS0iyL9PjMf5NW7SBrfOdQOwaMzDAJPkHYBX
         IrxVGvMXPH2krlYF1x9udTUdwvRIe8+x6ZblBtaRFeuYhFBdfVhAcB70RGqV95cQmL/e
         psQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=W90I7mQu7w/16qCdL/BrUe42I0T9vVcP3s5C9T0ym2s=;
        b=dp+JbFxMzoXUUh8J9YAyKX5w0HIeRQSRwbIlCxvBYOG7PpvYwBmyT0nyfafvUNImZa
         l/RUukPpbDdon3cH2AOEbVLrJlWn1CdJvsdcctcbPddiDO3XLN6Aq4mEVPwC9f4HjAvY
         q/4LVrxW2rlXW8BkNDmVTi0Z295QurNRRi/x9bvyKV+vMrqWoH1dPnM/5rBb1C+UILVV
         RBvp0eT+PHGgzDz+Wn9TbLLftD4I9H5W/d1bCTWNXahdB5GG1A/fYrh28VkrOAnTxs3C
         CxAwhd0H+ZwW6NGs1NZ8leJs+zXmOb0d3OH7ufAVTBoNJIrtNcoaWAW94jjIGKyHvlft
         d6cg==
X-Gm-Message-State: APt69E0zwDwJQlhixmUXmwOYDwED59L3TFQd5el+hzd0x5JueD9yFvgS
        LqriS/6diseGT4QSDRwOmLoNUTHs
X-Google-Smtp-Source: AAOMgpdOcxsH3lMmFT4N01m0MEbQXRPoV+dmPRHzkzrZFyrsIxP3AUqBwyFctKhMKZ8wprHejdMbFg==
X-Received: by 2002:a1c:d9d0:: with SMTP id q199-v6mr3993348wmg.78.1530347760860;
        Sat, 30 Jun 2018 01:36:00 -0700 (PDT)
Received: from localhost.localdomain (89-95-107-230.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id u70-v6sm5338356wmd.3.2018.06.30.01.35.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Jun 2018 01:36:00 -0700 (PDT)
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
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 0/9] Introducing remote ODBs
Date:   Sat, 30 Jun 2018 10:35:33 +0200
Message-Id: <20180630083542.20347-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.18.0.138.g8117677157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a follow up from the patch series called "odb remote" that I
sent earlier this year, which was itself a follow up from previous
series. See the links section for more information.

As with the previous "odb remote" series, this series is only about
integrating with the promisor/narrow clone work and showing that it
makes it possible to use more than one promisor remote. Everything
that is not necessary for that integration has been removed for now
(though you can still find it in one of my branches on GitHub if you
want).

There is one test in patch 8/9 that shows that more than one promisor
remote can now be used, but I still feel that it could be interesting
to add other such tests, so I am open to ideas in this area.

Changes compared to V1 of this patch series
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  - fix tests failures  
  - error out when more than one "odb.<name>.promisorremote" exist
    with the same <name>

High level overview of this patch series
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

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

V2: https://github.com/chriscool/git/commits/remote-odb
V1: https://github.com/chriscool/git/commits/remote-odb1

Discussions related to V1:

https://public-inbox.org/git/20180623121846.19750-1-chriscool@tuxfamily.org/

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
 remote-odb.c                  | 139 ++++++++++++++++++++++++++++++++++
 remote-odb.h                  |  10 +++
 setup.c                       |   7 +-
 sha1-file.c                   |  14 ++--
 t/t0410-partial-clone.sh      |  58 +++++++++-----
 t/t5500-fetch-pack.sh         |   4 +-
 t/t5601-clone.sh              |   2 +-
 t/t5616-partial-clone.sh      |   4 +-
 t/t5702-protocol-v2.sh        |   2 +-
 unpack-trees.c                |   6 +-
 26 files changed, 344 insertions(+), 86 deletions(-)
 create mode 100644 odb-helper.c
 create mode 100644 odb-helper.h
 create mode 100644 remote-odb.c
 create mode 100644 remote-odb.h

-- 
2.18.0.138.gac082779dc

