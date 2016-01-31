From: John Keeping <john@keeping.me.uk>
Subject: [PATCH] completion: verify-tag is not plumbing
Date: Sun, 31 Jan 2016 12:44:18 +0000
Message-ID: <60839686604d60632e1c80ef4fdd51eacb6b9290.1454244258.git.john@keeping.me.uk>
Cc: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 31 13:44:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aPrN8-0005VY-Dk
	for gcvg-git-2@plane.gmane.org; Sun, 31 Jan 2016 13:44:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757430AbcAaMou (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Jan 2016 07:44:50 -0500
Received: from jackal.aluminati.org ([72.9.247.210]:58319 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757401AbcAaMot (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jan 2016 07:44:49 -0500
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id C3B72CDA567;
	Sun, 31 Jan 2016 12:44:48 +0000 (GMT)
X-Quarantine-ID: <z28nww7o0Obv>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -0.199
X-Spam-Level: 
X-Spam-Status: No, score=-0.199 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_50=0.8, URIBL_BLOCKED=0.001] autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id z28nww7o0Obv; Sun, 31 Jan 2016 12:44:47 +0000 (GMT)
Received: from river.lan (banza.aluminati.org [10.0.7.182])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 56703CDA564;
	Sun, 31 Jan 2016 12:44:39 +0000 (GMT)
X-Mailer: git-send-email 2.7.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285146>

According to command-list.txt, verify-tag is an ancillary interrogator,
which means that it should be completed by "git verify-<TAB>" in the
same way as verify-commit.

Remove it from the list of plumbing commands so that it is treated as
porcelain and completed.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 contrib/completion/git-completion.bash | 1 -
 1 file changed, 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 51f5223..250788a 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -728,7 +728,6 @@ __git_list_porcelain_commands ()
 		write-tree)       : plumbing;;
 		var)              : infrequent;;
 		verify-pack)      : infrequent;;
-		verify-tag)       : plumbing;;
 		*) echo $i;;
 		esac
 	done
-- 
2.7.0
