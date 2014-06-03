From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v13 00/41] Use ref transactions
Date: Tue,  3 Jun 2014 14:37:18 -0700
Message-ID: <1401831479-3388-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 03 23:42:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WrwTi-0008JT-Q5
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jun 2014 23:42:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933399AbaFCVmh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2014 17:42:37 -0400
Received: from mail-ie0-f202.google.com ([209.85.223.202]:46343 "EHLO
	mail-ie0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934012AbaFCViH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2014 17:38:07 -0400
Received: by mail-ie0-f202.google.com with SMTP id rd18so1461697iec.3
        for <git@vger.kernel.org>; Tue, 03 Jun 2014 14:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=2onJ1JNHnEf/MZJtoeBm/QQ0KjDnTTh0t9JgtCbcrn4=;
        b=F4bdGD97cGI/lkYbHefhxJLGFxglOxI8djIzvWu1uD5izeIfVWG6QIiIVKt5xTojZi
         YGE5ezUgANNjbSXngnbgs2IBB5tWfhN+X7QcxZKxnoQ0JOAHulIsWUVWFxPNF2uKimKN
         FKlW1dlEoaNm/L6UTazmTwrlEgHnrGS9lm8z899834Coz4dO8q27dJeXZ4fKtt/+3gIm
         a1+3DVUaVoVI4QIb+VLpr53jnZXSZot60ASvxGn3JVR7hwAkCZh9RAkw7/VSgi8Dw5n5
         BRfhVVlYQdls1aYURWb8/B2wlVCfVtyABxIcJFfFDOLAW6e5rE+VvQdXXI1KmAoz4Wk1
         NErA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2onJ1JNHnEf/MZJtoeBm/QQ0KjDnTTh0t9JgtCbcrn4=;
        b=mpq6Nhv9T3m8LoZPIVhRAkSC4qaKODGsVnqAqtcEGJaSeahEqWkrDF+db/xTfp8aYg
         JxhlH7bNAntG+Z6AWDhdqik66FxX8JdpvITml1AKhbYf+smK1JjAS088Wx93Vdb/FIWG
         xh7XGLv9Af/CORNmF5zL2It93NOL9/fP5JSqD0XU/SNvcLg5cDveOWv8L/9Q+O1gyP/S
         JUYLVer+8Ye/X7xg+07vN7oCUuR8t9uXDPW81A5xVTpjjfpCg9tMA0bBIvZxKiVopcIM
         eV/JhXAuMHwmO789Mzz/X4hMIfIK4p37DtQKGfSHHIG/bB0/hyuSbQbGzQiOupZnaIKg
         EWLg==
X-Gm-Message-State: ALoCoQkMFPVPAi4p6XnMQB3cxy7LN5u6l/pXdODPHuwZJMRQ2odEgsiHuvj5OT2Dj+ODjiDSUyoB
X-Received: by 10.50.79.129 with SMTP id j1mr11071669igx.7.1401831486835;
        Tue, 03 Jun 2014 14:38:06 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id n68si29241yhj.5.2014.06.03.14.38.06
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Jun 2014 14:38:06 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 8EDB131C435;
	Tue,  3 Jun 2014 14:38:06 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 2C9DDE05F1; Tue,  3 Jun 2014 14:38:06 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.567.g64a7adf
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250689>

This patch series can also be found at
https://github.com/rsahlberg/git/tree/ref-transactions


This patch series is based on next and expands on the transaction API. It
converts all ref updates, inside refs.c as well as external, to use the
transaction API for updates. This makes most of the ref updates to become
atomic when there are failures locking or writing to a ref.

This version completes the work to convert all ref updates to use transactions.
Now that all updates are through transactions I will start working on
cleaning up the reading of refs and to create an api for managing reflogs but
all that will go in a different patch series.

Version 13:
 - This version should cover all of JNs suggestions on the previous series.
   If I missed anything I appologize.


Ronnie Sahlberg (41):
  refs.c: remove ref_transaction_rollback
  refs.c: ref_transaction_commit should not free the transaction
  refs.c: constify the sha arguments for
    ref_transaction_create|delete|update
  refs.c: allow passing NULL to ref_transaction_free
  refs.c: add a strbuf argument to ref_transaction_commit for error
    logging
  refs.c: add an err argument to repack_without_refs
  refs.c: make ref_update_reject_duplicates take a strbuf argument for
    errors
  refs.c: add an err argument to delete_ref_loose
  refs.c: make update_ref_write update a strbuf on failure
  update-ref: use err argument to get error from ref_transaction_commit
  refs.c: remove the onerr argument to ref_transaction_commit
  refs.c: change ref_transaction_update() to do error checking and
    return status
  refs.c: change ref_transaction_create to do error checking and return
    status
  refs.c: update ref_transaction_delete to check for error and return
    status
  refs.c: make ref_transaction_begin take an err argument
  refs.c: add transaction.status and track OPEN/CLOSED/ERROR
  tag.c: use ref transactions when doing updates
  replace.c: use the ref transaction functions for updates
  commit.c: use ref transactions for updates
  sequencer.c: use ref transactions for all ref updates
  fast-import.c: change update_branch to use ref transactions
  branch.c: use ref transaction for all ref updates
  refs.c: change update_ref to use a transaction
  receive-pack.c: use a reference transaction for updating the refs
  fast-import.c: use a ref transaction when dumping tags
  walker.c: use ref transaction for ref updates
  refs.c: make lock_ref_sha1 static
  refs.c: remove the update_ref_lock function
  refs.c: remove the update_ref_write function
  refs.c: remove lock_ref_sha1
  refs.c: make prune_ref use a transaction to delete the ref
  refs.c: make delete_ref use a transaction
  refs.c: pass the ref log message to _create/delete/update instead of
    _commit
  refs.c: pass NULL as *flags to read_ref_full
  refs.c: pack all refs before we start to rename a ref
  refs.c: move the check for valid refname to lock_ref_sha1_basic
  refs.c: call lock_ref_sha1_basic directly from commit
  refs.c: pass a skip list to name_conflict_fn
  refs.c: propagate any errno==ENOTDIR from _commit back to the callers
  fetch.c: change s_update_ref to use a ref transaction
  refs.c: make write_ref_sha1 static

 branch.c               |  30 +--
 builtin/commit.c       |  24 ++-
 builtin/fetch.c        |  36 ++--
 builtin/receive-pack.c |  32 +++-
 builtin/replace.c      |  15 +-
 builtin/tag.c          |  15 +-
 builtin/update-ref.c   |  34 ++--
 cache.h                |   2 +
 fast-import.c          |  54 ++++--
 lockfile.c             |  37 ++--
 refs.c                 | 503 ++++++++++++++++++++++++++++++++-----------------
 refs.h                 | 118 +++++++++---
 sequencer.c            |  24 ++-
 t/t3200-branch.sh      |   6 +-
 walker.c               |  58 +++---
 15 files changed, 647 insertions(+), 341 deletions(-)

-- 
2.0.0.567.g64a7adf
