From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 4/4] remote-hg: fix new branch creation
Date: Fri, 10 May 2013 05:17:03 -0500
Message-ID: <1368181023-10402-5-git-send-email-felipe.contreras@gmail.com>
References: <1368181023-10402-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 10 12:19:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UakPp-0001xR-3B
	for gcvg-git-2@plane.gmane.org; Fri, 10 May 2013 12:19:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752132Ab3EJKSq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 May 2013 06:18:46 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:57589 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750924Ab3EJKSn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 May 2013 06:18:43 -0400
Received: by mail-ob0-f174.google.com with SMTP id dn14so3988159obc.5
        for <git@vger.kernel.org>; Fri, 10 May 2013 03:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=v6ul7wVlw4e17x5c0h4xcEM976+G8PKA4/hJ1d+H7p8=;
        b=KfCBXLlNb7f9P4wXnqqeBTBhTnxch1n5TEkxZF5ttaz8R+HoALN6y4o2/EdV1G4KHr
         TEFzJINnd7ajrPBpw4knwCBmjhbOrfGThJ2y0fe7DCbtOdSvvJJe2vtaX6fTUD4vT8Xq
         n2XEl1wchjJg+h4+pk24CxJtUHWNss3+Nbpb45LB75uaBoZRuPjhnEtU20MEtVM880Rs
         1DLhnMHkBww6IAwsGG5tatsDxIcugVnmCUJxjemNEla8zDjW1+gMfNUSCNvbAGE40rGX
         EHq0Mexs//iZzS5gy4XywiPNoQKCaoZybOXkq+H4kR7+mm649N0lLqVC29yag9Kb1y5Y
         OPVA==
X-Received: by 10.182.46.228 with SMTP id y4mr6574372obm.28.1368181123417;
        Fri, 10 May 2013 03:18:43 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id wq8sm2153787obb.7.2013.05.10.03.18.41
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 10 May 2013 03:18:42 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.555.gd13b5a0
In-Reply-To: <1368181023-10402-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223829>

When force_push is disabled, we need to turn the argument to True.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index 85b9319..10f073a 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -853,7 +853,7 @@ def do_export(parser):
             continue
 
     if peer:
-        parser.repo.push(peer, force=force_push)
+        parser.repo.push(peer, force=force_push, newbranch=True)
 
     # handle bookmarks
     for bmark, node in p_bmarks:
-- 
1.8.3.rc1.555.gd13b5a0
