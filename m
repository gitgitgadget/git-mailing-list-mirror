From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: bug? in checkout with ambiguous refnames
Date: Fri, 7 Jan 2011 11:46:50 +0100
Message-ID: <20110107104650.GA5399@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 07 11:46:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pb9qU-0006Y5-V3
	for gcvg-git-2@lo.gmane.org; Fri, 07 Jan 2011 11:46:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751790Ab1AGKqw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Jan 2011 05:46:52 -0500
Received: from metis.ext.pengutronix.de ([92.198.50.35]:53672 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751720Ab1AGKqv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jan 2011 05:46:51 -0500
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.72)
	(envelope-from <ukl@pengutronix.de>)
	id 1Pb9qM-0007jL-O3
	for git@vger.kernel.org; Fri, 07 Jan 2011 11:46:50 +0100
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1Pb9qM-0001jp-Ml
	for git@vger.kernel.org; Fri, 07 Jan 2011 11:46:50 +0100
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164705>

Hello,

everything is clean:

	ukl@octopus:~/gsrc/linux-2.6$ git diff; git diff --cached

	ukl@octopus:~/gsrc/linux-2.6$ git checkout sgu/mxs-amba-uart
	warning: refname 'sgu/mxs-amba-uart' is ambiguous.
	Previous HEAD position was c13fb17... Merge commit '65e29a85a419f9a161=
ab0f09f9d69924e36d940e' into HEAD
	Switched to branch 'sgu/mxs-amba-uart'

OK, it might be a bad idea to have this ambiguity, still ...

	ukl@octopus:~/gsrc/linux-2.6$ git diff; git diff --cached --stat
	 arch/arm/mach-mxs/Kconfig                       |    2 ++
	 arch/arm/mach-mxs/clock-mx23.c                  |    2 +-
	 arch/arm/mach-mxs/clock-mx28.c                  |    2 +-
	 arch/arm/mach-mxs/devices-mx23.h                |    2 +-
	 arch/arm/mach-mxs/devices-mx28.h                |    2 +-
	 arch/arm/mach-mxs/devices.c                     |   17 ++------------=
---
	 arch/arm/mach-mxs/devices/Kconfig               |    1 -
	 arch/arm/mach-mxs/devices/amba-duart.c          |   15 +++++++-------=
-
	 arch/arm/mach-mxs/include/mach/devices-common.h |    4 +---
	 9 files changed, 16 insertions(+), 31 deletions(-)
	ukl@octopus:~/gsrc/linux-2.6$ git diff refs/tags/sgu/mxs-amba-uart
	ukl@octopus:~/gsrc/linux-2.6$ git diff --cached refs/tags/sgu/mxs-amba=
-uart

So working copy and cache are at refs/tags/sgu/mxs-amba-uart, HEAD
points to refs/heads/sgu/mxs-amba-uart

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
