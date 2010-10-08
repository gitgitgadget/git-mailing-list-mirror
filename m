From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [TopGit PATCH 07/10] tg-files: list files changed by the topic branch
Date: Fri,  8 Oct 2010 09:58:05 +0200
Message-ID: <009a8ed75bd5dcee636e049b11a1bf3ca8ee6fc7.1286524446.git.bert.wesarg@googlemail.com>
References: <160b8b0eb6152da98f4fa633ac25c7a25ff32aa4.1286524446.git.bert.wesarg@googlemail.com>
 <0e1f993f68d36f0c3d848c2aa78f46c7130a24f1.1286524446.git.bert.wesarg@googlemail.com>
 <f8601225b41e5f03b50688c0582466879faaff26.1286524446.git.bert.wesarg@googlemail.com>
 <c013d1489409b5d6e76764aba07eca7107715691.1286524446.git.bert.wesarg@googlemail.com>
 <724f5482452ad11bd3fb8560bacb080fa1cef0a4.1286524446.git.bert.wesarg@googlemail.com>
 <66f0cf2d3c7d2778616fa51bd8d81eb04d0528f6.1286524446.git.bert.wesarg@googlemail.com>
Cc: git@vger.kernel.org, pasky@suse.cz,
	martin f krafft <madduck@madduck.net>,
	Bert Wesarg <bert.wesarg@googlemail.com>
To: Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Fri Oct 08 09:58:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P47qq-00020q-Mv
	for gcvg-git-2@lo.gmane.org; Fri, 08 Oct 2010 09:58:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755286Ab0JHH6a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Oct 2010 03:58:30 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:48018 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755221Ab0JHH62 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Oct 2010 03:58:28 -0400
Received: by mail-bw0-f46.google.com with SMTP id 15so77487bwz.19
        for <git@vger.kernel.org>; Fri, 08 Oct 2010 00:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=FjWiMjCGuIcOZULboYptH2nPwIxhnblNHvGJpmy/WMs=;
        b=HMAaJKvDkeh686y6XmHjg2+YgiJ32rePiNrZeADcGz3btktj9Tx7r0ChzwYAWcHeH5
         AmU/KgxlOXDVui1M74TEpdNo09Ex9hlQSNDS4W3CpOuO6z7GTHKjkMVbCEybU4aUckzg
         KdfSqeDdoZIX41fmxeEzWKk9/PVtwHQ8/dJ5c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=KcDOibhMnUN09BqlqteyLJST92GKNkbs8mIG7UWsTx6b7o504OmQbaWMXLEGNHDO4h
         GH8gsHzy2xB1FB/cshpfI/cWsDzRLhaLZ8G7g1mB/TXlLdqiyWVfEnh5y5wGntjHzW/F
         D3hhg0xOrwj57N07eP32cf1xtSY/tqLCXdraQ=
Received: by 10.204.98.135 with SMTP id q7mr1678032bkn.49.1286524707513;
        Fri, 08 Oct 2010 00:58:27 -0700 (PDT)
Received: from localhost (p5B0F732C.dip.t-dialin.net [91.15.115.44])
        by mx.google.com with ESMTPS id l14sm1071682bkb.19.2010.10.08.00.58.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 08 Oct 2010 00:58:25 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.1067.g5aeb7
In-Reply-To: <66f0cf2d3c7d2778616fa51bd8d81eb04d0528f6.1286524446.git.bert.wesarg@googlemail.com>
In-Reply-To: <160b8b0eb6152da98f4fa633ac25c7a25ff32aa4.1286524446.git.bert.wesarg@googlemail.com>
References: <160b8b0eb6152da98f4fa633ac25c7a25ff32aa4.1286524446.git.bert.wesarg@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158490>

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
index 3298889..2a4d165 100644 .gitignore
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
index c96dc5a..552a2f1 100644 README
--- a/README
+++ b/README
@@ -532,6 +532,14 @@ tg log
 ~~~~~~
 	Prints the git log of the named topgit branch.
 
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
index 6a1e182..eff85ee 100755 contrib/tg-completion.bash
--- a/contrib/tg-completion.bash
+++ b/contrib/tg-completion.bash
@@ -486,6 +486,7 @@ _tg ()
 	delete)      _tg_delete ;;
 	depend)      _tg_depend ;;
 	export)      _tg_export ;;
+	files)       _tg_patch ;;
 	help)        _tg_help ;;
 	import)      _tg_import ;;
 	info)        _tg_info ;;
diff --git a/tg-files.sh b/tg-files.sh
new file mode 100644
index 0000000..ab97624 tg-files.sh
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
1.7.1.1067.g5aeb7
