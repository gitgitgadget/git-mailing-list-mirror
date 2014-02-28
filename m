From: Sun He <sunheehnus@gmail.com>
Subject: [PATCH] builtin/pack-objects.c:write_pack_file() replace tmpname with pack_tmp_name in warning
Date: Fri, 28 Feb 2014 23:37:11 +0800
Message-ID: <1393601831-17119-1-git-send-email-sunheehnus@gmail.com>
Cc: mhagger@alum.mit.edu, sunshine@sunshineco.com,
	Sun He <sunheehnus@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 28 16:38:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJPWa-0006rr-3H
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 16:38:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752433AbaB1Pik (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 10:38:40 -0500
Received: from mail-pd0-f170.google.com ([209.85.192.170]:57429 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752068AbaB1Pik (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Feb 2014 10:38:40 -0500
Received: by mail-pd0-f170.google.com with SMTP id y10so879872pdj.15
        for <git@vger.kernel.org>; Fri, 28 Feb 2014 07:38:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=aQuS2LnZopDVMDofgijRE0rLsIThgXAiX86DOUjsor4=;
        b=JxFaltdkqeJ5hq+PZUoi/FyueSYM7wK5UtW7LTo8zn/6p+adfZR4CFEmDNpH9V6kKy
         6iVuDzeDYp4vMQ0yb2GGwVeWP9JhpRJZ5AoSXcHKCf82lp0WU07IuXhSy1f7/Y5T03QZ
         MxJn774iavemca7Q7rVBYalqRsHIYulUkfSyzc9jx/ojMXUPESnzOSh9Q9zVK3UAURLw
         36B7f08/G6FxKENo/4HS61e+WbQh51xM4Jy4dcX2elMxc9l88wA6zIrhNkt21bf7omG+
         2Qbi4cZyx6OameqenkWwUUZadeF1zRMR7hTPL7ShehsdTKGQUgmKbM7Uo1smQouvA2Zt
         RHIg==
X-Received: by 10.68.136.162 with SMTP id qb2mr4294389pbb.88.1393601919677;
        Fri, 28 Feb 2014 07:38:39 -0800 (PST)
Received: from ENIGMA.61.134.1.4 ([61.150.43.99])
        by mx.google.com with ESMTPSA id ei4sm7261582pbb.42.2014.02.28.07.38.32
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Feb 2014 07:38:38 -0800 (PST)
X-Mailer: git-send-email 1.9.0.138.g2de3478.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242976>

Signed-off-by: Sun He <sunheehnus@gmail.com>
---
 builtin/pack-objects.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index c733379..4922ce5 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -823,7 +823,7 @@ static void write_pack_file(void)
 				utb.modtime = --last_mtime;
 				if (utime(pack_tmp_name, &utb) < 0)
 					warning("failed utime() on %s: %s",
-						tmpname, strerror(errno));
+						pack_tmp_name, strerror(errno));
 			}
 
 			/* Enough space for "-<sha-1>.pack"? */
-- 
1.9.0.138.g2de3478.dirty
---
The tmpname is uninitialized and it should a bug
