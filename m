From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH] checkout without arguments does not make sense
Date: Mon, 21 Jul 2008 22:06:32 +0200
Message-ID: <200807212206.32818.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 21 22:08:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KL1fV-0001Cn-Ln
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 22:07:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755517AbYGUUGh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2008 16:06:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751967AbYGUUGh
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jul 2008 16:06:37 -0400
Received: from smtp1.srv.eunet.at ([193.154.160.119]:42945 "EHLO
	smtp1.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755489AbYGUUGf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2008 16:06:35 -0400
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp1.srv.eunet.at (Postfix) with ESMTP id A5FCB33F11;
	Mon, 21 Jul 2008 22:06:33 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id E85B66AF9C;
	Mon, 21 Jul 2008 22:06:32 +0200 (CEST)
User-Agent: KMail/1.9.9
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89398>

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 builtin-checkout.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/builtin-checkout.c b/builtin-checkout.c
index fbd5105..669be0e 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -487,7 +487,8 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 		}
 
 		return checkout_paths(source_tree, pathspec);
-	}
+	} else if (!new.name && !opts.new_branch)
+		usage_with_options(checkout_usage, options);
 
 	if (new.name && !new.commit) {
 		die("Cannot switch branch to a non-commit.");
-- 
1.6.0.rc0.18.g6aef2
