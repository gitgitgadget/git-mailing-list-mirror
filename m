From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-send-email: add ~/.authinfo parsing
Date: Mon, 4 Feb 2013 15:10:40 -0500
Message-ID: <20130204201040.GA13272@sigill.intra.peff.net>
References: <2f93ce7b6b5d3f6c6d1b99958330601a5560d4ba.1359486391.git.mina86@mina86.com>
 <7vvcafojf4.fsf@alter.siamese.dyndns.org>
 <20130130074306.GA17868@sigill.intra.peff.net>
 <xa1tmwvk9gy1.fsf@mina86.com>
 <878v74vwst.fsf@lifelogs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michal Nazarewicz <mina86@mina86.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Krzysztof Mazur <krzysiek@podlesie.net>
To: Ted Zlatanov <tzz@lifelogs.com>
X-From: git-owner@vger.kernel.org Mon Feb 04 21:11:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2SNd-0007BI-Sf
	for gcvg-git-2@plane.gmane.org; Mon, 04 Feb 2013 21:11:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754209Ab3BDUKo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Feb 2013 15:10:44 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:60594 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753500Ab3BDUKn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2013 15:10:43 -0500
Received: (qmail 21922 invoked by uid 107); 4 Feb 2013 20:12:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 04 Feb 2013 15:12:08 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 04 Feb 2013 15:10:40 -0500
Content-Disposition: inline
In-Reply-To: <878v74vwst.fsf@lifelogs.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215415>

On Mon, Feb 04, 2013 at 12:00:34PM -0500, Ted Zlatanov wrote:

> On Mon, 04 Feb 2013 17:33:58 +0100 Michal Nazarewicz <mina86@mina86.c=
om> wrote:=20
>=20
> MN> As far as I understand, there could be a git-credential helper th=
at
> MN> reads ~/.authinfo and than git-send-email would just call =E2=80=9C=
git
> MN> credential fill=E2=80=9D, right?
>=20
> MN> I've noticed though, that git-credential does not support port ar=
gument,
> MN> which makes it slightly incompatible with ~/.authinfo.
>=20
> My proposed netrc credential helper does this :)
>=20
> The token mapping I use:
>=20
> port, protocol        =3D> protocol
> machine, host         =3D> host
> path                  =3D> path
> login, username, user =3D> username
> password              =3D> password
>=20
> I think that's sensible.

Technically you can speak a particular protocol on an alternate port:

  https://example.com:31337/repo.git

In this case, git will send you the host as:

  example.com:31337

You might want to map this to "port" in .autoinfo separately if it's
available.

-Peff
