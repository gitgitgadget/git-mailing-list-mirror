From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH/RFC 09/12] gettextize: git-submodule "Entering [...]" message
Date: Mon, 13 Sep 2010 22:09:15 +0000
Message-ID: <1284415758-20931-10-git-send-email-avarab@gmail.com>
References: <1284415758-20931-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Lars Hjemli <hjemli@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 14 00:10:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OvHEd-00079c-MA
	for gcvg-git-2@lo.gmane.org; Tue, 14 Sep 2010 00:10:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754172Ab0IMWKW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Sep 2010 18:10:22 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:44144 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753864Ab0IMWKT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Sep 2010 18:10:19 -0400
Received: by mail-wy0-f174.google.com with SMTP id 22so6742715wyf.19
        for <git@vger.kernel.org>; Mon, 13 Sep 2010 15:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=zdhfpIC702DLz2YsCQK9jHFfaXTev/GsthvTs6/a60Q=;
        b=LNX46M6Jg4EYFs3greePLJH+ykxZkVBTRJGaglIrx5bPiAzouufc61/U0gxDhJbLob
         Z0cq1wbO5QYawfNGDU239jMz48xPTIpkkYjv5eF/BFv2/kXbAR7kKoAogMo5qBHeoMJA
         CcM1Zr5GXD6BAGnrZX4sCDIzSVqBNwz/3ouRk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=xgXCLCvFouw7bUFkdtG0R08/cg3bKXqt3Cy3mnfOoWzmYLRNZltDRxcdD1aD+/odOZ
         d8ObR0cvj+wg/+MJT0q5iMsUiwy1BL9qVmglUvzaLLstsen/kVAHYKSmCuUGiQI8FKeg
         anE9gONv7L1xlnHRV3foorWbQz7N5fZ27/l3M=
Received: by 10.216.74.82 with SMTP id w60mr3084825wed.106.1284415818759;
        Mon, 13 Sep 2010 15:10:18 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id w14sm4296416weq.9.2010.09.13.15.10.17
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 13 Sep 2010 15:10:17 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.rc1.220.gb4d42
In-Reply-To: <1284415758-20931-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156140>

Gettextize the "Entering [...]" message. This is explicitly tested for
so we need to skip some tests with NO_GETTEXT_POISON.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-submodule.sh             |    2 +-
 t/t7407-submodule-foreach.sh |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index d453fe9..6ec6aa5 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -291,7 +291,7 @@ cmd_foreach()
 	do
 		if test -e "$path"/.git
 		then
-			say "Entering '$prefix$path'"
+			say "$(eval_gettext "Entering '\$prefix\$path'")"
 			name=3D$(module_name "$path")
 			(
 				prefix=3D"$prefix$path/"
diff --git a/t/t7407-submodule-foreach.sh b/t/t7407-submodule-foreach.s=
h
index 905a8ba..217fe55 100755
--- a/t/t7407-submodule-foreach.sh
+++ b/t/t7407-submodule-foreach.sh
@@ -68,7 +68,7 @@ Entering 'sub3'
 $pwd/clone-foo3-sub3-$sub3sha1
 EOF
=20
-test_expect_success 'test basic "submodule foreach" usage' '
+test_expect_success NO_GETTEXT_POISON 'test basic "submodule foreach" =
usage' '
 	git clone super clone &&
 	(
 		cd clone &&
@@ -153,7 +153,7 @@ Entering 'sub2'
 Entering 'sub3'
 EOF
=20
-test_expect_success 'test messages from "foreach --recursive"' '
+test_expect_success NO_GETTEXT_POISON 'test messages from "foreach --r=
ecursive"' '
 	(
 		cd clone2 &&
 		git submodule foreach --recursive "true" > ../actual
--=20
1.7.3.rc1.220.gb4d42
