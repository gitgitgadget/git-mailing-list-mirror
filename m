From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] merge-tree: fix typo in "both changed identically"
Date: Sat, 27 Apr 2013 15:23:18 +0200
Message-ID: <517BD146.1040401@lsrfire.ath.cx>
References: <51cbc79a9b250544a8365980d078601dfcd2b782.1367067799.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Sat Apr 27 15:23:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UW565-0005Gv-M8
	for gcvg-git-2@plane.gmane.org; Sat, 27 Apr 2013 15:23:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753059Ab3D0NXV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Apr 2013 09:23:21 -0400
Received: from india601.server4you.de ([85.25.151.105]:49294 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752430Ab3D0NXV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Apr 2013 09:23:21 -0400
Received: from [192.168.2.105] (p579BE62C.dip0.t-ipconnect.de [87.155.230.44])
	by india601.server4you.de (Postfix) with ESMTPSA id E18A8324;
	Sat, 27 Apr 2013 15:23:19 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <51cbc79a9b250544a8365980d078601dfcd2b782.1367067799.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222645>

How about squashing in this test?

Ren=C3=A9

---
 t/t4300-merge-tree.sh | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/t/t4300-merge-tree.sh b/t/t4300-merge-tree.sh
index bd43b3d..2defb42 100755
--- a/t/t4300-merge-tree.sh
+++ b/t/t4300-merge-tree.sh
@@ -205,6 +205,19 @@ EXPECTED
 	test_cmp expected actual
 '
=20
+test_expect_success 'file remove A, B (same)' '
+	cat >expected <<\EXPECTED &&
+EXPECTED
+
+	git reset --hard initial &&
+	test_commit "rm-a-b-base" "ONE" "AAA" &&
+	git rm ONE &&
+	git commit -m "rm-a-b" &&
+	git tag "rm-a-b" &&
+	git merge-tree rm-a-b-base rm-a-b rm-a-b >actual &&
+	test_cmp expected actual
+'
+
 test_expect_success 'file change A, remove B' '
 	cat >expected <<\EXPECTED &&
 removed in remote
--=20
1.8.2.1
