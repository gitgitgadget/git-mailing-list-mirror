From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 1/6] clone: Make the 'junk_mode' symbol a file static
Date: Sat, 27 Apr 2013 19:39:04 +0100
Message-ID: <517C1B48.5090206@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 27 21:46:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWB4h-0007xM-Aw
	for gcvg-git-2@plane.gmane.org; Sat, 27 Apr 2013 21:46:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756144Ab3D0TqT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Apr 2013 15:46:19 -0400
Received: from mdfmta009.mxout.tbr.inty.net ([91.221.168.50]:33011 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754713Ab3D0TqS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Apr 2013 15:46:18 -0400
Received: from mdfmta009.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP id 0A1A2384081;
	Sat, 27 Apr 2013 20:46:18 +0100 (BST)
Received: from mdfmta009.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP id 7D48B38407C;
	Sat, 27 Apr 2013 20:46:17 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP;
	Sat, 27 Apr 2013 20:46:16 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
X-MDF-HostID: 4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222663>


Sparse issues an "'junk_mode' not declared. Should it be static?"
warning. In order to suppress the warning, since this symbol does
not need more than file visibility, we simply add the static
modifier to it's declaration.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 builtin/clone.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 58fee98..035ab64 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -387,7 +387,7 @@ static void clone_local(const char *src_repo, const char *dest_repo)
 static const char *junk_work_tree;
 static const char *junk_git_dir;
 static pid_t junk_pid;
-enum {
+static enum {
 	JUNK_LEAVE_NONE,
 	JUNK_LEAVE_REPO,
 	JUNK_LEAVE_ALL
-- 
1.8.2
