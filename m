From: Marc Weber <marco-oweber@gmx.de>
Subject: Re: [PATCH 1/2] add--interactive: rename [r]evert command to
	[r]eset
Date: Mon, 6 Oct 2008 17:51:41 +0200
Message-ID: <20081006155141.GA28582@gmx.de>
References: <20081005152654.GA13618@gmx.de> <20081005164124.GA31903@coredump.intra.peff.net> <20081005214644.GB32727@gmx.de> <20081005221150.GA22007@coredump.intra.peff.net> <b41e1729a8817f0d3cba2be1edc37513a72901dd.1223304141.git.marco-oweber@gmx.de> <20081006145509.GD8203@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 06 17:57:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KmsOG-0000et-Ed
	for gcvg-git-2@gmane.org; Mon, 06 Oct 2008 17:52:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752928AbYJFPvp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Oct 2008 11:51:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752845AbYJFPvp
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Oct 2008 11:51:45 -0400
Received: from mail.gmx.net ([213.165.64.20]:46474 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752664AbYJFPvp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Oct 2008 11:51:45 -0400
Received: (qmail invoked by alias); 06 Oct 2008 15:51:42 -0000
Received: from pD9E0B45E.dip.t-dialin.net (EHLO nixos) [217.224.180.94]
  by mail.gmx.net (mp053) with SMTP; 06 Oct 2008 17:51:42 +0200
X-Authenticated: #9006135
X-Provags-ID: V01U2FsdGVkX1+rXYAGxT2rnaXF0xAuKvNuH1PMm+tqerpMKREe9y
	Y0Tk5aNgXg+cqD
Received: by nixos (sSMTP sendmail emulation); Mon, 06 Oct 2008 17:51:41 +0200
Mail-Followup-To: Marc Weber <marco-oweber@gmx.de>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20081006145509.GD8203@spearce.org>
User-Agent: Mutt/1.5.15 (2007-04-06)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97596>

> This patch is mangled.  The context line immediately above is
Sorry, I thought set paste sets noexpandtab as well, I was wrong.


============= patch starting at commit message =======================
The term "revert" is used very confusingly here. In git, to "revert"
is to take the changes made by a previous commit and un-apply them,
creating a new commit. The act of changing what is in the index to
match HEAD is called "reset".

Furthermore, incoming svn users will also find this confusing, since
to them, "revert" means to reset the working tree, which corresponds
to "checkout" in git.

Signed-off-by: Marc Weber <marco-oweber@gmx.de>
commit message rewritten by: Jeff King <peff@peff.net>
---
 git-add--interactive.perl |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index da768ee..5352d16 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -498,8 +498,8 @@ sub update_cmd {
 	print "\n";
 }
 
-sub revert_cmd {
-	my @update = list_and_choose({ PROMPT => 'Revert',
+sub reset_cmd {
+	my @update = list_and_choose({ PROMPT => 'Reset',
 				       HEADER => $status_head, },
 				     list_modified());
 	if (@update) {
@@ -527,7 +527,7 @@ sub revert_cmd {
 			}
 		}
 		refresh();
-		say_n_paths('reverted', @update);
+		say_n_paths('reset', @update);
 	}
 	print "\n";
 }
@@ -1046,7 +1046,7 @@ sub help_cmd {
 	print colored $help_color, <<\EOF ;
 status        - show paths with changes
 update        - add working tree state to the staged set of changes
-revert        - revert staged set of changes back to the HEAD version
+reset         - reset staged set of changes back to the HEAD version
 patch         - pick hunks and update selectively
 diff	      - view diff between HEAD and index
 add untracked - add contents of untracked files to the staged set of changes
@@ -1070,7 +1070,7 @@ sub process_args {
 sub main_loop {
 	my @cmd = ([ 'status', \&status_cmd, ],
 		   [ 'update', \&update_cmd, ],
-		   [ 'revert', \&revert_cmd, ],
+		   [ 'reset', \&reset_cmd, ],
 		   [ 'add untracked', \&add_untracked_cmd, ],
 		   [ 'patch', \&patch_update_cmd, ],
 		   [ 'diff', \&diff_cmd, ],
-- 
1.6.0.2.GIT
