From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v3 0/7] ref-transaction-send-pack
Date: Fri,  7 Nov 2014 11:41:54 -0800
Message-ID: <1415389321-10386-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 07 20:42:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XmpQG-0006yl-Vq
	for gcvg-git-2@plane.gmane.org; Fri, 07 Nov 2014 20:42:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753300AbaKGTmH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2014 14:42:07 -0500
Received: from mail-qg0-f73.google.com ([209.85.192.73]:43243 "EHLO
	mail-qg0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751806AbaKGTmF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2014 14:42:05 -0500
Received: by mail-qg0-f73.google.com with SMTP id z107so279331qgd.4
        for <git@vger.kernel.org>; Fri, 07 Nov 2014 11:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=gpNc+bBzEYDiGIm7H0uTPRIKDETpu+qv55h4ghiSPnY=;
        b=QEVj3s/wXH5AcWnZNo2e4yHQMzQjQ5SCf0Rnl6fmPVBavI4vyiB8JezMvTXpgrJKE5
         JTzpJF1Wmw80IezCY3hMPcMT9yjV5/TFXY/m3aQSDrUXNSBNT0vMMgEt5CdDkHtIUqqu
         jeuonpqWS5uVlj0PElDa+cFZkKpRaCmoqT4KXcmf8Sz5BZyuK3fjXdZzIigbQh9BAWR6
         XgSucRE+MA1M8fnTBj4M/KHJ9dwKw6AEPJTiaCtb4lc4zWUvt+dIAu+LaT+NdrEUOHfF
         QTMIZjtMVmROE2v8L9XH6xSpoWwqdspI76YWbD8eNKclXd8ZVqx3q13G4JNSOESzKIP9
         p+DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gpNc+bBzEYDiGIm7H0uTPRIKDETpu+qv55h4ghiSPnY=;
        b=Qxjzu/ZhQgE1aeNp+VtJwd2o6c5qkLXZVHHnJl8HKdIPLqGVIqp73W13vvmjN+BMU1
         OkYr/5ENQ4kW1ClU+ildRRnMG8vEg2nlkOkX+oKTeAcgbg92eE3i5lvWBrdpqcgv2eZv
         XQl2cCiv2MyOVJRlj9/K5a/IHvR4aDFVg/EwUoHLrYnQd8/M2GPubyzw7vtHfOyZmBfi
         7xk0rFE86/d457Ob4pT5oNQshzZBJV3n+wIX+D92oefRNicNbrMRSZ21DlEowZ+6NKzM
         GjaSPdlq1wngVoRpfYdv+1O/rXg60VziSkmP6NAjS4srfa6iSujU3OTP2oxDOF0EqtsR
         2NKw==
X-Gm-Message-State: ALoCoQlpdSItXVAli3iKTc4eEqih3GON6eX7g+9JGO+yLFeadOEwbyP5I7Qxnxp2j6YOp7hdCoDz
X-Received: by 10.236.22.106 with SMTP id s70mr11219390yhs.7.1415389324421;
        Fri, 07 Nov 2014 11:42:04 -0800 (PST)
Received: from corpmail-nozzle1-2.hot.corp.google.com ([100.108.1.103])
        by gmr-mx.google.com with ESMTPS id k66si400862yho.7.2014.11.07.11.42.04
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Nov 2014 11:42:04 -0800 (PST)
Received: from sahlberg1.mtv.corp.google.com ([172.27.69.52])
	by corpmail-nozzle1-2.hot.corp.google.com with ESMTP id A5q9rs2k.1; Fri, 07 Nov 2014 11:42:04 -0800
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 92163E0A83; Fri,  7 Nov 2014 11:42:03 -0800 (PST)
X-Mailer: git-send-email 2.1.2.810.gfbd2bf7.dirty
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

Version 2:
- Reordered the capabilities we send so that agent= remains the last
  capability listed.
- Reworded the paragraph for atomic push in git-send-pack.txt
- Dropped the patch for receive.preferatomicpush

Version 3:
- Fix a typo in a commit message.

Ronnie Sahlberg (7):
  receive-pack.c: add protocol support to negotiate atomic-push
  send-pack.c: add an --atomic-push command line argument
  receive-pack.c: use a single transaction when atomic-push is
    negotiated
  push.c: add an --atomic-push argument
  t5543-atomic-push.sh: add basic tests for atomic pushes
  refs.c: add an err argument to create_reflog
  refs.c: add an err argument to create_symref

 Documentation/git-push.txt                        |   7 +-
 Documentation/git-send-pack.txt                   |   7 +-
 Documentation/technical/protocol-capabilities.txt |  12 ++-
 builtin/branch.c                                  |   7 +-
 builtin/checkout.c                                |  21 +++--
 builtin/clone.c                                   |  15 +++-
 builtin/init-db.c                                 |   8 +-
 builtin/notes.c                                   |   7 +-
 builtin/push.c                                    |   2 +
 builtin/receive-pack.c                            |  79 +++++++++++++----
 builtin/remote.c                                  |  26 ++++--
 builtin/send-pack.c                               |   6 +-
 builtin/symbolic-ref.c                            |   6 +-
 cache.h                                           |   1 -
 refs.c                                            |  93 ++++++++++----------
 refs.h                                            |   5 +-
 remote.h                                          |   3 +-
 send-pack.c                                       |  45 ++++++++--
 send-pack.h                                       |   1 +
 t/t5543-atomic-push.sh                            | 101 ++++++++++++++++++++++
 transport.c                                       |   5 ++
 transport.h                                       |   1 +
 22 files changed, 358 insertions(+), 100 deletions(-)
 create mode 100755 t/t5543-atomic-push.sh

-- 
2.1.0.rc2.206.gedb03e5
