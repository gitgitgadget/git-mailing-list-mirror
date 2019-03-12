Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D7E720377
	for <e@80x24.org>; Tue, 12 Mar 2019 13:30:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbfCLNaR (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Mar 2019 09:30:17 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41048 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbfCLNaQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Mar 2019 09:30:16 -0400
Received: by mail-ed1-f68.google.com with SMTP id n14so2282075edv.8
        for <git@vger.kernel.org>; Tue, 12 Mar 2019 06:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gI4xZ2ETtM6ggBkCLznQep1cOD1OytxlI1qHtIR5lCk=;
        b=PLO0/5VB0+hgf2ug6UAc/9PPGOgP893x0QlozUM0LC9mSA4JfstFTCnDkXylu0iJef
         wvxc0A7+j1CXtzF58EHDOC0FB1gez7E5DYAmmbqHCob3zTPlEMqD+0kysK9ApbAfjZdA
         NypsAp/izmkFgu04fU+kPcTOCrmPw3IGorw28yuE1xe9j2nuPvFeqkIal0LpYH3Vbjcq
         qrrNom3wREZEG4KGquK3L3BT4DH7oljQVlF1mWiebWdfDNIJoutCdUvHO4f1oW0F0jR3
         MUrvAIltXxFRr70hKEjzXs6INbfkarZsJo3yHlp70oUTgLRKWQC6BlX/E5oPMP6AmT5B
         TG2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gI4xZ2ETtM6ggBkCLznQep1cOD1OytxlI1qHtIR5lCk=;
        b=LUUkNQ1YwOy+Ohgwfmy2oMBPmiJjL74+BfG8EPwK3WPv48fSBoHxddPYVMEwudkbJj
         X2hzsPAozIcnrbAovawrFyDiXW/cemSDQPa3s0eiO/OqsH/H2+I+NjvaSRoPY5IdWkly
         HNM4Sn/mj915Bp8qa0VW4XoKV2rLDSNXL+Hh9u+WpRa9ULShTjRTs5or1Rh5hN9CYOKZ
         WwMeZltCJRPA4W75SxaeLOOAq0z6eexHp389+iCdvaynCoeRBx1/4TeIDmKbsY111JJo
         Rm5UgKtSSrQ31SjCBA+Pr0Bti+79X4TqjmQs7XsRiOHOnosH0PQEZgKqx2zRNaAMaYvu
         +upA==
X-Gm-Message-State: APjAAAWrZFyTyb2JZI44sC9wnqRqSTouG1mgrif+y3dt2GtJxafyA0MK
        3D/KHgfrUYNB104d9BbTvoiK1aRd
X-Google-Smtp-Source: APXvYqz+EeWb1eoflOsrwwJmDTNG3xV6RkFXOPj4n8eEtgMVpGtdKpyUx4ICFkf4/fnRB2F+cSjWOg==
X-Received: by 2002:aa7:d396:: with SMTP id x22mr3427587edq.182.1552397413448;
        Tue, 12 Mar 2019 06:30:13 -0700 (PDT)
Received: from ubuntu-N750HU.booking.pcln.com (access-114.38.rev.fr.colt.net. [213.41.38.114])
        by smtp.gmail.com with ESMTPSA id h8sm5875213edk.21.2019.03.12.06.30.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Mar 2019 06:30:12 -0700 (PDT)
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
Subject: [PATCH v3 00/11] Many promisor remotes
Date:   Tue, 12 Mar 2019 14:29:48 +0100
Message-Id: <20190312132959.11764-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.21.0.166.gb5e4dbcfd3
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

In general I have tried to change as few things as possible.

High level changes since the V2
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  - remove the 2 first patches from V2 that have been sent and merged
    separately

  - improved commit message in patch 8/11 documentation patches
  
  - slightly improved cover letter

As I got no comment on V2, I am not sure what to improve at this
point.

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

These are new documentation patches, to explain how things can work
with more than one promisor remote.

Links
~~~~~

This patch series on GitHub:

V3: https://github.com/chriscool/git/commits/many-promisor-remotes
V2: https://github.com/chriscool/git/commits/many-promisor-remotes35
V1: https://github.com/chriscool/git/commits/many-promisor-remotes17

On the mailing list:

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

 Documentation/config/remote.txt           |   8 ++
 Documentation/technical/partial-clone.txt |  83 ++++++++----
 Makefile                                  |   1 +
 builtin/cat-file.c                        |   5 +-
 builtin/fetch.c                           |  29 ++---
 builtin/gc.c                              |   3 +-
 builtin/repack.c                          |   3 +-
 cache-tree.c                              |   3 +-
 connected.c                               |   3 +-
 fetch-object.c                            |  13 +-
 fetch-object.h                            |   4 +-
 list-objects-filter-options.c             |  51 ++++----
 list-objects-filter-options.h             |   3 +-
 packfile.c                                |   3 +-
 promisor-remote.c                         | 148 ++++++++++++++++++++++
 promisor-remote.h                         |  22 ++++
 sha1-file.c                               |  14 +-
 t/t0410-partial-clone.sh                  |  49 ++++++-
 t/t5601-clone.sh                          |   3 +-
 t/t5616-partial-clone.sh                  |   4 +-
 unpack-trees.c                            |   6 +-
 21 files changed, 362 insertions(+), 96 deletions(-)
 create mode 100644 promisor-remote.c
 create mode 100644 promisor-remote.h

-- 
2.21.0.166.gb5e4dbcfd3

