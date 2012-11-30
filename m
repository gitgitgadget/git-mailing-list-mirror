From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [PATCH v5 0/2] submodule update: add --remote for submodule's
 upstream changes
Date: Thu, 29 Nov 2012 22:27:19 -0500
Message-ID: <20121130032719.GE29257@odin.tremily.us>
References: <CABURp0oSo9ACFKkBEK1_qNu2mEAu1=nUJxnROaRsXiaWvHih=w@mail.gmail.com>
 <cover.1354130656.git.wking@tremily.us>
 <20121129191326.GC27409@odin.tremily.us>
 <CABURp0piLAG+hEsav-uro+nq9ZRZ9CFFjVG8VKYk3ZtYvRi8=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary=+JUInw4efm7IfTNU
Cc: Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>, Jeff King <peff@peff.net>,
	Shawn Pearce <spearce@spearce.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Nahor <nahor.j+gmane@gmail.com>
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 30 04:27:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TeHGZ-0001I7-Ig
	for gcvg-git-2@plane.gmane.org; Fri, 30 Nov 2012 04:27:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751593Ab2K3D1g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2012 22:27:36 -0500
Received: from vms173005pub.verizon.net ([206.46.173.5]:63436 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751167Ab2K3D1f (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2012 22:27:35 -0500
Received: from odin.tremily.us ([unknown] [72.68.95.230])
 by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MEA00A6H6XJUZA0@vms173005.mailsrvcs.net> for
 git@vger.kernel.org; Thu, 29 Nov 2012 21:27:20 -0600 (CST)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 68B436E30DE; Thu,
 29 Nov 2012 22:27:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1354246039; bh=mxIyCTEnzOfsmsvHwVr8eFXUiKdx/ZsMgS8rOEI6sBA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=apn6B1+ntryB9iBpSYNNmeERWLnW9YsrkNuMB2GiOxcJ0pc0JiLUYUXEhQWfhwk8A
 JqtRrLjThYrYVCnMtmxRW0btqSwDboR4Rkxj+V2sIdTi4CfoGh/WbBl4yDiWLW2RZu
 CTv29HgIey08fdY9aBkLJOFHu2HiSIQrYpHQznaY=
Content-disposition: inline
In-reply-to: <CABURp0piLAG+hEsav-uro+nq9ZRZ9CFFjVG8VKYk3ZtYvRi8=A@mail.gmail.com>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--+JUInw4efm7IfTNU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 29, 2012 at 08:11:20PM -0500, Phil Hord wrote:
> On Thu, Nov 29, 2012 at 2:13 PM, W. Trevor King <wking@tremily.us> wrote:
> > On Thu, Nov 29, 2012 at 01:29:12PM -0500, Phil Hord wrote:
> >> For that reason, I don't like the --pull switch since it implies a
> >> fetch, but I will not always want to do a fetch.
> >
> >   $ git submodule update --remote --no-fetch
> >
> > will not fetch the submodule remotes.
>=20
> This seems precisely backwards to me. Why not use
>=20
>   $ git submodule update --remote --fetch
>=20
> to do your "default" behavior instead?   I suppose I am arguing
> against the tide of the dominant workflow, but the fetch-by-default
> idea needlessly conflates two primitive operations:  "float" and
> "fetch".

Because --no-fetch is the existing option, and if it ain't broke=E2=80=A6 ;=
).

> >> I don't know which remote I should be tracking, though.  I suppose
> >> it is 'origin' for now, but maybe it is just whatever
> >> $superproject's HEAD's remote-tracking branch indicates.
> >
> > With the --remote series, I always use "origin" because that's what
> > `submodule add` should be setting up.  If people want to change that
> > up by hand, we may need a submodule.<name>.remote configuration
> > option.
>=20
> I've always felt that the "origin" defaults are broken and are simply
> being ignored because most users do not trip over them.  But ISTR that
> submodule commands use the remote indicated by the superproject's
> current remote-tracking configuration, with a fallback to 'origin' if
> there is none.  Sort of a "best effort" algorithm, I think.  Am I
> remembering that wrong?

The current code uses a bare "git-fetch".  I'm not sure what that
defaults to if you're on a detached head.  If it bothers you, I'm fine
adding the submodule.<name>.remote option in v6.

> >> I am not sure I want the gitlinks in superproject to update automatica=
lly
> >> in the index, but I definitely do not want to automatically create a c=
ommit
> >> for them.
> >
> > Commits are dissabled by default (see my recent --commit RFC for how
> > they would be enabled).
> >
> >> But I really don't want to figure out how to handle submodule
> >> collisions during a merge (or rebase!) of my superproject with changes=
 that
> >> someone else auto-committed in his local $superproject as he and I
> >> arbitrarily floated up the upstream independently.  There is nothing b=
ut
> >> loathing down that path.
> >
> > This is true.  I'm not sure how gitlink collisions are currently
> > handled=E2=80=A6
>=20
> They've always been trouble for me.  But it may be that I am ignorant.

I haven't dealt with any gitlink merges, but I think that supporting
easy gitlink merges is orthogonal to this --remote option.  For simple
cases like "autocommitted submodule floats", one of the conflicting
gitlinks will be an ancestor of the other, so it should be easy to
automate that merge.

Cheers,
Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--+JUInw4efm7IfTNU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQuCeQAAoJEEUbTsx0l5OMrgwP+gMZu2rjkF9HyPimOfprQC1a
Q5BraO/H6DGcLm3azQ05BE6tZ8vY3DiDIC18uQA+fOBipdnYwKQhq+xrBIMlzuUD
3yB/JAsbWbHkTtkwD5U9SEeZv4KmnuTM+v25SkR3+nllWtbnrauHztPJiIT0VdLG
zqpMCvmTLuwoLIYpuSBaJrLfld+uP6wkZ/ewEOfNidVjAnJAP0kQ+07EDv6Givql
rJIue9MsLYHudNowkFbHrUtSqaeCRJw3HqQdiAh7oaPHcItae1W86Cc/iA4nnHht
i5XQAr+1woDcyI6oo4AS54izWbTCYY2bPgthu5SZ6KVoj0yDmlHX6ZpbC6MBG4Fu
d8qn54Yaxnx9cJ9x8Xy0jwi3GznG6jjBeSYOJZ3FFIHaO5RtBUtjFlZadP+/UA2X
ncuq5+MJg4W3ehhdlhEgPJsAp4VxtmlZf1YBQNFKmHUmufMgL5ZgEkYdE7Cx7lP4
pGTn2k5/GTvGeMBi0AtR5GmHrM6AtASW5fQNvh1wPMZzB5IAvvZNpbq0Ori58L8v
l9P4zyP2z/tG37OUJwIBs7NpDMVpDG7Uiy5gwXMRE9hc23Dv81L7F6QNIATE9Tkt
9fbfFTTssfaRXTLd45r7s4MqK8vkww9gJ5PTjgwKSRPw01XcEntdkHqdtJfIhKUw
VBki1RUhHynSz3NIpiiI
=jQKF
-----END PGP SIGNATURE-----

--+JUInw4efm7IfTNU--
