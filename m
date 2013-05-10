From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 5/6] remote-hg: fix new branch creation
Date: Fri, 10 May 2013 15:59:25 -0500
Message-ID: <1368219566-1399-6-git-send-email-felipe.contreras@gmail.com>
References: <1368219566-1399-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 10 23:01:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UauRO-00011b-S7
	for gcvg-git-2@plane.gmane.org; Fri, 10 May 2013 23:01:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754908Ab3EJVBN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 May 2013 17:01:13 -0400
Received: from mail-ob0-f180.google.com ([209.85.214.180]:56560 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754266Ab3EJVBH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 May 2013 17:01:07 -0400
Received: by mail-ob0-f180.google.com with SMTP id xk17so2476063obc.39
        for <git@vger.kernel.org>; Fri, 10 May 2013 14:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=VkNo+CS0CaV76nxhRReIWOBAbxiEjhALMFSYIvomP7o=;
        b=W4xMNmNgI0gVL3jzLAJH/pe10lIa9nOn/HcN3Ncbzo3kkbHBmcErpCVmq3BOazGGnz
         PNZoFybk0mB581pLG+lmf59aU9pZwLrFoQikvCpbN1GmdY6U7tLVrn1vQ8WhHg/dnY37
         PMjAQxrzfgMeOAl6NgAWRvjyLz22D8ytM5tMNl8C0G7Hnf9Dd1P1fMBhkmx/yfaGDfnm
         PHUqVmpPj/ANZ+u//bcsYyD3OrPnCnhavYcLfsmVq8hxnpn6X5AQSEtmjQMs1adMsEHk
         rniBbF2thZperpI+fq91XnyULB0ClqHBaIhGjI1oPy/y+xoPaH+YG9a2Suorj0JXtZCC
         JrSA==
X-Received: by 10.182.60.136 with SMTP id h8mr7881950obr.47.1368219666889;
        Fri, 10 May 2013 14:01:06 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id eq4sm4620871obb.5.2013.05.10.14.01.05
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 10 May 2013 14:01:06 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.579.g184e698
In-Reply-To: <1368219566-1399-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223912>

When force_push is disabled, we need to turn the argument to True.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index c84a7b4..50ead38 100755
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
1.8.3.rc1.579.g184e698
