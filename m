From: Adam Petaccia <adam@tpetaccia.com>
Subject: [PATCH] Add matchings for csharp
Date: Sun, 21 Jun 2009 19:52:49 -0400
Message-ID: <1245628369.15870.1.camel@belthazor>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 22 01:53:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MIWqf-0004KW-AK
	for gcvg-git-2@gmane.org; Mon, 22 Jun 2009 01:53:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754142AbZFUXw6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Jun 2009 19:52:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753470AbZFUXw6
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Jun 2009 19:52:58 -0400
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:61429 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753962AbZFUXw6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jun 2009 19:52:58 -0400
Received: from [192.168.1.5] (really [65.190.241.253])
          by cdptpa-omta02.mail.rr.com with ESMTP
          id <20090621235258526.LHRM22702@cdptpa-omta02.mail.rr.com>
          for <git@vger.kernel.org>; Sun, 21 Jun 2009 23:52:58 +0000
X-Mailer: Evolution 2.26.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122003>

I'm not sure if this is the correct place to send patches, please direct 
me if I've addressed the wrong list.
---
 t/t4018-diff-funcname.sh |    2 +-
 userdiff.c               |   10 ++++++++++
 2 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
index 5b10e97..704dae8 100755
--- a/t/t4018-diff-funcname.sh
+++ b/t/t4018-diff-funcname.sh
@@ -32,7 +32,7 @@ EOF
 
 sed 's/beer\\/beer,\\/' < Beer.java > Beer-correct.java
 
-builtin_patterns="bibtex cpp html java objc pascal php python ruby tex"
+builtin_patterns="bibtex csharp cpp html java objc pascal php python ruby tex"
 for p in $builtin_patterns
 do
 	test_expect_success "builtin $p pattern compiles" '
diff --git a/userdiff.c b/userdiff.c
index 57529ae..d4151b2 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -79,6 +79,16 @@ PATTERNS("cpp",
 	 "|[-+0-9.e]+[fFlL]?|0[xXbB]?[0-9a-fA-F]+[lL]?"
 	 "|[-+*/<>%&^|=!]=|--|\\+\\+|<<=?|>>=?|&&|\\|\\||::|->"
 	 "|[^[:space:]]|[\x80-\xff]+"),
+PATTERNS("csharp",
+	 "!^[ \t]*(catch|do|for|if|instanceof|new|return|switch|throw|while)\n"
+	 "^([ \t]*(static|public|internal|private|protected|new|unsafe|readonly|volatile)[ \t]+(class|enum|interface|struct).*)$\n"
+	 "^([ \t]*(namespace)[ \t]+.*)$"
+	 ,
+	 /* -- */
+	 "[a-zA-Z_][a-zA-Z0-9_]*"
+	 "|[-+0-9.e]+[fFlL]?|0[xXbB]?[0-9a-fA-F]+[lL]?"
+	 "|[-+*/<>%&^|=!]=|--|\\+\\+|<<=?|>>=?|&&|\\|\\||::|->"
+	 "|[^[:space:]]|[\x80-\xff]+"),
 { "default", NULL, -1, { NULL, 0 } },
 };
 #undef PATTERNS
-- 
1.6.0.4
