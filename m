From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 1/2] t/t6030-bisect-porcelain.sh: use test_i18ngrep
Date: Sat,  5 Nov 2011 17:28:42 +0000
Message-ID: <1320514123-18842-2-git-send-email-avarab@gmail.com>
References: <1320514123-18842-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jon Seymour <jon.seymour@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 05 18:29:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RMk3K-00066P-Ew
	for gcvg-git-2@lo.gmane.org; Sat, 05 Nov 2011 18:29:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753749Ab1KER27 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 5 Nov 2011 13:28:59 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:55354 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751579Ab1KER26 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Nov 2011 13:28:58 -0400
Received: by mail-fx0-f46.google.com with SMTP id o14so3682311faa.19
        for <git@vger.kernel.org>; Sat, 05 Nov 2011 10:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=7EI6q/UwURDpzsn+tZgTc/VILAzrsjVIrJdXe9nZ5Uo=;
        b=HDSKkqrzVt4G63TebW3lR33I6oYWQXLtAWuMfVSeS75jResu9GC8lJ48RtyC8ln4kF
         o65n/v7tHa01jLEULyjvGRR8M7vYbDF+f28m6FR9g/Nkq/bV4ngDYmUHwH0BFVp8SYCV
         3QLplJ1+8Ud6vvBMGCBYXD+2se9V3q9uKBWrs=
Received: by 10.223.77.66 with SMTP id f2mr32922642fak.24.1320514137628;
        Sat, 05 Nov 2011 10:28:57 -0700 (PDT)
Received: from w.nix.is (w.nix.is. [188.40.98.140])
        by mx.google.com with ESMTPS id w11sm22575710fad.7.2011.11.05.10.28.56
        (version=SSLv3 cipher=OTHER);
        Sat, 05 Nov 2011 10:28:57 -0700 (PDT)
X-Mailer: git-send-email 1.7.7
In-Reply-To: <1320514123-18842-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184869>

Change a i18n-specific grep in t/t6030-bisect-porcelain.sh to use
test_i18ngrep instead. This was introduced in v1.7.7.2~5^2~11 and has
been broken under GETTEXT_POISON=3DYesPlease since.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 t/t6030-bisect-porcelain.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index c6f1f9f..691e4a4 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -164,7 +164,7 @@ test_expect_success 'bisect start: existing ".git/B=
ISECT_START" not modified if
 	cp .git/BISECT_START saved &&
 	test_must_fail git bisect start $HASH4 foo -- &&
 	git branch > branch.output &&
-	grep "* (no branch)" branch.output > /dev/null &&
+	test_i18ngrep "* (no branch)" branch.output > /dev/null &&
 	test_cmp saved .git/BISECT_START
 '
 test_expect_success 'bisect start: no ".git/BISECT_START" if mistaken =
rev' '
--=20
1.7.7
