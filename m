From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 09/14] merge-recursive.c: Initialise variable to suppress
 msvc warning
Date: Sat, 04 Dec 2010 19:08:18 +0000
Message-ID: <4CFA91A2.9090409@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j6t@kdbg.org>,
	GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 04 22:16:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POzTN-00074i-HY
	for gcvg-git-2@lo.gmane.org; Sat, 04 Dec 2010 22:16:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756119Ab0LDVQo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Dec 2010 16:16:44 -0500
Received: from anchor-post-3.mail.demon.net ([195.173.77.134]:43461 "EHLO
	anchor-post-3.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755843Ab0LDVQo (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Dec 2010 16:16:44 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-3.mail.demon.net with esmtp (Exim 4.69)
	id 1POysx-0001tr-pI; Sat, 04 Dec 2010 20:39:12 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162919>


The msvc compiler thinks a variable could be used while
uninitialised and issues the following warning:

    ...\git\merge-recursive.c(1599) : warning C4700: uninitialized local \
        variable 'mrtree' used

In order to suppress the warning we simply initialise the mrtree
pointer variable to NULL.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 merge-recursive.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 16c2dbe..d5423ad 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1596,7 +1596,7 @@ int merge_recursive(struct merge_options *o,
 {
 	struct commit_list *iter;
 	struct commit *merged_common_ancestors;
-	struct tree *mrtree = mrtree;
+	struct tree *mrtree = NULL;
 	int clean;
 
 	if (show(o, 4)) {
-- 
1.7.3
