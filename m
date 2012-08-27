From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v3 2/7] Fix tests under GETTEXT_POISON on git-stash
Date: Tue, 28 Aug 2012 06:59:12 +0800
Message-ID: <4e2f6d25bc4588f478bb3b6866290f2feabc03d0.1346108242.git.worldhello.net@gmail.com>
References: <cover.1346108242.git.worldhello.net@gmail.com>
 <1954d94a032f1cedee953a7db5da8f6d37e4c7d9.1346108242.git.worldhello.net@gmail.com>
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
	id 1T68HN-0007km-3u
	for gcvg-git-2@plane.gmane.org; Tue, 28 Aug 2012 00:59:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754893Ab2H0W7Y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Aug 2012 18:59:24 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:61072 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753150Ab2H0W7X (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2012 18:59:23 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr13so8239394pbb.19
        for <git@vger.kernel.org>; Mon, 27 Aug 2012 15:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=Yo02gKhH3j+BB5YXzYPc1N1nPcLQdgN8R1Qm3MNRU0s=;
        b=fYPiaSRMu692qu6HPX1xl4RVhRcv71ePJ5GCmCyknz3QjSbZmBVGtQszApMwZNVJzY
         Tk3mMOLex04VjOTYQVQzVxITf68QrDKeZOOMzgJ6+r5HUZRi2Vamp4B9Ygzw/9xJb575
         iA0sn7F7pbj4sLuWu27ex+unusOhJa1ZfvSnpUOP3Ab5En+omZMbrGAa6uz0WD6RnRBG
         7kJdL9s/hGpwB931Znqfr8t0POvz8wcxfr6PAENoMwHV4zLikenAl1K+ff8HJn/gxq1I
         KB+R3fVhz6RhUplcqmGkO5dXNljepvybwN0NAmNEcoWrrFJgg9ia+OJNxFVAOqlynW0l
         uBwA==
Received: by 10.68.234.6 with SMTP id ua6mr38122211pbc.117.1346108363485;
        Mon, 27 Aug 2012 15:59:23 -0700 (PDT)
Received: from localhost.foo.bar ([123.115.151.199])
        by mx.google.com with ESMTPS id qn13sm15577687pbb.71.2012.08.27.15.59.20
        (version=SSLv3 cipher=OTHER);
        Mon, 27 Aug 2012 15:59:22 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.92.g949df84
In-Reply-To: <1954d94a032f1cedee953a7db5da8f6d37e4c7d9.1346108242.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1346108242.git.worldhello.net@gmail.com>
References: <cover.1346108242.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204378>

Use i18n-specific test functions in test scripts for git-stash.
This issue was was introduced in v1.7.4.1-119-g355ec:

    355ec i18n: git-status basic messages

and been broken under GETTEXT_POISON=3DYesPlease since.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t3903-stash.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index cd0426..5dfbd 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -610,7 +610,7 @@ test_expect_success 'stash apply shows status same =
as git status (relative to cu
 		git stash apply
 	) |
 	sed -e 1,2d >actual && # drop "Saved..." and "HEAD is now..."
-	test_cmp expect actual
+	test_i18ncmp expect actual
 '
=20
 cat > expect << EOF
--=20
1.7.12.92.g949df84
