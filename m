From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 4/6] t7407: make expectation as clear as possible
Date: Tue, 29 Mar 2016 15:23:46 -0700
Message-ID: <1459290228-9069-5-git-send-email-sbeller@google.com>
References: <1459290228-9069-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com, jacob.keller@gmail.com
X-From: git-owner@vger.kernel.org Wed Mar 30 00:24:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1al23U-0002JJ-Rg
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 00:24:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754449AbcC2WYD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2016 18:24:03 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:35458 "EHLO
	mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756665AbcC2WX7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2016 18:23:59 -0400
Received: by mail-pf0-f176.google.com with SMTP id n5so25456082pfn.2
        for <git@vger.kernel.org>; Tue, 29 Mar 2016 15:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Tmk1dzj9ypKw8NukU1NSP+OH8Bo6dl9mjGieWESP66I=;
        b=YJlSNB72o+gv2TT0sirv16NmmHypAIL+CQvKpQxQFH5zaW+YJmtfgRuMBDhrvCcL17
         A0N/l/19ouqnjZw7rUmM1aPXD0nr97SX2L/c0Hm8GY9gYStBYn02cX1T+mVPzt3VPmSw
         qjkvOKnnXaC5it/8mzDXrwul2xo286FwvhP0r0FSW6ysJSoo3PTcLFJ2vvsXy8igRRy5
         4d1nXkIhUMziy7SWrOjdwR+qEG24/1Ni7QMEt6fbYRPAq3qf6z2XvcL+PDfAqWJkjgbp
         LYL6vP5lPG0/2fbBc3i8Av2GV/0F/vyh8idQ+5mi3AeILc2I5Gbxo4vPzIyYvA/Rf3RL
         ZzWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Tmk1dzj9ypKw8NukU1NSP+OH8Bo6dl9mjGieWESP66I=;
        b=aOgjeCM2KTYafJ0V2KKHIoowShZAJb9rFOnfcBh8QrD7bERTzN6zjyUrxC7msYjXXc
         HGCjKhGRfTlS0QmzT4RILLyaGqNQoNPL6XWMsB0VRFBuKJHCM4uMtDyxFLtgip5mLB7B
         pgew3yYxbQLf978KwFMNw84718JwlZ6f4rx/4bKxUq8AjAl24xK3OnWByFSFrCLs2Tp4
         HMQxpvO9qmO6aLwyfRtpES9CsqP8e3yUmROXAtPhg14NRMRs2maZY6XuQ7ZStkiFmhoY
         1Fhn0qtsWn5AfmMn1qh3WvWz8cBqz3yQAiEfp3TM6YaCYW8SSdhv6Q8RjC8K1m3nmZol
         9gnA==
X-Gm-Message-State: AD7BkJKsV46YDA6lL74gTFi7jmZE87CSIe2iq+ovVqtBrmQNKXbi++ckxi/+CAhZh8pB6UV4
X-Received: by 10.98.93.1 with SMTP id r1mr7256648pfb.57.1459290239141;
        Tue, 29 Mar 2016 15:23:59 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:3dd0:2ad7:f302:a06])
        by smtp.gmail.com with ESMTPSA id ut5sm675812pab.15.2016.03.29.15.23.58
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 29 Mar 2016 15:23:58 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.4.g5639dee.dirty
In-Reply-To: <1459290228-9069-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290208>

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
2.8.0.4.g5639dee.dirty
