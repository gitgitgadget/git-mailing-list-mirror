From: Adam Spiers <git@adamspiers.org>
Subject: [PATCH 1/2] t0008: document test_expect_success_multi
Date: Tue, 19 Feb 2013 14:06:22 +0000
Message-ID: <1361282783-1413-1-git-send-email-git@adamspiers.org>
References: <CAOkDyE_96Ef5CjoxNk3mbsNi+ZAuv6XeHcO7r8RQ-Of5ELsuKw@mail.gmail.com>
Cc: Zoltan Klinger <zoltan.klinger@gmail.com>
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 19 15:06:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7nqM-0005yj-7L
	for gcvg-git-2@plane.gmane.org; Tue, 19 Feb 2013 15:06:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932893Ab3BSOG0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2013 09:06:26 -0500
Received: from coral.adamspiers.org ([85.119.82.20]:32866 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932883Ab3BSOGZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2013 09:06:25 -0500
Received: from localhost (b.e.0.d.8.7.e.f.e.2.f.0.b.1.1.d.0.0.0.0.b.1.4.6.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:641b:0:d11b:f2e:fe78:d0eb])
	by coral.adamspiers.org (Postfix) with ESMTPSA id CD29655AFA;
	Tue, 19 Feb 2013 14:06:23 +0000 (GMT)
X-Mailer: git-send-email 1.8.2.rc0.18.g6ba1fe2.dirty
In-Reply-To: <CAOkDyE_96Ef5CjoxNk3mbsNi+ZAuv6XeHcO7r8RQ-Of5ELsuKw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216618>

test_expect_success_multi() helper function warrants some explanation,
since at first sight it may seem like generic test framework plumbing,
but is in fact specific to testing check-ignore, and allows more
thorough testing of the various output formats without significantly
increase the size of t0008.

Signed-off-by: Adam Spiers <git@adamspiers.org>
---
 t/t0008-ignores.sh | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/t/t0008-ignores.sh b/t/t0008-ignores.sh
index d7df719..ebe7c70 100755
--- a/t/t0008-ignores.sh
+++ b/t/t0008-ignores.sh
@@ -75,6 +75,16 @@ test_check_ignore () {
 	stderr_empty_on_success "$expect_code"
 }
 
+# Runs the same code with 3 different levels of output verbosity,
+# expecting success each time.  Takes advantage of the fact that
+# check-ignore --verbose output is the same as normal output except
+# for the extra first column.
+#
+# Arguments:
+#   - (optional) prereqs for this test, e.g. 'SYMLINKS'
+#   - test name
+#   - output to expect from -v / --verbose mode
+#   - code to run (should invoke test_check_ignore)
 test_expect_success_multi () {
 	prereq=
 	if test $# -eq 4
-- 
1.8.1.291.g0730ed6
