Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84DF61F516
	for <e@80x24.org>; Sat, 23 Jun 2018 12:19:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752049AbeFWMTE (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Jun 2018 08:19:04 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35401 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751640AbeFWMTC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Jun 2018 08:19:02 -0400
Received: by mail-wm0-f68.google.com with SMTP id j15-v6so5340021wme.0
        for <git@vger.kernel.org>; Sat, 23 Jun 2018 05:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=4F3EUWOdgPgkvlknsdGO3lJig7cOdFsJIg7d0zkZ86o=;
        b=KiRm3lEU3OyxN9X0+5lMBs65ff0W4i02YxHALe5X6+HE54ta1iX7z6LNT1tR30wJ30
         VSmr5GQIMMnzKO7EE6KHdAcVfu3u68bHjK8gimmtTSLNPnjs9jidchQKvsOsQRbjs6K/
         +cc8HbvCTbDRTZ3OzTfa0bg9Y8AWf1jzdkKp6AcycD7MBvhFZZu9OgOTTHVykDOaFunY
         Tno3GsA95koPlyR5i5tHPMnXMxLtaNHkJNViAynh5GWMlK6XZ9SGBdykwdFfBpGnckz1
         9ZZLZxfEwfDi6/a2eddb++3dkqzKMyzaw65Cx9uvRP2N6LXVBDFLkqKgYBivIvHGeD+i
         QrTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4F3EUWOdgPgkvlknsdGO3lJig7cOdFsJIg7d0zkZ86o=;
        b=XsyXRu9RA8PYZEWRLOLXFa0en58+i5GmY8bDOEfS51t/omAxtZzVtqob2ViZVKWNUv
         nkYYWZbCCD7v4VlrjBOnn+rg1Vt3qiyyIOXLPeK5vQAi+Qj7lwgzPP8IVu3rVxtrbhwG
         NjxaAFIrfix1TtRffjq+Al0e79xeLClj6UjUggZ4dpeN+qMZkrySyYOm9kpp3afyoehw
         AyEkboCPXL3fQVumaFF54xmtxTzjhfFgh9uklbvaXpQPwWJCx4VTZ4Ok4NIXuuhcSjP7
         HFgeKNOSNG84Z1CXnu7OnqMadE00G7M7kdyfWxouGwMdDY9QcjgsiUkzwXVCBDb+xqGJ
         jv2Q==
X-Gm-Message-State: APt69E3lA3I3MTKgjVqOYAHuCNhQ9/MrRD+ZmA90cSbxzOLZlx0AeZhk
        O1ZI+rOX5+vVOp0NcxJOE4o0yvw5
X-Google-Smtp-Source: ADUXVKIfkHS03VEy4+yxvRlC7X9qU9hTC3sEEsezsB6WTbeae4EOQl4dnXcRytD9jvGAZdMSh7Roow==
X-Received: by 2002:a1c:8fd5:: with SMTP id r204-v6mr4712729wmd.77.1529756340983;
        Sat, 23 Jun 2018 05:19:00 -0700 (PDT)
Received: from localhost.localdomain (89-95-107-230.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id q14-v6sm5527731wmd.20.2018.06.23.05.18.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Jun 2018 05:19:00 -0700 (PDT)
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
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v1 0/9] Introducing remote ODBs
Date:   Sat, 23 Jun 2018 14:18:37 +0200
Message-Id: <20180623121846.19750-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.17.0.762.g886f54ea46
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a follow up from the patch series called "odb remote" that I
sent earlier this year, which was itself a follow up from the patch
series called "Promisor remotes and external ODB support" that I sent
earlier this year, which was itself a follow up from previous series.
See the links section for more information.

Following discussions of the previous patch series, the mechanism is
renamed from "odb remote" to "remote odb". I hope that this will will
be the last name change.

As with the previous "odb remote" series, this series is only about
integrating with the promisor/narrow clone work and showing that it
makes it possible to use more than one promisor remote. Everything
that is not necessary for that integration has been removed for now
(though you can still find it in one of my branches on GitHub if you
want).

There is one test in patch 8/9 that shows that more than one promisor
remote can now be used, but I still feel that it could be interesting
to add other such tests, so I am open to ideas in this area.

Changes compared to previous patch series
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  - big rename from "odb remote" to "remote odb"
  - rename of field from "dealer" to "remote" in struct odb_helper
  - add comments around struct odb_helper
  - improve a few commit messages
  - add a documentation patch

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
promisor/narrow clone code. The "extensions.partialclone" config
option is replaced by "odb.<name>.promisorRemote" and
"core.partialclonefilter" is replaced by
"odb.<name>.partialclonefilter".

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

https://github.com/chriscool/git/commits/remote-odb

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
 fetch-object.c                |  15 +++--
 fetch-object.h                |   6 +-
 list-objects-filter-options.c |  49 ++++++++------
 list-objects-filter-options.h |   3 +-
 odb-helper.c                  |  45 +++++++++++++
 odb-helper.h                  |  24 +++++++
 packfile.c                    |   3 +-
 remote-odb.c                  | 118 ++++++++++++++++++++++++++++++++++
 remote-odb.h                  |  10 +++
 setup.c                       |   7 +-
 sha1-file.c                   |  14 ++--
 t/t0410-partial-clone.sh      |  54 +++++++++++-----
 t/t5500-fetch-pack.sh         |   4 +-
 t/t5601-clone.sh              |   2 +-
 t/t5616-partial-clone.sh      |   4 +-
 unpack-trees.c                |   6 +-
 25 files changed, 320 insertions(+), 81 deletions(-)
 create mode 100644 odb-helper.c
 create mode 100644 odb-helper.h
 create mode 100644 remote-odb.c
 create mode 100644 remote-odb.h

-- 
2.17.0.762.g886f54ea46

