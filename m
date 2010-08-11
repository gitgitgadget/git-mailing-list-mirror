From: Petr Onderka <gsvick@gmail.com>
Subject: [PATCH] Userdiff patterns for C#
Date: Wed, 11 Aug 2010 01:09:21 +0000
Message-ID: <1281488961-5884-1-git-send-email-gsvick@gmail.com>
Cc: Bjorn Steinbrink <B.Steinbrink@gmx.de>,
	Paolo Bonzini <bonzini@gnu.org>,
	Petr Onderka <gsvick@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 11 03:10:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OizpX-0000UU-7d
	for gcvg-git-2@lo.gmane.org; Wed, 11 Aug 2010 03:10:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758279Ab0HKBJ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Aug 2010 21:09:58 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:58377 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758161Ab0HKBJ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Aug 2010 21:09:56 -0400
Received: by bwz3 with SMTP id 3so2313774bwz.19
        for <git@vger.kernel.org>; Tue, 10 Aug 2010 18:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:x-antivirus:x-antivirus-status;
        bh=4e/fkZI2nI+Ky0zCdL9Z2HRELhDt3ibl6IeT0beB+eI=;
        b=Wp/P+kY/QjimLkoY4XyOmJ71LAX82cU6GfpT/ktr3364PBGzo9sC0pxc3QOQsJLNPf
         HVD8CjSfMV6s96iL9vh6Gra23kIBvqCalhBMNEGRz4OXsteBhQlOS7fgclwChPatqaNE
         XjQIZpWmITHOY3KN+UZmdk47LUfRetzEyLIgM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:x-antivirus
         :x-antivirus-status;
        b=r0Hw7uXFoZmc4gJ7158hsy7g8QRBSIopF60ZcDtylui+4KouiNoeirsNNwP8Up84UP
         Qpof2xHFC7teNVr8//+LTv7WZrmjz3RkO242MHwZJcTu2uJ/5SH6217o83oQO9Zssax2
         W5uEm36dFYsI1VO2EVNykbgZ/kBQJPB+FvnTk=
Received: by 10.204.73.130 with SMTP id q2mr4719391bkj.137.1281488995153;
        Tue, 10 Aug 2010 18:09:55 -0700 (PDT)
Received: from localhost (217-112-171-197.cust.avonet.cz [217.112.171.197])
        by mx.google.com with ESMTPS id bq20sm4670465bkb.16.2010.08.10.18.09.53
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 10 Aug 2010 18:09:54 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.msysgit.0.10.g9ffa0
X-Antivirus: avast! (VPS 100810-1, 10.08.2010), Outbound message
X-Antivirus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153182>

Add userdiff patterns for C#. This code is an improved version of
code by Adam Petaccia from 21 June 2009 mail to the list.

Signed-off-by: Petr Onderka <gsvick@gmail.com>
---
I was looking how to properly set up hunk-headers for C# and found
a mail from Adam Petaccia to this list, that almost did what I wanted.
It was never included, so I improved it and I hope it can be added
to the official repository now.

 t/t4018-diff-funcname.sh |    2 +-
 userdiff.c               |   16 ++++++++++++++++
 2 files changed, 17 insertions(+), 1 deletions(-)

diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
index 5b10e97..61de8a2 100755
--- a/t/t4018-diff-funcname.sh
+++ b/t/t4018-diff-funcname.sh
@@ -32,7 +32,7 @@ EOF
 
 sed 's/beer\\/beer,\\/' < Beer.java > Beer-correct.java
 
-builtin_patterns="bibtex cpp html java objc pascal php python ruby tex"
+builtin_patterns="bibtex cpp csharp html java objc pascal php python ruby tex"
 for p in $builtin_patterns
 do
 	test_expect_success "builtin $p pattern compiles" '
diff --git a/userdiff.c b/userdiff.c
index c49cc1b..e552215 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -82,6 +82,22 @@ PATTERNS("cpp",
 	 "|[-+0-9.e]+[fFlL]?|0[xXbB]?[0-9a-fA-F]+[lL]?"
 	 "|[-+*/<>%&^|=!]=|--|\\+\\+|<<=?|>>=?|&&|\\|\\||::|->"
 	 "|[^[:space:]]|[\x80-\xff]+"),
+PATTERNS("csharp",
+	 /* Keywords */
+	 "!^[ \t]*(do|while|for|if|else|instanceof|new|return|switch|case|throw|catch|using)\n"
+	 /* Methods and constructors */
+	 "^[ \t]*(((static|public|internal|private|protected|new|virtual|sealed|override|unsafe)[ \t]+)*[][<>@.~_[:alnum:]]+[ \t]+[<>@._[:alnum:]]+[ \t]*\\(.*\\))[ \t]*$\n"
+	 /* Properties */
+	 "^[ \t]*(((static|public|internal|private|protected|new|virtual|sealed|override|unsafe)[ \t]+)*[][<>@.~_[:alnum:]]+[ \t]+[@._[:alnum:]]+)[ \t]*$\n"
+	 /* Type definitions */
+	 "^[ \t]*(((static|public|internal|private|protected|new|unsafe|sealed|abstract|partial)[ \t]+)*(class|enum|interface|struct)[ \t]+.*)$\n"
+	 /* Namespace */
+	 "^[ \t]*(namespace[ \t]+.*)$",
+	 /* -- */
+	 "[a-zA-Z_][a-zA-Z0-9_]*"
+	 "|[-+0-9.e]+[fFlL]?|0[xXbB]?[0-9a-fA-F]+[lL]?"
+	 "|[-+*/<>%&^|=!]=|--|\\+\\+|<<=?|>>=?|&&|\\|\\||::|->"
+	 "|[^[:space:]]|[\x80-\xff]+"),
 { "default", NULL, -1, { NULL, 0 } },
 };
 #undef PATTERNS
-- 
1.7.1.msysgit.0.10.g9ffa0
