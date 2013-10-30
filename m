From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 01/23] t5510: use the correct tag name in test
Date: Wed, 30 Oct 2013 06:32:50 +0100
Message-ID: <1383111192-23780-2-git-send-email-mhagger@alum.mit.edu>
References: <1383111192-23780-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org,
	=?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>,
	Michael Schubert <mschub@elegosoft.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	John Szakmeister <john@szakmeister.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 30 06:34:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbOQh-0005z8-Ns
	for gcvg-git-2@plane.gmane.org; Wed, 30 Oct 2013 06:34:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752578Ab3J3Fe0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Oct 2013 01:34:26 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:60302 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752157Ab3J3Fdx (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Oct 2013 01:33:53 -0400
X-AuditID: 1207440f-b7f306d000006d99-a6-52709a41ab02
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 78.FF.28057.14A90725; Wed, 30 Oct 2013 01:33:53 -0400 (EDT)
Received: from localhost.localdomain (p57A242F8.dip0.t-ipconnect.de [87.162.66.248])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r9U5XbIC014009
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 30 Oct 2013 01:33:51 -0400
X-Mailer: git-send-email 1.8.4.1
In-Reply-To: <1383111192-23780-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOIsWRmVeSWpSXmKPExsUixO6iqOs4qyDIoHsBq8X0rtUsFl1Xupks
	GnqvMFvMu7uLyWLVrWXMFitn3GC0uL1iPrPF085Ki3kvXrBZ/GjpYXbg8vj7/gOTx6V1L5k8
	Dv2Zwu7x7EQ7m8ell9/ZPJ717mH0uHhJ2WNGy2sWj8+b5DwOXH7MFsAVxW2TlFhSFpyZnqdv
	l8Cd8XTSGtaCR2wVk+/oNzCeZu1i5OSQEDCR2HDlEhOELSZx4d56ti5GLg4hgcuMEpdb/0E5
	V5gk3n98xAJSxSagK7GopxmsQ0RATWJi2yEWkCJmgYnMEsenLwIrEhZwlPg6ZzaYzSKgKvGl
	dS3QJA4OXgEXiTlfrCG2KUjcaJ4KdgWngKvEp1032UFsIaCSpvbP7BMYeRcwMqxilEvMKc3V
	zU3MzClOTdYtTk7My0st0jXRy80s0UtNKd3ECAla/h2MXetlDjEKcDAq8fAaPMgPEmJNLCuu
	zD3EKMnBpCTKmzalIEiILyk/pTIjsTgjvqg0J7X4EKMEB7OSCO/040DlvCmJlVWpRfkwKWkO
	FiVxXvUl6n5CAumJJanZqakFqUUwWRkODiUJXuWZQEMFi1LTUyvSMnNKENJMHJwgggtkAw/Q
	Bh6QQt7igsTc4sx0iKJTjIpS4rwKIAkBkERGaR7cAFh6ecUoDvSPMEQ7DzA1wXW/AhrMBDR4
	D0seyOCSRISUVAOjw2N9z2fdaVqZhr7fHv73vaHWd3/npLuHnp89wKKiwuXyJeNA+ZJMzQ8/
	PzKIsb4rEhMP5VThMCgV0rXaYZY3wyJ3uhSHUWP9g8APW7mPdJ2Rmvy1qMBx4obF 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236964>

Fix an apparent copy-paste error: A few lines earlier, a tag
"refs/tags/sometag" is created.  Check for the (non-)existence of that
tag, not "somebranch", which is otherwise never mentioned in the
script.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 t/t5510-fetch.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 1f0f8e6..c5e5dfc 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -121,7 +121,7 @@ test_expect_success 'fetch --prune --tags does not delete the remote-tracking br
 
 	git fetch --prune --tags origin &&
 	git rev-parse origin/master &&
-	test_must_fail git rev-parse somebranch
+	test_must_fail git rev-parse sometag
 '
 
 test_expect_success 'fetch --prune --tags with branch does not delete other remote-tracking branches' '
-- 
1.8.4.1
