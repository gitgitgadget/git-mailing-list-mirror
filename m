From: Torsten =?utf-8?q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH] test-bzr: Do not use unportable sed "\+"
Date: Sat, 11 May 2013 15:25:52 +0200
Message-ID: <201305111525.53130.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: felipe.contreras@gmail.com
X-From: git-owner@vger.kernel.org Sat May 11 15:26:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ub9oL-0007jx-OK
	for gcvg-git-2@plane.gmane.org; Sat, 11 May 2013 15:26:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752732Ab3EKN0A convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 11 May 2013 09:26:00 -0400
Received: from mout.web.de ([212.227.15.3]:56770 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752711Ab3EKN0A convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 May 2013 09:26:00 -0400
Received: from appes.localnet ([195.67.191.23]) by smtp.web.de (mrweb103) with
 ESMTPA (Nemesis) id 0MUW7T-1V1FET28cV-00QyGv; Sat, 11 May 2013 15:25:58 +0200
X-Provags-ID: V02:K0:vuMb02Nwd0X9TdsSFhxrK/OeJe+8ciseE+LHcRP6Vp4
 QHhvvXkQwYP58KY9OuDBFZymvkod1pSg/donWfWNuIRzjhfhbY
 yS/7BlSZkwNwIaOOzYgO+3+EDDPY1CA4gTgJiSbq+iLiZIFOZR
 Doz7e1716miq6SvDr7uYgjydohM7iaGdhZ9YDLyZ5sbqohCQbE
 Z4E7+SCQg1EKpXpOpJnKA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223970>

Using sed -e '/[0-9]\+//' to find "one ore more" digits
is not portable.
Use the Basic Regular Expression '/[0-9][0-9]*//' instead

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 contrib/remote-helpers/test-bzr.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/remote-helpers/test-bzr.sh b/contrib/remote-helper=
s/test-bzr.sh
index d9c32f4..5dfa070 100755
--- a/contrib/remote-helpers/test-bzr.sh
+++ b/contrib/remote-helpers/test-bzr.sh
@@ -328,7 +328,7 @@ test_expect_success 'strip' '
=20
   echo four >> content &&
   bzr commit -m four &&
-  bzr log --line | sed -e "s/^[0-9]\+: //" > ../expected
+  bzr log --line | sed -e "s/^[0-9][0-9]*: //" > ../expected
   ) &&
=20
   (cd gitrepo &&
--=20
1.8.2.1.614.g66d7af5
