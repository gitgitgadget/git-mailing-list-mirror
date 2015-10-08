From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: Re: please strip MIME-Version and Content-T{ype,ransfer-Encoding} in
 git am --scissors
Date: Thu, 8 Oct 2015 21:37:07 +0200
Message-ID: <20151008193707.GT3982@pengutronix.de>
References: <1444162070-22034-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1444162070-22034-2-git-send-email-u.kleine-koenig@pengutronix.de>
 <5614CDAE.6070604@ti.com>
 <20151007075338.GH3982@pengutronix.de>
 <20151007102822.GT23801@atomide.com>
 <20151008071728.GO3982@pengutronix.de>
 <xmqqvbahqhw1.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 08 21:37:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZkH0A-0000q2-HP
	for gcvg-git-2@plane.gmane.org; Thu, 08 Oct 2015 21:37:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756690AbbJHThM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Oct 2015 15:37:12 -0400
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:43720 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756680AbbJHThK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Oct 2015 15:37:10 -0400
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0] ident=Debian-exim)
	by metis.ext.pengutronix.de with esmtps (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
	(Exim 4.80)
	(envelope-from <ukl@pengutronix.de>)
	id 1ZkH01-0007CA-H2; Thu, 08 Oct 2015 21:37:09 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.80)
	(envelope-from <ukl@pengutronix.de>)
	id 1ZkGzz-0000aD-43; Thu, 08 Oct 2015 21:37:07 +0200
Content-Disposition: inline
In-Reply-To: <xmqqvbahqhw1.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279269>

Hello Junio,

On Thu, Oct 08, 2015 at 12:28:46PM -0700, Junio C Hamano wrote:
> Uwe Kleine-K=F6nig  <u.kleine-koenig@pengutronix.de> writes:
>=20
> > Hello,
> >
> > when applying the mail below (without the '> ' prefix) using git am
> > --scissors the result looks like:
> >
> > 	$ git show
> > 	commit 26ef0606927cc1979faa4166d7f9f3584b5cdc61
> > 	Author: Tony Lindgren <tony@atomide.com>
> > 	Date:   Tue Oct 6 05:36:17 2015 -0700
> >
> > 	    memory: omap-gpmc: Fix unselectable debug option for GPMC
> > 	   =20
> > 	    MIME-Version: 1.0
> > 	    Content-Type: text/plain; charset=3DUTF-8
> > 	    Content-Transfer-Encoding: 8bit
> > 	   =20
> > 	    Commit 63aa945b1013 ("memory: omap-gpmc: Add Kconfig option fo=
r debug")
> > 	    added a debug option for GPMC, but somehow managed to keep it =
unselectable.
> > 	   =20
> > 	[...]
> >
> > 	$ git version
> > 	git version 2.6.0
> >
> > The obvious improvement is to strip all headers like git am does wi=
thout
> > --scissors.
>=20
> Does this have anything to do with scissors, though?  If you remove
> everything before "8< ---" in the body of Tony's message (i.e. keep
> the in-body headers starting with "From:" and ending with CTE) and
> try again, I would suspect that you will get the same result.
No, you're wrong here:

ukl@dude.ptx:~/gsrc/linux$ head ~/tmp/1444332661.3982_89.ptx\:2\,RS=20
=46rom: Tony Lindgren <tony@atomide.com>
Date: Tue, 6 Oct 2015 05:36:17 -0700
Subject: [PATCH] memory: omap-gpmc: Fix unselectable debug option for G=
PMC
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

Commit 63aa945b1013 ("memory: omap-gpmc: Add Kconfig option for debug")
added a debug option for GPMC, but somehow managed to keep it unselecta=
ble.

ukl@dude.ptx:~/gsrc/linux$ git am ~/tmp/1444332661.3982_89.ptx\:2\,RS
Applying: memory: omap-gpmc: Fix unselectable debug option for GPMC
ukl@dude.ptx:~/gsrc/linux$ git cat-file commit HEAD
tree bab01e3e0d0bdd715b86cf7d5c9e8bb9768a30dc
parent c6fa8e6de3dc420cba092bf155b2ed25bcd537f7
author Tony Lindgren <tony@atomide.com> 1444134977 -0700
committer Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de> 144433278=
2 +0200

memory: omap-gpmc: Fix unselectable debug option for GPMC

Commit 63aa945b1013 ("memory: omap-gpmc: Add Kconfig option for debug")
added a debug option for GPMC, but somehow managed to keep it unselecta=
ble.

This probably happened because I had some uncommitted changes and the
GPMC option is selected in the platform specific Kconfig.

Let's also update the description a bit, it does not mention that
enabling the debug option also disables the reset of GPMC controller
during the init as pointed out by Uwe Kleine-K=F6nig
<u.kleine-koenig@pengutronix.de> and Roger Quadros <rogerq@ti.com>.

=46ixes: 63aa945b1013 ("memory: omap-gpmc: Add Kconfig option for debug=
")
Reported-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
Signed-off-by: Tony Lindgren <tony@atomide.com>

> I also think that the "MIME-Version" thing is what gives this;
> mailinfo and am do not really use it, and consider that the in-body
> header ends there.

I failed to follow you here.

> The right approach to tweak mailinfo to cope with this better would
> be to keep a bit more state inside mailinfo.c::handle_commit_msg()
> so that if we are (1) using in-body headers, (2) have already seen
> _some_ valid in-body header like "Subject:" and "From: ", and (3)
> have not seen a blank line, discard lines that we do not care about
> (e.g. "MIME-VERSION: 1.0").

That sound's right.
=20
> > If someone wants a bounce of the original mail, just ask per PM.
>=20
> I have no idea what you are talking about here...

The result would be that a copy of the original mail would hit your mai=
lbox if
you asked per private mail (PM).

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
