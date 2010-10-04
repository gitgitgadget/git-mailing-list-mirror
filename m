From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] Documentation/git-clone: describe --mirror more verbose
Date: Mon, 4 Oct 2010 10:50:50 +0200
Message-ID: <20101004085050.GQ28679@pengutronix.de>
References: <1285963983-5629-1-git-send-email-u.kleine-koenig@pengutronix.de> <AANLkTimN53bcadyzshHNVULkt=kzdfTQrUmZxUd+FKpY@mail.gmail.com> <1285967766.6750.2.camel@gandalf.stny.rr.com> <4CA9815D.3040801@drmicha.warpmail.net> <20101004075015.GN28679@pengutronix.de> <4CA98EF1.1050102@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Darren Hart <darren@dvhart.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Oct 04 10:51:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2glB-0006Si-9g
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 10:51:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753589Ab0JDIuz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Oct 2010 04:50:55 -0400
Received: from metis.ext.pengutronix.de ([92.198.50.35]:43327 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753316Ab0JDIuz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Oct 2010 04:50:55 -0400
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.71)
	(envelope-from <ukl@pengutronix.de>)
	id 1P2gl1-0001pT-TU; Mon, 04 Oct 2010 10:50:51 +0200
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1P2gl0-00033G-AT; Mon, 04 Oct 2010 10:50:50 +0200
Content-Disposition: inline
In-Reply-To: <4CA98EF1.1050102@drmicha.warpmail.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158012>

Hello Michael,

On Mon, Oct 04, 2010 at 10:23:13AM +0200, Michael J Gruber wrote:
> Uwe Kleine-K=F6nig venit, vidit, dixit 04.10.2010 09:50:
> > Hello Michael,
> >=20
> > On Mon, Oct 04, 2010 at 09:25:17AM +0200, Michael J Gruber wrote:
> >> Steven Rostedt venit, vidit, dixit 01.10.2010 23:16:
> >>> On Fri, 2010-10-01 at 13:18 -0700, Darren Hart wrote:
> >>>> 2010/10/1 Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>:
> >>>>> Some people in #linux-rt claimed that you cannot define "--mirr=
or" with
> >>>>> "mirror".
> >>>>>
> >>
> >> I'd say "mirror" is a commonly known term for an exact copy. Moreo=
ver,
> >> the text below doesn't explain what a mirror is either, only how
> >> "update" behaves in it.
> > hmm.  The --mirror option doesn't have any effect (apart from the
> > changes in the config file) until you update.  So I think it's natu=
ral
> > to talk about git update.  No?
>=20
> "git clone" (with or without --mirror) does a couple of things, and i=
t
> does them differently when "--mirror" is used. It mirrors each branch
> from the source repo in the target repo under the same name, includin=
g
> for example any remote branches in the source repo. This is completel=
y
> different without "--mirror", where clone does not look at the source=
's
> remote branches at all. Also, it sets up a mirroring refspec, i.e.
> +refs/*:refs/*
Ah, didn't notice that.

> [...]
> This makes me think that --mirror should be explained on top of --bar=
e.
OK.

> For example:
>=20
> In addition to the mapping of local branches to local branches which
> --bare does, --mirror maps all refs which the source has under the sa=
me
> name in the target (including remote branches, notes etc.) and sets u=
p a
> refspec configuration so that all these refs are updated by a `git
> update` in the target repo.
Hmm, I didn't understand this when I read it the first few times.  The
special thing is that --mirror maps *all* refs, not *same name*.

So maybe:

	Set up a mirror of the remote repository.  This implies `--bare`.
	Compared to `--bare`, `--mirror` doesn't only map local branches of
	the remote to local branches of the target but all refs
	(including remote branches, notes etc.) and sets up a refspec
	configuration such that all these refs are overwritten by a
	`git remote update` in the target repository.

I choosed to write "overwritten" instead of "updated" to make it cleare=
r
that it makes no sence to push into these branches from a different
source.  Should this be noted more explicit?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
