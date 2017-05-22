Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F3142023D
	for <e@80x24.org>; Mon, 22 May 2017 14:18:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934668AbdEVOSL (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 May 2017 10:18:11 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:64429 "EHLO
        alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934407AbdEVOSI (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 22 May 2017 10:18:08 -0400
X-AuditID: 1207440d-dcfff70000000e33-09-5922f31fd052
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id E8.A8.03635.F13F2295; Mon, 22 May 2017 10:18:07 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCCDA0.dip0.t-ipconnect.de [87.188.205.160])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v4MEI249023503
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Mon, 22 May 2017 10:18:04 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>,
        Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 00/25] Prepare to separate out a packed_ref_store
Date:   Mon, 22 May 2017 16:17:30 +0200
Message-Id: <cover.1495460199.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCIsWRmVeSWpSXmKPExsUixO6iqCv/WSnS4OtRcYu1z+4wWTxff4Ld
        outKN5NFQ+8VZosnc+8yW9xeMZ/ZYsnD18wW3VPeMlr8aOlhtti8uZ3Fgcvj7/sPTB47Z91l
        91iwqdTj4asudo+u9iNsHs969zB6XLyk7PF5k1wARxSXTUpqTmZZapG+XQJXxta2dqaCNyoV
        /6YuYWxgfCXTxcjJISFgItE09QsriC0ksINJYtt0xS5GLiD7FJPE9SfnWUASbAK6Eot6mplA
        bBEBNYmJbYdYQIqYBTYwS7yZvhosISzgInHs+ztmEJtFQFVi/5cbjCA2r4C5xN+GJkaIbfIS
        u9ousk5g5FrAyLCKUS4xpzRXNzcxM6c4NVm3ODkxLy+1SNdILzezRC81pXQTIySweHcw/l8n
        c4hRgINRiYdX47FSpBBrYllxZe4hRkkOJiVR3qNvgEJ8SfkplRmJxRnxRaU5qcWHGCU4mJVE
        eLXvAuV4UxIrq1KL8mFS0hwsSuK8akvU/YQE0hNLUrNTUwtSi2CyMhwcShK8ep+AGgWLUtNT
        K9Iyc0oQ0kwcnCDDeYCGr/kAMry4IDG3ODMdIn+KUVFKnNcApFkAJJFRmgfXC4v8V4ziQK8I
        85qAVPEAkwZc9yugwUxAg62fyYMMLklESEk1MLJYyWw00DGMkbP0DFP7vafxpnNnUUtukdr9
        Kdt3V4ds9NML/fp1+UpVj+xPxg82lu1jvJCWsyVyq6a22p6V31nqxVZ2h0wquahW6aebalCq
        w/Rt5fSVRY+/z9E2j5oxXa1KfFvasfla71jZp1tON4i5fLRb/EZwbu1U8YeHNs+rXKZ7Mdr9
        gRJLcUaioRZzUXEiAOjgFpLXAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the second iteration of a patch series that prepares the
ground for separating out a `packed_ref_store` and then for changing
`packed-refs` to be read using `mmap()`. Thanks to Peff, Junio,
Stefan, Brandon, and Johannes for their feedback about v1 [1]. I think
I have addressed all of your comments.

Changes since v1:

* Since v1, branch `bc/object-id` has been merged to `next`, and it
  has lots of conflicts with these changes. So I rebased this branch
  onto a merge of `master` and `bc/object-id`. (I hope this makes
  Junio's job easier.) This unfortunately causes a bit of tbdiff noise
  between v1 and v2.

* Patch [01/25]: in t3600, register the `test_when_finished` command
  before executing `chmod a-w`.

* Patch [04/25] (new patch): convert a few `die("internal error: ...")`
  to `die("BUG: ...")`.

* Patch [05/25]: Use `strlen()` rather than `memchr()` to check the
  trim length, and `die()` rather than skipping if it is longer than
  the reference name.

* Patch [08/25]: Name the log message arguments `msg` for consistency
  with existing code.

* Patch [10/25]: Rename the new member from `packlock` to
  `packed_refs_lock`.

* Patch [13/25] (new patch): Move the check for valid
  `transaction->state` from `files_transaction_commit()` to
  `ref_transaction_commit()`.

* Patch [14/25]:

  * Add more sanity checks of `transaction->state`.

  * Don't add `ref_transaction_finish()` to the public API. Instead,
    teach `ref_transaction_commit()` to do the right thing whether or
    not `ref_transaction_prepare()` has been called.

  * Add and improve docstrings.

  * Allow `ref_transaction_abort()` to be called even before
    `ref_transaction_prepare()` (in which case it just calls
    `ref_transaction_free()`).

* Lots of improvements to commit messages and comments, mostly to
  clarify points that reviewers asked about.

These changes (along with the merge commit that they are based on) are
also available as branch `packed-ref-store-prep` in my GitHub fork
[2]. If you'd like to see a preview of the rest of the changes (which
works but is not yet polished), checkout the `mmap-packed-refs` branch
from the same place.

Michael

[1] http://public-inbox.org/git/cover.1495014840.git.mhagger@alum.mit.edu/
[2] https://github.com/mhagger/git

Jeff King (1):
  ref-filter: limit traversal to prefix

Michael Haggerty (24):
  t3600: clean up permissions test properly
  refs.h: clarify docstring for the ref_transaction_update()-related fns
  ref_iterator_begin_fn(): fix docstring
  files-backend: use `die("BUG: ...")`, not `die("internal error: ...")`
  prefix_ref_iterator: don't trim too much
  refs_ref_iterator_begin(): don't check prefixes redundantly
  refs: use `size_t` indexes when iterating over ref transaction updates
  ref_store: take a `msg` parameter when deleting references
  lockfile: add a new method, is_lock_file_locked()
  files-backend: move `lock` member to `files_ref_store`
  files_ref_store: put the packed files lock directly in this struct
  files_transaction_cleanup(): new helper function
  ref_transaction_commit(): check for valid `transaction->state`
  ref_transaction_prepare(): new optional step for reference updates
  ref_update_reject_duplicates(): expose function to whole refs module
  ref_update_reject_duplicates(): use `size_t` rather than `int`
  ref_update_reject_duplicates(): add a sanity check
  should_pack_ref(): new function, extracted from `files_pack_refs()`
  get_packed_ref_cache(): assume "packed-refs" won't change while locked
  read_packed_refs(): do more of the work of reading packed refs
  read_packed_refs(): report unexpected fopen() failures
  refs_ref_iterator_begin(): handle `GIT_REF_PARANOIA`
  create_ref_entry(): remove `check_name` option
  cache_ref_iterator_begin(): avoid priming unneeded directories

 builtin/fetch.c                |   2 +-
 builtin/remote.c               |   4 +-
 lockfile.h                     |   8 ++
 ref-filter.c                   |  64 ++++++++-
 refs.c                         | 135 ++++++++++++++++--
 refs.h                         | 149 +++++++++++++++-----
 refs/files-backend.c           | 302 +++++++++++++++++++++++++----------------
 refs/iterator.c                |  18 ++-
 refs/ref-cache.c               | 100 ++++++++++++--
 refs/ref-cache.h               |   6 +-
 refs/refs-internal.h           |  62 +++++++--
 t/helper/test-ref-store.c      |   3 +-
 t/t1405-main-ref-store.sh      |   2 +-
 t/t1406-submodule-ref-store.sh |   2 +-
 t/t3600-rm.sh                  |   4 +-
 15 files changed, 658 insertions(+), 203 deletions(-)

-- 
2.11.0

