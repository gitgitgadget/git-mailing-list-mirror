From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [RFC][PATCH 01/10] Sparse: fix "non-ANSI function declaration" warnings
Date: Fri, 08 Jun 2007 23:09:32 +0100
Message-ID: <4669D39C.5000904@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Jun 09 00:33:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hwn1P-0005N1-G2
	for gcvg-git@gmane.org; Sat, 09 Jun 2007 00:33:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S971370AbXFHWcd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jun 2007 18:32:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S971368AbXFHWcc
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jun 2007 18:32:32 -0400
Received: from anchor-fallback-93.mail.demon.net ([194.217.242.93]:57548 "EHLO
	anchor-fallback-93.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S971356AbXFHWc3 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Jun 2007 18:32:29 -0400
Received: from anchor-post-30.mail.demon.net ([194.217.242.88]:1512 "EHLO
	anchor-post-30.mail.demon.net") by anchor-fallback-93.mail.demon.net
	with ESMTP id S294322AbXFHWcW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2007 23:32:22 +0100
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-30.mail.demon.net with esmtp (Exim 4.42)
	id 1Hwmxr-0005mn-0z; Fri, 08 Jun 2007 22:29:51 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49514>


Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 config.c          |    2 +-
 merge-recursive.c |    2 +-
 sha1_file.c       |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/config.c b/config.c
index 7b655fd..5754ec2 100644
--- a/config.c
+++ b/config.c
@@ -512,7 +512,7 @@ static int store_aux(const char* key, const char* value)
 	return 0;
 }
 
-static int write_error()
+static int write_error(void)
 {
 	fprintf(stderr, "Failed to write new configuration file\n");
 
diff --git a/merge-recursive.c b/merge-recursive.c
index 8f72b2c..2042004 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -127,7 +127,7 @@ static void output(int v, const char *fmt, ...)
 	va_end(args);
 }
 
-static void flush_output()
+static void flush_output(void)
 {
 	struct output_buffer *b, *n;
 	for (b = output_list; b; b = n) {
diff --git a/sha1_file.c b/sha1_file.c
index be991ed..7b77468 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -412,7 +412,7 @@ static size_t peak_pack_mapped;
 static size_t pack_mapped;
 struct packed_git *packed_git;
 
-void pack_report()
+void pack_report(void)
 {
 	fprintf(stderr,
 		"pack_report: getpagesize()            = %10" SZ_FMT "\n"
-- 
1.5.2
