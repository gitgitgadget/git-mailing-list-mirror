From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 45/51] i18n: git-bisect die + gettext messages
Date: Sun,  3 Apr 2011 16:46:09 +0000
Message-ID: <1301849175-1697-46-git-send-email-avarab@gmail.com>
References: <1301849175-1697-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 03 18:48:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6QTM-0005RJ-BJ
	for gcvg-git-2@lo.gmane.org; Sun, 03 Apr 2011 18:48:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753160Ab1DCQrT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Apr 2011 12:47:19 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:47128 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753037Ab1DCQrR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2011 12:47:17 -0400
Received: by mail-ey0-f174.google.com with SMTP id 24so1502908eyx.19
        for <git@vger.kernel.org>; Sun, 03 Apr 2011 09:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=dWRrHvQZRQ7kOVq3nTrYN/XasAvi159g6+Z92aUvXsc=;
        b=QcFRh0tGAjB1G+3Tpr/3JCDwAgbt7tiGoHxPnnF8eb2V3z462vWJp3OBoeNiVoV4Hv
         G5zfviMG+v1Ja7DtTlQyfkwM8ECWTuS5rPf5F0rjxQMMlIeezBoT2a4CvFE/cHyngiM7
         JXm7QYGaG0nlwRq3ynko70keKnYOCoC52qNU0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=i2AWYorgXXUPP7Uea026cafL2lROBoHpmHHI3zq2GslJLkRZBeJ5EKWvxVskafTBu7
         /EvqPNya+3yHJcEm5uOvlsGTYJeN2wzzHk+u14SZLYTjB202lwajcGcfIw2+pB7eH4jE
         30Sky/07D0HcxwBgZNIphfcLqRdRZzcVpfeQM=
Received: by 10.14.15.135 with SMTP id f7mr896669eef.69.1301849237001;
        Sun, 03 Apr 2011 09:47:17 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id w59sm2750567eeh.24.2011.04.03.09.47.16
        (version=SSLv3 cipher=OTHER);
        Sun, 03 Apr 2011 09:47:16 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1301849175-1697-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170725>

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
1.7.4.1
