Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 486251F42D
	for <e@80x24.org>; Sun, 13 May 2018 10:32:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751149AbeEMKcz (ORCPT <rfc822;e@80x24.org>);
        Sun, 13 May 2018 06:32:55 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:56006 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750941AbeEMKcy (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 May 2018 06:32:54 -0400
Received: by mail-wm0-f51.google.com with SMTP id a8-v6so8842272wmg.5
        for <git@vger.kernel.org>; Sun, 13 May 2018 03:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=1n4x2dKwB2eLYpv9oGCpi3aildN9EjQ+QN5XPQihKgY=;
        b=F1bqxIitXYTTv9goP9EPwgY3ILJiWc14TGR9aPahX6fn/nKJ0tW0Urnk6O4CpGv0ev
         GMnFQP75Z3FzhS5vWBIT9RM/SVPcmaOHtadN+x5ZVaChnKxyckO8VSb27UuI6vM9WYic
         aS6iSNEj125cEbxsm0JD+ZzxZMErum2zpYhg2gpmlEJW5hDacU7ucJ2gxceG86Bupi0W
         5YtA3XJwpbmPB1/wvf8DGUmx8o66i2MJb+pVJWRW9c5WXJLn65wodkE8CEqDdrRFyKbc
         jI+s+GQHK+sLjfPJlARtzF0lVU6dxR7eUTTE0Rleav3snsol+db4ruYYjUdVgha5LwFq
         32yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1n4x2dKwB2eLYpv9oGCpi3aildN9EjQ+QN5XPQihKgY=;
        b=KEjHbZZmbW/uACENTJasg0baZIRSRAw1OvSeFauHeoIWtFleslcK4gFnR6aUzX86pk
         d8SF6CBqXO9F4PfHbEpAvkUk7bfBWN3KKiemWdScjp5LOH0qlnSL4umju3LPV6JHMCAr
         kQRGbGPZXMxzjQbDY5h4B0cE3BcCzur3w+pc71F40cvFzadLzgpuxAItzMDmdDkDnLqz
         vLkV8+47RPBq9d1pwq9Kpl9hCn8K0JmsNxrc9ITSFXeCeMwZxjnvs0l4PiTE2MIGBKLm
         VWExn/xIur2HyF80RIwb21ngVa9jhxPyeN6iVsIkKOE7dBwcD55/WkHInov2meatB/Vy
         2//A==
X-Gm-Message-State: ALKqPwc14HOZjpMnvwsD3Qtcp8qI7qS4xoLNbOdZPiW70hP35IsY/Uhh
        14I4iOHnts64XUfyOMGPTPnrpLT6
X-Google-Smtp-Source: AB8JxZoPZW6x03hnzNAxHbt1yhAzsMVzVo1i/+gIhVuhFAvUoUbw+qh6WkPT6I8QUn/qd1JAeE6r5A==
X-Received: by 2002:a1c:1305:: with SMTP id 5-v6mr3043264wmt.89.1526207573097;
        Sun, 13 May 2018 03:32:53 -0700 (PDT)
Received: from localhost.localdomain (89-95-107-230.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id t203-v6sm6886375wmt.33.2018.05.13.03.32.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 13 May 2018 03:32:52 -0700 (PDT)
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
Subject: [PATCH v1 0/8] Introducing odb remote
Date:   Sun, 13 May 2018 12:32:24 +0200
Message-Id: <20180513103232.17514-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.17.0.590.gbd05bfcafd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a follow up from the patch series called "Promisor remotes and
external ODB support" that I sent earlier this year.

Following discussions of these patch series, where Junio said "a
minimum s/ext/remote/ would clarify what it is", I decided to rename
"external odb" to "odb remote". I am still open to another name, but I
think that "odb remote" works well with "odb helper" that was already
used in the series and is as good or perhaps better than "remote odb",
as a "remote odb" I think would be easier to confuse with a regular
"remote".

Another obvious difference with the previous series is that this
series is only about integrating with the promisor/narrow clone work
and showing that it makes it possible to use more than one promisor
remote. Everything that is not necessary for that integration has been
removed for now (though you can still find it in one of my branches on
GitHub if you want).

This makes this patch series much shorter than the previous ones and
already useful. So hopefully this will make it possible to start
reviewing and merging it.

There is one test in patch 8/8 that shows that more than one promisor
remote can now be used, but I feel that it could be interesting to add
other such tests, so I am open to ideas in this area.

High level overview of this patch series
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  - Patch 1/8:

This makes functions in fetch-object.c return an error code, which is
necessary to later tell that they failed and try another odb remote
when there is more than one. This could also just be seen as a fix to
these functions.

  - Patch 2/8:

This introduces the minimum infrastructure for odb remotes.

  - Patches 3/8 and 4/8:

These patches implement odb_remote_get_direct() and
odb_remote_get_many_direct() using the functions from fetch-object.c.
These new functions will be used in following patches to replace the
functions from fetch-object.c.

  - Patch 5/8:

This implement odb_remote_reinit() which will be needed to reparse the
odb remote configuration.

  - Patches 6/8 and 7/8:

These patches integrate the odb remote mechanism into the
promisor/narrow clone code. The "extensions.partialclone" config
option is replaced by "odb.<name>.promisorRemote" and
"core.partialclonefilter" is replaced by "odb.<name>.partialclonefilter".

  - Patch 8/8:

This adds a test case that shows that now more than one promisor
remote can be used.

Links
~~~~~

This patch series on GitHub:

https://github.com/chriscool/git/commits/odb-remote

Version 1 and 2 of the "Promisor remotes and external ODB support" series:

https://public-inbox.org/git/20180103163403.11303-1-chriscool@tuxfamily.org/
https://public-inbox.org/git/20180319133147.15413-1-chriscool@tuxfamily.org/

Version 1 and 2 of the "Promisor remotes and external ODB support" series on GitHub:

https://github.com/chriscool/git/commits/gl-small-promisor-external-odb12
https://github.com/chriscool/git/commits/gl-small-promisor-external-odb71


Christian Couder (8):
  fetch-object: make functions return an error code
  Add initial odb remote support
  odb-remote: implement odb_remote_get_direct()
  odb-remote: implement odb_remote_get_many_direct()
  odb-remote: add odb_remote_reinit()
  Use odb_remote_get_direct() and has_external_odb()
  Use odb.origin.partialclonefilter instead of core.partialclonefilter
  t0410: test fetching from many promisor remotes

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
 odb-helper.h                  |  18 ++++++
 odb-remote.c                  | 118 ++++++++++++++++++++++++++++++++++
 odb-remote.h                  |  10 +++
 packfile.c                    |   3 +-
 setup.c                       |   7 +-
 sha1-file.c                   |   9 +--
 t/t0410-partial-clone.sh      |  54 +++++++++++-----
 t/t5500-fetch-pack.sh         |   4 +-
 t/t5601-clone.sh              |   2 +-
 t/t5616-partial-clone.sh      |   4 +-
 unpack-trees.c                |   6 +-
 24 files changed, 306 insertions(+), 79 deletions(-)
 create mode 100644 odb-helper.c
 create mode 100644 odb-helper.h
 create mode 100644 odb-remote.c
 create mode 100644 odb-remote.h

-- 
2.17.0.590.gbd05bfcafd

