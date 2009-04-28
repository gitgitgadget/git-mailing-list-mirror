From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: [PATCH] allow -t abbreviation for --track in git branch
Date: Tue, 28 Apr 2009 20:51:20 +0530
Message-ID: <20090428152119.GA18935@atc.tcs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 28 17:24:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LypAb-0008Tf-Vt
	for gcvg-git-2@gmane.org; Tue, 28 Apr 2009 17:24:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761773AbZD1PWR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Apr 2009 11:22:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932398AbZD1PWP
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Apr 2009 11:22:15 -0400
Received: from atcmail.atc.tcs.co.in ([203.200.212.145]:58219 "EHLO
	atcmail.atc.tcs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762013AbZD1PWO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Apr 2009 11:22:14 -0400
Received: from atcmail.atc.tcs.com (atcmail.atc.tcs.com [127.0.0.1])
	by atcmail.atc.tcs.com (8.14.2/8.14.2) with ESMTP id n3SFLLT7019009;
	Tue, 28 Apr 2009 20:51:21 +0530
Received: (from sitaram@localhost)
	by atcmail.atc.tcs.com (8.14.2/8.14.2/Submit) id n3SFLKru019005;
	Tue, 28 Apr 2009 20:51:20 +0530
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Virus-Scanned: ClamAV 0.94.2/9297/Tue Apr 28 02:00:26 2009 on atcmail.atc.tcs.com
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.5
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on atcmail.atc.tcs.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117790>

also makes it consistent with git-checkout

---
 Documentation/git-branch.txt |    1 +
 builtin-branch.c             |    2 +-
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index cbd4275..ae201de 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -111,6 +111,7 @@ OPTIONS
 --no-abbrev::
 	Display the full sha1s in the output listing rather than abbreviating them.
 
+-t::
 --track::
 	When creating a new branch, set up configuration to mark the
 	start-point branch as "upstream" from the new branch. This
diff --git a/builtin-branch.c b/builtin-branch.c
index 91098ca..6aaa708 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -547,7 +547,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	struct option options[] = {
 		OPT_GROUP("Generic options"),
 		OPT__VERBOSE(&verbose),
-		OPT_SET_INT( 0 , "track",  &track, "set up tracking mode (see git-pull(1))",
+		OPT_SET_INT('t', "track",  &track, "set up tracking mode (see git-pull(1))",
 			BRANCH_TRACK_EXPLICIT),
 		OPT_BOOLEAN( 0 , "color",  &branch_use_color, "use colored output"),
 		OPT_SET_INT('r', NULL,     &kinds, "act on remote-tracking branches",
-- 
1.6.2.4
