From: David Rientjes <rientjes@google.com>
Subject: [PATCH 25/28] makes pack_objects void
Date: Mon, 14 Aug 2006 13:38:50 -0700 (PDT)
Message-ID: <Pine.LNX.4.63.0608141338140.19383@chino.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Mon Aug 14 22:39:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCjD5-0001kQ-Rs
	for gcvg-git@gmane.org; Mon, 14 Aug 2006 22:38:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964865AbWHNUix (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Aug 2006 16:38:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964864AbWHNUix
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Aug 2006 16:38:53 -0400
Received: from smtp-out.google.com ([216.239.45.12]:7065 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S964865AbWHNUiw
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Aug 2006 16:38:52 -0400
Received: from zps38.corp.google.com (zps38.corp.google.com [172.25.146.38])
	by smtp-out.google.com with ESMTP id k7EKcpZP009683
	for <git@vger.kernel.org>; Mon, 14 Aug 2006 13:38:51 -0700
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:date:from:x-x-sender:to:subject:message-id:
	mime-version:content-type;
	b=TW+UbQXOU77D1+0ETLWpHvCOgfG1mYUAIgdaEim6AGVw9IuBMSZIAdSxc9dzB+Ljk
	WHs6ragLSx0/S8U3f4n/w==
Received: from localhost (chino.corp.google.com [172.24.88.221])
	by zps38.corp.google.com with ESMTP id k7EKcoWd003585
	for <git@vger.kernel.org>; Mon, 14 Aug 2006 13:38:50 -0700
Received: by localhost (Postfix, from userid 24081)
	id 15B4287D71; Mon, 14 Aug 2006 13:38:50 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by localhost (Postfix) with ESMTP id 12DD387D70
	for <git@vger.kernel.org>; Mon, 14 Aug 2006 13:38:50 -0700 (PDT)
X-X-Sender: rientjes@chino.corp.google.com
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25406>

Makes pack_objects void.

		David

Signed-off-by: David Rientjes <rientjes@google.com>
---
 send-pack.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/send-pack.c b/send-pack.c
index 10bc8bc..b7cc1a9 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -111,7 +111,7 @@ static void rev_list(int fd, struct ref 
 	exec_rev_list(refs);
 }
 
-static int pack_objects(int fd, struct ref *refs)
+static void pack_objects(int fd, struct ref *refs)
 {
 	pid_t rev_list_pid;
 
@@ -126,7 +126,6 @@ static int pack_objects(int fd, struct r
 	 * We don't wait for the rev-list pipeline in the parent:
 	 * we end up waiting for the other end instead
 	 */
-	return 0;
 }
 
 static void unmark_and_free(struct commit_list *list, unsigned int mark)
-- 
1.4.2.g89bb-dirty
