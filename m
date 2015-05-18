From: Stefan Beller <sbeller@google.com>
Subject: [PATCH] t1020: cleanup subdirectory tests a little
Date: Mon, 18 May 2015 11:13:37 -0700
Message-ID: <1431972817-18178-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>, Johannes.Schindelin@gmx.de,
	Jens.Lehmann@web.de, git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon May 18 20:14:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuPYA-0005aC-TT
	for gcvg-git-2@plane.gmane.org; Mon, 18 May 2015 20:14:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754044AbbERSN6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2015 14:13:58 -0400
Received: from mail-ig0-f178.google.com ([209.85.213.178]:36424 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753446AbbERSN5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2015 14:13:57 -0400
Received: by igbpi8 with SMTP id pi8so55687237igb.1
        for <git@vger.kernel.org>; Mon, 18 May 2015 11:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=LgcddGu6lPr9Fg4xGDcomYDUPU5kOQL70QPT9HQwDOk=;
        b=gzMVpz9D11B4R//U4nLxYqje76tZU6p+LkY6LdY8/2zxZtK64VMvleeETnukKSoti+
         kwv7zSEipmTYyIJqnaswvixkcVBfNy0sZLEdrQ49HnXX8Ues+IgtZeU5GqnYBwC74F3z
         06WxnNCB+HR12p3WVoAY6ybBkbJSHM5Tt/2diDaL9ExO+66erfSHb6mcSwlVo7wom7vf
         C8cd8sIgXQTCgEP3rR5BeGjCLhK1bNUCxgtTTYAGKLaNClOdN5pCb7/wjsM80IVj1wkd
         6ozfj0tbJKmxWCL8zNrCIRGo7TVfsXEO9mLz4b2jDAZ5SoS9P5uVOZ8JwQBN+ynG63Ps
         8EHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LgcddGu6lPr9Fg4xGDcomYDUPU5kOQL70QPT9HQwDOk=;
        b=Zn3SbdnhzWOm9TbAYUsbWJ4y4UuQ2/oYrGHb/aenrq0m2LXVNXmc3R9Cln9i4nGpXH
         UfJ2fu2RUAS2izBsB+fsxupGKPHFvKRpLBhOoC83vJMYrcLBUhqxehHsPegkViXk39xr
         ze523WwYFZMkvRhqyF7oVt4O+hGcsoWv53v6fVdHGQ/xb/9fgZ0rEbK8gHSyu6WEeQhN
         MTpIqRuEyTQ3N9o3UamPD2jL5gDTPrB4b+YUV0t0CmhIlqg5xJzDny6+OlsNcV6CzGti
         3orEL0UWOMOMsMVejtX5lgXgUskWrM50UY/ESWxBUkYcbrj6chy3wfUJ5EWAUy0Hdg9m
         lKwQ==
X-Gm-Message-State: ALoCoQmywzwMY1l31eNMVRg4OrLmsUmrBMowNCOvuFJs7muw84Adu5/bP0O1FJ8RdCSTnBVc4fJk
X-Received: by 10.107.41.72 with SMTP id p69mr30843830iop.58.1431972837290;
        Mon, 18 May 2015 11:13:57 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:8c3b:902d:86de:4470])
        by mx.google.com with ESMTPSA id g1sm7858484iog.4.2015.05.18.11.13.56
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 18 May 2015 11:13:56 -0700 (PDT)
X-Mailer: git-send-email 2.4.0.194.gc518059
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269291>

When looking through existing tests to point out good style I came across
t1020, which has a test commented out and the comment wasn't helping me
either of what the test should accomplish in the future. The code of the
test is the same as the test before except setting GIT_DIR=. explicitly,
so it did not ring a bell for me as well.

This removes the test, which may have been confusing readers since 2010.

Additionally moves the "rm -fr foo.git" of the next test (where it is
unrelated) to the previous test, where it makes sense as a cleanup.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 t/t1020-subdirectory.sh | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/t/t1020-subdirectory.sh b/t/t1020-subdirectory.sh
index 2edb4f2..4470ede 100755
--- a/t/t1020-subdirectory.sh
+++ b/t/t1020-subdirectory.sh
@@ -163,6 +163,7 @@ test_expect_success 'no file/rev ambiguity check inside .git' '
 '
 
 test_expect_success 'no file/rev ambiguity check inside a bare repo' '
+	test_when_finished "rm -fr foo.git" &&
 	git clone -s --bare .git foo.git &&
 	(
 		cd foo.git &&
@@ -170,17 +171,7 @@ test_expect_success 'no file/rev ambiguity check inside a bare repo' '
 	)
 '
 
-# This still does not work as it should...
-: test_expect_success 'no file/rev ambiguity check inside a bare repo' '
-	git clone -s --bare .git foo.git &&
-	(
-		cd foo.git &&
-		git show -s HEAD
-	)
-'
-
 test_expect_success SYMLINKS 'detection should not be fooled by a symlink' '
-	rm -fr foo.git &&
 	git clone -s .git another &&
 	ln -s another yetanother &&
 	(
-- 
2.4.0.194.gc518059
