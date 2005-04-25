From: Valdis.Kletnieks@vt.edu
Subject: Re: [PATCH GIT 0.6] make use of register variables & size_t
Date: Mon, 25 Apr 2005 14:55:16 -0400
Message-ID: <200504251855.j3PItHQs021408@turing-police.cc.vt.edu>
References: <426CD1F1.2010101@tiscali.de> <Pine.LNX.4.58.0504250751330.18901@ppc970.osdl.org> <426D21FE.3040401@tiscali.de> <Pine.LNX.4.58.0504251021280.18901@ppc970.osdl.org>
            <426D33BA.8040604@tiscali.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1114455314_5553P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 25 20:51:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQ8fS-0003XF-Se
	for gcvg-git@gmane.org; Mon, 25 Apr 2005 20:50:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262702AbVDYSzr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Apr 2005 14:55:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262736AbVDYSzr
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Apr 2005 14:55:47 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:7442 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S262702AbVDYSzg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2005 14:55:36 -0400
Received: from turing-police.cc.vt.edu (localhost [127.0.0.1])
	by turing-police.cc.vt.edu (8.13.4/8.13.4) with ESMTP id j3PItHQs021408;
	Mon, 25 Apr 2005 14:55:17 -0400
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Matthias-Christian Ott <matthias.christian@tiscali.de>
In-Reply-To: Your message of "Mon, 25 Apr 2005 20:15:22 +0200."
             <426D33BA.8040604@tiscali.de> 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

--==_Exmh_1114455314_5553P
Content-Type: text/plain; charset=us-ascii

On Mon, 25 Apr 2005 20:15:22 +0200, Matthias-Christian Ott said:

> But this makes, like "register",  direct use of processor registers (it stores int arguments in eax, ebx, etc.).

`-mregparm=NUM'
     Control how many registers are used to pass integer arguments.  By
     default, no registers are used to pass arguments, and at most 3
     registers can be used.  You can control this behavior for a
     specific function by using the function attribute `regparm'.
     *Note Function Attributes::.

     *Warning:* if you use this switch, and NUM is nonzero, then you
     must build all modules with the same value, including any
     libraries.  This includes the system libraries and startup modules.

If it weren't for that *warning*, you could get away with making this another
auto-optimizable value (similar to register allocation inside a function).
Alas, the caller and called functions can be in different .o files, and as
a result, you need to be able to specify the NUM to use to each invocation
of gcc involved, as there's an ABI change involved....

> Stay serious. The book only teaches you ISO-C 99 like many other books. So
> where's your problem?

The problem is the supposition that the implied 3 week's experience in a
language makes anybody qualified to comment on how to use it truly effectively
(for that matter, I've been programming in C since SunOS 3.2, literally 2
decades ago, and I'm still finding little corners I didn't previously know...)


--==_Exmh_1114455314_5553P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCbT0ScC3lWbTT17ARAq1jAKDnfXWazXNEM3mwxMC/x2PEeQWNYwCgjZ7q
uR2E5mN9rIlzwmrfoi5AKQc=
=Xbby
-----END PGP SIGNATURE-----

--==_Exmh_1114455314_5553P--
