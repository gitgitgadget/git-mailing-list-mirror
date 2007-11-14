From: Kristis Makris <kristis.makris@asu.edu>
Subject: Re: Git and Scmbug integration
Date: Tue, 13 Nov 2007 17:16:44 -0700
Message-ID: <1194999404.4106.40.camel@localhost>
References: <1194980792.4106.6.camel@localhost>
	 <ee77f5c20711131500h6ee067ffv3e488ac7bde1d22c@mail.gmail.com>
	 <1194998142.4106.24.camel@localhost>
	 <ee77f5c20711131602m5b9042fx72689af53e24ddd2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=_morpheus-32187-1194999435-0001-2"
Cc: jnareb@gmail.com, git@vger.kernel.org, scmbug-users@lists.mkgnu.net
To: David Symonds <dsymonds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 14 01:17:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Is5wj-0006H7-GK
	for gcvg-git-2@gmane.org; Wed, 14 Nov 2007 01:17:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755571AbXKNARR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 19:17:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755374AbXKNARR
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 19:17:17 -0500
Received: from net.mkgnu.net ([67.40.69.52]:60415 "EHLO mail.mkgnu.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754693AbXKNARQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 19:17:16 -0500
Received: from syd-mkgnu-net.dhcp.asu.edu (syd-mkgnu-net.dhcp.asu.edu [::ffff:149.169.179.39])
  (AUTH: LOGIN mkgnu@mkgnu.net)
  by morpheus with esmtp; Tue, 13 Nov 2007 17:17:14 -0700
  id 00011EC9.473A3E8A.00007DBB
In-Reply-To: <ee77f5c20711131602m5b9042fx72689af53e24ddd2@mail.gmail.com>
X-Mailer: Evolution 2.6.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64927>

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_morpheus-32187-1194999435-0001-2
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2007-11-14 at 11:02 +1100, David Symonds wrote:
> On Nov 14, 2007 10:55 AM, Kristis Makris <kristis.makris@asu.edu> wrote:
> > On Wed, 2007-11-14 at 10:00 +1100, David Symonds wrote:
> > > > http://bugzilla.mkgnu.net/show_bug.cgi?id=3D991
> > > >
> > > > There's no hook that will trigger when a tag is applied.
> > >
> > > I believe the 'update' hook is run when the tag is pushed.
> >
> > Even if that is true, there no hook that will trigger when a local tag
> > is applied.
>=20
> Unannotated tags don't make a proper new object, only a ref. If you
> stick to annotated tags, you'll get new objects added which, I think,
> should trigger the post-commit hook.

I just tried again tagging with both:

$ git tag TAG_NAME

$ git tag -a TAG_NAME

and I don't get the post-commit hook executed.

Perhaps I missed something ?

> > I'd like the commit hook to provide enough information to be able to
> > tell which files were modified and their respective old/new version (or
> > perhaps their old/new SHA-1 hash). If the new SHA-1 hash can be used to
> > extract all that, that's ok with me. But right now there's nothing.
>=20
> If you have the new commit's SHA-1, it's very simple to get the parent
> commit's SHA-1 and do whatever you want. A complexity would be with
> handling merges, where a commit has multiple parents. If you have a
> commit SHA-1 hash, you can just "git diff --name-only <hash>^ <hash>"
> to get a list of the files changed by <hash>.

This sounds great. If the post-commit hook could now provide the new
commit SHA-1 hash than that should be what I need.

Can the new commit SHA-1 hash be added as a parameter to the post-commit
hook please ?

--=_morpheus-32187-1194999435-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHOj5s/KuTDwnYLxERAjz7AKCSzkSVJE2e6gUwiXwGWGTxPgPiOQCbBKd6
5AzEFqi3+mYLPSdwkRzDn1k=
=KtIe
-----END PGP SIGNATURE-----

--=_morpheus-32187-1194999435-0001-2--
