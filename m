From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 12/20] gettextize: git-am one-line gettext $msg; echo
Date: Tue,  7 Sep 2010 16:48:26 +0000
Message-ID: <1283878113-19533-3-git-send-email-avarab@gmail.com>
References: <1283877955-19105-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Jan=20Kr=C3=BCger?= <jk@jk.gs>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 07 18:51:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ot1O7-0004K7-G2
	for gcvg-git-2@lo.gmane.org; Tue, 07 Sep 2010 18:51:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932191Ab0IGQsy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Sep 2010 12:48:54 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:41915 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932198Ab0IGQsu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Sep 2010 12:48:50 -0400
Received: by mail-wy0-f174.google.com with SMTP id 22so4442067wyf.19
        for <git@vger.kernel.org>; Tue, 07 Sep 2010 09:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=mv8IgfQLWHoHgyH8Zf/SXtXnFnzEjmT+7HkpbcjpW4k=;
        b=iBVPre4cq0+32s0bOHaiUEJOgZ6GbAkePGN6q6AmcaU/EXlQEK3Y8UD3DGcmpqmt6p
         L7ubtV7/BtrzcKOJKqRzO0yQZIxSCN5ZG7lf5U9bzyxCVxFGqSRcR5u6WGs/XmSvkNTB
         546QXAO7lQxPzfMuoCJAR0ahwlgbj/rHh8jx4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=GA+kSptEQ8AcIpVEqgjyGyKOovpyZl9sattKo8Ly/p6fSdfKURjT49Fw4lTQ7zJ2oj
         gGU6EF8ftuPAggY99cN32yXFlaEr16Aqcawsc+LJY3l7E/asj5a9yrucUVOorKO8vokm
         g3krKazJ1moUMmRjvLTWEPiWskxqgV/dos8go=
Received: by 10.227.131.68 with SMTP id w4mr295491wbs.225.1283878126378;
        Tue, 07 Sep 2010 09:48:46 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id k46sm4304936weq.34.2010.09.07.09.48.45
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 07 Sep 2010 09:48:45 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.3.313.gcd15
In-Reply-To: <1283877955-19105-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155719>

One-line `gettext $msg; echo' messages are the simplest use case for
gettext(1).

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-am.sh |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index a7185d9..bd04a15 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -93,7 +93,7 @@ go_next () {
=20
 cannot_fallback () {
 	echo "$1"
-	echo "Cannot fall back to three-way merge."
+	gettext "Cannot fall back to three-way merge."; echo
 	exit 1
 }
=20
@@ -629,7 +629,7 @@ do
=20
 	if test -z "$GIT_AUTHOR_EMAIL"
 	then
-		echo "Patch does not have a valid e-mail address."
+		gettext "Patch does not have a valid e-mail address."; echo
 		stop_here $this
 	fi
=20
@@ -680,7 +680,7 @@ do
 	    action=3Dagain
 	    while test "$action" =3D again
 	    do
-		echo "Commit Body is:"
+		gettext "Commit Body is:"; echo
 		echo "--------------------------"
 		cat "$dotest/final-commit"
 		echo "--------------------------"
--=20
1.7.2.3.313.gcd15
