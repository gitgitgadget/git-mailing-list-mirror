From: Greg Troxel <gdt@ir.bbn.com>
Subject: Re: What's cooking in git.git (Apr 2014, #09; Tue, 29)
Date: Wed, 07 May 2014 19:38:41 -0400
Message-ID: <rmizjit6txa.fsf@fnord.ir.bbn.com>
References: <xmqq7g67iwxc.fsf@gitster.dls.corp.google.com>
	<20140505184546.GB23935@serenity.lan>
	<xmqqoazb944d.fsf@gitster.dls.corp.google.com>
	<rmiha51dd99.fsf@fnord.ir.bbn.com>
	<536a8f6cd81e9_76ff7a52ec60@nysa.notmuch>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 08 01:38:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WiBQE-0000C1-UD
	for gcvg-git-2@plane.gmane.org; Thu, 08 May 2014 01:38:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752201AbaEGXin (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2014 19:38:43 -0400
Received: from fnord.ir.bbn.com ([192.1.100.210]:55326 "EHLO fnord.ir.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751377AbaEGXim (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2014 19:38:42 -0400
Received: by fnord.ir.bbn.com (Postfix, from userid 10853)
	id 3F540A8D0; Wed,  7 May 2014 19:38:41 -0400 (EDT)
OpenPGP: id=32611E25
X-Hashcash: 1:20:140507:felipe.contreras@gmail.com::sGxaXvFCRoZzhDKB:000000000000000000000000000000000000bSv
X-Hashcash: 1:20:140507:john@keeping.me.uk::Ks+Xf8rOOU5zm8OS:00000000000000000000000000000000000000000001Eyk
X-Hashcash: 1:20:140507:gitster@pobox.com::3KbxLrvNafUDD9oe:000000000000000000000000000000000000000000006s0+
X-Hashcash: 1:20:140507:git@vger.kernel.org::cUDOC+T3ao1CEYNJ:0000000000000000000000000000000000000000008ucB
In-Reply-To: <536a8f6cd81e9_76ff7a52ec60@nysa.notmuch> (Felipe Contreras's
	message of "Wed, 07 May 2014 14:54:20 -0500")
User-Agent: Gnus/5.130006 (Ma Gnus v0.6) Emacs/23.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248388>

--=-=-=
Content-Type: text/plain


Felipe Contreras <felipe.contreras@gmail.com> writes:

> Greg Troxel wrote:
>> In a packaging system, dependencies are much more troublesome.
>> Dependencies have to be declared, and the build limited to use only
>> those declared dependencies, in order to get repeatable builds and
>> binary packages that can be used on other systems.  Dependencies that
>> really are required are fine.  But optional dependencies are a
>> problem, because e.g. one doesn't want to require the presence of qt
>> to build something (that isn't already enormous).   So if git needs
>> mercurial and subversion installed, plus perhaps 5 other things for
>> less popular remote helpers, that starts to be a real burden.
>
> It doesn't *need* them to build. The Mercurial/Bazaar dependencies are
> optional, both at build-time and at run-time. Most distributions would
> want to test the functionality they are distributing, and for testing
> they do need these dependencies.

My point is that a packaging of git needs to either decide to forego
these optional parts, or to include them, in the default case.  One
choice means that anyone who builds the package from source has to have
the dependencies, and the other means that users of the built package(s)
can't use the features.  I realize that in Linux it's perhaps typical to
not worry about burdening builders because actually building is very
rare, but that's only reasonable because of having only one OS and
perhaps three CPUs; with dozens each, building from source becomes more
frequent.  So I'm merely trying to suggest that it's better to have a
core package with a restrained set of dependencies, and then a way to
build the other things independently (perhaps assuming the core is
built/installed), each with their own dependencies.

It turns out in pkgsrc that git-svn is a meta-package (with no files)
that depends on git-base (no man pages, no gitk) and p5-subversion.
hg-git appears to be a separate source distribution, depending on a
python implementation of the git formats.  So perhaps the situation is
currently ok.  I was just trying to point out the issue to avoid
regressions in the packaging situation.



--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlNqxAEACgkQ+vesoDJhHiWpFgCeNSRouxxiR8VKuqu9OE39iAvt
8G0AnigExHw2geoanWl/kQtrrpi+50VZ
=fkRj
-----END PGP SIGNATURE-----
--=-=-=--
