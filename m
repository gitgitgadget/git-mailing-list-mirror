From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: [PATCH] t/README: Add a note about running commands under valgrind
Date: Tue, 15 Mar 2011 10:32:11 +0100
Message-ID: <1300181536.19100.7.camel@bee.lab.cmartin.tk>
References: <1300130318-11279-1-git-send-email-cmn@elego.de>
	 <1300130318-11279-3-git-send-email-cmn@elego.de>
	 <7v7hc1cvdt.fsf@alter.siamese.dyndns.org>
	 <1300140119.4320.38.camel@bee.lab.cmartin.tk>
	 <20110315011230.GA31865@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 15 10:32:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzQc9-0006Ul-8D
	for gcvg-git-2@lo.gmane.org; Tue, 15 Mar 2011 10:32:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753510Ab1COJcY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Mar 2011 05:32:24 -0400
Received: from mx0.elegosoft.com ([88.198.54.133]:32947 "EHLO
	mx0.elegosoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752841Ab1COJcX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2011 05:32:23 -0400
Received: from localhost (localhost [127.0.0.1])
	by mx0.elegosoft.com (Postfix) with ESMTP id 39AD01B4BAD;
	Tue, 15 Mar 2011 10:32:22 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mx0.elegosoft.com
Received: from mx0.elegosoft.com ([127.0.0.1])
	by localhost (mx0.elegosoft.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id J3Laxq82xLky; Tue, 15 Mar 2011 10:32:16 +0100 (CET)
Received: from [10.10.10.234] (i59F7870A.versanet.de [89.247.135.10])
	by mx0.elegosoft.com (Postfix) with ESMTPSA id 1845B1B4AFF;
	Tue, 15 Mar 2011 10:32:16 +0100 (CET)
In-Reply-To: <20110315011230.GA31865@sigill.intra.peff.net>
X-Mailer: Evolution 2.91.92 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169055>

The test suite runs valgrind with certain options activated. Add a
note saying how to run commands under the same conditions as the test
suite does.

Signed-off-by: Carlos Mart=C3=ADn Nieto <cmn@elego.de>
---

 As Jeff pointed out, the test suite does use --leak-check=3Dno. I was
using valgrind manually as I was chasing a different error that does
show up. How about adding this to the README?

 t/README |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/t/README b/t/README
index 78c9e65..2a73fc3 100644
--- a/t/README
+++ b/t/README
@@ -98,6 +98,13 @@ appropriately before running "make".
 	not see any output, this option implies --verbose.  For
 	convenience, it also implies --tee.
=20
+	*NOTE*: As the git process is short-lived and some errors are
+	not interesting, valgrind is run with (among others) the
+	option --leak-check=3Dno. In order to run a single command under
+	the same conditions manually, you should set GIT_VALGRIND to
+	point to the 't/valgrind/' directory and use the commands
+	under 't/valgrind/bin/'.
+
 --tee::
 	In addition to printing the test output to the terminal,
 	write it to files named 't/test-results/$TEST_NAME.out'.
--=20
1.7.4.1
