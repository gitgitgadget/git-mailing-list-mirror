From: Stefan Beller <sbeller@google.com>
Subject: [PATCH] t7300: mark test with SANITY
Date: Tue,  3 May 2016 11:54:32 -0700
Message-ID: <1462301672-20866-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, peff@peff.net, janx@linux.com,
	Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue May 03 20:54:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axfSy-0004MZ-La
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 20:54:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934334AbcECSyh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2016 14:54:37 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:36478 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933291AbcECSyg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 14:54:36 -0400
Received: by mail-pa0-f50.google.com with SMTP id bt5so13365865pac.3
        for <git@vger.kernel.org>; Tue, 03 May 2016 11:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=vrS/uQvG4WhPfgbQAyN33X45vwc65j1qLQGtZpuMrFM=;
        b=EdnTxJyJzZnIbYbTewBAlcT0vCzkMXjH8ET0C4bsSssBuffEJlW2mSRb8FmcHG8TtK
         E2+Kq8w2Hb5zZs3mg/qRj7HZrvtfczCTD6u/yQFckyi4dTNO5dqTPFsgX7PeO78XmWev
         iBFSvg0gclV7Ye6IlZJycGpjoRsytU2RznX6PE/iFRArHp9WTCEvxcf8OmCGVFo6Iojo
         uxziz7fYmI2hpMIrF1Ll076paOZ4E1RcXef8VnfdFfxGBhoqMOGKpMjzVEYsO12kv3DD
         Le6qCwL7Qu95vGYphBxxaC2BRYehCmM3ThZ1oWf9bABJBo3TFg8cDLFTKP7EpPzj9n2a
         IHGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vrS/uQvG4WhPfgbQAyN33X45vwc65j1qLQGtZpuMrFM=;
        b=BOc2nq0k9g+ckcSccDTgsng7+oa+I2H1tW6v5OvzaH9puX/BcA5I4U55KtL0BsmukF
         e/9G2Lz5Dp8TsuHrQKrj6QfhMDU/PH3tNxUItWXYdX1bFSPjnph6fTNNa52WvbC6Cj9j
         5BQ+tYXgtoyI8QHH4fOx1aPqOkzaao2xiD5z6S+OhJ7h0TkCSRT4WZr2SGOUU+F4mhiI
         Lpf/iGF4Dcc07aV+P0yhrVq0poAMA94KlcljuyO7r70zxV47Iq9vlAHiCtuvAHgcoqEl
         W9X8goOGECnhQp81AuZyLCW9KUvJoh8vLkpjBh1TochmqK3ASLBatN2wafd6i+5KKc0Z
         pxvg==
X-Gm-Message-State: AOPr4FWJ3vxpOwNfldmaeUa37V4Q1HqRusro4vILgeOmDQwQnRqLWK9fXp0c3cSYsfRE/IeM
X-Received: by 10.66.148.42 with SMTP id tp10mr5854008pab.159.1462301675440;
        Tue, 03 May 2016 11:54:35 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:81d8:5415:7a03:cda9])
        by smtp.gmail.com with ESMTPSA id 28sm596759pfr.89.2016.05.03.11.54.34
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 03 May 2016 11:54:34 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.37.gb114fff.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293435>

As the test runs `chmod 0` on a file, we don't want to run that test
as root.

Reported-by: Jan Keromnes <janx@linux.com>
Fix-proposed-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 t/t7300-clean.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
index 86ceb38..b89fd2a 100755
--- a/t/t7300-clean.sh
+++ b/t/t7300-clean.sh
@@ -495,7 +495,7 @@ test_expect_success 'should not clean submodules' '
 	test_path_is_missing to_clean
 '
 
-test_expect_success POSIXPERM 'should avoid cleaning possible submodules' '
+test_expect_success POSIXPERM,SANITY 'should avoid cleaning possible submodules' '
 	rm -fr to_clean possible_sub1 &&
 	mkdir to_clean possible_sub1 &&
 	test_when_finished "rm -rf possible_sub*" &&
-- 
2.8.0.37.gb114fff.dirty
