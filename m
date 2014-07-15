From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 00/20] ref transactions part 2
Date: Tue, 15 Jul 2014 16:33:58 -0700
Message-ID: <1405467258-24102-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 16 01:34:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7CEy-0003Ia-S7
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jul 2014 01:34:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934332AbaGOXe3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2014 19:34:29 -0400
Received: from mail-ie0-f201.google.com ([209.85.223.201]:54982 "EHLO
	mail-ie0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932230AbaGOXeX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2014 19:34:23 -0400
Received: by mail-ie0-f201.google.com with SMTP id tr6so34537ieb.4
        for <git@vger.kernel.org>; Tue, 15 Jul 2014 16:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=zC1SC63nMToEemEem9niJpCvfJJwHa4oRAmIQNtpuZY=;
        b=On2ZZxvCvc77QDvlvZgZiwrfHXjoV4jbNv7d7n6q8anKV0cTQJk0z/Sz84bdVq5u51
         kBr0CGWb9lXfwUia5QvYmvTQYcCvs42PZxJjpf/CLCVqXp1Ib98szC+qYY1a5pLBSElq
         Yd4ZyHgSjLvby74UiYOVCmYF7GXi+F/l6s/jGYhhd5GjdnJv2RfXscBUNImFRkaD3BeX
         O3QkSOnYiKAG8bktMknfw1B7yTc81fTY4GAj1o+65IFELfx6T4j+NlCd5RkDN8XuDAZy
         dJqNOIl64jmWGjYoB3MV8dwyHbHGjMlcBNjiVTyt4+CpgCnxmPp58CVW8TC+Lx3A4RQq
         wYPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zC1SC63nMToEemEem9niJpCvfJJwHa4oRAmIQNtpuZY=;
        b=LApn/hcCHFlJ78f8VYA04scyhizwVAWiltZHtU3awdIMNwCd+fop7z2PvZwyluHdO+
         Wgrv9H4eyiYXnpe4qWNygqoSZvWdb9rRq8hw5JNETzm88+it06EqGiLc/PdD8szUf4ps
         N6SgKgyZiTc03/dL5D7vAxdiEUdJbz89uy9jVdGhHPY9tazTl+AY7hoEjp5Mq62EAOxz
         3O1t9iZKjoUD1wG/qwfzrgj3/z59nfoEIby4c5SM4/dqmIXNUBuTlila/i93Mky4m2sw
         Ku4wZUQU3scaaX/mAjAMqtcF5vtnkJcmTIVmEIr1bBYcpKSEnSRf37rXYgcw1EBUQ4m/
         6eQQ==
X-Gm-Message-State: ALoCoQkoJT0EU/CAczUSyIGvWDEKiXUMOq6mGq0JnAUfockLM4pa38x1lRSxljaJCTrr2nzDpswP
X-Received: by 10.43.67.68 with SMTP id xt4mr8599379icb.23.1405467262676;
        Tue, 15 Jul 2014 16:34:22 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id z50si1060581yhb.3.2014.07.15.16.34.22
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 15 Jul 2014 16:34:22 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 8084031C2D7;
	Tue, 15 Jul 2014 16:34:22 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id EDAC2E0B6B; Tue, 15 Jul 2014 16:34:21 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.481.gb244468
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253626>

This is the next 20 patches from my originally big patch series and follow
the previous 19 patches that is now in juns tree.
These patches were numbered 20-39 in the original 48-patch series.

Changes since these patches were in the original series:

- Addressing concerns from mhagger's review


Ronnie Sahlberg (20):
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

 branch.c               |  30 +++---
 builtin/commit.c       |  24 +++--
 builtin/receive-pack.c |  96 +++++++++++++-------
 builtin/replace.c      |  15 +--
 builtin/tag.c          |  15 +--
 builtin/update-ref.c   |  11 ++-
 fast-import.c          |  53 +++++++----
 refs.c                 | 242 ++++++++++++++++++++++++++++---------------------
 refs.h                 |  78 ++++++++++++----
 sequencer.c            |  27 ++++--
 walker.c               |  59 +++++++-----
 11 files changed, 403 insertions(+), 247 deletions(-)

-- 
2.0.1.442.g7fe6834.dirty
