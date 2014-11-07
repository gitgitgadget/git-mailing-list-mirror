From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v3 00/16] ref-transaction-rename
Date: Fri,  7 Nov 2014 11:38:49 -0800
Message-ID: <1415389145-6391-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 07 20:39:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XmpNK-0003nR-M6
	for gcvg-git-2@plane.gmane.org; Fri, 07 Nov 2014 20:39:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752601AbaKGTjJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2014 14:39:09 -0500
Received: from mail-pd0-f201.google.com ([209.85.192.201]:57300 "EHLO
	mail-pd0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752509AbaKGTjI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2014 14:39:08 -0500
Received: by mail-pd0-f201.google.com with SMTP id r10so637395pdi.2
        for <git@vger.kernel.org>; Fri, 07 Nov 2014 11:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=Q+m+RnTUFJgpd+1Jx8SaaKE29gZ/CwDil959JiVnpg4=;
        b=ASVHLUi8Sf3oX/K35zTyxTgY0ww2qfEc4DXDqnvgDS+MO+eR+RCSO7OkD1Cy9XiQmw
         2aORP/Vhj3kDxtOhz0axIkPJnbEsTVlijgCbwaZ5EKSOsK/nTZKUwRcDBfpNYMqbCdiM
         JiqxMGyZGg6JpCkaKJ6qVx8wjeWdV5ybo36CCPhpSl9QIegB2EnwscG0GapTGFLkYdfB
         jsjcVNsEUGPMCpDZuUlQJb53Ces6oZvE67aruHou9dRQY8ApVqjCKdS5vu1LsNL3BhdW
         YQwBggwHBohBqe3T+Wrzn/LMgqUXMINDLEAGnlW5wQLFOKz8jPushZlhz4yJ96L2Z04b
         zRUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Q+m+RnTUFJgpd+1Jx8SaaKE29gZ/CwDil959JiVnpg4=;
        b=aqnuIVgOFo2L1vXBrHNet88GQWRsZEWZqAdcjBPezCVzDyzctFqqIa3zsAJy427w/p
         NdWwtEcfn3HSQre0d7TpMEQi7x6yUjb91U6qPsKQEkDy64BHZwZBRx5OhDVTIuewEhcE
         xw0Uzs+BsZ9bt3XRcAY0J+ZyVIAokbs4Guh6+TUnAejrgwjA9oVlF0RpJ4owWJPQ4zEw
         TC3k9mvD0m3B16qQsThSGGbaJGs/Nk/YpexDtBVQ0bB/8ilgc/2ykmMcydlcDH1WP6Re
         EIJl9Q74y6B8eTm0f6MlMSEP/GflyM9tb05isCaYM9/+H6PxWZLrpKwTH4KcJHqsW2iP
         ieMg==
X-Gm-Message-State: ALoCoQlqRTvddM7mzN1K8FhTpIUo/bRU+qJJfUN1dag5VQ5VhjcZhh+RzW963SZp8pYX57QUDPMD
X-Received: by 10.66.142.106 with SMTP id rv10mr10594630pab.21.1415389148144;
        Fri, 07 Nov 2014 11:39:08 -0800 (PST)
Received: from corpmail-nozzle1-1.hot.corp.google.com ([100.108.1.104])
        by gmr-mx.google.com with ESMTPS id n63si402048yho.5.2014.11.07.11.39.07
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Nov 2014 11:39:08 -0800 (PST)
Received: from sahlberg1.mtv.corp.google.com ([172.27.69.52])
	by corpmail-nozzle1-1.hot.corp.google.com with ESMTP id Ldjw6uBT.1; Fri, 07 Nov 2014 11:39:08 -0800
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 4FF80E07F8; Fri,  7 Nov 2014 11:39:07 -0800 (PST)
X-Mailer: git-send-email 2.1.2.810.gfbd2bf7.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

List,

Thsi series builds on the previous series : ref-transaction-reflog
as applied to next. This series has been sent to the list before
but is now rebased to current git next.

This series can also be found at :
https://github.com/rsahlberg/git/tree/ref-transactions-rename

This series converts ref rename to use a transaction. This addesses several
issues in the old implementation, such as colliding renames might overwrite
someone elses reflog, and it makes the rename atomic.

As part of the series we also move changes that cover multiple refs to happen
as an atomic transaction/rename to the pacekd refs file. This makes it possible
to have both the rename case (one deleted ref + one created ref) as well
as any operation that updates multiple refs to become one atomic rename()
applied to the packed refs file. Thus all such changes are now also atomic
to all external observers.

Version 2:
- Changed to not use potentially iterators to copy the reflog entries one
  by one. Instead adding two new functions. One to read an existing reflog
  as one big blob, and a second function to, in a transaction, write a new
  complete reflog from said blob.
  The idea is that each future reflog backend will provide optimized
  versions for these "read whole reflog" "write whole reflog" functions.

Version 3:
- Rename and redo the API for updating a whole reflog in one single operation
  to transaction_rename_reflog()

Ronnie Sahlberg (16):
  refs.c: allow passing raw git_committer_info as email to
    _update_reflog
  refs.c: return error instead of dying when locking fails during
    transaction
  refs.c: use packed refs when deleting refs during a transaction
  refs.c: use a stringlist for repack_without_refs
  refs.c: add transaction support for renaming a reflog
  refs.c: update rename_ref to use a transaction
  refs.c: rollback the lockfile before we die() in repack_without_refs
  refs.c: move reflog updates into its own function
  refs.c: write updates to packed refs when a transaction has more than
    one ref
  remote.c: use a transaction for deleting refs
  refs.c: make repack_without_refs static
  refs.c: make the *_packed_refs functions static
  refs.c: replace the onerr argument in update_ref with a strbuf err
  refs.c: make add_packed_ref return an error instead of calling die
  refs.c: make lock_packed_refs take an err argument
  refs.c: add an err argument to pack_refs

 builtin/checkout.c    |   7 +-
 builtin/clone.c       |  36 ++-
 builtin/merge.c       |  20 +-
 builtin/notes.c       |  24 +-
 builtin/pack-refs.c   |   8 +-
 builtin/reflog.c      |  19 +-
 builtin/remote.c      |  69 +++---
 builtin/reset.c       |  12 +-
 builtin/update-ref.c  |   7 +-
 notes-cache.c         |   2 +-
 notes-utils.c         |   5 +-
 refs.c                | 616 ++++++++++++++++++++++++++++++--------------------
 refs.h                |  79 +++----
 t/t3200-branch.sh     |   7 -
 t/t5516-fetch-push.sh |   2 +-
 transport-helper.c    |   7 +-
 transport.c           |   9 +-
 17 files changed, 552 insertions(+), 377 deletions(-)

-- 
2.1.0.rc2.206.gedb03e5
