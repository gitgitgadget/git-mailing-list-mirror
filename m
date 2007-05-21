From: Martin Waitz <tali@admingilde.org>
Subject: Re: [PATCH v2] Submodule merge support
Date: Mon, 21 May 2007 09:32:53 +0200
Message-ID: <20070521073253.GU5412@admingilde.org>
References: <20070520154227.GG5412@admingilde.org> <20070521062005.GK3141@spearce.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1LW0Rr0Uq98qh6Rv"
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon May 21 09:33:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hq2O5-0008Ro-7b
	for gcvg-git@gmane.org; Mon, 21 May 2007 09:33:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754545AbXEUHcz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 May 2007 03:32:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754933AbXEUHcz
	(ORCPT <rfc822;git-outgoing>); Mon, 21 May 2007 03:32:55 -0400
Received: from mail.admingilde.org ([213.95.32.147]:60737 "EHLO
	mail.admingilde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754545AbXEUHcy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2007 03:32:54 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1Hq2Nx-00027U-Ft; Mon, 21 May 2007 09:32:53 +0200
Content-Disposition: inline
In-Reply-To: <20070521062005.GK3141@spearce.org>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47981>


--1LW0Rr0Uq98qh6Rv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Mon, May 21, 2007 at 02:20:05AM -0400, Shawn O. Pearce wrote:
> > @@ -574,6 +575,21 @@ static void update_file_flags(const unsigned char =
*sha,
> >  		void *buf;
> >  		unsigned long size;
> > =20
> > +		if (S_ISDIRLNK(mode)) {
> > +			/* defer dirlinks to another process, don't try to */
> > +			/* read the object "sha" here */
> > +			const char *dirlink_checkout[] =3D {
> > +				"dirlink-checkout", path, sha1_to_hex(sha), NULL
> > +			};
> > +			struct child_process cmd =3D {
> > +				.argv =3D dirlink_checkout,
> > +				.git_cmd =3D 1,
> > +			};
>=20
> My Solaris 9 system cannot compile this syntax, even though it is
> a clean way to initalize the child_process.

any special thing it does not like in the above code or does it just
not support structs that are initialized that way?

> > +	status =3D read(cmd.out, hex, sizeof(hex));
> > +	if (status !=3D 40) return status;
>=20
> OK, this is probably just never trusting the OS, but shouldn't that
> read be wrapped up in a loop, like our read_in_full?  We want 40
> bytes here, and expect it, and the read call is allowed to return
> as few as 1 byte....

right.

--=20
Martin Waitz

--1LW0Rr0Uq98qh6Rv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFGUUslj/Eaxd/oD7IRAgYnAJ90HcXInbk2R/SQiOxU6f4/9Pw2eQCfT5pr
MqjoHLUjZzRHiWbZtqX9V+s=
=LA/r
-----END PGP SIGNATURE-----

--1LW0Rr0Uq98qh6Rv--
