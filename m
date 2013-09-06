From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v5 4/7] t6050-replace: add test to clean up all the replace
 refs
Date: Fri, 06 Sep 2013 07:10:56 +0200
Message-ID: <20130906051100.6657.48216.chriscool@tuxfamily.org>
References: <20130906050702.6657.25651.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Philip Oakley <philipoakley@iee.org>,
	Thomas Rast <trast@inf.ethz.ch>, Johannes Sixt <j6t@kdbg.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 06 07:12:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHoL3-0005Eb-9D
	for gcvg-git-2@plane.gmane.org; Fri, 06 Sep 2013 07:12:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750780Ab3IFFL5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Sep 2013 01:11:57 -0400
Received: from mail-2y.bbox.fr ([194.158.98.15]:48944 "EHLO mail-2y.bbox.fr"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750773Ab3IFFL4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Sep 2013 01:11:56 -0400
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id 357657A;
	Fri,  6 Sep 2013 07:11:35 +0200 (CEST)
X-git-sha1: f29f51574b690a56302c2602c89e8f716a840128 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20130906050702.6657.25651.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234020>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t6050-replace.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
index 09bad98..09a2b49 100755
--- a/t/t6050-replace.sh
+++ b/t/t6050-replace.sh
@@ -276,4 +276,10 @@ test_expect_success '-f option bypasses the type check' '
 	git replace -f HEAD^ $BLOB
 '
 
+test_expect_success 'replace ref cleanup' '
+	test -n "$(git replace)" &&
+	git replace -d $(git replace) &&
+	test -z "$(git replace)"
+'
+
 test_done
-- 
1.8.4.rc1.28.ge2684af
