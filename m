From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v2 0/7] ref-transaction-send-pack
Date: Mon,  3 Nov 2014 11:12:25 -0800
Message-ID: <1415041952-19637-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 03 20:12:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XlN3Q-0006LE-OA
	for gcvg-git-2@plane.gmane.org; Mon, 03 Nov 2014 20:12:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753442AbaKCTMg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2014 14:12:36 -0500
Received: from mail-pd0-f202.google.com ([209.85.192.202]:40246 "EHLO
	mail-pd0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752329AbaKCTMf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2014 14:12:35 -0500
Received: by mail-pd0-f202.google.com with SMTP id ft15so1997807pdb.5
        for <git@vger.kernel.org>; Mon, 03 Nov 2014 11:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=dac+XOGZntImC4QztFdolDUTSINwaEii7qf3N+NJTeo=;
        b=bFtVP1ARks8jJlBHp4qh31Y5cUWcP5u9/CG4H+8gGsyyQ3Q5QJ07cQ2Y0Hlvyl/6FX
         p/WKayl5hNWd1rtjrxZOM0v6EXnqNFafDZCZ0QhvLiSNG6PtDaMgUVTWuCFvciWRsH9R
         zFXj5mZCvNtdW5entxOXQ2TzHmDXy0S4POIDJh8AelazFgylacGt8bqmyER9W7LXkawA
         Y6AJ0UdWctqmYNpux0JvJRTSOeaK4CNBim1tpJq7/OJKIltEvOcwryeRwFZLaaNPym16
         1K5W5rFgnw9YxlW6XDsGQFtef9t/A4X5MrJq9XkwGU6NJ4ocHbmknG7azHB1YaRg4KBr
         ELig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dac+XOGZntImC4QztFdolDUTSINwaEii7qf3N+NJTeo=;
        b=Cztk4RnSs/dGVh7FFAcegaDZwl/G6Ba+X1bPSJm0AvRX+IeF2H46edlHGWxTUWIY1O
         c9h3tAjbZLw8TIVS3mBSARvQBtbbIEGysRwfxR3yNGf+ee/+bGJxPZJ4uTuGZj1Lu1yB
         dJNge/14rOPJNKM22XH9UWo5sq7jHIY2wSlBxcAfCBtiOwLFni9ge0Xp1FDlp/iy8yAY
         S2PK/+VVJ2Ey/3R2RwOEvKVA5xsvrRMmRm7wL7/nwaN1qAREdLyUA/ANbEy86mMG18dK
         cZqj6U9Q/J8hkQrLcpYPJ7CX9OZdc3XLZMtkCV5CencKWtfgBeaXHGKKL8t5yA6KSVY0
         MNXw==
X-Gm-Message-State: ALoCoQnShPrkw+Qy4bNtK61zQvRw1O00itkc1yetHfw3+Lo5GnWmPIxaaVX3DWZljn9dxvOzJIKv
X-Received: by 10.66.142.229 with SMTP id rz5mr32954867pab.36.1415041954886;
        Mon, 03 Nov 2014 11:12:34 -0800 (PST)
Received: from corpmail-nozzle1-2.hot.corp.google.com ([100.108.1.103])
        by gmr-mx.google.com with ESMTPS id t28si976234yhb.4.2014.11.03.11.12.34
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Nov 2014 11:12:34 -0800 (PST)
Received: from sahlberg1.mtv.corp.google.com ([172.27.69.52])
	by corpmail-nozzle1-2.hot.corp.google.com with ESMTP id 7jRt0YQm.1; Mon, 03 Nov 2014 11:12:34 -0800
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 09833E0F37; Mon,  3 Nov 2014 11:12:33 -0800 (PST)
X-Mailer: git-send-email 2.1.2.785.g8f5823f
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
