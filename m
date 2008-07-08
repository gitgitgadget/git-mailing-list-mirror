From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] bash: offer only paths after '--'
Date: Tue, 8 Jul 2008 23:18:37 +0000
Message-ID: <20080708231837.GA16895@spearce.org>
References: <279b37b20807071341k3551e61cl10c5969600ba8218@mail.gmail.com> <20080708044922.GD2542@spearce.org> <7vprppvt7a.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0807081335470.4319@eeepc-johanness> <20080708165614.GB8224@neumann> <7vtzf0rusw.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: SZEDER GGGbor <szeder@ira.uka.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Raible <raible@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 09 01:19:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGMTE-0000BV-GN
	for gcvg-git-2@gmane.org; Wed, 09 Jul 2008 01:19:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758725AbYGHXSj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Jul 2008 19:18:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758284AbYGHXSj
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jul 2008 19:18:39 -0400
Received: from george.spearce.org ([209.20.77.23]:60591 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758915AbYGHXSi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2008 19:18:38 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 626BB38195; Tue,  8 Jul 2008 23:18:37 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7vtzf0rusw.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87806>

Junio C Hamano <gitster@pobox.com> wrote:
> SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:
>=20
> > Hope that I got the commit message right (;
>=20
> It was very readable.  Thanks.

Acked-by: Shawn O. Pearce <spearce@spearce.org>

> > +__git_has_doubledash ()
> > +{
> > +	local c=3D1
> > +	while [ $c -lt $COMP_CWORD ]; do
> > +		if [ "--" =3D "${COMP_WORDS[c]}" ]; then
> > +			return 0
> > +		fi
> > +		c=3D$((++c))
>=20
> This assignment is somewhat curious, although it should work as expec=
ted
> either way ;-)

I agree, its damned odd.  But we already do this in the same
sort of loop inside of _git_branch() (see around line 541 in
next).  This new patch is only sticking with our current set
of conventions in the script, so I say its fine.

--=20
Shawn.
