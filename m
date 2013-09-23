From: Brandon Casey <drafnel@gmail.com>
Subject: [PATCH 04/15] contrib/git-credential-gnome-keyring.c: exit non-zero when called incorrectly
Date: Sun, 22 Sep 2013 22:08:00 -0700
Message-ID: <1379912891-12277-5-git-send-email-drafnel@gmail.com>
References: <1379912891-12277-1-git-send-email-drafnel@gmail.com>
Cc: pah@qo.cx, Brandon Casey <drafnel@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 23 07:09:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VNyOZ-0001yp-Gg
	for gcvg-git-2@plane.gmane.org; Mon, 23 Sep 2013 07:09:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753212Ab3IWFJI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Sep 2013 01:09:08 -0400
Received: from mail-pb0-f41.google.com ([209.85.160.41]:59475 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753156Ab3IWFJG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Sep 2013 01:09:06 -0400
Received: by mail-pb0-f41.google.com with SMTP id rp2so2756795pbb.28
        for <git@vger.kernel.org>; Sun, 22 Sep 2013 22:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LKyRhW+dkcNB3sn17Q+yHxhplxb4ko4Roa5s/ORFiQ4=;
        b=fDKyk639uicu09ts65YEv635tfcAkMFyRMVSWQbPmnpfg/SbX+6zA67OOCdalpyiAm
         nxhQ89rR442mo+p5zQ1fJwOIrXdfe6/lTOAtDUEr/lU+WhKiuzrgbeMuKEgfz0CSsbXy
         rOcjZMfP6ZJmJvwYD8nnu/+VZfKB0X5VmS1tF7WcWoGLYFeJPymtBSKrJbhHKguea63n
         Rx6TYNvtVZOYnJwjW3/svNSqzGv5oWx/JB1mWWOMC0new9paLaifeoOHiXo5RufljGU7
         DaHyHnPmhmsSeAfJFdcpFC4+gPA26ffN7xskrCNPuc93RmOn1fvNErKkXsanBZ9fRsbg
         nBFA==
X-Received: by 10.68.88.161 with SMTP id bh1mr22087839pbb.49.1379912945896;
        Sun, 22 Sep 2013 22:09:05 -0700 (PDT)
Received: from charliebrown.hsd1.ca.comcast.net (c-98-248-40-161.hsd1.ca.comcast.net. [98.248.40.161])
        by mx.google.com with ESMTPSA id sb9sm31437553pbb.0.1969.12.31.16.00.00
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 22 Sep 2013 22:09:05 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.489.g545bc72
In-Reply-To: <1379912891-12277-1-git-send-email-drafnel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235189>

If the correct arguments were not specified, this program should exit
non-zero.  Let's do so.

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---
 contrib/credential/gnome-keyring/git-credential-gnome-keyring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c b/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c
index ad23dbf..5459ba7 100644
--- a/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c
+++ b/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c
@@ -396,7 +396,7 @@ int main(int argc, char *argv[])
 
 	if (!argv[1]) {
 		usage(argv[0]);
-		goto out;
+		exit(EXIT_FAILURE);
 	}
 
 	/* lookup operation callback */
-- 
1.8.4.489.g545bc72
