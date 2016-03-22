From: izabera <izaberina@gmail.com>
Subject: [PATCH] (exit 1) is silly
Date: Tue, 22 Mar 2016 16:47:51 +0100
Message-ID: <1458661671-3793-1-git-send-email-izaberina@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 22 16:49:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiOYY-0000fu-A2
	for gcvg-git-2@plane.gmane.org; Tue, 22 Mar 2016 16:49:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751836AbcCVPtP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2016 11:49:15 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:35796 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751365AbcCVPtO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2016 11:49:14 -0400
Received: by mail-wm0-f53.google.com with SMTP id l68so159269574wml.0
        for <git@vger.kernel.org>; Tue, 22 Mar 2016 08:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id;
        bh=/nGERP4RmWNetCFeU3AOSy0LEI59/caaH+c+IqSukI0=;
        b=vu9juoROr95U8jnsdF+GfhNOpln6toEMhhT8oon7bzQeF+GNIeJrakh5r2D9UVgTcG
         3ySoVVLd92uPoyw8uxEsr69qgZj7v/MAwcHhF14W7LLoSEBK3f2b5NpByN2Cv+IM6yGQ
         obgXW9ROjbQNBOURwn4TgaLnmo0tTa6XUbB/bgEmb/HyiaibUbHi8sc5/1F9mLfQE3Or
         yePtsRQiesIDTU/vtEKuwS0Mq8L7FEsDKr+YJeGm1T1+tavSKw11RGk4142An04c5+Dt
         6zLiJOe5ovRZUF2H2eSZDJYreG3Ko6OECfoTlP6Vr5bBmQf93fbUt0cugECh8Slx3ZC0
         Wyfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=/nGERP4RmWNetCFeU3AOSy0LEI59/caaH+c+IqSukI0=;
        b=fOu/spZ49nL0VFfxEUqTaxaL0PTJ7CF/jkC2tMR3uWnIXU9xg7nqGCGYcTZ4w3cvqP
         BMBSbirJqiE8jvXu/nTfQQWe0Igs/M2ssIC1TPFoceUU1QSzW7t3HTfYr6ySQ1QdkKoU
         wEo6NRFORBk44g3OnnviWIrRoN+job2f0EAXEUcy96Q7hJVQc6PHDWEpBK2a+tmHxIyS
         4MhTQkzNRq7k4hSdhuDk/WkEfwu9lKf0w4fuE6NSN4ncZ60ef3jVwARDffjIgm6KctiV
         f5tLPpzVu8JXYgTnaHuPzBbIti8RSrfVPQKTpFqhW9NOsK0pqKZSYSrTwPKc8BxFsLlZ
         Vayg==
X-Gm-Message-State: AD7BkJJhiKxCDq7fAQNElTIZo0Y4/mk29FahPMRETwZFep8CHNlpsPYMFrrQWZgXGHzOQA==
X-Received: by 10.28.227.130 with SMTP id a124mr18892478wmh.2.1458661752313;
        Tue, 22 Mar 2016 08:49:12 -0700 (PDT)
Received: from notebook ([95.236.26.232])
        by smtp.gmail.com with ESMTPSA id hx10sm30839189wjb.25.2016.03.22.08.49.10
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Mar 2016 08:49:11 -0700 (PDT)
Received: by notebook (sSMTP sendmail emulation); Tue, 22 Mar 2016 16:47:51 +0100
X-Mailer: git-send-email 2.7.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289509>

Signed-off-by: izabera <izaberina@gmail.com>
---
 GIT-VERSION-GEN | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
index b5072a2..17b6ef4 100755
--- a/GIT-VERSION-GEN
+++ b/GIT-VERSION-GEN
@@ -14,7 +14,7 @@ then
 elif test -d ${GIT_DIR:-.git} -o -f .git &&
 	VN=$(git describe --match "v[0-9]*" --abbrev=7 HEAD 2>/dev/null) &&
 	case "$VN" in
-	*$LF*) (exit 1) ;;
+	*$LF*) false ;;
 	v[0-9]*)
 		git update-index -q --refresh
 		test -z "$(git diff-index --name-only HEAD --)" ||
-- 
2.7.4
