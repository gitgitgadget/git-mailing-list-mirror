From: Ingo Br=?ISO-8859-1?Q?=FCckl?= <ib@wupperonline.de>
Subject: [PATCH] Fix wrong failures in config test
Date: Mon, 10 Jan 2011 17:13:21 +0100
Message-ID: <4d2b3198.674034bb.bm000@wupperonline.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 10 17:43:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PcKq3-0000se-96
	for gcvg-git-2@lo.gmane.org; Mon, 10 Jan 2011 17:43:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753710Ab1AJQnQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Jan 2011 11:43:16 -0500
Received: from smtp-a.tal.de ([81.92.1.9]:53092 "EHLO smtp-a.tal.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753629Ab1AJQnN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jan 2011 11:43:13 -0500
X-Greylist: delayed 1125 seconds by postgrey-1.27 at vger.kernel.org; Mon, 10 Jan 2011 11:43:13 EST
Received: from point.localnet (mue-88-130-97-192.dsl.tropolys.de [88.130.97.192])
	(Authenticated sender: ib@wtal.de)
	by smtp-a.tal.de (Postfix) with ESMTP id 9BDBD111C29A
	for <git@vger.kernel.org>; Mon, 10 Jan 2011 17:24:26 +0100 (CET)
Received: from ib by point.localnet with local (masqmail 0.2.21) id
 1PcKXh-2aN-00 for <git@vger.kernel.org>; Mon, 10 Jan 2011 17:24:25 +0100
X-Mailer: blueMail/Linux 1.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164879>

The tests after '--set in alternative GIT_CONFIG' failed because
variable GIT_CONFIG was still set.

Signed-off-by: Ingo Br=FCckl <ib@wupperonline.de>
---

Is it only me (bash 3.2.48(1)-release) experiencing these failures?

 t/t1300-repo-config.sh |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index d0e5546..d1c9a8f 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -428,6 +428,8 @@ EOF

 test_expect_success '--set in alternative GIT_CONFIG' 'cmp other-confi=
g expect'

+unset GIT_CONFIG
+
 cat > .git/config << EOF
 # Hallo
 	#Bello
--
1.7.3.5
