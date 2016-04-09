From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: [PATCH v13 2/6] test-parse-options: print quiet as integer
Date: Sat, 9 Apr 2016 12:23:20 +0000
Message-ID: <01020153faf9fcbb-adadd774-db3a-43ce-b908-d08ac1312b31-000000@eu-west-1.amazonses.com>
References: <01020153faf9fc14-e6ad18fa-c892-4601-bab7-e2cc4cd9e100-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 09 14:23:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aorvL-0004iC-7t
	for gcvg-git-2@plane.gmane.org; Sat, 09 Apr 2016 14:23:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753456AbcDIMX1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Apr 2016 08:23:27 -0400
Received: from a6-245.smtp-out.eu-west-1.amazonses.com ([54.240.6.245]:60864
	"EHLO a6-245.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752934AbcDIMXX (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 9 Apr 2016 08:23:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1460204600;
	h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
	bh=NLgng85Q89D+JCbLTDNH8icghCh3OnnN/HVxNBicOKM=;
	b=fLuPkFqb0OBw+XfJMWcLqC2vMACttARoV42mxZu0TNaJxggA+BtjEgID5YTmRNyD
	kKnK5TOdN3zM4b/YgRSNGxcDx0xIDSuxkwBRMogbGdCayunH+rUpf81R8WQQSbEc7yM
	FD7aDlNxJB8u0YuoLqNN5A/UgilRaEnsfsmijKyM=
In-Reply-To: <01020153faf9fc14-e6ad18fa-c892-4601-bab7-e2cc4cd9e100-000000@eu-west-1.amazonses.com>
X-SES-Outgoing: 2016.04.09-54.240.6.245
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291094>

Current implementation of parse-options.c treats OPT__QUIET() as integer
and not boolean and thus it is more appropriate to print it as integer
to avoid confusion.

Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
---
 t/t0040-parse-options.sh | 26 +++++++++++++-------------
 test-parse-options.c     |  2 +-
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index 477fcff..450da45 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -64,7 +64,7 @@ timestamp: 0
 string: (not set)
 abbrev: 7
 verbose: 0
-quiet: no
+quiet: 0
 dry run: no
 file: (not set)
 EOF
@@ -164,7 +164,7 @@ timestamp: 0
 string: 123
 abbrev: 7
 verbose: 2
-quiet: no
+quiet: 0
 dry run: yes
 file: prefix/my.file
 EOF
@@ -184,7 +184,7 @@ timestamp: 0
 string: 321
 abbrev: 10
 verbose: 2
-quiet: no
+quiet: 0
 dry run: no
 file: prefix/fi.le
 EOF
@@ -212,7 +212,7 @@ timestamp: 0
 string: 123
 abbrev: 7
 verbose: 0
-quiet: no
+quiet: 0
 dry run: no
 file: (not set)
 arg 00: a1
@@ -235,7 +235,7 @@ timestamp: 0
 string: (not set)
 abbrev: 7
 verbose: 0
-quiet: no
+quiet: 0
 dry run: no
 file: (not set)
 EOF
@@ -264,7 +264,7 @@ timestamp: 0
 string: 123
 abbrev: 7
 verbose: 0
-quiet: no
+quiet: 0
 dry run: no
 file: (not set)
 EOF
@@ -303,7 +303,7 @@ timestamp: 0
 string: (not set)
 abbrev: 7
 verbose: 0
-quiet: no
+quiet: 0
 dry run: no
 file: (not set)
 arg 00: --quux
@@ -323,7 +323,7 @@ timestamp: 1
 string: (not set)
 abbrev: 7
 verbose: 0
-quiet: yes
+quiet: 1
 dry run: no
 file: (not set)
 arg 00: foo
@@ -345,7 +345,7 @@ timestamp: 0
 string: (not set)
 abbrev: 7
 verbose: 0
-quiet: no
+quiet: 0
 dry run: no
 file: (not set)
 EOF
@@ -374,7 +374,7 @@ timestamp: 0
 string: (not set)
 abbrev: 7
 verbose: 0
-quiet: no
+quiet: 0
 dry run: no
 file: (not set)
 EOF
@@ -399,7 +399,7 @@ timestamp: 0
 string: (not set)
 abbrev: 7
 verbose: 0
-quiet: no
+quiet: 0
 dry run: no
 file: (not set)
 EOF
@@ -430,7 +430,7 @@ timestamp: 0
 string: (not set)
 abbrev: 7
 verbose: 0
-quiet: no
+quiet: 0
 dry run: no
 file: (not set)
 EOF
@@ -449,7 +449,7 @@ timestamp: 0
 string: (not set)
 abbrev: 7
 verbose: 0
-quiet: no
+quiet: 0
 dry run: no
 file: (not set)
 EOF
diff --git a/test-parse-options.c b/test-parse-options.c
index 2c8c8f1..86afa98 100644
--- a/test-parse-options.c
+++ b/test-parse-options.c
@@ -90,7 +90,7 @@ int main(int argc, char **argv)
 	printf("string: %s\n", string ? string : "(not set)");
 	printf("abbrev: %d\n", abbrev);
 	printf("verbose: %d\n", verbose);
-	printf("quiet: %s\n", quiet ? "yes" : "no");
+	printf("quiet: %d\n", quiet);
 	printf("dry run: %s\n", dry_run ? "yes" : "no");
 	printf("file: %s\n", file ? file : "(not set)");
 

--
https://github.com/git/git/pull/218
