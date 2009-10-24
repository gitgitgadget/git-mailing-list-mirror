From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: [PATCH] t7800-difftool: fix the effectless GIT_DIFFTOOL_PROMPT test
Date: Sun, 25 Oct 2009 01:39:19 +0200
Message-ID: <1256427559-28698-1-git-send-email-markus.heidelberg@web.de>
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
	Markus Heidelberg <markus.heidelberg@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 25 01:43:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N1qGK-0008QS-EK
	for gcvg-git-2@lo.gmane.org; Sun, 25 Oct 2009 01:43:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751970AbZJXXj4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Oct 2009 19:39:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751837AbZJXXj4
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Oct 2009 19:39:56 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:41619 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751823AbZJXXjz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Oct 2009 19:39:55 -0400
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate02.web.de (Postfix) with ESMTP id C7F0D1380E3BB;
	Sun, 25 Oct 2009 01:39:59 +0200 (CEST)
Received: from [89.59.119.245] (helo=localhost.localdomain)
	by smtp05.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #314)
	id 1N1qDH-0003fZ-00; Sun, 25 Oct 2009 01:39:59 +0200
X-Mailer: git-send-email 1.6.5.1.86.g7f7ff
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1+ev/UmqTG1urljOvSVzKWVaUHbPI5wNXcx6fRs
	yppj/5sbzlsSgf/QER/1odnfBOQsSO/ZJgzpDlMHKmlhoaTIk6
	qxxLzOUaAX69A4hxGxug==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131185>

GIT_DIFFTOOL_PROMPT doesn't have any effect if overridden with --prompt.

Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
---
 t/t7800-difftool.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index ebdccf9..fff6a6d 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -136,7 +136,7 @@ test_expect_success 'GIT_DIFFTOOL_PROMPT variable' '
 	GIT_DIFFTOOL_PROMPT=true &&
 	export GIT_DIFFTOOL_PROMPT &&
 
-	prompt=$(echo | git difftool --prompt branch | tail -1) &&
+	prompt=$(echo | git difftool branch | tail -1) &&
 	prompt_given "$prompt" &&
 
 	restore_test_defaults
-- 
1.6.5.1.86.g7f7ff
