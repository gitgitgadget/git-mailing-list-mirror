From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v2 02/48] i18n: git-am one-line gettext $msg; echo
Date: Sat, 21 May 2011 18:43:43 +0000
Message-ID: <1306003469-22939-3-git-send-email-avarab@gmail.com>
References: <1306003469-22939-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 21 20:45:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNrAo-00009h-JA
	for gcvg-git-2@lo.gmane.org; Sat, 21 May 2011 20:45:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755187Ab1EUSpH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 May 2011 14:45:07 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:39530 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754732Ab1EUSpF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2011 14:45:05 -0400
Received: by eyx24 with SMTP id 24so1444607eyx.19
        for <git@vger.kernel.org>; Sat, 21 May 2011 11:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=VGnuyRtMS7mDa9ENweePbi79Tu/jQXwgACa9oPCFWVA=;
        b=ky5OuyZIUW09Whd8cFHvoRVfcZ0fMyYgiukswIZcvmQypEiROtXIU4SxinEZM4fovu
         G7xYKowxnqyDkaMLx7m3+mDAgKHiUEdl65irdY5LjmSVHAH6XNaQfzgQP/E39FjZleXK
         MaIbzZ+N4kqV9xW5iTDgiTXQ+N4hDn+Hy/ngI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=HmKEWQeJ3KyRGzl0uQ7fbiy50K1zWrl0b67u+UUcjeB3xZZdMPHOsyHNqbI6PFwsj4
         SAGmb1uhzR8RlfT93T0823L1DqZSbv0BGzeb6eCOKPEhwKMeXdC2GWGlsWW0aTuekZQb
         EJoYS9NM5G7vrajhjhuVEsB/+2ZsVFsGdJlMA=
Received: by 10.213.19.18 with SMTP id y18mr542227eba.60.1306003504084;
        Sat, 21 May 2011 11:45:04 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id y14sm1130434eeh.3.2011.05.21.11.45.02
        (version=SSLv3 cipher=OTHER);
        Sat, 21 May 2011 11:45:03 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
In-Reply-To: <1306003469-22939-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174119>

One-line `gettext $msg; echo' messages are the simplest use case for
gettext(1).

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-am.sh |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index 79c5ea2..f54f13d 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -115,7 +115,7 @@ go_next () {
=20
 cannot_fallback () {
 	echo "$1"
-	echo "Cannot fall back to three-way merge."
+	gettext "Cannot fall back to three-way merge."; echo
 	exit 1
 }
=20
@@ -645,7 +645,7 @@ do
=20
 	if test -z "$GIT_AUTHOR_EMAIL"
 	then
-		echo "Patch does not have a valid e-mail address."
+		gettext "Patch does not have a valid e-mail address."; echo
 		stop_here $this
 	fi
=20
@@ -696,7 +696,7 @@ do
 	    action=3Dagain
 	    while test "$action" =3D again
 	    do
-		echo "Commit Body is:"
+		gettext "Commit Body is:"; echo
 		echo "--------------------------"
 		cat "$dotest/final-commit"
 		echo "--------------------------"
--=20
1.7.5.1
