From: =?ISO-8859-1?Q?=22Peter_Valdemar_M=F8rch_=28Lists=29=22?= 
	<4ux6as402@sneakemail.com>
Subject: Re: [PATCH] Document disabling core.whitespace values trailing-space
 and space-before-tab
Date: Fri, 25 Jul 2008 08:13:17 +0200
Message-ID: <48896EFD.8010209@sneakemail.com>
References: <4888144E.8090300@sneakemail.com> <20080724172912.6117@nanako3.lavabit.com> <7vbq0m608w.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030502030307060800080502"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 25 08:14:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMGZH-00065C-LM
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 08:14:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751445AbYGYGNU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2008 02:13:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751408AbYGYGNU
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 02:13:20 -0400
Received: from morch.com ([193.58.255.207]:34144 "EHLO morch.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751275AbYGYGNT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 02:13:19 -0400
Received: from [192.168.1.214] (ANice-157-1-37-217.w90-28.abo.wanadoo.fr [90.28.176.217])
	by morch.com (Postfix) with ESMTP id EF426281D
	for <git@vger.kernel.org>; Fri, 25 Jul 2008 08:15:09 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.14 (X11/20080502)
In-Reply-To: <7vbq0m608w.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90005>

This is a multi-part message in MIME format.
--------------030502030307060800080502
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

> So I think Peter's patch is going in the right direction.

Thus encouraged, I've created a file with two more patches like I
described in my previous mail: one that fixes up .gitattributes and one
that fixes up t/* to conform to documented syntax of core.whitespace.

(For the future: Is it better to have one file with tree patches like I
have created with "git format-patch -M -s --stdout", 3 individual 
numbered files, or one single patch created with git-merge --squash?)

Peter
-- 
Peter Valdemar M�rch
http://www.morch.com

--------------030502030307060800080502
Content-Type: text/x-patch;
 name="core.whitespace.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="core.whitespace.patch"

>From 900455ce5a4e8bf771aea2e3dbdbab38e440cdf4 Mon Sep 17 00:00:00 2001
From: =?utf-8?q?Peter=20Valdemar=20M=C3=B8rch?= <peter@morch.com>
Date: Thu, 24 Jul 2008 07:18:48 +0200
Subject: [PATCH] Document disabling core.whitespace values trailing-space and space-before-tab
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit


Signed-off-by: Peter Valdemar Mørch <peter@morch.com>
---
 Documentation/config.txt |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index e784805..a198b3c 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -361,10 +361,12 @@ core.whitespace::
 	consider them as errors:
 +
 * `trailing-space` treats trailing whitespaces at the end of the line
-  as an error (enabled by default).
+  as an error (enabled by default - disable with 'git config core.whitespace
+  "-trailing-space"').
 * `space-before-tab` treats a space character that appears immediately
   before a tab character in the initial indent part of the line as an
-  error (enabled by default).
+  error (enabled by default - disable with 'git config core.whitespace
+  "-space-before-tab"').
 * `indent-with-non-tab` treats a line that is indented with 8 or more
   space characters as an error (not enabled by default).
 * `cr-at-eol` treats a carriage-return at the end of line as
-- 
1.5.6


>From c73dd588bef2a56fc44af2ce10cedef1b779a510 Mon Sep 17 00:00:00 2001
From: =?utf-8?q?Peter=20Valdemar=20M=C3=B8rch?= <peter@morch.com>
Date: Fri, 25 Jul 2008 07:33:07 +0200
Subject: [PATCH] Fixed up .gitattributes to allign with git-config.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit


Signed-off-by: Peter Valdemar Mørch <peter@morch.com>
---
 .gitattributes |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/.gitattributes b/.gitattributes
index 6b9c715..1a903b6 100644
--- a/.gitattributes
+++ b/.gitattributes
@@ -1,2 +1,2 @@
-* whitespace=!indent,trail,space
-*.[ch] whitespace
+* whitespace=-indent-with-non-tab,trailing-space,space-before-tab
+*.[ch] !whitespace
-- 
1.5.6


>From 45889568fec2b952e10aef2fac78ba6dfda9f46d Mon Sep 17 00:00:00 2001
From: =?utf-8?q?Peter=20Valdemar=20M=C3=B8rch?= <peter@morch.com>
Date: Fri, 25 Jul 2008 07:59:24 +0200
Subject: [PATCH] tests now use git-config's core.whitespace only with documented values
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit


Signed-off-by: Peter Valdemar Mørch <peter@morch.com>
---
 t/t4019-diff-wserror.sh  |   14 +++++++-------
 t/t4124-apply-ws-rule.sh |    4 ++--
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/t/t4019-diff-wserror.sh b/t/t4019-diff-wserror.sh
index 0d9cbb6..ecff30d 100755
--- a/t/t4019-diff-wserror.sh
+++ b/t/t4019-diff-wserror.sh
@@ -33,9 +33,9 @@ test_expect_success default '
 
 '
 
-test_expect_success 'without -trail' '
+test_expect_success 'without -trailing-space' '
 
-	git config core.whitespace -trail
+	git config core.whitespace -trailing-space
 	git diff --color >output
 	grep "$blue_grep" output >error
 	grep -v "$blue_grep" output >normal
@@ -48,10 +48,10 @@ test_expect_success 'without -trail' '
 
 '
 
-test_expect_success 'without -trail (attribute)' '
+test_expect_success 'without -trailing-space (attribute)' '
 
 	git config --unset core.whitespace
-	echo "F whitespace=-trail" >.gitattributes
+	echo "F whitespace=-trailing-space" >.gitattributes
 	git diff --color >output
 	grep "$blue_grep" output >error
 	grep -v "$blue_grep" output >normal
@@ -99,7 +99,7 @@ test_expect_success 'without -space (attribute)' '
 test_expect_success 'with indent-non-tab only' '
 
 	rm -f .gitattributes
-	git config core.whitespace indent,-trailing,-space
+	git config core.whitespace indent-with-non-tab,-trailing-space,-space-before-tab
 	git diff --color >output
 	grep "$blue_grep" output >error
 	grep -v "$blue_grep" output >normal
@@ -115,7 +115,7 @@ test_expect_success 'with indent-non-tab only' '
 test_expect_success 'with indent-non-tab only (attribute)' '
 
 	git config --unset core.whitespace
-	echo "F whitespace=indent,-trailing,-space" >.gitattributes
+	echo "F whitespace=indent-with-non-tab,-trailing-space,-space-before-tab" >.gitattributes
 	git diff --color >output
 	grep "$blue_grep" output >error
 	grep -v "$blue_grep" output >normal
@@ -147,7 +147,7 @@ test_expect_success 'with cr-at-eol' '
 test_expect_success 'with cr-at-eol (attribute)' '
 
 	git config --unset core.whitespace
-	echo "F whitespace=trailing,cr-at-eol" >.gitattributes
+	echo "F whitespace=trailing-space,cr-at-eol" >.gitattributes
 	git diff --color >output
 	grep "$blue_grep" output >error
 	grep -v "$blue_grep" output >normal
diff --git a/t/t4124-apply-ws-rule.sh b/t/t4124-apply-ws-rule.sh
index 85f3da2..644aadc 100755
--- a/t/t4124-apply-ws-rule.sh
+++ b/t/t4124-apply-ws-rule.sh
@@ -106,7 +106,7 @@ test_expect_success 'whitespace=error-all, default rule' '
 
 test_expect_success 'whitespace=error-all, no rule' '
 
-	git config core.whitespace -trailing,-space-before,-indent &&
+	git config core.whitespace -trailing-space,-space-before-tab,-indent-with-non-tab &&
 	apply_patch --whitespace=error-all &&
 	diff file target
 
@@ -130,7 +130,7 @@ do
 		for i in - ''
 		do
 			case "$i" in '') ti='#' ;; *) ti= ;; esac
-			rule=${t}trailing,${s}space,${i}indent
+			rule=${t}trailing-space,${s}space-before-tab,${i}indent-with-non-tab
 
 			rm -f .gitattributes
 			test_expect_success "rule=$rule" '
-- 
1.5.6


--------------030502030307060800080502--
