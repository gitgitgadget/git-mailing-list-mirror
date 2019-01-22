Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2EEB12141D
	for <e@80x24.org>; Tue, 22 Jan 2019 14:42:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728904AbfAVOmc (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Jan 2019 09:42:32 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44992 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728700AbfAVOmc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jan 2019 09:42:32 -0500
Received: by mail-wr1-f68.google.com with SMTP id z5so27587943wrt.11
        for <git@vger.kernel.org>; Tue, 22 Jan 2019 06:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PAlmiEx7Szizb+S3UTg1EDQ1ukanL6MpvUbp6BeijY8=;
        b=igNguoVPEaFcVNuFx4t0Vjt08KKrbve8pGJbLGuj3eyfY+rPtO3EL0bQQKlCEOy6SD
         huMa2POU+vGvP0qdj59ZgOHZv3l15umm+l+BshYix/+pJiE75Hawb2kXXNTV5iwzjmWx
         OeTlL7f+62xi7KNANojbqaAk8zfT/Y134SaIaRLRe+zgFA108deP4lWUpKHZfegjzEnk
         UfsWkFEaFgJ3T0kN+Vhz9GR6EsLD3XkbOhim5tsvAARmLKDnXMkQf17faO39ZoKwY8dQ
         fusWUKNTOEDiEwnfrL8BcTpAaHC5rF9mdED07JgP2cZON3nALJxbWf+lI+eZ08uTU09M
         xy8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PAlmiEx7Szizb+S3UTg1EDQ1ukanL6MpvUbp6BeijY8=;
        b=cdg/JXaGCqr6R3y8aLB2kWK/TEjbuLrMpzHENZIxKfZHt/vku0qhlZttGLZmqVBV5x
         yRvvu1vBy2CpZ6HdUuojrwHuuacFsnCJppzm12UllPWTPvY3ow4k9nHj12bIvdbD1TNt
         i75PqeKXt2O4SrcabQy7f+reu4AgMKyXJRkRZmwvAazcuCnxiwb7PlQkE6MATSVacNPE
         PUxw+Agaxuc8Qt4cLk69zP0DUSHb1owJR1Gs5ZroiebmPgtC1paqne//8Fnz9PrVO+sX
         VTo2hfJQTn1cZNletXsI0GXit4O3iLBRRhPpyiRDzAEVEob2X0BOtOkBT4kyhxiP3Zw0
         B7fA==
X-Gm-Message-State: AJcUukcNf2xsqcZc3EcMfxKcTllRJo+HWWc2dJraA6iwVrlTFxFvrDwU
        yKlqZ42MEhzwxAYeG30aGgnwmRQT
X-Google-Smtp-Source: ALg8bN7eDvrQsZzCXopNgWEvCibRjeRtl63oCzOh08RDyKAqQIV4xVJenXVzmVw53MwF/OlIVZrR3A==
X-Received: by 2002:a5d:45d0:: with SMTP id b16mr18985103wrs.86.1548168149688;
        Tue, 22 Jan 2019 06:42:29 -0800 (PST)
Received: from ubuntu-N750HU.booking.pcln.com (access-114.38.rev.fr.colt.net. [213.41.38.114])
        by smtp.gmail.com with ESMTPSA id k26sm31266168wmi.28.2019.01.22.06.42.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 06:42:29 -0800 (PST)
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
Subject: [PATCH v2 00/13] Many promisor remotes
Date:   Tue, 22 Jan 2019 15:41:59 +0100
Message-Id: <20190122144212.15119-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.20.1.322.gd6b9ae60d4
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

For now the fetch order is the order of the remotes in the config.

I selected the name "Promisor remote" over "Partial clone remote"
because it is shorter and because it is not only about cloning.

The existing extensions.partialclone is respected, but it is not
written in the config when a partial clone or fetch is made. Instead
remote.<name>.promisor is set to "true". This may create a
compatibility issue, but it makes it possible to start using many
promisor remotes by just cloning and fetching from different remotes
with partial clone filters. The compatibility issue could be resolved
in a future iteration by just setting extensions.partialclone instead
of remote.<name>.promisor the first time a promisor remote is used.

In general I have tried to change as few things as possible.

High level changes since the V1
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  - added documentation patches
  
  - fixed issues when fetching from a new promisor remote
  
  - added a test to check that remote.<name>.promisor is set to "true"
    when fetching from a new promisor remote

  - renamed functions in promisor-remote.{c,h} to make the names more
    coherent and easier to understand

  - added 2 small typo fix patches that I sent separately

High level overview of this patch series
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  - Patch 1/13 and 2/13:

These are 2 new small patches that I sent separately. I am adding them
here as the other patches were developed on top of them and it creates
a small conflict is these 2 patches are removed.

  - Patch 3/13:

This patch, which hasn't changed since V1, makes functions in
fetch-object.c return an error code, which is necessary to later tell
that they failed and try another promisor remote when there is more
than one. This could also just be seen as a fix to these functions.

  - Patch 4/13:

This introduces the minimum infrastructure for promisor remotes. There
has been a number of renames and improvements since V1.

  - Patch 5/13, 6/13 and 7/13:

This add a few missing bits in the promisor remote infrastructure that
will be needed in the following patches. There has been a number of
renames and improvements since V1.

  - Patch 8/13:

This replaces the previous interface to use only one promisor remote
defined in extensions.partialclone by the new interface created by the
previous patches. There has been a few renames since V1.

  - Patch 9/13:

This replaces the way a partial clone filter was handled by a new way
based on the previous patches that support more than one partial clone
filter. There has been a few renames since V1.

  - Patch 10/13:

This new patch removes the limitation in builtin/fetch.c to have only
one promisor remote.

  - Patch 11/13:

This adds test cases that shows that now more than one promisor remote
can be used and that remote.<name>.promisor is set to "true" when
fetching from a new promisor remote.

  - Patch 12/13 and 13/13:

These are new documentation patches, to explain how things can work
with more than one promisor remote.

Links
~~~~~

This patch series on GitHub:

V2: https://github.com/chriscool/git/commits/many-promisor-remotes
V1: https://github.com/chriscool/git/commits/many-promisor-remotes17

On the mailing list:

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


Christian Couder (13):
  fetch: fix extensions.partialclone name in error message
  partial-clone: add missing 'is' in doc
  fetch-object: make functions return an error code
  Add initial support for many promisor remotes
  promisor-remote: implement promisors_get_direct()
  promisor-remote: add promisor_remote_reinit()
  promisor-remote: use repository_format_partial_clone
  Use promisor_remote_get_direct() and has_promisor_remote()
  promisor-remote: parse remote.*.partialclonefilter
  builtin/fetch: remove unique promisor remote limitation
  t0410: test fetching from many promisor remotes
  partial-clone: add multiple remotes in the doc
  remote: add promisor and partial clone config to the doc

 Documentation/config/remote.txt           |   8 ++
 Documentation/technical/partial-clone.txt |  85 +++++++++----
 Makefile                                  |   1 +
 builtin/cat-file.c                        |   5 +-
 builtin/fetch.c                           |  31 ++---
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
 21 files changed, 365 insertions(+), 97 deletions(-)
 create mode 100644 promisor-remote.c
 create mode 100644 promisor-remote.h

-- 
2.20.1.322.gd6b9ae60d4

