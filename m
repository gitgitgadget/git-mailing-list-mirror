From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [TopGit PATCH 06/11] tg-summary: accept -i/-w
Date: Sat,  9 Oct 2010 22:56:57 +0200
Message-ID: <62e3424559a93dc0f7c3ed55aafce738f2b0f6d3.1286657607.git.bert.wesarg@googlemail.com>
References: <e72a55b5f6ca2b805892fd6e214a4f72bf865124.1286657607.git.bert.wesarg@googlemail.com>
 <456834d2977615d5f5c41ca3947fb45cd82bfd87.1286657607.git.bert.wesarg@googlemail.com>
 <6e000c8cf21fac6cd4cf8608c8dc021b039e6f83.1286657607.git.bert.wesarg@googlemail.com>
 <ec70ec8e15013f663bba7f62885abe6881a1512a.1286657607.git.bert.wesarg@googlemail.com>
 <b765e0da80781182bf6c3af8f28d9496ed49cc1b.1286657607.git.bert.wesarg@googlemail.com>
Cc: git@vger.kernel.org, pasky@suse.cz,
	martin f krafft <madduck@madduck.net>,
	Bert Wesarg <bert.wesarg@googlemail.com>
To: Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Sat Oct 09 22:58:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4gUy-00005a-3Q
	for gcvg-git-2@lo.gmane.org; Sat, 09 Oct 2010 22:58:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760616Ab0JIU6Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Oct 2010 16:58:25 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:52677 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760545Ab0JIU6Y (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Oct 2010 16:58:24 -0400
Received: by mail-ew0-f46.google.com with SMTP id 20so129207ewy.19
        for <git@vger.kernel.org>; Sat, 09 Oct 2010 13:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=SgazpwSPCQ2s3/L5LUfroktn17KZ3onDxRRwendMSKw=;
        b=R96a3iJhB6GrrzUhDAT7w/bILiUO52T8icx6VZoxXABuc64oJnO5/3VPDuIApTjXM8
         Pw8v96ti9UPFwhvQuDNP1X3+YolMLp8jZ6UAqA7HexWAxHLTjVNughoj0gPhmuR1UZE1
         yqf7QSk76bSHkBFxMRrGpbt7CGfA+ZIOP9MOI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ZUhKXxpbvNlghKbPPkGLGVuQVve/UYSHf6cGcOPDi56Gkd+1ChPmmAXC74rlLhk4e1
         Dh1eVgLl3AbgIlzh0fRv7jyQgU7iwFOwRPVLcoTwbIYTa3fAk+tSFDqzpnBUqTStaLqs
         MAyEam1ChIji+/KlU2gd+ockbAfuh6w6GbOWo=
Received: by 10.213.39.196 with SMTP id h4mr2425403ebe.42.1286657903773;
        Sat, 09 Oct 2010 13:58:23 -0700 (PDT)
Received: from localhost ([46.115.90.142])
        by mx.google.com with ESMTPS id z55sm7834580eeh.3.2010.10.09.13.58.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 09 Oct 2010 13:58:22 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.1067.g5aeb7
In-Reply-To: <b765e0da80781182bf6c3af8f28d9496ed49cc1b.1286657607.git.bert.wesarg@googlemail.com>
In-Reply-To: <e72a55b5f6ca2b805892fd6e214a4f72bf865124.1286657607.git.bert.wesarg@googlemail.com>
References: <e72a55b5f6ca2b805892fd6e214a4f72bf865124.1286657607.git.bert.wesarg@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158616>

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
---
 README                     |    4 ++++
 contrib/tg-completion.bash |    4 ++++
 tg-summary.sh              |   21 +++++++++++++++------
 3 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/README b/README
index 5ca0424..eea0d72 100644 README
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
