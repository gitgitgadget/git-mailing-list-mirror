From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 06/48] i18n: git-am die messages
Date: Sun,  8 May 2011 12:20:38 +0000
Message-ID: <1304857280-14773-7-git-send-email-avarab@gmail.com>
References: <1304857280-14773-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 08 14:22:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJ303-0003rg-GP
	for gcvg-git-2@lo.gmane.org; Sun, 08 May 2011 14:22:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753491Ab1EHMVs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 May 2011 08:21:48 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:56660 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753053Ab1EHMVg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2011 08:21:36 -0400
Received: by mail-ew0-f46.google.com with SMTP id 4so1327019ewy.19
        for <git@vger.kernel.org>; Sun, 08 May 2011 05:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=M3fBY/NH0Pzpmou3XTwB1Fgq0v1q4/C/0VdQGPKgSHc=;
        b=mwT02GnN9QeMgxonKM6FnhLvnvHLGEo79e5fUafAqu4ARSZEJyv2QAG3p7c7LtIt+Z
         eBQ+SHn3+fd3411FQOUV+P1cC+30ca9/XZOEjopxR+NuzS5QvMsXQZzWOT545/x89dD8
         fsPXecFARvAXhA1ypY2W+qMI4WpgwSA7TzOM8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=N4sCuiHE/I7X70mNbGQ1r2jAd+ZyhxYppdD1oqa9YTKR7geVIrznzMiW1VtQ0hPwas
         8CBn2yz9O5qXzrsNZgxyDTSP2EM0ELU/MooWY7kYTXHCT3xC0c9xQFwLoXRAVy8D2o2V
         J/0I1cdu/RXODaZiORYzCcPHGopFfewf+P+JA=
Received: by 10.14.49.210 with SMTP id x58mr2828075eeb.12.1304857295850;
        Sun, 08 May 2011 05:21:35 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id n55sm2690046een.2.2011.05.08.05.21.35
        (version=SSLv3 cipher=OTHER);
        Sun, 08 May 2011 05:21:35 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.4
In-Reply-To: <1304857280-14773-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173112>

The die messages in git-am need to use:

    die "$(gettext "string")"

Since gettext(1) emits the message instead of returning it like the C
equivalent, and our die() function in git-sh-setup needs to get a
string as an argument.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-am.sh |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index 688f689..cbd48a9 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -44,7 +44,7 @@ require_work_tree
 cd_to_toplevel
=20
 git var GIT_COMMITTER_IDENT >/dev/null ||
-	die "You need to set your committer info first"
+	die "$(gettext "You need to set your committer info first")"
=20
 if git rev-parse --verify -q HEAD >/dev/null
 then
@@ -359,7 +359,7 @@ do
 	--rebasing)
 		rebasing=3Dt threeway=3Dt keep=3Dt scissors=3Df no_inbody_headers=3D=
t ;;
 	-d|--dotest)
-		die "-d option is no longer supported.  Do not use."
+		die "$(gettext "-d option is no longer supported.  Do not use.")"
 		;;
 	--resolvemsg)
 		shift; resolvemsg=3D$1 ;;
@@ -422,12 +422,12 @@ then
 		false
 		;;
 	esac ||
-	die "previous rebase directory $dotest still exists but mbox given."
+	die "$(eval_gettext "previous rebase directory \$dotest still exists =
but mbox given.")"
 	resume=3Dyes
=20
 	case "$skip,$abort" in
 	t,t)
-		die "Please make up your mind. --skip or --abort?"
+		die "$(gettext "Please make up your mind. --skip or --abort?")"
 		;;
 	t,)
 		git rerere clear
@@ -454,7 +454,7 @@ then
 else
 	# Make sure we are not given --skip, --resolved, nor --abort
 	test "$skip$resolved$abort" =3D "" ||
-		die "Resolve operation not in progress, we are not resuming."
+		die "$(gettext "Resolve operation not in progress, we are not resumi=
ng.")"
=20
 	# Start afresh.
 	mkdir -p "$dotest" || exit
@@ -519,7 +519,7 @@ case "$resolved" in
 	if test "$files"
 	then
 		test -n "$HAS_HEAD" && : >"$dotest/dirtyindex"
-		die "Dirty index: cannot apply patches (dirty: $files)"
+		die "$(eval_gettext "Dirty index: cannot apply patches (dirty: \$fil=
es)")"
 	fi
 esac
=20
@@ -692,7 +692,7 @@ To restore the original branch and stop patching ru=
n \"\$cmdline --abort\"."; ec
 	if test "$interactive" =3D t
 	then
 	    test -t 0 ||
-	    die "cannot be interactive without stdin connected to a terminal.=
"
+	    die "$(gettext "cannot be interactive without stdin connected to =
a terminal.")"
 	    action=3Dagain
 	    while test "$action" =3D again
 	    do
--=20
1.7.4.4
