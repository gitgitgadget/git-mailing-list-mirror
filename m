From: Jeff King <peff@peff.net>
Subject: Re: Git-mediawiki : Encoding problems in perl
Date: Wed, 8 Jun 2011 12:18:17 -0400
Message-ID: <20110608161816.GA13175@sigill.intra.peff.net>
References: <BANLkTimy85b3nu05FBjXzdnTJP0RBWdxiQ@mail.gmail.com>
 <20110608150106.GB7805@sigill.intra.peff.net>
 <vpqhb8049m3.fsf@bauges.imag.fr>
 <BANLkTi=DLZQM_jzove_g0wLy_zgBF6Z0Xw@mail.gmail.com>
 <vpqtyc0wc1j.fsf@bauges.imag.fr>
 <BANLkTinKV3k7uu=+QzvUjrLdRD0TUj67pw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, thomas@xteddy.org,
	git@vger.kernel.org
To: =?utf-8?B?SsOpcsOpbWll?= NIKAES <jeremie.nikaes@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 18:18:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QULSb-0001rO-6C
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 18:18:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751070Ab1FHQSU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Jun 2011 12:18:20 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:56735
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750986Ab1FHQSU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 12:18:20 -0400
Received: (qmail 32128 invoked by uid 107); 8 Jun 2011 16:18:27 -0000
Received: from c-76-21-13-32.hsd1.ca.comcast.net (HELO sigill.intra.peff.net) (76.21.13.32)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 08 Jun 2011 12:18:27 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 08 Jun 2011 12:18:17 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTinKV3k7uu=+QzvUjrLdRD0TUj67pw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175392>

On Wed, Jun 08, 2011 at 06:15:15PM +0200, J=C3=A9r=C3=A9mie NIKAES wrot=
e:

> 2011/6/8 Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>:
>=20
> > there should probably have been a $/ =3D 1; or some other perl magi=
c to
> > make sure we don't read only the first line there:
> >
>=20
> Yes, it indeed currently reads only the first line. I'm going to see
> what kind of magic I need to use.

You need to set $/ to undef. Use "local" to prevent it from polluting
other parts of the code, like:

  my $var =3D do { local $/; <$handle> };

-Peff
