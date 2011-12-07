From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 10/15] t3400 (rebase): fix && chaining
Date: Thu,  8 Dec 2011 01:06:46 +0530
Message-ID: <1323286611-4806-11-git-send-email-artagnon@gmail.com>
References: <20111207100858.GB13374@elie.hsd1.il.comcast.net>
 <1323286611-4806-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 07 20:38:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYNKC-0001GW-7L
	for gcvg-git-2@lo.gmane.org; Wed, 07 Dec 2011 20:38:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757528Ab1LGTif (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Dec 2011 14:38:35 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:52491 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757154Ab1LGTie (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Dec 2011 14:38:34 -0500
Received: by mail-iy0-f174.google.com with SMTP id c1so1353523iak.19
        for <git@vger.kernel.org>; Wed, 07 Dec 2011 11:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=QoD7fooQAJMBpSxxTnCfZImumcAYfQW/Sxqf4jB+2O8=;
        b=a/OEitmG9awv91C+dpCF2xsV4tP4zLYADBBz3tqwdYj3LAt947FPUK3CH4ncLBlU/+
         KORzzsCQAKeFxQkvQErk1MrB1HXruuhsBd+9PERIMnngruT2EuHccHPGbPQrilXJm2Ez
         kB45pzXTkP+NyiLLT0j4byU5CQW+fe99iKD94=
Received: by 10.42.159.72 with SMTP id k8mr288855icx.14.1323286714018;
        Wed, 07 Dec 2011 11:38:34 -0800 (PST)
Received: from localhost.localdomain ([203.110.240.205])
        by mx.google.com with ESMTPS id ds5sm10016838ibb.5.2011.12.07.11.38.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 07 Dec 2011 11:38:33 -0800 (PST)
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1323286611-4806-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186491>

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 t/t3400-rebase.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index 6eaecec..c355533 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -172,8 +172,8 @@ test_expect_success 'fail when upstream arg is missing and not configured' '
 
 test_expect_success 'default to @{upstream} when upstream arg is missing' '
 	git checkout -b default topic &&
-	git config branch.default.remote .
-	git config branch.default.merge refs/heads/master
+	git config branch.default.remote . &&
+	git config branch.default.merge refs/heads/master &&
 	git rebase &&
 	test "$(git rev-parse default~1)" = "$(git rev-parse master)"
 '
-- 
1.7.7.3
