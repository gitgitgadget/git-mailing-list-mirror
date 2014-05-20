From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 16/19] t/t5537-fetch-shallow.sh: convert test -a/-o to && and ||
Date: Tue, 20 May 2014 06:50:29 -0700
Message-ID: <1400593832-6510-17-git-send-email-gitter.spiros@gmail.com>
References: <1400593832-6510-1-git-send-email-gitter.spiros@gmail.com>
Cc: jrnieder@gmail.com, Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 20 15:51:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmkRj-0000Bh-2n
	for gcvg-git-2@plane.gmane.org; Tue, 20 May 2014 15:51:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753647AbaETNu6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2014 09:50:58 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:38596 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753614AbaETNuz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2014 09:50:55 -0400
Received: by mail-pa0-f42.google.com with SMTP id rd3so350181pab.1
        for <git@vger.kernel.org>; Tue, 20 May 2014 06:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fuWC5nHgbYb6eWw6hpzWRnm/MD09Vx2jvn5tRFC+Nl4=;
        b=wwSOqyrt05C13penRJ8czvCgmV2k5I7jSYhzLKZDt3yRR5xchBOYY6MmzCJ5flszha
         ol5smuqgBk/5muJN6oYMkTte2HDmhk3UjQaiCQoY6kwEMnThGABC8/mUHXwGh+tGGOYJ
         w/LbPzeA3/ETroaGz1W9/uK4xF+G9hJSCWLT2iJUV2U3jjtAAqu6FVF0UusmM7ju+c/p
         ZRsCPh5s8AF7QSzKqAV70DXc8AgdsCS6ty3Cas2u0YXcExiGHDlqIHg469tLbxBgnABQ
         crvDz+3ekODTrS5WdU4g+PBRdg0VmaN0FMCBs805KcEzsBXCHsEEk9BRR0T7myAWPLLu
         yAZQ==
X-Received: by 10.68.239.137 with SMTP id vs9mr51351918pbc.84.1400593854550;
        Tue, 20 May 2014 06:50:54 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id oe4sm3317286pbb.33.2014.05.20.06.50.53
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 20 May 2014 06:50:54 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1400593832-6510-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249667>

The interaction with unary operators and operator precedence
for && and || are better known than -a and -o, and for that
reason we prefer them. Replace all existing instances
of -a and -o to save readers from the burden of thinking
about such things.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 t/t5537-fetch-shallow.sh |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5537-fetch-shallow.sh b/t/t5537-fetch-shallow.sh
index be951a4..2c75730 100755
--- a/t/t5537-fetch-shallow.sh
+++ b/t/t5537-fetch-shallow.sh
@@ -173,7 +173,7 @@ EOF
 	)
 '
 
-if test -n "$NO_CURL" -o -z "$GIT_TEST_HTTPD"; then
+if test -n "$NO_CURL" || test -z "$GIT_TEST_HTTPD"; then
 	say 'skipping remaining tests, git built without http support'
 	test_done
 fi
-- 
1.7.10.4
