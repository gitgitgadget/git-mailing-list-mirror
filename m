From: Brian Downing <bdowning@lavos.net>
Subject: [PATCH] Mark 'git stash [message...]' as deprecated
Date: Tue,  6 Nov 2007 18:26:44 -0600
Message-ID: <1194395205-27905-1-git-send-email-bdowning@lavos.net>
References: <20071106085134.GD4435@artemis.corp>
Cc: tsuna@lrde.epita.fr, aghilesk@gmail.com, git@vger.kernel.org,
	Brian Downing <bdowning@lavos.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 07 02:35:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpZoy-00020H-6e
	for gcvg-git-2@gmane.org; Wed, 07 Nov 2007 02:35:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755257AbXKGBew (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2007 20:34:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754292AbXKGBev
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Nov 2007 20:34:51 -0500
Received: from mxsf09.insightbb.com ([74.128.0.79]:20418 "EHLO
	mxsf09.insightbb.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754178AbXKGBeu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2007 20:34:50 -0500
X-IronPort-AV: E=Sophos;i="4.21,381,1188792000"; 
   d="scan'208";a="125611266"
Received: from unknown (HELO asav02.insightbb.com) ([172.31.249.124])
  by mxsf09.insightbb.com with ESMTP; 06 Nov 2007 20:34:48 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Aq4HAE6lMEdKhvkY/2dsb2JhbACBWw
X-IronPort-AV: E=Sophos;i="4.21,381,1188792000"; 
   d="scan'208";a="155810217"
Received: from 74-134-249-24.dhcp.insightbb.com (HELO mail.lavos.net) ([74.134.249.24])
  by asav02.insightbb.com with ESMTP; 06 Nov 2007 20:34:49 -0500
Received: by mail.lavos.net (Postfix, from userid 1000)
	id 6823A309F21; Tue,  6 Nov 2007 19:34:48 -0600 (CST)
X-Original-To: bdowning@lavos.net
Received: from somat1.somat.local (mail.somat.com [63.252.84.66])
	by mail.lavos.net (Postfix) with ESMTP id 1E908309F20
	for <bdowning@lavos.net>; Tue,  6 Nov 2007 18:26:20 -0600 (CST)
Received: from silvara.lavos.net ([192.168.0.143]) by somat1.somat.local with Microsoft SMTPSVC(5.0.2195.6713);
	 Tue, 6 Nov 2007 18:26:19 -0600
Received: (nullmailer pid 27927 invoked by uid 1000);
	Wed, 07 Nov 2007 00:26:45 -0000
X-Mailer: git-send-email 1.5.3.5.1547.gf6d81-dirty
In-Reply-To: <20071106085134.GD4435@artemis.corp>
X-OriginalArrivalTime: 07 Nov 2007 00:26:19.0367 (UTC) FILETIME=[D11EC770:01C820D4]
X-DSPAM-Result: Whitelisted
X-DSPAM-Processed: Tue Nov  6 18:26:57 2007
X-DSPAM-Confidence: 0.9997
X-DSPAM-Probability: 0.0000
X-DSPAM-Signature: 1000,4731065061891804284693
X-DSPAM-Factors: 27,
	$+git, 0.00010,
	$+git, 0.00010,
	is+deprecated, 0.00010,
	git+pull, 0.00010,
	git+pull, 0.00010,
	147+7, 0.00010,
	txt+index, 0.00010,
	test+done, 0.00010,
	100755, 0.00010,
	100755, 0.00010,
	git+reset, 0.00010,
	git+reset, 0.00010,
	8+t, 0.00010,
	References*corp, 0.00010,
	To*Junio, 0.00010,
	*bdowning+silvara, 0.00010,
	sh+b, 0.00010,
	sh+b, 0.00010,
	7+146, 0.00010,
	8+39, 0.00010,
	Cc*com+git, 0.00010,
	'git, 0.00010,
	'git, 0.00010,
	7+deletions, 0.00010,
	Received*somat1.somat.local, 0.00010,
	Received*somat1.somat.local, 0.00010,
	Return-Path*bdowning+silvara, 0.00010
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63764>

Complain to STDERR unless 'git stash save' is explicitly used.
This is in preparation for completely disabling the "default save"
behavior of the command in the future.

Signed-off-by: Brian Downing <bdowning@lavos.net>
---
 Documentation/git-stash.txt |    9 ++++-----
 git-stash.sh                |    8 +++++++-
 t/t3903-stash.sh            |   14 +++++++++++++-
 3 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index c0147b9..61cf95d 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -9,7 +9,7 @@ SYNOPSIS
 --------
 [verse]
 'git-stash' (list | show [<stash>] | apply [<stash>] | clear)
-'git-stash' [save] [message...]
+'git-stash' save [message...]
 
 DESCRIPTION
 -----------
@@ -39,8 +39,7 @@ OPTIONS
 save::
 
 	Save your local modifications to a new 'stash', and run `git-reset
-	--hard` to revert them.  This is the default action when no
-	subcommand is given.
+	--hard` to revert them.
 
 list::
 
@@ -119,7 +118,7 @@ perform a pull, and then unstash, like this:
 $ git pull
 ...
 file foobar not up to date, cannot merge.
-$ git stash
+$ git stash save
 $ git pull
 $ git stash apply
 ----------------------------------------------------------------
@@ -147,7 +146,7 @@ You can use `git-stash` to simplify the above, like this:
 +
 ----------------------------------------------------------------
 ... hack hack hack ...
-$ git stash
+$ git stash save
 $ edit emergency fix
 $ git commit -a -m "Fix in a hurry"
 $ git stash apply
diff --git a/git-stash.sh b/git-stash.sh
index f39bd55..a8b854a 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -1,7 +1,7 @@
 #!/bin/sh
 # Copyright (c) 2007, Nanako Shiraishi
 
-USAGE='[ | list | show | apply | clear]'
+USAGE='[save | list | show | apply | clear]'
 
 SUBDIRECTORY_OK=Yes
 . git-sh-setup
@@ -223,6 +223,12 @@ help | usage)
 	if test $# -gt 0 && test "$1" = save
 	then
 		shift
+	else
+		cat >&2 <<EOF
+'git stash [message...]' is deprecated, please use
+'git stash save [message...]' instead.
+
+EOF
 	fi
 	save_stash "$*" && git-reset --hard
 	;;
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 9a9a250..adfac4b 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -16,7 +16,7 @@ test_expect_success 'stash some dirty working directory' '
 	git add file &&
 	echo 3 > file &&
 	test_tick &&
-	git stash &&
+	git stash save &&
 	git diff-files --quiet &&
 	git diff-index --cached --quiet HEAD
 '
@@ -73,4 +73,16 @@ test_expect_success 'unstashing in a subdirectory' '
 	git stash apply
 '
 
+test_expect_success 'stash with no args' '
+	echo 7 > file &&
+	test_tick &&
+	git stash
+'
+
+test_expect_success 'stash with bare message' '
+	echo 8 > file &&
+	test_tick &&
+	git stash "a message"
+'
+
 test_done
-- 
1.5.3.5.1547.gf6d81-dirty
