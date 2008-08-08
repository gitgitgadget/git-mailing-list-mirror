From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 3/3] git-svn: wrap long lines in a few places
Date: Fri,  8 Aug 2008 01:41:58 -0700
Message-ID: <1218184918-9135-3-git-send-email-normalperson@yhbt.net>
References: <20080808084025.GA8718@untitled>
Cc: git@vger.kernel.org, Marcus Griep <marcus@griep.us>,
	Eric Wong <normalperson@yhbt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 08 10:43:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRNZC-0001Rm-7W
	for gcvg-git-2@gmane.org; Fri, 08 Aug 2008 10:43:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754152AbYHHImE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2008 04:42:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754166AbYHHImE
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Aug 2008 04:42:04 -0400
Received: from hand.yhbt.net ([66.150.188.102]:56522 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754214AbYHHImB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2008 04:42:01 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id AB18B2DC08B;
	Fri,  8 Aug 2008 01:41:59 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.rc2.4.g0643f
In-Reply-To: <20080808084025.GA8718@untitled>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91637>

Oops, I let a few patches slip by with long lines in them.
Extracted from an unrelated patch by: Marcus Griep <marcus@griep.us>

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 git-svn.perl |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 47ad378..d7a884d 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -171,7 +171,8 @@ my %cmd = (
 			  'color' => \$Git::SVN::Log::color,
 			  'pager=s' => \$Git::SVN::Log::pager
 			} ],
-	'find-rev' => [ \&cmd_find_rev, "Translate between SVN revision numbers and tree-ish",
+	'find-rev' => [ \&cmd_find_rev,
+	                "Translate between SVN revision numbers and tree-ish",
 			{} ],
 	'rebase' => [ \&cmd_rebase, "Fetch and rebase your working directory",
 			{ 'merge|m|M' => \$_merge,
@@ -231,7 +232,9 @@ unless ($cmd && $cmd =~ /(?:clone|init|multi-init)$/) {
 my %opts = %{$cmd{$cmd}->[2]} if (defined $cmd);
 
 read_repo_config(\%opts);
-Getopt::Long::Configure('pass_through') if ($cmd && ($cmd eq 'log' || $cmd eq 'blame'));
+if ($cmd && ($cmd eq 'log' || $cmd eq 'blame')) {
+	Getopt::Long::Configure('pass_through');
+}
 my $rv = GetOptions(%opts, 'help|H|h' => \$_help, 'version|V' => \$_version,
                     'minimize-connections' => \$Git::SVN::Migration::_minimize,
                     'id|i=s' => \$Git::SVN::default_ref_id,
-- 
1.6.0.rc2.4.g0643f
