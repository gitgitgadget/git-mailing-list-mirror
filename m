From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH/RFC 14/20] gettextize: git-bisect die + gettext messages
Date: Tue, 14 Sep 2010 13:52:14 +0000
Message-ID: <1284472340-7049-15-git-send-email-avarab@gmail.com>
References: <1284472340-7049-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 14 15:53:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OvVx8-0004Wc-HH
	for gcvg-git-2@lo.gmane.org; Tue, 14 Sep 2010 15:53:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753453Ab0INNxc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Sep 2010 09:53:32 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:48443 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753327Ab0INNxb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Sep 2010 09:53:31 -0400
Received: by mail-ww0-f44.google.com with SMTP id 20so136386wwd.1
        for <git@vger.kernel.org>; Tue, 14 Sep 2010 06:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=C8tE1s6eOF1vQEo/Sh82rk/XSGPoMkNh13hvQPFXeSk=;
        b=tg/z+ljaW5/hyTItJf/IZhz+dtB8sV7qxIVN5NHjFHEmf/N1K1hQhyE9dG1YfnYSak
         EP58QPC4OihXXFEnYjUw4dLsvgaQDCAUBD60kwDtfmri2ZlUvI4ZZJj/07vMDjzbWlMR
         HhnBSjhMVh723MNy9JwaPGev7bOxnN796ihJ8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=lMHa5hapy/k4ITZO2QGy61PTxJGmypDd/BReKGergPYqFF4IMiaqFIu3Y70D9GDVCz
         JTtuBTDlNK6PMql8eBWGXFo6Y3dAtdIKi7zuFbVMUm/yd+ikNOFD/Qo2KdjvarqiWc3U
         KNSgnok7Umq/bu1grnVCASYQ8GGv3OTQ7OXxU=
Received: by 10.216.8.138 with SMTP id 10mr4013065wer.57.1284472410816;
        Tue, 14 Sep 2010 06:53:30 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id v11sm158854weq.16.2010.09.14.06.53.26
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 14 Sep 2010 06:53:26 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.rc1.234.g8dc15
In-Reply-To: <1284472340-7049-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156182>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-bisect.sh |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index c294819..31ca97c 100755
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
@@ -355,7 +355,7 @@ bisect_replay () {
 		good|bad|skip)
 			bisect_write "$command" "$rev" ;;
 		*)
-			die "?? what are you talking about?" ;;
+			die "$(gettext "?? what are you talking about?")" ;;
 		esac
 	done <"$1"
 	bisect_auto_next
--=20
1.7.3.rc1.234.g8dc15
