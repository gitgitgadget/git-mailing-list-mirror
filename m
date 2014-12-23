From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v2 2/2] Add a regression test for 'git remote add <existing>
 <same-url>'
Date: Tue, 23 Dec 2014 14:25:09 +0100 (CET)
Message-ID: <c1fcf95b1329df7c9b88b41adaa3010e5c3c3729.1419340898.git.johannes.schindelin@gmx.de>
References: <20141216021900.50095.24877@random.io> <cover.1419340898.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: anapsix@random.io, git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Dec 23 14:25:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3PSs-0002GU-IO
	for gcvg-git-2@plane.gmane.org; Tue, 23 Dec 2014 14:25:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755826AbaLWNZT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Dec 2014 08:25:19 -0500
Received: from mout.gmx.net ([212.227.17.21]:50787 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755829AbaLWNZS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Dec 2014 08:25:18 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx102) with ESMTPSA (Nemesis) id 0MJWAZ-1Y1TeW1xLH-0039sO;
 Tue, 23 Dec 2014 14:25:11 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <cover.1419340898.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:9ayHYdJi6WYjPKa/Awz135tx8QUQcRlyDf7Tav92sl7YRuKHGey
 yBk8QVQYFINHESjErN6N4pqv2NUOw91OwCPcZmua0MkLqILbUbmv71KNjA5v0UKiC/Io963
 AB/zyVLAv3W005j47EhfYk9w8TlAdxLLh3MxADV5aThIK8Fm9hgwAvSrMjXZThoZXBTQlht
 AWgNUDCEY2AEKINaNkooQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261732>

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t5505-remote.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index ac79dd9..17c6330 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -1113,4 +1113,9 @@ test_extra_arg set-url origin newurl oldurl
 # prune takes any number of args
 # update takes any number of args
 
+test_expect_success 'add remote matching the "insteadOf" URL' '
+	git config url.xyz@example.com.insteadOf backup &&
+	git remote add backup xyz@example.com
+'
+
 test_done
-- 
2.0.0.rc3.9669.g840d1f9
