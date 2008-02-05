From: Tim Stoakes <tim@stoakes.net>
Subject: [PATCH] git-stash: alias 'list' to 'ls' and 'clear' to 'rm'
Date: Tue,  5 Feb 2008 21:08:19 +1030
Message-ID: <1202207899-28578-1-git-send-email-tim@stoakes.net>
Cc: gitster@pobox.com, Tim Stoakes <tim@stoakes.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 05 11:44:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMLIH-0001eC-Bw
	for gcvg-git-2@gmane.org; Tue, 05 Feb 2008 11:44:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756022AbYBEKoP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2008 05:44:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755671AbYBEKoO
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Feb 2008 05:44:14 -0500
Received: from hosted02.westnet.com.au ([203.10.1.213]:51162 "EHLO
	hosted02.westnet.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755888AbYBEKoN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2008 05:44:13 -0500
X-Greylist: delayed 348 seconds by postgrey-1.27 at vger.kernel.org; Tue, 05 Feb 2008 05:44:13 EST
Received: from hosted02.westnet.com.au (hosted02.westnet.com.au [127.0.0.1])
	by hosted02.westnet.com.au (Postfix) with SMTP id 2C7504A8C1;
	Tue,  5 Feb 2008 19:38:23 +0900 (WST)
Received: from mail.stoakes.net (dsl-202-173-137-105.sa.westnet.com.au [202.173.137.105])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hosted02.westnet.com.au (Postfix) with ESMTP id 7FE754969D;
	Tue,  5 Feb 2008 19:38:20 +0900 (WST)
Received: from noodle.stoakes.net (unknown [192.168.20.209])
	by mail.stoakes.net (Postfix) with ESMTP id 4EDED28C034;
	Tue,  5 Feb 2008 21:08:19 +1030 (CST)
Received: by noodle.stoakes.net (Postfix, from userid 1000)
	id 625107F1FF; Tue,  5 Feb 2008 21:08:19 +1030 (CST)
X-Mailer: git-send-email 1.5.4
X-PMX-Branch: TNG-Outgoing
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72643>

Signed-off-by: Tim Stoakes <tim@stoakes.net>
---
 Documentation/git-stash.txt |    2 ++
 git-stash.sh                |    4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index cd0dc1b..fc5866f 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -44,6 +44,7 @@ save [<message>]::
 	the description along with the stashed state.
 
 list::
+ls::
 
 	List the stashes that you currently have.  Each 'stash' is listed
 	with its name (e.g. `stash@\{0}` is the latest stash, `stash@\{1}` is
@@ -79,6 +80,7 @@ have conflicts (which are stored in the index, where you therefore can no
 longer apply the changes as they were originally).
 
 clear::
+rm::
 	Remove all the stashed states. Note that those states will then
 	be subject to pruning, and may be difficult or impossible to recover.
 
diff --git a/git-stash.sh b/git-stash.sh
index b00f888..8884950 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -198,7 +198,7 @@ apply_stash () {
 
 # Main command set
 case "$1" in
-list)
+list | ls)
 	shift
 	if test $# = 0
 	then
@@ -219,7 +219,7 @@ apply)
 	shift
 	apply_stash "$@"
 	;;
-clear)
+clear | rm)
 	shift
 	clear_stash "$@"
 	;;
-- 
1.5.4
