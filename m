From: Tony Luck <tony.luck@intel.com>
Subject: [PATCH] git: fix trivial warning from show_rename_copy()
Date: Tue, 12 Jul 2005 11:54:21 -0700
Message-ID: <200507121854.j6CIsLxd001509@agluck-lia64.sc.intel.com>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 12 21:02:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DsPzf-0005gw-Eu
	for gcvg-git@gmane.org; Tue, 12 Jul 2005 21:00:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262239AbVGLS7q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Jul 2005 14:59:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262186AbVGLS5k
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jul 2005 14:57:40 -0400
Received: from fmr21.intel.com ([143.183.121.13]:28570 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S262022AbVGLSzN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2005 14:55:13 -0400
Received: from scsfmr101.sc.intel.com (scsfmr101.sc.intel.com [10.3.253.10])
	by scsfmr001.sc.intel.com (8.12.10/8.12.10/d: major-outer.mc,v 1.1 2004/09/17 17:50:56 root Exp $) with ESMTP id j6CIsfMD023632;
	Tue, 12 Jul 2005 18:54:45 GMT
Received: from agluck-lia64.sc.intel.com (agluck-lia64.sc.intel.com [143.183.251.239])
	by scsfmr101.sc.intel.com (8.12.10/8.12.10/d: major-inner.mc,v 1.2 2004/09/17 18:05:01 root Exp $) with ESMTP id j6CIlV11031305;
	Tue, 12 Jul 2005 18:47:31 GMT
Received: from agluck-lia64.sc.intel.com (agluck-lia64.sc.intel.com [127.0.0.1])
	by agluck-lia64.sc.intel.com (8.13.1/8.13.1) with ESMTP id j6CIsa0d001510;
	Tue, 12 Jul 2005 11:54:41 -0700
Received: (from aegl@localhost)
	by agluck-lia64.sc.intel.com (8.13.1/8.13.1/Submit) id j6CIsLxd001509;
	Tue, 12 Jul 2005 11:54:21 -0700
To: torvalds@osdl.org
X-Scanned-By: MIMEDefang 2.44
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

apply.c: In function `show_rename_copy':
apply.c:1147: warning: field precision is not type int (arg 3)

Signed-off-by: Tony Luck <tony.luck@intel.com>

---

diff --git a/apply.c b/apply.c
--- a/apply.c
+++ b/apply.c
@@ -1143,7 +1143,7 @@ static void show_rename_copy(struct patc
 	 */
 	if (old != p->old_name)
 		printf(" %s %.*s{%s => %s} (%d%%)\n", renamecopy,
-		       old - p->old_name, p->old_name,
+		       (int)(old - p->old_name), p->old_name,
 		       old, new, p->score);
 	else
 		printf(" %s %s => %s (%d%%)\n", renamecopy,
