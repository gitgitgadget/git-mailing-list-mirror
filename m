From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [TopGit PATCH 6/6] tg-log: short cut to git log
Date: Mon, 4 Oct 2010 08:45:44 +0200
Message-ID: <20101004064544.GH28679@pengutronix.de>
References: <AANLkTim3gnU+_krD2QM0BAMf9DZi2_4hva6dq4WXcatH@mail.gmail.com> <1286141157-30422-1-git-send-email-bert.wesarg@googlemail.com> <1286141157-30422-2-git-send-email-bert.wesarg@googlemail.com> <1286141157-30422-3-git-send-email-bert.wesarg@googlemail.com> <1286141157-30422-4-git-send-email-bert.wesarg@googlemail.com> <1286141157-30422-5-git-send-email-bert.wesarg@googlemail.com> <1286141157-30422-6-git-send-email-bert.wesarg@googlemail.com> <AANLkTi=Kwx5avY7xRdWLS931zK2fi7cj5Q8u3++bqRO+@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Bert Wesarg <bert.wesarg@googlemail.com>,
	Olaf Dabrunz <odabrunz@gmx.net>, Peter Simons <simons@cryp.to>,
	martin f krafft <madduck@madduck.net>, git@vger.kernel.org,
	pasky@suse.cz, Thomas Moschny <thomas.moschny@gmx.de>
To: Per Cederqvist <ceder@lysator.liu.se>
X-From: git-owner@vger.kernel.org Mon Oct 04 08:46:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2eoE-0004QT-PS
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 08:46:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752382Ab0JDGpu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Oct 2010 02:45:50 -0400
Received: from metis.ext.pengutronix.de ([92.198.50.35]:58521 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752107Ab0JDGpu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Oct 2010 02:45:50 -0400
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.71)
	(envelope-from <ukl@pengutronix.de>)
	id 1P2enw-00052L-75; Mon, 04 Oct 2010 08:45:44 +0200
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1P2enw-0003HN-3D; Mon, 04 Oct 2010 08:45:44 +0200
Content-Disposition: inline
In-Reply-To: <AANLkTi=Kwx5avY7xRdWLS931zK2fi7cj5Q8u3++bqRO+@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157987>

Hi,

On Mon, Oct 04, 2010 at 06:40:22AM +0200, Per Cederqvist wrote:
> Using --first-parent to get only the interesting commits only works r=
eliably
> when you only work locally. If you collaborate and you and your partn=
er both
> make a commit before you push to a central server you will have to ma=
ke a
> merge, where both parents are interesting.
>=20
> I wish that git remembered which branch a commit was initially made o=
n. That
> would make "tg log" easy to implement correctly. But since git doesn'=
t, I
> don't think it is possible to implement it properly.
>=20
> At least, a warning should be added to the README.
Oh right, I missed that, when looking over the patch.  Maybe doing
something like:

	git log $name ^base(name) $(for d in dep(name); do echo ^$d)

would work?

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
