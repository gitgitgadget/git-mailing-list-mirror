From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [BUG?] rename patch accepted with --dry-run, rejected without
	(Re: [PATCH V3] arm & sh: factorised duplicated clkdev.c)
Date: Fri, 3 Sep 2010 21:33:09 +0200
Message-ID: <20100903193309.GC29821@pengutronix.de>
References: <1283431716-21540-1-git-send-email-plagnioj@jcrosoft.com> <1283434786-26479-1-git-send-email-plagnioj@jcrosoft.com> <AANLkTimRKCYYQmgwY0DHu5+e-ggT8grJbdjWFvUqTzH=@mail.gmail.com> <20100903182323.GA17152@pengutronix.de> <20100903184351.GC2341@burratino> <20100903192907.GA2978@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, linux-sh@vger.kernel.org,
	bug-patch@gnu.org, Magnus Damm <magnus.damm@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>,
	git@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
X-From: linux-sh-owner@vger.kernel.org Fri Sep 03 21:33:20 2010
Return-path: <linux-sh-owner@vger.kernel.org>
Envelope-to: glps-linuxsh-dev@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-sh-owner@vger.kernel.org>)
	id 1Orc0l-00069R-TX
	for glps-linuxsh-dev@lo.gmane.org; Fri, 03 Sep 2010 21:33:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753983Ab0ICTdS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;glps-linuxsh-dev@m.gmane.org>);
	Fri, 3 Sep 2010 15:33:18 -0400
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38435 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753967Ab0ICTdS (ORCPT
	<rfc822;linux-sh@vger.kernel.org>); Fri, 3 Sep 2010 15:33:18 -0400
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.71)
	(envelope-from <ukl@pengutronix.de>)
	id 1Orc0c-0005lJ-Sn; Fri, 03 Sep 2010 21:33:10 +0200
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1Orc0b-0000uL-AS; Fri, 03 Sep 2010 21:33:09 +0200
Content-Disposition: inline
In-Reply-To: <20100903192907.GA2978@n2100.arm.linux.org.uk>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-sh@vger.kernel.org
Sender: linux-sh-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155267>

Hey Russell,

On Fri, Sep 03, 2010 at 08:29:07PM +0100, Russell King - ARM Linux wrot=
e:
> On Fri, Sep 03, 2010 at 01:43:51PM -0500, Jonathan Nieder wrote:
> > Uwe Kleine-K=F6nig wrote:
> > > On Fri, Sep 03, 2010 at 07:18:43PM +0900, Magnus Damm wrote:
> >=20
> > >> Using --dry-run is fine, but omitting dry-run gives me:
> > >>=20
> > >> ...
> > >> patching file arch/arm/common/clkdev.c
> > >> patching file arch/sh/include/asm/clkdev.h
> > >> Hunk #1 FAILED at 1.
> > >> Hunk #2 FAILED at 11.
> > >> 2 out of 2 hunks FAILED -- saving rejects to file
> > >> arch/sh/include/asm/clkdev.h.rej
> > >>=20
> > >> I guess this is caused by the last "renaming" hunk, see below.
> >=20
> > Yep, I can reproduce this.  Patch applies with "git apply",
> > "patch --dry-run -p1" accepts it, "patch -p1" fails.
>=20
> git patches include additional metadata for renaming files, which gnu=
 patch
> will not understand.
>=20
> If you want GNU patch compatible diffs, don't use -C or -M when gener=
ating
> patches out of git.
Still GNU patch should then already fail in --dry-run mode.
=20
Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
