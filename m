From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 2/2] read-tree: at least one tree-ish argument is required
Date: Fri, 18 Dec 2009 10:51:01 +0100
Message-ID: <4B2B5085.1050906@viscovery.net>
References: <4B274BDE.8000504@viscovery.net> <4B274C3A.4060808@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 18 10:51:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NLZUX-000330-Iv
	for gcvg-git-2@lo.gmane.org; Fri, 18 Dec 2009 10:51:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752908AbZLRJvL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Dec 2009 04:51:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752743AbZLRJvK
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Dec 2009 04:51:10 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:61720 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752433AbZLRJvI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Dec 2009 04:51:08 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1NLZUE-0002J8-96; Fri, 18 Dec 2009 10:51:02 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id ED0431660F;
	Fri, 18 Dec 2009 10:51:01 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <4B274C3A.4060808@viscovery.net>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135407>

You have queued 1/2 (filter-branch: remove an unnecessary use of
'git read-tree') of this 2-patch series, but I haven't seen any comments
about this 2/2 nor is it queued. Did it fall through the cracks?

--- 8< ---
From: Johannes Sixt <j6t@kdbg.org>
Date: Tue, 15 Dec 2009 09:21:53 +0100
Subject: [PATCH] read-tree: at least one tree-ish argument is required

Previously, it was possible to run read-tree without any arguments,
whereupon it purged the index!

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 builtin-read-tree.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/builtin-read-tree.c b/builtin-read-tree.c
index 50413ca..31623b9 100644
--- a/builtin-read-tree.c
+++ b/builtin-read-tree.c
@@ -125,6 +125,9 @@ int cmd_read_tree(int argc, const char **argv,
 		stage = opts.merge = 1;
 	}

+	if (argc == 0)
+		usage_with_options(read_tree_usage, read_tree_options);
+
 	for (i = 0; i < argc; i++) {
 		const char *arg = argv[i];

-- 
1.6.6.rc3.54.g0f72d
