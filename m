From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: Re: cannot fetch arm git tree
Date: Sun, 16 Jan 2011 12:08:19 +0100
Message-ID: <20110116110819.GG6917@pengutronix.de>
References: <AANLkTikRrewCLGDTU7DjVssjpxz-EFK8AhRScAGPRumg@mail.gmail.com>
 <20110116092315.GA27542@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>,
	linux-arm-kernel@lists.infradead.org, git@vger.kernel.org
To: Jello huang <ruifeihuang@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 16 12:08:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PeQTH-0002ks-AM
	for gcvg-git-2@lo.gmane.org; Sun, 16 Jan 2011 12:08:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751918Ab1APLI0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 16 Jan 2011 06:08:26 -0500
Received: from metis.ext.pengutronix.de ([92.198.50.35]:53789 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751839Ab1APLIZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Jan 2011 06:08:25 -0500
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.72)
	(envelope-from <ukl@pengutronix.de>)
	id 1PeQT6-0005L3-65; Sun, 16 Jan 2011 12:08:20 +0100
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1PeQT5-0004Tp-FE; Sun, 16 Jan 2011 12:08:19 +0100
Content-Disposition: inline
In-Reply-To: <20110116092315.GA27542@n2100.arm.linux.org.uk>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165161>

Hello Jello,

On Sun, Jan 16, 2011 at 09:23:15AM +0000, Russell King - ARM Linux wrot=
e:
> On Sun, Jan 16, 2011 at 10:28:55AM +0800, Jello huang wrote:
> > Dear Russell,
> >=20
> > when i use git fetch,there arm some wrong with it.
> >=20
> > jello@jello-laptop:~/git/russell/linux-2.6-arm$git pull
> > error: Unable to find 89e4d4b145bb7e73b4c45671a84b401a5d8694c1 unde=
r
> > http://ftp.arm.linux.org.uk/pub/armlinux/kernel/git-cur/linux-2.6-a=
rm.git
> > Cannot obtain needed blob 89e4d4b145bb7e73b4c45671a84b401a5d8694c1
> > while processing commit eda2e5dcc914b4d70f665443efc9780e89a5e5c1.
> > error: Fetch failed.
> >=20
> > What is the wrong?
>=20
> No idea.  The tree has the object file in one of its pack files:
>=20
> | rmk@ZenIV:[linux-2.6-arm.git]:<1020> GIT_DIR=3D. git cat-file -p 89=
e4d4b145bb7e73b4c45671a84b401a5d8694c1|head
> |=20
> |         List of maintainers and how to submit kernel changes
> |=20
> | Please try to follow the guidelines below.  This will make things
> | easier on the maintainers.  Not all of these guidelines matter for =
every
> | trivial patch so apply some common sense.
>=20
> and the pack info file lists all the pack files.  Maybe you have a ha=
sh
> collision on a pack file with your repository?
Probably you have a corrupted pack file.  Try renaming all packfiles
listed in
http://ftp.arm.linux.org.uk/pub/armlinux/kernel/git-cur/linux-2.6-arm.g=
it/objects/info/packs
(i.e.
=2Egit/objects/pack/pack-74405a23171b6debd894d4791e06956d6387022a.pack
etc.) and try refetching then.  This happend to me after Ctrl-Cing an
earlier git-fetch.  Git doesn't seem to handle that case.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
