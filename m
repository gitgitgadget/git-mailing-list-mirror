From: Mike Hommey <mh@glandium.org>
Subject: [PATCH] Don't use cpio in git-clone when not installed
Date: Wed, 31 Oct 2007 21:05:45 +0100
Message-ID: <1193861145-20357-1-git-send-email-mh@glandium.org>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 31 21:06:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InJq5-0001Ev-PO
	for gcvg-git-2@gmane.org; Wed, 31 Oct 2007 21:06:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752293AbXJaUGo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2007 16:06:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752716AbXJaUGo
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Oct 2007 16:06:44 -0400
Received: from vawad.err.no ([85.19.200.177]:35170 "EHLO vawad.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752236AbXJaUGo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2007 16:06:44 -0400
Received: from aputeaux-153-1-44-162.w82-124.abo.wanadoo.fr ([82.124.8.162] helo=namakemono.glandium.org)
	by vawad.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.62)
	(envelope-from <mh@glandium.org>)
	id 1InJpg-0002Lm-KF; Wed, 31 Oct 2007 21:06:36 +0100
Received: from mh by namakemono.glandium.org with local (Exim 4.68)
	(envelope-from <mh@glandium.org>)
	id 1InJov-0005Ib-TM; Wed, 31 Oct 2007 21:05:45 +0100
X-Mailer: git-send-email 1.5.3.4
In-Reply-To: 18216.31314.990545.518458@lisa.zopyra.com
References: 18216.31314.990545.518458@lisa.zopyra.com
X-Spam-Status: (score 2.0): Status=No hits=2.0 required=5.0 tests=RCVD_IN_SORBS_DUL version=3.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62859>


Signed-off-by: Mike Hommey <mh@glandium.org>
---
 git-clone.sh |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/git-clone.sh b/git-clone.sh
index 0ea3c24..57e96ae 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -191,7 +191,9 @@ fi
 # it is local
 if base=$(get_repo_base "$repo"); then
 	repo="$base"
-	local=yes
+	if type cpio > /dev/null 2>&1; then
+		local=yes
+	fi
 fi
 
 dir="$2"
-- 
1.5.3.4
