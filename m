From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [RFC/PATCH 2/4] Submodules: Add the
 lib-submodule-update.sh test library
Date: Thu, 17 Apr 2014 09:41:38 -0700
Message-ID: <20140417164138.GP21805@odin.tremily.us>
References: <5331B6F6.60501@web.de>
 <5331B741.6000606@web.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8jcWiON1L7A8HfS7"
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder p <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Heiko Voigt <hvoigt@hvoigt.net>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu Apr 17 18:41:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WapNl-0004FY-Vu
	for gcvg-git-2@plane.gmane.org; Thu, 17 Apr 2014 18:41:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752460AbaDQQlp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Apr 2014 12:41:45 -0400
Received: from qmta06.westchester.pa.mail.comcast.net ([76.96.62.56]:33056
	"EHLO qmta06.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751001AbaDQQlm (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Apr 2014 12:41:42 -0400
Received: from omta08.westchester.pa.mail.comcast.net ([76.96.62.12])
	by qmta06.westchester.pa.mail.comcast.net with comcast
	id r0Er1n0070Fqzac564hhlT; Thu, 17 Apr 2014 16:41:41 +0000
Received: from odin.tremily.us ([24.18.63.50])
	by omta08.westchester.pa.mail.comcast.net with comcast
	id r4hf1n00l152l3L3U4hgKP; Thu, 17 Apr 2014 16:41:41 +0000
Received: by odin.tremily.us (Postfix, from userid 1000)
	id 26CB61150FA0; Thu, 17 Apr 2014 09:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1397752899; bh=Swmbfo9OVuPc2pbEtNI4Uw3iMEtqeVOPnbNGgwavg1A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=R+1k4xPrc90/cLecbap+Tg6h1lTsxg90akdGE9EsaWf/Oflp5ynYkkWz4kgsuS/9M
	 Okb2kXd6sAJNrCwuiYT/qblDoLVZR8GJZ4P+WIhbPH/ZI/xqgStMgkkzBe1hCzrNcE
	 HADXTHblAvGo5NxQ/2P91HLz7nkHUC3mY7bbsK2w=
Content-Disposition: inline
In-Reply-To: <5331B741.6000606@web.de>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.22 (2013-10-16)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20140121; t=1397752901;
	bh=xCfgGIw7uhaMbBA7WSlgDWgla+yZW8tndeljjp3R8Ng=;
	h=Received:Received:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type;
	b=DiE7hyef6D2NwDYZ5YJqPXgDLZUaB7M6QtTIX3Pnauc7zDHPzo8nlZEZWTlzhoLOk
	 wwpGuGCY4+pYpivSjbFBnMQodr+jpF7KFr7RHqnJ6QSZYFMufA4HlZoBFT2TjpgU2H
	 Ibdarh1HnY/XVbYzGPd4gSuFPDzMmTi7Fij7YlCjIDkrzjyy5m1+pIi3N7ui81F65U
	 Y1faCZJNv91ppe467YEzxmE1WBNHr0OP2EhZOE+f6gD3J9h5b91s/Phz3Jdg59TVVR
	 B9g04iMdk5UkWsxCAW/6KCIKi67ZvYrLbioOZRzbh3ERPXvqs4rt9Epr3MgXUlhYgB
	 4+PfxHSvJFvBw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246421>


--8jcWiON1L7A8HfS7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25, 2014 at 06:05:05PM +0100, Jens Lehmann wrote:
> *) When a submodule is replaced with a tracked file of the same name
>    the submodule work tree including any local modifications (and
>    even the whole history if it uses a .git directory instead of a
>    gitfile!) is simply removed.
> =E2=80=A6
> I think the first bug really needs to be fixed, as that behavior is
> extremely nasty. We should always protect work tree modifications
> (unless forced) and *never* remove a .git directory (even when
> forced).

I think this should be covered by the usual =E2=80=9Cdon't allow checkouts
=66rom dirty workdirs unless the dirty-ing changes are easily applied to
the target tree=E2=80=9D.

Are we waiting to land this series (or a successor) before starting on
a fix for this issue?  There have been a number of submodule series in
flight recently, and I'm having trouble keeping track of them all ;).

> *) Forced work tree updates happily manipulate files in the
>    directory of a submodule that has just been removed in the
>    superproject (but is of course still present in the work tree due
>    to the way submodules are currently handled). This becomes
>    dangerous when files in the submodule directory are overwritten
>    by files from the new superproject commit, as any modifications
>    to the submodule files will be lost) and is expected to also
>    destroy history in the - admittedly unlikely case - the new
>    commit adds a file named ".git" to the submodule directory.
> =E2=80=A6
> I'm not so sure about the second one. Even though I believe the
> current behavior is not correct (switching commits should never mess
> around in a submodule directory)

This should also be covered by the usual =E2=80=9Cdon't allow checkouts from
dirty workdirs unless the dirty-ing changes are easily applied to the
target tree=E2=80=9D.  We don't implement this yet, but I'd like to force
users to move any about-to-be-clobbered state from their submodule
into .git/modules/<name>/ (via commits or stashes) before allowing
them to begin the checkout.  Once we've ensured that the state is
preserved out-of-tree, then clobber away ;).

Cheers,
Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--8jcWiON1L7A8HfS7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTUAQ/AAoJEKKfehoaNkbtCA8P/03YkFHbWdXAQyzawlV4f5X+
U5mkTvSwXSBxH1/t3LsUTmlVsPY/Ly8EdVNztOlpmrEieD4BrFGWeXShr4vL9GRV
Z+mlJAiMT59MtBcNtQo+6o4TEjeFi8QofuYhND2q4yWkEoTxEj8ChXDIemUZ+hbS
EIk6L983rltKpbI/yS4NUcKVqMqiFr+VwadfLwQ9YGZSnPQjLfcEDD8/Tap5hUwR
6Mt5qcio0DXSkQPeIcypjdIOAWVZH08bOOKs/Jb3ei76SJKYs6ygkUx8IjWRCEsz
dc9FpBsUQdCYuSVM5YFK9dceW3Iz/QmJUnyEXHyZmi480Ag6FRsPsFJ72ZuROM0X
JiAb+++cfFdETSFiG6PUYbSRHwoOObWYddg2MvmLGpij3Y511QiAymJ2aezd8Rkw
VBuaf6V4Hsg+pBtg8IsFa5imSoDK2L4fBV+uFe5YODnOsdtABQroDPwl6tBheZ4t
APLUv29KYw9hma9s8aVwTMaoSkccsiR7Es54pXTcXM+rzkdHhkXzqS6nOqOJ+d7S
XMLyK6zUTespCOkJZK6CSZTf68Ho8k1lv5axuab0fk3PLHiukfIh/7gPkDcEzqpo
lnBcnA6J9IrbcjPzg9Vk19uT4hQG6tC56RwSd9Lkjf9naR6Ob728Lu+p70JTWxHr
j4rHIOapyK/nHtjESozE
=BOaV
-----END PGP SIGNATURE-----

--8jcWiON1L7A8HfS7--
