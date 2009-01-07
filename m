From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [RFC PATCH] diff --no-index: test for pager after option parsing
Date: Wed, 7 Jan 2009 01:09:03 +0100
Message-ID: <200901070109.25579.trast@student.ethz.ch>
References: <1231286163-9422-1-git-send-email-trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3625224.NdUhL204AA";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junio@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 07 01:10:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKM0H-0000XN-Lf
	for gcvg-git-2@gmane.org; Wed, 07 Jan 2009 01:10:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754689AbZAGAJO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2009 19:09:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751438AbZAGAJN
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jan 2009 19:09:13 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:4241 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754298AbZAGAJL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2009 19:09:11 -0500
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 7 Jan 2009 01:09:10 +0100
Received: from [192.168.0.3] ([84.75.148.62]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 7 Jan 2009 01:09:09 +0100
User-Agent: KMail/1.9.9
In-Reply-To: <1231286163-9422-1-git-send-email-trast@student.ethz.ch>
X-OriginalArrivalTime: 07 Jan 2009 00:09:10.0038 (UTC) FILETIME=[29FAE360:01C9705C]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104740>

--nextPart3625224.NdUhL204AA
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Speaking of diff --no-index code, there's also this bit:

	/* diff-no-index.c:206 */
	for (i =3D 1; i < argc - 2; ) {
		int j;
		if (!strcmp(argv[i], "--no-index"))
			i++;
		else if (!strcmp(argv[1], "-q"))
			options |=3D DIFF_SILENT_ON_REMOVED;

Note the argv[i] vs. argv[1].  The entire block is from 0569e9b ("git
diff": do not ignore index without --no-index, 2008-05-23).

While it seems obvious that this should be argv[i], I'm rather
confused by the option itself.  It is not documented in my version of
git-diff(1).  Furthermore, I can't see what being silent about removed
paths (which relates to the index?) has to do with a diff --no-index
(which takes two paths that must exist).

Or perhaps I should take the "no mails/patches after midnight" rule a
tad bit more serious...

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch



--nextPart3625224.NdUhL204AA
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEUEABECAAYFAklj8rUACgkQqUud07tmzP1f3ACY40DVwObDKOmXQMTQ2j5Zic3x
uwCdGIVAj94oEgKKMGOAPhTMEekX/zo=
=duJk
-----END PGP SIGNATURE-----

--nextPart3625224.NdUhL204AA--
