From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [TopGit PATCH v3 09/12] tg-files: list files changed by the topic branch
Date: Wed, 20 Oct 2010 22:17:54 +0200
Message-ID: <1bf3b3656a23c2de123c749524fcd6df09d9bf87.1287605587.git.bert.wesarg@googlemail.com>
References: <52df5d1de969f474d93c4dce320edc657bb866dc.1287605587.git.bert.wesarg@googlemail.com>
 <38d2d7e3ba54cea256bc111f50bcb8d35e7d520d.1287605587.git.bert.wesarg@googlemail.com>
 <b00fdc4e3060b7cf9f1ed25caff16799df09e414.1287605587.git.bert.wesarg@googlemail.com>
 <d9fc8653e6e4c7eb7197a0fb92cd3b8c6e058187.1287605587.git.bert.wesarg@googlemail.com>
 <d1c407c33f446a6e5c7329ba521871732a136fa6.1287605587.git.bert.wesarg@googlemail.com>
 <e3ce8e49edc363c62c6135ffe94dd1e5990cce6a.1287605587.git.bert.wesarg@googlemail.com>
 <2af535ba26e4879ef1e420900effb95f71a9e531.1287605587.git.bert.wesarg@googlemail.com>
 <3d4e3b72d48a5227fc7a22c0e55581114a75f1b0.1287605587.git.bert.wesarg@googlemail.com>
Cc: git@vger.kernel.org, pasky@suse.cz,
	martin f krafft <madduck@madduck.net>,
	Bert Wesarg <bert.wesarg@googlemail.com>
To: Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Wed Oct 20 22:19:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8f7p-0005GB-3H
	for gcvg-git-2@lo.gmane.org; Wed, 20 Oct 2010 22:19:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755616Ab0JTUSc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Oct 2010 16:18:32 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:34020 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755576Ab0JTUSa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Oct 2010 16:18:30 -0400
Received: by mail-yx0-f174.google.com with SMTP id 8so1901803yxm.19
        for <git@vger.kernel.org>; Wed, 20 Oct 2010 13:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=mpa6FZX+7GxTAS9JwTbdexLbxIIPJztiK04mAs3GSW0=;
        b=Snvwpa/zoFuuT2rOWDLtpAsRdHG2i1QDbo1eyz8UL4J8zhj3I5naIiShKE8VcADqo1
         cX9GcWTVgKlI+L33Hv9Nmd8SWO02PC+XJ44KJYDURq6W4OeCsidUwgmoi6iNRSrCV4pA
         IVo+81AjAHX6FX/gVCHFevSktJcd3J+rV2+GI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=xSAivNm6YgZbiedbLs3dtQ1GPFKO+bgHyHfa/KiRfDfFqTp+MBHj1GEsTxBM60kFsl
         bD9Lcr8ftHVJDoUCjdLHY4T4U1LWKnA05TJx8v2NJg3zf9g5HtV0JnbFlG1q+u0DFgNE
         PEvSvl+yAI1C3THR838xK5xnqWfjeg7v3Cip8=
Received: by 10.103.169.18 with SMTP id w18mr7524290muo.6.1287605908188;
        Wed, 20 Oct 2010 13:18:28 -0700 (PDT)
Received: from localhost (drsd-4db3cc42.pool.mediaWays.net [77.179.204.66])
        by mx.google.com with ESMTPS id n8sm404790faa.31.2010.10.20.13.18.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 20 Oct 2010 13:18:27 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.1.1069.g89486
In-Reply-To: <3d4e3b72d48a5227fc7a22c0e55581114a75f1b0.1287605587.git.bert.wesarg@googlemail.com>
In-Reply-To: <52df5d1de969f474d93c4dce320edc657bb866dc.1287605587.git.bert.wesarg@googlemail.com>
References: <52df5d1de969f474d93c4dce320edc657bb866dc.1287605587.git.bert.wesarg@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159431>

this could also be a --name-only option to tg-patch. But I Like the
similarity to 'quilt files'.

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
---
 .gitignore                 |    2 ++
 README                     |    8 ++++++++
 contrib/tg-completion.bash |    1 +
 tg-files.sh                |   43 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 54 insertions(+), 0 deletions(-)
 create mode 100644 tg-files.sh

diff --git a/.gitignore b/.gitignore
index 3298889..2a4d165 100644
--- a/.gitignore
+++ b/.gitignore
@@ -22,6 +22,8 @@
 /tg-depend.txt
 /tg-export
 /tg-export.txt
+/tg-files
+/tg-files.txt
 /tg-import
 /tg-import.txt
 /tg-info
diff --git a/README b/README
index 538659a..c5a8ae0 100644
--- a/README
+++ b/README
@@ -533,6 +533,14 @@ tg log
 	repository, so you will not see work done by your
 	collaborators.
 
+tg files
+~~~~~~~~
+	List files changed by the current or specified topic branch.
+
+	Options:
+	  -i		list files based on index instead of branch
+	  -w		list files based on working tree instead of branch
+
 TODO: tg rename
 
 
diff --git a/contrib/tg-completion.bash b/contrib/tg-completion.bash
index b7051b8..ddc7655 100755
--- a/contrib/tg-completion.bash
+++ b/contrib/tg-completion.bash
@@ -494,6 +494,7 @@ _tg ()
 	delete)      _tg_delete ;;
 	depend)      _tg_depend ;;
 	export)      _tg_export ;;
+	files)       _tg_patch ;;
 	help)        _tg_help ;;
 	import)      _tg_import ;;
 	info)        _tg_info ;;
diff --git a/tg-files.sh b/tg-files.sh
new file mode 100644
index 0000000..ab97624
--- /dev/null
+++ b/tg-files.sh
@@ -0,0 +1,43 @@
+#!/bin/sh
+# TopGit - A different patch queue manager
+# (c) Petr Baudis <pasky@suse.cz>  2008
+# GPLv2
+
+name=
+head_from=
+
+
+## Parse options
+
+while [ -n "$1" ]; do
+	arg="$1"; shift
+	case "$arg" in
+	-i|-w)
+		[ -z "$head_from" ] || die "-i and -w are mutually exclusive"
+		head_from="$arg";;
+	-*)
+		echo "Usage: tg [...] files [-i | -w] [NAME]" >&2
+		exit 1;;
+	*)
+		[ -z "$name" ] || die "name already specified ($name)"
+		name="$arg";;
+	esac
+done
+
+
+head="$(git symbolic-ref HEAD)"
+head="${head#refs/heads/}"
+
+[ -n "$name" ] ||
+	name="$head"
+base_rev="$(git rev-parse --short --verify "refs/top-bases/$name" 2>/dev/null)" ||
+	die "not a TopGit-controlled branch"
+
+if [ -n "$head_from" ] && [ "$name" != "$head" ]; then
+	die "$head_from makes only sense for the current branch"
+fi
+
+b_tree=$(pretty_tree "$name" -b)
+t_tree=$(pretty_tree "$name" $head_from)
+
+git diff-tree --name-only -r $b_tree $t_tree
-- 
1.7.3.1.1069.g89486
