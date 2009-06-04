From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [TopGit PATCH] pre-commit: check .top* files in the
	to-be-commited tree
Date: Thu, 4 Jun 2009 07:27:16 +0200
Message-ID: <20090604052716.GA24414@pengutronix.de>
References: <1243975238-4807-1-git-send-email-bert.wesarg@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org,
	martin f krafft <madduck@debian.org>
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Thu Jun 04 07:28:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MC5VA-0002Vb-LX
	for gcvg-git-2@gmane.org; Thu, 04 Jun 2009 07:28:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757077AbZFDF1V convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Jun 2009 01:27:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757049AbZFDF1U
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Jun 2009 01:27:20 -0400
Received: from metis.ext.pengutronix.de ([92.198.50.35]:49998 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756881AbZFDF1S (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jun 2009 01:27:18 -0400
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.63)
	(envelope-from <ukl@pengutronix.de>)
	id 1MC5Ty-0002mO-RZ; Thu, 04 Jun 2009 07:27:18 +0200
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1MC5Tw-0006Ly-Ek; Thu, 04 Jun 2009 07:27:16 +0200
Content-Disposition: inline
In-Reply-To: <1243975238-4807-1-git-send-email-bert.wesarg@googlemail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120679>

Hi Bert,

On Tue, Jun 02, 2009 at 10:40:38PM +0200, Bert Wesarg wrote:
> We currently check fo these files only in the working tree. But we sh=
ould check
> what would be commited. We use write-tree to be able to utilize ls-tr=
ee and
> check the result.
<nitpick> I prefer not speaking about "us" in the commit log.  Better
use passive voice. </nitpick>  So what about:

The pre-commit hook used to check that the working copy has the .top*
files.  Instead of that assert that the tree that is about to be
commited has these files.

> +# I suspect this can't fail, but who knows
> +tree=3D$(git write-tree) ||
> +	die "Can't write tree"
Actually you don't need to write the tree.  You can use:

	git cat-file -t :0:.topdeps
	-> blob

	git cat-file blob :0:.topdeps | grep .

Up to now I only shortly looked at your patches, but they seem to be OK=
=2E
I hope I get around to push the changes later today.

Best regards
Uwe

--=20
Pengutronix e.K.                              | Uwe Kleine-K=F6nig     =
       |
Industrial Linux Solutions                    | http://www.pengutronix.=
de/  |
