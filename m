From: Radoslaw Szkodzinski <astralstorm@o2.pl>
Subject: Question about git-ls-files
Date: Fri, 24 Mar 2006 23:49:47 +0100
Message-ID: <200603242349.54578.astralstorm@o2.pl>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1383905.BrvFsiUK6t";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Mar 24 23:53:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FMv9z-0005NE-I8
	for gcvg-git@gmane.org; Fri, 24 Mar 2006 23:53:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964801AbWCXWxc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Mar 2006 17:53:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932196AbWCXWxc
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Mar 2006 17:53:32 -0500
Received: from mx2.go2.pl ([193.17.41.42]:45011 "EHLO poczta.o2.pl")
	by vger.kernel.org with ESMTP id S932194AbWCXWxb (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Mar 2006 17:53:31 -0500
Received: from zen.localdomain (host-81-190-201-167.gorzow.mm.pl [81.190.201.167])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by poczta.o2.pl (Postfix) with ESMTP id EA33A74807C
	for <git@vger.kernel.org>; Fri, 24 Mar 2006 23:53:29 +0100 (CET)
Received: from zen.localdomain ([192.168.0.1])
	by zen.localdomain with esmtpa (Exim 4.60)
	(envelope-from <astralstorm@o2.pl>)
	id 1FMv6i-0007t6-V8
	for git@vger.kernel.org; Fri, 24 Mar 2006 23:50:12 +0100
To: git@vger.kernel.org
User-Agent: KMail/1.9.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17942>

--nextPart1383905.BrvFsiUK6t
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

git-ls-files is a very useful command to list various types of files.

However, it has some weird behaviour.

Let's say someone removed the file and not updated the index yet.
I want to get status for all files in the directory, so I launch git-ls-fil=
es=20
=2Dt -m -d -o, and I get:

R removed-file
C removed-file
? something-else

(it looks even better if I call it w/o -t)

If the file is removed, then marking it as changed is redundant.
A removed file cannot be unchanged.

This behaviour makes for slow parsing, because to get the changed files whi=
ch=20
still exist one has to at least skip items (or uniquify the list). This=20
shouldn't be needed.

Removed files should of course still be listed as changed if there's no -d=
=20
parameter.

=2D-=20
GPG Key id:  0xD1F10BA2
=46ingerprint: 96E2 304A B9C4 949A 10A0  9105 9543 0453 D1F1 0BA2

AstralStorm

--nextPart1383905.BrvFsiUK6t
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.1 (GNU/Linux)

iD8DBQBEJHeSlUMEU9HxC6IRAn8sAJ40INXdvRNJsnvk3Ukghe0pFPq/uQCdH2Yl
jEHrl1z+jNYPimxB7a6eqs0=
=oFeE
-----END PGP SIGNATURE-----

--nextPart1383905.BrvFsiUK6t--
