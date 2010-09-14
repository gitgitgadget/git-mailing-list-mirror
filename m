From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH/RFC 15/20] gettextize: git-bisect die + eval_gettext messages
Date: Tue, 14 Sep 2010 13:52:15 +0000
Message-ID: <1284472340-7049-16-git-send-email-avarab@gmail.com>
References: <1284472340-7049-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 14 15:53:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OvVxK-0004cy-0v
	for gcvg-git-2@lo.gmane.org; Tue, 14 Sep 2010 15:53:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753496Ab0INNxo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Sep 2010 09:53:44 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:48443 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753327Ab0INNxo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Sep 2010 09:53:44 -0400
Received: by mail-ww0-f44.google.com with SMTP id 20so136386wwd.1
        for <git@vger.kernel.org>; Tue, 14 Sep 2010 06:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=L6VDdOnAJvIEkWAPXSiSH7tz2lk/fnA5LV7kGzFi+lw=;
        b=kJiRIdeY0e6RNemsRaiAeREfj3oHqQIjAJNHIp0YLFKypJo7Yb0nRSaBGWFd+VR95M
         Oe0uWoeZFPmss4Dcsgh5CRD8fYZREUKpdCfN0J9fi/KT+DIuf2la/+lvXRDRjqbWB5Hr
         lmcbaaSR/ukTAHcF73jswRsFF58IFeYA5iOWU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=iijc6VXa9ia8l5BMoh7Lvzhr6ROve6FReUc0ci4aP8MY5xAYi5n/kGXA9oC41NOzEy
         em8oxsXdp8oYnsmQbydJN2nKZ2XIF1lW1RXcdHcPw636/KQuZkrn4m3JcU0ST5YJUZfI
         4ZOVHJqNMuyFPlFY/nRj5WcpJ8EW6jY5Qx92I=
Received: by 10.216.90.140 with SMTP id e12mr5778730wef.9.1284472419056;
        Tue, 14 Sep 2010 06:53:39 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id v11sm158854weq.16.2010.09.14.06.53.31
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 14 Sep 2010 06:53:34 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.rc1.234.g8dc15
In-Reply-To: <1284472340-7049-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156184>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-bisect.sh |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index 31ca97c..f715e84 100755
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
--=20
1.7.3.rc1.234.g8dc15
