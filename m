From: David Rientjes <rientjes@google.com>
Subject: [PATCH 22/28] http-push.c cleanup
Date: Mon, 14 Aug 2006 13:37:05 -0700 (PDT)
Message-ID: <Pine.LNX.4.63.0608141336200.19383@chino.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Mon Aug 14 22:37:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCjBX-0001PG-M5
	for gcvg-git@gmane.org; Mon, 14 Aug 2006 22:37:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964839AbWHNUhP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Aug 2006 16:37:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964845AbWHNUhP
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Aug 2006 16:37:15 -0400
Received: from smtp-out.google.com ([216.239.45.12]:14232 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S964839AbWHNUhN
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Aug 2006 16:37:13 -0400
Received: from zps37.corp.google.com (zps37.corp.google.com [172.25.146.37])
	by smtp-out.google.com with ESMTP id k7EKb9tx021166
	for <git@vger.kernel.org>; Mon, 14 Aug 2006 13:37:09 -0700
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:date:from:x-x-sender:to:subject:message-id:
	mime-version:content-type;
	b=ZUPvQqy2mOGLLyBoaajv0fVkb1j2A9GUikv/DIllD4SEC7uCZ1cWWFYQhIWtp979q
	yHD0kZe54ezpsClMFMNyw==
Received: from localhost (chino.corp.google.com [172.24.88.221])
	by zps37.corp.google.com with ESMTP id k7EKb5df024693
	for <git@vger.kernel.org>; Mon, 14 Aug 2006 13:37:05 -0700
Received: by localhost (Postfix, from userid 24081)
	id D253587D71; Mon, 14 Aug 2006 13:37:05 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by localhost (Postfix) with ESMTP id CF79287D70
	for <git@vger.kernel.org>; Mon, 14 Aug 2006 13:37:05 -0700 (PDT)
X-X-Sender: rientjes@chino.corp.google.com
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25403>

Removes conditional return.

		David

Signed-off-by: David Rientjes <rientjes@google.com>
---
 http-push.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/http-push.c b/http-push.c
index 0359ae5..511875f 100644
--- a/http-push.c
+++ b/http-push.c
@@ -2186,10 +2186,7 @@ static int verify_merge_base(unsigned ch
 	struct commit *branch = lookup_commit(branch_sha1);
 	struct commit_list *merge_bases = get_merge_bases(head, branch, 1);
 
-	if (merge_bases && !merge_bases->next && merge_bases->item == branch)
-		return 1;
-
-	return 0;
+	return (merge_bases && !merge_bases->next && merge_bases->item == branch)
 }
 
 static int delete_remote_branch(char *pattern, int force)
-- 
1.4.2.g89bb-dirty
