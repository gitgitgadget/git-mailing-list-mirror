From: Chhatoi Pritam Baral <chhatoipritam@gmail.com>
Subject: [PATCH v2] t7012: Implement test for git-checkout
Date: Sat, 26 Mar 2016 05:04:07 +0530
Message-ID: <56F5CAEF.9070906@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 26 00:36:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajbGw-0007QO-C8
	for gcvg-git-2@plane.gmane.org; Sat, 26 Mar 2016 00:36:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751868AbcCYXfT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2016 19:35:19 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35641 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751127AbcCYXfS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2016 19:35:18 -0400
Received: by mail-pf0-f195.google.com with SMTP id u190so12928110pfb.2
        for <git@vger.kernel.org>; Fri, 25 Mar 2016 16:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:subject:to:message-id:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=34RgHeoKgY4QwE3CdvtMOUa02Lwm77M/zQ7zgQvrF8Q=;
        b=ytwSZg5yBNEK+BuZr3iuNi51WdjCjsSZUNt15zD0KyMr13lzFfayJ2kNKzxA9KctRN
         SMxvS/TaAbK/F5BmCIuoCFC5nIu8LUU3dI4iFAXH7rCorEcrIPXnmZViq1vzCI0pas+M
         m/a+T4Gs4PN9m7kZlin36ZrqDdJzmxwLNCel2AAYf74GmLDmMAIQ7l2CbugRYgAhB1JP
         SEy9y22Qkd6cof+5Y+jzAK6RdYk9xl/qAfO7plHZE9dqRrM/IKgtrobs4+XEiaeyuHHm
         VvpKdkpdwF0J25MnW+Tm/Y2ug7N2+NwMtA0e0T5zi3hcPezYeJQ2g5iWaWSpQGgWKyLY
         W1Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:subject:to:message-id:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=34RgHeoKgY4QwE3CdvtMOUa02Lwm77M/zQ7zgQvrF8Q=;
        b=IaTP+b3kqU2OiJ9qIKA7AhA1/xt+2F51xtUTGr/j2p3eTNB3xuJOJ9BH1d4rPs6iMt
         mI+ST5nbv7WyuW2f0PfuUOLpO/9tBvlPcZW172M8nZI1eXKSEsIhdthpnYsEovBqCXTD
         KoR/ITJFxpbgeaJs99DUzq6G8I7j+7fdPoUt7r8aEAOMXOOQ0bMcAPlzsCYcoPo5rvuq
         6HWkXELOP/A7OP655I56RKE4pHxIoRdbFOGV0HRvFgzFcrzYnhzaJWGTyVdqvhzt2WDE
         cafQ3i1qU09QIx2zbN/l4+3wVRCYZIdeoF1aXbrbOXQ/FMUCgmslKYVvEQttYCZ7UrLi
         pmiA==
X-Gm-Message-State: AD7BkJI3HAWiNsvCBTk5LnfOMVWEhZbX0UlfIJ2KBMWhTdlBQAsDKWwgoZBWbmV8J4sJig==
X-Received: by 10.98.18.195 with SMTP id 64mr24580856pfs.131.1458948917321;
        Fri, 25 Mar 2016 16:35:17 -0700 (PDT)
Received: from [0.0.0.0] ([128.199.85.127])
        by smtp.gmail.com with ESMTPSA id y7sm18682016pfa.82.2016.03.25.16.35.15
        for <git@vger.kernel.org>
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 25 Mar 2016 16:35:16 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289971>

Previously a TODO; add a test for git-checkout skipping a
file with the skip-worktree bit set.

Signed-off-by: Chhatoi Pritam Baral <chhatoipritam@gmail.com>
---

This is a microproject for my GSoC '16 application.

Thanks, Torsten, for pointing out my mistakes. :)
It was my first time sending patches in mail (and not as attachments).

 t/t7012-skip-worktree-writing.sh | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/t/t7012-skip-worktree-writing.sh
b/t/t7012-skip-worktree-writing.sh
index 9ceaa40..276f076 100755
--- a/t/t7012-skip-worktree-writing.sh
+++ b/t/t7012-skip-worktree-writing.sh
@@ -141,6 +141,16 @@ test_expect_success 'git-clean, dirty case' '
 #TODO test_expect_failure 'git-apply removes file' false
 #TODO test_expect_failure 'git-mv to skip-worktree' false
 #TODO test_expect_failure 'git-mv from skip-worktree' false
-#TODO test_expect_failure 'git-checkout' false
+
+test_expect_success 'git-checkout ignores skip-worktree file' '
+	echo >1 &&
+	git commit -m "Add files" &&
+	echo dirty >1 &&
+	echo dirty >2 &&
+	git update-index --skip-worktree 1 &&
+	git checkout -- . &&
+	grep -q dirty 1 &&
+	test_must_fail grep -q dirty 2
+'
  test_done
-- 
2.7.4
