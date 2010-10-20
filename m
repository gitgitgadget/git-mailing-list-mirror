From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [TopGit PATCH v3 07/12] tg-summary: accept -i/-w
Date: Wed, 20 Oct 2010 22:17:52 +0200
Message-ID: <2af535ba26e4879ef1e420900effb95f71a9e531.1287605587.git.bert.wesarg@googlemail.com>
References: <52df5d1de969f474d93c4dce320edc657bb866dc.1287605587.git.bert.wesarg@googlemail.com>
 <38d2d7e3ba54cea256bc111f50bcb8d35e7d520d.1287605587.git.bert.wesarg@googlemail.com>
 <b00fdc4e3060b7cf9f1ed25caff16799df09e414.1287605587.git.bert.wesarg@googlemail.com>
 <d9fc8653e6e4c7eb7197a0fb92cd3b8c6e058187.1287605587.git.bert.wesarg@googlemail.com>
 <d1c407c33f446a6e5c7329ba521871732a136fa6.1287605587.git.bert.wesarg@googlemail.com>
 <e3ce8e49edc363c62c6135ffe94dd1e5990cce6a.1287605587.git.bert.wesarg@googlemail.com>
Cc: git@vger.kernel.org, pasky@suse.cz,
	martin f krafft <madduck@madduck.net>,
	Bert Wesarg <bert.wesarg@googlemail.com>
To: Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Wed Oct 20 22:19:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8f7o-0005GB-Hq
	for gcvg-git-2@lo.gmane.org; Wed, 20 Oct 2010 22:19:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755594Ab0JTUS2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Oct 2010 16:18:28 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:33858 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755557Ab0JTUSZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Oct 2010 16:18:25 -0400
Received: by ywi6 with SMTP id 6so2278667ywi.19
        for <git@vger.kernel.org>; Wed, 20 Oct 2010 13:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=Gwmacet2URWBktlI1oi41kSv8uL7lkX0j+dz6vDxRQU=;
        b=nrNuBlZvCpWE0/lgrZzFMZ3nF5XjCihQtilkGqWEk6IYsN5ouzdeFNVLZ7AaASzAjW
         /A2/DQR4nP4n0XMiazPU8Wr/mtmzWbv5FlLhWPgyztF4+TYXqOR19Hg21Ds2P+HETx8N
         bP2+HAOx18jVJUkRUgp9XQ4WQ1qtmExu1+zis=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=XPbcRf2ysM1wIoSidkR0LhWwD2889tCaEU4azDYmWGksBuNF98w5HPt+B6twYRKLPP
         F6FirY5UDPTXbGnIxaINvDGpzbJjv8AtZCkEiM5pD45eIx/iKpFu+X2C5k77bpNDJ1E1
         gliRNzI2SbGHtTM8/JF8F1096GbaEa8aOLQYg=
Received: by 10.103.121.9 with SMTP id y9mr6501887mum.61.1287605904396;
        Wed, 20 Oct 2010 13:18:24 -0700 (PDT)
Received: from localhost (drsd-4db3cc42.pool.mediaWays.net [77.179.204.66])
        by mx.google.com with ESMTPS id z25sm406988fam.2.2010.10.20.13.18.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 20 Oct 2010 13:18:24 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.1.1069.g89486
In-Reply-To: <e3ce8e49edc363c62c6135ffe94dd1e5990cce6a.1287605587.git.bert.wesarg@googlemail.com>
In-Reply-To: <52df5d1de969f474d93c4dce320edc657bb866dc.1287605587.git.bert.wesarg@googlemail.com>
References: <52df5d1de969f474d93c4dce320edc657bb866dc.1287605587.git.bert.wesarg@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159430>

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
---
 README                     |    4 ++++
 contrib/tg-completion.bash |    4 ++++
 tg-summary.sh              |   21 +++++++++++++++------
 3 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/README b/README
index 5ca0424..eea0d72 100644
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
index ccf1a32..6a1e182 100755
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
index 612bd27..1c99e22 100644
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
@@ -68,8 +71,11 @@ process_branch()
 
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
@@ -88,7 +94,7 @@ process_branch()
 	branch_contains "$name" "refs/top-bases/$name" || base_update='B'
 
 	if [ "$(git rev-parse "$name")" != "$rev" ]; then
-		subject="$(git cat-file blob "$name:.topmsg" | sed -n 's/^Subject: //p')"
+		subject="$(cat_file "$name:.topmsg" $from | sed -n 's/^Subject: //p')"
 	else
 		# No commits yet
 		subject="(No commits)"
@@ -99,7 +105,7 @@ process_branch()
 }
 
 if [ -n "$deps" ]; then
-	list_deps
+	list_deps $head_from
 	exit 0
 fi
 
@@ -113,7 +119,10 @@ git for-each-ref refs/top-bases |
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
1.7.3.1.1069.g89486
