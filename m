From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 43/48] i18n: git-bisect die + eval_gettext messages
Date: Sun,  8 May 2011 12:21:15 +0000
Message-ID: <1304857280-14773-44-git-send-email-avarab@gmail.com>
References: <1304857280-14773-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 08 14:23:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJ30u-0004Hv-1j
	for gcvg-git-2@lo.gmane.org; Sun, 08 May 2011 14:23:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754069Ab1EHMWg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 May 2011 08:22:36 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:50701 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753705Ab1EHMWO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2011 08:22:14 -0400
Received: by mail-ew0-f46.google.com with SMTP id 4so1327021ewy.19
        for <git@vger.kernel.org>; Sun, 08 May 2011 05:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=Gbc/uyc9AIx/AhE8m4N/Rw8/xLQBO+79LUtDvlq8Rko=;
        b=xhoXfXPcAiWfeGN7plQQN297bXQc/+mX1U1p0mSHgiHUx6yc+pDdK+IWfReQbHYfdQ
         lbz6q4rVVbf4pGVuUIZVVJsUPba/z0uqhUnRpDlMkDHlI6PPTedJ4xvg8J2jH3nnkSJs
         LrCfjAHL2C0A6M6uOW4Atv+2H/zCiCaLzWE3Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=CQMsst82hFXVtr4JUMV1P3DkhaBslahoFqXZYr8HUPW7LvpCgFSc0DOYfVhQQ++Ac2
         9ef84RK/T2EJ7gRtCJ+ONNI33Oam+98bdZnSE1YbiURLC63VZAhyT6F/KdfU+HQi22N4
         CuXH36/tnpzZgZC/oxDZVda94J8tfWoX6je/g=
Received: by 10.213.9.195 with SMTP id m3mr1978980ebm.57.1304857333922;
        Sun, 08 May 2011 05:22:13 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id n55sm2690046een.2.2011.05.08.05.22.12
        (version=SSLv3 cipher=OTHER);
        Sun, 08 May 2011 05:22:13 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.4
In-Reply-To: <1304857280-14773-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173133>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-bisect.sh |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index ef9af0b..2e755cd 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -111,7 +111,7 @@ bisect_start() {
 	    *)
 		rev=3D$(git rev-parse -q --verify "$arg^{commit}") || {
 		    test $has_double_dash -eq 1 &&
-		        die "'$arg' does not appear to be a valid revision"
+		        die "$(eval_gettext "'\$arg' does not appear to be a valid r=
evision")"
 		    break
 		}
 		case $bad_seen in
@@ -156,7 +156,7 @@ bisect_write() {
 	case "$state" in
 		bad)		tag=3D"$state" ;;
 		good|skip)	tag=3D"$state"-"$rev" ;;
-		*)		die "Bad bisect_write argument: $state" ;;
+		*)		die "$(eval_gettext "Bad bisect_write argument: \$state")" ;;
 	esac
 	git update-ref "refs/bisect/$tag" "$rev" || exit
 	echo "# $state: $(git show-branch $rev)" >>"$GIT_DIR/BISECT_LOG"
@@ -184,7 +184,7 @@ bisect_skip() {
 	do
 	    case "$arg" in
             *..*)
-                revs=3D$(git rev-list "$arg") || die "Bad rev input: $=
arg" ;;
+                revs=3D$(git rev-list "$arg") || die "$(eval_gettext "=
Bad rev input: \$arg")" ;;
             *)
                 revs=3D$(git rev-parse --sq-quote "$arg") ;;
 	    esac
@@ -210,7 +210,7 @@ bisect_state() {
 		for rev in "$@"
 		do
 			sha=3D$(git rev-parse --verify "$rev^{commit}") ||
-				die "Bad rev input: $rev"
+				die "$(eval_gettext "Bad rev input: \$rev")"
 			eval=3D"$eval bisect_write '$state' '$sha'; "
 		done
 		eval "$eval"
@@ -322,8 +322,8 @@ bisect_reset() {
 	if git checkout "$branch" -- ; then
 		bisect_clean_state
 	else
-		die "Could not check out original HEAD '$branch'." \
-				"Try 'git bisect reset <commit>'."
+		die "$(eval_gettext "Could not check out original HEAD '\$branch'.
+Try 'git bisect reset <commit>'.")"
 	fi
 }
=20
--=20
1.7.4.4
