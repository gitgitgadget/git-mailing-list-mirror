From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: Re: please strip MIME-Version and Content-T{ype,ransfer-Encoding} in
 git am --scissors
Date: Thu, 8 Oct 2015 22:23:43 +0200
Message-ID: <20151008202343.GU3982@pengutronix.de>
References: <1444162070-22034-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1444162070-22034-2-git-send-email-u.kleine-koenig@pengutronix.de>
 <5614CDAE.6070604@ti.com>
 <20151007075338.GH3982@pengutronix.de>
 <20151007102822.GT23801@atomide.com>
 <20151008071728.GO3982@pengutronix.de>
 <xmqqvbahqhw1.fsf@gitster.mtv.corp.google.com>
 <20151008193707.GT3982@pengutronix.de>
 <xmqqio6hqg9a.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 08 22:23:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZkHjF-0003Ma-3k
	for gcvg-git-2@plane.gmane.org; Thu, 08 Oct 2015 22:23:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752973AbbJHUXt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Oct 2015 16:23:49 -0400
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:33762 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751242AbbJHUXs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Oct 2015 16:23:48 -0400
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0] ident=Debian-exim)
	by metis.ext.pengutronix.de with esmtps (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
	(Exim 4.80)
	(envelope-from <ukl@pengutronix.de>)
	id 1ZkHj9-0001kA-A6; Thu, 08 Oct 2015 22:23:47 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.80)
	(envelope-from <ukl@pengutronix.de>)
	id 1ZkHj5-0002Eb-PN; Thu, 08 Oct 2015 22:23:43 +0200
Content-Disposition: inline
In-Reply-To: <xmqqio6hqg9a.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279274>

Hello Junio,

On Thu, Oct 08, 2015 at 01:04:01PM -0700, Junio C Hamano wrote:
> Uwe Kleine-K=F6nig  <u.kleine-koenig@pengutronix.de> writes:
>=20
> >> Does this have anything to do with scissors, though?  If you remov=
e
> >> everything before "8< ---" in the body of Tony's message (i.e. kee=
p
> >> the in-body headers starting with "From:" and ending with CTE) and
> >> try again, I would suspect that you will get the same result.
> > No, you're wrong here:
> >
> > ukl@dude.ptx:~/gsrc/linux$ head ~/tmp/1444332661.3982_89.ptx\:2\,RS=
=20
> > From: Tony Lindgren <tony@atomide.com>
> > Date: Tue, 6 Oct 2015 05:36:17 -0700
> > Subject: [PATCH] memory: omap-gpmc: Fix unselectable debug option f=
or GPMC
> > MIME-Version: 1.0
> > Content-Type: text/plain; charset=3DUTF-8
> > Content-Transfer-Encoding: 8bit
> >
> > Commit 63aa945b1013 ("memory: omap-gpmc: Add Kconfig option for deb=
ug")
> > added a debug option for GPMC, but somehow managed to keep it unsel=
ectable.
>=20
> I think you are the one who misread my question.  I said "keep the
> in-body headers", didn't I?  If you did the "head", then you would
> see something like this:

Ah got it. Yes, you're right. (Subject and Date are actually different
between real and in-body headers, but that's not important. git am pick=
s
up the in-body headers.)
=20
> > ukl@dude.ptx:~/gsrc/linux$ head ~/tmp/1444332661.3982_89.ptx\:2\,RS=
=20
> > From: Tony Lindgren <tony@atomide.com>
> > Date: Tue, 6 Oct 2015 05:36:17 -0700
> > Subject: [PATCH] memory: omap-gpmc: Fix unselectable debug option f=
or GPMC
> > ... probably Received: and all other junk from your mailbox ...
> >
> > From: Tony Lindgren <tony@atomide.com>
> > Date: Tue, 6 Oct 2015 05:36:17 -0700
> > Subject: [PATCH] memory: omap-gpmc: Fix unselectable debug option f=
or GPMC
> > MIME-Version: 1.0
> > Content-Type: text/plain; charset=3DUTF-8
> > Content-Transfer-Encoding: 8bit
> >
> > Commit 63aa945b1013 ("memory: omap-gpmc: Add Kconfig option for deb=
ug")
> > added a debug option for GPMC, but somehow managed to keep it unsel=
ectable.
>=20
> >> I also think that the "MIME-Version" thing is what gives this;
> >> mailinfo and am do not really use it, and consider that the in-bod=
y
> >> header ends there.
> >
> > I failed to follow you here.
>=20
> I think if you tried the example with in-body header, you will see
> what I meant.
>=20
> >
> >> The right approach to tweak mailinfo to cope with this better woul=
d
> >> be to keep a bit more state inside mailinfo.c::handle_commit_msg()
> >> so that if we are (1) using in-body headers, (2) have already seen
> >> _some_ valid in-body header like "Subject:" and "From: ", and (3)
> >> have not seen a blank line, discard lines that we do not care abou=
t
> >> (e.g. "MIME-VERSION: 1.0").

The right thing should also happen if MIME-Version comes above Subject
in the body but other than that I'm with you here.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
