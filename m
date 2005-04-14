From: tony.luck@intel.com
Subject: [PATCH 1/1] git: remove redundant getenv() in init-db
Date: Thu, 14 Apr 2005 11:30:21 -0700
Message-ID: <200504141830.j3EIUL003768@unix-os.sc.intel.com>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 14 20:27:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DM93c-0006xA-HZ
	for gcvg-git@gmane.org; Thu, 14 Apr 2005 20:27:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261369AbVDNSaf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Apr 2005 14:30:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261392AbVDNSaf
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Apr 2005 14:30:35 -0400
Received: from fmr22.intel.com ([143.183.121.14]:65253 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S261369AbVDNSa2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2005 14:30:28 -0400
Received: from scsfmr101.sc.intel.com (scsfmr101.sc.intel.com [10.3.253.10])
	by scsfmr002.sc.intel.com (8.12.10/8.12.10/d: major-outer.mc,v 1.1 2004/09/17 17:50:56 root Exp $) with ESMTP id j3EIULxt028530;
	Thu, 14 Apr 2005 18:30:21 GMT
Received: from unix-os.sc.intel.com (unix-os.sc.intel.com [172.25.110.7])
	by scsfmr101.sc.intel.com (8.12.10/8.12.10/d: major-inner.mc,v 1.2 2004/09/17 18:05:01 root Exp $) with ESMTP id j3EIPnDW013902;
	Thu, 14 Apr 2005 18:25:49 GMT
Received: from localhost (localhost [[UNIX: localhost]])
	by unix-os.sc.intel.com (8.11.6/8.11.2) id j3EIUL003768;
	Thu, 14 Apr 2005 11:30:21 -0700
To: Linus Torvalds <torvalds@osdl.org>
X-Scanned-By: MIMEDefang 2.44
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

From: Tony Luck <tony.luck@intel.com>

init-db calls getenv(DB_ENVIRONMENT) twice.  Once should be enough.

Signed-off-by: Tony Luck <tony.luck@intel.com>

---

 init-db.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- init-db.c
+++ init-db.c	2005-04-14 11:01:52.000000000 -0700
@@ -7,7 +7,7 @@
 
 int main(int argc, char **argv)
 {
-	char *sha1_dir = getenv(DB_ENVIRONMENT), *path;
+	char *sha1_dir, *path;
 	int len, i;
 
 	if (mkdir(".git", 0755) < 0) {
