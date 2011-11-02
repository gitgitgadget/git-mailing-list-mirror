From: Stefan Naewe <stefan.naewe@gmail.com>
Subject: [PATCH] t3200: add test case for 'branch -m'
Date: Wed,  2 Nov 2011 16:07:05 +0100
Message-ID: <1320246425-2141-1-git-send-email-stefan.naewe@gmail.com>
References: <4EB153B4.6070404@atlas-elektronik.com>
Cc: gitster@pobox.com, Stefan Naewe <stefan.naewe@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 02 16:17:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RLcZ9-0001W7-PZ
	for gcvg-git-2@lo.gmane.org; Wed, 02 Nov 2011 16:17:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932847Ab1KBPRM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Nov 2011 11:17:12 -0400
Received: from mail96.atlas.de ([194.156.172.86]:18470 "EHLO mail96.atlas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932778Ab1KBPRF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Nov 2011 11:17:05 -0400
X-Greylist: delayed 592 seconds by postgrey-1.27 at vger.kernel.org; Wed, 02 Nov 2011 11:17:05 EDT
Received: from localhost (localhost [127.0.0.1])
	by mail96.atlas.de (Postfix) with ESMTP id 8DDD810061;
	Wed,  2 Nov 2011 16:07:11 +0100 (CET)
X-Virus-Scanned: amavisd-new at lxsrv96.atlas.de
Received: from mail96.atlas.de ([127.0.0.1])
	by localhost (lxsrv96.atlas.de [127.0.0.1]) (amavisd-new, port 10124)
	with ESMTP id ytM1kBYqXx80; Wed,  2 Nov 2011 16:07:11 +0100 (CET)
Received: from mgsrv01.atlas.de (mailrelay-atlas.atlas.de [10.200.101.16])
	by mail96.atlas.de (Postfix) with ESMTP;
	Wed,  2 Nov 2011 16:07:10 +0100 (CET)
Received: from as100897.atlas.de (as100897.atlas.de [141.200.51.220])
	by mgsrv01.atlas.de (Postfix) with ESMTP id 53D712718B;
	Wed,  2 Nov 2011 16:07:10 +0100 (CET)
Received: by as100897.atlas.de (Postfix, from userid 1000)
	id 29CC414088; Wed,  2 Nov 2011 16:07:10 +0100 (CET)
X-Mailer: git-send-email 1.7.8.rc0.1.gb345ae
In-Reply-To: <4EB153B4.6070404@atlas-elektronik.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184637>

Signed-off-by: Stefan Naewe <stefan.naewe@gmail.com>
---
 t/t3200-branch.sh |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 2f5eada..3ce31b5 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -75,6 +75,11 @@ test_expect_success \
         git branch l'
 
 test_expect_success \
+    'git branch -m dumps usage' \
+       'test_expect_code 129 git branch -m 2>err &&
+        grep "[Uu]sage: git branch" err'
+
+test_expect_success \
     'git branch -m m m/m should work' \
        'git branch -l m &&
         git branch -m m m/m &&
-- 
1.7.8.rc0.1.gb345ae
