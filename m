From: Nemina Amarasinghe <neminaa@gmail.com>
Subject: [PATCH] simplified the chain if() statements of  =?utf-8?b?aW5zdGFsbF9icmFuY2hfY29uZmlnKCk=?= function in branch.c
Date: Mon, 10 Mar 2014 07:39:38 +0000 (UTC)
Message-ID: <loom.20140310T083649-236@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 10 08:50:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WMuyX-00048t-G1
	for gcvg-git-2@plane.gmane.org; Mon, 10 Mar 2014 08:50:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752293AbaCJHuK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2014 03:50:10 -0400
Received: from plane.gmane.org ([80.91.229.3]:49905 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751873AbaCJHuJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2014 03:50:09 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1WMuyL-00040y-Hp
	for git@vger.kernel.org; Mon, 10 Mar 2014 08:50:07 +0100
Received: from 61.245.163.2 ([61.245.163.2])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 10 Mar 2014 08:50:05 +0100
Received: from neminaa by 61.245.163.2 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 10 Mar 2014 08:50:05 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 61.245.163.2 (Mozilla/5.0 (Windows NT 6.3; WOW64; rv:27.0) Gecko/20100101 Firefox/27.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243707>

Did some simple changing to the chain of if() statements in function
install_branch_config() of branch.c
This was a micro-project for GSOC 2014 


>From aebfa60feb643280c89b54e5ab87f9d960cde452 Mon Sep 17 00:00:00 2001
From: Nemina Amarasinghe <neminaa@gmail.com>
Date: Mon, 10 Mar 2014 13:02:55 +0530
Subject: [PATCH] simplified the chain if() statements of
 install_branch_config() function in branch.c

---
 branch.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/branch.c b/branch.c
index d3b9d49..0304a7a 100644
--- a/branch.c
+++ b/branch.c
@@ -87,7 +87,12 @@ void install_branch_config(int flag, const char *local,
const char *origin, cons
 				  _("Branch %s set up to track local branch %s by rebasing.") :
 				  _("Branch %s set up to track local branch %s."),
 				  local, shortname);
-		else if (!remote_is_branch && (origin || !origin))
+		else if (!remote_is_branch && origin)
+			printf_ln(rebasing ?
+				  _("Branch %s set up to track remote ref %s by rebasing.") :
+				  _("Branch %s set up to track remote ref %s."),
+				  local, remote);
+		else if (!remote_is_branch && !origin)
 			printf_ln(rebasing ?
 				  _("Branch %s set up to track remote ref %s by rebasing.") :
 				  _("Branch %s set up to track remote ref %s."),
-- 
1.9.0.152.g6ab4ae2
