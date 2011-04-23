From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 16/23] misc
Date: Sat, 23 Apr 2011 17:22:45 +1000
Message-ID: <1303543372-77843-17-git-send-email-jon.seymour@gmail.com>
References: <1303543372-77843-1-git-send-email-jon.seymour@gmail.com>
Cc: Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 23 09:24:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QDXCu-00054D-I0
	for gcvg-git-2@lo.gmane.org; Sat, 23 Apr 2011 09:24:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752619Ab1DWHYh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Apr 2011 03:24:37 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:44129 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751894Ab1DWHYe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Apr 2011 03:24:34 -0400
Received: by mail-pv0-f174.google.com with SMTP id 12so585772pvg.19
        for <git@vger.kernel.org>; Sat, 23 Apr 2011 00:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=XBLmLRFUuQR3w3xqIjtNItO4n+WwPHl7LXCGyg6PArU=;
        b=W3cIwa8qGphtRlKq7PFQjDE3+5aIHjdv1b35z18kVJWUyOyCex5bfuNyifrFXHmsY/
         KN6+bmdehWhdDapBAz3GYnji5BznI3IeQM1K057ERHhd0zg0rzXlE0IZu13pCnEAHdre
         TsmOeuFE90pwbkR4qB8+xbr48bmLWMMri4S+k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=wL1l70bDYNLw/vx5UMmcKZN0ktk+lyy/6Qz3P3IcuffhO4RV7fpR0GUNanE0qh9mHB
         T7rZ8BDeF9D4qtUERUKKNiASNrTaAw+DZ1bZPgYyH4aEMd6Wwb5BobD6pMLA86Hz3ClK
         wj0LkCBT2OoAPhMqj4ntfwzKq374x1Qh+jBac=
Received: by 10.68.23.41 with SMTP id j9mr2772991pbf.51.1303543474222;
        Sat, 23 Apr 2011 00:24:34 -0700 (PDT)
Received: from localhost.localdomain (124-169-133-110.dyn.iinet.net.au [124.169.133.110])
        by mx.google.com with ESMTPS id v8sm2498310pbk.95.2011.04.23.00.24.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 23 Apr 2011 00:24:33 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.rc1.23.g7f622
In-Reply-To: <1303543372-77843-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171969>

---
 t/t1520-test.sh |   26 ++++++++++++++++++++++++++
 1 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/t/t1520-test.sh b/t/t1520-test.sh
index 1d0776d..78f31fe 100755
--- a/t/t1520-test.sh
+++ b/t/t1520-test.sh
@@ -416,4 +416,30 @@ test_expect_success 'same' \
       --not-same C D 
 '
 
+test_expect_success 'clean' \
+'
+    git test \
+       --not-staged \
+       --not-unstaged \
+       --not-detached \
+       --not-untracked \
+       --not-rebasing \
+       --not-conflicted 
+'
+
+test_expect_success 'existence' \
+'
+    git test \
+       --commit-exists M \
+       --not-commit-exists N \
+       --ref-exists refs/tags/M \
+       --not-ref-exists refs/tags/N \
+       --branch-exists master \
+       --not-branch-exists N \
+       --tag-exists D \
+       --not-tag-exists N \
+       --not-tag-exists master \
+       --not-branch-exists A 
+ '
+
 test_done
-- 
1.7.5.rc1.23.g7f622
