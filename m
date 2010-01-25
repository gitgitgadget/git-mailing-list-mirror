From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH] git_connect: use use_shell instead of explicit "sh", "-c"
Date: Mon, 25 Jan 2010 13:32:44 +0100
Message-ID: <4B5D8F6C.1040407@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jan 25 13:32:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZO7g-0007gT-St
	for gcvg-git-2@lo.gmane.org; Mon, 25 Jan 2010 13:32:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752092Ab0AYMcs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jan 2010 07:32:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752021Ab0AYMcs
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jan 2010 07:32:48 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:13139 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751703Ab0AYMcr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jan 2010 07:32:47 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1NZO7Y-0007H4-SX; Mon, 25 Jan 2010 13:32:45 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 8CE991660F;
	Mon, 25 Jan 2010 13:32:44 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.9 (+)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Sixt <j6t@kdbg.org>

This is a followup to ac0ba18 (run-command: convert simple callsites to
use_shell, 2009-12-30), for consistency.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 Jeff,

 is there a reason that this was not part of the original patch?

 -- Hannes

 connect.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/connect.c b/connect.c
index db965c9..3a12562 100644
--- a/connect.c
+++ b/connect.c
@@ -613,8 +613,7 @@ struct child_process *git_connect(int fd[2], const
char *url_orig,
 			NULL
 		};
 		conn->env = env;
-		*arg++ = "sh";
-		*arg++ = "-c";
+		conn->use_shell = 1;
 	}
 	*arg++ = cmd.buf;
 	*arg = NULL;
-- 
1.7.0.rc0.39.g31c5d
