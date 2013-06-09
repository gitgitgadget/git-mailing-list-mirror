From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 45/45] tests: update topology tests
Date: Sun,  9 Jun 2013 11:40:57 -0500
Message-ID: <1370796057-25312-46-git-send-email-felipe.contreras@gmail.com>
References: <1370796057-25312-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 09 18:45:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ulijt-0007i7-CY
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 18:45:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752667Ab3FIQpA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 12:45:00 -0400
Received: from mail-ob0-f169.google.com ([209.85.214.169]:64649 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751667Ab3FIQo6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 12:44:58 -0400
Received: by mail-ob0-f169.google.com with SMTP id up14so9040176obb.0
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 09:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=cQAQsrxDG0Nt0Ef0Bao644MAJJycQ6cTV9e8GdY9Rf4=;
        b=tMfPhrbl8Y1UDjhOt1dexeizp7cug1onpz6WskMCnuOeWcn/EtULtOsFxQ6g8Ibv9M
         /W/Iw1ozf9gf/wxLZNSQCCrLtyhNJMcPoXeQZfU35Q/xATNzGjgyaE1zLZYJKJ8Enyod
         2Qz/9MBfJAE88c3PW35pKHpLDOXZp/bk06VJgo877SG3dcvCa65fmj0iFcSYooFcne08
         nRMQFUYaZWoorKjmMv/4ZyHbsplIAyWX7mvdXdDdT76gEQ6pdbDUv2dgZS8UwK6li9Tg
         GTqe1k5vNkBFQp/0VuHPJMmFkgRJ0iC05ZJCQ7tz/yGsXVa7ExW+5Z+m1q1XlLc4HHAK
         hlHw==
X-Received: by 10.60.125.72 with SMTP id mo8mr5234017oeb.11.1370796297875;
        Sun, 09 Jun 2013 09:44:57 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id wz1sm14953626obc.3.2013.06.09.09.44.56
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 09 Jun 2013 09:44:57 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.698.g079b096
In-Reply-To: <1370796057-25312-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227014>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t3425-rebase-topology-merges.sh | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/t/t3425-rebase-topology-merges.sh b/t/t3425-rebase-topology-merges.sh
index 5400a05..96cc479 100755
--- a/t/t3425-rebase-topology-merges.sh
+++ b/t/t3425-rebase-topology-merges.sh
@@ -70,9 +70,8 @@ test_run_rebase () {
 		test_linear_range "\'"$expected"\'" d..
 	"
 }
-#TODO: make order consistent across all flavors of rebase
-test_run_rebase success 'e n o' ''
-test_run_rebase success 'e n o' -m
+test_run_rebase success 'n o e' ''
+test_run_rebase success 'n o e' -m
 test_run_rebase success 'n o e' -i
 
 test_run_rebase () {
@@ -87,9 +86,8 @@ test_run_rebase () {
 		test_linear_range "\'"$expected"\'" c..
 	"
 }
-#TODO: make order consistent across all flavors of rebase
-test_run_rebase success 'd e n o' ''
-test_run_rebase success 'd e n o' -m
+test_run_rebase success 'd n o e' ''
+test_run_rebase success 'd n o e' -m
 test_run_rebase success 'd n o e' -i
 
 test_run_rebase () {
@@ -104,9 +102,8 @@ test_run_rebase () {
 		test_linear_range "\'"$expected"\'" c..
 	"
 }
-#TODO: make order consistent across all flavors of rebase
-test_run_rebase success 'd e n o' ''
-test_run_rebase success 'd e n o' -m
+test_run_rebase success 'd n o e' ''
+test_run_rebase success 'd n o e' -m
 test_run_rebase success 'd n o e' -i
 
 test_expect_success "rebase -p is no-op in non-linear history" "
-- 
1.8.3.698.g079b096
