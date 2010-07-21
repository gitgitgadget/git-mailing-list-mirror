From: =?UTF-8?q?Ville=20Skytt=C3=A4?= <ville.skytta@iki.fi>
Subject: [PATCH v2] Improve "move the whole tree into a subdirectory" example.
Date: Wed, 21 Jul 2010 08:48:32 +0300
Message-ID: <1279691312-31364-1-git-send-email-ville.skytta@iki.fi>
References: <7vk4opjtdo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 21 07:48:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ObSAa-0007kT-TJ
	for gcvg-git-2@lo.gmane.org; Wed, 21 Jul 2010 07:48:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933369Ab0GUFsg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Jul 2010 01:48:36 -0400
Received: from filtteri6.pp.htv.fi ([213.243.153.189]:48566 "EHLO
	filtteri6.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932940Ab0GUFse (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jul 2010 01:48:34 -0400
Received: from localhost (localhost [127.0.0.1])
	by filtteri6.pp.htv.fi (Postfix) with ESMTP id E6F6056E17C
	for <git@vger.kernel.org>; Wed, 21 Jul 2010 08:48:32 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp6.welho.com ([213.243.153.40])
	by localhost (filtteri6.pp.htv.fi [213.243.153.189]) (amavisd-new, port 10024)
	with ESMTP id Q5lNF7XYJqlp for <git@vger.kernel.org>;
	Wed, 21 Jul 2010 08:48:32 +0300 (EEST)
Received: from viper.bobcat.mine.nu.bobcat.mine.nu (cs181085020.pp.htv.fi [82.181.85.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp6.welho.com (Postfix) with ESMTPS id 90E335BC003
	for <git@vger.kernel.org>; Wed, 21 Jul 2010 08:48:32 +0300 (EEST)
X-Mailer: git-send-email 1.7.1.1
In-Reply-To: <7vk4opjtdo.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151390>

Using "|" as the sed substitution delimiter is less likely to clash
with desired subdirectory names than "-".

Signed-off-by: Ville Skytt=C3=A4 <ville.skytta@iki.fi>
---
 Documentation/git-filter-branch.txt |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-fi=
lter-branch.txt
index 020028c..954d195 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -354,11 +354,12 @@ git filter-branch ... C..H --not D
 git filter-branch ... D..H --not C
 ----------------------------------------
=20
-To move the whole tree into a subdirectory, or remove it from there:
+To move the whole tree into a subdirectory named newsubdir, or remove
+it from there:
=20
 ---------------------------------------------------------------
 git filter-branch --index-filter \
-	'git ls-files -s | sed "s-\t\"*-&newsubdir/-" |
+	'git ls-files -s | sed "s|\t\"*|&newsubdir/|" |
 		GIT_INDEX_FILE=3D$GIT_INDEX_FILE.new \
 			git update-index --index-info &&
 	 mv $GIT_INDEX_FILE.new $GIT_INDEX_FILE' HEAD
--=20
1.7.1.1
