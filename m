From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 09/44] request-pull: t: add missing cat
Date: Sat, 28 Sep 2013 17:03:34 -0500
Message-ID: <1380405849-13000-10-git-send-email-felipe.contreras@gmail.com>
References: <1380405849-13000-1-git-send-email-felipe.contreras@gmail.com>
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 29 00:10:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQ2id-00030Z-Rf
	for gcvg-git-2@plane.gmane.org; Sun, 29 Sep 2013 00:10:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755231Ab3I1WKZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Sep 2013 18:10:25 -0400
Received: from mail-oa0-f47.google.com ([209.85.219.47]:62056 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755207Ab3I1WKW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Sep 2013 18:10:22 -0400
Received: by mail-oa0-f47.google.com with SMTP id i1so3010246oag.20
        for <git@vger.kernel.org>; Sat, 28 Sep 2013 15:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SNrmh8hQ5MVG0ZyWnobzDy3iGVjCkhq8YMbGf7O4sdA=;
        b=zu6WVagj20pAq2lzREvELwCsAzXCDCiY072a2TscA2PZHA1yh807myu6//N82o2AQ1
         68A6GejaDmrHgY9tDVt5NmBC+GAqrlBlT0Zatsdi7XXaC8hcAc84XHtrrrkKkJ94xKP7
         WXd143DGgEc9URPPfFHwu9avFUh6i4hE7+GGOzfqHNz0M04Qn7cZ/boM46m4lCpj3V9/
         ShlNaI/HXxlPz1miDnL13u4iEIvIrThdLoh1sRfD9q0mS5uV/CGdt+buW9hut3FPqpOR
         ZEJw4pMCDxYdTLk0Ayc4rJlaw9l2n3MACJTg4pNKu4P9kjucvC+5F8fKS/vnUS+aSJD8
         fD1w==
X-Received: by 10.60.116.230 with SMTP id jz6mr12632788oeb.21.1380406222203;
        Sat, 28 Sep 2013 15:10:22 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id d3sm25421609oek.5.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 28 Sep 2013 15:10:21 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1380405849-13000-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235530>

Otherwise we wouldn't know why it failed.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t5150-request-pull.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/t5150-request-pull.sh b/t/t5150-request-pull.sh
index 9375912..60a38be 100755
--- a/t/t5150-request-pull.sh
+++ b/t/t5150-request-pull.sh
@@ -122,6 +122,7 @@ test_expect_success 'pull request when forgot to push' '
 		test_must_fail git request-pull initial "$downstream_url" \
 			2>../err
 	) &&
+	cat err &&
 	grep "No branch of.*is at:\$" err &&
 	grep "Are you sure you pushed" err
 '
-- 
1.8.4-fc
