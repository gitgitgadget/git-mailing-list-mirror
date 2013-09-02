From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 2/4] t: rev-parse-parents: fix weird ! notation
Date: Mon,  2 Sep 2013 01:30:37 -0500
Message-ID: <1378103439-3225-3-git-send-email-felipe.contreras@gmail.com>
References: <1378103439-3225-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 02 08:35:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGNja-0003jJ-7V
	for gcvg-git-2@plane.gmane.org; Mon, 02 Sep 2013 08:35:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755609Ab3IBGf2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Sep 2013 02:35:28 -0400
Received: from mail-oa0-f51.google.com ([209.85.219.51]:35394 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755120Ab3IBGf2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Sep 2013 02:35:28 -0400
Received: by mail-oa0-f51.google.com with SMTP id h1so4725083oag.38
        for <git@vger.kernel.org>; Sun, 01 Sep 2013 23:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6PWG3tThxXpFuQnKGXS5x35+LCotGfdAwe6nn7Gkz3M=;
        b=obkIGhNoO0YZ4Th+krMjOdqwgY1VQFbPDgZGFG65NKYCVyzGimdwVzmmaa0ct51MvH
         NotLeczE8OuCRxqv+JMU3R+zvVIT9RVcBoW+fMjSuYN8CsE7sThPKyCUWcwbBqIR4x4P
         KRNEqXrHwdw+n6OjvnVGnNAXaIeQngQTBlOcum/BBc6fVQPFJw3LBCGolqIsta23Q9oE
         3T3ZMN/epwOPjGZ6t2PLMYT6H8tokKBbq0/HORtMo81cK48HD8qn7zGcKxVH7tyzbvqH
         AhH6leM8t9AwqpClNtaEIuI+/DNrfu5lN4n7BvuNws/m72qf98JDEHS8GZlx+dKnIv+q
         i/fQ==
X-Received: by 10.60.62.4 with SMTP id u4mr15902431oer.35.1378103727483;
        Sun, 01 Sep 2013 23:35:27 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id ru3sm11966390obc.2.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 01 Sep 2013 23:35:26 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-338-gefd7fa6
In-Reply-To: <1378103439-3225-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233612>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t6101-rev-parse-parents.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t6101-rev-parse-parents.sh b/t/t6101-rev-parse-parents.sh
index bead4d7..c10580c 100755
--- a/t/t6101-rev-parse-parents.sh
+++ b/t/t6101-rev-parse-parents.sh
@@ -26,7 +26,7 @@ test_expect_success 'start^0' '
 '
 
 test_expect_success 'start^1 not valid' '
-	if git rev-parse --verify start^1; then false; else :; fi
+	test_must_fail git rev-parse --verify start^1
 '
 
 test_expect_success 'second^1 = second^' '
@@ -50,7 +50,7 @@ test_expect_success 'final^1^2 != final^1^1' '
 '
 
 test_expect_success 'final^1^3 not valid' '
-	if git rev-parse --verify final^1^3; then false; else :; fi
+	test_must_fail git rev-parse --verify final^1^3
 '
 
 test_expect_success '--verify start2^1' '
-- 
1.8.4-338-gefd7fa6
