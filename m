From: David Rientjes <rientjes@google.com>
Subject: [PATCH 05/28] builtin-grep.c cleanup
Date: Mon, 14 Aug 2006 13:22:15 -0700 (PDT)
Message-ID: <Pine.LNX.4.63.0608141321250.19383@chino.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Mon Aug 14 22:22:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCix7-0006gE-09
	for gcvg-git@gmane.org; Mon, 14 Aug 2006 22:22:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932586AbWHNUWW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Aug 2006 16:22:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932713AbWHNUWW
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Aug 2006 16:22:22 -0400
Received: from smtp-out.google.com ([216.239.45.12]:50831 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S932586AbWHNUWV
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Aug 2006 16:22:21 -0400
Received: from zps76.corp.google.com (zps76.corp.google.com [172.25.146.76])
	by smtp-out.google.com with ESMTP id k7EKMHSG006003
	for <git@vger.kernel.org>; Mon, 14 Aug 2006 13:22:17 -0700
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:date:from:x-x-sender:to:subject:message-id:
	mime-version:content-type;
	b=Xbbi3duE6fRoWoJuPvmzPUByXyiFalFPIeFtXossZ/qM77xmu82lF+QNOLSnfhe49
	1NMLypzhURYY05QBTt0ZA==
Received: from localhost (chino.corp.google.com [172.24.88.221])
	by zps76.corp.google.com with ESMTP id k7EKMFqp029578
	for <git@vger.kernel.org>; Mon, 14 Aug 2006 13:22:15 -0700
Received: by localhost (Postfix, from userid 24081)
	id E60FC87D71; Mon, 14 Aug 2006 13:22:15 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by localhost (Postfix) with ESMTP id E362A87D70
	for <git@vger.kernel.org>; Mon, 14 Aug 2006 13:22:15 -0700 (PDT)
X-X-Sender: rientjes@chino.corp.google.com
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25385>

Removes conditional return.

		David

Signed-off-by: David Rientjes <rientjes@google.com>
---
 builtin-grep.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/builtin-grep.c b/builtin-grep.c
index a561612..3ec99b7 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -390,9 +390,7 @@ static int buffer_is_binary(const char *
 {
 	if (FIRST_FEW_BYTES < size)
 		size = FIRST_FEW_BYTES;
-	if (memchr(ptr, 0, size))
-		return 1;
-	return 0;
+	return !!memchr(ptr, 0, size);
 }
 
 static int fixmatch(const char *pattern, char *line, regmatch_t *match)
-- 
1.4.2.g89bb-dirty
