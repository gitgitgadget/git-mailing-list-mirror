From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 2/3] add: avoid yoda condition
Date: Tue, 29 Apr 2014 16:49:37 -0500
Message-ID: <1398808178-3703-3-git-send-email-felipe.contreras@gmail.com>
References: <1398808178-3703-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 30 00:00:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfG4i-00072E-TO
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 00:00:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964836AbaD2WA0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 18:00:26 -0400
Received: from mail-yk0-f171.google.com ([209.85.160.171]:36203 "EHLO
	mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964783AbaD2WAY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 18:00:24 -0400
Received: by mail-yk0-f171.google.com with SMTP id 10so771418ykt.30
        for <git@vger.kernel.org>; Tue, 29 Apr 2014 15:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Y23po/0x24BHHv1WflksHyHMTItsmjSgvcVcx+cXzag=;
        b=LL+qQr+9yi1uf7O/E9M0qUf2NCbOKmKKwjcZCWS1v5Imfz7zSliLy0C1fwQw1mTFLu
         NsJLQOcdLASYC1LEiPlZhxtVGLNNaOcskRd6HE0b8gc7JPfKvvlLesedhEIpo84DRpS1
         CifQ4yor4r+tZf94GLWUDhoCClO8CPyAKpshJd876j3suzTj+YkKgeJOto5mw82QoILb
         OK7tZioPH1yNNKEGeZ5c1rbXfEaxrOYZ+uXZO1QoKoae4BOkZwnof+nMzL8R8eyDMiO7
         WzaIuj/QvsQKb6ms8iDMhPEPOSu/jV1tsccxIe0mo80zq40cVjfhDwCpdSLxG0RJXJQs
         zcew==
X-Received: by 10.236.179.69 with SMTP id g45mr488996yhm.81.1398808824215;
        Tue, 29 Apr 2014 15:00:24 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id q66sm39090853yhj.44.2014.04.29.15.00.21
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Apr 2014 15:00:23 -0700 (PDT)
X-Mailer: git-send-email 1.9.2+fc1.3.gade8541
In-Reply-To: <1398808178-3703-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247620>

18 is younger than person's age.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/add.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/add.c b/builtin/add.c
index 459208a..ac10bab 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -321,7 +321,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 	argc--;
 	argv++;
 
-	if (0 <= addremove_explicit)
+	if (addremove_explicit >= 0)
 		addremove = addremove_explicit;
 	else if (take_worktree_changes && ADDREMOVE_DEFAULT)
 		addremove = 0; /* "-u" was given but not "-A" */
-- 
1.9.2+fc1.3.gade8541
