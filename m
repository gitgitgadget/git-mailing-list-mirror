From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v2 06/48] i18n: git-am die messages
Date: Sat, 21 May 2011 18:43:47 +0000
Message-ID: <1306003469-22939-7-git-send-email-avarab@gmail.com>
References: <1306003469-22939-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 21 20:45:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNrAp-00009h-Jj
	for gcvg-git-2@lo.gmane.org; Sat, 21 May 2011 20:45:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755597Ab1EUSpL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 May 2011 14:45:11 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:45234 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755100Ab1EUSpI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2011 14:45:08 -0400
Received: by mail-ew0-f46.google.com with SMTP id 4so1451059ewy.19
        for <git@vger.kernel.org>; Sat, 21 May 2011 11:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=826nYOabkPDO5kyoxKu+/J00bUGqsf59pTBe9Fa5v8A=;
        b=xZ3+iKQ6Ae39UJp8LAncTgpzXMBeN++vLJAP2W87I8aPR6d4rWDUNdSEMLxTQO2JUc
         SRam2GcsLQiMkNXSGVyo+MbF+JK+EXMkauawNkIaVZ7QWAUsKPoJM1iWsh5QEObJwVJq
         P5Tgqzzm65XtSqS/9TyoOId19BDbnFt17nTkk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=f0M67X5PQLY74NUEKmrw1UwcDTdjn6pIbpg8aKtSmJtvLdsWjZbgeUBXNzOJFON4sA
         anBGyPvNx/FUuz85UpX8vgh8Ce6O0v3pF2v86ShnCC+ZgVsvXdy4qV5SBoQ/TzMUTb+H
         pIAO89r4hXVCstAiXfNMeM4WuaA3UfhhKyVQs=
Received: by 10.14.11.5 with SMTP id 5mr260435eew.92.1306003507624;
        Sat, 21 May 2011 11:45:07 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id y14sm1130434eeh.3.2011.05.21.11.45.06
        (version=SSLv3 cipher=OTHER);
        Sat, 21 May 2011 11:45:07 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
In-Reply-To: <1306003469-22939-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174120>

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
index d56c7e9..b9ec69e 100755
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
@@ -362,7 +362,7 @@ do
 	--rebasing)
 		rebasing=3Dt threeway=3Dt keep=3Dt scissors=3Df no_inbody_headers=3D=
t ;;
 	-d|--dotest)
-		die "-d option is no longer supported.  Do not use."
+		die "$(gettext "-d option is no longer supported.  Do not use.")"
 		;;
 	--resolvemsg)
 		shift; resolvemsg=3D$1 ;;
@@ -425,12 +425,12 @@ then
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
@@ -457,7 +457,7 @@ then
 else
 	# Make sure we are not given --skip, --resolved, nor --abort
 	test "$skip$resolved$abort" =3D "" ||
-		die "Resolve operation not in progress, we are not resuming."
+		die "$(gettext "Resolve operation not in progress, we are not resumi=
ng.")"
=20
 	# Start afresh.
 	mkdir -p "$dotest" || exit
@@ -522,7 +522,7 @@ case "$resolved" in
 	if test "$files"
 	then
 		test -n "$HAS_HEAD" && : >"$dotest/dirtyindex"
-		die "Dirty index: cannot apply patches (dirty: $files)"
+		die "$(eval_gettext "Dirty index: cannot apply patches (dirty: \$fil=
es)")"
 	fi
 esac
=20
@@ -695,7 +695,7 @@ To restore the original branch and stop patching ru=
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
1.7.5.1
