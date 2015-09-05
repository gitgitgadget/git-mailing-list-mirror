From: John Keeping <john@keeping.me.uk>
Subject: [PATCH] interpret-trailers: allow running outside a repository
Date: Sat,  5 Sep 2015 14:39:24 +0100
Message-ID: <d8a4735a50d84010b81fd6a07a7c7403074fbb74.1441460208.git.john@keeping.me.uk>
Cc: Christian Couder <chriscool@tuxfamily.org>,
	John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 05 15:39:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZYDh1-0007kH-1h
	for gcvg-git-2@plane.gmane.org; Sat, 05 Sep 2015 15:39:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751514AbbIENjW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Sep 2015 09:39:22 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:49675 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750919AbbIENjV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Sep 2015 09:39:21 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id E77CDCDA567;
	Sat,  5 Sep 2015 14:39:20 +0100 (BST)
X-Quarantine-ID: <EW3clbvP29pk>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -0.199
X-Spam-Level: 
X-Spam-Status: No, score=-0.199 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_50=0.8, URIBL_BLOCKED=0.001] autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id EW3clbvP29pk; Sat,  5 Sep 2015 14:39:20 +0100 (BST)
Received: from river.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 103C5CDA510;
	Sat,  5 Sep 2015 14:39:12 +0100 (BST)
X-Mailer: git-send-email 2.5.0.466.g9af26fa
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277378>

It may be useful to run git-interpret-trailers without needing to be in
a repository.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 git.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git.c b/git.c
index 82d7a1c..2431cb0 100644
--- a/git.c
+++ b/git.c
@@ -417,7 +417,7 @@ static struct cmd_struct commands[] = {
 	{ "index-pack", cmd_index_pack, RUN_SETUP_GENTLY },
 	{ "init", cmd_init_db, NO_SETUP },
 	{ "init-db", cmd_init_db, NO_SETUP },
-	{ "interpret-trailers", cmd_interpret_trailers, RUN_SETUP },
+	{ "interpret-trailers", cmd_interpret_trailers, RUN_SETUP_GENTLY },
 	{ "log", cmd_log, RUN_SETUP },
 	{ "ls-files", cmd_ls_files, RUN_SETUP },
 	{ "ls-remote", cmd_ls_remote, RUN_SETUP_GENTLY },
-- 
2.5.0.466.g9af26fa
