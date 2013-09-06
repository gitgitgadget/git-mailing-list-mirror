From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH v5 6/6] status: add missing blank line after list of "other" files
Date: Fri,  6 Sep 2013 19:43:09 +0200
Message-ID: <1378489389-25802-7-git-send-email-Matthieu.Moy@imag.fr>
References: <vpq38phsvuc.fsf@anie.imag.frvpq38phsvuc.fsf@anie.imag.fr>
 <1378489389-25802-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Sep 06 19:43:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VI04a-0001GB-Sw
	for gcvg-git-2@plane.gmane.org; Fri, 06 Sep 2013 19:43:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750971Ab3IFRnx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Sep 2013 13:43:53 -0400
Received: from mx2.imag.fr ([129.88.30.17]:54084 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750714Ab3IFRnw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Sep 2013 13:43:52 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r86HhShi014298
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 6 Sep 2013 19:43:28 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1VI04A-0000bJ-PJ; Fri, 06 Sep 2013 19:43:30 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1VI04A-0006jf-Fn; Fri, 06 Sep 2013 19:43:30 +0200
X-Mailer: git-send-email 1.8.4.5.g8688bea
In-Reply-To: <1378489389-25802-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 06 Sep 2013 19:43:28 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r86HhShi014298
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1379094209.28884@dnhLOTr6MJK1gjaz6yBXxQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234073>

List of files in other sections ("Changes to be committed", ...) end with
a blank line. It is not the case with the "Untracked files" and "Ignored
files" sections. The issue become particularly visible after the #-prefix
removal, as the last line (e.g. "nothing added to commit but untracked
files present") seems mixed with the untracked files.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 t/t7508-status.sh | 21 +++++++++++++++++++++
 wt-status.c       |  4 +++-
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index d0444d3..9bf9701 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -84,6 +84,7 @@ test_expect_success 'status --column' '
 #
 #	dir1/untracked dir2/untracked output
 #	dir2/modified  expect         untracked
+#
 EOF
 	COLUMNS=50 git -c status.displayCommentPrefix=true status --column="column dense" >output &&
 	test_i18ncmp expect output
@@ -117,6 +118,7 @@ cat >expect <<\EOF
 #	expect
 #	output
 #	untracked
+#
 EOF
 
 test_expect_success 'status with status.displayCommentPrefix=true' '
@@ -167,6 +169,7 @@ Untracked files:
 	expect
 	output
 	untracked
+
 EOF
 
 test_expect_success 'status (advice.statusHints false)' '
@@ -241,6 +244,7 @@ Untracked files:
   (use "git add <file>..." to include in what will be committed)
 
 	dir2/modified
+
 Ignored files:
   (use "git add -f <file>..." to include in what will be committed)
 
@@ -250,6 +254,7 @@ Ignored files:
 	expect
 	output
 	untracked
+
 EOF
 	git status --ignored >output &&
 	test_i18ncmp expect output
@@ -308,6 +313,7 @@ Ignored files:
 	expect
 	output
 	untracked
+
 EOF
 	git status --ignored >output &&
 	test_i18ncmp expect output
@@ -430,6 +436,7 @@ Untracked files:
 	expect
 	output
 	untracked
+
 EOF
 	git status -unormal >output &&
 	test_i18ncmp expect output
@@ -488,6 +495,7 @@ Untracked files:
 	expect
 	output
 	untracked
+
 EOF
 	git status -uall >output &&
 	test_i18ncmp expect output
@@ -548,6 +556,7 @@ Untracked files:
 	../expect
 	../output
 	../untracked
+
 EOF
 	(cd dir1 && git status) >output &&
 	test_i18ncmp expect output
@@ -618,6 +627,7 @@ Untracked files:
 	<BLUE>expect<RESET>
 	<BLUE>output<RESET>
 	<BLUE>untracked<RESET>
+
 EOF
 	test_config color.ui always &&
 	git status | test_decode_color >output &&
@@ -747,6 +757,7 @@ Untracked files:
 	expect
 	output
 	untracked
+
 EOF
 	test_config status.relativePaths false &&
 	(cd dir1 && git status) >output &&
@@ -789,6 +800,7 @@ Untracked files:
 	expect
 	output
 	untracked
+
 EOF
 	git commit --dry-run dir1/modified >output &&
 	test_i18ncmp expect output
@@ -838,6 +850,7 @@ Untracked files:
 	expect
 	output
 	untracked
+
 EOF
 	git status >output &&
 	test_i18ncmp expect output
@@ -902,6 +915,7 @@ Untracked files:
 	expect
 	output
 	untracked
+
 EOF
 	git config status.submodulesummary 10 &&
 	git status >output &&
@@ -952,6 +966,7 @@ Untracked files:
 	expect
 	output
 	untracked
+
 no changes added to commit (use "git add" and/or "git commit -a")
 EOF
 	git commit -m "commit submodule" &&
@@ -1012,6 +1027,7 @@ Untracked files:
 	expect
 	output
 	untracked
+
 EOF
 	git config status.submodulesummary 10 &&
 	git commit --dry-run --amend >output &&
@@ -1066,6 +1082,7 @@ Untracked files:
 	expect
 	output
 	untracked
+
 EOF
 	echo modified  sm/untracked &&
 	git status --ignore-submodules=untracked >output &&
@@ -1177,6 +1194,7 @@ Untracked files:
 	expect
 	output
 	untracked
+
 EOF
 	git status --ignore-submodules=untracked > output &&
 	test_i18ncmp expect output
@@ -1238,6 +1256,7 @@ Untracked files:
 	expect
 	output
 	untracked
+
 EOF
 	git status --ignore-submodules=untracked > output &&
 	test_i18ncmp expect output
@@ -1319,6 +1338,7 @@ cat > expect << EOF
 ;	expect
 ;	output
 ;	untracked
+;
 EOF
 
 test_expect_success "status (core.commentchar with submodule summary)" '
@@ -1352,6 +1372,7 @@ Untracked files:
 	expect
 	output
 	untracked
+
 no changes added to commit (use "git add" and/or "git commit -a")
 EOF
 	git status --ignore-submodules=all > output &&
diff --git a/wt-status.c b/wt-status.c
index 3c795da..2a9ca0f 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -751,7 +751,7 @@ static void wt_status_print_other(struct wt_status *s,
 
 	strbuf_release(&buf);
 	if (!column_active(s->colopts))
-		return;
+		goto conclude;
 
 	strbuf_addf(&buf, "%s%s\t%s",
 		    color(WT_STATUS_HEADER, s),
@@ -765,6 +765,8 @@ static void wt_status_print_other(struct wt_status *s,
 	print_columns(&output, s->colopts, &copts);
 	string_list_clear(&output, 0);
 	strbuf_release(&buf);
+conclude:
+	status_printf_ln(s, GIT_COLOR_NORMAL, "");
 }
 
 static void wt_status_print_verbose(struct wt_status *s)
-- 
1.8.4.5.g8688bea
