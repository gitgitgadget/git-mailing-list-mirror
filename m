From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 1/4] remote-bzr: avoid echo -n
Date: Thu,  4 Apr 2013 09:36:16 -0600
Message-ID: <1365089779-9726-2-git-send-email-felipe.contreras@gmail.com>
References: <1365089779-9726-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Max Horn <max@quendi.de>, Antoine Pelisse <apelisse@gmail.com>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 04 17:37:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNmEa-0000WM-HM
	for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 17:37:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760622Ab3DDPhV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 11:37:21 -0400
Received: from mail-ob0-f178.google.com ([209.85.214.178]:53904 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760391Ab3DDPhT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 11:37:19 -0400
Received: by mail-ob0-f178.google.com with SMTP id wd20so2638263obb.23
        for <git@vger.kernel.org>; Thu, 04 Apr 2013 08:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=h9ZNt8hvTo04LfIR+vvCDg5HVCyuoJ7U0VcQWOT0qLE=;
        b=lbqodCJejWqQuAcNCe53OVUNS+tzyPtyLkcKw0E4iuuIXxcjXqXd4pefUcUi8g0kmx
         j8VU+BVkGo/ZHSx9ihhfj+tUzJ7PrS3rWbM72J7lVwSVo0hzIuPEXaqqyiWH2XjUkUWi
         gWrLJE8To9W5AerZPNdSwRQEIMJU6HseuKXEFJQOJrK+BqIp8FHGcaIP0n9oh/5UQPDK
         KegTS+UDWwtgAnZO/QQ7vQswCRfP6ni8ybwPuxHiTgJoaENT9Xukae3nMB/gPaJIudVq
         +IffOfz5TNP3zbyknCUlIBt+eNvwJBWXA/5rN/tKWIVUjhW3ce6/Uv+W1reMfrEYZebM
         q6YA==
X-Received: by 10.182.23.101 with SMTP id l5mr4681744obf.16.1365089839337;
        Thu, 04 Apr 2013 08:37:19 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id ri7sm7144455oeb.6.2013.04.04.08.37.17
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 04 Apr 2013 08:37:18 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
In-Reply-To: <1365089779-9726-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220018>

It's not portable, as reported by test-lint.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/test-bzr.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/remote-helpers/test-bzr.sh b/contrib/remote-helpers/test-bzr.sh
index 70aa8a0..b81052b 100755
--- a/contrib/remote-helpers/test-bzr.sh
+++ b/contrib/remote-helpers/test-bzr.sh
@@ -136,7 +136,7 @@ test_expect_success 'special modes' '
   (cd gitrepo &&
   git cat-file -p HEAD:link > ../actual) &&
 
-  echo -n content > expected &&
+  printf content > expected &&
   test_cmp expected actual
 '
 
-- 
1.8.2
