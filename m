From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH 1/3] submodule add: test failure when url is not configured
 in superproject
Date: Mon, 06 Jun 2011 21:57:01 +0200
Message-ID: <4DED310D.9040300@web.de>
References: <7vaae2ihe1.fsf@alter.siamese.dyndns.org> <1306943792-1825-1-git-send-email-marcnarc@xiplink.com> <7vsjrth4iy.fsf@alter.siamese.dyndns.org> <4DE69945.1080601@web.de> <7v39jsdulf.fsf@alter.siamese.dyndns.org> <4DE93B29.4030401@web.de> <7vipskb0br.fsf@alter.siamese.dyndns.org> <4DED30E0.6090608@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Marc Branchaud <marcnarc@xiplink.com>, git@vger.kernel.org,
	Mark Levedahl <mlevedahl@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 06 21:57:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTfvB-0003gi-So
	for gcvg-git-2@lo.gmane.org; Mon, 06 Jun 2011 21:57:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754267Ab1FFT5E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2011 15:57:04 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:52736 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751685Ab1FFT5C (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2011 15:57:02 -0400
Received: from smtp03.web.de  ( [172.20.0.65])
	by fmmailgate02.web.de (Postfix) with ESMTP id 65BFB1A24FF14;
	Mon,  6 Jun 2011 21:57:01 +0200 (CEST)
Received: from [93.240.124.249] (helo=[192.168.178.43])
	by smtp03.web.de with asmtp (WEB.DE 4.110 #2)
	id 1QTfv3-0005Gs-00; Mon, 06 Jun 2011 21:57:01 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.17) Gecko/20110414 Lightning/1.0b2 Thunderbird/3.1.10
In-Reply-To: <4DED30E0.6090608@web.de>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX19NKRMX7e8prdA6/Rx51bWx/qLxoX3Y3vuem2XT
	24/dsFy30WbELskLctGBo9+9SkkIbiQusL1uelSnNn5UQJOcrq
	QqgmcqZjz3J8Bv/X3BcA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175155>

This documents the current behavior (submodule add with the url set in the
superproject is already tested in t7403, t7406, t7407 and t7506).

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---
 t/t7400-submodule-basic.sh |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 874279e..cae5fd0 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -446,6 +446,13 @@ test_expect_success 'add should fail when path is used by an existing directory'
 	)
 '

+test_expect_success 'add should fail when path is relative but no url is set in the superproject' '
+	(
+		cd addtest &&
+		test_must_fail git submodule add ../repo relative
+	)
+'
+
 test_expect_success 'set up for relative path tests' '
 	mkdir reltest &&
 	(
-- 
1.7.6.rc0.3.g28a66
