From: "W. Trevor King" <wking@tremily.us>
Subject: Re: regression:
 "96b9e0e3 config: treat user and xdg config permission problems as errors"
 busted git-daemon
Date: Thu, 11 Apr 2013 16:03:30 -0400
Message-ID: <20130411200330.GA15667@odin.tremily.us>
References: <1365572015.4658.51.camel@marge.simpson.net>
 <20130410135605.GB4694@odin.tremily.us>
 <1365651583.19620.8.camel@marge.simpson.net>
 <20130411054207.GE27795@sigill.intra.peff.net>
 <7vwqs9jd0t.fsf@alter.siamese.dyndns.org>
 <20130411172424.GC1255@sigill.intra.peff.net>
 <20130411181103.GJ27070@google.com>
 <20130411181439.GA2820@sigill.intra.peff.net>
 <7vwqs8hmh1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="k1lZvvs/B4yU6o8G"
Cc: Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
	Mike Galbraith <bitbucket@online.de>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 11 23:04:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQOf9-0005VF-Rw
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 23:04:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936407Ab3DKVDx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Apr 2013 17:03:53 -0400
Received: from vms173001pub.verizon.net ([206.46.173.1]:40997 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935750Ab3DKVDu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Apr 2013 17:03:50 -0400
X-Greylist: delayed 3600 seconds by postgrey-1.27 at vger.kernel.org; Thu, 11 Apr 2013 17:03:50 EDT
Received: from odin.tremily.us ([unknown] [72.68.100.81])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0ML3003VIX1UKI30@vms173001.mailsrvcs.net> for
 git@vger.kernel.org; Thu, 11 Apr 2013 15:03:31 -0500 (CDT)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 6695D95D705; Thu,
 11 Apr 2013 16:03:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1365710610; bh=F2Jgzch6wbR+rwrbDdjwp8ha9stayEXqm8HeZI8Q+Gg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YVKELcs54Y2+ZOfkqBOQb7ETZDXcP43pII3EfMjtl2qqEN4rLc3ToFS8ig2YeD17l
 9E+t7UpLONTCayYUeJQsv5SdxzTizX20pQwOfGjbZUHlYPSdvvtFb3EZWAF4fZx9z4
 SmvA7XQ8oxVIA9eF8ykneuxKAX6w8ynbo7j3nFXo=
Content-disposition: inline
In-reply-to: <7vwqs8hmh1.fsf@alter.siamese.dyndns.org>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220928>


--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2013 at 12:54:34PM -0700, Junio C Hamano wrote:
> I also have a suspicion that your patch makes things worse for
> people who are more adept at these issues around running daemons
> than the people who introduced this problem in the first place (eh,
> that's "us")=E2=80=A6
>=20
> A trade off to make things slightly easier for one sysadmin by
> making another thing impossible to do for another sysadmin does not
> sound like a good one.

As one of the less experienced folks tripped up by this issue, I think
that setting HOME explicitly before invoking the daemon is simple
enough (which is why I just fixed my invocation and didn't post to the
list).  The difficulty was figuring out why the daemon was dying in
the first place (which involved bisection for me as well).  Maybe
there could be an additional note about HOME to flesh out:

  fatal: unable to access '/root/.config/git/config': Permission denied

when there's an EACCES error for the per-user config?  On the other
hand, the code to handle this might be more trouble than it's worth.

Cheers,
Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--k1lZvvs/B4yU6o8G
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRZxcQAAoJEEUbTsx0l5OMoXYP/1MEcFEDTMATtUxTDMoviWVa
C7BlFH51wXgQKA/O4IwAvLPWyyO3Ka8JiVnLBAXyi4IoCgmqSfUWvz+X5s8eJOHE
4eRHdU+jpLU9pBMPs1/IvRMQciPq1pBEVTOMjgseua5TEIQ1MujoF8adg9Vzi3r4
XIYVYqEAx0xZA3Ar5BepeQxXmuMDpehM+3aG/Oc6wP4/P+ACO1KxAddAwneaokkq
/NSdzuzHFgqJkpjNmZ5NgMX3WBjDC9D5rV4nmDaR3bV+DE/5Gzvyv3+KReIfLqJ2
XLV9zkGUJt8qhpyKKLFdu1hehOjPHpuz/fMVtOR6r+p1MugOtTtsno/R9GkescoB
W0yXknKbVvceN6Xgscj2Ei6OGZbcrhCDgs1L/NPRTuxCOwPUYhP7T9yvcBLD2lDE
UnTLqAU92VJlZgWz7kJIhRYu5CN1BZ+cpDTtT+/LWMWfUTBwTKaDP/pebseAoMFd
LHKaoSGo7tSpEP57mlqLJZReq6WVqDTVQoKxQQv/1AQpmi6Dr0MO3wJGYXVFFsIo
giUt/S+ygtsxh4DS0bbgGbVDJ6GZt9azjlm5Q8HFd5kL4cUE3do6Hqon0pLvkuzu
foswkNILaGq42DhXRIR3t2kgxspzwEvekbYsXhIiXu90fiZEjKnGo/FoakM4Yllb
gkM5tC45yYrovoAif8Jl
=o2pv
-----END PGP SIGNATURE-----

--k1lZvvs/B4yU6o8G--
