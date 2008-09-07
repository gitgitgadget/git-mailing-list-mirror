From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [RFC] cherry-pick using multiple parents to implement -x
Date: Sun, 7 Sep 2008 23:16:54 +0200
Message-ID: <200809072316.58516.trast@student.ethz.ch>
References: <20080907103415.GA3139@cuci.nl> <7vtzcrn9uv.fsf@gitster.siamese.dyndns.org> <20080907201038.GB8765@cuci.nl>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3391066.G4vQLN2E4c";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Sun Sep 07 23:18:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcRe6-0006B4-LS
	for gcvg-git-2@gmane.org; Sun, 07 Sep 2008 23:18:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751674AbYIGVRE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Sep 2008 17:17:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751504AbYIGVRD
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Sep 2008 17:17:03 -0400
Received: from xsmtp1.ethz.ch ([82.130.70.13]:58568 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750962AbYIGVRB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Sep 2008 17:17:01 -0400
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 7 Sep 2008 23:17:00 +0200
Received: from [192.168.0.5] ([84.75.158.234]) by xfe1.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 7 Sep 2008 23:16:59 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <20080907201038.GB8765@cuci.nl>
X-OriginalArrivalTime: 07 Sep 2008 21:16:59.0364 (UTC) FILETIME=[106F6240:01C9112F]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95177>

--nextPart3391066.G4vQLN2E4c
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Stephen R. van den Berg wrote:
> Junio C Hamano wrote:
> >             o---...o---B---A
> >            /                \ (wrong)
> >        ---o---o---...o---X---A'
[...]
> >To put it another way, having the parent link from A' to A is a statement
> >that A' is a superset of A.  Because A contains B, you are claiming A'
> >also contains B, which is not the case in your cherry-picked history.
>=20
> Which existing git command actually misbehaves because it makes the
> above assumption?

Most importantly: merge.

If you later merge the top branch into the bottom one, the merge-base
is now A.  So any such merge, that under normal circumstances would
have integrated B (which as Junio said could be a very important fix!)
would not do so in your version.

But other things fail too: take the '..' and '...' way of specifying
revisions (because they consider B as "on the bottom branch" with that
extra parent relationship).

=2D Thomas

=2D-=20
Thomas Rast
trast@student.ethz.ch



--nextPart3391066.G4vQLN2E4c
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkjERMoACgkQqUud07tmzP1PnQCeKOa7GRRhq0P27crrt3P4rMjo
2TkAn3bGfU4+rfOzgCRqUhh3aTZgN5D4
=AS3J
-----END PGP SIGNATURE-----

--nextPart3391066.G4vQLN2E4c--
