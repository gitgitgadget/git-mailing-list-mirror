From: larsxschneider@gmail.com
Subject: [PATCH v4 2/2] travis-ci: build documentation
Date: Wed,  4 May 2016 10:38:36 +0200
Message-ID: <1462351116-19308-3-git-send-email-larsxschneider@gmail.com>
References: <E4A56B4E-6F2E-44E3-870B-D1D3A71B2869@gmail.com>
 <1462351116-19308-1-git-send-email-larsxschneider@gmail.com>
Cc: peff@peff.net, Matthieu.Moy@grenoble-inp.fr, sbeller@google.com,
	gitster@pobox.com, Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 04 10:38:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axsKc-0006jk-VQ
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 10:38:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757734AbcEDIio (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2016 04:38:44 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:35066 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757686AbcEDIim (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 04:38:42 -0400
Received: by mail-wm0-f42.google.com with SMTP id e201so177509618wme.0
        for <git@vger.kernel.org>; Wed, 04 May 2016 01:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WDEhiriG8JVfJgrOYJ443Leka9Aeu3Eg4cfASjb1rs8=;
        b=cQOzomeGxMHxtzInjYs+L3zJqSzTwhsVRxwx3RCaoXUOIeAz6SqYZwPTcO+AOXnpgU
         QW491FCJ3QuZPJoGnhUQieaIQQIAh2dQoEZKNgykwgHCmgbdo5d2PJVr9nHXZJq97RmY
         mg3HyTVMuSpoQPh5ecAtU0OIH9U5AFuefi2mNquow9A2ojBmfu6iDziQ7I9KsHoO/zyb
         HMrZT3Bgrmmi0jrA9xvSSinyJnuWQkv0UDB5Tc4/YTcUI4QJ3DvB+/ZgKUmhGlTBzjYL
         Vx65LqTBuY447Ops8fjs8gaZGPxgYgv5Lu/MZkAPj3W5z9OI/wmHPImUYr8CJ6CoC2Ah
         PngQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WDEhiriG8JVfJgrOYJ443Leka9Aeu3Eg4cfASjb1rs8=;
        b=dLCAgZeDJsP+01e44U5giHIvTV07hjyEZ7qrDnEH8seMeOtIzOerp2xlUz1oeU4m1s
         0++DxwMSMW6zZJVQY5GuVbdBFJhBoaCX7RBjILU2mvYtt3IG0ESxA16eU1eed5oVj7rG
         da4B52Ad4GtxCNdUsxtlKbx+JgYiXR5n0Pya6hq73o9v8KgNB5CXd1SS6GeIJAOTnabQ
         3SpCJ3dJi4DU0cwKDWQ7r4E5Kq7hfSm5XNIcg2b5fvHOuiV5476FSC7XHeI4VzXSHdZ4
         7tgvXHFufujeF9thg49fJr8tiOq7h4ubAoQ5SsEmf4ppbbHKa+F2SELs511oLe0i3BGt
         Uz/w==
X-Gm-Message-State: AOPr4FUlMMUT3/lfhAYawNC/ucUX/2NaSfJN5kUqbL3rIjH94ZKM1b9v8fRZyXVYFCAHhQ==
X-Received: by 10.28.161.198 with SMTP id k189mr29827707wme.23.1462351121150;
        Wed, 04 May 2016 01:38:41 -0700 (PDT)
Received: from slxBook3.fritz.box (p5DDB740E.dip0.t-ipconnect.de. [93.219.116.14])
        by smtp.gmail.com with ESMTPSA id d23sm2983014wmd.1.2016.05.04.01.38.40
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 04 May 2016 01:38:40 -0700 (PDT)
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1462351116-19308-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293523>

From: Lars Schneider <larsxschneider@gmail.com>

Build documentation as separate Travis CI job to check for
documentation errors.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 .travis.yml              | 15 +++++++++++++++
 ci/test-documentation.sh | 14 ++++++++++++++
 2 files changed, 29 insertions(+)
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
index 0000000..579d540
--- /dev/null
+++ b/ci/test-documentation.sh
@@ -0,0 +1,14 @@
+#!/bin/sh
+#
+# Perform sanity checks on documentation and build it.
+#
+
+set -e
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
