From: Charles McGarvey <chazmcgarvey@brokenzipper.com>
Subject: Re: is there a fast web-interface to git for huge repos?
Date: Fri, 07 Jun 2013 14:13:53 -0600
Organization: Sevenology
Message-ID: <51B23F01.5020608@brokenzipper.com>
References: <CAPKkNb4bYfBeqkBKqe-22iJsqjmvrYNSe4oWUnPo7QeghLK59Q@mail.gmail.com> <20130607063353.GB19771@paksenarrion.iveqy.com> <CAPKkNb5PyurX1eNsCsckdfiwgM3dqb5KpN9OS0NpLZw1+VsSdg@mail.gmail.com> <20130607175717.GA25127@paksenarrion.iveqy.com> <CAPKkNb4myh9MPNSgLqs5Mku-z1EOsHyWrgK2Qy_3_UOivXvcnw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2AJTCJEOARKVAACEJAHNS"
Cc: Fredrik Gustafsson <iveqy@iveqy.com>, git@vger.kernel.org
To: "Constantine A. Murenin" <mureninc@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 07 22:14:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ul334-0005EN-SA
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 22:14:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753821Ab3FGUN5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jun 2013 16:13:57 -0400
Received: from romulus.brokenzipper.com ([71.19.157.142]:65356 "EHLO
	romulus.brokenzipper.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752810Ab3FGUN4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 16:13:56 -0400
Received: from vulcan.local (unknown [IPv6:2602:61:7edf:e300:0:ff:fe00:7701])
	by romulus.brokenzipper.com (Postfix) with ESMTP id 9A72652D2A;
	Fri,  7 Jun 2013 14:13:55 -0600 (MDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=brokenzipper.com;
	s=romulus; t=1370636035;
	bh=7FbMcdfwTQg/1+rkQFZLCwMgGtFOf28jPjVsJl2oVno=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=MoItBR1CRj74YDNTd/Qsf2uK+RD2CnqqKwMNPiNbNcye6oHfCRumBJ70zXySqUkC7
	 5FRL8+CTWGrGoxr9HuYTbtMlWfZbQALFE6bWixJgXQjCLo4obh/MEXYH8G8rz64Uyh
	 RsKI1xdu05z/nxP7ZNd0BwzXq0a5Jti3MrJygi8s=
Received: from [2602:61:7edf:e300:0:ff:fe00:7700]
	by vulcan.local with esmtpsa (TLS1.0:DHE_RSA_CAMELLIA_256_CBC_SHA1:256)
	(Exim 4.80)
	(envelope-from <chazmcgarvey@brokenzipper.com>)
	id 1Ul33I-0002IQ-N1; Fri, 07 Jun 2013 14:14:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130523 Thunderbird/17.0.6
In-Reply-To: <CAPKkNb4myh9MPNSgLqs5Mku-z1EOsHyWrgK2Qy_3_UOivXvcnw@mail.gmail.com>
X-Enigmail-Version: 1.6a1pre
OpenPGP: url=https://www.brokenzipper.com/chaz.asc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226693>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2AJTCJEOARKVAACEJAHNS
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 06/07/2013 01:02 PM, Constantine A. Murenin wrote:
>> That's a one-time penalty. Why would that be a problem? And why is wge=
t
>> even mentioned? Did we misunderstood eachother?
>=20
> `wget` or `curl --head` would be used to trigger the caching.
>=20
> I don't understand how it's a one-time penalty.  Noone wants to look
> at an old copy of the repository, so, pretty much, if, say, I want to
> have a gitweb of all 4 BSDs, updated daily, then, pretty much, even
> with lots of ram (e.g. to eliminate the cold-case 5s penalty, and
> reduce each page to 0.5s), on a quad-core box, I'd be kinda be lucky
> to complete a generation of all the pages within 12h or so, obviously
> using the machine at, or above, 50% capacity just for the caching.  Or
> several days or even a couple of weeks on an Intel Atom or VIA Nano
> with 2GB of RAM or so.  Obviously not acceptable, there has to be a
> better solution.
>=20
> One could, I guess, only regenerate the pages which have changed, but
> it still sounds like an ugly solution, where you'd have to be
> generating a list of files that have changed between one gen and the
> next, and you'd still have to have a very high cpu, cache and storage
> requirements.

Have you already ruled out caching on a proxy?  Pages would only be gener=
ated
on demand, so the first visitor would still experience the delay but the =
rest
would be fast until the page expires.  Even expiring pages as often as fi=
ve
minutes or less would probably provide significant processing savings
(depending on how many users you have), and that level of staleness and t=
he
occasional delays may be acceptable to your users.

As you say, generating the entire cache upfront and continuously is waste=
ful
and probably unrealistic, but any type of caching, by definition, is goin=
g to
involve users seeing stale content, and I don't see that you have any oth=
er
option but some type of caching.  Well, you could reproduce what git does=
 in a
bunch of distributed algorithms and run your app on a farm--which, I gues=
s, is
probably what GitHub is doing--but throwing up a caching reverse proxy is=
 a
lot quicker if you can accept the caveats.

--=20
Charles McGarvey


------enig2AJTCJEOARKVAACEJAHNS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAlGyPwEACgkQNi05PrCndfuDUQCfWWFxzUYjCnR1V9mT0HUP7bOc
QokAnjC/CivddLcxPht2SbudtsepzZsw
=txHV
-----END PGP SIGNATURE-----

------enig2AJTCJEOARKVAACEJAHNS--
