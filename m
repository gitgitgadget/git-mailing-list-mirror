From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 14/14] WIP test git fetch
Date: Fri, 29 Apr 2016 16:34:47 -0700
Message-ID: <1461972887-22100-15-git-send-email-sbeller@google.com>
References: <1461972887-22100-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: dturner@twopensource.com
X-From: git-owner@vger.kernel.org Sat Apr 30 01:35:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awHwW-00010K-M1
	for gcvg-git-2@plane.gmane.org; Sat, 30 Apr 2016 01:35:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752770AbcD2XfX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2016 19:35:23 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:34154 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752737AbcD2XfO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2016 19:35:14 -0400
Received: by mail-pa0-f51.google.com with SMTP id r5so52040615pag.1
        for <git@vger.kernel.org>; Fri, 29 Apr 2016 16:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HFiVj6e/gdPCWS3f1CaP7naw03ayKo6ppSy2vDhOqwI=;
        b=oOcb/l20chKnk1f0IP4a3Wbr3x6U2iWljmCG7AAQOh8GyR5LI4UOna1zP9A52XZyPq
         H4ZzstLN4JLzUyA7D86GSVno/7CqM6bU5Zo0Q/rbaFYY9/E7dLpp2/U9aCklsHeZp+/E
         78LRBdd/e+CFMqiK+ncY1ufyUFzCoiMGUjjIbNtVBzL1q8eS0A1UxOVUbQ7NKhWj9D9B
         FslDgEVlz7tgpcswJaUoL11022C5aT6hLsBlKyP99w4fMRWoChpjJKti6XMe8NOafkec
         y/IBLYqzVoGgh8+D9QFno9lwyjhJduUGthbdqxCTmfi+STK/RLNx9NdVS9NNLipmVPxN
         iocg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HFiVj6e/gdPCWS3f1CaP7naw03ayKo6ppSy2vDhOqwI=;
        b=M9AjtaeUYonASa/wkTbX27gAB3zi1DFBhw5sbLng39Il6aha9gybHFLyCfAXPkGr1M
         UNrKPEBwYEpSm+eMnkIW1u+0iCZZyAK7bWmPVk2nirr8Nhv9RhQ9FuDLckCi1ZVg2W1k
         MAhf808ymPsKC963+ODtaDCDwqocaUjKkoJfC544s4N2ZPRCuYcmrcOJB2QGsY4Us2k/
         Kd9ur+y+URdgXgptfUQ4MxK/nm64zrPVb4kPOM/IuUejGUB5IckhzyeBK3E2vg23qE7g
         TjAbD4AvPwi69393HRi2ZcXrfhhuk6V3zoAHw8jArZnOcgSG8oQ08GMOGUd6adMjU+42
         FiDg==
X-Gm-Message-State: AOPr4FWLg1aeBYtawDV98wMa1A0/IVsWZnt5vr0nYUkt3UnvcHRWAcc+lRg6mz9rTU3tQISN
X-Received: by 10.66.153.209 with SMTP id vi17mr33117181pab.0.1461972913914;
        Fri, 29 Apr 2016 16:35:13 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:1c8a:9b5c:52bb:4ac5])
        by smtp.gmail.com with ESMTPSA id c2sm26230301pfc.40.2016.04.29.16.35.13
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 29 Apr 2016 16:35:13 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.32.g71f8beb.dirty
In-Reply-To: <1461972887-22100-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293077>

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 t/t5510-fetch.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 38321d1..ab5d3da 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -687,4 +687,9 @@ test_expect_success 'fetching with auto-gc does not lock up' '
 	)
 '
 
+test_expect_success 'fetching with transport protocol 2 works' '
+	test_pause
+	git fetch --transport-protocol=2
+'
+
 test_done
-- 
2.8.0.32.g71f8beb.dirty
