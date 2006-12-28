From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 4/4] git-svn: sort multi-init output
Date: Thu, 28 Dec 2006 01:16:22 -0800
Message-ID: <11672973863687-git-send-email-normalperson@yhbt.net>
References: <11672973823960-git-send-email-normalperson@yhbt.net>
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Dec 28 10:16:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GzrNQ-0002oO-Gb
	for gcvg-git@gmane.org; Thu, 28 Dec 2006 10:16:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964977AbWL1JQ3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Dec 2006 04:16:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964969AbWL1JQ3
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Dec 2006 04:16:29 -0500
Received: from hand.yhbt.net ([66.150.188.102]:43038 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964977AbWL1JQ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Dec 2006 04:16:28 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id A82927DC099;
	Thu, 28 Dec 2006 01:16:26 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Thu, 28 Dec 2006 01:16:26 -0800
To: Junio C Hamano <junkio@cox.net>
X-Mailer: git-send-email 1.4.4.3.gd4ada
In-Reply-To: <11672973823960-git-send-email-normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35548>

This looks a bit more pleasant for users.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 git-svn.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 74a3424..b28c5bb 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -2481,7 +2481,7 @@ sub libsvn_ls_fullurl {
 	my $pool = SVN::Pool->new;
 	my $r = defined $_revision ? $_revision : $ra->get_latest_revnum;
 	my ($dirent, undef, undef) = $ra->get_dir('', $r, $pool);
-	foreach my $d (keys %$dirent) {
+	foreach my $d (sort keys %$dirent) {
 		if ($dirent->{$d}->kind == $SVN::Node::dir) {
 			push @ret, "$d/"; # add '/' for compat with cli svn
 		}
-- 
1.4.4.3.gd4ada
