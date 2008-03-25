From: Junio C Hamano <junio@pobox.com>
Subject: [PATCH 2/5] test_must_fail: 129 is a valid error code from usage()
Date: Mon, 24 Mar 2008 23:59:16 -0700
Message-ID: <7vbq53nvaz.fsf@gitster.siamese.dyndns.org>
References: <200803232150.29971.barra_cuda@katamail.com>
 <200803241502.21465.barra_cuda@katamail.com>
 <7vwsnrubmd.fsf@gitster.siamese.dyndns.org>
 <200803242218.44026.barra_cuda@katamail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Michele Ballabio <barra_cuda@katamail.com>
X-From: git-owner@vger.kernel.org Tue Mar 25 08:00:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Je38r-0002sm-T3
	for gcvg-git-2@gmane.org; Tue, 25 Mar 2008 08:00:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752732AbYCYG7f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Mar 2008 02:59:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752717AbYCYG7f
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Mar 2008 02:59:35 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:57885 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752654AbYCYG7e (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2008 02:59:34 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 65A0C2F84;
	Tue, 25 Mar 2008 02:59:32 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id D63DD2F83; Tue, 25 Mar 2008 02:59:25 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78155>

From: Junio C Hamano <gitster@pobox.com>
Date: Mon, 24 Mar 2008 23:07:08 -0700

When a git command is run under test_must_fail to make sure that
the argument parser catches bogus command line, it exits with 129.
We need to catch it as a valid "graceful error exit".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/test-lib.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 870b255..7c2a8ba 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -300,7 +300,7 @@ test_expect_code () {
 
 test_must_fail () {
 	"$@"
-	test $? -gt 0 -a $? -le 128
+	test $? -gt 0 -a $? -le 129
 }
 
 # test_cmp is a helper function to compare actual and expected output.
-- 
1.5.5.rc1.121.g1594
