From: Matthieu Prat <matthieuprat@gmail.com>
Subject: [PATCH] t7060: actually test "git diff-index --cached -M"
Date: Wed,  2 Sep 2015 14:12:55 -0400
Message-ID: <1441217575-45474-1-git-send-email-matthieuprat@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Sep 02 20:13:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXCWy-0006OU-HM
	for gcvg-git-2@plane.gmane.org; Wed, 02 Sep 2015 20:13:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756017AbbIBSND convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Sep 2015 14:13:03 -0400
Received: from mail-wi0-f170.google.com ([209.85.212.170]:34054 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753774AbbIBSNA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2015 14:13:00 -0400
Received: by wicfx3 with SMTP id fx3so26197169wic.1
        for <git@vger.kernel.org>; Wed, 02 Sep 2015 11:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=AfLmHIFIyAuz5+TOxk+D6ZPfLxV09LddfwLV844fP18=;
        b=HShcj2ivtnh76uLWTJn8pAh2Lft7n8IiOZYR45WdR5NJxF80dPxYTAFAhuhRspu6tj
         g6e0nGrmqiEh3WUbcKEnm1efCt8pw98pdWjIn3OHnkxYgnJnUcsbOeq2qTROjdkNn+aZ
         6P2MBIrwTwRD6CTdFQlID0pwVBk85lRHZ2n8AXEHZuVL4lSbf6OyqZlCULBZ5gT4QpO2
         9/fWbDA6LBRf4gvvKrMteAayWT+WfCGwwhFaOcGOlaLJ7s7SakvKSmoFidF/xC8kW1K4
         gizTa4ELlVz9PTC7GN6S7/LjyNllgQ0evExE4WDYm4lgJ50sS7evnq7keuvSxr2Qi5ki
         DG1Q==
X-Received: by 10.194.87.102 with SMTP id w6mr40776911wjz.111.1441217579378;
        Wed, 02 Sep 2015 11:12:59 -0700 (PDT)
Received: from mprat.corp.nyc.dailymotion.com (static-98-116-12-46.nycmny.fios.verizon.net. [98.116.12.46])
        by smtp.googlemail.com with ESMTPSA id gk9sm4812308wib.9.2015.09.02.11.12.57
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Sep 2015 11:12:58 -0700 (PDT)
X-Mailer: git-send-email 2.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277114>

A test was designed for "git diff-index --cached -M" but the command is
run without the "-M" option (which makes the test essentially identical
to its preceding counterpart).

Give the command the option it deserves and the test a raison d'=C3=AAt=
re.

Signed-off-by: Matthieu Prat <matthieuprat@gmail.com>
---
 t/t7060-wtstatus.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t7060-wtstatus.sh b/t/t7060-wtstatus.sh
index 741ec08..32d8176 100755
--- a/t/t7060-wtstatus.sh
+++ b/t/t7060-wtstatus.sh
@@ -106,7 +106,7 @@ test_expect_success 'git diff-index --cached -M sho=
ws 2 added + 1 unmerged' '
 	A	THREE
 	A	TWO
 	EOF
-	git diff-index --cached --name-status HEAD >actual &&
+	git diff-index --cached -M --name-status HEAD >actual &&
 	test_cmp expected actual
 '
=20
--=20
2.5.0
