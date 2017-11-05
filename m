Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5BDB32055E
	for <e@80x24.org>; Sun,  5 Nov 2017 08:42:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752733AbdKEIm2 (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Nov 2017 03:42:28 -0500
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:48125 "EHLO
        alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752367AbdKEImV (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 5 Nov 2017 03:42:21 -0500
X-AuditID: 12074411-f7dff70000007f0a-ea-59fecee74c1e
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id A7.40.32522.7EECEF95; Sun,  5 Nov 2017 03:42:15 -0500 (EST)
Received: from bagpipes.fritz.box (p4FC6E019.dip0.t-ipconnect.de [79.198.224.25])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id vA58gCCp018723
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Sun, 5 Nov 2017 03:42:14 -0500
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 0/9] Tidy up the constants related to ref_update::flags
Date:   Sun,  5 Nov 2017 09:42:00 +0100
Message-Id: <cover.1509870243.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.14.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPIsWRmVeSWpSXmKPExsUixO6iqPv83L9Ig0OPrS26rnQzWTT0XmG2
        +Pumi9Hi9or5zBZn3jQyOrB6/H3/gclj56y77B4XLyl7LH7g5fF5k1wAaxSXTUpqTmZZapG+
        XQJXxtc/fawFb/krPp5oZmlgnMPTxcjJISFgInHj4k72LkYuDiGBHUwSM35/Y4NwTjBJ9Lxa
        xAxSxSagK7Gop5kJxBYRUJOY2HaIBaSIWWAro8Tf7mawImEBL4lvn5+D2SwCqhL3z/cygti8
        AuYSC69fZIJYJy9x7sFt5gmMXAsYGVYxyiXmlObq5iZm5hSnJusWJyfm5aUW6Zrq5WaW6KWm
        lG5ihISC4A7GGSflDjEKcDAq8fCe8PgXKcSaWFZcmXuIUZKDSUmU98rLP5FCfEn5KZUZicUZ
        8UWlOanFhxglOJiVRHiDFgOV86YkVlalFuXDpKQ5WJTEefmWqPsJCaQnlqRmp6YWpBbBZGU4
        OJQkeK+dBWoULEpNT61Iy8wpQUgzcXCCDOcBGv4YpIa3uCAxtzgzHSJ/itGY49nM1w3MHNOu
        tjYxC7Hk5eelSonzHgMpFQApzSjNg5sGi+dXjOJAzwnzygOjW4gHmArg5r0CWsUEtGo2xx+Q
        VSWJCCmpBsbtbVu94qZtf1f4ylJ6SfqEWF+L74c0jv39rsFT/pJLTkPh1uuLh94u2+qgpeY8
        fZrXkU1pc1d+4Hj+vzP3YMi75wtWn3B8oyCwRfzezeMdL05/3rtcdI7O94BDfFfuutauuymR
        9OjKnKBJ/X3/JoUfKp+lr7sn40fXyqhVy8XYU54oFDg+/JgcqMRSnJFoqMVcVJwIAAdHI1bC
        AgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a reroll of a patch series that tidies up some stuff around
the ref_update::flags constants. Thanks to Junio and Martin for their
comments about v1 [1].

Relative to v1, this version:

* In patch 5, cleans up the touched comments to refer to OIDs rather
  than SHA-1s.

* Adds a patch 8, which changes `write_packed_entry()` to take
  `object_id` arguments.

* Adds a patch 9, which cleans up some remaining comments across all
  of the refs-related files to refer to OIDs rather than SHA-1s.

This patch series depends on bc/object-id. The patches are also
available from my GitHub fork as branch `tidy-ref-update-flags` [2].

Michael

[1] https://public-inbox.org/git/cover.1509183413.git.mhagger@alum.mit.edu/
[2] https://github.com/mhagger/git

Michael Haggerty (9):
  files_transaction_prepare(): don't leak flags to packed transaction
  prune_ref(): call `ref_transaction_add_update()` directly
  ref_transaction_update(): die on disallowed flags
  ref_transaction_add_update(): remove a check
  refs: tidy up and adjust visibility of the `ref_update` flags
  refs: rename constant `REF_NODEREF` to `REF_NO_DEREF`
  refs: rename constant `REF_ISPRUNING` to `REF_IS_PRUNING`
  write_packed_entry(): take `object_id` arguments
  refs: update some more docs to use "oid" rather than "sha1"

 builtin/am.c           |   2 +-
 builtin/branch.c       |   2 +-
 builtin/checkout.c     |   2 +-
 builtin/clone.c        |   4 +-
 builtin/notes.c        |   2 +-
 builtin/remote.c       |   6 +--
 builtin/symbolic-ref.c |   2 +-
 builtin/update-ref.c   |   4 +-
 refs.c                 |   8 ++-
 refs.h                 |  77 ++++++++++++++++-------------
 refs/files-backend.c   | 132 +++++++++++++++++++++++++++++++++++--------------
 refs/packed-backend.c  |  18 +++----
 refs/ref-cache.c       |   4 +-
 refs/refs-internal.h   |  81 +++++++++---------------------
 sequencer.c            |   6 +--
 15 files changed, 188 insertions(+), 162 deletions(-)

-- 
2.14.1

