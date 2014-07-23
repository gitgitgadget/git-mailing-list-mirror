From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 00/15] ref-transactions for reflogs
Date: Wed, 23 Jul 2014 10:03:40 -0700
Message-ID: <1406135035-26441-1-git-send-email-sahlberg@google.com>
Cc: gitster@pobox.com, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 23 19:04:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X9zxV-000447-E6
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jul 2014 19:04:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932514AbaGWREA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2014 13:04:00 -0400
Received: from mail-yk0-f201.google.com ([209.85.160.201]:55418 "EHLO
	mail-yk0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932080AbaGWRD6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2014 13:03:58 -0400
Received: by mail-yk0-f201.google.com with SMTP id 142so86612ykq.2
        for <git@vger.kernel.org>; Wed, 23 Jul 2014 10:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=jYDA7f0WL/xsUXOERyImlN8FMFifcDqSDC57dVwj9eo=;
        b=ZsURfGEz6lTpqSgBi8bmQ/7f+sSXBjdN2NG/GNKHnuJqgd/u9iuHX+icJ8xhuqZzQ7
         mBr+DARiuCrm8T+EgBFulfowYyk1jBfXCZl0VV+wslSa1GxW8a9g9WCnNezNwG3gEJ8X
         6aJbGifQV6h0+FGH37g1yTlYMwSbdg005iNtxn3AJGowwqdq6pdEScK8LY+T3tMMkhBC
         2naoVYZLtnYGC/a/gpw4EEP+49Agb8AHdPrfn8KBreCxsAYQ0PbpS7ObDXIXWHZlgTRZ
         oo6+5CE3JqTecqxZYCjRDbd366GZ0mlzpHqskLpWpLX+o5k+jp5i9RT1bYv8xQEFc3Jx
         +N3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jYDA7f0WL/xsUXOERyImlN8FMFifcDqSDC57dVwj9eo=;
        b=F2haBRh5KvK7P74F7KUhhSN5niXpepvHEwntnXbh7Cp1cuyk/2f6DkHrJE1o8bnuaG
         te4pQ4LBz0Ip/fnT6+XsxSlQwBqdI8EYg1jzzu0MznimoInfeA7jsgSAQ60627h0hF2s
         IW5uFX3ZWKTUNtjr0JA8qBV2uHSlXmVAbzDDw8OykH/JpG7yLPWfCDbAi7JUy8tJf0af
         Aof6rPnWyLZf+yvSegF7hDWFJjY4MaXveo7kD9dHpzhDcVWS8AepfqK+5wpk2e0ttRir
         z9Efr3h0II3BBWPsURNSt2MydAQCkBoiB/SfyIQdpdcaVD7fuAthIA6sW8evblfca29s
         9EjA==
X-Gm-Message-State: ALoCoQmEEbcto5BZAO40dD/eHUyxuk9MQHyvyXWQoTMXc8BC6RZLxGnjhG3wJc2J6qQ5HeCIbR0Z
X-Received: by 10.236.43.20 with SMTP id k20mr1043959yhb.54.1406135038112;
        Wed, 23 Jul 2014 10:03:58 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id p3si487174yho.7.2014.07.23.10.03.58
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 23 Jul 2014 10:03:58 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id F140131C34D;
	Wed, 23 Jul 2014 10:03:57 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 8FAA5E0670; Wed, 23 Jul 2014 10:03:57 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.508.g763ab16
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254079>

List, Jun,

This is the next patch series for ref-transactions.
It is also available at 

https://github.com/rsahlberg/git/tree/ref-transactions-reflog

and is the same patch series that has been posted previously with one
exception:
This series now contains an additional patch that fixes ref handling
of broken refs. This patch allows a user to delete a ref that can not
be resolved and contains a broken SHA1.

The main part of the patch series is to refactor the reflog handling
to use transactions and eventually leads up to :
* only a single place in the code where we marshall the reflog text line
* atomic transaction for reflog.c for performing the reflog expire
  operation.


This series is based on and builds on the previous series that is now in
origin/pu:
===
commit c52f85eb59d26a7036d2149bc5b4347d0ecbbbeb
Merge: 44fc7ba 282edb2
Author: Junio C Hamano <gitster@pobox.com>
Date:   Mon Jul 21 12:35:51 2014 -0700

    Merge branch 'rs/ref-transaction' into jch
    
    * rs/ref-transaction:
      refs.c: fix handling of badly named refs
      refs.c: make write_ref_sha1 static
      fetch.c: change s_update_ref to use a ref transaction
      refs.c: propagate any errno==ENOTDIR from _commit back to the callers
      refs.c: pass a skip list to name_conflict_fn
      refs.c: call lock_ref_sha1_basic directly from commit
      refs.c: move the check for valid refname to lock_ref_sha1_basic
      refs.c: pass NULL as *flags to read_ref_full
      refs.c: pass the ref log message to _create/delete/update instead of _commit
      refs.c: add an err argument to delete_ref_loose
      wrapper.c: add a new function unlink_or_msg
      wrapper.c: simplify warn_if_unremovable
===

  
Ronnie Sahlberg (15):
  refs.c make ref_transaction_create a wrapper to ref_transaction_update
  refs.c: make ref_transaction_delete a wrapper for
    ref_transaction_update
  refs.c: rename the transaction functions
  refs.c: add a new update_type field to ref_update
  refs.c: add a function to append a reflog entry to a fd
  lockfile.c: make hold_lock_file_for_append preserve meaningful errno
  refs.c: add a transaction function to append a reflog entry
  refs.c: add a flag to allow reflog updates to truncate the log
  refs.c: only write reflog update if msg is non-NULL
  refs.c: allow multiple reflog updates during a single transaction
  reflog.c: use a reflog transaction when writing during expire
  refs.c: rename log_ref_setup to create_reflog
  refs.c: make unlock_ref/close_ref/commit_ref static
  refs.c: remove lock_any_ref_for_update
  refs.c: allow deleting refs with a broken sha1

 branch.c               |  11 +-
 builtin/branch.c       |   6 +-
 builtin/checkout.c     |   8 +-
 builtin/commit.c       |  14 +-
 builtin/fetch.c        |  12 +-
 builtin/receive-pack.c |  14 +-
 builtin/reflog.c       |  84 +++++------
 builtin/replace.c      |  10 +-
 builtin/tag.c          |  10 +-
 builtin/update-ref.c   |  22 +--
 copy.c                 |  20 ++-
 fast-import.c          |  22 +--
 lockfile.c             |   7 +-
 refs.c                 | 392 ++++++++++++++++++++++++++++++++++---------------
 refs.h                 | 110 +++++++-------
 sequencer.c            |  14 +-
 walker.c               |  16 +-
 17 files changed, 461 insertions(+), 311 deletions(-)

-- 
2.0.1.508.g763ab16
