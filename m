Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 909D11F914
	for <e@80x24.org>; Fri, 13 Jul 2018 17:50:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731383AbeGMSF5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jul 2018 14:05:57 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:54718 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729926AbeGMSF5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jul 2018 14:05:57 -0400
Received: by mail-wm0-f48.google.com with SMTP id i139-v6so9519958wmf.4
        for <git@vger.kernel.org>; Fri, 13 Jul 2018 10:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=8LRZIXSR1FdxQM3vMUhjjVn84zxeb5u0ijdHhtMK7sw=;
        b=OUPw3cxQaq9NgDYoTWC1G5WDb19NQu+de47RjW9lzk4b26EWpdfkXznEa18639uqhv
         l4JNPunoep//Z/B8I/Ddi+KopWKjpS+lWxeEyJ60naQepTNEFdqtQ7991dop7FtpB6TD
         tJf02EDn5wa5yfRWQIRPOpERZ2FslpIlq3blyfRJUhR+Nm5tu1qNZa8wjSSwNu4D5PaU
         xLP63Q8mgzpDTE8Q8RPT5kBlryFc6uyrOTfm4l1O5ZwOuCK4rBR0Lmh0zsFbFCPs/PMc
         OwYTghlNi2HGs3tG4yHwEijRGfmtvofPVCnCpmBE+0C8OIRv4WIiZ+zkN5VXGNqapAcA
         VQ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8LRZIXSR1FdxQM3vMUhjjVn84zxeb5u0ijdHhtMK7sw=;
        b=MA/if6N1rWbGxSNoTTLfy4D3FcwdcYoB3aonlEcivwYaJvwvsxvk3rkg75YQaOU5RU
         oTz7dHrWyvzdixcDQCHpnXNMxB1OoOdpE+Km1YnZDatqbJnSr+lrBbiqOTAhWAnAhN2s
         123s8v7V2lD2ZzwYINwBJpOt2XlKGDG4IXUq7k2VGDeewoY3HfT4HKzwLaI89DFc+bqP
         UGODa/66o+893Zs8VL+T5PqvZWYVKHDVxMLQWFdwB9NtX3/NPn/arA0FWcueJwNcFZlp
         2D3/OcRE4ZHUOuNlkEdJf0it/wxZVbfBJ5XdWw1Pv8l7McWwTq10o76+u7l4o/peS3HC
         Sqfg==
X-Gm-Message-State: AOUpUlHHJxnR8BYTHUhbDI7anZPEVmiTPLSO88qh4MyKj5PB13MgST3z
        6DZPqnoMcRj+Z/uShIEuEycgjzpC
X-Google-Smtp-Source: AAOMgpcAZvWDXnxRpyxjuOHyBpIK5rIA1yAD7/gPRpOw4/Db0mYOWcWUIEk3D2iNwTwQbNcgv0QmDA==
X-Received: by 2002:a1c:ee94:: with SMTP id j20-v6mr4487744wmi.66.1531504217394;
        Fri, 13 Jul 2018 10:50:17 -0700 (PDT)
Received: from localhost.localdomain (188.10.112.78.rev.sfr.net. [78.112.10.188])
        by smtp.gmail.com with ESMTPSA id v15-v6sm6556862wmc.16.2018.07.13.10.50.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jul 2018 10:50:16 -0700 (PDT)
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
Subject: [PATCH v3 0/9] Introducing remote ODBs
Date:   Fri, 13 Jul 2018 19:49:50 +0200
Message-Id: <20180713174959.16748-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.18.0.138.g7076a5fae1
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

Changes compared to V2 of this patch series
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  - fix unused variable in patch 2/9: the "SQUASH???" patch that Junio
    had created (thanks!) has been squashed

High level overview of this patch series
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

All the patches except 2/9 are unchanged compared to V2.

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

V3: https://github.com/chriscool/git/commits/remote-odb
V2: https://github.com/chriscool/git/commits/remote-odb2
V1: https://github.com/chriscool/git/commits/remote-odb1

Discussions related to previous versions:

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
2.18.0.171.ge260395bfe

