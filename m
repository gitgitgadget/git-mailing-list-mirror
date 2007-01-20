From: Martin Waitz <tali@admingilde.org>
Subject: SEGV in git-apply
Date: Sat, 20 Jan 2007 02:48:52 +0100
Message-ID: <20070120014851.GF5231@admingilde.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+JUInw4efm7IfTNU"
X-From: git-owner@vger.kernel.org Sat Jan 20 02:49:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H85Ln-0008W8-DZ
	for gcvg-git@gmane.org; Sat, 20 Jan 2007 02:48:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965081AbXATBs5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 Jan 2007 20:48:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965098AbXATBs5
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jan 2007 20:48:57 -0500
Received: from mail.admingilde.org ([213.95.32.147]:53242 "EHLO
	mail.admingilde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965081AbXATBs4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jan 2007 20:48:56 -0500
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1H85Li-0001dQ-KH
	for git@vger.kernel.org; Sat, 20 Jan 2007 02:48:54 +0100
To: git@vger.kernel.org
Content-Disposition: inline
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37248>


--+JUInw4efm7IfTNU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

I just hit this bug in git-apply, while executing it in a subdirectory.
At the moment I am using some mixture of next and some own changes
(mostly submodule support, should not affect this bug).

I am afraid that I don't have the time to fix it myself atm, so I am simply
attaching the backtrace here:

Program received signal SIGSEGV, Segmentation fault.
0x080500fa in apply_patch (fd=3D5, filename=3D0xbf821b4d "/tmp/404241.patch=
",
    inaccurate_eof=3D<value optimized out>) at builtin-apply.c:2504
2504                    if (pathlen <=3D prefix_length ||
(gdb) bt
#0  0x080500fa in apply_patch (fd=3D5, filename=3D0xbf821b4d "/tmp/404241.p=
atch",
    inaccurate_eof=3D<value optimized out>) at builtin-apply.c:2504
#1  0x0805147a in cmd_apply (argc=3D3, argv=3D0xbf8201e4, prefix=3D0x80e75c=
6 "src/")
    at builtin-apply.c:2719
#2  0x0804ab55 in handle_internal_command (argc=3D3, argv=3D0xbf8201e4,
    envp=3D<value optimized out>) at git.c:304
#3  0x0804b1f8 in main (argc=3D3, argv=3DCannot access memory at address 0x8
) at git.c:341


--=20
Martin Waitz

--+JUInw4efm7IfTNU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFsXUDj/Eaxd/oD7IRAhLvAJ0fXLbWBmFi2KyjWszI7C4QSsI3ZwCfWv8R
A9hfAQm+clZ+I6vJENUgjS0=
=v5fU
-----END PGP SIGNATURE-----

--+JUInw4efm7IfTNU--
