From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] t2203: fix wrong commit command
Date: Wed, 11 Jan 2012 10:21:38 +0700
Message-ID: <1326252098-2891-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 11 04:22:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rkolf-0007W0-TM
	for gcvg-git-2@lo.gmane.org; Wed, 11 Jan 2012 04:22:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932664Ab2AKDWL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Jan 2012 22:22:11 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:59312 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932520Ab2AKDVw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jan 2012 22:21:52 -0500
Received: by iabz25 with SMTP id z25so414289iab.19
        for <git@vger.kernel.org>; Tue, 10 Jan 2012 19:21:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=iAHWQNxhO/KQ17B8O5G194BinEBvbga9XIfLEstDHvw=;
        b=K9OQsXuQPvcfzOCdXyu+FQ95Ji38DbQfzD1g6cTEXLX04RtjxIqnBhUNzU8DbyX+ZC
         MDQ5TpIB3+xMFy6oHm8gRywE7aTReQR3T4qnaoh6hTwf6JSmE2YU9q2ylSclFtN4TAWA
         zs1Qo4R/CG55pGx6ClZvQODqrygP5IytTdqYI=
Received: by 10.42.168.202 with SMTP id x10mr24117181icy.4.1326252108709;
        Tue, 10 Jan 2012 19:21:48 -0800 (PST)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id he16sm148113ibb.9.2012.01.10.19.21.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 10 Jan 2012 19:21:47 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 11 Jan 2012 10:21:39 +0700
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188320>

Add commit message to avoid commit's aborting due to the lack of
commit message, not because there are INTENT_TO_ADD entries in index.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t2203-add-intent.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t2203-add-intent.sh b/t/t2203-add-intent.sh
index 58a3299..2543529 100755
--- a/t/t2203-add-intent.sh
+++ b/t/t2203-add-intent.sh
@@ -41,7 +41,7 @@ test_expect_success 'cannot commit with i-t-a entry' =
'
 	echo frotz >nitfol &&
 	git add rezrov &&
 	git add -N nitfol &&
-	test_must_fail git commit
+	test_must_fail git commit -m initial
 '
=20
 test_expect_success 'can commit with an unrelated i-t-a entry in index=
' '
--=20
1.7.3.1.256.g2539c.dirty
