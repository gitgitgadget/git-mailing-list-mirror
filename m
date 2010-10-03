From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [TopGit PATCH 6/6] tg-log: short cut to git log
Date: Sun,  3 Oct 2010 23:25:57 +0200
Message-ID: <1286141157-30422-6-git-send-email-bert.wesarg@googlemail.com>
References: <AANLkTim3gnU+_krD2QM0BAMf9DZi2_4hva6dq4WXcatH@mail.gmail.com>
 <1286141157-30422-1-git-send-email-bert.wesarg@googlemail.com>
 <1286141157-30422-2-git-send-email-bert.wesarg@googlemail.com>
 <1286141157-30422-3-git-send-email-bert.wesarg@googlemail.com>
 <1286141157-30422-4-git-send-email-bert.wesarg@googlemail.com>
 <1286141157-30422-5-git-send-email-bert.wesarg@googlemail.com>
Cc: git@vger.kernel.org, Peter Simons <simons@cryp.to>, pasky@suse.cz,
	Per Cederqvist <ceder@lysator.liu.se>,
	Olaf Dabrunz <odabrunz@gmx.net>,
	Thomas Moschny <thomas.moschny@gmx.de>,
	martin f krafft <madduck@madduck.net>,
	Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Sun Oct 03 23:26:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2W4s-0003XG-VT
	for gcvg-git-2@lo.gmane.org; Sun, 03 Oct 2010 23:26:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755262Ab0JCV0P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Oct 2010 17:26:15 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:49127 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755243Ab0JCV0O (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Oct 2010 17:26:14 -0400
Received: by mail-bw0-f46.google.com with SMTP id 11so3198232bwz.19
        for <git@vger.kernel.org>; Sun, 03 Oct 2010 14:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:to;
        bh=v6vIOqkVYOXDt+CiWhZtfmc43jQa7ESpRpzeiyadjKo=;
        b=OKfdMHYNlzl1SoFE6QAHaDRCEuT3YlNxgYtYiCk3oyB+8HKcsCt4gaE4JG+2hQQ8oW
         iotQedjgjMdFsp/IO7cCAgI1o2gl5SJ5Jy9EjkD9S1xskeW5PsAfKdfAD5G2cwJr2ugd
         57pGqnbndWTzN1/rpv7YTEaH1F/6aIWXWv4GM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=CNCkKOD5Xmxmkn8ww7ldmEb+BIR8Y/ogNc1+T50tT6IwiWMIYzJFymBJxyBlfmgAND
         /fJosaOrqRLECEtaMKhcPb5GEqF/OFT6nZTutZgaVg1vs5o6fK5uAmKggXAni0y8FdrB
         c3od5uqPs488aGuCphG/5vAXTwOpIFdzSAWuc=
Received: by 10.204.74.195 with SMTP id v3mr6272778bkj.35.1286141173902;
        Sun, 03 Oct 2010 14:26:13 -0700 (PDT)
Received: from localhost (p5B0F7E04.dip.t-dialin.net [91.15.126.4])
        by mx.google.com with ESMTPS id f18sm3044828bkf.3.2010.10.03.14.26.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 03 Oct 2010 14:26:13 -0700 (PDT)
To: Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 1.7.1.1067.g5aeb7
In-Reply-To: <1286141157-30422-5-git-send-email-bert.wesarg@googlemail.com>
To: Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157933>

A short cut to show the history of a named topgit branch.  Additional options
to git log can be given after a '--'.

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>

---
 .gitignore                 |    2 ++
 README                     |    3 +++
 contrib/tg-completion.bash |   11 +++++++++++
 tg-log.sh                  |   30 ++++++++++++++++++++++++++++++
 4 files changed, 46 insertions(+), 0 deletions(-)

diff --git a/.gitignore b/.gitignore
index 0342e09..3298889 100644 .gitignore
--- a/.gitignore
+++ b/.gitignore
@@ -28,6 +28,8 @@
 /tg-info.txt
 /tg-mail
 /tg-mail.txt
+/tg-log
+/tg-log.txt
 /tg-patch
 /tg-patch.txt
 /tg-push
diff --git a/README b/README
index f103d92..b5fdaaf 100644 README
--- a/README
+++ b/README
@@ -522,6 +522,9 @@ tg base
 	repository, so you will not see work done by your
 	collaborators.)
 
+tg log
+~~~~~~
+	Prints the git log of the named topgit branch.
 
 TODO: tg rename
 
diff --git a/contrib/tg-completion.bash b/contrib/tg-completion.bash
index 0ee233c..c65398a 100755 contrib/tg-completion.bash
--- a/contrib/tg-completion.bash
+++ b/contrib/tg-completion.bash
@@ -344,6 +344,16 @@ _tg_info ()
 	esac
 }
 
+_tg_log ()
+{
+	local cur="${COMP_WORDS[COMP_CWORD]}"
+
+	case "$cur" in
+	*)
+		__tgcomp "$(__tg_topics)"
+	esac
+}
+
 _tg_mail ()
 {
 	local cur="${COMP_WORDS[COMP_CWORD]}"
@@ -470,6 +480,7 @@ _tg ()
 	help)        _tg_help ;;
 	import)      _tg_import ;;
 	info)        _tg_info ;;
+	log)         _tg_log ;;
 	mail)        _tg_mail ;;
 	patch)       _tg_patch ;;
 	push)        _tg_push ;;
diff --git a/tg-log.sh b/tg-log.sh
new file mode 100644
index 0000000..8a8d527 tg-log.sh
--- /dev/null
+++ b/tg-log.sh
@@ -0,0 +1,30 @@
+#!/bin/sh
+# TopGit - A different patch queue manager
+# (c) Petr Baudis <pasky@suse.cz>  2008
+# (c) Bert Wesarg <Bert.Wesarg@googlemail.com>  2009
+# GPLv2
+
+name=
+
+
+## Parse options
+
+while [ -n "$1" ]; do
+	arg="$1"; shift
+	case "$arg" in
+	--)
+		break;;
+	-*)
+		echo "Usage: tg [...] log [NAME] [-- GIT LOG OPTIONS...]" >&2
+		exit 1;;
+	*)
+		[ -z "$name" ] || die "name already specified ($name)"
+		name="$arg";;
+	esac
+done
+
+[ -n "$name" ] || name="$(git symbolic-ref HEAD | sed 's#^refs/heads/##')"
+base_rev="$(git rev-parse --short --verify "refs/top-bases/$name" 2>/dev/null)" ||
+	die "not a TopGit-controlled branch"
+
+git log --first-parent --no-merges "$@" "refs/top-bases/$name".."$name"
-- 
tg: (9404aa1..) bw/log (depends on: master)
