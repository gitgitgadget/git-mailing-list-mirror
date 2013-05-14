From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 05/47] remote-hg: fix new branch creation
Date: Mon, 13 May 2013 23:36:28 -0500
Message-ID: <1368506230-19614-6-git-send-email-felipe.contreras@gmail.com>
References: <1368506230-19614-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 14 06:39:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uc70x-0003o1-1C
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 06:39:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751936Ab3ENEi4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 00:38:56 -0400
Received: from mail-ob0-f180.google.com ([209.85.214.180]:61248 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751276Ab3ENEiz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 00:38:55 -0400
Received: by mail-ob0-f180.google.com with SMTP id xk17so92918obc.39
        for <git@vger.kernel.org>; Mon, 13 May 2013 21:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=T7P01XGYmFOw6WaRR/hHd6FmdJBDl2phqJG0UWtbgZk=;
        b=PjDsw2X4YJewYk8jhyRnMtMiapo2e6J5qCQVcx4rRlCsGLSmnBhb0Az3OC8qtT8tKM
         K+dZ3qc0/G7fyPl5t/2b9GA/ISrTEmYhCj7ptyVujbE6xjtbNiRdcfW+cohkmDVh8dnx
         xhru3U0DUZ2EcHdZQyXuBJgdZkjJcmoXx4drvsU4HI8zf9wXjIRrmoiJJyKeOvlnIMAg
         GgYgQl5YPVqtExLls9IrENhrnsPRY2bZMfTknbiOCCS1jLXK0W1/gsS1H92sqinMoFEl
         ylYiALJUTNgIp2L1BoR22tfg/ta2hm5kl6Ur/fs3+X4m8UicRJ2TgHsI3ymQDa3Wg756
         sXwg==
X-Received: by 10.60.92.41 with SMTP id cj9mr15230061oeb.31.1368506335152;
        Mon, 13 May 2013 21:38:55 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id yx4sm9274320obb.11.2013.05.13.21.38.53
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 13 May 2013 21:38:54 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.579.g184e698
In-Reply-To: <1368506230-19614-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224240>

When force_push is disabled, we need to turn the argument to True.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index 4a5c72f..3cf9b4c 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -856,7 +856,7 @@ def do_export(parser):
             continue
 
     if peer:
-        parser.repo.push(peer, force=force_push)
+        parser.repo.push(peer, force=force_push, newbranch=True)
 
     # handle bookmarks
     for bmark, node in p_bmarks:
-- 
1.8.3.rc1.579.g184e698
