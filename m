From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: [PATCH v12 2/5] test-parse-options: print quiet as integer
Date: Sat, 2 Apr 2016 23:33:11 +0000
Message-ID: <01020153d952be64-9ca893f1-5a7b-4a2c-a0bd-98abf93a17ac-000000@eu-west-1.amazonses.com>
References: <01020153d952bd99-d3812bd6-d189-4780-ab48-f015696e9cf0-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 03 01:33:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1amV2h-0002Ng-5f
	for gcvg-git-2@plane.gmane.org; Sun, 03 Apr 2016 01:33:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751544AbcDBXdT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Apr 2016 19:33:19 -0400
Received: from a7-12.smtp-out.eu-west-1.amazonses.com ([54.240.7.12]:44540
	"EHLO a7-12.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751225AbcDBXdO (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 2 Apr 2016 19:33:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1459639991;
	h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
	bh=cIl9E31v7MycbWBrIze/K2W8hRyfAgXBoQwFeUky6Z4=;
	b=CfwVzxruS17QPeOogmOefZHhCKBfeMVEFBDMTP9B2UKPTRfeud06YO93maQ+n5HP
	6r1Uw0PgIsrSXMk01o50ORPfjromBN1ZBV1zP2d/Z/L8PcuchTcmeV8xtG1BUxDC/6b
	up5qLbr39lp5dGEAS4shVjKqn1wmTvt/7/aX7E+o=
In-Reply-To: <01020153d952bd99-d3812bd6-d189-4780-ab48-f015696e9cf0-000000@eu-west-1.amazonses.com>
X-SES-Outgoing: 2016.04.02-54.240.7.12
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290614>

Current implementation of parse-options.c treats OPT__QUIET() as integer
and not boolean and thus it is more appropriate to print it as integer
to avoid confusion.

Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
---
 t/t0040-parse-options.sh | 26 +++++++++++++-------------
 test-parse-options.c     |  2 +-
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index c6f205b..302c315 100755
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
