From: Jamey Sharp <jamey@minilop.net>
Subject: Re: [PATCHv2 1/2] Support multiple virtual repositories with a
 single object store and refs
Date: Wed, 25 May 2011 08:44:05 -0700
Message-ID: <20110525154405.GA4839@oh.minilop.net>
References: <1306274066-4092-1-git-send-email-jamey@minilop.net>
 <7v7h9f7kzx.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.1.00.1105250847380.2701@bonsai2>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tThc/1wpZn/ma/RB"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Josh Triplett <josh@joshtriplett.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Sixt <johannes.sixt@telecom.at>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed May 25 17:44:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPGFt-0002Zt-Ei
	for gcvg-git-2@lo.gmane.org; Wed, 25 May 2011 17:44:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932779Ab1EYPoM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2011 11:44:12 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:35122 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932560Ab1EYPoL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2011 11:44:11 -0400
Received: by pvg12 with SMTP id 12so3442516pvg.19
        for <git@vger.kernel.org>; Wed, 25 May 2011 08:44:10 -0700 (PDT)
Received: by 10.68.65.198 with SMTP id z6mr3566591pbs.129.1306338250481;
        Wed, 25 May 2011 08:44:10 -0700 (PDT)
Received: from oh.minilop.net (69-71-169-164.mammothnetworks.com [69.71.169.164])
        by mx.google.com with ESMTPS id l3sm5744511pbq.75.2011.05.25.08.44.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 25 May 2011 08:44:09 -0700 (PDT)
Received: from jamey by oh.minilop.net with local (Exim 4.76)
	(envelope-from <jamey@oh.minilop.net>)
	id 1QPGFh-0001HQ-Tb; Wed, 25 May 2011 08:44:05 -0700
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.1105250847380.2701@bonsai2>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174417>


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 25, 2011 at 08:51:07AM +0200, Johannes Schindelin wrote:
> On Tue, 24 May 2011, Junio C Hamano wrote:
> > Jamey Sharp <jamey@minilop.net> writes:
> > > Given many repositories with copies of the same objects (such as=20
> > > branches of the same source), sharing a common object store will avoi=
d=20
> > > duplication.  Alternates provide a single baseline, but don't handle=
=20
> > > ongoing activity in the various repositories.  Git safely handles=20
> > > concurrent accesses to the same object store across repositories, but=
=20
> > > operations such as gc need to know about all of the refs.
> > >
> > > This change adds support in upload-pack and receive-pack to simulate=
=20
> > > multiple virtual repositories within the object store and references=
=20
> > > of
> >=20
> > Is it just me to read the above and then have to re-read the first=20
> > sentence of the second paragraph over and over again?  There seems to b=
e=20
> > a huge gap in logic flow, probably largely due to the use of undefined=
=20
> > term "virtual repository".
>=20
> I had to read the example call to understand that 'virtual repository'=20
> means 'one real catch-em-all repository'.
>=20
> I wonder about two things, though:
>=20
> 1) Would teaching git clone to understand "-t this/repo/*" help?

Sure, that would be an improvement for our use case, but we expect to
have lots of these virtual repositories, so I think we'd rather have the
server-side help we proposed in these patches. Seems to me that
wildcards in git-clone would be nice for other use cases, though.

> 2) You're extending the protocol by appending the prefix after the SHA-1,=
=20
>    and I stopped halfway through the patch trying to find information=20
>    which I now think should be in the commit message: a) why? b) why does=
=20
>    it not break when one of the two sides is a previous version?

I don't think we're changing the protocol in any way...? In all of our
tests, the client was Debian's package of git version 1.7.5.1. And note
that none of these patches touch client-side protocol code; it's all in
the server-side upload-pack and receive-pack.

If we have changed the protocol, it was unintentional and we should fix
it.

Jamey

--tThc/1wpZn/ma/RB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk3dI7EACgkQp1aplQ4I9mV5lwCfZo3lPqdLGm3VgOH4yiX9UFr5
W3wAnjKTMp+bS7vUAirmvqB491B31NEs
=sWND
-----END PGP SIGNATURE-----

--tThc/1wpZn/ma/RB--
