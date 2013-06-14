From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v2 0/5] Write a good 'git stash store' for autostash
Date: Fri, 14 Jun 2013 16:01:59 +0530
Message-ID: <1371205924-8982-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 14 12:30:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnRHB-0000Kx-T0
	for gcvg-git-2@plane.gmane.org; Fri, 14 Jun 2013 12:30:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752019Ab3FNKaM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jun 2013 06:30:12 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:33566 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751972Ab3FNKaL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jun 2013 06:30:11 -0400
Received: by mail-pa0-f51.google.com with SMTP id lf11so524420pab.10
        for <git@vger.kernel.org>; Fri, 14 Jun 2013 03:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=NcpekZ5FJPekSgAnph34I9gzw0tz9hkHGg3bI7Unr0Y=;
        b=rhqTAtuPmAP/rC2njyKNeuJq5yYzv4Nv6MxhFmgYvVZiGamxDsO8SgqGGatRpxnf0r
         syp4qYojghqkhnuuQmBvkrcyjqrKL01aw4AhpiOPRLMriPBi/F34ZWoZVPL8wkIKptXY
         dnArAaJyJmBUkcfPFbWdvDn1wt7UBG9rtrGmefyyOP1VfiY9inMFhKnmq6NgPOg5dMku
         uelX7G47q5RaIjw3GZJGuR5LRXuLSrKLP57T8fLQmBh9AYF1M0YQLvdcE+bv1zrUtW5L
         prkx0sEM4jQriveXYQFeCA5JZm26CKNhWVwy5PUFwrDtkqR5R9mo8PeuFIg5Vk6rHBh1
         gCYg==
X-Received: by 10.66.118.79 with SMTP id kk15mr1860107pab.193.1371205810823;
        Fri, 14 Jun 2013 03:30:10 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPSA id xj9sm1809871pbc.16.2013.06.14.03.30.07
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 14 Jun 2013 03:30:09 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.383.g0d5ad6b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227803>

Hi,

So, I've taken Junio's suggestion and designed a proper command-line
interface for 'git stash store' in this iteration:

  git stash store [-m <message>] [-e <error>] <commit>

The error string will be passed through eval_gettext before it is
printed.  Otherwise, the idea is the same: to clean up the logic
surrounding autostash.

Thanks.

Ramkumar Ramachandra (5):
  stash doc: add a warning about using create
  stash doc: document short form -p in synopsis
  stash: simplify option parser for create
  stash: introduce 'git stash store'
  rebase: use 'git stash store' to simplify logic

 Documentation/git-stash.txt | 12 ++++++++--
 git-rebase.sh               |  6 +----
 git-stash.sh                | 53 ++++++++++++++++++++++++++++++++++++---------
 t/t3903-stash.sh            | 19 ++++++++++++++++
 4 files changed, 73 insertions(+), 17 deletions(-)

-- 
1.8.3.1.383.g0d5ad6b
