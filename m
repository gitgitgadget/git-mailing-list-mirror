From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 18/20] gettextize: git-am "Apply?" message
Date: Tue,  7 Sep 2010 16:48:32 +0000
Message-ID: <1283878113-19533-9-git-send-email-avarab@gmail.com>
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
X-From: git-owner@vger.kernel.org Tue Sep 07 18:51:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ot1OC-0004K7-Ii
	for gcvg-git-2@lo.gmane.org; Tue, 07 Sep 2010 18:51:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932142Ab0IGQuO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Sep 2010 12:50:14 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:65530 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932081Ab0IGQuM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Sep 2010 12:50:12 -0400
Received: by mail-wy0-f174.google.com with SMTP id 22so4443062wyf.19
        for <git@vger.kernel.org>; Tue, 07 Sep 2010 09:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=CvtVdQ2tsA3CyLxd9nlj5tm8w71zvxl4iX77UFR6Ldg=;
        b=mjZ2rGvHb17A6eDvA1tJUVik7JSvFRmOSnDGndtwZj0D4xq2FlvquZPdOpQ9bhFt+R
         kd7dCX17M1ZI3b68UGZnbJAv/TMMpHTiYGVAERELSdGNFAijE2yNO2pciQa47HEXSSE/
         LNUw+2HhQj6kcQqOqfUYCr6yrqRHz+EIhM3Zw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=rMyT01iRIl1tVhPEkfsljV3rDcDyzegUDAvOb6Xz90Hqrg7FYCT2q5/YoX0tgC0HLn
         cA7hGKd4BXzU42cQm8XOJyaZXl4fh5ZaYu2lyxgK8U7CT6kT+zRED/zgcF8aEy2gRhkj
         hqpONou/JVwjDilKyJgIJMqVO/iBhLBBZg1Fc=
Received: by 10.227.153.208 with SMTP id l16mr105963wbw.57.1283878211820;
        Tue, 07 Sep 2010 09:50:11 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id k46sm4304936weq.34.2010.09.07.09.50.10
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 07 Sep 2010 09:50:10 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.3.313.gcd15
In-Reply-To: <1283877955-19105-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155726>

Make the "Apply? [y]es/[n]o/[e]dit/[v]iew patch/[a]ccept all" message
translatable, and leave a note in a TRANSLATORS comment explaining
that translators have to preserve a mention of the y/n/e/v/a
characters since the program will expect them, and not their
localized equivalents.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-am.sh |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index 3403267..90f2a9d 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -684,7 +684,10 @@ To restore the original branch and stop patching r=
un \"\$cmdline --abort\"."; ec
 		echo "--------------------------"
 		cat "$dotest/final-commit"
 		echo "--------------------------"
-		printf "Apply? [y]es/[n]o/[e]dit/[v]iew patch/[a]ccept all "
+		# TRANSLATORS: Make sure to include [y], [n], [e], [v] and [a]
+		# in your translation. The program will only accept English
+		# input at this point.
+		gettext "Apply? [y]es/[n]o/[e]dit/[v]iew patch/[a]ccept all "
 		read reply
 		case "$reply" in
 		[yY]*) action=3Dyes ;;
--=20
1.7.2.3.313.gcd15
