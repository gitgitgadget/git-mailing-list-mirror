From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: git merge and cherry-pick and duplicated commits?
Date: Wed, 14 Jan 2009 09:41:14 +0100
Message-ID: <200901140941.17110.trast@student.ethz.ch>
References: <2729632a0901131840v5c7ce0c7l3f87c03caabf68de@mail.gmail.com> <5EA96780-EF4C-4B31-9C60-6ABAF21663FA@silverinsanity.com> <2729632a0901132221r746144a1y9628615be1c6ad04@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart8003221.df5EyIThe1";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: skillzero@gmail.com
X-From: git-owner@vger.kernel.org Wed Jan 14 09:42:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LN1KX-0000Q4-3p
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 09:42:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754119AbZANIlH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 03:41:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752805AbZANIlE
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 03:41:04 -0500
Received: from xsmtp0.ethz.ch ([82.130.70.14]:14818 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752793AbZANIlD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 03:41:03 -0500
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 14 Jan 2009 09:41:00 +0100
Received: from pcjremy.inf.ethz.ch ([129.132.153.233]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 14 Jan 2009 09:41:00 +0100
User-Agent: KMail/1.9.9
In-Reply-To: <2729632a0901132221r746144a1y9628615be1c6ad04@mail.gmail.com>
X-OriginalArrivalTime: 14 Jan 2009 08:41:00.0293 (UTC) FILETIME=[D39C2B50:01C97623]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105605>

--nextPart8003221.df5EyIThe1
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

skillzero@gmail.com wrote:
> I thought git would realize that master already had those 2 commits
> and not add them again when merging?

[later]
> That's what I was somewhat disappointed by. Even though the result of
> the commit had a different hash, I assumed git would keep some kind of
> internal per-commit hash so it could tell later that two commits were
> the same and not re-apply them.

I think there's an important misunderstanding here: merging A into B
does *not* have anything to do with commits, or history for that
matter, beyond the differences from $(git merge-base A B) to A and
B.[*]

Along the same lines, nothing is ever re-applied during merging.
git-merge just figures out that you made the same change on both
sides, so it must have been a good change, so it must go into the end
result.  *How* you arrived at the same change---say, by
cherry-picking, or by getting the same result in that region from
otherwise different commits, or even from several commits---does *not*
matter in any way.

You can use 'git cherry', 'git log --left-right --cherry-pick', and
similar tools to find commits that are cherry-picked "duplicates", but
unless you rewrite history, they are there to stay.


[*] This is a simplification since as soon as the merge-base is not
unique, merge-recursive will actually start looking into history
further back.

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch



--nextPart8003221.df5EyIThe1
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkltpS0ACgkQqUud07tmzP2fpwCdGIckdzq28dblLSg6tCwWV1Xl
2wkAn1pMDxEK72otasBHP8qCvMrAZabn
=tKm5
-----END PGP SIGNATURE-----

--nextPart8003221.df5EyIThe1--
