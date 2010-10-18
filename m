From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] {cvs,svn}import: use the new 'git read-tree --empty'
Date: Mon, 18 Oct 2010 15:11:25 +0200
Message-ID: <ed4d2a5ba3f219dbaba501e9ae3701d5e96322a1.1287407371.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 18 15:11:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P7pV0-0004vm-OR
	for gcvg-git-2@lo.gmane.org; Mon, 18 Oct 2010 15:11:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754899Ab0JRNL2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Oct 2010 09:11:28 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:24126 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754333Ab0JRNL1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Oct 2010 09:11:27 -0400
Received: from CAS20.d.ethz.ch (172.31.51.110) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.254.0; Mon, 18 Oct
 2010 15:11:27 +0200
Received: from localhost.localdomain (129.132.153.233) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.1.218.12; Mon, 18 Oct
 2010 15:11:25 +0200
X-Mailer: git-send-email 1.7.3.1.270.gbc760
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159257>

Since fb1bb96 (read-tree: deprecate syntax without tree-ish args,
2010-09-10) not passing --empty caused a spurious warning that was
shown to the user.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 contrib/examples/git-svnimport.perl |    2 +-
 git-cvsimport.perl                  |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/examples/git-svnimport.perl b/contrib/examples/git-svnimport.perl
index ead4c04..b09ff8f 100755
--- a/contrib/examples/git-svnimport.perl
+++ b/contrib/examples/git-svnimport.perl
@@ -289,7 +289,7 @@ my $current_rev = $opt_s || 1;
 unless(-d $git_dir) {
 	system("git init");
 	die "Cannot init the GIT db at $git_tree: $?\n" if $?;
-	system("git read-tree");
+	system("git read-tree --empty");
 	die "Cannot init an empty tree: $?\n" if $?;
 
 	$last_branch = $opt_o;
diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index 249aeaf..d27abfe 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -612,7 +612,7 @@ my %index; # holds filenames of one index per branch
 unless (-d $git_dir) {
 	system(qw(git init));
 	die "Cannot init the GIT db at $git_tree: $?\n" if $?;
-	system(qw(git read-tree));
+	system(qw(git read-tree --empty));
 	die "Cannot init an empty tree: $?\n" if $?;
 
 	$last_branch = $opt_o;
-- 
1.7.3.1.270.gbc760
