From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 11/19] t/t0025-crlf-auto.sh: convert test -a/-o to && and ||
Date: Tue, 20 May 2014 06:50:24 -0700
Message-ID: <1400593832-6510-12-git-send-email-gitter.spiros@gmail.com>
References: <1400593832-6510-1-git-send-email-gitter.spiros@gmail.com>
Cc: jrnieder@gmail.com, Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 20 15:51:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmkRz-0000e3-Ry
	for gcvg-git-2@plane.gmane.org; Tue, 20 May 2014 15:51:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753613AbaETNuy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2014 09:50:54 -0400
Received: from mail-pb0-f43.google.com ([209.85.160.43]:51216 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753581AbaETNuu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2014 09:50:50 -0400
Received: by mail-pb0-f43.google.com with SMTP id up15so340808pbc.30
        for <git@vger.kernel.org>; Tue, 20 May 2014 06:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tVy37ZkBn4Ja4M+LVnzC/wof3E4kdHtJVqQu+nmBJwQ=;
        b=bjiZURDrP8i5tO9l4xkzQFsKvzwdvbTiicA6kmGjf4XZd9FfOgl/xJvT4mI4jRndNJ
         En8FcEdnqKUZ/FJqdQIRzA38ZhSu+ySKxXk/9m7N9ja4Ry4/4SXvdTrGSPGfLtvts0cK
         MIpH470K2TGI/uMc5C7gGtGODTfydy98tYeAFRCR000ne3tv2apP6gsT/X8vA+HBKfft
         THr2qIFsmsl5GyMzLAFnNqB4nxRLzaykTnvJgI+pMl5VQeA3rYqUgnMlEE/GkCxfQw93
         KAIL28p2V2K5FfySJrt1d3D4BuBzzGaypw++EyvDM6BWN2ywT9YVQxV/cAX2DSpviAyb
         +ELw==
X-Received: by 10.66.141.165 with SMTP id rp5mr50593843pab.90.1400593849763;
        Tue, 20 May 2014 06:50:49 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id oe4sm3317286pbb.33.2014.05.20.06.50.48
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 20 May 2014 06:50:49 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1400593832-6510-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249676>

The interaction with unary operators and operator precedence
for && and || are better known than -a and -o, and for that
reason we prefer them. Replace all existing instances
of -a and -o to save readers from the burden of thinking
about such things.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 t/t0025-crlf-auto.sh |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t0025-crlf-auto.sh b/t/t0025-crlf-auto.sh
index f5f67a6..a13fc56 100755
--- a/t/t0025-crlf-auto.sh
+++ b/t/t0025-crlf-auto.sh
@@ -36,7 +36,7 @@ test_expect_success 'default settings cause no changes' '
 	onediff=`git diff one` &&
 	twodiff=`git diff two` &&
 	threediff=`git diff three` &&
-	test -z "$onediff" -a -z "$twodiff" -a -z "$threediff"
+	test -z "$onediff" && test -z "$twodiff" && test -z "$threediff"
 '
 
 test_expect_success 'crlf=true causes a CRLF file to be normalized' '
@@ -111,7 +111,7 @@ test_expect_success 'autocrlf=true does not normalize CRLF files' '
 	onediff=`git diff one` &&
 	twodiff=`git diff two` &&
 	threediff=`git diff three` &&
-	test -z "$onediff" -a -z "$twodiff" -a -z "$threediff"
+	test -z "$onediff" && test -z "$twodiff" && test -z "$threediff"
 '
 
 test_expect_success 'text=auto, autocrlf=true _does_ normalize CRLF files' '
@@ -126,7 +126,7 @@ test_expect_success 'text=auto, autocrlf=true _does_ normalize CRLF files' '
 	onediff=`git diff one` &&
 	twodiff=`git diff two` &&
 	threediff=`git diff three` &&
-	test -z "$onediff" -a -n "$twodiff" -a -z "$threediff"
+	test -z "$onediff" && test -n "$twodiff" && test -z "$threediff"
 '
 
 test_expect_success 'text=auto, autocrlf=true does not normalize binary files' '
-- 
1.7.10.4
