From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv4 6/6] t7407: make expectation as clear as possible
Date: Tue, 29 Mar 2016 18:27:46 -0700
Message-ID: <1459301266-12403-7-git-send-email-sbeller@google.com>
References: <1459301266-12403-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, jacob.keller@gmail.com,
	Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Mar 30 03:28:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1al4vW-0004Ah-P4
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 03:28:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932304AbcC3B2A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2016 21:28:00 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:34394 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758504AbcC3B17 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2016 21:27:59 -0400
Received: by mail-pa0-f51.google.com with SMTP id fe3so27377381pab.1
        for <git@vger.kernel.org>; Tue, 29 Mar 2016 18:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PG/0p6GEsBPbgL2q2jL6y3VbIVknXLB8bj3Q7DMuptw=;
        b=Z9xSEa0q91Ke1/emQJiT6OjzerHSnxmfiPfGGbKYwuCi+xXXU2KncmGwZsFAzKypU1
         WpUL4Yp5mjFyBWx/ZR0Q+5LlVcL1FbAsDdix2nFClpGhlpD8W2eX3MBlc7WxxbSzQ7Vd
         ar2YgJvbVr27CroYhT6CSAqvHqvc9zfAkw9/V4J0CnB3bLCNBzkfPBgICJj5fPtV5Vt8
         EEN4FDEqEyokLPy1yWSaFVmTf5b9UKaOhLuYaI+up66AJaX3TdmSd5JqAgCMmLAp7D22
         htScAUHWnaIs2Cr+CrxONDWbU4bY9RnKITYC/daq14mdd9tvemicUUtg9sWcqC3ZQUrx
         RqSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PG/0p6GEsBPbgL2q2jL6y3VbIVknXLB8bj3Q7DMuptw=;
        b=WSKWXrX3shTOHPvfzyKmtNY4dyMVkgew65P0UpBQmKr8KTExMZwmMWFuWw9BZeGTPy
         6nxcs1tyaiHGlqYr2i2Fli5LooM22bcMx5swkGdcs6BO2gokPgoxBiOD+XsVccm7PQy7
         WAQcv1L0lydvON8kw3KhyV1JJuYfsT5XJz6OWx19W+d+8qDPGm7BecutX71osDm15/nS
         xh3FxWsRBPqmquC1sIVMqHNDVi1pEbt620bjgmRx1T6W0O1+GUrHu1uEAQJkM9vNoYsU
         0lHW54ypkWOiw+yZTj5ctOS7syNJqa+Sz7BwG11qLdPwxJdCU+AM9t/qfFxN0vhRfOlr
         TY5w==
X-Gm-Message-State: AD7BkJKd45KN1U2wvUapLUi4bYBsSfhwzplU9/S+usoyqNHoX4Tnv36YHgoi6zwHRNAh7FT6
X-Received: by 10.67.21.167 with SMTP id hl7mr8429800pad.16.1459301278438;
        Tue, 29 Mar 2016 18:27:58 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:9cc5:9f4:3ffe:cd1])
        by smtp.gmail.com with ESMTPSA id h85sm1126576pfj.52.2016.03.29.18.27.57
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 29 Mar 2016 18:27:57 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.2.gb331331
In-Reply-To: <1459301266-12403-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290256>

Not everyone (including me) grasps the sed expression in a split second as
they would grasp the 4 lines printed as is.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 t/t7407-submodule-foreach.sh | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/t/t7407-submodule-foreach.sh b/t/t7407-submodule-foreach.sh
index 4b35e12..6ba5daf 100755
--- a/t/t7407-submodule-foreach.sh
+++ b/t/t7407-submodule-foreach.sh
@@ -262,8 +262,12 @@ test_expect_success 'test "status --recursive"' '
 	test_cmp expect actual
 '
 
-sed -e "/nested2 /s/.*/+$nested2sha1 nested1\/nested2 (file2~1)/;/sub[1-3]/d" < expect > expect2
-mv -f expect2 expect
+cat > expect <<EOF
+ $nested1sha1 nested1 (heads/master)
++$nested2sha1 nested1/nested2 (file2~1)
+ $nested3sha1 nested1/nested2/nested3 (heads/master)
+ $submodulesha1 nested1/nested2/nested3/submodule (heads/master)
+EOF
 
 test_expect_success 'ensure "status --cached --recursive" preserves the --cached flag' '
 	(
-- 
2.8.0.2.gb331331
