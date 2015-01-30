From: "Tom G. Christensen" <tgc@statsbiblioteket.dk>
Subject: [PATCH] t9001: use older Getopt::Long boolean prefix '--no' rather than '--no-'
Date: Fri, 30 Jan 2015 07:24:45 +0100
Message-ID: <1422599085-11804-1-git-send-email-tgc@statsbiblioteket.dk>
References: <54CA3611.1000804@statsbiblioteket.dk>
Mime-Version: 1.0
Content-Type: text/plain
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 30 07:24:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YH50h-0002nB-5Q
	for gcvg-git-2@plane.gmane.org; Fri, 30 Jan 2015 07:24:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751798AbbA3GYt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2015 01:24:49 -0500
Received: from sbexch03.sb.statsbiblioteket.dk ([130.225.24.68]:12841 "EHLO
	sbexch03.sb.statsbiblioteket.dk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750909AbbA3GYt (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Jan 2015 01:24:49 -0500
Received: from throll.localdomain (172.18.234.199) by
 sbexch03.sb.statsbiblioteket.dk (130.225.24.68) with Microsoft SMTP Server id
 8.3.348.2; Fri, 30 Jan 2015 07:24:45 +0100
Received: by throll.localdomain (Postfix, from userid 3000)	id D5F02400E6C;
 Fri, 30 Jan 2015 07:24:45 +0100 (CET)
X-Mailer: git-send-email 2.2.2
In-Reply-To: <54CA3611.1000804@statsbiblioteket.dk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263171>

The '--no-xmailer' option is a Getopt::Long boolean option. The
'--no-' prefix (as in --no-xmailer) for boolean options is not
supported in Getopt::Long version 2.32 which was released with Perl 5.8.0.
This version only supports '--no' as in '--noxmailer'.  More recent
versions of Getopt::Long, such as version 2.34, support either prefix. So
use the older form in the tests.

See also:

d2559f734bba7fe5257720356a92f3b7a5b0d37c
907a0b1e04ea31cb368e9422df93d8ebb0187914
84eeb687de7a6c7c42af3fb51b176e0f412a979e
3fee1fe87144360a1913eab86af9ad136c810076

Signed-off-by: Tom G. Christensen <tgc@statsbiblioteket.dk>
---
 t/t9001-send-email.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index af6a3e8..30df6ae 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -1580,20 +1580,20 @@ do_xmailer_test () {
 
 test_expect_success $PREREQ '--[no-]xmailer without any configuration' '
 	do_xmailer_test 1 "--xmailer" &&
-	do_xmailer_test 0 "--no-xmailer"
+	do_xmailer_test 0 "--noxmailer"
 '
 
 test_expect_success $PREREQ '--[no-]xmailer with sendemail.xmailer=true' '
 	test_config sendemail.xmailer true &&
 	do_xmailer_test 1 "" &&
-	do_xmailer_test 0 "--no-xmailer" &&
+	do_xmailer_test 0 "--noxmailer" &&
 	do_xmailer_test 1 "--xmailer"
 '
 
 test_expect_success $PREREQ '--[no-]xmailer with sendemail.xmailer=false' '
 	test_config sendemail.xmailer false &&
 	do_xmailer_test 0 "" &&
-	do_xmailer_test 0 "--no-xmailer" &&
+	do_xmailer_test 0 "--noxmailer" &&
 	do_xmailer_test 1 "--xmailer"
 '
 
-- 
2.2.1
