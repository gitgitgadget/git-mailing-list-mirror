From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 42/48] i18n: git-bisect die + gettext messages
Date: Sun,  8 May 2011 12:21:14 +0000
Message-ID: <1304857280-14773-43-git-send-email-avarab@gmail.com>
References: <1304857280-14773-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 08 14:23:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJ30x-0004Hv-Tu
	for gcvg-git-2@lo.gmane.org; Sun, 08 May 2011 14:23:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754094Ab1EHMXH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 May 2011 08:23:07 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:37472 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753954Ab1EHMWN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2011 08:22:13 -0400
Received: by mail-ey0-f174.google.com with SMTP id 24so1325598eyx.19
        for <git@vger.kernel.org>; Sun, 08 May 2011 05:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=hE2L0rBtJT/UFe4KhUx3pGZLyjvkE+qMhMhbcNXNBuQ=;
        b=Ga+JRJWZyyb+/ka8zjQdYlHsECIkXwOYNIgxQROIFsg/wpgAquQvd21KIpaXBHd+z4
         JyrOL50uK6DWunAIjuqtybsmgxYI3PO2K7VwTZj3OdvzMl9FXUKP8lh4FkDIztia3lkl
         PWKOJaTOuDeSjY/HQzm2HVQNQpiUtP2aBIX4A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=QV7btcxKLIs09aCWAjlY9kUb9SQPZa9lkkLtwWYTy87QmbqWvIIzKaPSM1xAPJqpBO
         jlEvBV7CFzQmOgIbx8VrH41dnf0zVwSeTJAO77A1TOSJJRWVKLsuSlBrW8lPEbi2raxS
         kfeFiKTGftwGn7GStOdZRgnEEsftw3lbyQCzs=
Received: by 10.213.13.206 with SMTP id d14mr1780144eba.28.1304857332889;
        Sun, 08 May 2011 05:22:12 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id n55sm2690046een.2.2011.05.08.05.22.11
        (version=SSLv3 cipher=OTHER);
        Sun, 08 May 2011 05:22:12 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.4
In-Reply-To: <1304857280-14773-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173138>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-bisect.sh |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index e74be9c..ef9af0b 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -58,7 +58,7 @@ bisect_start() {
 	#
 	head=3D$(GIT_DIR=3D"$GIT_DIR" git symbolic-ref -q HEAD) ||
 	head=3D$(GIT_DIR=3D"$GIT_DIR" git rev-parse --verify HEAD) ||
-	die "Bad HEAD - I need a HEAD"
+	die "$(gettext "Bad HEAD - I need a HEAD")"
=20
 	#
 	# Check if we are bisecting.
@@ -77,11 +77,11 @@ bisect_start() {
 			# cogito usage, and cogito users should understand
 			# it relates to cg-seek.
 			[ -s "$GIT_DIR/head-name" ] &&
-				die "won't bisect on seeked tree"
+				die "$(gettext "won't bisect on seeked tree")"
 			start_head=3D"${head#refs/heads/}"
 			;;
 		*)
-			die "Bad HEAD - strange symbolic ref"
+			die "$(gettext "Bad HEAD - strange symbolic ref")"
 			;;
 		esac
 	fi
@@ -198,10 +198,10 @@ bisect_state() {
 	state=3D$1
 	case "$#,$state" in
 	0,*)
-		die "Please call 'bisect_state' with at least one argument." ;;
+		die "$(gettext "Please call 'bisect_state' with at least one argumen=
t.")" ;;
 	1,bad|1,good|1,skip)
 		rev=3D$(git rev-parse --verify HEAD) ||
-			die "Bad rev input: HEAD"
+			die "$(gettext "Bad rev input: HEAD")"
 		bisect_write "$state" "$rev"
 		check_expected_revs "$rev" ;;
 	2,bad|*,good|*,skip)
@@ -216,7 +216,7 @@ bisect_state() {
 		eval "$eval"
 		check_expected_revs "$@" ;;
 	*,bad)
-		die "'git bisect bad' can take only one argument." ;;
+		die "$(gettext "'git bisect bad' can take only one argument.")" ;;
 	*)
 		usage ;;
 	esac
@@ -363,7 +363,7 @@ bisect_replay () {
 		good|bad|skip)
 			bisect_write "$command" "$rev" ;;
 		*)
-			die "?? what are you talking about?" ;;
+			die "$(gettext "?? what are you talking about?")" ;;
 		esac
 	done <"$1"
 	bisect_auto_next
@@ -422,7 +422,7 @@ bisect_run () {
 }
=20
 bisect_log () {
-	test -s "$GIT_DIR/BISECT_LOG" || die "We are not bisecting."
+	test -s "$GIT_DIR/BISECT_LOG" || die "$(gettext "We are not bisecting=
=2E")"
 	cat "$GIT_DIR/BISECT_LOG"
 }
=20
--=20
1.7.4.4
