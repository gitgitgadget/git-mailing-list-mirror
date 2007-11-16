From: Sebastian Harl <sh@tokkee.org>
Subject: Re: [PATCH] Git.pm: Don't return 'undef' in vector context.
Date: Fri, 16 Nov 2007 13:47:46 +0100
Message-ID: <20071116124746.GW29439@albany.tokkee.org>
References: <473D3593.9080806@zwell.net> <7vfxz61yox.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GTZ+2qEBTXdGs1w1"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 16 13:59:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1It0nK-00014O-A4
	for gcvg-git-2@gmane.org; Fri, 16 Nov 2007 13:59:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932409AbXKPM7T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Nov 2007 07:59:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932382AbXKPM7T
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Nov 2007 07:59:19 -0500
Received: from mail.tokkee.org ([212.114.247.92]:33644 "EHLO albany.tokkee.org"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932336AbXKPM7S (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Nov 2007 07:59:18 -0500
X-Greylist: delayed 689 seconds by postgrey-1.27 at vger.kernel.org; Fri, 16 Nov 2007 07:59:18 EST
Received: by albany.tokkee.org (Postfix, from userid 1000)
	id F0B46364001; Fri, 16 Nov 2007 13:47:46 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vfxz61yox.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65222>


--GTZ+2qEBTXdGs1w1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Nov 15, 2007 at 10:39:26PM -0800, Junio C Hamano wrote:
> Dan Zwell <dzwell@gmail.com> writes:
> > Previously, the Git->repository()->config('non-existent.key')
> > evaluated to as true in a vector context. Return an empty list
> > instead.
> > ---
> > I don't know whether this breaks anything, because I don't use most of
> > the git perl scripts. I can't imagine that there is a script that
> > relies on the fact that config('non-existent.key') actually returns
> > (''), in an array context. Is this a reasonable change?
>=20
> I did not examine the callers but my gut feeling is that it
> would be simpler and cleaner to always return () without
> checking the context.
[...]
> I generally try to stay away from functions that changes their
> return values depending on the context, because they tend to
> make reading the callers to find bugs more difficult.

In fact, if you simply return without any value, it will evaluate to "false"
no matter which context it has been called in ("()" in list context, "undef"
in scalar context, etc.). So, it's generally a good idea to use "return;" to
indicate an error.

Cheers,
Sebastian

--=20
Sebastian "tokkee" Harl +++ GnuPG-ID: 0x8501C7FC +++ http://tokkee.org/

Those who would give up Essential Liberty to purchase a little Temporary
Safety, deserve neither Liberty nor Safety.         -- Benjamin Franklin


--GTZ+2qEBTXdGs1w1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHPZFyEFEKc4UBx/wRAtfmAJ9fDbYpX699cTgZ7fDvIk87TTqbHACdF3Cr
R/TIbcT7wj1muBLQq9sr2Oo=
=e2x4
-----END PGP SIGNATURE-----

--GTZ+2qEBTXdGs1w1--
