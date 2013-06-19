From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 1/6] t/t5528-push-default: remove redundant test_config lines
Date: Wed, 19 Jun 2013 16:41:39 +0530
Message-ID: <1371640304-26019-2-git-send-email-artagnon@gmail.com>
References: <1371640304-26019-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 19 13:15:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpGLw-00036l-F2
	for gcvg-git-2@plane.gmane.org; Wed, 19 Jun 2013 13:15:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934338Ab3FSLO4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jun 2013 07:14:56 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:40530 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933666Ab3FSLOz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Jun 2013 07:14:55 -0400
Received: by mail-pa0-f50.google.com with SMTP id fb1so4990541pad.23
        for <git@vger.kernel.org>; Wed, 19 Jun 2013 04:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=qhNN+HoZy0+/J3ToWcaNsVi8gM4Bebw1IxUgZBVWTQc=;
        b=r3ru1q1nNYaKN+68ceOyZMzOp5uF1Td864HMw/Ttu95potNDvyr3z0TvFagrISBmfN
         goCiT9ECXw7qU3yCz2dlZW1glCpDAeFOnh4aWxjwZ+cuZZZPI/shUE7wVGUIhif5MhKV
         wUEvlmdxDNzZkC3tbb/6EGmrZnbYQeYyHwzTsnIhM4w9kvtaEp5tkJ/49aW4Xu97zaw3
         0m6Si+RPtXa98gukbLcmm+8BQptJMyExBIt8OovsFioAp22OXh4O2VHb0A1VuydhPTn5
         zFp1ZCtsx3QtZ5MblCCmgGY3p5vZh7jjnOWRRoGcaS2rvy+jM0NNJsfKwC9sT/21+Us0
         19TQ==
X-Received: by 10.68.111.33 with SMTP id if1mr2322773pbb.31.1371640494817;
        Wed, 19 Jun 2013 04:14:54 -0700 (PDT)
Received: from localhost.localdomain ([122.164.211.22])
        by mx.google.com with ESMTPSA id iq2sm22746579pbb.19.2013.06.19.04.14.52
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 19 Jun 2013 04:14:54 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.454.gff6ba36
In-Reply-To: <1371640304-26019-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228384>

The line

  test_config push.default upstream

appears unnecessarily in two tests, as the final test_push_failure sets
push.default before pushing anyway.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 t/t5528-push-default.sh | 2 --
 1 file changed, 2 deletions(-)

diff --git a/t/t5528-push-default.sh b/t/t5528-push-default.sh
index 4736da8..69ce6bf 100755
--- a/t/t5528-push-default.sh
+++ b/t/t5528-push-default.sh
@@ -48,7 +48,6 @@ test_expect_success '"upstream" pushes to configured upstream' '
 test_expect_success '"upstream" does not push on unconfigured remote' '
 	git checkout master &&
 	test_unconfig branch.master.remote &&
-	test_config push.default upstream &&
 	test_commit three &&
 	test_push_failure upstream
 '
@@ -57,7 +56,6 @@ test_expect_success '"upstream" does not push on unconfigured branch' '
 	git checkout master &&
 	test_config branch.master.remote parent1 &&
 	test_unconfig branch.master.merge &&
-	test_config push.default upstream
 	test_commit four &&
 	test_push_failure upstream
 '
-- 
1.8.3.1.454.g30263f3.dirty
