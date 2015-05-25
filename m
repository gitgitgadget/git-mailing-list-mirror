From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v3 23/56] cmd_show_branch(): fix error message
Date: Mon, 25 May 2015 18:38:49 +0000
Message-ID: <1432579162-411464-24-git-send-email-sandals@crustytoothpaste.net>
References: <1432579162-411464-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 25 20:40:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YwxIp-00013c-LJ
	for gcvg-git-2@plane.gmane.org; Mon, 25 May 2015 20:40:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751474AbbEYSk1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2015 14:40:27 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:50652 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751257AbbEYSkQ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 May 2015 14:40:16 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 3D92C2809A;
	Mon, 25 May 2015 18:40:15 +0000 (UTC)
X-Mailer: git-send-email 2.4.0
In-Reply-To: <1432579162-411464-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269858>

From: Michael Haggerty <mhagger@alum.mit.edu>

We need to convert the SHA-1 to hexadecimal before printing it.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/show-branch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index 826d9fa..323f857 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -846,7 +846,7 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 		commit = lookup_commit_reference(revkey.hash);
 		if (!commit)
 			die("cannot find commit %s (%s)",
-			    ref_name[num_rev], revkey.hash);
+			    ref_name[num_rev], oid_to_hex(&revkey));
 		parse_commit(commit);
 		mark_seen(commit, &seen);
 
-- 
2.4.0
