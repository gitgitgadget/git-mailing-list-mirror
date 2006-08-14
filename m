From: David Rientjes <rientjes@google.com>
Subject: [PATCH 08/28] remove conditional return
Date: Mon, 14 Aug 2006 13:25:34 -0700 (PDT)
Message-ID: <Pine.LNX.4.63.0608141324490.19383@chino.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Mon Aug 14 22:25:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCj0M-0007Le-PS
	for gcvg-git@gmane.org; Mon, 14 Aug 2006 22:25:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932720AbWHNUZn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Aug 2006 16:25:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932723AbWHNUZn
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Aug 2006 16:25:43 -0400
Received: from smtp-out.google.com ([216.239.45.12]:46225 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S932721AbWHNUZm
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Aug 2006 16:25:42 -0400
Received: from zps75.corp.google.com (zps75.corp.google.com [172.25.146.75])
	by smtp-out.google.com with ESMTP id k7EKPcFj019592
	for <git@vger.kernel.org>; Mon, 14 Aug 2006 13:25:38 -0700
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:date:from:x-x-sender:to:subject:message-id:
	mime-version:content-type;
	b=bwHqfIygjOKY93NoJ53tmfH7hxKnQNBmvQ7V5bDSgSXvc7xYnNnMd146fJEcqExlN
	fUOvVi6rQl7LO7I5q2ajA==
Received: from localhost (chino.corp.google.com [172.24.88.221])
	by zps75.corp.google.com with ESMTP id k7EKPYxk014355
	for <git@vger.kernel.org>; Mon, 14 Aug 2006 13:25:34 -0700
Received: by localhost (Postfix, from userid 24081)
	id BC62D87D71; Mon, 14 Aug 2006 13:25:34 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by localhost (Postfix) with ESMTP id BA85887D70
	for <git@vger.kernel.org>; Mon, 14 Aug 2006 13:25:34 -0700 (PDT)
X-X-Sender: rientjes@chino.corp.google.com
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25388>

Removes conditional return from builtin-pack-objects.c

		David

Signed-off-by: David Rientjes <rientjes@google.com>
---
 builtin-pack-objects.c |    7 +------
 1 files changed, 1 insertions(+), 6 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 2f99212..eb287a2 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -138,12 +138,7 @@ static int cmp_offset(const void *a_, co
 {
 	unsigned long a = *(unsigned long *) a_;
 	unsigned long b = *(unsigned long *) b_;
-	if (a < b)
-		return -1;
-	else if (a == b)
-		return 0;
-	else
-		return 1;
+	return (a < b) ? -1 : !(a == b);
 }
 
 /*
-- 
1.4.2.g89bb-dirty
