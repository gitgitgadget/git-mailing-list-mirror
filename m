From: David Rientjes <rientjes@google.com>
Subject: [PATCH 01/28] blame.c return cleanup
Date: Mon, 14 Aug 2006 13:18:11 -0700 (PDT)
Message-ID: <Pine.LNX.4.63.0608141317170.19383@chino.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Mon Aug 14 22:18:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCitB-0005sx-V2
	for gcvg-git@gmane.org; Mon, 14 Aug 2006 22:18:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932700AbWHNUSS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Aug 2006 16:18:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932701AbWHNUSS
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Aug 2006 16:18:18 -0400
Received: from smtp-out.google.com ([216.239.45.12]:54669 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S932700AbWHNUSR
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Aug 2006 16:18:17 -0400
Received: from zps75.corp.google.com (zps75.corp.google.com [172.25.146.75])
	by smtp-out.google.com with ESMTP id k7EKICHU006811
	for <git@vger.kernel.org>; Mon, 14 Aug 2006 13:18:12 -0700
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:date:from:x-x-sender:to:subject:message-id:
	mime-version:content-type;
	b=lvIAHSZr+P3PWO6sxaG5yFxUO6Q/4d7U3FC/FSNMi8dwcS/IZzLtkq6mG+kwciQXC
	QpkgmpzRIej4cQ+aATxeQ==
Received: from localhost (chino.corp.google.com [172.24.88.221])
	by zps75.corp.google.com with ESMTP id k7EKIB2v015609
	for <git@vger.kernel.org>; Mon, 14 Aug 2006 13:18:12 -0700
Received: by localhost (Postfix, from userid 24081)
	id DE94F87D71; Mon, 14 Aug 2006 13:18:11 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by localhost (Postfix) with ESMTP id DC21487D70
	for <git@vger.kernel.org>; Mon, 14 Aug 2006 13:18:11 -0700 (PDT)
X-X-Sender: rientjes@chino.corp.google.com
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25381>

Removes conditional from return

		David

Signed-off-by: David Rientjes <rientjes@google.com>
---
 blame.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/blame.c b/blame.c
index 7099b53..54a43d5 100644
--- a/blame.c
+++ b/blame.c
@@ -351,10 +351,7 @@ static int fill_util_info(struct commit 
 	assert(util);
 	assert(util->pathname);
 
-	if (get_blob_sha1(commit->tree, util->pathname, util->sha1))
-		return 1;
-	else
-		return 0;
+	return !!get_blob_sha1(commit->tree, util->pathname, util->sha1);
 }
 
 static void alloc_line_map(struct commit *commit)
-- 
1.4.2.g89bb-dirty
