From: Alexander Strasser <eclipse7@gmx.net>
Subject: [PATCH v3 2/2] t4012: Check binary only change with --shortstat
Date: Fri, 15 Jun 2012 23:51:24 +0200
Message-ID: <3fe3171f891450f6a7ecc04051f4c0c5e467df3d.1339796363.git.eclipse7@gmx.net>
References: <eae8caaf80d3bc90051de3f8f022bda01016bfd8.1339796363.git.eclipse7@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	mj@ucw.cz, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 15 23:51:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SfeQa-00078S-Mt
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jun 2012 23:51:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757957Ab2FOVvc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jun 2012 17:51:32 -0400
Received: from mailout-de.gmx.net ([213.165.64.22]:35400 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1757323Ab2FOVvc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jun 2012 17:51:32 -0400
Received: (qmail invoked by alias); 15 Jun 2012 21:51:29 -0000
Received: from p5DC36C83.dip.t-dialin.net (EHLO gmx.net) [93.195.108.131]
  by mail.gmx.net (mp032) with SMTP; 15 Jun 2012 23:51:29 +0200
X-Authenticated: #8251126
X-Provags-ID: V01U2FsdGVkX1/C+gx7dK7CFs2UHlox8ClDTb5Itd1Bw+eCo+llKW
	5iGFDY3N7h2na7
Received: by gmx.net (sSMTP sendmail emulation); Fri, 15 Jun 2012 23:51:24 +0200
Content-Disposition: inline
In-Reply-To: <eae8caaf80d3bc90051de3f8f022bda01016bfd8.1339796363.git.eclipse7@gmx.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200103>

Expect to see files changed but with 0 insertions and 0 deletions,
because we do not count line changes for binary file modifications.

Signed-off-by: Alexander Strasser <eclipse7@gmx.net>
---

  This patch can be squashed into the first one if desirable.

 t/t4012-diff-binary.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/t/t4012-diff-binary.sh b/t/t4012-diff-binary.sh
index 7d03c1d..6cebb39 100755
--- a/t/t4012-diff-binary.sh
+++ b/t/t4012-diff-binary.sh
@@ -42,6 +42,12 @@ test_expect_success 'diff --shortstat output for binary file change' '
 	test_i18ncmp expected current
 '
 
+test_expect_success 'diff --shortstat output for binary file change only' '
+	echo " 1 file changed, 0 insertions(+), 0 deletions(-)" >expected &&
+	git diff --shortstat -- b >current &&
+	test_i18ncmp expected current
+'
+
 test_expect_success 'apply --numstat notices binary file change' '
 	git diff >diff &&
 	git apply --numstat <diff >current &&
-- 
1.7.10.2.552.gaa3bb87
