From: Nico -telmich- Schottelius <nico-git-20080606@schottelius.org>
Subject: How to compare different files in different branches
Date: Fri, 6 Jun 2008 14:24:21 +0200
Message-ID: <20080606122421.GA1521@denkbrett.schottelius.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Dxnq1zWXvFF0Q93v"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 06 14:25:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4b0d-00089r-MD
	for gcvg-git-2@gmane.org; Fri, 06 Jun 2008 14:25:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753409AbYFFMY0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2008 08:24:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753852AbYFFMY0
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 08:24:26 -0400
Received: from mx2.schottelius.org ([62.65.138.77]:54205 "EHLO
	mx2.schottelius.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753299AbYFFMYZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2008 08:24:25 -0400
Received: from denkbrett.schottelius.org (natgw.netstream.ch [62.65.128.28])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.schottelius.org (Postfix) with ESMTPSA id 6180F30D25E
	for <git@vger.kernel.org>; Fri,  6 Jun 2008 14:24:19 +0200 (CEST)
Received: by denkbrett.schottelius.org (Postfix, from userid 1000)
	id C0C25380F4; Fri,  6 Jun 2008 14:24:21 +0200 (CEST)
Content-Disposition: inline
User-Agent: echo $message | gpg -e $sender  -s | netcat mailhost 25
X-Unix-Info: http://unix.schottelius.org/
X-Netzseite: http://nico.schottelius.org/
X-System-Info: denkbrett running Linux 2.6.25.3-denkbrett on x86_64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84054>


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello!

I want to compare 'configure.in' from the master branch with
'configure.ac' from the gpm-2-dev branch.

What I tried:

% git-diff master..gpm-2-dev configure.ac               =20
fatal: ambiguous argument 'configure.ac': unknown revision or path not
in the working tree.
Use '--' to separate paths from revisions

# ok, correct, there is no configure.ac in master
# But not what I want.

% git-diff master..gpm-2-dev configure.in

# shows that the file does not exist in gpm-2-dev. Correct.
# But not what I want.

Strange ist:=20
% git-diff --summary master...gpm-2-dev
and
% git-diff --stat master...gpm-2-dev
do not show the rename.

But using

% git log -Sconfigure gpm-2-dev

I find the rename in commit 5fe49d36d775af47c08bb9a0c0beabef609bba20.

Now I could do=20

% git-checkout master configure.in

in the gpm-2-dev branch and manually compare it with diff.
But - you guessed it - is not what I want.

I really think git can do that, but currently I do not see the right
way. So any idea on how to do that?

Sincerly

Nico

P.S.: Please cc on reply.

--=20
Think about Free and Open Source Software (FOSS).
http://nico.schottelius.org/documentations/foss/the-term-foss/

PGP: BFE4 C736 ABE5 406F 8F42  F7CF B8BE F92A 9885 188C

--Dxnq1zWXvFF0Q93v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFISSx1uL75KpiFGIwRAqZxAKC0jdJG+nx9X7sWwBha3Nalq8CzhgCcDwMc
GI/fSrupX4USpkvN15LGn0E=
=qRAp
-----END PGP SIGNATURE-----

--Dxnq1zWXvFF0Q93v--
