From: martin f krafft <madduck@madduck.net>
Subject: Re: [PATCH] gitk: don't save the geometry to rc file on exit
Date: Fri, 7 Mar 2008 12:11:44 +0100
Message-ID: <20080307111144.GA18108@piper.oerlikon.madduck.net>
References: <47AAA254.2020008@thorn.ws> <20080207063020.GP24004@spearce.org> <200802071056.19370.robin.rosenberg.lists@dewire.com> <20080207101051.19459.qmail@fcb20609bc7c07.315fe32.mid.smarden.org> <20080223113759.12854.qmail@6a8737aa4695b2.315fe32.mid.smarden.org> <18368.41742.689290.877767@cargo.ozlabs.ibm.com> <47C190E3.6000407@gmail.com> <18383.57540.26282.526111@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="opJtzjQTFsWo+cga"
Cc: Mark Levedahl <mlevedahl@gmail.com>,
	Gerrit Pape <pape@smarden.org>, git@vger.kernel.org,
	442253-quiet@bugs.debian.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Fri Mar 07 12:13:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXaVm-0001JL-B3
	for gcvg-git-2@gmane.org; Fri, 07 Mar 2008 12:13:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757352AbYCGLMg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Mar 2008 06:12:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757148AbYCGLMg
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Mar 2008 06:12:36 -0500
Received: from seamus.madduck.net ([213.203.238.82]:57741 "EHLO
	seamus.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757104AbYCGLMf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Mar 2008 06:12:35 -0500
Received: from wall.oerlikon.madduck.net (84-75-158-163.dclient.hispeed.ch [84.75.158.163])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wall.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by seamus.madduck.net (postfix) with ESMTP id 60174406147;
	Fri,  7 Mar 2008 12:12:39 +0100 (CET)
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [192.168.14.3])
	by wall.oerlikon.madduck.net (Postfix) with ESMTP id A1A1D9F18E;
	Fri,  7 Mar 2008 12:11:44 +0100 (CET)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id 668944424; Fri,  7 Mar 2008 12:11:44 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <18383.57540.26282.526111@cargo.ozlabs.ibm.com>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.24-1-amd64 x86_64
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Virus-Scanned: ClamAV 0.92.1/6158/Fri Mar  7 07:54:13 2008 on seamus.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76475>


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Paul Mackerras <paulus@samba.org> [2008.03.06.1317 +0100]:
> Here's a patch for people to test.  It only restores the width and
> height, and limits the width and height to be at most the width and
> height of the screen.  It seems to work fine under X; I would be
> interested to know what happens under macos and windows.

I can confirm that the behaviour is much better: the window size is
restored, as is the position, but it gives preference to the
Xinerama head. You'd think it restores at the same *relative*
position on the current head, but it actually just restores
somewhere =E2=80=94 I cannot figure out the behaviour.

However, I still wonder why we have to do this at all. I understand
that Cygwin has issues and needs this code, but couldn't it then be
made to run only on Cygwin, such that on "proper" Unix systems, the
config file is *not* updated every time I move the window before
closing the application? As I said earlier, this is really the job
of a window manager, *not* a configuration option. If your window
manager cannot restore the window to a size you control, then it's
broken. Let's not hack applications to work around that, please.

--=20
martin | http://madduck.net/ | http://two.sentenc.es/
=20
$complex->{'data'}[$structures][$in_perl] =3D @{$can{'be'}->[$painful]};
=20
spamtraps: madduck.bogus@madduck.net

--opJtzjQTFsWo+cga
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFH0SLwIgvIgzMMSnURAp6fAKCbbXxuNuzJIj1ieJpi0HTcRCrxzgCgntOv
wUBPkeLCHbgYbRW1O50c7SU=
=XHRA
-----END PGP SIGNATURE-----

--opJtzjQTFsWo+cga--
