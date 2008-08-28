From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH 0/6] 'git svn info' fixes
Date: Thu, 28 Aug 2008 10:30:58 +0200
Message-ID: <200808281031.04975.trast@student.ethz.ch>
References: <1219779157-31602-1-git-send-email-trast@student.ethz.ch> <20080827095342.GB26475@untitled>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart8543558.W4A2qfG9rO";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Aug 28 10:32:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYcvI-0005Sp-LG
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 10:32:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752606AbYH1IbE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 04:31:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752585AbYH1IbE
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 04:31:04 -0400
Received: from xsmtp0.ethz.ch ([82.130.70.14]:28419 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752436AbYH1IbB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 04:31:01 -0400
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 28 Aug 2008 10:31:00 +0200
Received: from [192.168.0.8] ([77.56.223.244]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 28 Aug 2008 10:31:00 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <20080827095342.GB26475@untitled>
X-OriginalArrivalTime: 28 Aug 2008 08:31:00.0232 (UTC) FILETIME=[6686E080:01C908E8]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--nextPart8543558.W4A2qfG9rO
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Eric Wong wrote:
> Thomas Rast <trast@student.ethz.ch> wrote:
> > However, the unknown files tests still fail, simply because 'svn info'
> > itself fails on untracked files.  It would be great if someone who is
> > still running SVN 1.4 could check whether that has been a bug in
> > git-svn all along, or is actually a behaviour change on the part of
> > SVN.
>=20
> Oops, I upgraded to 1.5.x here already.  I should still have
> another machine with 1.4 to check on tomorrow, though.

I got a friend with 1.4 to test this, and it appears the error

  $ touch new
  $ svn info new
  new:  (Keine versionierte Ressource)

(literally "not a versioned resource") is already present in

  $ svn --version
  svn, Version 1.4.6 (r28521)

(He also says the error is the same if the file does not exist at
all.)

So should we just change all "unknown foo" tests to verify that 'git
svn info' errors out too?

=2D Thomas

=2D-=20
Thomas Rast
trast@student.ethz.ch


--nextPart8543558.W4A2qfG9rO
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAki2YkgACgkQqUud07tmzP1CJQCfargARljTYQo9S5Ympt7lWFTY
XP0AnjBefPEX1RgJPaFUXa96dhP0Yea+
=uDWZ
-----END PGP SIGNATURE-----

--nextPart8543558.W4A2qfG9rO--
