From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 0/8] ref-transaction-send-pack
Date: Tue, 21 Oct 2014 13:46:32 -0700
Message-ID: <1413924400-15418-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 21 22:47:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XggKm-0005CL-Qt
	for gcvg-git-2@plane.gmane.org; Tue, 21 Oct 2014 22:47:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933547AbaJUUrG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Oct 2014 16:47:06 -0400
Received: from mail-pd0-f201.google.com ([209.85.192.201]:56670 "EHLO
	mail-pd0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933465AbaJUUqo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Oct 2014 16:46:44 -0400
Received: by mail-pd0-f201.google.com with SMTP id y10so374194pdj.0
        for <git@vger.kernel.org>; Tue, 21 Oct 2014 13:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=s4Y0BlKLX8XK3/QwVNWz1c6rk2BSiqdXAEh3hHsS8a4=;
        b=P6icRarhj3SCs87LxzPEbRTJgSn/4fkJoavDH+sAb4VDnuVogWrIZ2IbsHunypgmd3
         E8nkBCRse1rwtCwuhfuVMomKJFv0UI/prHoAxHpoyElGsm91tjKTpLWC1ObXoremz2wJ
         q64VYGrLG5itMNBqqBIbq5LcKV287eGSKEpNAqXXPCSdfroggjpThDhj3YGi+74ViLc5
         kiYcCr0XO5Jij2m3rgdqktggAX9KMmv26ZoIxjOs9aFNttfVP+AEE+ljrGN2YPqtaU4O
         Cdxiq4+atXSq4XUwaX7CR8kNTv7x1x3YHHvsbXH0xlaSDi7gs/bpNuN5r9lSuXU6pfnl
         WjNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=s4Y0BlKLX8XK3/QwVNWz1c6rk2BSiqdXAEh3hHsS8a4=;
        b=YqGo7OWBQiMap/YUUfYxUKNGhbx9dumcydgX8cHNkncNOE1dW3L6UMJJz6NNSzZNJN
         1r5H9GRz3M2+OPXFm53NuLz4sDV7oobMkeCa7tduqAVwv3jMghG3V94xsRS/YwD02+cS
         0H3BVgs/SAs1I2IZFa+49XkONfDdLIMjN2qdf1WHc5RCF+Y7aw68hGOuBL2eJYD3NM/v
         n4f79IlMiC8l9Onb0LtUlR344bayAKlPuI+WN6a8IemaRZYTJaEfsZzNncJH1NJKQHtd
         L7Leo/bOxyWwhBtLlVpiB7H0qoRtxJPCvgpwt39bpsnVXeVZdj6qJxgCrPOC8+RdHVsX
         Rx4A==
X-Gm-Message-State: ALoCoQkyw7X/sfbm+IoL2O7Evoih4RlblX6iAtt3x4lIf+86NheiKjXlAlmfj2X1w4F6KrC8g2+M
X-Received: by 10.70.119.71 with SMTP id ks7mr23820794pdb.9.1413924403867;
        Tue, 21 Oct 2014 13:46:43 -0700 (PDT)
Received: from corpmail-nozzle1-2.hot.corp.google.com ([100.108.1.103])
        by gmr-mx.google.com with ESMTPS id e24si596835yhe.3.2014.10.21.13.46.43
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Oct 2014 13:46:43 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com ([172.27.69.52])
	by corpmail-nozzle1-2.hot.corp.google.com with ESMTP id dk6Z9vjk.1; Tue, 21 Oct 2014 13:46:43 -0700
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 48719E0BD6; Tue, 21 Oct 2014 13:46:43 -0700 (PDT)
X-Mailer: git-send-email 2.1.2.738.gd04b95a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

List,

This series has been posted before but is now rebased on the previous
ref-transaction-rename series that are against next.
This series can also be found at :
https://github.com/rsahlberg/git/tree/ref-transactions-send-pack

This series finishes the transaction work to provide atomic pushes.
With this series we can now perform atomic pushes to a repository.



Ronnie Sahlberg (8):
  receive-pack.c: add protocol support to negotiate atomic-push
  send-pack.c: add an --atomic-push command line argument
  receive-pack.c: use a single transaction when atomic-push is
    negotiated
  push.c: add an --atomic-push argument
  t5543-atomic-push.sh: add basic tests for atomic pushes
  receive-pack.c: add a receive.preferatomicpush configuration variable
  refs.c: add an err argument to create_reflog
  refs.c: add an err argument to create_symref

 Documentation/config.txt                          |   4 +
 Documentation/git-push.txt                        |   7 +-
 Documentation/git-send-pack.txt                   |   7 +-
 Documentation/technical/protocol-capabilities.txt |  19 +++-
 builtin/branch.c                                  |   7 +-
 builtin/checkout.c                                |  21 +++-
 builtin/clone.c                                   |  15 ++-
 builtin/init-db.c                                 |   8 +-
 builtin/notes.c                                   |   7 +-
 builtin/push.c                                    |   2 +
 builtin/receive-pack.c                            |  87 +++++++++++---
 builtin/remote.c                                  |  26 +++--
 builtin/send-pack.c                               |   6 +-
 builtin/symbolic-ref.c                            |   6 +-
 cache.h                                           |   1 -
 refs.c                                            |  93 ++++++++-------
 refs.h                                            |   5 +-
 remote.h                                          |   3 +-
 send-pack.c                                       |  47 +++++++-
 send-pack.h                                       |   1 +
 t/t5543-atomic-push.sh                            | 133 ++++++++++++++++++++++
 transport.c                                       |   5 +
 transport.h                                       |   1 +
 23 files changed, 411 insertions(+), 100 deletions(-)
 create mode 100755 t/t5543-atomic-push.sh

-- 
2.1.0.rc2.206.gedb03e5
