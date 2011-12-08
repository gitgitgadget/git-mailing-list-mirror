From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v2 0/6] Fix '&&' chaining in tests
Date: Thu,  8 Dec 2011 18:40:09 +0530
Message-ID: <1323349817-15737-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 08 14:11:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYdkz-0004H3-5q
	for gcvg-git-2@lo.gmane.org; Thu, 08 Dec 2011 14:11:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752952Ab1LHNLU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Dec 2011 08:11:20 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:52142 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750811Ab1LHNLS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Dec 2011 08:11:18 -0500
Received: by iakc1 with SMTP id c1so2573483iak.19
        for <git@vger.kernel.org>; Thu, 08 Dec 2011 05:11:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=fvhhmoIWwehy/pORwyAEjfjFQ3AoyaKV0sEB2cBoJKo=;
        b=wld3XxtEv55PQUMedOL1qJN0uJ3/jVayQOuilnT74Bvg0KRL7w+5I/ICU3/3d1PkIL
         RLi67FvBiB4TopIGRs1m9TJgHU8o98/KPrDJTrXigtTvNc48XIucdOR9B5jeaqeInmbO
         x7hXZja8oUjvpSXrtWgnNnF8Y11I8rrTuYvcY=
Received: by 10.42.159.72 with SMTP id k8mr3458532icx.14.1323349877721;
        Thu, 08 Dec 2011 05:11:17 -0800 (PST)
Received: from localhost.localdomain ([203.110.240.205])
        by mx.google.com with ESMTPS id dd36sm19583344ibb.7.2011.12.08.05.11.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 08 Dec 2011 05:11:17 -0800 (PST)
X-Mailer: git-send-email 1.7.7.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186553>

Hi,

This follows-up $gmane/186481.  Thanks to Jonathan and Matthieu for
going through it.  Changes are:
1. Changes in response to Jonathan's review.
2. Squash similar patches and re-order.

Thanks.

-- Ram

Ramkumar Ramachandra (6):
  t3040 (subprojects-basic): modernize style
  t3030 (merge-recursive): use test_expect_code
  t1006 (cat-file): use test_cmp
  t3200 (branch): fix '&&' chaining
  t1510 (worktree): fix '&&' chaining
  test: fix '&&' chaining

 t/t1006-cat-file.sh                   |  119 +++++++++++++--------------
 t/t1007-hash-object.sh                |    2 +-
 t/t1013-loose-object-format.sh        |    2 +-
 t/t1300-repo-config.sh                |    2 +-
 t/t1412-reflog-loop.sh                |    2 +-
 t/t1501-worktree.sh                   |    6 +-
 t/t1510-repo-setup.sh                 |    4 +-
 t/t1511-rev-parse-caret.sh            |    2 +-
 t/t3030-merge-recursive.sh            |   72 ++---------------
 t/t3040-subprojects-basic.sh          |  144 ++++++++++++++++----------------
 t/t3200-branch.sh                     |    4 +-
 t/t3310-notes-merge-manual-resolve.sh |   10 +-
 t/t3400-rebase.sh                     |    4 +-
 t/t3418-rebase-continue.sh            |    4 +-
 t/t3419-rebase-patch-id.sh            |    2 +-
 15 files changed, 156 insertions(+), 223 deletions(-)

-- 
1.7.7.3
