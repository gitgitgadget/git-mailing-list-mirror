From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [RFC PATCH] make diff --color-words customizable
Date: Fri, 9 Jan 2009 01:50:50 +0100
Message-ID: <200901090151.10880.trast@student.ethz.ch>
References: <1231459505-14395-1-git-send-email-trast@student.ethz.ch> <alpine.DEB.1.00.0901090121432.30769@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart7512548.DZpfyDEy7T";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jan 09 01:52:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LL5bn-0006gI-5S
	for gcvg-git-2@gmane.org; Fri, 09 Jan 2009 01:52:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756147AbZAIAu4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jan 2009 19:50:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756088AbZAIAuz
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jan 2009 19:50:55 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:16047 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755597AbZAIAuz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jan 2009 19:50:55 -0500
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 9 Jan 2009 01:50:54 +0100
Received: from [192.168.0.3] ([84.75.148.62]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 9 Jan 2009 01:50:53 +0100
User-Agent: KMail/1.9.9
In-Reply-To: <alpine.DEB.1.00.0901090121432.30769@pacific.mpi-cbg.de>
X-OriginalArrivalTime: 09 Jan 2009 00:50:53.0550 (UTC) FILETIME=[530400E0:01C971F4]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104978>

--nextPart7512548.DZpfyDEy7T
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Johannes Schindelin wrote:
> On Fri, 9 Jan 2009, Thomas Rast wrote:
>=20
> > Allows for user-configurable word splits when using --color-words. This=
=20
> > can make the diff more readable if the regex is configured according to=
=20
> > the language of the file.
> >=20
> > For now the (POSIX extended) regex must be set via the environment
> > GIT_DIFF_WORDS_REGEX.  Each (non-overlapping) match of the regex is
> > considered a word.  Anything characters not matched are considered
> > whitespace.  For example, for C try
> >=20
> >   GIT_DIFF_WORDS_REGEX=3D'[0-9]+|[a-zA-Z_][a-zA-Z0-9_]*|(\+|-|&|\|){1,2=
}|\S'
[...]
> Interesting idea.  However, I think it would be better to do the opposite=
,=20
> have _word_ patterns.  And even better to have _one_ pattern.

I'm not sure I understand.  It _is_ a single pattern.  The examples
just have several cases to distinguish various semantic groups that
can occur, as a sort of "half tokenizer".  (The C example isn't very
complete however.)

> BTW I think you could do what you intended to do with a _way_ smaller=20
> and more intuitive patch.

How?

I don't think the existing mechanism, which just replaces all
whitespace with newlines and does a line diff to find out which words
changed, can "just" be adapted.  We will have to insert extra newlines
at points where the regex said to split a word, but where there was no
whitespace in the original content.  If there's a significantly easier
way to do that than I hacked up, please share.

Or maybe I got your original code all wrong?

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch


--nextPart7512548.DZpfyDEy7T
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAklmn34ACgkQqUud07tmzP0OawCeMrFu76V/OcztzAeaOt97EeTa
EeQAnjcf5AklLC/fyHEkNoXi4TRgVE76
=KyoE
-----END PGP SIGNATURE-----

--nextPart7512548.DZpfyDEy7T--
