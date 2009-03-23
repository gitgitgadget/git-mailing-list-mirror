From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [bug?] git-format-patch produces a 0-byte long patch for the first commit
Date: Mon, 23 Mar 2009 17:29:03 +0100
Message-ID: <200903231729.08216.trast@student.ethz.ch>
References: <Pine.LNX.4.64.0903231119110.4871@axis700.grange>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1436443.KImnlqYZTn";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
X-From: git-owner@vger.kernel.org Mon Mar 23 17:31:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lln3W-0000ke-Hm
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 17:31:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757031AbZCWQ3p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2009 12:29:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754633AbZCWQ3o
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 12:29:44 -0400
Received: from xsmtp1.ethz.ch ([82.130.70.13]:17040 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755907AbZCWQ3o (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2009 12:29:44 -0400
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 23 Mar 2009 17:29:41 +0100
Received: from thomas.localnet ([129.132.153.233]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 23 Mar 2009 17:29:41 +0100
User-Agent: KMail/1.11.1 (Linux/2.6.27.19-3.2-default; KDE/4.2.1; x86_64; ; )
In-Reply-To: <Pine.LNX.4.64.0903231119110.4871@axis700.grange>
X-OriginalArrivalTime: 23 Mar 2009 16:29:41.0409 (UTC) FILETIME=[9130F110:01C9ABD4]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114330>

--nextPart1436443.KImnlqYZTn
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Guennadi Liakhovetski wrote:
> mkdir x
> cd x
> git-init
> echo hi > greating
> git-commit -a
[...]
> git-format-patch HEAD^ produces an error,=20

There is no HEAD^ in this case.  HEAD is always the currently checked
out commit.  Since it has a root commit, it has no parent, so you
cannot apply ^ ("the first parent of") to it.  Similarly, HEAD~2 will
not work if HEAD~1 has no parent, etc.

> git-format-patch -1 produces a 0-byte long patch.

That is admittedly weird and probably deserves a fix and/or suggestion
to use --root.

I'm not sure what else I can add to the explanations I gave on IRC.

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch

--nextPart1436443.KImnlqYZTn
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAknHuNQACgkQqUud07tmzP29AACZAdUHUuZmwVsv9C20PWHFhDYQ
nq4AnjoSSPQqnzaNu7BZIX/q9rVQXS3+
=6HdM
-----END PGP SIGNATURE-----

--nextPart1436443.KImnlqYZTn--
