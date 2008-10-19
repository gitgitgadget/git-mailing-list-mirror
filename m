From: Matt McCutchen <matt@mattmccutchen.net>
Subject: [PATCH] git-merge-recursive: honor merge.conflictstyle once again
Date: Sat, 18 Oct 2008 20:40:50 -0400
Message-ID: <1224376850.19061.1.camel@mattlaptop2.local>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 19 02:42:06 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KrMMw-0004Bn-0E
	for gcvg-git-2@gmane.org; Sun, 19 Oct 2008 02:42:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752035AbYJSAky (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Oct 2008 20:40:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752024AbYJSAky
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Oct 2008 20:40:54 -0400
Received: from balanced.mail.policyd.dreamhost.com ([208.97.132.119]:37035
	"EHLO jankymail-a5.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751981AbYJSAkx (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Oct 2008 20:40:53 -0400
Received: from [129.2.207.232] (ml2.student.umd.edu [129.2.207.232])
	by jankymail-a5.g.dreamhost.com (Postfix) with ESMTP id 616D213EC8;
	Sat, 18 Oct 2008 17:40:52 -0700 (PDT)
X-Mailer: Evolution 2.22.3.1 (2.22.3.1-1.fc9) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98585>

This was originally implemented in c236bcd06138bcbc929b86ad1a513635bf4847b2
but was lost to a mismerge in 9ba929ed652f5ed7707f1c684999af4ad02c4925.

Signed-off-by: Matt McCutchen <matt@mattmccutchen.net>
---
 merge-recursive.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 245232a..7472d3e 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1332,7 +1332,7 @@ static int merge_recursive_config(const char *var, const char *value, void *cb)
 		o->merge_rename_limit = git_config_int(var, value);
 		return 0;
 	}
-	return git_default_config(var, value, cb);
+	return git_xmerge_config(var, value, cb);
 }
 
 void init_merge_options(struct merge_options *o)
-- 
1.6.0.2.545.g6cb4a
