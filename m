From: Petr Onderka <gsvick@gmail.com>
Subject: [PATCH v2] Userdiff patterns for C#
Date: Mon, 16 Aug 2010 17:01:02 +0000
Message-ID: <1281978062-5772-1-git-send-email-gsvick@gmail.com>
References: <20100811193739.GC8106@coredump.intra.peff.net>
Cc: Jeff King <peff@peff.net>, Bjorn Steinbrink <B.Steinbrink@gmx.de>,
	Paolo Bonzini <bonzini@gnu.org>,
	Petr Onderka <gsvick@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 16 19:01:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ol34J-0005al-BH
	for gcvg-git-2@lo.gmane.org; Mon, 16 Aug 2010 19:01:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755344Ab0HPRBl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Aug 2010 13:01:41 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:51892 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751225Ab0HPRBk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Aug 2010 13:01:40 -0400
Received: by bwz3 with SMTP id 3so2848848bwz.19
        for <git@vger.kernel.org>; Mon, 16 Aug 2010 10:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:x-antivirus
         :x-antivirus-status;
        bh=AqR9jhj5yBCFdx0QVrYGog92eHTUWhSZvC4nqdbYkJY=;
        b=fOjlSqHFv9i06DQHFR/MagAzWJwVFCaohJ0rVXnQXgVXmWJ2QKHgWXoHFU0KDVlqae
         XL68ZdVRBoGha+69ig+yKvmbVFwhGbhIdN5qFRDlMM14zrhCOGoQDTSJ5w6pMQsarlZ+
         fIsE1zGGblcd6quBpDZTmL/HTYyOU5QKwMyV0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-antivirus:x-antivirus-status;
        b=VWNNBkhGABY3rTOE4TXaYvSOtm7rb8pfCBhioWNtfVEjKFWtnCtGlV6OhF8OR1xMIv
         ZimqZwN0rPccClBGdvSH8pBWfaEzn4JF8rMODUksccgAJPYug2ICSJ1NzUKzFOIQsBiV
         SOnVM2XwDWVodIlwVGXL52MDnUP2M+gfR5Ii4=
Received: by 10.204.136.71 with SMTP id q7mr3520772bkt.111.1281978098880;
        Mon, 16 Aug 2010 10:01:38 -0700 (PDT)
Received: from localhost (217-112-171-197.cust.avonet.cz [217.112.171.197])
        by mx.google.com with ESMTPS id bq20sm4466229bkb.4.2010.08.16.10.01.36
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 16 Aug 2010 10:01:38 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.2361.g5f8e3
In-Reply-To: <20100811193739.GC8106@coredump.intra.peff.net>
X-Antivirus: avast! (VPS 100816-0, 16.08.2010), Outbound message
X-Antivirus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153665>

Add userdiff patterns for C#. This code is an improved version of
code by Adam Petaccia from 21 June 2009 mail to the list.

Signed-off-by: Petr Onderka <gsvick@gmail.com>
---
Added the documentation.

 Documentation/gitattributes.txt |    2 ++
 t/t4018-diff-funcname.sh        |    2 +-
 userdiff.c                      |   16 ++++++++++++++++
 3 files changed, 19 insertions(+), 1 deletions(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 564586b..2e2370c 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -441,6 +441,8 @@ patterns are available:
 
 - `cpp` suitable for source code in the C and C++ languages.
 
+- `csharp` suitable for source code in the C# language.
+
 - `html` suitable for HTML/XHTML documents.
 
 - `java` suitable for source code in the Java language.
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
1.7.2.1.2358.g07fa
