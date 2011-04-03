From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 46/51] i18n: git-bisect die + eval_gettext messages
Date: Sun,  3 Apr 2011 16:46:10 +0000
Message-ID: <1301849175-1697-47-git-send-email-avarab@gmail.com>
References: <1301849175-1697-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 03 18:48:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6QTN-0005RJ-Ec
	for gcvg-git-2@lo.gmane.org; Sun, 03 Apr 2011 18:48:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753175Ab1DCQrV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Apr 2011 12:47:21 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:45462 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753135Ab1DCQrS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2011 12:47:18 -0400
Received: by mail-ey0-f174.google.com with SMTP id 24so1503007eyx.19
        for <git@vger.kernel.org>; Sun, 03 Apr 2011 09:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=fEqlxg6dXxz0iCuqvx8eQaHX7q1PQik7OPQirl6A7hU=;
        b=Br2ykwncHuqTDqYR6zQA/zDYNCzWFvG4tf4rdUwWr1hcdf7tErRD8pVsToFfafiulC
         TaWdgYp3d6bDnJwjwrpp/DVdtAk+wunLWbE7d5TYYh48DepIZhvIr+oVvccUp0kctPKN
         FPYaXLzfJvcneZdCsxRry7NJzYGxWbvuWacQM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=vDTXuhjZiShL/FzlUB0MEA2gFwJRg03Rpbb+V+Lb0pDe7FtrvCWKeWUXNNEFSkJaEa
         96FIdQhsOTs6vB7kZrWwblT0FT5hxN0kVikZPzWXE97q5K0zAsYTvd5TjIwsn0a59Km6
         cZCKq2T92r+gp0BM3UoztLeMIvstU67OQKztw=
Received: by 10.213.21.28 with SMTP id h28mr3058184ebb.118.1301849237901;
        Sun, 03 Apr 2011 09:47:17 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id w59sm2750567eeh.24.2011.04.03.09.47.17
        (version=SSLv3 cipher=OTHER);
        Sun, 03 Apr 2011 09:47:17 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1301849175-1697-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170729>

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
1.7.4.1
