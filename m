From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [TopGit PATCH] tg-patch: fix invocation in sub working tree
	directory
Date: Tue, 17 Mar 2009 09:02:11 +0100
Message-ID: <20090317080211.GA21794@pengutronix.de>
References: <1237241299-25515-1-git-send-email-bert.wesarg@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org,
	martin f krafft <madduck@debian.org>
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Tue Mar 17 09:03:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjUH5-0001Qc-KH
	for gcvg-git-2@gmane.org; Tue, 17 Mar 2009 09:03:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752491AbZCQICT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Mar 2009 04:02:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752304AbZCQICR
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 04:02:17 -0400
Received: from metis.ext.pengutronix.de ([92.198.50.35]:49662 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751911AbZCQICQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2009 04:02:16 -0400
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.63)
	(envelope-from <ukl@pengutronix.de>)
	id 1LjUFZ-0003Ax-D6; Tue, 17 Mar 2009 09:02:13 +0100
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1LjUFX-0000rz-Gw; Tue, 17 Mar 2009 09:02:11 +0100
Content-Disposition: inline
In-Reply-To: <1237241299-25515-1-git-send-email-bert.wesarg@googlemail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113435>

On Mon, Mar 16, 2009 at 11:08:19PM +0100, Bert Wesarg wrote:
> tg patch won't work in a sub directory of the working tree, because '=
git diff
> --name-only' prints the names relative to the top working tree.
Hhhm, that's not exactly the problem.

	git diff --patch-with-stat 45c82b5 t/trivial/typo-kernel -- $path

expects $path to be relative to the top working tree.

IMHO this is a strange behaviour of core git when comparing two trees
(and not a tree and the wc).  Moreover as the output uses "absolute"
paths:

	ukleinek@cassiopeia:~/gsrc/linux-2.6/fs$ git diff --patch-with-stat 45=
c82b5 t/trivial/typo-kernel -- proc/nommu.c | diffstat -p0
 b/fs/proc/nommu.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Best regards
Uwe

--=20
Pengutronix e.K.                              | Uwe Kleine-K=F6nig     =
       |
Industrial Linux Solutions                    | http://www.pengutronix.=
de/  |
