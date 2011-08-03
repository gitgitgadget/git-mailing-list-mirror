From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH 1bis/2] Diff patterns for POSIX shells
Date: Wed,  3 Aug 2011 07:26:16 +0200
Message-ID: <1312349176-20984-1-git-send-email-giuseppe.bilotta@gmail.com>
References: <7vzkjrem6b.fsf@alter.siamese.dyndns.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Aug 03 07:26:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QoTyY-0001iU-1c
	for gcvg-git-2@lo.gmane.org; Wed, 03 Aug 2011 07:26:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754524Ab1HCF0e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Aug 2011 01:26:34 -0400
Received: from mail-ww0-f42.google.com ([74.125.82.42]:43306 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754463Ab1HCF0c (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2011 01:26:32 -0400
Received: by wwg11 with SMTP id 11so3118042wwg.1
        for <git@vger.kernel.org>; Tue, 02 Aug 2011 22:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=SmFfmWnJ0zxwMeA3FN6PKFZMnb8NULRHZvIO0vy3cBc=;
        b=nJSC3dfwRzH0+NixHBi/G9f41lADDf2lACMLlO8ngTY/zm8b6cLzyVOafW7ryrPJLL
         BlHRsXxH5wPNGgBk5BFsKLcU0dbgfFWB83MWwimqu/Fia9etRDVBM5qzbKu0EWxbbDwC
         M93PnQJavkMQIFwJuRSIcVZ5YoRHEjq8kGtcY=
Received: by 10.227.29.87 with SMTP id p23mr7965303wbc.70.1312349191583;
        Tue, 02 Aug 2011 22:26:31 -0700 (PDT)
Received: from localhost ([151.54.121.1])
        by mx.google.com with ESMTPS id fr7sm379923wbb.5.2011.08.02.22.26.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 02 Aug 2011 22:26:30 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.485.gd947c.dirty
In-Reply-To: <7vzkjrem6b.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178541>

All diffs following a function definition will have that function name
as chunck header, but this is the best we can do with the current
userdiff capabilities.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 userdiff.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/userdiff.c b/userdiff.c
index 01d3a8b..94b1c47 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -107,6 +107,9 @@
 	 "(@|@@|\\$)?[a-zA-Z_][a-zA-Z0-9_]*"
 	 "|[-+0-9.e]+|0[xXbB]?[0-9a-fA-F]+|\\?(\\\\C-)?(\\\\M-)?."
 	 "|//=?|[-+*/<>%&^|=!]=|<<=?|>>=?|===|\\.{1,3}|::|[!=]~"),
+PATTERNS("shell", "^[ \t]*([a-zA-Z_0-9]+)[ \t]*\\(\\).*",
+	 /* -- */
+	 "\\$?[a-zA-Z_0-9]+|&&|\\|\\|"),
 PATTERNS("bibtex", "(@[a-zA-Z]{1,}[ \t]*\\{{0,1}[ \t]*[^ \t\"@',\\#}{~%]*).*$",
 	 "[={}\"]|[^={}\" \t]+"),
 PATTERNS("tex", "^(\\\\((sub)*section|chapter|part)\\*{0,1}\\{.*)$",
-- 
1.7.6.485.gd947c.dirty
