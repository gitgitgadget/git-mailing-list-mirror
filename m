From: Sup Yut Sum <ch3cooli@gmail.com>
Subject: [PATCH 1/2] userdiff: support C# async methods and correct C# keywords
Date: Mon,  2 Jun 2014 12:13:24 +0800
Message-ID: <1401682405-3319-1-git-send-email-ch3cooli@gmail.com>
Cc: gitster@pobox.com, Sup Yut Sum <ch3cooli@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 02 06:13:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WrJd4-00015I-32
	for gcvg-git-2@plane.gmane.org; Mon, 02 Jun 2014 06:13:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751000AbaFBENl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2014 00:13:41 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:64272 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750702AbaFBENl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2014 00:13:41 -0400
Received: by mail-pa0-f52.google.com with SMTP id bj1so3452215pad.11
        for <git@vger.kernel.org>; Sun, 01 Jun 2014 21:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=nWanV7b0jHBaxiZOGxyQP0hxlyXdmJ8CyZ6TzQcbO2o=;
        b=BwXY96eifL199n2q9KIeF/sKnKqFROJCaIU382Uw2ioD/cq82mUJWXh6mZSs6Tj2vy
         FlhFLn8L25JOmjs99uj8wYAcslhoBsDDgmsV8Dx4moinZoGL+dojJ5byoes7Hdm4ta/I
         k4mHMJQVQD6CCTAKvSxkyd+//kuBSDzhCrNwUsD0ed5284Tl00WS9PtYcJ7GgmIseINN
         XB+89NMleMP589V5XtqgT86e4MQAGugG/kSfGUUvVhj88zMkR47Yw+05Wv2s7KteoofY
         S82n99a6uAVVGCCicpBoHsonLm1eUIPBdzLwGV3dT2b0SWecbIPhqNyJ1twOvfPvgWly
         sUHQ==
X-Received: by 10.66.176.196 with SMTP id ck4mr38289008pac.154.1401682420556;
        Sun, 01 Jun 2014 21:13:40 -0700 (PDT)
Received: from localhost.localdomain (n219079230136.netvigator.com. [219.79.230.136])
        by mx.google.com with ESMTPSA id pn4sm9593164pbb.7.2014.06.01.21.13.37
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 01 Jun 2014 21:13:39 -0700 (PDT)
X-Mailer: git-send-email 1.9.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250548>

async is in C# 5.0
foreach is in C# 1.0
instanceof is in Java. The similar keywords are typeof, is, as in C# 1.0
default, try are in C# 1.0

Signed-off-by: Sup Yut Sum <ch3cooli@gmail.com>
---
 userdiff.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/userdiff.c b/userdiff.c
index fad52d6..96eda6c 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -134,9 +134,9 @@ PATTERNS("cpp",
 	 "|[-+*/<>%&^|=!]=|--|\\+\\+|<<=?|>>=?|&&|\\|\\||::|->\\*?|\\.\\*"),
 PATTERNS("csharp",
 	 /* Keywords */
-	 "!^[ \t]*(do|while|for|if|else|instanceof|new|return|switch|case|throw|catch|using)\n"
+	 "!^[ \t]*(do|while|for|foreach|if|else|typeof|is|as|new|return|switch|case|default|throw|try|catch|using)\n"
 	 /* Methods and constructors */
-	 "^[ \t]*(((static|public|internal|private|protected|new|virtual|sealed|override|unsafe)[ \t]+)*[][<>@.~_[:alnum:]]+[ \t]+[<>@._[:alnum:]]+[ \t]*\\(.*\\))[ \t]*$\n"
+	 "^[ \t]*(((static|public|internal|private|protected|new|virtual|sealed|override|unsafe|async)[ \t]+)*[][<>@.~_[:alnum:]]+[ \t]+[<>@._[:alnum:]]+[ \t]*\\(.*\\))[ \t]*$\n"
 	 /* Properties */
 	 "^[ \t]*(((static|public|internal|private|protected|new|virtual|sealed|override|unsafe)[ \t]+)*[][<>@.~_[:alnum:]]+[ \t]+[@._[:alnum:]]+)[ \t]*$\n"
 	 /* Type definitions */
-- 
1.9.1
