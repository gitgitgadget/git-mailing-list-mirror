From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] git-remote-mediawiki: do not remove installed files in
 "clean" target
Date: Fri, 8 Nov 2013 18:22:39 -0800
Message-ID: <20131109022239.GI10302@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>,
	Thorsten Glaser <t.glaser@tarent.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 09 03:22:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VeyCG-0002YN-Fa
	for gcvg-git-2@plane.gmane.org; Sat, 09 Nov 2013 03:22:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758001Ab3KICWn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Nov 2013 21:22:43 -0500
Received: from mail-pd0-f173.google.com ([209.85.192.173]:44795 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757939Ab3KICWm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Nov 2013 21:22:42 -0500
Received: by mail-pd0-f173.google.com with SMTP id r10so2888531pdi.18
        for <git@vger.kernel.org>; Fri, 08 Nov 2013 18:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=bm12BgFc4p1nn+IsJTPphmmyHyeG2wFKuV89aAePEbI=;
        b=MSF/r2twVhRTL74j3DhhPIfABR2o/a9XLbw6mSgYhJ8lnlCI8pCdcO2zVN3QVYZMwk
         JqEQ9DBZ3zpwpuKzHcbsfVUUxkpk7GLM4ScStfSzAiMVLVl9Aw4pNuYsSnXsAtBZln9o
         vUGVQFrSm73gx7ZozlUVxT93xx4uMRs0s6jcU9sxRPKxN+F9SLe8k7FnMiaPx6qA5iUL
         O6X0uRrHnt59wAp2e4rgYqryBji2BRAw7Aa3lJPpVdC3sjGEzCgLRYg5iLTDcE59LG9X
         WoLQJyikItc7mvWcI6EXusd35C6/vd46dmC1BscPdQxzcZJqQFX2D+GQdExuM0QMtyFm
         Nhuw==
X-Received: by 10.68.133.198 with SMTP id pe6mr18262024pbb.10.1383963762403;
        Fri, 08 Nov 2013 18:22:42 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id ja5sm15161436pbc.14.2013.11.08.18.22.41
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 08 Nov 2013 18:22:41 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237482>

Running "make clean" after a successful "make install" should not
result in a broken mediawiki remote helper.

Reported-by: Thorsten Glaser <t.glaser@tarent.de>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Thanks for the very pleasant mediawiki remote helper.

 contrib/mw-to-git/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/contrib/mw-to-git/Makefile b/contrib/mw-to-git/Makefile
index f206f96..c5547f9 100644
--- a/contrib/mw-to-git/Makefile
+++ b/contrib/mw-to-git/Makefile
@@ -43,7 +43,6 @@ install: install_pm
 clean:
 	$(MAKE) -C $(GIT_ROOT_DIR) SCRIPT_PERL="$(SCRIPT_PERL_FULL)" \
                 clean-perl-script
-	rm $(INSTLIBDIR)/$(GIT_MEDIAWIKI_PM)
 
 perlcritic:
 	perlcritic -5 $(SCRIPT_PERL)
-- 
1.8.4.1
