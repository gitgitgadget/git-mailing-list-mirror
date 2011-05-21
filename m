From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v2 42/48] i18n: git-bisect die + gettext messages
Date: Sat, 21 May 2011 18:44:23 +0000
Message-ID: <1306003469-22939-43-git-send-email-avarab@gmail.com>
References: <1306003469-22939-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 21 20:47:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNrCi-0001Bj-9Q
	for gcvg-git-2@lo.gmane.org; Sat, 21 May 2011 20:47:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757191Ab1EUSqh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 May 2011 14:46:37 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:39530 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756864Ab1EUSpm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2011 14:45:42 -0400
Received: by mail-ey0-f174.google.com with SMTP id 24so1444607eyx.19
        for <git@vger.kernel.org>; Sat, 21 May 2011 11:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=4+iLpYjDpbHgHrsrS6qPfitu4E/GRGwBPjrnzzp+bzs=;
        b=U76ruvVlF8M/hYwDE+bsFNR3MoPu63pEqQOzW/hYOH1cTbHIVgs4gAYbRqknM3+v0m
         Zlow6/zYVUfQU0qAdz1sxwzAQXzi0EgeYIr4gfQSaA7WKlqFtPHMFkrY5sKZmrZXSSXV
         8nAEzb3zd9PG6Ylm0kq/rYLRhEkGXru+Iv2v4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=oTpHK7DQP4AWS7ZJLW7YS5456TZp+v0HssDMY7Nxod8R9YPBdKUFxBfsG8OXCrrN+/
         WmtsERKKUMND2Dj7vikx9OrZu0WCA6wfyvwsCuL/y5Y4uoLrDB15Uz3Yi6yQVuhxN6k8
         hkFvki47GBEBw5hI2WjtUAD6PvtZ7jtM+CPrA=
Received: by 10.213.19.136 with SMTP id a8mr610474ebb.87.1306003541533;
        Sat, 21 May 2011 11:45:41 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id y14sm1130434eeh.3.2011.05.21.11.45.40
        (version=SSLv3 cipher=OTHER);
        Sat, 21 May 2011 11:45:41 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
In-Reply-To: <1306003469-22939-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174147>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-bisect.sh |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index 1b432b5..876fdd1 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -61,7 +61,7 @@ bisect_start() {
 	#
 	head=3D$(GIT_DIR=3D"$GIT_DIR" git symbolic-ref -q HEAD) ||
 	head=3D$(GIT_DIR=3D"$GIT_DIR" git rev-parse --verify HEAD) ||
-	die "Bad HEAD - I need a HEAD"
+	die "$(gettext "Bad HEAD - I need a HEAD")"
=20
 	#
 	# Check if we are bisecting.
@@ -80,11 +80,11 @@ bisect_start() {
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
@@ -201,10 +201,10 @@ bisect_state() {
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
@@ -219,7 +219,7 @@ bisect_state() {
 		eval "$eval"
 		check_expected_revs "$@" ;;
 	*,bad)
-		die "'git bisect bad' can take only one argument." ;;
+		die "$(gettext "'git bisect bad' can take only one argument.")" ;;
 	*)
 		usage ;;
 	esac
@@ -369,7 +369,7 @@ bisect_replay () {
 		good|bad|skip)
 			bisect_write "$command" "$rev" ;;
 		*)
-			die "?? what are you talking about?" ;;
+			die "$(gettext "?? what are you talking about?")" ;;
 		esac
 	done <"$1"
 	bisect_auto_next
@@ -434,7 +434,7 @@ bisect_run () {
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
1.7.5.1
