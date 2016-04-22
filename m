From: larsxschneider@gmail.com
Subject: [PATCH v1] travis-ci: build documentation
Date: Fri, 22 Apr 2016 10:34:02 +0200
Message-ID: <1461314042-3132-1-git-send-email-larsxschneider@gmail.com>
Cc: gitster@pobox.com, Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 22 10:34:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atWXV-0008DR-MC
	for gcvg-git-2@plane.gmane.org; Fri, 22 Apr 2016 10:34:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753420AbcDVIeI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Apr 2016 04:34:08 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:38824 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752113AbcDVIeF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2016 04:34:05 -0400
Received: by mail-wm0-f46.google.com with SMTP id u206so15147833wme.1
        for <git@vger.kernel.org>; Fri, 22 Apr 2016 01:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=Bdsw9CRY6eZYcjKtzegRR+gPwdKCN8Ohcjvrz8Gk5EA=;
        b=V1s7HCnv8An8XLuE7MCcuEMDSLyUBoDiGd6OTQsXPUiefcvjg4/aCIfu+Ox+XQxXv4
         mzKsTnZmcXQad8Xnnr1AwgXSTLzaJ3fCxiTv3Ub3SATbOCkerw+rvDgIf33ScZfjXJp1
         lrNUFlkvJlW55buvmiu1YOJrOUcp5kgCIjGsvExL+4yEVfwCcG55ICo38y39zanodNqI
         1DGCO7R3SbSJuCZ974sdGvHtSOSYo1NdJH7Pk5y2S8Oo6pMzNO7e1IlaTLDWoK74NpT8
         OSDaeJVt5p3kDGKZR1YU31NdtbZEjMeJS1IXwR/9v+CWu1/2gGRdaNrb5ScSv0AUSJJE
         yifA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Bdsw9CRY6eZYcjKtzegRR+gPwdKCN8Ohcjvrz8Gk5EA=;
        b=HslcPb8w9Qi0uyJZeSyB7YXmZBWeu9GSJSxjJH3eCvgd+1JQwIk+Dtl73hEnyrwGv/
         yNm4hGtQLmVox1Iqj+2+07hA9w6iftc0DOfL546sTKB5aCM7P+GrzqnZI4o0Y9XlHkMm
         W/YXG1uhyuZl0B2fLbnSw6Q1yOvRDoUHcKkZaH7vGsoS40YXoYpcbsM6K8MXLx3S7TTh
         4K4WQamXKqDSUrZovYfSNg3jETYMUK5twpyu9DCW/cy21qblNhQ30S9oksP4l/sOjkLk
         rhRX+FFIrUWzFmbXk41vConH/YOespSjRAzswppnQDnJcuGEeMGfAlo0y+lvgGkHXMsK
         2JSA==
X-Gm-Message-State: AOPr4FVG9/I1pVa9zdzX+aSrZAe5fJOlRJMO//RnTrVK9mRYKOwDWZEasAVdktZOxCI+8A==
X-Received: by 10.194.88.201 with SMTP id bi9mr18621891wjb.147.1461314044002;
        Fri, 22 Apr 2016 01:34:04 -0700 (PDT)
Received: from slxBook3.fritz.box (p5DDB43AA.dip0.t-ipconnect.de. [93.219.67.170])
        by smtp.gmail.com with ESMTPSA id w77sm2153186wmw.10.2016.04.22.01.34.02
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 22 Apr 2016 01:34:03 -0700 (PDT)
X-Mailer: git-send-email 2.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292181>

From: Lars Schneider <larsxschneider@gmail.com>

Run "make doc" to check if all documentation can be build without errors.
Since the documentation is the same on every platform/compiler, the check
is only performed as part of the Linux/GCC build job to maintain a fast
CI process.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---

Patch as promised in http://article.gmane.org/gmane.comp.version-control.git/291726

Cheers,
Lars

 .travis.yml | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/.travis.yml b/.travis.yml
index c3bf9c6..6ca7fb2 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -12,6 +12,8 @@ addons:
   apt:
     packages:
     - language-pack-is
+    - asciidoc
+    - xmlto

 env:
   global:
@@ -70,7 +72,16 @@ before_install:

 before_script: make --jobs=2

-script: make --quiet test
+script:
+  - >
+      make --quiet test &&
+      if [[ "$TRAVIS_OS_NAME" = linux ]] && [[ "$CC" = gcc ]];
+          then
+          echo ""
+          echo "------------------------------------------------------------------------" &&
+          echo "$(tput setaf 2)Building documentation...$(tput sgr0)" &&
+          make --quiet doc
+      fi;

 after_failure:
   - >
--
2.5.1
