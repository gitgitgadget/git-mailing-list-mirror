From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 29/51] i18n: git-submodule "[...] path is ignored" message
Date: Sun,  3 Apr 2011 16:45:53 +0000
Message-ID: <1301849175-1697-30-git-send-email-avarab@gmail.com>
References: <1301849175-1697-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 03 18:47:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6QSL-00055g-As
	for gcvg-git-2@lo.gmane.org; Sun, 03 Apr 2011 18:47:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753020Ab1DCQrA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Apr 2011 12:47:00 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:33259 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753000Ab1DCQq7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2011 12:46:59 -0400
Received: by mail-ew0-f46.google.com with SMTP id 4so1505908ewy.19
        for <git@vger.kernel.org>; Sun, 03 Apr 2011 09:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=DoB/aO1dKihtWFiKtzV2KiC0kH83FC7QLwusyOYfu0E=;
        b=XhIwqaGHh/qf3GKbhaVDpB6HU/Qz1q8X9imYj34ajSkyKfyzWxs008fRa5xPLEHOhr
         FzpYdC/Ql0PGqSSR67MdC/iaeH7WQMzrqrsmCXthCNNeRnY4MsU4BVOlofA/qZQleDVI
         ptomWmqUxPNxRsYMsRu9hhvIEz6FdBdzf8SfE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=Gi2Rt0iftkys06FcJpbM7nJ+/Sl0FTO6QvO4oOFSljITw2BFkAyJmFEzlYevs8J/KE
         1+BpygFSoI2PVkhC8XbsiPrSaBvd4RjrUm4c41oq/C05zbYKn4+UK7kaPeDX/mSMCnPx
         SfZCXvl5szHSJ6W6hdO6jEphNCSn/UWFwTJIA=
Received: by 10.213.34.136 with SMTP id l8mr1127353ebd.96.1301849218461;
        Sun, 03 Apr 2011 09:46:58 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id w59sm2750567eeh.24.2011.04.03.09.46.57
        (version=SSLv3 cipher=OTHER);
        Sun, 03 Apr 2011 09:46:58 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1301849175-1697-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170721>

Gettextize the "The following path is ignored" message. This is
explicitly tested for so we need to skip some tests with
C_LOCALE_OUTPUT.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-submodule.sh           |    6 +++---
 t/t7400-submodule-basic.sh |    2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index fceacf8..43a10e2 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -206,9 +206,9 @@ cmd_add()
=20
 	if test -z "$force" && ! git add --dry-run --ignore-missing "$path" >=
 /dev/null 2>&1
 	then
-		echo >&2 "The following path is ignored by one of your .gitignore fi=
les:" &&
-		echo >&2 $path &&
-		echo >&2 "Use -f if you really want to add it."
+		echo >&2 "$(eval_gettext "The following path is ignored by one of yo=
ur .gitignore files:
+\$path
+Use -f if you really want to add it.")"
 		exit 1
 	fi
=20
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 874279e..1911688 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -86,7 +86,7 @@ test_expect_success 'submodule add' '
 	test_cmp empty untracked
 '
=20
-test_expect_success 'submodule add to .gitignored path fails' '
+test_expect_success C_LOCALE_OUTPUT 'submodule add to .gitignored path=
 fails' '
 	(
 		cd addtest-ignore &&
 		cat <<-\EOF >expect &&
--=20
1.7.4.1
