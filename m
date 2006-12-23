From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] git-svn: enable common fetch/commit options for dcommit
Date: Fri, 22 Dec 2006 21:59:24 -0800
Message-ID: <20061223055923.GA10460@localdomain>
References: <20061222122836.GD9595@hermes>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 23 06:59:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gxzv1-0000r2-Ht
	for gcvg-git@gmane.org; Sat, 23 Dec 2006 06:59:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752407AbWLWF70 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Dec 2006 00:59:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752412AbWLWF70
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Dec 2006 00:59:26 -0500
Received: from hand.yhbt.net ([66.150.188.102]:38589 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752401AbWLWF70 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Dec 2006 00:59:26 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 3C1C57DC02A;
	Fri, 22 Dec 2006 21:59:24 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Fri, 22 Dec 2006 21:59:24 -0800
To: Nicolas Vilz <niv@iaglans.de>
Content-Disposition: inline
In-Reply-To: <20061222122836.GD9595@hermes>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35271>

dcommit does commits and fetches, so all options used for those
should work, too, including --authors-file.

Reported missing by Nicolas Vilz.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 git-svn.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 07748bc..4288a05 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -111,7 +111,7 @@ my %cmd = (
 			{ 'merge|m|M' => \$_merge,
 			  'strategy|s=s' => \$_strategy,
 			  'dry-run|n' => \$_dry_run,
-			%cmt_opts } ],
+			%cmt_opts, %fc_opts } ],
 	'set-tree' => [ \&commit, "Set an SVN repository to a git tree-ish",
 			{	'stdin|' => \$_stdin, %cmt_opts, %fc_opts, } ],
 	'show-ignore' => [ \&show_ignore, "Show svn:ignore listings",
-- 
1.4.4.3.gc902c
