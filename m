From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 1/5] Remove unused diffcore_std_no_resolve
Date: Wed, 14 Mar 2007 14:26:48 -0700
Message-ID: <7vtzwn7bzb.fsf@assigned-by-dhcp.cox.net>
References: <7vwt1j8z0e.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 14 22:27:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRazl-0002Og-BX
	for gcvg-git@gmane.org; Wed, 14 Mar 2007 22:26:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751065AbXCNV0u (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Mar 2007 17:26:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751262AbXCNV0u
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Mar 2007 17:26:50 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:34757 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751065AbXCNV0t (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2007 17:26:49 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070314212648.VMAH28911.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Wed, 14 Mar 2007 17:26:48 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id alSp1W0071kojtg0000000; Wed, 14 Mar 2007 17:26:49 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42232>

This was only used by diff-tree-helper program, whose purpose
was to translate a raw diff to a patch.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 * These are re-spin of the earlier 2 patch series, go directly
   on top of Alex's --exit-code.

 diff.c |   11 -----------
 diff.h |    2 --
 2 files changed, 0 insertions(+), 13 deletions(-)

diff --git a/diff.c b/diff.c
index cc81801..7d938c1 100644
--- a/diff.c
+++ b/diff.c
@@ -2917,17 +2917,6 @@ void diffcore_std(struct diff_options *options)
 }
 
 
-void diffcore_std_no_resolve(struct diff_options *options)
-{
-	if (options->pickaxe)
-		diffcore_pickaxe(options->pickaxe, options->pickaxe_opts);
-	if (options->orderfile)
-		diffcore_order(options->orderfile);
-	diffcore_apply_filter(options->filter);
-	if (options->exit_with_status)
-		options->has_changes = !!diff_queued_diff.nr;
-}
-
 void diff_addremove(struct diff_options *options,
 		    int addremove, unsigned mode,
 		    const unsigned char *sha1,
diff --git a/diff.h b/diff.h
index d13fc89..81fa265 100644
--- a/diff.h
+++ b/diff.h
@@ -173,8 +173,6 @@ extern int diff_setup_done(struct diff_options *);
 
 extern void diffcore_std(struct diff_options *);
 
-extern void diffcore_std_no_resolve(struct diff_options *);
-
 #define COMMON_DIFF_OPTIONS_HELP \
 "\ncommon diff options:\n" \
 "  -z            output diff-raw with lines terminated with NUL.\n" \
-- 
1.5.0.3.1036.g6baf1
