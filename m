From: larsxschneider@gmail.com
Subject: [PATCH v2] travis-ci: build documentation
Date: Fri, 29 Apr 2016 11:35:34 +0200
Message-ID: <1461922534-49293-1-git-send-email-larsxschneider@gmail.com>
Cc: Matthieu.Moy@grenoble-inp.fr, stefan.naewe@atlas-elektronik.com,
	gitster@pobox.com, peff@peff.net,
	Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 29 11:35:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aw4pw-000186-IV
	for gcvg-git-2@plane.gmane.org; Fri, 29 Apr 2016 11:35:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751980AbcD2Jfj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2016 05:35:39 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:37447 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751257AbcD2Jfi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2016 05:35:38 -0400
Received: by mail-wm0-f46.google.com with SMTP id a17so26607667wme.0
        for <git@vger.kernel.org>; Fri, 29 Apr 2016 02:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=eInv8rBdaOha1b0nG82hVXIR3kvcnuR+78y7+tbTJnY=;
        b=0Gum2Q9zqilVpQrcN5AAyRTp39DjW8KZEcyNdEa8MccYFcqP/dxVtPhoQGdQXtvaL/
         XXpbBWkjjVYdzXx5jPoHycAq1yC1BC7b/dRAARjzeoo1ijb4KHsOFgBSFPdHghfVDJ18
         rsKSy8yaFM8wmu8H8+63p9XVFjjzIGrLCFf/2U0m7L24y8N23+doObKAHDEPyrM7r7S1
         Uf2FvbgZ2Fu00CMKqa1GBW3X2uh0vBUJxsN8iV8ZD9F7lNHDsR9PgJReKhZjOg061JHy
         uGG8Rl8L6Ef20kZ8qUYE02KTi8EYdubKpWsF8CRWUqToT4ZjFovI7qJ4lcle2kcY7KmM
         wG8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=eInv8rBdaOha1b0nG82hVXIR3kvcnuR+78y7+tbTJnY=;
        b=TkvkmLJ83AX3PWQ8aB9lCWdGuYsfwhDUiC1x9qr4axVkS8iGekYcsKGrRQn9KByTOH
         8U7f7SxnO20obx1nDD9YwdVEuvLpdGQulI6uwKt5PCDnG8r9U0QuM9NxJ2WMDXib1Y5/
         EHI1DNehxmcfAbCiRXr+wnnE5RpZxMoSabXIi5R3o9RJLDzof1B2qIpx0bcUFEgl7CMf
         QumOhyuGRVJ06783hOnYwg/jwx7uAgvsJf1JL+oV90fmikWhbk5d9APoGlRzcue0WNVX
         Je34ACsS5lPUfBbQrfa44o3lTOPix539+5ElRSJswYZRQGEngDuY4ZXA+RsIpE09qUq4
         YuLg==
X-Gm-Message-State: AOPr4FUgn2kwCc4V00NB5B06oAunNzOSlu8Fd+BdFBBTlx9XxF2otVKhdjHXVfPwgAvftw==
X-Received: by 10.28.35.208 with SMTP id j199mr2850741wmj.22.1461922536797;
        Fri, 29 Apr 2016 02:35:36 -0700 (PDT)
Received: from slxBook3.fritz.box (p5DDB43DC.dip0.t-ipconnect.de. [93.219.67.220])
        by smtp.gmail.com with ESMTPSA id c4sm13906800wjm.24.2016.04.29.02.35.35
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 29 Apr 2016 02:35:36 -0700 (PDT)
X-Mailer: git-send-email 2.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292983>

From: Lars Schneider <larsxschneider@gmail.com>

Run "make doc" as separate Travis CI build job to check if all
documentation can be built without errors.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---

diff to v1:
* add quick sanity check to documentation results (thanks Matthieu)
* fix typo in commits message (thanks Stefan)
* move 'make doc' into seperate Travis CI build job (thanks Peff)
* started to move CI helper scripts to /ci (thanks Matthieu & Junio)

I really like the idea of the "/ci" directory. Over time I plan to
migrate all non Travis-CI related code from .travis.yml to this directory.
This would ease the transition to or parallel execution with another CI
system (e.g. GitLab CI to test Git on Windows).

Thanks,
Lars


 .travis.yml              | 15 +++++++++++++++
 ci/test-documentation.sh | 23 +++++++++++++++++++++++
 2 files changed, 38 insertions(+)
 create mode 100755 ci/test-documentation.sh

diff --git a/.travis.yml b/.travis.yml
index 78e433b..9f71d23 100644
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
+      before_script: make doc
+      script: ci/test-documentation.sh
+      after_failure:
+
 before_install:
   - >
     case "${TRAVIS_OS_NAME:-linux}" in
diff --git a/ci/test-documentation.sh b/ci/test-documentation.sh
new file mode 100755
index 0000000..329ff4b
--- /dev/null
+++ b/ci/test-documentation.sh
@@ -0,0 +1,23 @@
+#!/bin/sh
+#
+# Perform a quick sanity check on documentation generated with 'make doc'.
+#
+
+set -e
+
+test_file_count () {
+    SUFFIX=$1
+    EXPECTED_COUNT=$2
+    ACTUAL_COUNT=$(find Documentation -type f -name "*.$SUFFIX" | wc -l)
+    echo "$ACTUAL_COUNT *.$SUFFIX files found. $EXPECTED_COUNT expected."
+    test $ACTUAL_COUNT -eq $EXPECTED_COUNT
+}
+
+test -s Documentation/git.html
+test -s Documentation/git.xml
+test -s Documentation/git.1
+
+# The follow numbers need to be adjusted when new documentation is added.
+test_file_count html 233
+test_file_count xml 171
+test_file_count 1 152
--
2.5.1
