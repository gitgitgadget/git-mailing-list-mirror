From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH TopGit] hooks/pre-commit.sh: fix bashism
Date: Thu, 26 Mar 2009 10:00:09 +0100
Message-ID: <20090326090009.GA7570@pengutronix.de>
References: <1237981384-7857-1-git-send-email-bert.wesarg@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org,
	martin f krafft <madduck@debian.org>,
	Marc Kleine-Budde <m.kleine-budde@pengutronix.de>
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Thu Mar 26 10:02:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmlTm-0002Qb-Fr
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 10:02:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756351AbZCZJAT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 Mar 2009 05:00:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755906AbZCZJAT
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Mar 2009 05:00:19 -0400
Received: from metis.ext.pengutronix.de ([92.198.50.35]:59128 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754425AbZCZJAQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Mar 2009 05:00:16 -0400
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.63)
	(envelope-from <ukl@pengutronix.de>)
	id 1LmlRb-0005wx-EE; Thu, 26 Mar 2009 10:00:11 +0100
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1LmlRZ-0001zl-CH; Thu, 26 Mar 2009 10:00:09 +0100
Content-Disposition: inline
In-Reply-To: <1237981384-7857-1-git-send-email-bert.wesarg@googlemail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114753>

This was introduced in fcb488d51e72c7414f9beb40ad06bf529b8b38dc.
A similar fix was suggested by martin f krafft, too.

Reported-by: Bert Wesarg <bert.wesarg@googlemail.com>
Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
---
Hello,

this should fix the issue now.

If I don't get negative feed back I will push this change later today.
I'm open for acks, too.

Best regards and thanks
Uwe

 hooks/pre-commit.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/hooks/pre-commit.sh b/hooks/pre-commit.sh
index a12cfa6..9d677e9 100644
--- a/hooks/pre-commit.sh
+++ b/hooks/pre-commit.sh
@@ -20,7 +20,7 @@ tg_util
 if head_=3D$(git symbolic-ref -q HEAD); then
 	case "$head_" in
 		refs/heads/*)
-			git rev-parse -q --verify "${head_/#refs\/heads/refs\/top-bases}" >=
/dev/null || exit 0;;
+			git rev-parse -q --verify "refs/top-bases${head_#refs/heads}" >/dev=
/null || exit 0;;
 		*)
 			exit 0;;
 	esac
--=20
1.6.2

--=20
Pengutronix e.K.                              | Uwe Kleine-K=F6nig     =
       |
Industrial Linux Solutions                    | http://www.pengutronix.=
de/  |
