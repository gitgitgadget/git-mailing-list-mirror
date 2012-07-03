From: Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH 2/3] gitweb: Handle a few other tags in git_print_log
Date: Tue,  3 Jul 2012 15:02:56 +0900
Message-ID: <1341295377-22083-3-git-send-email-namhyung@kernel.org>
References: <1341295377-22083-1-git-send-email-namhyung@kernel.org>
Cc: git@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
	Namhyung Kim <namhyung.kim@lge.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 03 08:07:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SlwGj-0000R3-K6
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jul 2012 08:07:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933375Ab2GCGHL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jul 2012 02:07:11 -0400
Received: from LGEMRELSE1Q.lge.com ([156.147.1.111]:47075 "EHLO
	LGEMRELSE1Q.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933135Ab2GCGHK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2012 02:07:10 -0400
X-AuditID: 9c93016f-b7bccae00000345c-d2-4ff28c0d82ce
Received: from sejong.aot.lge.com ( [10.177.220.181])
	by LGEMRELSE1Q.lge.com (Symantec Brightmail Gateway) with SMTP id EE.88.13404.D0C82FF4; Tue,  3 Jul 2012 15:07:09 +0900 (KST)
X-Mailer: git-send-email 1.7.10.2
In-Reply-To: <1341295377-22083-1-git-send-email-namhyung@kernel.org>
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200900>

There are many of tags used in s-o-b area. Add
support for a few of well-known ones.

Signed-off-by: Namhyung Kim <namhyung.kim@lge.com>
---
 gitweb/gitweb.perl |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 7585e08..e0701af 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -4485,8 +4485,9 @@ sub git_print_log {
 
 	# print log
 	my $empty = 0;
+	my $tags = "acked|reviewed|reported|tested|suggested"
 	foreach my $line (@$log) {
-		if ($line =~ m/^ *(signed[ \-]off[ \-]by[ :]|acked[ \-]by[ :]|cc[ :])/i) {
+		if ($line =~ m/^ *(signed[ \-]off[ \-]by[ :]|($tags)[ \-]by[ :]|cc[ :])/i) {
 			$empty = 0;
 			if (! $opts{'-remove_signoff'}) {
 				print "<span class=\"signoff\">" . esc_html($line) . "</span><br/>\n";
-- 
1.7.10.2
