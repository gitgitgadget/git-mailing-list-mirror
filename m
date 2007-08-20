From: Jan Hudec <bulb@ucw.cz>
Subject: Re: confused about preserved permissions
Date: Mon, 20 Aug 2007 21:43:28 +0200
Message-ID: <20070820194328.GE8542@efreet.light.src>
References: <20070820164411.GA15637@piper.oerlikon.madduck.net> <20070820174142.GA7943@glandium.org> <867inqhyuk.fsf@lola.quinscape.zz> <20070820181357.GA8264@glandium.org> <86zm0mgicy.fsf@lola.quinscape.zz> <20070820184829.GA8617@glandium.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+JUInw4efm7IfTNU"
Cc: David Kastrup <dak@gnu.org>, git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Mon Aug 20 21:43:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INDA3-00062n-2l
	for gcvg-git@gmane.org; Mon, 20 Aug 2007 21:43:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757766AbXHTTnf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Aug 2007 15:43:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756041AbXHTTnf
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Aug 2007 15:43:35 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:38521 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755521AbXHTTne (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2007 15:43:34 -0400
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id 1CDAB57289;
	Mon, 20 Aug 2007 21:43:33 +0200 (CEST)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id a3-sK153e7jE; Mon, 20 Aug 2007 21:43:30 +0200 (CEST)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id F3D08573DA;
	Mon, 20 Aug 2007 21:43:29 +0200 (CEST)
Received: from bulb by efreet.light.src with local (Exim 4.67)
	(envelope-from <bulb@ucw.cz>)
	id 1IND9s-0006xf-Fg; Mon, 20 Aug 2007 21:43:28 +0200
Content-Disposition: inline
In-Reply-To: <20070820184829.GA8617@glandium.org>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56243>


--+JUInw4efm7IfTNU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 20, 2007 at 20:48:29 +0200, Mike Hommey wrote:
> On Mon, Aug 20, 2007 at 08:40:13PM +0200, David Kastrup <dak@gnu.org> wro=
te:
> > Mike Hommey <mh@glandium.org> writes:
> >=20
> > > On Mon, Aug 20, 2007 at 07:58:43PM +0200, David Kastrup <dak@gnu.org>=
 wrote:
> > >> > I also never understood why there were no permissions set on
> > >> > directories in trees...
> > >>=20
> > >> Because directories are not actually tracked.  They are created and
> > >> deleted as-needed.
> > >
> > > I don't see why it would prevent to have a permission set to
> > > it... the permission technically can be recorded in the parent tree,
> > > along its sha1. Filesystems are also like this.
> >=20
> > No, they aren't.  Filesystems don't create and delete directories on
> > the fly.  If we record any information about a directory, deleting it
> > automagically would not be appropriate since we would lose information
> > that has not been explicitly deleted.
>=20
> git doesn't magically create directories either. It actually stores
> something about them: the hash of the tree object that represents them.
> And it has permissions associated with these hashes.
>=20
> What it doesn't have, though, is tracking of the directory's history.

Git does not have tracking of file's history either.

There are actually no permissions to record with a directory, since only
executable bit is tracked and that always has to be turned on.

Git actually does store directories in tree objects, but never in the index.
There was a long thread about tracking existence of directories. IMNSHO the
index can start to *always* contain directories, with reader being able to
detect index written without them and automatically fill them in, to keep
compatibility. Than a config option could switch between removing empty
directories implicitly when there are no versioned files in them, or
explicitely.

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--+JUInw4efm7IfTNU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD4DBQFGye7gRel1vVwhjGURAr0/AJ9kK+WNIHLWkstPes1TXC3Du6r1BACYs8+B
Ie4++Gy400QCnbJa7KbshQ==
=k1Rg
-----END PGP SIGNATURE-----

--+JUInw4efm7IfTNU--
