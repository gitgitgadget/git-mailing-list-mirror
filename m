From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: [PATCH] t5705: Use the correct file:// URL
Date: Thu, 13 Nov 2014 08:36:07 +0100
Message-ID: <54645F67.30008@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 13 08:36:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xoowx-0005tm-AY
	for gcvg-git-2@plane.gmane.org; Thu, 13 Nov 2014 08:36:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751704AbaKMHgL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 13 Nov 2014 02:36:11 -0500
Received: from mout.web.de ([212.227.15.14]:53794 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751117AbaKMHgK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2014 02:36:10 -0500
Received: from macce.local ([78.72.74.102]) by smtp.web.de (mrweb002) with
 ESMTPSA (Nemesis) id 0LfReL-1YMEt42RM9-00p8Ij; Thu, 13 Nov 2014 08:36:07
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
X-Provags-ID: V03:K0:v1erLjBN+pPv7b3tqdp5ONv0HG3UyuN9mXLnDoQWM8IyAcvO/yi
 QPbFdMaHKaEFMz6KOh2Ylg16UuszM5LqTKk8y/xfDEtfgn22QCOURBW09SzBQtRZuede1Ik
 sZPdfi+wZ3lutRDvxnkhA8+5mAnwr8DMtFzkfZ8lAs3tidkkJxKlI6j7vbsKPO2COGVTOQ+
 alcj4Du/BrmDYERoBOQwQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A URL like file;//. is (no longer) supported by Git:
Typically there is no host, and RFC1738 says that file:///<path>
should be used.

Update t5705 to use a working URL.

Reported-by: Michael Blume <blume.mike@gmail.com>
Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 t/t5705-clone-2gb.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5705-clone-2gb.sh b/t/t5705-clone-2gb.sh
index e9783c3..191d6d3 100755
--- a/t/t5705-clone-2gb.sh
+++ b/t/t5705-clone-2gb.sh
@@ -46,7 +46,7 @@ test_expect_success CLONE_2GB 'clone - bare' '
=20
 test_expect_success CLONE_2GB 'clone - with worktree, file:// protocol=
' '
=20
-	git clone file://. clone-wt
+	git clone "file://$(pwd)" clone-wt
=20
 '
=20
--=20
1.9.1.dirty
