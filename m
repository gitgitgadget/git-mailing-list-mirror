From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v3 00/14] ref-transactions-reflog
Date: Wed, 18 Jun 2014 10:08:52 -0700
Message-ID: <1403111346-18466-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 18 19:09:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxJMV-0006uT-8Q
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jun 2014 19:09:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753334AbaFRRJL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2014 13:09:11 -0400
Received: from mail-ie0-f202.google.com ([209.85.223.202]:55190 "EHLO
	mail-ie0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750862AbaFRRJK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2014 13:09:10 -0400
Received: by mail-ie0-f202.google.com with SMTP id tr6so300247ieb.5
        for <git@vger.kernel.org>; Wed, 18 Jun 2014 10:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=Cjftj3wypDbspmgLCnQh/OP+ko7UHbgpC4pEaMmukoI=;
        b=PY6px69z/KO7o0pH7cJ3pulW0PZm5LS8UHUFo5waZU3/RBgmheAjfnCM94aVxfdBw4
         xMmWbrUSnMg+mUA0ZXFNJq2qvphBA7Ey8mapGYz1GSdDNumN2/8ToOhbwfm8QEkEWHMx
         rsHqQBwuR8aORmpJEEprXrMJGbdyIZRW3rgCQBZlrqgI3L4nHb4k9dWwbwCLASYburzS
         JxJ6EQf5LGA0SLBJUTKcG0rRj2ESAuUP1zaZQpZOnv8cyxTStn/prmvs43TpzvGvTNRR
         Wnfe288OkK6DGwYFZTFaWly2L6vkFgR4zRVALOfrdgXwi1Of1s6XE+40x4zgoXnbTLYP
         +q+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Cjftj3wypDbspmgLCnQh/OP+ko7UHbgpC4pEaMmukoI=;
        b=hRQDIL2cwTfOcA1vfWik+zCELAbwMKNmncwb3u+xjsqQMyLtjSSF6/kFbdHNJI62Mx
         eWpRUKBRYa/kiwzYkUnK6mWUwHJ9CJpUVE6256SfOH7C4pEX3RZzLtSp8QrE9GMqZvyU
         5EUDYX6OxboNqcbn0xguIgZtw4XQVbj4r0GVhEbbbF/SkeNv701laeI40r62cI0l3tZN
         zVPoFBWIMzJmGXToUguiM+i6S3Qw2dLU8a5zsXn09MQ0P2fGUMlB8/zW/7+xWYSS+vyp
         pUA+ejbLqLlID+aF+m7Re0/JpSUm7TZPwmvB789fGakIiVDnXR+eTxiwl4QXuVyRpCRG
         5Slg==
X-Gm-Message-State: ALoCoQk6qaj5ngzkM2O2oeuz3vkpXGYVs5otkfvBPoUdF/+GXlxzdF8kcE4EUMuivcnrE06JQzjl
X-Received: by 10.50.85.102 with SMTP id g6mr1912051igz.8.1403111349590;
        Wed, 18 Jun 2014 10:09:09 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id z50si173677yhb.3.2014.06.18.10.09.09
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 18 Jun 2014 10:09:09 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 6CBC35A478E;
	Wed, 18 Jun 2014 10:09:09 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 10635E0966; Wed, 18 Jun 2014 10:09:08 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.467.g08c0633
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251991>

These patches can also be found at:
https://github.com/rsahlberg/git/tree/ref-transactions-reflog
This series is based on, and applies ontop of, the previous 48 patch long
ref-transaction series that is now in origin/pu.

 
This series introduces support for reflog updates to the transaction framework
and ends up re-factoring reflog.c to use a single atomic transaction for
updating both the ref and its reflog.

With these changes we also reduce the number of places where we build and write
a reflog entry to a single function which makes maintenance easier.
Several functions that act on reflogs can now be made private to refs.c
since we no longer need to export them.


This is version 3:
 - Update and rebased ontop of the current ref-transactions series.

Ronnie Sahlberg (14):
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

 branch.c               |  11 +-
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
 refs.c                 | 377 ++++++++++++++++++++++++++++++++++---------------
 refs.h                 | 109 +++++++-------
 sequencer.c            |  12 +-
 walker.c               |  16 +--
 16 files changed, 448 insertions(+), 300 deletions(-)

-- 
2.0.0.467.g08c0633
