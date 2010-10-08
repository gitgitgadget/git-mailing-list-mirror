From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [TopGit PATCH 06/10] tg-summary: accept -i/-w
Date: Fri,  8 Oct 2010 09:58:04 +0200
Message-ID: <66f0cf2d3c7d2778616fa51bd8d81eb04d0528f6.1286524446.git.bert.wesarg@googlemail.com>
References: <160b8b0eb6152da98f4fa633ac25c7a25ff32aa4.1286524446.git.bert.wesarg@googlemail.com>
 <0e1f993f68d36f0c3d848c2aa78f46c7130a24f1.1286524446.git.bert.wesarg@googlemail.com>
 <f8601225b41e5f03b50688c0582466879faaff26.1286524446.git.bert.wesarg@googlemail.com>
 <c013d1489409b5d6e76764aba07eca7107715691.1286524446.git.bert.wesarg@googlemail.com>
 <724f5482452ad11bd3fb8560bacb080fa1cef0a4.1286524446.git.bert.wesarg@googlemail.com>
Cc: git@vger.kernel.org, pasky@suse.cz,
	martin f krafft <madduck@madduck.net>,
	Bert Wesarg <bert.wesarg@googlemail.com>,
	Per Cederqvist <ceder@lysator.liu.se>
To: Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Fri Oct 08 09:58:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P47qq-00020q-5G
	for gcvg-git-2@lo.gmane.org; Fri, 08 Oct 2010 09:58:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755248Ab0JHH61 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Oct 2010 03:58:27 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:47865 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755221Ab0JHH6Z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Oct 2010 03:58:25 -0400
Received: by bwz15 with SMTP id 15so77566bwz.19
        for <git@vger.kernel.org>; Fri, 08 Oct 2010 00:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=O4VzryauK/YIU60mS9LSldZRnJbOAUjPzpSJkiHnQ7c=;
        b=WfBAa4Hc2dU4PaLc6WqI8YylUp7/apVgiUP/VEF/8jG/wzJqjHfcFQY4QlXOypLfCL
         AwtWNaD8PGwUEKRIkN/88t0HANT2xCieerh3gCmB1ZZWN30StR6F9CfZMMMPlKRrGyni
         rjzmzPcDf6Nh+Vbpow8MENRM0FFtKRYc1+dqM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=eFnxgaCDeUmMF7dTNNRiMLrr/fIffXYD1tNQ3FyFbtAOrfyKF7pEoDMQdw9e9XLx0r
         1IFG4kvMyigoZq+WzOM7YSRqv78IhdWtW389mkdgJBUjFC9+GL9lBuZmtdBqSJEQXZ2i
         KamTWLDAfsPV19wEUVJq4xppUyKllQMMeIFgI=
Received: by 10.204.53.207 with SMTP id n15mr1668069bkg.185.1286524704279;
        Fri, 08 Oct 2010 00:58:24 -0700 (PDT)
Received: from localhost (p5B0F732C.dip.t-dialin.net [91.15.115.44])
        by mx.google.com with ESMTPS id 11sm2392418bkj.11.2010.10.08.00.58.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 08 Oct 2010 00:58:23 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.1067.g5aeb7
In-Reply-To: <724f5482452ad11bd3fb8560bacb080fa1cef0a4.1286524446.git.bert.wesarg@googlemail.com>
In-Reply-To: <160b8b0eb6152da98f4fa633ac25c7a25ff32aa4.1286524446.git.bert.wesarg@googlemail.com>
References: <160b8b0eb6152da98f4fa633ac25c7a25ff32aa4.1286524446.git.bert.wesarg@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158487>

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
---
 README                     |    4 ++++
 contrib/tg-completion.bash |    4 ++++
 tg-summary.sh              |   21 +++++++++++++++------
 3 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/README b/README
index ce0c3a6..c96dc5a 100644 README
--- a/README
+++ b/README
@@ -362,6 +362,10 @@ tg summary
 	branches in a machine-readable format.  Feed this to "tsort"
 	to get the output from --sort.
 
+	Options:
+	  -i		Use TopGit meta data from the index instead of branch
+	  -w		Use TopGit meta data from the working tree instead of branch
+
 	TODO: Speed up by an order of magnitude
 	TODO: Text graph view
 
diff --git a/contrib/tg-completion.bash b/contrib/tg-completion.bash
index ccf1a32..6a1e182 100755 contrib/tg-completion.bash
--- a/contrib/tg-completion.bash
+++ b/contrib/tg-completion.bash
@@ -426,7 +426,11 @@ _tg_summary ()
 	*)
 		__tgcomp "
 			--graphviz
+			--sort
+			--deps
 			-t
+			-i
+			-w
 		"
 	esac
 }
diff --git a/tg-summary.sh b/tg-summary.sh
index af16888..113efc2 100644 tg-summary.sh
--- a/tg-summary.sh
+++ b/tg-summary.sh
@@ -7,13 +7,16 @@ terse=
 graphviz=
 sort=
 deps=
-
+head_from=
 
 ## Parse options
 
 while [ -n "$1" ]; do
 	arg="$1"; shift
 	case "$arg" in
+	-i|-w)
+		[ -z "$head_from" ] || die "-i and -w are mutually exclusive"
+		head_from="$arg";;
 	-t)
 		terse=1;;
 	--graphviz)
@@ -23,7 +26,7 @@ while [ -n "$1" ]; do
 	--deps)
 		deps=1;;
 	*)
-		echo "Usage: tg [...] summary [-t | --sort | --deps | --graphviz]" >&2
+		echo "Usage: tg [...] summary [-t | --sort | --deps | --graphviz] [-i | -w]" >&2
 		exit 1;;
 	esac
 done
@@ -69,8 +72,11 @@ process_branch()
 
 	current=' '
 	[ "$name" != "$curname" ] || current='>'
+	from=$head_from
+	[ "$name" = "$curname" ] ||
+		from=
 	nonempty=' '
-	! branch_empty "$name" || nonempty='0'
+	! branch_empty "$name" $from || nonempty='0'
 	remote=' '
 	[ -z "$base_remote" ] || remote='l'
 	! has_remote "$name" || remote='r'
@@ -89,7 +95,7 @@ process_branch()
 	branch_contains "$name" "refs/top-bases/$name" || base_update='B'
 
 	if [ "$(git rev-parse "$name")" != "$rev" ]; then
-		subject="$(git cat-file blob "$name:.topmsg" | sed -n 's/^Subject: //p')"
+		subject="$(cat_file "$name:.topmsg" $from | sed -n 's/^Subject: //p')"
 	else
 		# No commits yet
 		subject="(No commits)"
@@ -100,7 +106,7 @@ process_branch()
 }
 
 if [ -n "$deps" ]; then
-	list_deps
+	list_deps $head_from
 	exit 0
 fi
 
@@ -114,7 +120,10 @@ git for-each-ref refs/top-bases |
 		if [ -n "$terse" ]; then
 			echo "$name"
 		elif [ -n "$graphviz$sort" ]; then
-			git cat-file blob "$name:.topdeps" | while read dep; do
+			from=$head_from
+			[ "$name" = "$curname" ] ||
+				from=
+			cat_file "$name:.topdeps" $from | while read dep; do
 				dep_is_tgish=true
 				ref_exists "refs/top-bases/$dep"  ||
 					dep_is_tgish=false
-- 
1.7.1.1067.g5aeb7
