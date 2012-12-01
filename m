From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [RFC] remove/deprecate 'submodule init' and 'sync'
Date: Sat, 01 Dec 2012 11:37:14 -0500
Message-ID: <20121201163714.GC4823@odin.tremily.us>
References: <20121130032719.GE29257@odin.tremily.us> <50B54A68.60309@web.de>
 <20121130175309.GA718@odin.tremily.us>
 <CABURp0qNBcFnxbvhn7PsKWLUOsTiK4u5vx-=6cG3JQHw9aUeHA@mail.gmail.com>
 <50BA2892.7060706@web.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary=xo44VMWPx7vlQ2+2
Cc: Phil Hord <phil.hord@gmail.com>, Git <git@vger.kernel.org>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Shawn Pearce <spearce@spearce.org>,
	Nahor <nahor.j+gmane@gmail.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Sat Dec 01 17:37:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Teq4U-0001Yt-2V
	for gcvg-git-2@plane.gmane.org; Sat, 01 Dec 2012 17:37:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752699Ab2LAQhZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Dec 2012 11:37:25 -0500
Received: from vms173007pub.verizon.net ([206.46.173.7]:32650 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752489Ab2LAQhY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Dec 2012 11:37:24 -0500
Received: from odin.tremily.us ([unknown] [72.68.99.23])
 by vms173007.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MED007NB2633R80@vms173007.mailsrvcs.net> for
 git@vger.kernel.org; Sat, 01 Dec 2012 10:37:17 -0600 (CST)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 07D966E3C70; Sat,
 01 Dec 2012 11:37:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1354379835; bh=OVuOfpBy1gmsKzB0H5xObax1M1WW1jPpTfGBywrV2vs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nvSavxyRCQD9LsFcFAKMyKi8zHBl8ouOKJuO4CTpBP5t91gON2VfW/M7FhThCuwOO
 p76B2N/qBfQmS/GCzH5vtut83XCSgZOzBnFw2/Wx/iY4c43RHas0Oqp4iN5wfwjHpR
 IQAs0fpNAGISi6vnAMCCKUNZpHmk0O5fXHLRO9QU=
Content-disposition: inline
In-reply-to: <50BA2892.7060706@web.de>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210978>


--xo44VMWPx7vlQ2+2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 01, 2012 at 04:56:02PM +0100, Jens Lehmann wrote:
> Am 01.12.2012 00:52, schrieb Phil Hord:
> > If I never 'submodule init' a submodule, it does not get visited by
> > 'git submodule foreach', among others.  I think some people use this
> > behavior explicitly.
> >=20
> > On the other hand, I've also notice that a submodule which I have
> > removed does not get de-inited later one.  It causes my 'git submodule
> > foreach' to emit errors.  :-(
>=20
> I'm currently hacking on "git submodule deinit" which removes the 'url'
> setting from git/config. This should do the trick for you, right?
>=20
> Just removing that submodule automagically would not work that well, as
> it would deinitialize a submodule when you switch to a branch where it
> isn't present and you'd have to reinitialize it when you come back.

I think this is another case where we should be looping through
submodules based on the revision-specific .gitmodules content, and
querying the local config only to determine if the user wants to
update them (to drop into them with foreach, etc.).

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--xo44VMWPx7vlQ2+2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQujI6AAoJEEUbTsx0l5OMGXMQAL1vsIAgDstkwzXVxa4tWMd0
rE/9x+xL14Xoc8jE1thmmYPAKwGBq9xIPQTBGWDMO+VOuJo1BJ4YmGgjGAjuOo1c
wjir1r1GQxE6wRaZATdVR6x5FV974RiBuAVD2sM/doUX6VUky2MntTGKg6s6fh4/
KIIiUW0didutUWRPcmZIPIvmpgmtSaLQfM5u2BxmuR39iI5K4/n6aRsk8+PgP1rG
hZoxbtplUkR8Ag8g+mcLSyVKb5OXr6fgioHI7nvPhj4GeP4gEFPjvfZLLRw6+nVf
KnDld9/nWsGVBuhD4io43TTkyu/5skInuHmeLU5jksJK1/WMFTOyT0OJgYUreCaH
x5J1268gBgcuTe7KDA1nTSAIhJY9ylcdw6/MxT5TkSr/VF2fSXXwIexGjtfl9Zqq
YMvFdZHKC/02OtxpYdhkShylFrFJtO7v7yGvK9anPu/De+c5u2X8ZyAVU/M1/9Pg
7N7Nec4R9Bn2GlGCUqj2vbHI1i+ecOh0hxFlEkISod1u2xR3Yjge1tgwsWo7MDdw
8XADgkxKo6YPKVYDNQ2/I+F/nWEj+SweW4SfZmD2ztrFz6kVOQNoKNcdYVVFV74M
C7erKqRLOYGy0Lbz3dzeETJlDGk6uiKXhkAj3b3xDO/8tVYJltLPIKorRZMOQosw
iK2yNYKONWwa4jHg1+x9
=ryUI
-----END PGP SIGNATURE-----

--xo44VMWPx7vlQ2+2--
