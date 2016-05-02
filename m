From: larsxschneider@gmail.com
Subject: [PATCH v3 2/2] travis-ci: build documentation
Date: Mon,  2 May 2016 22:20:05 +0200
Message-ID: <1462220405-12408-3-git-send-email-larsxschneider@gmail.com>
References: <xmqqziscw2g7.fsf@gitster.mtv.corp.google.com>
 <1462220405-12408-1-git-send-email-larsxschneider@gmail.com>
Cc: peff@peff.net, Matthieu.Moy@grenoble-inp.fr, sbeller@google.com,
	gitster@pobox.com, Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 02 22:20:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axKKL-00052g-5Q
	for gcvg-git-2@plane.gmane.org; Mon, 02 May 2016 22:20:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932111AbcEBUUP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 May 2016 16:20:15 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33110 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932110AbcEBUUL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2016 16:20:11 -0400
Received: by mail-wm0-f68.google.com with SMTP id r12so406963wme.0
        for <git@vger.kernel.org>; Mon, 02 May 2016 13:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1O3fDyD72D+6WsJCqPwEpj7+TPNI+KZg0Lto5mkFgYo=;
        b=oM2L1fvwwl+i1lzSIlFXQmIQyUMg1+QnKMGmSWr5SMzvunUyQToHUsY7WGIsa4/1K1
         r7kUxIuF9dr+cIxv5gG83KvO/Ec9zEHCyC+3j/1slSbY2heqYQilqRJG69wEbou35O9j
         TzDoHlEHRcjkxzSgNxvo5MPIPPSv2frHqGvqox9kseK+NjoE5pG0VLaTtER7dY0FiK6C
         FS+OrsMob6ONvpvL4uNKgtyVmU5PxOwt0cMN33wAcIhiAYR8qYZBu7nK7lPuq7Ck2kGA
         z6DAUh2/6FxuYeQ59kx2a11TyHPGPRpAVH1YvLLKa4QrQ4f5myS1vhgERNqH8ZovsbR7
         2Msg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1O3fDyD72D+6WsJCqPwEpj7+TPNI+KZg0Lto5mkFgYo=;
        b=RUnHQnh7kAS8IodkuIgaF6G40LiYAwDdjid06LCRTEIzFQj73jE4u83DUUJYzODyJ8
         W2NT/lt4G7Wt627bSLyaWQV2W19dicL89llSv1A0PttO8zuF6GlQSAB86Wgyi1r6jGjH
         iWbGulz6bgD9NCMV3OS0LlUfMFlcAm0ZCNQ6QchgMv6p8sFTG5+zvDV5955okF0/GDMQ
         3KDJl5Oegvk741l4KIab3del61cR1UBHxhZ2sSQnyfki3ugPnLRKE97j1OLSgsHuKEhG
         QUibuAJB2NE9ivw2L9GH0ahA+6ziIy/xUgRoPQj+E25RV5TCrdtUCGKSTKW+3PHLHuhI
         tixg==
X-Gm-Message-State: AOPr4FUeExTGTcfMOu/1m+MwJ26btERkFmDkGEgCAwGBk7O8bmFVz8eAletRU2Cv2uoshQ==
X-Received: by 10.28.30.148 with SMTP id e142mr19963252wme.69.1462220409757;
        Mon, 02 May 2016 13:20:09 -0700 (PDT)
Received: from slxBook3.fritz.box (p5DDB4E4A.dip0.t-ipconnect.de. [93.219.78.74])
        by smtp.gmail.com with ESMTPSA id v143sm20558672wmv.4.2016.05.02.13.20.08
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 02 May 2016 13:20:09 -0700 (PDT)
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1462220405-12408-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293284>

From: Lars Schneider <larsxschneider@gmail.com>

Build documentation as separate Travis CI job to check for
documentation errors.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 .travis.yml              | 15 +++++++++++++++
 ci/test-documentation.sh | 24 ++++++++++++++++++++++++
 2 files changed, 39 insertions(+)
 create mode 100755 ci/test-documentation.sh

diff --git a/.travis.yml b/.travis.yml
index 78e433b..55299bd 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -32,6 +32,21 @@ env:
     # t9816 occasionally fails with "TAP out of sequence errors" on Travis CI OS X
     - GIT_SKIP_TESTS="t9810 t9816"
 
+matrix:
+  include:
+    - env: Documentation
+      os: linux
+      compiler: clang
+      addons:
+        apt:
+          packages:
+          - asciidoc
+          - xmlto
+      before_install:
+      before_script:
+      script: ci/test-documentation.sh
+      after_failure:
+
 before_install:
   - >
     case "${TRAVIS_OS_NAME:-linux}" in
diff --git a/ci/test-documentation.sh b/ci/test-documentation.sh
new file mode 100755
index 0000000..889e6fd
--- /dev/null
+++ b/ci/test-documentation.sh
@@ -0,0 +1,24 @@
+#!/bin/sh
+#
+# Perform sanity checks on documentation and build it.
+#
+
+set -e
+
+LINKS=$(grep --recursive --only-matching --no-filename --perl-regexp \
+    '(?<=linkgit:).*?(?=\[\d+\])' Documentation/* \
+    | sort -u \
+)
+
+for LINK in $LINKS; do
+    echo "Checking linkgit:$LINK..."
+    test -s Documentation/$LINK.txt
+done
+
+make check-builtins
+make check-docs
+make doc
+
+test -s Documentation/git.html
+test -s Documentation/git.xml
+test -s Documentation/git.1
-- 
2.5.1
