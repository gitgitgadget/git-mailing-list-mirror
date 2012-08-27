From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v3 1/7] Fix tests under GETTEXT_POISON on relative dates
Date: Tue, 28 Aug 2012 06:59:11 +0800
Message-ID: <1954d94a032f1cedee953a7db5da8f6d37e4c7d9.1346108242.git.worldhello.net@gmail.com>
References: <cover.1346108242.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 28 00:59:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T68HM-0007km-Jb
	for gcvg-git-2@plane.gmane.org; Tue, 28 Aug 2012 00:59:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754888Ab2H0W7V convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Aug 2012 18:59:21 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:46816 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753150Ab2H0W7U (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2012 18:59:20 -0400
Received: by dady13 with SMTP id y13so2857009dad.19
        for <git@vger.kernel.org>; Mon, 27 Aug 2012 15:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=ASyXt/M6rsiexsCtK1wdfDwjn76PziG2Jptq2ZF7MJs=;
        b=a3QGibEH4ICwBpFoASEwLD8fCgFWb+b1CHHd88PjBXD5KbyMqc0J+sHGgf9xIVnHXH
         QVMOQXQ/82ys5hcIj+hYdtg6zxxFGsZW0dpgilfNkwtmvlFN5yn1I6Ju6Z7dn7W16LAD
         4HjPjqX1FhyxNoukkrTW5p5MPbXJH3cZYB1qvGwZwntDNnxEzgjDOCt16o09iSLfoy/s
         +FVTvyqfv3GoK32FN07cVzqsvdjzPVu0cTtz/Nxw3f7carNR4KZEQfm78N/jy8CEJ+Nj
         7zLHiaUM42JrtOXf4Wk9+pt9w+4GgGV14/3Nx2qpNiZHEQXXjKZZ94fBPVZ+Rw5xXt22
         xmLg==
Received: by 10.68.190.8 with SMTP id gm8mr504300pbc.74.1346108360291;
        Mon, 27 Aug 2012 15:59:20 -0700 (PDT)
Received: from localhost.foo.bar ([123.115.151.199])
        by mx.google.com with ESMTPS id qn13sm15577687pbb.71.2012.08.27.15.59.17
        (version=SSLv3 cipher=OTHER);
        Mon, 27 Aug 2012 15:59:19 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.92.g949df84
In-Reply-To: <cover.1346108242.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1346108242.git.worldhello.net@gmail.com>
References: <cover.1346108242.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204379>

Use a i18n-specific test_i18ncmp in t/t0006-date.sh for relative dates
tests. This issue was was introduced in v1.7.10-230-g7d29a:

    7d29a i18n: mark relative dates for translation

and been broken under GETTEXT_POISON=3DYesPlease since.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t0006-date.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t0006-date.sh b/t/t0006-date.sh
index 1d29..e53cf 100755
--- a/t/t0006-date.sh
+++ b/t/t0006-date.sh
@@ -11,7 +11,7 @@ check_show() {
 	echo "$t -> $2" >expect
 	test_expect_${3:-success} "relative date ($2)" "
 	test-date show $t >actual &&
-	test_cmp expect actual
+	test_i18ncmp expect actual
 	"
 }
=20
--=20
1.7.12.92.g949df84
