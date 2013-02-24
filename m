From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 2/4] tests: use a lowercase "usage:" string
Date: Sun, 24 Feb 2013 14:48:39 -0800
Message-ID: <1361746121-56921-2-git-send-email-davvid@gmail.com>
References: <1361746121-56921-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 24 23:49:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9kNa-0001bB-3k
	for gcvg-git-2@plane.gmane.org; Sun, 24 Feb 2013 23:49:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759048Ab3BXWsm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Feb 2013 17:48:42 -0500
Received: from mail-da0-f47.google.com ([209.85.210.47]:44749 "EHLO
	mail-da0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758953Ab3BXWsk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Feb 2013 17:48:40 -0500
Received: by mail-da0-f47.google.com with SMTP id s35so1170922dak.6
        for <git@vger.kernel.org>; Sun, 24 Feb 2013 14:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=UA1Q7btKgJFpCTPBNSSXmAypXeN+7oF1SwLDArvgrNY=;
        b=LmY7h/dHbuTWf+RDMVnW/dYMbi3wT/G6Dngr0ifaFpNF4x7599cn7IqUdyXb5DRXa4
         qWVAs3v53v26NFMU0l6R/l8/yt2R3Y6aLjG22NYWuRG9I1K6UIGBNwgM1BDKbVLn0rUl
         ppTVV4/W1Jj9DIKBq+bbgHLQmObWHkKLehQFs4vdeqnrS5rnXezY2ltFxqRQ1cT0sGZm
         FQcBLDcGSsH9HWxFcNycbSOBAKbp+MU07Qzd8S2svdhPRm/wXSreG+nW4AQPmHrLz6aK
         BriSEG/OZJB/9Ju9INIPHYGRQdh9bss54xFXi5oeIcSaLXcclLm95pNHBut0vxQh/hjO
         s3YQ==
X-Received: by 10.66.251.71 with SMTP id zi7mr15966048pac.153.1361746120117;
        Sun, 24 Feb 2013 14:48:40 -0800 (PST)
Received: from lustrous.fas.fa.disney.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPS id kb3sm10427967pbc.21.2013.02.24.14.48.37
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 24 Feb 2013 14:48:39 -0800 (PST)
X-Mailer: git-send-email 1.7.12.4 (Apple Git-37)
In-Reply-To: <1361746121-56921-1-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217015>

Adjust test commands and test suites so that their
usage strings are consistent with Git.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 t/lib-git-svn.sh          | 2 +-
 t/t1509/prepare-chroot.sh | 2 +-
 test-chmtime.c            | 2 +-
 test-delta.c              | 2 +-
 test-genrandom.c          | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/lib-git-svn.sh b/t/lib-git-svn.sh
index 199f22c..c5e55b1 100644
--- a/t/lib-git-svn.sh
+++ b/t/lib-git-svn.sh
@@ -148,7 +148,7 @@ stop_httpd () {
 convert_to_rev_db () {
 	"$PERL_PATH" -w -- - "$@" <<\EOF
 use strict;
-@ARGV == 2 or die "Usage: convert_to_rev_db <input> <output>";
+@ARGV == 2 or die "usage: convert_to_rev_db <input> <output>";
 open my $wr, '+>', $ARGV[1] or die "$!: couldn't open: $ARGV[1]";
 open my $rd, '<', $ARGV[0] or die "$!: couldn't open: $ARGV[0]";
 my $size = (stat($rd))[7];
diff --git a/t/t1509/prepare-chroot.sh b/t/t1509/prepare-chroot.sh
index c5334a8..6269117 100755
--- a/t/t1509/prepare-chroot.sh
+++ b/t/t1509/prepare-chroot.sh
@@ -14,7 +14,7 @@ xmkdir() {
 
 R="$1"
 
-[ -n "$R" ] || die "Usage: prepare-chroot.sh <root>"
+[ -n "$R" ] || die "usage: prepare-chroot.sh <root>"
 [ -x git ] || die "This script needs to be executed at git source code's top directory"
 [ -x /bin/busybox ] || die "You need busybox"
 
diff --git a/test-chmtime.c b/test-chmtime.c
index 92713d1..02b42ba 100644
--- a/test-chmtime.c
+++ b/test-chmtime.c
@@ -114,6 +114,6 @@ int main(int argc, const char *argv[])
 	return 0;
 
 usage:
-	fprintf(stderr, "Usage: %s %s\n", argv[0], usage_str);
+	fprintf(stderr, "usage: %s %s\n", argv[0], usage_str);
 	return -1;
 }
diff --git a/test-delta.c b/test-delta.c
index af40a3c..4595cd6 100644
--- a/test-delta.c
+++ b/test-delta.c
@@ -23,7 +23,7 @@ int main(int argc, char *argv[])
 	unsigned long from_size, data_size, out_size;
 
 	if (argc != 5 || (strcmp(argv[1], "-d") && strcmp(argv[1], "-p"))) {
-		fprintf(stderr, "Usage: %s\n", usage_str);
+		fprintf(stderr, "usage: %s\n", usage_str);
 		return 1;
 	}
 
diff --git a/test-genrandom.c b/test-genrandom.c
index b3c28d9..54824d0 100644
--- a/test-genrandom.c
+++ b/test-genrandom.c
@@ -12,7 +12,7 @@ int main(int argc, char *argv[])
 	unsigned char *c;
 
 	if (argc < 2 || argc > 3) {
-		fprintf(stderr, "Usage: %s <seed_string> [<size>]\n", argv[0]);
+		fprintf(stderr, "usage: %s <seed_string> [<size>]\n", argv[0]);
 		return 1;
 	}
 
-- 
1.7.12.4 (Apple Git-37)
