From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: [PATCH 2/2] check-builtins: Strip any executable suffix to make it
 work on Windows
Date: Thu, 5 Feb 2015 14:28:04 +0100
Message-ID: <CAHGBnuNvesez_Ctvpi16vzsOZnaHiY5Fcf5+b+u0HNZ9zAyNZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Johannes Sixt <j6t@kdbg.org>, normalperson@yhbt.net,
	amyrick@apple.com
To: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 05 14:28:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YJMTb-0006bf-UR
	for gcvg-git-2@plane.gmane.org; Thu, 05 Feb 2015 14:28:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755261AbbBEN2H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2015 08:28:07 -0500
Received: from mail-yh0-f49.google.com ([209.85.213.49]:61306 "EHLO
	mail-yh0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752644AbbBEN2G (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2015 08:28:06 -0500
Received: by mail-yh0-f49.google.com with SMTP id v1so3319683yhn.8
        for <git@vger.kernel.org>; Thu, 05 Feb 2015 05:28:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=dpXx146M7AUgYjdYqbLjui6mDQ32Oc2I4QHXQDIVN+s=;
        b=W+tFWXB9MrSrA7KY0w0+CN65xC74A90uEoeR4doCKNhqAbRRAXkD+1357FWwMy9OB0
         1E/PbaNCesGmx7FGXxC0R/mLnbc+ijppAjzqMxRGft7sK2COGsQQFUhbP5gRMlrJfxqb
         cimKm9UzgY9fISr16PgnOhCwK6Q5ff6lLxF5Jh6kS/1YcuVcq6hNmOcDBgbsRUqaAXIu
         sqSK7N/SD5ws+QplOGP7uQb/WSXueEH4qpoUaOgHIg2slSdXKd/Fvwxi9VJ2UAYzWU55
         DMZLlX5W3p6NOxInPvjnDN4hWS2hyehnuHi62O2NABQGikhaoItpqoB5H6VEZrgstFjE
         V78A==
X-Received: by 10.236.24.129 with SMTP id x1mr1349253yhx.118.1423142884624;
 Thu, 05 Feb 2015 05:28:04 -0800 (PST)
Received: by 10.170.132.133 with HTTP; Thu, 5 Feb 2015 05:28:04 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263372>

Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
---
 check-builtins.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/check-builtins.sh b/check-builtins.sh
index 07cff69..a0aaf3a 100755
--- a/check-builtins.sh
+++ b/check-builtins.sh
@@ -3,7 +3,7 @@
 {
     cat <<\EOF
 sayIt:
-    $(foreach b,$(BUILT_INS),echo XXX $b YYY;)
+    $(foreach b,$(BUILT_INS),echo XXX $(b:$X=) YYY;)
 EOF
     cat Makefile
 } |
-- 
2.1.2-mingw-1
