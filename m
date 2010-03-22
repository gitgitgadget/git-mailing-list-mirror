From: Kirill Smelkov <kirr@mns.spb.ru>
Subject: [PATCH 2/3] taskd/clone: quote shell metacharacters where appropriate
Date: Mon, 22 Mar 2010 14:08:00 +0300
Message-ID: <31fb9f4ece8be1e91aca8f05e78a8e3df986741d.1269255835.git.kirr@mns.spb.ru>
References: <20100222085029.GA28744@landau.phys.spbu.ru>
Cc: Miklos Vajna <vmiklos@frugalware.org>, Petr Baudis <pasky@ucw.cz>,
	git@vger.kernel.org, Kirill Smelkov <kirr@mns.spb.ru>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Mon Mar 22 12:13:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtfZP-000842-IB
	for gcvg-git-2@lo.gmane.org; Mon, 22 Mar 2010 12:13:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753953Ab0CVLNN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Mar 2010 07:13:13 -0400
Received: from mail.mnsspb.ru ([84.204.75.2]:39991 "EHLO mail.mnsspb.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753668Ab0CVLNM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Mar 2010 07:13:12 -0400
Received: from [192.168.0.127] (helo=tugrik.mns.mnsspb.ru)
	by mail.mnsspb.ru with esmtps id 1NtfZD-0000i5-VF; Mon, 22 Mar 2010 14:13:08 +0300
Received: from kirr by tugrik.mns.mnsspb.ru with local (Exim 4.69)
	(envelope-from <kirr@tugrik.mns.mnsspb.ru>)
	id 1NtfVC-0002uW-0t; Mon, 22 Mar 2010 14:08:58 +0300
X-Mailer: git-send-email 1.7.0.2.284.gafe27d
In-Reply-To: <20100222085029.GA28744@landau.phys.spbu.ru>
In-Reply-To: <cover.1269255835.git.kirr@mns.spb.ru>
References: <cover.1269255835.git.kirr@mns.spb.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142919>

At present this involves svn mirror setup -- refspec mappings contain
shell wildcards. Quote them just in case.
---
 taskd/clone.sh |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/taskd/clone.sh b/taskd/clone.sh
index 0f5d6fa..cfcb3b1 100755
--- a/taskd/clone.sh
+++ b/taskd/clone.sh
@@ -27,9 +27,9 @@ case "$url" in
 		GIT_DIR=. git svn fetch
 		# Neat Trick suggested by Miklos Vajna
 		GIT_DIR=. git config remote.origin.url .
-		GIT_DIR=. git config remote.origin.fetch +refs/remotes/heads/*:refs/heads/*
-		GIT_DIR=. git config --add remote.origin.fetch +refs/remotes/trunk:refs/heads/master
-		GIT_DIR=. git config --add remote.origin.fetch +refs/remotes/tags/*:refs/tags/*
+		GIT_DIR=. git config remote.origin.fetch '+refs/remotes/heads/*:refs/heads/*'
+		GIT_DIR=. git config --add remote.origin.fetch '+refs/remotes/trunk:refs/heads/master'
+		GIT_DIR=. git config --add remote.origin.fetch '+refs/remotes/tags/*:refs/tags/*'
 		GIT_DIR=. git fetch
 		;;
 	darcs://*)
-- 
1.7.0.2.284.gafe27d
