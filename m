From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 01/11] tests: at-combinations: simplify setup
Date: Tue,  7 May 2013 16:55:01 -0500
Message-ID: <1367963711-8722-2-git-send-email-felipe.contreras@gmail.com>
References: <1367963711-8722-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 07 23:56:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZpsO-00083T-6l
	for gcvg-git-2@plane.gmane.org; Tue, 07 May 2013 23:56:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752720Ab3EGV4o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 May 2013 17:56:44 -0400
Received: from mail-gg0-f182.google.com ([209.85.161.182]:53002 "EHLO
	mail-gg0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752466Ab3EGV4l (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 May 2013 17:56:41 -0400
Received: by mail-gg0-f182.google.com with SMTP id f1so248996ggn.27
        for <git@vger.kernel.org>; Tue, 07 May 2013 14:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=E67czeAABSDla6fEMK4wpVSFZrRqznJ40u4DfO4hk+s=;
        b=vQwxvK7IYqtpV7o7AcfrcXGcGun2rB9pQUd6em8MptT6akNQ6gQakG0QwBQFKHcdWK
         F8hjp9R8PSIoFHA/WEK17tsHMg0UMmICGNBLrMIVy5ZWztAxW+QUpgJcn15tchs6yf22
         X9NViVNJiXyE+HQnoPZy860l32XNy3FRvAqzIw6S1VUuJ4gW797G96Ga6AjrkDFCnMzf
         61/Ds4zzQFnN9f0PwnKMZXa/flMosYuIW7qRAFMqL0zrV/euyF8s+Fk0xt7hYVdTmvPP
         nrvznIxnFU/jD4sTEDP7tYlMlkn49PWkgoUOTojsXSv2cIvOAmlMnvCVKpTauEDhVlDc
         epNA==
X-Received: by 10.236.119.13 with SMTP id m13mr3863057yhh.155.1367963800100;
        Tue, 07 May 2013 14:56:40 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id j27sm58402587yhf.18.2013.05.07.14.56.37
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 07 May 2013 14:56:39 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc0.401.g45bba44
In-Reply-To: <1367963711-8722-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223606>

The test is setting up an upstream branch, but there's a much simpler
way of doing that: git branch -u.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t1508-at-combinations.sh | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/t/t1508-at-combinations.sh b/t/t1508-at-combinations.sh
index d5d6244..46e3f16 100755
--- a/t/t1508-at-combinations.sh
+++ b/t/t1508-at-combinations.sh
@@ -31,10 +31,8 @@ test_expect_success 'setup' '
 	git checkout -b new-branch &&
 	test_commit new-one &&
 	test_commit new-two &&
-	git config branch.old-branch.remote . &&
-	git config branch.old-branch.merge refs/heads/master &&
-	git config branch.new-branch.remote . &&
-	git config branch.new-branch.merge refs/heads/upstream-branch
+	git branch -u master old-branch &&
+	git branch -u upstream-branch new-branch
 '
 
 check HEAD new-two
-- 
1.8.3.rc0.401.g45bba44
