From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] checkout: implement "-" shortcut name for last branch
Date: Thu, 15 Jan 2009 18:05:42 +0100
Message-ID: <200901151805.44747.trast@student.ethz.ch>
References: <1231977976-8739-1-git-send-email-trast@student.ethz.ch> <200901151501.26394.trast@student.ethz.ch> <alpine.DEB.1.00.0901151510340.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart6848063.5Ob9e72fmg";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <junio@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 15 18:07:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNVgD-0003A5-6j
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 18:06:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755621AbZAORF3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2009 12:05:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755567AbZAORF2
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jan 2009 12:05:28 -0500
Received: from xsmtp0.ethz.ch ([82.130.70.14]:21176 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755321AbZAORF2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2009 12:05:28 -0500
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 15 Jan 2009 18:05:26 +0100
Received: from pcjremy.inf.ethz.ch ([129.132.153.233]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 15 Jan 2009 18:05:26 +0100
User-Agent: KMail/1.9.9
In-Reply-To: <alpine.DEB.1.00.0901151510340.3586@pacific.mpi-cbg.de>
X-OriginalArrivalTime: 15 Jan 2009 17:05:26.0134 (UTC) FILETIME=[75DEC160:01C97733]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105857>

--nextPart6848063.5Ob9e72fmg
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Johannes Schindelin wrote:
> There are a number of issues why I would like to avoid introducing=20
> LAST_HEAD:
>=20
> - it does not work when you are using different Git versions on the same=
=20
>   repository,
>=20
> - it does not work when you switched recently,

If you switch once, you'll be able to use the feature one checkout
later than if it was reflog-based.

If you switch a lot, the feature won't be in your git half the time
anyway.

> - you are storing redundant information,

AFAIK it's the first instance of this data in a non-free-form field.
There's also the precedent of ORIG_HEAD.

> - yes, the field is meant for user consumption, but no, it is not=20
>   free-form,

It's a field of almost arbitrary character data, filled by 70% of the
update-ref calls I can find in git.git in a "<tool>: <comment>" format
and by the rest with things such as "initial pull" or
"refs/remotes/git-svn: updating HEAD".  (The latter is so informative
that it probably deserves a fix.)  How is that not free-form?

> - AFAICT your version could never be convinced to resurrect deleted=20
>   branches, without resorting to reflogs anyway.

Neither can any other use of git-checkout without the user manually
recovering some valid revspec referring to the old branch tip from the
reflog.  I wanted to be able to abbreviate the previous branch's name,
and it does just that.

> - the reflog method reflects pretty much exactly how people work around=20
>   the lack of "checkout -" currently, so why not just use the same proven=
=20
>   approach?

So you can make me fight an uphill battle against your idea how it
should be done.


=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch









--nextPart6848063.5Ob9e72fmg
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAklvbOgACgkQqUud07tmzP0TuACfWl59vRwVBEF2MW9ZN7aKBuoj
4oMAnRs9YKxpljNzmx3R8Cj/DGUqIJlP
=F6AQ
-----END PGP SIGNATURE-----

--nextPart6848063.5Ob9e72fmg--
