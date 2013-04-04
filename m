From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 11/13] remote-hg: force remote push
Date: Thu,  4 Apr 2013 09:30:20 -0600
Message-ID: <1365089422-8250-12-git-send-email-felipe.contreras@gmail.com>
References: <1365089422-8250-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Max Horn <max@quendi.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 04 17:32:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNm9K-00048e-Vq
	for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 17:32:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762738Ab3DDPb4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 11:31:56 -0400
Received: from mail-ob0-f181.google.com ([209.85.214.181]:58187 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762715Ab3DDPbz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 11:31:55 -0400
Received: by mail-ob0-f181.google.com with SMTP id ni5so2695369obc.12
        for <git@vger.kernel.org>; Thu, 04 Apr 2013 08:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=5ds+PaaNEziWmYDht5lFJ45FeooECT7NpUBFHvIf4pA=;
        b=hSAk4x8DwhlVa9e7pFBvG5DrJOCRFeogcsVBR1ywa5GlpRxkmjSZ2q+GkLcINaijto
         2pBWL8HNbQk8fUnQmxIX9iu2dfjaWOkTd/cBwWaQ/0VRHEDR9mOrsSNDkkovwn+zSB0p
         AG5GvmsIojGtwj6quaDZ8Czb03HY0obIaVeL06mabjzlcQQBngM6Tc5fMGZ13tiGT2mz
         LbBSXYctTsGrz9BGF+Xu5lhnQYg46WYdWK8u1q5/sBGQhqulOUDGFcl2VQ4wpAcOx4ZT
         BksUKkLmQ/YqS/t6B9BMjQcLeylUVIUdyDm/bpdzZ7uAoVSkhXwSojxZ0/s50ukgf+me
         bSFw==
X-Received: by 10.60.103.165 with SMTP id fx5mr4730128oeb.4.1365089514615;
        Thu, 04 Apr 2013 08:31:54 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id n1sm6785218obc.10.2013.04.04.08.31.52
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 04 Apr 2013 08:31:53 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
In-Reply-To: <1365089422-8250-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220013>

Ideally we shouldn't do this, as it's not recommended in mercurial
documentation, but there's no other way to push multiple bookmarks (on
the same branch), which would be the behavior most similar to git.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index b54de1e..b784c54 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -722,7 +722,7 @@ def do_export(parser):
             continue
 
     if peer:
-        parser.repo.push(peer, force=False)
+        parser.repo.push(peer, force=True)
 
     # handle bookmarks
     for bmark, node in p_bmarks:
-- 
1.8.2
