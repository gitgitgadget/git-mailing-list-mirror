From: "Wesley J. Landaker" <wjl@icecavern.net>
Subject: [PATCH (resend)] Update git fsck --full short description to mention packs
Date: Fri, 5 Feb 2010 12:58:50 -0700
Organization: icecavern.net
Message-ID: <201002051258.50732.wjl@icecavern.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Feb 05 20:59:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdUKn-00077R-M6
	for gcvg-git-2@lo.gmane.org; Fri, 05 Feb 2010 20:59:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933838Ab0BET7F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2010 14:59:05 -0500
Received: from rinoa.icecavern.net ([92.243.7.152]:50933 "EHLO icecavern.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S933842Ab0BET7A (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2010 14:59:00 -0500
Received: from tonberry.icecavern.net (c-76-113-110-228.hsd1.nm.comcast.net [76.113.110.228])
	by icecavern.net (Postfix) with ESMTPSA id 3575936148;
	Fri,  5 Feb 2010 12:58:56 -0700 (MST)
X-Face: #;qMWg=Msk*d]z]X1P2-t9]~6+RoGF$nJo89f%|Y`^whfl3Wj$X2Q_1u)ZAW@Hx|g)J]!)
 =?utf-8?q?=0A=09Br0=3FK3Imj?=)np=]r*QN,Q8].V99^Og'xl-d9FM~$yaSGB"mfXb>x[QNi[()
 =?utf-8?q?oob=60/4M42=26We=0A=09cC1jq=3DQ=5CS?=@ck\>H@
 =?utf-8?q?t=26Y7Y=3Apub=3DHOWqY=7D-d=5CwrCxvsTo7k1Ek=7DqQO=5D5=7EngK=5E=25?=
 =?utf-8?q?cT5IzmmG=5BQ=0A=09Nha=7D=5DAmI=60R-6m84VcWT4=236c?=)1`>t{$~l6:gZMtv18ge'!d[Yk-/?T3>C5O-|6On4(
 =?utf-8?q?N=7BAV=23=0A=094Eyw52=5B=3A=25Z?=>#"c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139075>

The '--full' option to git fsck does two things:

  1) Check objects in packs
  2) Check alternate objects

This is documented in the git fsck manual; this patch reflects that in
the short git fsck option help message as well.

Signed-off-by: Wesley J. Landaker <wjl@icecavern.net>
---
 builtin-fsck.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

I sent this patch a while back, and after the resulting discussion, the --full
option was made the default. However, the short option help was still not
updated to reflect the full documentation (and behavior) of git fsck.

(This is a resend. My apologies if you get this twice.)

diff --git a/builtin-fsck.c b/builtin-fsck.c
index 0e5faae..0929c7f 100644
--- a/builtin-fsck.c
+++ b/builtin-fsck.c
@@ -578,7 +578,7 @@ static struct option fsck_opts[] = {
 	OPT_BOOLEAN(0, "root", &show_root, "report root nodes"),
 	OPT_BOOLEAN(0, "cache", &keep_cache_objects, "make index objects head nodes"),
 	OPT_BOOLEAN(0, "reflogs", &include_reflogs, "make reflogs head nodes (default)"),
-	OPT_BOOLEAN(0, "full", &check_full, "also consider alternate objects"),
+	OPT_BOOLEAN(0, "full", &check_full, "also consider packs and alternate objects"),
 	OPT_BOOLEAN(0, "strict", &check_strict, "enable more strict checking"),
 	OPT_BOOLEAN(0, "lost-found", &write_lost_and_found,
 				"write dangling objects in .git/lost-found"),
-- 
1.6.6.1
