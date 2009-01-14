From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH 4/4] color-words: take an optional regular expression describing words
Date: Wed, 14 Jan 2009 20:55:21 +0100
Message-ID: <200901142055.27222.trast@student.ethz.ch>
References: <alpine.DEB.1.00.0901112057300.3586@pacific.mpi-cbg.de> <alpine.DEB.1.00.0901141840100.3586@pacific.mpi-cbg.de> <alpine.DEB.1.00.0901141851350.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2323805.3yY0BKGst1";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Santi =?utf-8?q?B=C3=A9jar?= <santi@agolina.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 14 20:56:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNBqv-0003sB-Ti
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 20:56:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755597AbZANTzO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 14:55:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755285AbZANTzN
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 14:55:13 -0500
Received: from xsmtp0.ethz.ch ([82.130.70.14]:52956 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754751AbZANTzL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 14:55:11 -0500
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 14 Jan 2009 20:55:10 +0100
Received: from pcjremy.inf.ethz.ch ([129.132.153.233]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 14 Jan 2009 20:55:10 +0100
User-Agent: KMail/1.9.9
In-Reply-To: <alpine.DEB.1.00.0901141851350.3586@pacific.mpi-cbg.de>
X-OriginalArrivalTime: 14 Jan 2009 19:55:10.0202 (UTC) FILETIME=[01A275A0:01C97682]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105689>

--nextPart2323805.3yY0BKGst1
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Johannes Schindelin wrote:
> ---color-words::
> +--color-words[=3Dregex]::
>  	Show colored word diff, i.e. color words which have changed.
> ++
> +Optionally, you can pass a regular expression that tells Git what the
> +words are that you are looking for; The default is to interpret any
> +stretch of non-whitespace as a word.

Perhaps you could resurrect the documentation from my series, adjusted
for the different newline rule:


=2D-color-words[=3D<regex>]::
	Show colored word diff, i.e., color words which have changed.
	By default, a new word only starts at whitespace, so that a
	'word' is defined as a maximal sequence of non-whitespace
	characters.  The optional argument <regex> can be used to
	configure this.  It can also be set via a diff driver, see
	linkgit:gitattributes[1]; if a <regex> is given explicitly, it
	overrides any diff driver setting.
+
The <regex> must be an (extended) regular expression.  When set, every
non-overlapping match of the <regex> is considered a word.  Anything
between these matches is considered whitespace and ignored for the
purposes of finding differences.  You may want to append
`|[^[:space:]]` to your regular expression to make sure that it
matches all non-whitespace characters.  A match that contains a
newline is silently truncated at the newline.


=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch


--nextPart2323805.3yY0BKGst1
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkluQy8ACgkQqUud07tmzP1EQQCfWxhq+ZDgmpVYu+13oIav61S1
bd8AnAmGkB38CryM3amE55f/jTiPfvJl
=hj+W
-----END PGP SIGNATURE-----

--nextPart2323805.3yY0BKGst1--
