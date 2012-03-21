From: "W. Trevor King" <wking@drexel.edu>
Subject: Re: [PATCH v3] Isolate If-Modified-Since handling in gitweb
Date: Wed, 21 Mar 2012 13:38:24 -0400
Message-ID: <20120321173824.GA31490@odin.tremily.us>
References: <20120321140429.GA28721@odin.tremily.us>
 <201203211755.07121.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary=pf9I7BMVVzbSWLtt
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 21 19:38:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAQQw-0007Fg-A8
	for gcvg-git-2@plane.gmane.org; Wed, 21 Mar 2012 19:38:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759943Ab2CUSit (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Mar 2012 14:38:49 -0400
Received: from vms173015pub.verizon.net ([206.46.173.15]:40676 "EHLO
	vms173015pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759882Ab2CUSis (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Mar 2012 14:38:48 -0400
X-Greylist: delayed 3611 seconds by postgrey-1.27 at vger.kernel.org; Wed, 21 Mar 2012 14:38:48 EDT
Received: from odin.tremily.us ([unknown] [72.68.85.198])
 by vms173015.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0M1800C8TX01AF60@vms173015.mailsrvcs.net> for
 git@vger.kernel.org; Wed, 21 Mar 2012 12:38:26 -0500 (CDT)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 1EEA342860D; Wed,
 21 Mar 2012 13:38:24 -0400 (EDT)
Content-disposition: inline
In-reply-to: <201203211755.07121.jnareb@gmail.com>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193597>


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 21, 2012 at 05:55:06PM +0100, Jakub Narebski wrote:
> There is a tool to create patches to send: git-format-patch.  Myself I
> usually create a new directory for a patch series, e.g. mdir.if_mod.v3,
> and use git-format-patch to populate it, e.g.

Ah, I like that.  Then I can rebase away ;).

> I think it would be better to add initial tests with refactoring, and
> snapshot specific tests with snapshot support, e.g.:
>=20
>   1/2: gitweb: Refactor If-Modified-Since handling and add tests
>   2/2: gitweb: Add If-Modified-Since support for snapshots

But the new tests would be for the new functionality (i.e. snapshot
support), so they wouldn't belong in the general refactoring commit.

> Currently all of those work
>=20
>     http://.../gitweb.cgi?p=3Dgit.git;a=3Dsnapshot;h=3Dv1.7.6;sf=3Dtgz
>     http://.../gitweb.cgi?p=3Dgit.git;a=3Dsnapshot;h=3Df696543d;sf=3Dtgz"
>     http://.../gitweb.cgi?p=3Dgit.git;a=3Dsnapshot;h=3Db1485af8;sf=3Dtgz"
>=20
> v1.7.6 is a tag, f696543d is a commit (v1.7.6^{}), b1485af8 is a tree
> (v1.7.6^{tree}).
>=20
> The last URL would stop working after your change with 404
> "Unknown commit object".

Indeed it does.  I'll add you're suggested skipping for these cases.

There should be a way to determine the oldest commit refering to a
tree, which could be used for timestamping tree-ishes, but that can be
a project for another day ;).

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQEcBAEBAgAGBQJPahIOAAoJEPe7CdOcrcTZssgH/0FY8nBAwxw1fKbYMwr4JEOc
mespoDg+ibiojvXgAx8HO59HS+3o0IyqiGNPUd6x+IyP8RSSIa+86POKc/VKX+vk
g93KIVehY6mrseh589NoVL2jC2s/yOy0EBJeV1SHdslJ7wghIZU6g/vXy88ge3QM
LiXXfKeRkUtX4nSyH/dn6DSpdwzv2zuwcYNVuBoauyt/XyS1qQjTetguGKcoA/DZ
yN9F81rGSNl8V55wdyT1SYL5JplDHiaAon9mYcNPT4MPVyuQR3+fYM0+QM8wf+7y
dCNpnCsLyfZqvJfjAxWvAHO9/fojMcmbjFBhahX6MbmRPvsZXOa1pR6cLfvUTgQ=
=3haI
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--
