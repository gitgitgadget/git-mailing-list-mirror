From: Ben Hutchings <ben@decadent.org.uk>
Subject: Re: Bug#813084: Background git gc fails, telling me to run git
 prune, which doesn't help
Date: Sat, 27 Feb 2016 22:50:04 +0000
Message-ID: <1456613404.3098.23.camel@decadent.org.uk>
References: <145407452147.14999.2503236526246955240.reportbug@deadeye.wl.decadent.org.uk>
	 <CACsJy8Ai9dW3mLOEidsyh2yw29-2zvYRGB1LZN51B-L4QHMQ2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-FnJEwqH+ABdpD/5zK4fj"
Cc: git@vger.kernel.org
To: Duy Nguyen <pclouds@gmail.com>, 813084@bugs.debian.org
X-From: git-owner@vger.kernel.org Sat Feb 27 23:50:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZnh2-0006bj-9I
	for gcvg-git-2@plane.gmane.org; Sat, 27 Feb 2016 23:50:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756787AbcB0WuV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Feb 2016 17:50:21 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:60876 "EHLO
	shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756728AbcB0WuU (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 27 Feb 2016 17:50:20 -0500
Received: from [2a02:8011:400e:2:b06c:6b7a:5449:a1ad] (helo=deadeye)
	by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
	(Exim 4.84)
	(envelope-from <ben@decadent.org.uk>)
	id 1aZngm-0006uT-An; Sat, 27 Feb 2016 22:50:16 +0000
Received: from ben by deadeye with local (Exim 4.86)
	(envelope-from <ben@decadent.org.uk>)
	id 1aZngg-0004Vx-Ka; Sat, 27 Feb 2016 22:50:10 +0000
In-Reply-To: <CACsJy8Ai9dW3mLOEidsyh2yw29-2zvYRGB1LZN51B-L4QHMQ2w@mail.gmail.com>
X-Mailer: Evolution 3.18.3-1 
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:b06c:6b7a:5449:a1ad
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287734>


--=-FnJEwqH+ABdpD/5zK4fj
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Control: forwarded -1 git@vger.kernel.org

On Fri, 2016-01-29 at 21:05 +0700, Duy Nguyen wrote:
> On Fri, Jan 29, 2016 at 8:35 PM, Ben Hutchings <ben@decadent.org.uk> wrot=
e:
> > git keeps trying to do a background gc on my linux repository, but
> > fails, reporting this in .git/gc.log:
> >=20
> > warning: There are too many unreachable loose objects; run 'git prune' =
to remove them.
> >=20
> > However, after running 'git prune' and 'git gc' (which succeeds), git
> > soon tries to a background gc again, resulting in the same error.
> >=20
> > Let me know what I can do to get any further diagnostic information.
>=20
> Make sure nobody is accessing the repository before you do this:
>=20
> git prune --expire=3Dnow
>=20
> Then you can try "git gc --auto" again to see if it is still
> complaining. Report back on git@vger.kernel.org in that case.

OK, I've now done that and I get the same failure. =C2=A0But
'git gc --prune=3Dall' seems to work:

$ git gc --prune=3Dall
Counting objects: 6479254, done.
Delta compression using up to 4 threads.
Compressing objects: 100% (939232/939232), done.
Writing objects: 100% (6479254/6479254), done.
Total 6479254 (delta 5503044), reused 6479254 (delta 5503044)
Checking connectivity: 6479254, done.

I kept a backup of the .git directory so I can run further experiments
on that.

Ben.

--=20
Ben Hutchings
Every program is either trivial or else contains at least one bug
--=-FnJEwqH+ABdpD/5zK4fj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIVAwUAVtIoHOe/yOyVhhEJAQpMEw//da54ikeiRkZEPjVPQZExveQ3Se0U4uih
jRXIpTCV1AYFwWlHg9KvXRzkF9DQyQgp8RWB8Sy8D5WlpTJqj6Hg/8t8ZIhY8OW6
75Ng8Ctw/0FQ3IjWYi31Za1jDmAthC1oKaOMZGqDY+T2Nlf52wvOuC83HdRAm3nf
qnFu4bMrkSePJywLAgO8b0WczTSaZyZ+LvUo9h2ZZ3Sd18NlUHyuDI99m11EXPCR
and4Hg3BBVZ3lUXaceOT4UnUw1ZVyBPsEucWZp2l0AwhApnltpXj7yRLpjUK0ee1
yccuwJ5+3Rutg2raeCzL/TA7i+dkrQR+yI6VrFKcE7qlK5FJg6X3Hs0WBlxEVJKb
Kta3JxcpxnCwUx/vpLtFGTTYeDQ5LRriIhqONIiVSyBPiII3EgjCls57HB4cTnVA
6ru9h/Vr7//rSj+EvArtB7ZgrM8iTez6mwoleUj7/AIUKD+5zA52vtlHlBqXQFwl
8G5BKph816r9EG4ZjD3SNPhXUPLTScUADSsYCFWcF1q8KNGzxU7jK+vk56VUBzye
9eZwz8UBvDL+y0h9XG4HUF+VIzPXDXPWbh4T/mV1CcwXGmkcsqRXOeyGIJoGVKFR
A/COrmWrr4ETpjRs0+LEKcQLDhY2KQG7HdFyuMYl2vrlH8iADFGNVkaKGr05uege
2ZyNVTVHSpE=
=hSQw
-----END PGP SIGNATURE-----

--=-FnJEwqH+ABdpD/5zK4fj--
