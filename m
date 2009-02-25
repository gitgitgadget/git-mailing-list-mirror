From: =?utf-8?q?Uwe=20Kleine-K=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH] [TOPGIT] limit rev-list in branch_contains to a single rev
Date: Wed, 25 Feb 2009 21:03:56 +0100
Message-ID: <1235592240-12616-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20090225195856.GA12372@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 25 21:06:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcQ0t-0007ne-WA
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 21:05:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758193AbZBYUEF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Feb 2009 15:04:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758189AbZBYUEE
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 15:04:04 -0500
Received: from metis.ext.pengutronix.de ([92.198.50.35]:45152 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758112AbZBYUEC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2009 15:04:02 -0500
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.63)
	(envelope-from <ukl@pengutronix.de>)
	id 1LcPz6-0002lc-7B
	for git@vger.kernel.org; Wed, 25 Feb 2009 21:04:00 +0100
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1LcPz6-0003Hs-5x
	for git@vger.kernel.org; Wed, 25 Feb 2009 21:04:00 +0100
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <20090225195856.GA12372@pengutronix.de>
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111490>

This eases reading of debug output using sh -x and probably helps
performance, too.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
 tg.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/tg.sh b/tg.sh
index 8c23d26..ccb40cd 100644
--- a/tg.sh
+++ b/tg.sh
@@ -77,7 +77,7 @@ measure_branch()
 # Whether B1 is a superset of B2.
 branch_contains()
 {
-	[ -z "$(git rev-list ^"$1" "$2" --)" ]
+	[ -z "$(git rev-list --max-count=3D1 ^"$1" "$2" --)" ]
 }
=20
 # ref_exists REF
--=20
1.5.6.5
