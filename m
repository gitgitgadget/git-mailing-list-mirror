From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH] t7811 (grep-open): remove test_config() redefinition
Date: Tue, 19 Mar 2013 16:13:14 +0530
Message-ID: <1363689794-25974-1-git-send-email-artagnon@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 19 11:42:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHu00-0008Ri-Vu
	for gcvg-git-2@plane.gmane.org; Tue, 19 Mar 2013 11:42:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750799Ab3CSKmF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Mar 2013 06:42:05 -0400
Received: from mail-pb0-f50.google.com ([209.85.160.50]:61248 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750765Ab3CSKmE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Mar 2013 06:42:04 -0400
Received: by mail-pb0-f50.google.com with SMTP id up1so323548pbc.9
        for <git@vger.kernel.org>; Tue, 19 Mar 2013 03:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:subject:date:message-id:x-mailer;
        bh=LhFEjqJG8IRRe+Wwa7rvqa30b34OCP1Qqu0/H37c0Gg=;
        b=NPjc1ZOKabD0SAE8EcEz9mHTUdv3yjA9ratyBukJT6IV29es97K3iYza2RJN9cIivC
         xkaUAOPngxScpXm4R9qVXSjuhlXseqBKOu7Wo5KB03LCcecQDDopFNJQMBRUd12mokcu
         +HfVtTdjOGqwlP3iKkwJW5kHz3Kr+l4qWB/+aDRqn7nGGSobN6w1Q9g0hA20TjX3Zjob
         gMgfqsMTsUAt76172hDAHaPfpAKRuaLvwiYHL8nkCTNgyLMGZXa8n0pADkp5ncaKq4vq
         nevqA+cKztArAP0uCeIh65zxc4ppVcpm5KGxkB0/AZ5YYCqGEY1D8mHdcavFz9nTR3Y0
         q0ew==
X-Received: by 10.66.192.201 with SMTP id hi9mr2459462pac.65.1363689723644;
        Tue, 19 Mar 2013 03:42:03 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPS id i9sm12145064paa.7.2013.03.19.03.42.01
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 19 Mar 2013 03:42:02 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218498>

test_config() is already a well-defined function in
test-lib-functions.sh.  Don't duplicate it unnecessarily.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Found this while randomly grep'ping around.

 t/t7811-grep-open.sh | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/t/t7811-grep-open.sh b/t/t7811-grep-open.sh
index a895778..e1951a5 100755
--- a/t/t7811-grep-open.sh
+++ b/t/t7811-grep-open.sh
@@ -125,11 +125,6 @@ test_expect_success 'modified file' '
 	test_cmp empty out
 '
 
-test_config() {
-	git config "$1" "$2" &&
-	test_when_finished "git config --unset $1"
-}
-
 test_expect_success 'copes with color settings' '
 	rm -f actual &&
 	echo grep.h >expect &&
-- 
1.8.2
