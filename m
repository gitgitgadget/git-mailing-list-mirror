From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [PATCH] cmd_reset: don't trash uncommitted changes unless told
	to
Date: Thu, 26 Jun 2008 14:35:39 +0200
Message-ID: <20080626123539.GA22219@atjola.homenet>
References: <1214346098-24584-1-git-send-email-stevenrwalter@gmail.com> <7vwskea2ik.fsf@gitster.siamese.dyndns.org> <48620C1A.6000509@panasas.com> <alpine.DEB.1.00.0806251109380.9925@racer> <486220CE.3070103@viscovery.net> <alpine.DEB.1.00.0806251334060.9925@racer> <20080625135100.GF20361@mit.edu> <7v63rx2zwf.fsf@gitster.siamese.dyndns.org> <20080626115550.GA23058@atjola.homenet> <alpine.DEB.1.00.0806261306060.9925@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Theodore Tso <tytso@mit.edu>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Boaz Harrosh <bharrosh@panasas.com>,
	Steven Walter <stevenrwalter@gmail.com>, git@vger.kernel.org,
	jeske@google.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jun 26 14:37:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBqix-0000wU-Uo
	for gcvg-git-2@gmane.org; Thu, 26 Jun 2008 14:37:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758698AbYFZMfq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 Jun 2008 08:35:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753578AbYFZMfq
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jun 2008 08:35:46 -0400
Received: from mail.gmx.net ([213.165.64.20]:55436 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754821AbYFZMfo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2008 08:35:44 -0400
Received: (qmail invoked by alias); 26 Jun 2008 12:35:41 -0000
Received: from i577B9D84.versanet.de (EHLO atjola.local) [87.123.157.132]
  by mail.gmx.net (mp062) with SMTP; 26 Jun 2008 14:35:41 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX18xuAcNYDkxWN9aiz+niIjIw0Kbd61jh9IElsP47g
	N/rmjdAwgk9Jaz
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0806261306060.9925@racer>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86447>

On 2008.06.26 13:07:40 +0100, Johannes Schindelin wrote:
> On Thu, 26 Jun 2008, Bj=F6rn Steinbrink wrote:
>=20
> > On 2008.06.25 10:22:08 -0700, Junio C Hamano wrote:
> > > Theodore Tso <tytso@mit.edu> writes:
> > >=20
> > > > I used to argue for this, but gave up, because no one seemed to=
 agree
> > > > with me.  So now I just have the following in
> > > > /home/tytso/bin/git-revert-file and I am very happy:
> > > >
> > > > #!/bin/sh
> > > > #
> > > > prefix=3D$(git rev-parse --show-prefix)
> > > >
> > > > for i in $*
> > > > do
> > > >         git show HEAD:$prefix$i > $i
> > > > done
> > >=20
> > > Isn't that this?
> > >=20
> > >         #!/bin/sh
> > >         exec git checkout HEAD -- "$@"
> >=20
> > I thought so at first, too, but there's one difference. Ted's versi=
on
> > doesn't affect the index, while yours does. Of course I cannot tell=
 if
> > Ted actually intended not to touch the index ;-)
>=20
> While we are nit-picking: Ted's version does not respect autocrlf, wh=
ile=20
> Junio's does.
>=20
> Oh, and Junio's version works with spaces and other funny stuff in fi=
le=20
> names, while Ted's does not.
>=20
> Oh, and error checking is correct in Junio's version.
>=20
> I am sure there are more differences.

I didn't intend to nit-pick, sorry if it looked like that. Not touching
the index might have been a conscious decision, but obviously I must
have missed some email that made it clear that it was intended to also
revert the index entry. Very sorry...

Thanks for the information on autocrlf though, didn't know that show
doesn't care about that.

Bj=F6rn
