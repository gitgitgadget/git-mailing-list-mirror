From: David Rientjes <rientjes@google.com>
Subject: [PATCH 10/28] builtin-push.c cleanup
Date: Mon, 14 Aug 2006 13:26:58 -0700 (PDT)
Message-ID: <Pine.LNX.4.63.0608141326160.19383@chino.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Mon Aug 14 22:27:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCj1l-0007cL-7M
	for gcvg-git@gmane.org; Mon, 14 Aug 2006 22:27:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932721AbWHNU1K (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Aug 2006 16:27:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932722AbWHNU1K
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Aug 2006 16:27:10 -0400
Received: from smtp-out.google.com ([216.239.45.12]:26514 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S932721AbWHNU1I
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Aug 2006 16:27:08 -0400
Received: from zps75.corp.google.com (zps75.corp.google.com [172.25.146.75])
	by smtp-out.google.com with ESMTP id k7EKR2ki003393
	for <git@vger.kernel.org>; Mon, 14 Aug 2006 13:27:02 -0700
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:date:from:x-x-sender:to:subject:message-id:
	mime-version:content-type;
	b=ZVLtFTLVbhUy6UGEBsDJc1UE7ua3Cqy8McAm6iiwQizcMNUTdn7qMqswSKioeirMi
	6nTcnahwiwQGSW7AyoN7g==
Received: from localhost (chino.corp.google.com [172.24.88.221])
	by zps75.corp.google.com with ESMTP id k7EKQwHt020001
	for <git@vger.kernel.org>; Mon, 14 Aug 2006 13:26:58 -0700
Received: by localhost (Postfix, from userid 24081)
	id 3CCFC87D71; Mon, 14 Aug 2006 13:26:58 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by localhost (Postfix) with ESMTP id 39F9F87D70
	for <git@vger.kernel.org>; Mon, 14 Aug 2006 13:26:58 -0700 (PDT)
X-X-Sender: rientjes@chino.corp.google.com
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25390>

Removes conditional return in builtin-push.c

		David

Signed-off-by: David Rientjes <rientjes@google.com>
---
 builtin-push.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/builtin-push.c b/builtin-push.c
index 53bc378..c09ff2f 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -32,10 +32,8 @@ static int expand_one_ref(const char *re
 	/* Ignore the "refs/" at the beginning of the refname */
 	ref += 5;
 
-	if (strncmp(ref, "tags/", 5))
-		return 0;
-
-	add_refspec(strdup(ref));
+	if (!strncmp(ref, "tags/", 5))
+		add_refspec(strdup(ref));
 	return 0;
 }
 
-- 
1.4.2.g89bb-dirty
