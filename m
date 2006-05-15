From: Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: [PATCH] gitk: Display commit messages with word wrap
Date: Mon, 15 May 2006 19:06:19 +0400
Message-ID: <20060515150619.GC19254@master.mivlgu.local>
References: <20060514151456.GA18012@procyon.home> <17511.48749.631725.358279@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DIOMP1UsTsWJauNi"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 15 17:06:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FfeeO-0001HW-Lv
	for gcvg-git@gmane.org; Mon, 15 May 2006 17:06:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964915AbWEOPGV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 May 2006 11:06:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964940AbWEOPGV
	(ORCPT <rfc822;git-outgoing>); Mon, 15 May 2006 11:06:21 -0400
Received: from mivlgu.ru ([81.18.140.87]:57522 "EHLO master.mivlgu.local")
	by vger.kernel.org with ESMTP id S964915AbWEOPGU (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 May 2006 11:06:20 -0400
Received: by master.mivlgu.local (Postfix, from userid 1000)
	id 81E41180110; Mon, 15 May 2006 19:06:19 +0400 (MSD)
To: Paul Mackerras <paulus@samba.org>
Content-Disposition: inline
In-Reply-To: <17511.48749.631725.358279@cargo.ozlabs.ibm.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20051>


--DIOMP1UsTsWJauNi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 15, 2006 at 09:34:05AM +1000, Paul Mackerras wrote:
> Sergey Vlasov writes:
>=20
> > Some people put very long strings into commit messages, which then
> > become invisible in gitk (word wrapping in the commit details window is
> > turned off, and there is no horizontal scroll bar).  Enabling word wrap
> > for just the commit message looks much better.
>=20
> Well... you can scroll in any direction with mouse button 2, but ok...

I completely forgot about this obscure feature of Tk (and is it only me
who thinks that it scrolls in the wrong direction?).

> > +    $ctext insert end "\n" {}
>=20
> Why are you adding the superfluous {} ?

Because I was paranoid about not letting the tag leak into subsequent
text...  but apparently this does not happen even without that {}, so I'll
remove it.

> > -    set comment {}
> > +    set headers {}
>=20
> Why are you changing the name here?  Your commit description doesn't
> address either of these points.

Previously the "comment" variable contained both the commit headers
("Parent:" and "Child:" lines) and the commit message, and all this text
was inserted into $ctext by a single call to "appendwithlinks".  Now I
need to insert these parts separately (wrapped "Parent:" and "Child:"
lines look bad, I want to wrap only the commit message), therefore only
headers are collected in that variable - so I renamed it to reflect this
new usage.

I'll send the updated patch in a separate message.

--DIOMP1UsTsWJauNi
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFEaJjrW82GfkQfsqIRAgaNAJ94Xb/YAlpbcY+IogOFL3bmsiuFBwCfdvKB
JrOd2iB5QET3XolYsgDEjxs=
=0UBr
-----END PGP SIGNATURE-----

--DIOMP1UsTsWJauNi--
