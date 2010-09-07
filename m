From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 17/20] gettextize: git-am clean_abort messages
Date: Tue,  7 Sep 2010 16:48:31 +0000
Message-ID: <1283878113-19533-8-git-send-email-avarab@gmail.com>
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
X-From: git-owner@vger.kernel.org Tue Sep 07 18:51:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ot1OD-0004K7-O4
	for gcvg-git-2@lo.gmane.org; Tue, 07 Sep 2010 18:51:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932186Ab0IGQuW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Sep 2010 12:50:22 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:40094 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932144Ab0IGQuT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Sep 2010 12:50:19 -0400
Received: by ewy23 with SMTP id 23so2472965ewy.19
        for <git@vger.kernel.org>; Tue, 07 Sep 2010 09:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=g20sReN0eTJEnWt8/+Hb2OUsRZxzCdK9HZ9qb/p0yfg=;
        b=SjWooApR9X2RPXHOBWx8IVmKcvPnbLYAEEubOKpIKuINGnu247DSOhGhNfh6tCPimy
         D13MVU6rRdF03LHV9oO28IiMil/5SLZC/in8u32tqXEM4lhw2waUbh015OtNp4ZfubCc
         zm8uZPOULzk6j3fLat9kJC9s5KbdbALmzJgyc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=OMvPlFPkBmAbpjItxuCl73/AoCHGCWIMjUYueuPE+YoXL6gYWJUX039AC89rW7DPNj
         GEoNYkZfQUgLCHb81pl7YQTg8cj1lyYyta8qK7gLxz/CFURz/0V4fDvuLB7YgQ/84TFN
         LdKeTJJcoBwTzz5fdZe+aMPk1fJb5UsaVCPDs=
Received: by 10.216.238.37 with SMTP id z37mr5330weq.26.1283878200215;
        Tue, 07 Sep 2010 09:50:00 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id k46sm4304936weq.34.2010.09.07.09.49.54
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 07 Sep 2010 09:49:54 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.3.313.gcd15
In-Reply-To: <1283877955-19105-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155723>

Messages that used the clean_abort function needed both gettext(1) and
eval_gettext(). These need to be interpolated in a string like the die
and cannot_fallback messages.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-am.sh |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index 8e894e5..3403267 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -233,7 +233,7 @@ split_patches () {
 	stgit-series)
 		if test $# -ne 1
 		then
-			clean_abort "Only one StGIT patch series can be applied at once"
+			clean_abort "$(gettext "Only one StGIT patch series can be applied =
at once")"
 		fi
 		series_dir=3D`dirname "$1"`
 		series_file=3D"$1"
@@ -285,9 +285,9 @@ split_patches () {
 		;;
 	*)
 		if test -n "$parse_patch" ; then
-			clean_abort "Patch format $patch_format is not supported."
+			clean_abort "$(eval_gettext "Patch format \$patch_format is not sup=
ported.")"
 		else
-			clean_abort "Patch format detection failed."
+			clean_abort "$(gettext "Patch format detection failed.")"
 		fi
 		;;
 	esac
--=20
1.7.2.3.313.gcd15
