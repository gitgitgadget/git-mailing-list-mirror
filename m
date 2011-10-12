From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/3] t5403.1: simplify commit creation
Date: Wed, 12 Oct 2011 20:35:03 +1100
Message-ID: <1318412105-13595-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 12 11:35:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RDvDp-0007ow-T2
	for gcvg-git-2@lo.gmane.org; Wed, 12 Oct 2011 11:35:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751258Ab1JLJfV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 Oct 2011 05:35:21 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:51812 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751119Ab1JLJfU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Oct 2011 05:35:20 -0400
Received: by ggnv2 with SMTP id v2so486735ggn.19
        for <git@vger.kernel.org>; Wed, 12 Oct 2011 02:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=yzO3Q2KgLgsWg7KXupDUipZFZu1h2uZXSgyLpdKpiJQ=;
        b=a9SgtSsyJHtMqG2kZHGGGMqn9pwpj5Wpb7gQwBiUp0gwtHbaUvi0LrDDxbw2tFO9gH
         coruy9+e1ZJpUqw8h2qFLGxoxa4iuM5jjVCxFS32RfutUHOMLyEv2ff9USXSrmZ4aaRS
         zqGt43N+Lyu90e5cogVZ7OSfDMCE9PDeeSwBU=
Received: by 10.236.116.98 with SMTP id f62mr32385825yhh.48.1318412119845;
        Wed, 12 Oct 2011 02:35:19 -0700 (PDT)
Received: from pclouds@gmail.com (220-244-161-237.static.tpgi.com.au. [220.244.161.237])
        by mx.google.com with ESMTPS id x65sm2387854yhg.18.2011.10.12.02.35.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 12 Oct 2011 02:35:19 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 12 Oct 2011 20:35:08 +1100
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183363>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t5403-post-checkout-hook.sh |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/t/t5403-post-checkout-hook.sh b/t/t5403-post-checkout-hook=
=2Esh
index d05a913..0c126d7 100755
--- a/t/t5403-post-checkout-hook.sh
+++ b/t/t5403-post-checkout-hook.sh
@@ -9,11 +9,8 @@ test_description=3D'Test the post-checkout hook.'
 test_expect_success setup '
 	echo Data for commit0. >a &&
 	echo Data for commit0. >b &&
-	git update-index --add a &&
-	git update-index --add b &&
-	tree0=3D$(git write-tree) &&
-	commit0=3D$(echo setup | git commit-tree $tree0) &&
-	git update-ref refs/heads/master $commit0 &&
+	git add a b &&
+	git commit -m setup &&
 	git clone ./. clone1 &&
 	git clone ./. clone2 &&
 	GIT_DIR=3Dclone2/.git git branch new2 &&
--=20
1.7.3.1.256.g2539c.dirty
