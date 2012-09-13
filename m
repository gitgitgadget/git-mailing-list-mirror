From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2 3/6] t7810-grep: test multiple --author with --all-match
Date: Thu, 13 Sep 2012 16:04:41 +0200
Message-ID: <8fd93bb87098298677426735dd354fa4f64abc17.1347544259.git.git@drmicha.warpmail.net>
References: <7v7grzdue6.fsf@alter.siamese.dyndns.org>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 13 16:05:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCA2b-00073N-Ng
	for gcvg-git-2@plane.gmane.org; Thu, 13 Sep 2012 16:05:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755668Ab2IMOEx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Sep 2012 10:04:53 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:42970 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755164Ab2IMOEv (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Sep 2012 10:04:51 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 97D6020B19;
	Thu, 13 Sep 2012 10:04:50 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute3.internal (MEProxy); Thu, 13 Sep 2012 10:04:50 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:in-reply-to:references; s=smtpout; bh=pc
	GFQu1phZbOGmYVgQpweBW4gtg=; b=UQrHpUkQxEG2PWXEL3aOYLfpnEY36RH+Ny
	vThU0YsEK3iAvw2S04ZcIGiWRIVVuPsqradBVuXbPCXECwg0j9ofPy85zXt0sbVN
	rrckz0zPmGAO5jyrni9371w3yntjQ1Zssu4PBwSJtoUh1SyMmUkTNaZbaiyt4e/z
	v/H9LH1ow=
X-Sasl-enc: TY7vpWAjQrpHDM1VfTPA+oQKGiCoE7XM7sJp0Xbyr2jQ 1347545090
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 3B7B58E01F7;
	Thu, 13 Sep 2012 10:04:50 -0400 (EDT)
X-Mailer: git-send-email 1.7.12.463.gbd9d638
In-Reply-To: <7v7grzdue6.fsf@alter.siamese.dyndns.org>
In-Reply-To: <cover.1347544259.git.git@drmicha.warpmail.net>
References: <cover.1347544259.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205379>

--all-match is ignored for author matching on purpose.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 t/t7810-grep.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 1db3dcb..9bc63a3 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -580,6 +580,14 @@ test_expect_success 'log with multiple --author uses union' '
 	test_cmp expect actual
 '
 
+test_expect_success 'log --all-match with multiple --author still uses union' '
+	git log --all-match --author="Thor" --author="Aster" --format=%s >actual &&
+	{
+	    echo third && echo second && echo initial
+	} >expect &&
+	test_cmp expect actual
+'
+
 test_expect_success 'log with --grep and multiple --author uses all-match' '
 	git log --author="Thor" --author="Night" --grep=i --format=%s >actual &&
 	{
-- 
1.7.12.463.gbd9d638
