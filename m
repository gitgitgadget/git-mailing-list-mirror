From: Greg Troxel <gdt@ir.bbn.com>
Subject: Re: Multiple clients accessing git over NFS
Date: Sun, 14 Nov 2010 18:46:40 -0500
Message-ID: <rmipqu7lb8f.fsf@fnord.ir.bbn.com>
References: <AANLkTimyFkVFAw4s2fiWKZFPvnx15K6U6GbxmRgznx7Z@mail.gmail.com>
	<rmi39r3mrf6.fsf@fnord.ir.bbn.com>
	<AANLkTinX-XR2TaZPGPeWyekMq3e8wEDkfcmi_o6pTvMK@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Cc: git@vger.kernel.org
To: Khawaja Shams <kshams@usc.edu>
X-From: git-owner@vger.kernel.org Mon Nov 15 00:46:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PHmHW-0000yF-Vz
	for gcvg-git-2@lo.gmane.org; Mon, 15 Nov 2010 00:46:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752838Ab0KNXqm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Nov 2010 18:46:42 -0500
Received: from fnord.ir.bbn.com ([192.1.100.210]:50227 "EHLO fnord.ir.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751434Ab0KNXql (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Nov 2010 18:46:41 -0500
Received: by fnord.ir.bbn.com (Postfix, from userid 10853)
	id C0D6653EF; Sun, 14 Nov 2010 18:46:40 -0500 (EST)
X-Hashcash: 1:20:101114:git@vger.kernel.org::tLqOppodXlL65gEQ:0000000000000000000000000000000000000000000+Rn
X-Hashcash: 1:20:101114:kshams@usc.edu::tLqOppodXlL65gEQ:0002KF+
In-Reply-To: <AANLkTinX-XR2TaZPGPeWyekMq3e8wEDkfcmi_o6pTvMK@mail.gmail.com>
	(Khawaja Shams's message of "Sun, 14 Nov 2010 15:40:33 -0800")
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/23.2 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161461>

--=-=-=
Content-Type: text/plain


If only one computer is accessing the repository, then failure to lock
may be ok.  But you'll still need atomic rename etc. to work.

I may be overly conservative, but I would not (and do not) allow anyone
to access a repository (cvs, svn, git, whatever) over NFS, ever.

My expectation is that multiple git processes on one machine with a repo
on local disk works fine.  If not it's a bug.  When you add a remote FS
you have to wonder if the unix filesystem sematics are preserved.

Another approach would be cloned repositories that constantly pull from
the main one or each other, and have people use those.  That will get
you delayed merge conflicts, but they might be useful as RO replicas.



--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (NetBSD)

iEYEARECAAYFAkzgdOAACgkQ+vesoDJhHiVGPACgkUUuRpWjdWZVA5rp2h7AwNTE
qcwAoKhl5HVD3r+xMRrPTgGoohJ+T/2e
=CY+9
-----END PGP SIGNATURE-----
--=-=-=--
