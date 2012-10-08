From: Ben Walton <bdwalton@gmail.com>
Subject: [PATCH] t/t5400-send-pack: Use POSIX options to cp for portability
Date: Mon,  8 Oct 2012 09:08:01 +0100
Message-ID: <1349683681-18978-1-git-send-email-bdwalton@gmail.com>
Cc: Ben Walton <bdwalton@gmail.com>
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 08 10:08:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TL8Ny-0005fA-NZ
	for gcvg-git-2@plane.gmane.org; Mon, 08 Oct 2012 10:08:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751831Ab2JHIIM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Oct 2012 04:08:12 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:35694 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751113Ab2JHIIK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Oct 2012 04:08:10 -0400
Received: by mail-wg0-f44.google.com with SMTP id dr13so3537189wgb.1
        for <git@vger.kernel.org>; Mon, 08 Oct 2012 01:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=dv4IjJNu9aGYxU/fupNbO25nMgju7FyTJ2k7lJZtkHw=;
        b=yeGYy78w+hoHtkiYBsJiqybitg9lihCLbI39WsZ6i+A30Fi8ROl+ovUZ2yNJ8cgqBc
         9imPjkVfJzkM1gU7NWSx+g20PbThUFkobvQNanhEr1B8Ka8ul4RipGfld2KV4G8rRso3
         eGe/zDAo0NwNgir7qJMicGl4a/FI6qi/U8sycQ9qFRW3Y4pQTpxRcix4JMGU8wts/40/
         9J4PyifkyVkbjZfX65SjULWFF5hGwYdIok2/hkkjXF8yqdf3RUvMzxf7MNToZCcJCZAZ
         t5jf84ImvPDX0XSp65VOUjCaGw+xbwA3scbwKeL0HYNG9gU4ETGiSUbUIe7ykVvr4g6X
         IS/g==
Received: by 10.216.53.193 with SMTP id g43mr8811632wec.67.1349683689402;
        Mon, 08 Oct 2012 01:08:09 -0700 (PDT)
Received: from gilmour.chass.utoronto.ca ([89.100.144.161])
        by mx.google.com with ESMTPS id j8sm18334149wiy.9.2012.10.08.01.08.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 08 Oct 2012 01:08:08 -0700 (PDT)
Received: from bwalton by gilmour.chass.utoronto.ca with local (Exim 4.76)
	(envelope-from <bdwalton@gmail.com>)
	id 1TL8Nj-0004wj-0h; Mon, 08 Oct 2012 09:08:07 +0100
X-Mailer: git-send-email 1.7.9.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207225>

Avoid a GNU-ism in the cp options used by t5400-send-pack.  Change -a
to -pR.

Signed-off-by: Ben Walton <bdwalton@gmail.com>
---
 t/t5400-send-pack.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5400-send-pack.sh b/t/t5400-send-pack.sh
index 250c720..65b3b0f 100755
--- a/t/t5400-send-pack.sh
+++ b/t/t5400-send-pack.sh
@@ -159,7 +159,7 @@ test_expect_success 'receive-pack runs auto-gc in remote repo' '
 	    git commit -a -m "Second commit" &&
 	    git repack
 	) &&
-	cp -a parent child &&
+	cp -pR parent child &&
 	(
 	    # Set the child to auto-pack if more than one pack exists
 	    cd child &&
-- 
1.7.12
