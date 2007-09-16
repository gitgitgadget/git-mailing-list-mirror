From: Jan Hudec <bulb@ucw.cz>
Subject: Re: metastore (was: Track /etc directory using Git)
Date: Sun, 16 Sep 2007 17:51:47 +0200
Message-ID: <20070916155147.GA30476@efreet.light.src>
References: <20070915132632.GA31610@piper.oerlikon.madduck.net> <Pine.LNX.4.64.0709151507310.28586@racer.site> <20070915145437.GA12875@piper.oerlikon.madduck.net> <Pine.LNX.4.64.0709151430040.5298@iabervon.org> <Pine.LNX.4.64.0709152310380.28586@racer.site> <20070916061411.GC24124@piper.oerlikon.madduck.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yrj/dFKFPuw6o+aM"
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	"Thomas Harning Jr." <harningt@gmail.com>,
	Francis Moreau <francis.moro@gmail.com>,
	Nicolas Vilz <niv@iaglans.de>,
	David =?utf-8?B?SMOkcmRlbWFu?= <david@hardeman.nu>
To: martin f krafft <madduck@madduck.net>
X-From: git-owner@vger.kernel.org Sun Sep 16 17:52:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWwPg-00007r-2N
	for gcvg-git-2@gmane.org; Sun, 16 Sep 2007 17:52:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751762AbXIPPv4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Sep 2007 11:51:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751730AbXIPPv4
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Sep 2007 11:51:56 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:37066 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751583AbXIPPvz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Sep 2007 11:51:55 -0400
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id F1CB2572EB;
	Sun, 16 Sep 2007 17:51:53 +0200 (CEST)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id j6ZrGkjF1ucR; Sun, 16 Sep 2007 17:51:51 +0200 (CEST)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id 654AF572D9;
	Sun, 16 Sep 2007 17:51:50 +0200 (CEST)
Received: from bulb by efreet.light.src with local (Exim 4.67)
	(envelope-from <bulb@ucw.cz>)
	id 1IWwPT-0000Ei-Bz; Sun, 16 Sep 2007 17:51:47 +0200
Content-Disposition: inline
In-Reply-To: <20070916061411.GC24124@piper.oerlikon.madduck.net>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58321>


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 16, 2007 at 08:14:11 +0200, martin f krafft wrote:
> also sprach Johannes Schindelin <Johannes.Schindelin@gmx.de> [2007.09.16.=
0014 +0200]:
> > While at it, you should invent a fallback what to do when the
> > owner is not present on the system you check out on.  And
> > a fallback when checking out on a filesystem that does not support
> > owners.
>=20
> Like rsync, git would use numerical UIDs (which are always present)
> by default, but could be told to try to map account names.
>=20
> If the filesystem does not support owners, chown() would not exist.
> I actually tend to think of things the other way around: instead of
> a fallback when chown() does not work (what would such a fallback be
> other than not chown()ing?), it would only try chown() if such
> functionality existed.

There's a problem. You need to know that the functionality is missing and n=
ot
try to read attributes back, but instead consider them unchanged. Nothing
that can't be taken care of, but it needs to be handled carefuly.

> > And a fallback when a non-root user uses it.
>=20
> That's easy, Unix already provides you with that "fallback": pack up
> /etc in a tar and unpack it as a normal user...

But if you tar that up again, the owners will be different. But you don't
want the change.

> > Oh, and while you're at it (you said that it would be nice not to
> > restrict git in any way: "it is a content tracker") support the
> > Windows style "Group-or-User-or-something:[FRW]" ACLs.
>=20
> Provided we find a way to implement this in an extensible manner,
> this should not be hard to do. I can't do it since I don't have
> access to a Windows machine.
>=20
> Your statement does catch me off-guard though. Does git now
> officially target Windows?

Official git works in cygwin. There is also a port to msys, which is
not official in a sense it is not merged into mainline.

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFG7VETRel1vVwhjGURAlZRAJ9hd9KyDqvv10az4QsPlNOqybjfDwCfVKA6
KwkKnqReJqDsGJhGv9uPAvU=
=7dvg
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--
