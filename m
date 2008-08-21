From: Tor Arvid Lund <torarvid@gmail.com>
Subject: [PATCH] git-p4: Fix one-liner in p4_write_pipe function.
Date: Thu, 21 Aug 2008 23:11:40 +0200
Message-ID: <1219353100-1692-1-git-send-email-torarvid@gmail.com>
Cc: Tor Arvid Lund <torarvid@gmail.com>
To: git@vger.kernel.org, Simon Hausmann <simon@lst.de>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 21 23:19:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWHZB-0001al-Im
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 23:19:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751567AbYHUVSc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2008 17:18:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751276AbYHUVSc
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Aug 2008 17:18:32 -0400
Received: from 213-187-171-142.dd.nextgentel.com ([213.187.171.142]:20352 "EHLO
	webl.heads.no" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751236AbYHUVSc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2008 17:18:32 -0400
X-Greylist: delayed 409 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 Aug 2008 17:18:31 EDT
Received: by webl.heads.no (Postfix, from userid 1001)
	id 1C3EF318316; Thu, 21 Aug 2008 23:11:40 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.1.108.g660379
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93211>

The function built a p4 command string via the p4_build_cmd function, but
ignored the result.
---
 contrib/fast-import/git-p4 |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index f9865b4..46136d4 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -76,7 +76,7 @@ def write_pipe(c, str):
 
 def p4_write_pipe(c, str):
     real_cmd = p4_build_cmd(c)
-    return write_pipe(c, str)
+    return write_pipe(real_cmd, str)
 
 def read_pipe(c, ignore_error=False):
     if verbose:
-- 
1.6.0.GIT
