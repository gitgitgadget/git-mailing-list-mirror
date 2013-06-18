From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 0/8] Re-roll rr/rebase-checkout-reflog
Date: Tue, 18 Jun 2013 17:44:22 +0530
Message-ID: <1371557670-12534-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 18 14:17:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uouqw-0007gv-Sc
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 14:17:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754374Ab3FRMRf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 08:17:35 -0400
Received: from mail-pb0-f42.google.com ([209.85.160.42]:49376 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751422Ab3FRMRe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 08:17:34 -0400
Received: by mail-pb0-f42.google.com with SMTP id un1so3854757pbc.1
        for <git@vger.kernel.org>; Tue, 18 Jun 2013 05:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=yA1RiYwz7uJggXsjOwlkGs0SNMbruO28M5vNx42DyPY=;
        b=NtAb7RgfPD4BPqDVw9GDvTshUoTxETRAg/Q5BBGe3rJh2808wr0/qsLlD+GeCvYT4G
         D5StEDbI9IFgYipKNxbM4/wvHzhvANTS/v/QouvR31qlsjtHJXFOqZDnLlFmz/KubqLX
         u+fTBQDEdewBmv2i5yJtrHgDM+5QlAb+gfQSTyUQiYwjLeBlvJMMeJn+o02J+7c0Finy
         4ReqUMWo0U6TBX0ZR6nBsq807568nOmABVWkNohXQLCHiMyVOwp9g755oi66Ixi8rgLw
         HPucFsGaveBe9W31pgzcbZb9IakOK4D3EPOiqvHMLp08SBzy4z/NZBvCOpjxqRd74IGE
         9aMQ==
X-Received: by 10.68.44.169 with SMTP id f9mr16726814pbm.29.1371557853928;
        Tue, 18 Jun 2013 05:17:33 -0700 (PDT)
Received: from localhost.localdomain ([122.164.213.38])
        by mx.google.com with ESMTPSA id fm2sm19398332pab.13.2013.06.18.05.17.29
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 18 Jun 2013 05:17:32 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.456.gb7f4cb6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228202>

This is a re-roll for rr/rebase-checkout-reflog, which is queued in
`pu`.

I've reviewed the changes carefully, and I believe that they are all
correct.  I've added a [6/8], because I think it is the correct way to
unset GIT_REFLOG_ACTION.

Junio: there is no need to re-export GIT_REFLOG_ACTION every time we
set it.  I've also fixed up some of your commit messages.  Let me know
if any further tweaks are necessary.

Thanks.

Junio C Hamano (1):
  t/status-help: test "HEAD detached from"

Ramkumar Ramachandra (7):
  wt-status: remove unused field in grab_1st_switch_cbdata
  t/checkout-last: test "checkout -" after a rebase
  status: do not depend on rebase reflog messages
  checkout: respect GIT_REFLOG_ACTION
  sh-setup: make die_with_status clear GIT_REFLOG_ACTION
  rebase: write better reflog messages
  rebase -i: write better reflog messages

 builtin/checkout.c         | 11 ++++++++---
 git-rebase--am.sh          |  2 ++
 git-rebase--interactive.sh |  3 +++
 git-rebase.sh              |  8 +++++++-
 git-sh-setup.sh            |  1 +
 t/t2012-checkout-last.sh   | 34 +++++++++++++++++++++++++++++++++
 t/t7512-status-help.sh     | 47 +++++++++++++++++++++++++---------------------
 wt-status.c                |  7 ++++---
 8 files changed, 85 insertions(+), 28 deletions(-)

-- 
1.8.3.1.456.gb7f4cb6
