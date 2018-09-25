Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 512531F456
	for <e@80x24.org>; Tue, 25 Sep 2018 11:54:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728559AbeIYSBO (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Sep 2018 14:01:14 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40390 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727165AbeIYSBO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Sep 2018 14:01:14 -0400
Received: by mail-wr1-f68.google.com with SMTP id y8-v6so19406122wrh.7
        for <git@vger.kernel.org>; Tue, 25 Sep 2018 04:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9jykZQCbcjpLm+LQOT+qfq32v83w5y4DwKBWtR+fNOM=;
        b=ltFyGg6YiPUu9V+tUSeB5uz1Isbsmxd+RdG03pwXMBO3ErqNDySeV9YhMO5tOmvjA2
         xQ7bOZ8Z5GpoV+B7Ajd3K3qOPYtvxyiKaFfk9hmwzBWPVPuC8t2EkMHYjx7dNIF7uHfp
         L0RG+LwPELZ2mNDvl7gdWxk6Oi+s97lXTNMJ9OH8L9Hj/3rNJvjsab3C0zzPHazEKs6e
         c6InGWESXQ0xOnxQnnpgXOI3hLCSVLsE6vSEk8y62KgqpPowC6LZ0P50lwIgewEIbhEz
         C+ig7JirI1vJmIb0a8EhqmKtEqf68TOKge2CZFpu/gqJttOzxcruq2rcIJQIqjRztFgM
         s8WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9jykZQCbcjpLm+LQOT+qfq32v83w5y4DwKBWtR+fNOM=;
        b=gzPALeTyiDape939/LUwpr7+w9mvy8X1Fp6vUlCyn6eOshrnrWuPhfBLyZPhf+E7ZB
         EXzfgFWVBdnr56IQ4zAr61gJ+GoZ3FqfptvHHWEBykoN+rBGQJmEVx60CxI/kQe6Vr3v
         Y/B9xfiTNdrJ+4b6WBJ8NxXb7Se2ArG0mRKYAyzQYoE/oiz+SIuJxvtdzZqE9KeP71Wt
         YzcefqUjRpN+6T9Y8Uuyxk7vs8foTLMkdPqHNfnkowhlKwrK7Wei39QFdn4wZDXTpvO5
         6tpXcIAz1txgtoeCrHNKnXQKychiN5QN6Kl7aiMa55TS3OF/qbtZfe8GSrrYE1Gub5Gf
         FN9A==
X-Gm-Message-State: ABuFfohGw3/G53azGKAIazfcxd4PMkSUspbOx8RNqbkrqofvncVNNRiu
        bXlbUEGY+NGEJ1INo+817SQbR9n0
X-Google-Smtp-Source: ACcGV62oCcY8b9mbScfoYscdLGPkTymNmvCx1Sgch8OS+lDojPyM1ifocLLHxkt3tUb/L4wS+ZMHcw==
X-Received: by 2002:adf:82cb:: with SMTP id 69-v6mr622657wrc.131.1537876440634;
        Tue, 25 Sep 2018 04:54:00 -0700 (PDT)
Received: from localhost.localdomain (89-95-107-230.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id z14-v6sm1998628wrr.91.2018.09.25.04.53.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 04:53:59 -0700 (PDT)
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
Subject: [PATCH v5 0/8] Introducing remote ODBs
Date:   Tue, 25 Sep 2018 13:53:33 +0200
Message-Id: <20180925115341.19248-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.19.0.278.gca5b891cac
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This path series is a follow up from the patch series called "odb
remote" that I sent earlier this year, which was itself a follow up
from previous series. See the links section for more information.

Goal
~~~~

This series is about introducing a remote ODB mechanism and showing
that this mechanism makes it is possible to:

  - have more than one promisor remote
  - specify different parameters for each promisor remote
  - make it possible later to have other kind of promisor/odb remotes

This also restores the distributed nature of Git which was kind of
broken for promisor remotes.

Explanations
~~~~~~~~~~~~

The extensions.partialclone config option limits the partial clone and
promisor features to only one remote.

That config option also prevents having other kind of promisor/partial
clone/odb remotes. By other kind I mean remotes that would not
necessarily be git repos, but that could store objects (that's where
ODB, for Object DataBase, comes from) and could provide those objects
to Git through a helper (or driver) script or program.

If we want more than one promisor remote, we also need to be able to
specify different parameters for each promisor remote. For example now
core.partialclonefilter is used to specify some filters for the
promisor remote, but how can we nicely specify different partial clone
filters if we have more than one promisor remote?

With the changes in this patch series core.partialclonefilter is
replaced with odb.<remote odb name>.partialclonefilter, so that
parameters for a remote odb are properly grouped together in the
section where the remote odb is defined.

So an added benefit is that the "remote.<remote name>.*" config name
space is not overloaded with more config variables.

Discussion
~~~~~~~~~~

I am not sure that it is ok to completely replace the
"extensions.partialclone" config option. Even if it is fully replaced,
no "extensions.remoteodb" is implemented in these patches, as maybe
the "extensions.partialclone" name could be kept even if the
underlying mechanism is the remote odb mechanism. 

I think that the remote odb mechanism is much more extensible, so I
think using "extensions.partialclone" to specify a promisor remote
should be at least deprecated.

Changes compared to V4 of this patch series
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The main change is that the interface of remote_odb_get_direct() in
patch 3/8 is changed, so that it can fetch more than one object. This
remove the needs for remote_odb_get_many_direct(), so the patch that
introduced this function (4/9 in V4) has been removed.

High level overview of this patch series
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  - Patch 1/8:

This makes functions in fetch-object.c return an error code, which is
necessary to later tell that they failed and try another remote odb
when there is more than one. This could also just be seen as a fix to
these functions.

  - Patch 2/8:

This introduces the minimum infrastructure for remote odbs.

  - Patches 3/8:

This patch implements remote_odb_get_direct() using fetch_objects()
from "fetch-object.c". Compared to V4, the interface of many functions
now uses oids instead of sha1s.

  - Patch 4/8:

This implement remote_odb_reinit() which will be needed to reparse the
remote odb configuration.

  - Patches 5/8 and 6/8:

These patches integrate the remote odb mechanism into the
promisor/narrow clone code. The "extensions.partialClone" config
option is replaced by "odb.<name>.promisorRemote" and
"core.partialCloneFilter" is replaced by
"odb.<name>.partialCloneFilter". (See the Discussion section below
about this.)

  - Patch 7/8:

This adds a test case that shows that now more than one promisor
remote can be used.

  - Patch 8/8:

This starts documenting the remote odb mechanism.

Links
~~~~~

This patch series on GitHub:

V5: https://github.com/chriscool/git/commits/remote-odb
V4: https://github.com/chriscool/git/commits/remote-odb5
V3: https://github.com/chriscool/git/commits/remote-odb3
V2: https://github.com/chriscool/git/commits/remote-odb2
V1: https://github.com/chriscool/git/commits/remote-odb1

Discussions related to previous versions:

V4: https://public-inbox.org/git/20180802061505.2983-1-chriscool@tuxfamily.org/
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


Christian Couder (8):
  fetch-object: make functions return an error code
  Add initial remote odb support
  remote-odb: implement remote_odb_get_direct()
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
 fetch-object.c                |  13 ++--
 fetch-object.h                |   4 +-
 list-objects-filter-options.c |  51 ++++++++-------
 list-objects-filter-options.h |   3 +-
 odb-helper.c                  |  31 +++++++++
 odb-helper.h                  |  23 +++++++
 packfile.c                    |   3 +-
 remote-odb.c                  | 120 ++++++++++++++++++++++++++++++++++
 remote-odb.h                  |   9 +++
 setup.c                       |   7 +-
 sha1-file.c                   |  14 ++--
 t/t0410-partial-clone.sh      |  62 ++++++++++++------
 t/t5500-fetch-pack.sh         |   4 +-
 t/t5601-clone.sh              |   2 +-
 t/t5616-partial-clone.sh      |   4 +-
 t/t5702-protocol-v2.sh        |   2 +-
 unpack-trees.c                |   6 +-
 26 files changed, 309 insertions(+), 86 deletions(-)
 create mode 100644 odb-helper.c
 create mode 100644 odb-helper.h
 create mode 100644 remote-odb.c
 create mode 100644 remote-odb.h

-- 
2.19.0.278.gca5b891cac

