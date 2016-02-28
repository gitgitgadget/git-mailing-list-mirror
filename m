From: tboegi@web.de
Subject: [PATCH 1/1] config.mak.uname: Darwin: Use clang for Mac OS X 10.6
Date: Sun, 28 Feb 2016 21:09:44 +0100
Message-ID: <1456690184-25127-1-git-send-email-tboegi@web.de>
References: <xmqqfuwcg0g8.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 28 21:07:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aa7co-0002Hd-KE
	for gcvg-git-2@plane.gmane.org; Sun, 28 Feb 2016 21:07:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754813AbcB1UH0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 28 Feb 2016 15:07:26 -0500
Received: from mout.web.de ([212.227.17.11]:53763 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754612AbcB1UHZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Feb 2016 15:07:25 -0500
Received: from tor.lan ([195.252.60.88]) by smtp.web.de (mrweb101) with
 ESMTPSA (Nemesis) id 0MN4Gi-1aXuh015Kq-006bm0; Sun, 28 Feb 2016 21:07:22
 +0100
X-Mailer: git-send-email 2.7.0.303.g2c4f448.dirty
In-Reply-To: <xmqqfuwcg0g8.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:cB/Dk7zGYmakQeMK2IyZ/ID3l92J+5P3USdk2yJzj8GikNN+ABV
 rDzsiIbGh9nhwwspENLX0T0uMe4Jd5+Jg93haJLztyMaaZK+uZ/T24qsje72jvFtWmm9wXy
 aV1ogDd2QKev8SPp1Fw1f8G7+nYMe5ROCJbHMarCFoBZhvR5yIZHFo7/P/GkWA2/4ySy3ps
 mtVScVwWIpaiH+9TivOqw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:0cvHtfQqpJE=:C8kytye2fodhVN+Pb6JTAC
 HC3wrv1Ya3ssCzvZSMEQjDfwOMxYGcvaX7O8JGqgrRs0GYrb2FectbsFV6sUPWfvfHAiAmgAQ
 Qb50vXSoz5zeWjVVbLCMleJIziI0349ZUoGIevbCcql2bnPqGSbFt2vliuTQHRuTBSDNIpZk6
 KJrGkcYYXDSZMYKw/864F0DOKaaYDzEXULSqrx7qTh5MYhAGENe51f+9W9Xh77aQJXen6NG1W
 TRkIF3qYxA5GxxyTqheG4YP3gjk+nuoPO0OzQEhoUqAp6cljAPI0Mypp8JuHSHBaY4/MPn6Tx
 VCqOEbuiJcEHdjT+DRvMYOJJ6CtldWM2JcBj9GOG0UwIPLPP0a6V2a7JgNDMad8buY0iDj/jJ
 Nj1yevF0qCxATYqEMWm+jT53xBl6e1rnXge3lV0IkpMm0Fhfu8HNRfcuuKLw/t6p9I7lc3Xtx
 ctXHllFBHH2UDM9fo76CxLhYTtZys9jfhf1WHDbCXWe+ssWanvI7Sk//kAObtqmHdaK3oEMzM
 X3rRxfuYO34TPLDfEYkYExGvVD39Qcv+nHcaJ0u+oWbMbuVD2Qc0MdzeWwMQ6mvr71jQ0Sx9j
 agBQi/fCcXur3ILUu0DzcgsF9jeDBaNkk16TO85yhB57MqRh/+AaLkzsESX1VmOzAOlmsQ1wn
 h6R+Vf5RbkIHAWe7DHPEvB6zwRZAerEvXdEKiDPmC0NpIG8/i5qExFoirqvDnAKZ6KG7NzN4Z
 USBZqLFBar3zIvwrArMeSKaFnLKK7bp45oOpd/I8qwNT0r8AARq5oi6Ih50hLKsjKNmk2Wfr 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287789>

=46rom: Torsten B=C3=B6gershausen <tboegi@web.de>

Commit
"tree-diff: catch integer overflow in combine_diff_path allocation"
make gcc under Mac OX 10.6 crash like this:

CC combine-diff.o
combine-diff.c: In function =E2=80=98diff_tree_combined=E2=80=99:
combine-diff.c:1391: internal compiler error: Segmentation fault

Xcode for Mac OS X 10.6 has both gcc and clang.
Later versions of Mac OSX/Xcode only provide clang, and gcc is a wrappe=
r
to it.
Make Git compile under Mac OS X 10.6 by using clang instead of gcc

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 config.mak.uname | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/config.mak.uname b/config.mak.uname
index d6f7980..d0a3df3 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -102,6 +102,9 @@ ifeq ($(uname_S),Darwin)
 	ifeq ($(shell expr "$(uname_R)" : '[15]\.'),2)
 		NO_STRLCPY =3D YesPlease
 	endif
+	ifeq ($(shell test "`expr "$(uname_R)" : '\([0-9][0-9]*\)\.'`" -eq 10=
 && echo 1),1)
+    CC =3D clang
+	endif
 	ifeq ($(shell test "`expr "$(uname_R)" : '\([0-9][0-9]*\)\.'`" -ge 11=
 && echo 1),1)
 		HAVE_GETDELIM =3D YesPlease
 	endif
--=20
2.7.0.303.g2c4f448.dirty
