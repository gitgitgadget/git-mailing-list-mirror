From: larsxschneider@gmail.com
Subject: [PATCH v3 2/3] travis-ci: express Linux/OS X dependency versions more clearly
Date: Sun, 24 Apr 2016 20:58:11 +0200
Message-ID: <1461524292-20490-3-git-send-email-larsxschneider@gmail.com>
References: <1461524292-20490-1-git-send-email-larsxschneider@gmail.com>
Cc: sschuberth@gmail.com, gitster@pobox.com, ben.woosley@gmail.com,
	Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 24 20:58:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auPEd-0006Dm-H0
	for gcvg-git-2@plane.gmane.org; Sun, 24 Apr 2016 20:58:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753090AbcDXS6V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Apr 2016 14:58:21 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:37859 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751785AbcDXS6T (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2016 14:58:19 -0400
Received: by mail-wm0-f52.google.com with SMTP id n3so97236885wmn.0
        for <git@vger.kernel.org>; Sun, 24 Apr 2016 11:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Z23kHb5vG4dM2Iy/s0pQHjJFg9LrUqFV6LuOb9/5e5c=;
        b=Eps98ivwNHsjftObQZcx+ggbyBLPCehgn38W2wTxA9SBwUOFRTazjw0eMWU2XKxxck
         vHGVqNBYysvi0sPTrTHO5N6dAHBh06rIt9pLECW5euQ657vdPT5wtnFb6CrBqNnfJGoV
         +76FFxy9mTWjTwxc/0EDdcNFWjm3sbC/RGmGSUjTBEe7oPlOsGNRzF5uxU5gYSge2bX1
         ZTeY1xO/0dZz9lFryaCuzxRsl9qMGJftJK7peX9S7tt3pTXgzTYpRoKcldx2vu/C1frD
         dYs7LV1ynWObNV/wHh0gfDtuVXuBoeo/OkBNRIW5vEAh5GPZM6ANdJONsKKnqIvNf3Eu
         +FGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Z23kHb5vG4dM2Iy/s0pQHjJFg9LrUqFV6LuOb9/5e5c=;
        b=BAx8GwcvbtSGmOiQAaZd4vsO8bK7P7fIt1njWzw+Uq5eiBxNicBz47N0n1ZTNk5ufj
         YBwwv1fXMbawSDZq7jbGjzssP8gti7pv8wov09mohNu5vaOYfu4ZO2jzhGUJOxKDfSdO
         DXe2mqS0YVKpVbsy37IGj2EWDDfTMx6FPwKmWJ75hHxmfu4PW9JGagWOqjK292WtHh9U
         7cSpW6hh6d5ZCMCLEvOMOrPmpkkgg77E1853ZJIxntqfar7LAHn03kL4R3sOHJoIKmqS
         X2wrHm+aan/9tb8SxjxQR/SffuJPWs7hqLoTcERcH49hUX4ZGVsHa4kILAoyCoiZlaih
         XtHQ==
X-Gm-Message-State: AOPr4FVM+HdcWmwaTteUyBtyTDZXqSeLjXqrqbZUFl0aMD/CWlb9pMxMbkkn8apdQ5P4Wg==
X-Received: by 10.194.61.40 with SMTP id m8mr30282019wjr.106.1461524298162;
        Sun, 24 Apr 2016 11:58:18 -0700 (PDT)
Received: from slxBook3.fritz.box (p508BA7B8.dip0.t-ipconnect.de. [80.139.167.184])
        by smtp.gmail.com with ESMTPSA id d79sm14948541wmi.23.2016.04.24.11.58.17
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 24 Apr 2016 11:58:17 -0700 (PDT)
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1461524292-20490-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292427>

From: Lars Schneider <larsxschneider@gmail.com>

The Git Travis CI OSX build always installs the latest versions of Git LFS and
Perforce via brew and the Linux build installs fixed versions. Consequently new
LFS/Perforce versions can brake the OS X build even if there is no change in
Git.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 .travis.yml | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index 4acf617..1fdcec8 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -22,8 +22,11 @@ addons:
 env:
   global:
     - DEVELOPER=1
-    - P4_VERSION="16.1"
-    - GIT_LFS_VERSION="1.2.0"
+    # The Linux build installs the defined dependency versions below.
+    # The OS X build installs the latest available versions. Keep that
+    # in mind when you encounter a broken OS X build!
+    - LINUX_P4_VERSION="16.1"
+    - LINUX_GIT_LFS_VERSION="1.2.0"
     - DEFAULT_TEST_TARGET=prove
     - GIT_PROVE_OPTS="--timer --jobs 3 --state=failed,slow,save"
     - GIT_TEST_OPTS="--verbose --tee"
@@ -38,17 +41,17 @@ before_install:
     linux)
       mkdir --parents custom/p4
       pushd custom/p4
-        wget --quiet http://filehost.perforce.com/perforce/r$P4_VERSION/bin.linux26x86_64/p4d
-        wget --quiet http://filehost.perforce.com/perforce/r$P4_VERSION/bin.linux26x86_64/p4
+        wget --quiet http://filehost.perforce.com/perforce/r$LINUX_P4_VERSION/bin.linux26x86_64/p4d
+        wget --quiet http://filehost.perforce.com/perforce/r$LINUX_P4_VERSION/bin.linux26x86_64/p4
         chmod u+x p4d
         chmod u+x p4
         export PATH="$(pwd):$PATH"
       popd
       mkdir --parents custom/git-lfs
       pushd custom/git-lfs
-        wget --quiet https://github.com/github/git-lfs/releases/download/v$GIT_LFS_VERSION/git-lfs-linux-amd64-$GIT_LFS_VERSION.tar.gz
-        tar --extract --gunzip --file "git-lfs-linux-amd64-$GIT_LFS_VERSION.tar.gz"
-        cp git-lfs-$GIT_LFS_VERSION/git-lfs .
+        wget --quiet https://github.com/github/git-lfs/releases/download/v$LINUX_GIT_LFS_VERSION/git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.gz
+        tar --extract --gunzip --file "git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.gz"
+        cp git-lfs-$LINUX_GIT_LFS_VERSION/git-lfs .
         export PATH="$(pwd):$PATH"
       popd
       ;;
-- 
2.5.1
