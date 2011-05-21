From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v2 43/48] i18n: git-bisect die + eval_gettext messages
Date: Sat, 21 May 2011 18:44:24 +0000
Message-ID: <1306003469-22939-44-git-send-email-avarab@gmail.com>
References: <1306003469-22939-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 21 20:46:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNrC8-0000od-4H
	for gcvg-git-2@lo.gmane.org; Sat, 21 May 2011 20:46:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757197Ab1EUSqd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 May 2011 14:46:33 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:44943 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756996Ab1EUSpn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2011 14:45:43 -0400
Received: by mail-ew0-f46.google.com with SMTP id 4so1451116ewy.19
        for <git@vger.kernel.org>; Sat, 21 May 2011 11:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=2UyqK+YZHQk9BWSCSbWCmdk4rQSIkVLlQ0+dPSJWuJE=;
        b=PcosDdyMQCKICn3x35pozlDjXAuQ89JKJGmO+FK6THo4KrDnrkBVp/EbKjDQLGNBJO
         nVIk+wQstwFN9qIanV7urjOIa6kUbmvmOZDjLpRNFyoJBdUnnI4b9vLm+Q4pS7wt3oix
         NIzo2m5JJutwIkdYgQ4sEvyPuMlWOA7JRayAM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=IN+zU0UeZpsvwSOb+XMPSkIB6rIwKhNXYNJYloADimkH6yr9gJgzvzqLqAJZSoF7Ow
         cwGpJ1vK6AXW585XdDA5IxpOEwxk02FTK9ppPSXH6if/vh5uVqBR3uw1BMEDHfTlZob3
         BHsR6L/PLVcFKQI4SxVzZViAQ8KiJG3ei3OZo=
Received: by 10.14.29.69 with SMTP id h45mr262313eea.158.1306003542534;
        Sat, 21 May 2011 11:45:42 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id y14sm1130434eeh.3.2011.05.21.11.45.41
        (version=SSLv3 cipher=OTHER);
        Sat, 21 May 2011 11:45:41 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
In-Reply-To: <1306003469-22939-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174145>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-bisect.sh |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index 876fdd1..d86d503 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -114,7 +114,7 @@ bisect_start() {
 	    *)
 		rev=3D$(git rev-parse -q --verify "$arg^{commit}") || {
 		    test $has_double_dash -eq 1 &&
-		        die "'$arg' does not appear to be a valid revision"
+		        die "$(eval_gettext "'\$arg' does not appear to be a valid r=
evision")"
 		    break
 		}
 		case $bad_seen in
@@ -159,7 +159,7 @@ bisect_write() {
 	case "$state" in
 		bad)		tag=3D"$state" ;;
 		good|skip)	tag=3D"$state"-"$rev" ;;
-		*)		die "Bad bisect_write argument: $state" ;;
+		*)		die "$(eval_gettext "Bad bisect_write argument: \$state")" ;;
 	esac
 	git update-ref "refs/bisect/$tag" "$rev" || exit
 	echo "# $state: $(git show-branch $rev)" >>"$GIT_DIR/BISECT_LOG"
@@ -187,7 +187,7 @@ bisect_skip() {
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
@@ -213,7 +213,7 @@ bisect_state() {
 		for rev in "$@"
 		do
 			sha=3D$(git rev-parse --verify "$rev^{commit}") ||
-				die "Bad rev input: $rev"
+				die "$(eval_gettext "Bad rev input: \$rev")"
 			eval=3D"$eval bisect_write '$state' '$sha'; "
 		done
 		eval "$eval"
@@ -328,8 +328,8 @@ bisect_reset() {
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
1.7.5.1
