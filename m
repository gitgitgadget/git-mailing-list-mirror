From: Carlos =?iso-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: git diff <file> HEAD^:<file> error message
Date: Thu, 12 Jan 2012 11:31:52 +0100
Message-ID: <20120112103152.GC11984@beez.lab.cmartin.tk>
References: <20120111111831.GB15232@beez.lab.cmartin.tk>
 <7vr4z54pwp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7qSK/uQB79J36Y4o"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 12 11:32:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RlHwu-0003nD-UZ
	for gcvg-git-2@lo.gmane.org; Thu, 12 Jan 2012 11:32:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751739Ab2ALKb4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jan 2012 05:31:56 -0500
Received: from kimmy.cmartin.tk ([91.121.65.165]:51964 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751317Ab2ALKbz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jan 2012 05:31:55 -0500
Received: from beez.lab.cmartin.tk (z39c5.pia.fu-berlin.de [87.77.57.197])
	by kimmy.cmartin.tk (Postfix) with ESMTPA id 40383461C3;
	Thu, 12 Jan 2012 11:31:41 +0100 (CET)
Received: (nullmailer pid 32294 invoked by uid 1000);
	Thu, 12 Jan 2012 10:31:52 -0000
Mail-Followup-To: Carlos =?iso-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vr4z54pwp.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188441>


--7qSK/uQB79J36Y4o
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 11, 2012 at 06:26:30PM -0800, Junio C Hamano wrote:
> Carlos Mart=EDn Nieto <cmn@elego.de> writes:
>=20
> > I was trying to figure out why running
> >
> >    git diff HEAD^:RelNotes RelNotes
> >
> > gives the expected output (on maint it tells me that the stable
> > version changed from 1.7.8.3 to 1.7.8.4) but swapping the arguments
> > doesn't.
> >
> >    git diff RelNotes HEAD^:RelNotes
> >
> > doesn't show the opposite patch ...
>=20
> That comes from the general argument parsing rules of Git, namely, global
> options (e.g. --paginate) first, then subcommand name, followed by dashed
> options, revs and finally the paths. Once you give "RelNotes", which
> cannot be a rev, you cannot give a rev.
>=20
> We _could_ special case the rule for "diff", but we simply didn't bother,
> as the resulting code (and the implications of special casing) would be
> too ugly to live to support such a corner case usage, especially when you
> could always say "-R" to reverse the output.

The rule "non-rev stops rev parsing" is fair enough. The error message
is still very misleading, as it lies about RelNotes not being in HEAD^
and gives the impression that it was parsed as a rev (which I guess it
was, but only to show the message).

   cmn


--7qSK/uQB79J36Y4o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJPDraYAAoJEHKRP1jG7ZzTLkkH/0ib2iLePDYxmp2+dGitpWbW
xb79AmY7hjXLzfH96XgnIbN2Ry3acDIFX0TFWdwN8Qv1/pbIIFXbUQ1IlmVkp6nX
ngD10lPS6nr0jLxtXhn8K3VZ7WvLgG/acwqcQtufNB4UwdJc93b5mGnQeTLs7jtj
awW8tnSfknC1btppE2ZH0mtP4ikW2aVha6HhufFOyqYRpDWqy5AoQKB6EROap3Ar
qROh517of01MW9D4+oeyzN6jpUITgVnQefIZCW+KYfIupKKXMIN0eD+7ji8P/c9o
NJnv2BryA27h4552WMmG6H03LvIqMy9TCMqYz0Pmm9aVmD5QR3KbB54MEDfAYeI=
=9qKM
-----END PGP SIGNATURE-----

--7qSK/uQB79J36Y4o--
