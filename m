From: Jan Hudec <bulb@ucw.cz>
Subject: Re: Another question about importing SVN with fast-import
Date: Mon, 23 Jul 2007 20:06:36 +0200
Message-ID: <20070723180636.GA20174@efreet.light.src>
References: <Pine.LNX.4.64.0707162204480.14971@reaper.quantumfyre.co.uk> <7154c5c60707190009r6d460debs71158d4db9a028d4@mail.gmail.com> <20070720051142.GO32566@spearce.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fUYQa+Pmc3FrFX/N"
Cc: David Frech <david@nimblemachines.com>,
	Julian Phillips <julian@quantumfyre.co.uk>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Jul 23 20:07:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ID2JR-000731-M0
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 20:07:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934095AbXGWSGr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jul 2007 14:06:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933938AbXGWSGq
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jul 2007 14:06:46 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:39774 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1765660AbXGWSGo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2007 14:06:44 -0400
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id 809A7572A9;
	Mon, 23 Jul 2007 20:06:43 +0200 (CEST)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id yEIZ01jXTtzf; Mon, 23 Jul 2007 20:06:42 +0200 (CEST)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id 48C3B5727A;
	Mon, 23 Jul 2007 20:06:41 +0200 (CEST)
Received: from bulb by efreet.light.src with local (Exim 4.67)
	(envelope-from <bulb@ucw.cz>)
	id 1ID2In-0005YC-3p; Mon, 23 Jul 2007 20:06:37 +0200
Content-Disposition: inline
In-Reply-To: <20070720051142.GO32566@spearce.org>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53456>


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 20, 2007 at 01:11:42 -0400, Shawn O. Pearce wrote:
> It is possible.  I'm just not sure what the syntax for it should be.
> Suggestions?  I really want to stay backwards compatible with the
> current "C" command, so:
>=20
> 	'C' SP commit SP path SP path
>=20
> is out because its ambiguous with the current meaning where the
> second (destination) path can contain SP without being quoted by
> the frontend.

I'd suggest one of two variants:
 1) 'M' SP <mode> SP <dataref> SP <path> LF
    where <dataref> would be extended to understand the
    {tag-id|commit-id|tree-id}:path notation git-ref-parse understands plus
    mark:path where mark points to commit.
 2) 'C' SP <dataref> SP <path> LF
    where again <dataref> can be {tag-id|commit-id|tree-id|mark}:path -- or
    just path which implies current head.

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--fUYQa+Pmc3FrFX/N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGpO4sRel1vVwhjGURAn3lAKDL2z9KbTig8EihvGshyTcIzRroLACfQiEB
KkebRaQF/se9gFu785xYZes=
=E39W
-----END PGP SIGNATURE-----

--fUYQa+Pmc3FrFX/N--
