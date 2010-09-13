From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH/RFC 08/12] gettextize: git-submodule $errmsg messages
Date: Mon, 13 Sep 2010 22:09:14 +0000
Message-ID: <1284415758-20931-9-git-send-email-avarab@gmail.com>
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
	id 1OvHEd-00079c-5S
	for gcvg-git-2@lo.gmane.org; Tue, 14 Sep 2010 00:10:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753814Ab0IMWKT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Sep 2010 18:10:19 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:44144 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753735Ab0IMWKQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Sep 2010 18:10:16 -0400
Received: by mail-wy0-f174.google.com with SMTP id 22so6742715wyf.19
        for <git@vger.kernel.org>; Mon, 13 Sep 2010 15:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=Ej4+wgTXiHHRVV+nkv5GDJ5EkDVuuBoK/Qo4Ei/AGjk=;
        b=xOFihin5NY5CMeDBZYDiIg04f8XBYc6+L6uW6/ukSwwaLgYw8NDYFCPdTZh/sOfiVh
         n6Nu8L2JOIaCJrtgfEa6JeunSOnImOylLH3iAm8eM+T4UkUeHnuzE0nDDrvc6uOQAcDm
         0z/7p4VSQ5Pzy7WtRiTc78D3UfEK4jFZvog60=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=L77GJxN8PPVVdUu7VQN18+qGBilvjCcFCcDJpFmMKZJ8I0CGbV/s6oDUVhrVAeHTcA
         s0OaE3Xd1/mxeh9zUYPLCI42HlS9KaLhfq1VMJjgIW1WzPq6+oZGKKlAxJz7hOwO8gfQ
         kTZK608vSy2eZy6zp/gYPLI2P9lPm8iPs00VA=
Received: by 10.216.54.73 with SMTP id h51mr3171002wec.100.1284415816220;
        Mon, 13 Sep 2010 15:10:16 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id w14sm4296416weq.9.2010.09.13.15.10.14
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 13 Sep 2010 15:10:15 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.rc1.220.gb4d42
In-Reply-To: <1284415758-20931-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156141>

Gettextize warning messages stored in the $errmsg variable using
eval_gettext interpolation. This is explicitly tested for so we need
to skip some tests with NO_GETTEXT_POISON.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-submodule.sh             |    6 +++---
 t/t7401-submodule-summary.sh |    2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 065b343..d453fe9 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -643,13 +643,13 @@ cmd_summary() {
 		total_commits=3D
 		case "$missing_src,$missing_dst" in
 		t,)
-			errmsg=3D"  Warn: $name doesn't contain commit $sha1_src"
+			errmsg=3D"$(eval_gettext "  Warn: \$name doesn't contain commit \$s=
ha1_src")"
 			;;
 		,t)
-			errmsg=3D"  Warn: $name doesn't contain commit $sha1_dst"
+			errmsg=3D"$(eval_gettext "  Warn: \$name doesn't contain commit \$s=
ha1_dst")"
 			;;
 		t,t)
-			errmsg=3D"  Warn: $name doesn't contain commits $sha1_src and $sha1=
_dst"
+			errmsg=3D"$(eval_gettext "  Warn: \$name doesn't contain commits \$=
sha1_src and \$sha1_dst")"
 			;;
 		*)
 			errmsg=3D
diff --git a/t/t7401-submodule-summary.sh b/t/t7401-submodule-summary.s=
h
index 70b2fb1..09ef760 100755
--- a/t/t7401-submodule-summary.sh
+++ b/t/t7401-submodule-summary.sh
@@ -154,7 +154,7 @@ EOF
 rm -f sm1 &&
 test_create_repo sm1 &&
 head6=3D$(add_file sm1 foo6 foo7)
-test_expect_success 'nonexistent commit' "
+test_expect_success NO_GETTEXT_POISON 'nonexistent commit' "
     git submodule summary >actual &&
     cat >expected <<-EOF &&
 * sm1 $head4...$head6:
--=20
1.7.3.rc1.220.gb4d42
