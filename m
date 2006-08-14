From: David Rientjes <rientjes@google.com>
Subject: [PATCH 21/28] makes fsck_dir void
Date: Mon, 14 Aug 2006 13:36:18 -0700 (PDT)
Message-ID: <Pine.LNX.4.63.0608141335420.19383@chino.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Mon Aug 14 22:36:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCjAk-0001Ee-UL
	for gcvg-git@gmane.org; Mon, 14 Aug 2006 22:36:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964838AbWHNUg2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Aug 2006 16:36:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964839AbWHNUg2
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Aug 2006 16:36:28 -0400
Received: from smtp-out.google.com ([216.239.45.12]:48791 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S964838AbWHNUg1
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Aug 2006 16:36:27 -0400
Received: from zps38.corp.google.com (zps38.corp.google.com [172.25.146.38])
	by smtp-out.google.com with ESMTP id k7EKaL2t030335
	for <git@vger.kernel.org>; Mon, 14 Aug 2006 13:36:21 -0700
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:date:from:x-x-sender:to:subject:message-id:
	mime-version:content-type;
	b=GFh+zqnB/K7x2kaGm0MJr+/QImWx6pzMhYpCg9Ugmh8CnbdHxVNwFmC5WABc11hdN
	tFOFY+yx0RnOLulN7bHZQ==
Received: from localhost (chino.corp.google.com [172.24.88.221])
	by zps38.corp.google.com with ESMTP id k7EKaInh025545
	for <git@vger.kernel.org>; Mon, 14 Aug 2006 13:36:18 -0700
Received: by localhost (Postfix, from userid 24081)
	id 3E39187D71; Mon, 14 Aug 2006 13:36:18 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by localhost (Postfix) with ESMTP id 39AB987D70
	for <git@vger.kernel.org>; Mon, 14 Aug 2006 13:36:18 -0700 (PDT)
X-X-Sender: rientjes@chino.corp.google.com
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25402>

Makes fsck_dir void.

		David

Signed-off-by: David Rientjes <rientjes@google.com>
---
 fsck-objects.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/fsck-objects.c b/fsck-objects.c
index e167f41..4ba3377 100644
--- a/fsck-objects.c
+++ b/fsck-objects.c
@@ -366,13 +366,13 @@ static void add_sha1_list(unsigned char 
 	sha1_list.nr = ++nr;
 }
 
-static int fsck_dir(int i, char *path)
+static void fsck_dir(int i, char *path)
 {
 	DIR *dir = opendir(path);
 	struct dirent *de;
 
 	if (!dir)
-		return 0;
+		return;
 
 	while ((de = readdir(dir)) != NULL) {
 		char name[100];
@@ -398,7 +398,6 @@ static int fsck_dir(int i, char *path)
 		fprintf(stderr, "bad sha1 file: %s/%s\n", path, de->d_name);
 	}
 	closedir(dir);
-	return 0;
 }
 
 static int default_refs = 0;
-- 
1.4.2.g89bb-dirty
