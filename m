From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [TopGit PATCH 08/11] tg-files: list files changed by the topic branch
Date: Sat,  9 Oct 2010 22:56:59 +0200
Message-ID: <3f39e999ea8aeca5c7125e8981aeffb8cd92d472.1286657607.git.bert.wesarg@googlemail.com>
References: <e72a55b5f6ca2b805892fd6e214a4f72bf865124.1286657607.git.bert.wesarg@googlemail.com>
 <456834d2977615d5f5c41ca3947fb45cd82bfd87.1286657607.git.bert.wesarg@googlemail.com>
 <6e000c8cf21fac6cd4cf8608c8dc021b039e6f83.1286657607.git.bert.wesarg@googlemail.com>
 <ec70ec8e15013f663bba7f62885abe6881a1512a.1286657607.git.bert.wesarg@googlemail.com>
 <b765e0da80781182bf6c3af8f28d9496ed49cc1b.1286657607.git.bert.wesarg@googlemail.com>
 <62e3424559a93dc0f7c3ed55aafce738f2b0f6d3.1286657607.git.bert.wesarg@googlemail.com>
 <65565f00635372ad3677c0187c33da4d3ceb4b73.1286657607.git.bert.wesarg@googlemail.com>
Cc: git@vger.kernel.org, pasky@suse.cz,
	martin f krafft <madduck@madduck.net>,
	Bert Wesarg <bert.wesarg@googlemail.com>
To: Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Sat Oct 09 22:59:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4gVf-0000L9-CU
	for gcvg-git-2@lo.gmane.org; Sat, 09 Oct 2010 22:59:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760625Ab0JIU7J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Oct 2010 16:59:09 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:52677 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760620Ab0JIU7I (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Oct 2010 16:59:08 -0400
Received: by mail-ew0-f46.google.com with SMTP id 20so129207ewy.19
        for <git@vger.kernel.org>; Sat, 09 Oct 2010 13:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=BecDm8HBTrq8ob5+5QaGuxZNjwW8n/R6IiPS1qtavdg=;
        b=sPwwacwMUXpjswPGZFdWyvDsLNyCZzvm4KIO362PzRb8TIOdpFDiqd4hftlZ6Y5Qet
         oa6RloNL8+Z2tKciuKifDowCrqQNHTC4EQESreMnQhs43ZYxqYWWSZtduPBoSyFmiYYS
         aq7yIQTC+TJnBV1Pst71szJTVt5HlHMIn4VVo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=TVVh9pYvCiCzxp+MAy6Zu63CQ04EG2cdKGFoMsLeURRBp/hP2Nj9hbAT98BKIvTh4p
         RBBjXWBO8UVwcDdNfYuy6IEsSFAfwTPTueBEd4N+VZNRdSCsyl0fFqzgOfuQl87yATwo
         6ces92Rh2TKtGpmL7SbbozacrzsAh+LnVIIGo=
Received: by 10.213.113.13 with SMTP id y13mr85535ebp.44.1286657947952;
        Sat, 09 Oct 2010 13:59:07 -0700 (PDT)
Received: from localhost ([46.115.90.142])
        by mx.google.com with ESMTPS id v59sm7832408eeh.16.2010.10.09.13.58.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 09 Oct 2010 13:59:06 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.1067.g5aeb7
In-Reply-To: <65565f00635372ad3677c0187c33da4d3ceb4b73.1286657607.git.bert.wesarg@googlemail.com>
In-Reply-To: <e72a55b5f6ca2b805892fd6e214a4f72bf865124.1286657607.git.bert.wesarg@googlemail.com>
References: <e72a55b5f6ca2b805892fd6e214a4f72bf865124.1286657607.git.bert.wesarg@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158618>

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
index 538659a..c5a8ae0 100644 README
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
index b7051b8..ddc7655 100755 contrib/tg-completion.bash
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
