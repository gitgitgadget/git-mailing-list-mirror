From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH/RFC 12/20] gettextize: git-bisect echo + gettext messages
Date: Tue, 14 Sep 2010 13:52:12 +0000
Message-ID: <1284472340-7049-13-git-send-email-avarab@gmail.com>
References: <1284472340-7049-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 14 15:53:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OvVx7-0004Wc-EM
	for gcvg-git-2@lo.gmane.org; Tue, 14 Sep 2010 15:53:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753307Ab0INNxX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Sep 2010 09:53:23 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:48443 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753292Ab0INNxW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Sep 2010 09:53:22 -0400
Received: by mail-ww0-f44.google.com with SMTP id 20so136386wwd.1
        for <git@vger.kernel.org>; Tue, 14 Sep 2010 06:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=2FtRt93q0CFqBtPyN8AxdEmjF5thHVbUNNlZe5jSWCM=;
        b=KMySDWmaXu459ap3Vmm6fsLu97T00yA2jCj4HyGR5DnIzr5xfvue9OSWnPNKK4Y3S5
         gixORWky1HPqSU96nPCd9LX2dXhj0elxDHrguYfKbDCRSfq3AGB/icKcA4YTxSD9T9jA
         2S+NAEhdlDc/tnq0jKlKXKJWzA6bGxPwOsmQM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=vBbb2eUGBOvpSBq2oy8nlWVeHbx6+BTjN8hnPr4mCplf/0gar8ncn9kVGQ9aOhEMoX
         gbidQgUOShEVlTXTlYpRvPbcknWTGd/OOss+myWVGj7WBPzSsM1cNRF+WqlEsQhcWblB
         NABQnchuSmufcOM1xLB1sq3y5ZrTe4T4PQnwk=
Received: by 10.216.176.8 with SMTP id a8mr3937881wem.93.1284472402060;
        Tue, 14 Sep 2010 06:53:22 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id v11sm158854weq.16.2010.09.14.06.53.20
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 14 Sep 2010 06:53:20 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.rc1.234.g8dc15
In-Reply-To: <1284472340-7049-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156181>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-bisect.sh |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index 1274f11..4920878 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -36,7 +36,7 @@ _x40=3D"$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
=20
 bisect_autostart() {
 	test -s "$GIT_DIR/BISECT_START" || {
-		echo >&2 'You need to start by "git bisect start"'
+		echo >&2 "$(gettext "You need to start by \"git bisect start\"")"
 		if test -t 0
 		then
 			echo >&2 -n 'Do you want me to do it for you [Y/n]? '
@@ -239,7 +239,7 @@ bisect_next_check() {
 	t,,good)
 		# have bad but not good.  we could bisect although
 		# this is less optimum.
-		echo >&2 'Warning: bisecting only with a bad commit.'
+		echo >&2 "$(gettext "Warning: bisecting only with a bad commit.")"
 		if test -t 0
 		then
 			printf >&2 'Are you sure [Y/n]? '
@@ -395,7 +395,7 @@ bisect_run () {
=20
       if sane_grep "first bad commit could be any of" "$GIT_DIR/BISECT=
_RUN" \
 		> /dev/null; then
-	  echo >&2 "bisect run cannot continue any more"
+	  echo >&2 "$(gettext "bisect run cannot continue any more")"
 	  exit $res
       fi
=20
--=20
1.7.3.rc1.234.g8dc15
