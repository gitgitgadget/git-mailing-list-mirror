From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH] diff: add ruby funcname pattern
Date: Thu, 31 Jul 2008 09:21:48 +0200
Message-ID: <1217488908-19692-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 31 09:22:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOSUk-0001M3-8C
	for gcvg-git-2@gmane.org; Thu, 31 Jul 2008 09:22:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752997AbYGaHVg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2008 03:21:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753042AbYGaHVg
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jul 2008 03:21:36 -0400
Received: from qb-out-0506.google.com ([72.14.204.226]:59316 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752704AbYGaHVe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2008 03:21:34 -0400
Received: by qb-out-0506.google.com with SMTP id a16so422778qbd.17
        for <git@vger.kernel.org>; Thu, 31 Jul 2008 00:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=8r1f2BReuzQUxPf+ULxz+eTQ28Srdt29VcyEoa9CVe0=;
        b=D6OjBklyFzwE2g6Q/Xlrzua2fTPiNHPejO2NS0V8fgWCorbtp2/fpzX3oLwriGhDJI
         n2bO3HVd0HmFqCeI6pLxVToKF545HtiDJuDIVUnqqt4SmQ7qzSJMhzUyC3ky0pjyxqeL
         o+1kVBhNa5vDqr/6aAGb/YuKRZelJtCGPghx8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=G5gU5DIUknfaOurOj2eEG3esFgalfx5fLFx5lEbKOR6ZY5HsqGZluwjqVdmK9T1reT
         ovhSQEKFTe04T90FAL2hV8UzidQ9cOKrqIQI/t2UT8ZpuUPxqvUl6hXIbmBMxFlU7eC8
         lwURmeRFd/EqxSvzey3yxyr6J+kSDn28DGds8=
Received: by 10.180.224.4 with SMTP id w4mr3080850bkg.51.1217488893403;
        Thu, 31 Jul 2008 00:21:33 -0700 (PDT)
Received: from localhost ( [94.37.6.145])
        by mx.google.com with ESMTPS id k29sm2358698fkk.2.2008.07.31.00.21.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 31 Jul 2008 00:21:32 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90903>

Provide a regexp that catches class, module and method definitions in
Ruby scripts, since the built-in default only finds classes.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 diff.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/diff.c b/diff.c
index cbf2547..c253015 100644
--- a/diff.c
+++ b/diff.c
@@ -1381,6 +1381,7 @@ static struct builtin_funcname_pattern {
 			"[A-Za-z_][A-Za-z_0-9]*\\)\\{2,\\}"
 			"[ 	]*([^;]*\\)$" },
 	{ "tex", "^\\(\\\\\\(sub\\)*section{.*\\)$" },
+	{ "ruby", "^\\s*\\(\\(class\\|module\\|def\\)\\s.*\\)$" },
 };
 
 static const char *diff_funcname_pattern(struct diff_filespec *one)
-- 
1.5.6.3
