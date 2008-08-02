From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH] diff: chapter and part in funcname for tex
Date: Sat,  2 Aug 2008 08:35:45 +0200
Message-ID: <1217658945-29908-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 02 08:36:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPAjD-00010t-SQ
	for gcvg-git-2@gmane.org; Sat, 02 Aug 2008 08:36:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751913AbYHBGf3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Aug 2008 02:35:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751912AbYHBGf3
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Aug 2008 02:35:29 -0400
Received: from mu-out-0910.google.com ([209.85.134.191]:10024 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751863AbYHBGf2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Aug 2008 02:35:28 -0400
Received: by mu-out-0910.google.com with SMTP id w8so1919977mue.1
        for <git@vger.kernel.org>; Fri, 01 Aug 2008 23:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=xXemyGd0F60T/7SopebUnecs5ZsH6I2arrgpy1aGv4A=;
        b=RTvqJ5Rh9ULjkj+HJ+o/R1BroF96ZA/Uoa8vppuldanwJcubZk18UledjTP8aLj9T+
         6L9YEwliaB/nfJ+TifQrw0XzmslYl9Nx6dXSV3/VZ0dbCvaCjikjX+/ePzoTCTPKLQa+
         qnmp31nXDz0BxrzRXaZ+QxsVKUb0kqgfjDYEI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=ms2otn4i9Qfhcl16l3TRT/fB8I/eiTSYgLl3PTDp2xRd0SMnb5rX/y527q6EwtjaMr
         /rcMTtwiILBrGdPSUL1ffWjiJTitN78gvXaKK4YElvVBH4iZ5ew+30hfPlAtCGnKGO4/
         DPGY5vqVFX2OFZLjJqDPt61btETi680oHelPE=
Received: by 10.181.24.14 with SMTP id b14mr4350587bkj.22.1217658926059;
        Fri, 01 Aug 2008 23:35:26 -0700 (PDT)
Received: from localhost ( [94.37.6.145])
        by mx.google.com with ESMTPS id 13sm2093646fks.6.2008.08.01.23.35.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 01 Aug 2008 23:35:25 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91135>

This patch enhances the tex funcname by adding support for
chapter and part sectioning commands. It also matches
the starred version of the sectioning commands.
---

I know that technically speaking this should have been two
separate patches because they are two logically separate
changes, but they are really rather braindead so please
accept them as one :)

 diff.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/diff.c b/diff.c
index c253015..776bce1 100644
--- a/diff.c
+++ b/diff.c
@@ -1380,7 +1380,7 @@ static struct builtin_funcname_pattern {
 			"^[ 	]*\\(\\([ 	]*"
 			"[A-Za-z_][A-Za-z_0-9]*\\)\\{2,\\}"
 			"[ 	]*([^;]*\\)$" },
-	{ "tex", "^\\(\\\\\\(sub\\)*section{.*\\)$" },
+	{ "tex", "^\\(\\\\\\(\\(sub\\)*section\\|chapter\\|part\\)\\*\\?{.*\\)$" },
 	{ "ruby", "^\\s*\\(\\(class\\|module\\|def\\)\\s.*\\)$" },
 };
 
-- 
1.5.6.3
