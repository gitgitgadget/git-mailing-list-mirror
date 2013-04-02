From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 11/13] remote-hg: force remote push
Date: Tue,  2 Apr 2013 13:03:00 -0600
Message-ID: <1364929382-1399-12-git-send-email-felipe.contreras@gmail.com>
References: <1364929382-1399-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Max Horn <max@quendi.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 02 21:05:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UN6WB-0007LU-2Z
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 21:05:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762140Ab3DBTEk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 15:04:40 -0400
Received: from mail-gh0-f170.google.com ([209.85.160.170]:63024 "EHLO
	mail-gh0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762111Ab3DBTEj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 15:04:39 -0400
Received: by mail-gh0-f170.google.com with SMTP id z2so115299ghb.29
        for <git@vger.kernel.org>; Tue, 02 Apr 2013 12:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=g9sUm8PFhomRbr6o5EK9VLRjIjF2g5+U+ch1yiNU8oQ=;
        b=sk1Y7aWKGZvnHgn/LQ26V96rTXz3InPc/HlH0jimDuk3znEm1jvibCV+QXNL04sk7q
         pVsVrrRM20SqiYOkVN5uQsioRpaMM/7kgs3h26+KxPsp2diLfKcuw1OxxgWxux1wluy1
         ZAzn5io3ONZDwr4ohZAJDpCMpki/SC3g1emid1Uu931BknEo8EG17wdDPPKFWtk/xTCC
         tXXA+9k+Xc/a6mltmS4ZiZFvvijq7OuRrJDQ8ilj4Fg5bf4PEdD4Wt2hZb5CG4q9oSfJ
         MqOAQB6J7xDs/9FcNaf76Kx/JfjxVGjgtX3S4Si9bqJg49n1X1n/U5u7ebEEqupJAo+h
         QqkQ==
X-Received: by 10.236.73.231 with SMTP id v67mr16462744yhd.88.1364929478654;
        Tue, 02 Apr 2013 12:04:38 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id b7sm4873194yhl.10.2013.04.02.12.04.36
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 02 Apr 2013 12:04:37 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
In-Reply-To: <1364929382-1399-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219844>

Ideally we shouldn't do this, as it's not recommended in mercurial
documentation, but there's no other way to push multiple bookmarks (on
the same branch), which would be the behavior most similar to git.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index 160f486..a1b7e44 100755
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
