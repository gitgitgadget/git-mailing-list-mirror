From: Alexey Shumkin <Alex.Crezoff@gmail.com>
Subject: [PATCH v8 2/5] t7102 (reset): don't hardcode SHA-1 in expected outputs
Date: Tue,  2 Jul 2013 03:19:01 +0400
Message-ID: <569203880cc1c0f5405c5b54efa5ffd8a4907c6b.1372719264.git.Alex.Crezoff@gmail.com>
References: <cover.1372719264.git.Alex.Crezoff@gmail.com>
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Alexey Shumkin <Alex.Crezoff@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 02 01:19:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UtnNm-0007Lt-Gz
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jul 2013 01:19:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755609Ab3GAXT3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jul 2013 19:19:29 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:63855 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755438Ab3GAXTR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jul 2013 19:19:17 -0400
Received: by mail-lb0-f174.google.com with SMTP id x10so2857683lbi.5
        for <git@vger.kernel.org>; Mon, 01 Jul 2013 16:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rarus.ru; s=google;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references;
        bh=Dn9n2nKIbvo1wyKxfEX0Yd56Cc4Y0GndEzjWb9AxMhY=;
        b=p/HPTJJzqOqN1/pL/cYBidfO4LwG3QEXSdo7tRmNSJ0a1RyxDcGGFsWmLWG4pazF2J
         ocmbHn1zlhT2XcOn+SSk3nHxCYPDOUAUIEogZop6/DFuzNZnGUVVwqHcdf/ld/fl6+MH
         EA/NIza8WH/GIWAH+U1bT0hd/ELtrUbkoNcCc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references;
        bh=Dn9n2nKIbvo1wyKxfEX0Yd56Cc4Y0GndEzjWb9AxMhY=;
        b=WCCtRACjPvQckNbEr0FHk+7BjHeY+UsTpEtioe5+iaES2GE54w9pnzrYlk4K9VQ38n
         7ZAIle4M7AGQLJPZ7gSGu0GVBwUhyqnrmwbFshi6OPsWPZczQO+6AASDlvdW41fPhKO1
         4Jd4GvhvISQPs7VsL72+Kmw0zyy4LY5AxmY90VSlrHr3t2gENhFakpwls+cuo30Idume
         Qs51tMCPXEPgg3UYAhjjjve8odF+Gns6WFlp3uS5SwTFsJ8vp2NxEHBzygI52vg9OELX
         KqhVTvGRRcttsnKq4A22Pf98l8R3qNYsksqbcBM/6e12I7TiuRf2vJ7H/t5L130BKZNV
         lzag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references:x-gm-message-state;
        bh=Dn9n2nKIbvo1wyKxfEX0Yd56Cc4Y0GndEzjWb9AxMhY=;
        b=E3hKIhg3Xabr8gBssDWwBZPODKMWpqJHtkCCxbulDMmxh6gvE37jW5QAhypqkn+OE0
         /529DX9czmS+uPlv+MJffa0gU/2BDlBzqzCLzScA44Ca1ttyZXBkD0+r25mzNtGqrxn4
         DAAuXF4LLFL3TvKzk4rbSfglZxrZdlJs1XwkK0UIn50zop2ACRFNpHFwlIo+a09nrXM9
         Ig87D6kSFOApebOopwcc3ZP4HIPoSJW3qmob2QmR/Jyhd1G8nhqnSMsqYTKFTNGvRC4R
         j45S15FbJQ1Usyb/ESBXrv5zYuJo/uRG2kwXZ9P803T/ur08D2Mu3hIo4icxs+BJC7Lf
         FAPg==
X-Received: by 10.152.27.137 with SMTP id t9mr13174693lag.28.1372720756207;
        Mon, 01 Jul 2013 16:19:16 -0700 (PDT)
Received: from localhost (ppp91-77-20-158.pppoe.mtu-net.ru. [91.77.20.158])
        by mx.google.com with ESMTPSA id v18sm7883182lbd.5.2013.07.01.16.19.14
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 01 Jul 2013 16:19:15 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.16.gce2c52e
In-Reply-To: <cover.1372719264.git.Alex.Crezoff@gmail.com>
In-Reply-To: <cover.1372719264.git.Alex.Crezoff@gmail.com>
References: <cover.1372240998.git.Alex.Crezoff@gmail.com> <cover.1372719264.git.Alex.Crezoff@gmail.com>
X-Gm-Message-State: ALoCoQn+WATFhlblDMTVL5JcX2f8qiTGzcKCxMFDdLpxY7UGnHlaIipoWV2Si9/CB86AZvziAQNF
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229350>

The expected SHA-1 digests are always available in variables. Use
them instead of hardcoding.

Signed-off-by: Alexey Shumkin <Alex.Crezoff@gmail.com>
---
 t/t7102-reset.sh | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/t/t7102-reset.sh b/t/t7102-reset.sh
index df82ec9..05dfb27 100755
--- a/t/t7102-reset.sh
+++ b/t/t7102-reset.sh
@@ -192,7 +192,8 @@ test_expect_success \
 	'changing files and redo the last commit should succeed' '
 	echo "3rd line 2nd file" >>secondfile &&
 	git commit -a -C ORIG_HEAD &&
-	check_changes 3d3b7be011a58ca0c179ae45d94e6c83c0b0cd0d &&
+	head4=$(git rev-parse --verify HEAD) &&
+	check_changes $head4 &&
 	test "$(git rev-parse ORIG_HEAD)" = \
 			$head5
 '
@@ -211,7 +212,7 @@ test_expect_success \
 	git reset --hard HEAD~2 &&
 	check_changes ddaefe00f1da16864591c61fdc7adb5d7cd6b74e &&
 	test "$(git rev-parse ORIG_HEAD)" = \
-			3d3b7be011a58ca0c179ae45d94e6c83c0b0cd0d
+			$head4
 '
 
 >.diff_expect
@@ -326,10 +327,11 @@ test_expect_success '--hard reset to HEAD should clear a failed merge' '
 	git checkout branch2 &&
 	echo "3rd line in branch2" >>secondfile &&
 	git commit -a -m "change in branch2" &&
+	head3=$(git rev-parse --verify HEAD) &&
 
 	test_must_fail git pull . branch1 &&
 	git reset --hard &&
-	check_changes 77abb337073fb4369a7ad69ff6f5ec0e4d6b54bb
+	check_changes $head3
 '
 
 >.diff_expect
-- 
1.8.3.1.16.gce2c52e
