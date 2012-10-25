From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [PATCH] Fixes handling of --reference argument.
Date: Thu, 25 Oct 2012 06:45:19 -0400
Message-ID: <20121025104519.GA3816@odin.tremily.us>
References: <5088c5a4.L25tOcUVCSwBRpYF%szager@google.com>
 <20121025083625.GA8390@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary=+QahgC5+KEYLbs62
Cc: szager@google.com, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 25 13:45:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRLsn-0002JR-4C
	for gcvg-git-2@plane.gmane.org; Thu, 25 Oct 2012 13:45:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753779Ab2JYLpl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2012 07:45:41 -0400
Received: from vms173009pub.verizon.net ([206.46.173.9]:31849 "EHLO
	vms173009pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751402Ab2JYLpk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2012 07:45:40 -0400
X-Greylist: delayed 3605 seconds by postgrey-1.27 at vger.kernel.org; Thu, 25 Oct 2012 07:45:40 EDT
Received: from odin.tremily.us ([unknown] [72.68.84.95])
 by vms173009.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MCG00BK837KKS80@vms173009.mailsrvcs.net> for
 git@vger.kernel.org; Thu, 25 Oct 2012 05:45:21 -0500 (CDT)
Received: by odin.tremily.us (Postfix, from userid 1000)	id DC61E67F62E; Thu,
 25 Oct 2012 06:45:19 -0400 (EDT)
Content-disposition: inline
In-reply-to: <20121025083625.GA8390@sigill.intra.peff.net>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208394>


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 25, 2012 at 04:36:26AM -0400, Jeff King wrote:
> On Wed, Oct 24, 2012 at 09:52:52PM -0700, szager@google.com wrote:
> > diff --git a/git-submodule.sh b/git-submodule.sh
> > index ab6b110..dcceb43 100755
> > --- a/git-submodule.sh
> > +++ b/git-submodule.sh
> > @@ -270,7 +270,6 @@ cmd_add()
> >  			;;
> >  		--reference=3D*)
> >  			reference=3D"$1"
> > -			shift
> >  			;;
>=20
> Is that right? We'll unconditionally do a "shift" at the end of the
> loop. If it were a two-part argument like "--reference foo", the extra
> shift would make sense, but for "--reference=3D*", no extra shift should
> be neccessary. Am I missing something?

Both the patch and Jeff's analysis are right.  You only need an
in-case shift if you consume "$2", or you're on =E2=80=98--=E2=80=99 and yo=
u're
breaking before the end-of-case shift.

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--+QahgC5+KEYLbs62
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQiRg9AAoJEEUbTsx0l5OMYoMP/3KsWXse/cRlsJ5Sfinm2HMA
4CShw5FTZBFO1xi0zfdarnHwE1bkoVqj59ZFV7hRLIAK0LW9LkfMQGhcuSsyqeyO
gXmc5DCEXD+13umBB5TNOuCvbmfzNk0ZyYvmn7+y/j6wGOQhXLE4jnxe7bYJ5iaU
sx0ElZXt081pC71ArbvLKMImMqxlbM5YjyNK0y3ycnHVj4ivrWF1fK6gurT27LA+
gVNi/Ta2qB3+407pqZGSk/u1a781HwI6cjfukjT0u8RTGy0VC8iOUy2KAGxrKho7
r936nqfMC6PigP2qujxbcHW/dv9lhQ6DGufEMmCZ9bL8G4OlDe6aBpRuFyv02Ekl
bBb3MplJDDpV+Ii70N1oF5cL86Ba1exhvXjHWnWm3O1GzUJ3CbbtGj9JP/warsr1
1JS+3rK6sd3BnODofJoCxtl3KvIgvFnwqOjEEwP72BHVpQUfKshRf21M5kjaMK30
ezrs7I+aC8vInkd1HgKQovHcNYaLZM9P72dsOyrCFq7+fOnRszO+COHvSV1NFtGP
A2r2MXorQXmxZsoacatTle+0ul1rJLv+RnyR4bmM8LsZwcluZprCmBANzLGpXFg4
6a9Nx8CO6Vt4Srwz/Gc8GELKKJ+XAlYj/5Hxd/KbILGLxacdsj2AaZWVy6w8lt/3
yzkH+wlWTXma0IgX/KSG
=wrbP
-----END PGP SIGNATURE-----

--+QahgC5+KEYLbs62--
