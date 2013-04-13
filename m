From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 2/3] t5521 (pull-options): use test_commit() where appropriate
Date: Sun, 14 Apr 2013 02:45:28 +0530
Message-ID: <1365887729-9630-3-git-send-email-artagnon@gmail.com>
References: <1365887729-9630-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 13 23:16:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UR7nq-0001HY-5D
	for gcvg-git-2@plane.gmane.org; Sat, 13 Apr 2013 23:16:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932124Ab3DMVPz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Apr 2013 17:15:55 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:64260 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753788Ab3DMVPy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Apr 2013 17:15:54 -0400
Received: by mail-pd0-f180.google.com with SMTP id q11so1916728pdj.25
        for <git@vger.kernel.org>; Sat, 13 Apr 2013 14:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=e0txgxP9MLXCfsDYPObWeYnP+9sv8t03gdO0R7/r/d4=;
        b=XU3Vg8FfFaijxnM7zOcDWsEU6CmdPK6u4EfEjlJ7EkKcquefsFszHibYnrxj76uEC8
         r8wRgax7uTLb1QmGVijmS9eKHDj0BEs4bGrACQkVYmy8bYwxqHsE4jIUNnd65vAMeTQj
         ymBXrOfFBKSjSo9og7DFTRqyitXOwlcqYJ/D90zeMlcSFDRWqMXtZUXz6fuqRS1AKITE
         V71snI6GvfzlFCJrs/DB23vzOBhOMW//zCO/xNff4NYpx2MqB6OKoVotbdqBjVJwY/Nc
         o5/JA4EdMJy0jjdO8EkbAUanyt6T1FTQGHsn3ZGalo1ddw+Fc+9Qf1YH6wnTcO+ijPIj
         1XEg==
X-Received: by 10.66.159.42 with SMTP id wz10mr13090851pab.219.1365887754018;
        Sat, 13 Apr 2013 14:15:54 -0700 (PDT)
Received: from localhost.localdomain ([122.164.25.24])
        by mx.google.com with ESMTPS id fb7sm15112193pab.16.2013.04.13.14.15.52
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 13 Apr 2013 14:15:53 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.392.g6943ea6
In-Reply-To: <1365887729-9630-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221072>

test_commit() is a well-defined function in test-lib-functions.sh that
allows you to create commits with a terse syntax.  Prefer using it
over creating commits by hand.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 t/t5521-pull-options.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t5521-pull-options.sh b/t/t5521-pull-options.sh
index aa31abe..3bdfe82 100755
--- a/t/t5521-pull-options.sh
+++ b/t/t5521-pull-options.sh
@@ -7,8 +7,8 @@ test_description='pull options'
 test_expect_success 'setup' '
 	mkdir parent &&
 	(cd parent && git init &&
-	 echo one >file && git add file &&
-	 git commit -m one)
+	 test_commit "one" file "one"
+	)
 '
 
 test_expect_success 'git pull -q' '
-- 
1.8.2.1.392.g6943ea6
