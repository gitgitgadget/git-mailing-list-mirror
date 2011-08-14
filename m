From: =?ISO-8859-1?Q?Ingo_Br=FCckl?= <ib@wupperonline.de>
Subject: [PATCH] Utilize config variable pager.stash in stash list command
Date: Sun, 14 Aug 2011 16:31:49 +0200
Message-ID: <4e47dcf9.55313988.bm000@wupperonline.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 14 16:54:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qsc5K-00053f-3u
	for gcvg-git-2@lo.gmane.org; Sun, 14 Aug 2011 16:54:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752542Ab1HNOyh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Aug 2011 10:54:37 -0400
Received: from smtp-a.tal.de ([81.92.1.9]:59033 "EHLO smtp-a.tal.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751088Ab1HNOyg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Aug 2011 10:54:36 -0400
X-Greylist: delayed 1090 seconds by postgrey-1.27 at vger.kernel.org; Sun, 14 Aug 2011 10:54:36 EDT
Received: from point.localnet (mue-88-130-101-063.dsl.tropolys.de [88.130.101.63])
	(Authenticated sender: ib@wtal.de)
	by smtp-a.tal.de (Postfix) with ESMTP id 38BAA11E386A
	for <git@vger.kernel.org>; Sun, 14 Aug 2011 16:36:24 +0200 (CEST)
Received: from ib by point.localnet with local (masqmail 0.2.21) id
 1Qsbnd-3em-00 for <git@vger.kernel.org>; Sun, 14 Aug 2011 16:36:25 +0200
X-Mailer: blueMail/Linux 1.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179329>

Signed-off-by: Ingo Br=FCckl <ib@wupperonline.de>
---
 By now stash list ignores it.

 git-stash.sh |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index f4e6f05..7bb0856 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -264,7 +264,8 @@ have_stash () {

 list_stash () {
 	have_stash || return 0
-	git log --format=3D"%gd: %gs" -g "$@" $ref_stash --
+	test "$(git config --get pager.stash)" =3D "false" && no_pager=3D--no=
-pager
+	git $no_pager log --format=3D"%gd: %gs" -g "$@" $ref_stash --
 }

 show_stash () {
--
1.7.6
