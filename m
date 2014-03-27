From: "W. Trevor King" <wking@tremily.us>
Subject: Re: Possible regression in master? (submodules without a "master"
 branch)
Date: Thu, 27 Mar 2014 08:57:48 -0700
Message-ID: <20140327155748.GN4008@odin.tremily.us>
References: <CALKQrgeRJRoyC-UV7J98U1qQfqEFr_H1sEfAWd0GbstZagUisw@mail.gmail.com>
 <20140327155208.GM4008@odin.tremily.us>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0aF+6pWUK5w8WdCh"
Cc: Git mailing list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Mar 27 17:04:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTCmf-0006NH-MR
	for gcvg-git-2@plane.gmane.org; Thu, 27 Mar 2014 17:04:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756525AbaC0QD5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Mar 2014 12:03:57 -0400
Received: from qmta11.westchester.pa.mail.comcast.net ([76.96.59.211]:53322
	"EHLO QMTA11.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755131AbaC0QD4 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Mar 2014 12:03:56 -0400
X-Greylist: delayed 365 seconds by postgrey-1.27 at vger.kernel.org; Thu, 27 Mar 2014 12:03:56 EDT
Received: from omta21.westchester.pa.mail.comcast.net ([76.96.62.72])
	by QMTA11.westchester.pa.mail.comcast.net with comcast
	id iay21n0081ZXKqc5Bfxql3; Thu, 27 Mar 2014 15:57:50 +0000
Received: from odin.tremily.us ([24.18.63.50])
	by omta21.westchester.pa.mail.comcast.net with comcast
	id ifxp1n007152l3L3hfxpTz; Thu, 27 Mar 2014 15:57:50 +0000
Received: by odin.tremily.us (Postfix, from userid 1000)
	id C2A1010DD462; Thu, 27 Mar 2014 08:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1395935868; bh=DJmtvEAuB2cnxl2XRHC5HEGQhJD7g4Y1biAzW+eRcYw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nL2+v2he8QmnBZN68m4Tydyy1XvzIwyl3wpm8+1KWsD3auOwojkAuI57UOOHDZVqj
	 fBjZXepFPc1nkbPYbXpknkghBmAbvsGIJi3uks+pG2XkH7Foju6fDLNxkx8k6JrdSG
	 YzBziP1T3U6cWW0d/XCEaRVEuwABcTVUyQT2tnt4=
Content-Disposition: inline
In-Reply-To: <20140327155208.GM4008@odin.tremily.us>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.22 (2013-10-16)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20140121; t=1395935870;
	bh=+aKQKhnpr2D3wLR5sqfXeFFFkR12izSpV0wSR1SdeSQ=;
	h=Received:Received:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type;
	b=f992U/3kqTVfh5KqHpKZcRcGUrd+YX0pC7zDu6BOInsSsWCvL5bfNpZEeu8d5u9Mc
	 BcPWogS8nsVWbIUbXnvyH3dVBXPkzY8YWYPq//7NOXlXxLaazmXMNk3n+7L7Dn098V
	 0ERzq8tj4PF/RRe9WQKQ8ZZUi3KiAdu1xZkmvRQxjLsnetMwiYWX0NdXj9SNNBne0L
	 vvhJbx19gAREGD6udHqQPmSyYh4TypaXMTydXMqnUa9/xR55shx/41uoAmaJezSXUJ
	 F2dk/UwJN9Td4ZKhuKcKEvCaqdbOvB9WENy21r+rh7OLnUBemsi8lVMXu1N7qmLgQf
	 uBtkbASIpGAhA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245288>


--0aF+6pWUK5w8WdCh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 27, 2014 at 08:52:08AM -0700, W. Trevor King wrote:
> Working around that to default to the upstream submodule's HEAD is
> possible (you can just use --branch HEAD)

Actually, this is probably not a good idea.  The initial submodule
addition works:

  $ git submodule add -b HEAD /tmp/submod.git submod
  Cloning into 'submod'...
  done.

But subsequent log calls (from the superproject) do not:

  $ git log
  fatal: bad default revision 'HEAD'
  $ echo $?
  128

and status calls (from the superproject) also have trouble:

  $ git status
  warning: refname 'HEAD' is ambiguous
  warning: refname 'HEAD' is ambiguous.
  On branch master
  =E2=80=A6

So it's better to just specify your preferred upstream branch directly
(e.g. --branch next).

Cheers,
Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--0aF+6pWUK5w8WdCh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTNEp7AAoJEKKfehoaNkbtg3kQAKXHammX2xgQ7Z9zVRHiJj/q
yGSiAM/OTmzydU1x82Q13whP3JUMM2B9Vsi2Qr7HqZevgZz5Zogk2X6yc2rXWrgE
Fb4IFj7eyIsxzCsGBxqdNoLOrnvIVQa8+JYVps116O4d6hGGa8fNs/jqt/pIudNw
LpNi6pq6J/nUaxQ4L/w/O5vGdwYVQvut2PK9l3Be5HD5NWCS9roiAZZ7fQ4TjaI0
zmdZL0DJb1VdPSFdhvCDFoRVJdBjlIIJ/5sU61e0zZ/QV3RlAyArUCK1GyqHJH09
umW6JT7k9CBCEl5Rj6JTaGaj7YeSjG10jEj8RvEgtLpgiRX6wr63m/xBYbrIBKdi
H1JN9Q8T3G/ymp3pI4OULaS8gHeKzyV1GHahBBA2zQeVzyzGXU1CHR+JCN5UPCQh
xVcZRWVO4vFSzGF+GJkRofO+2+doFuc1RYjRUnFX4wA3lQ/hn/ZyKwYddJmpeDzE
+CLyXGbJn1SMvaMH87Tgfn6bAeYeMGlM8VVeNcupde9TUejJmuaknnQfzefK7BFy
D2PZC+XMACU2ouhl+X/CHjrB1uw9DFiR3E8pq7H6RiV3gBR0GghVkIGCyFfMgSMv
u/Kre3hcAnTowALIXjGhlwcR42ijxR3HUrtGAFzYbNvGD+lFuSJM6WxgqZP7TIwd
THAHHTiaccs7NJjXBgSn
=Te+N
-----END PGP SIGNATURE-----

--0aF+6pWUK5w8WdCh--
