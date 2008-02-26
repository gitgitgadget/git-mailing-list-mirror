From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH] Don't use GIT_CONFIG in t5505-remote
Date: Tue, 26 Feb 2008 17:15:31 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802261713520.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 26 23:16:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JU85s-0006BA-V0
	for gcvg-git-2@gmane.org; Tue, 26 Feb 2008 23:16:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753506AbYBZWPg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2008 17:15:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753490AbYBZWPg
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Feb 2008 17:15:36 -0500
Received: from iabervon.org ([66.92.72.58]:34529 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751130AbYBZWPg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2008 17:15:36 -0500
Received: (qmail 28658 invoked by uid 1000); 26 Feb 2008 22:15:31 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 26 Feb 2008 22:15:31 -0000
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75182>

For some reason, t5505-remote was setting GIT_CONFIG to .git/config
and exporting it. The sole effect of this was to cause the tests to
fail if "git clone" obeyed it (which it presumably should).

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
Maybe test-lib used to set GIT_CONFIG to something that would interfere? 
Or the default behavior was wrong?

 t/t5505-remote.sh |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 636aec2..4fc62f5 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -4,9 +4,6 @@ test_description='git remote porcelain-ish'
 
 . ./test-lib.sh
 
-GIT_CONFIG=.git/config
-export GIT_CONFIG
-
 setup_repository () {
 	mkdir "$1" && (
 	cd "$1" &&
-- 
1.5.4.3.328.gcaed
