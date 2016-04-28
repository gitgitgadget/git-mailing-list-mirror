From: larsxschneider@gmail.com
Subject: [PATCH v4 2/3] travis-ci: express Linux/OS X dependency versions more clearly
Date: Thu, 28 Apr 2016 08:26:32 +0200
Message-ID: <1461824793-43235-3-git-send-email-larsxschneider@gmail.com>
References: <1461824793-43235-1-git-send-email-larsxschneider@gmail.com>
Cc: sschuberth@gmail.com, gitster@pobox.com, ben.woosley@gmail.com,
	sunshine@sunshineco.com, Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 08:26:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avfPY-0006Tr-56
	for gcvg-git-2@plane.gmane.org; Thu, 28 Apr 2016 08:26:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751829AbcD1G0m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2016 02:26:42 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:38631 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750867AbcD1G0j (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2016 02:26:39 -0400
Received: by mail-wm0-f47.google.com with SMTP id g17so23530375wme.1
        for <git@vger.kernel.org>; Wed, 27 Apr 2016 23:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TQDSkI5GTFyJ++br9pZ+AwJGsVbX2vqL+kCrRHJqnbU=;
        b=o8Fn9tkO31ECotkTZ9B6nPxBY9xg0h/duEEbQprUXg+rfJSLOhvhBnZnAZINxu+UgR
         FuyNW2kzgUqloYXB+KIrLr11v4KckJu6bVFdJAn8bbNX3bjVGl+qKlKReIcX5TxuSDZd
         YusxBf1VQjEH4FCHkbUPawf8A9OGNws6shJT8b/K6vfulCrkTh8q2sLjhwj3Pj5RYOP8
         D0gruMgA759gfwm8G4lRu0vvyKCWSieAk56U2nDIuiJOf0cI4sk3E1bniu3nDwhP9Z79
         +PtQj617sHex7OELxFdI3U3hkSFAMFnP2oSfQ7/9V5yA7b0LYroDiDU8LP1MdSwRImiZ
         TRuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TQDSkI5GTFyJ++br9pZ+AwJGsVbX2vqL+kCrRHJqnbU=;
        b=Mc+e4oeD7mcIShs9nluHAUQ2yf3VK1DzNnt1WfI5hAdsJnkLWxm4YMJGf/FZDisOkD
         a60w4NUeSFf9cuohn9+0ZfRi/pugUR9I77FwhQYHjjinqbaHU8rH4/C+kzxxYG1LBoVE
         XCiJx9TzlaQdSR98Tpk1aRRzPmAs/CS0X0MTu9yTI/zHbTsb8MYm44v+VkQ7ULsmuXKc
         Bof+hi7yTHqi6gURBt2pcnXeAjNFojxB4+ntHazM8SFrnj7f9neFpQK+l0CmecCZaeSY
         IiSu/Gpu7Bm9hQh4vR+Hg7qR+yweOh4RsuyFTLNZBAsRSsN3YI1hUPlumDIEKiYjIPjh
         a/xQ==
X-Gm-Message-State: AOPr4FU4BVdiRF+CL04UrhpO7PO92F+Vaochbph9R3hBIv/Ew00bVoIehP6sSTlbxAPM7A==
X-Received: by 10.194.174.231 with SMTP id bv7mr13197111wjc.17.1461824797984;
        Wed, 27 Apr 2016 23:26:37 -0700 (PDT)
Received: from slxBook3.fritz.box (p508BAD07.dip0.t-ipconnect.de. [80.139.173.7])
        by smtp.gmail.com with ESMTPSA id y91sm12225405wmh.10.2016.04.27.23.26.36
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 27 Apr 2016 23:26:37 -0700 (PDT)
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1461824793-43235-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292850>

From: Lars Schneider <larsxschneider@gmail.com>

The Git Travis CI OSX build always installs the latest versions of Git LFS and
Perforce via brew and the Linux build installs fixed versions. Consequently new
LFS/Perforce versions can break the OS X build even if there is no change in
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
