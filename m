From: Johannes =?utf-8?B?TMO2dGhiZXJn?= <johannes@kyriasis.com>
Subject: Re: publish from certain commit onward, keeping earlier history
 private, but provable
Date: Wed, 9 Dec 2015 18:54:31 +0100
Message-ID: <20151209175431.GA18000@zorg.kyriasis.com>
References: <35583CFA-3BEE-4844-9F85-ED73A412A97F@joernhees.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fdj2RfSjLxBAspz7"
Cc: git@vger.kernel.org
To: =?utf-8?B?SsO2cm4=?= Hees <dev@joernhees.de>
X-From: git-owner@vger.kernel.org Wed Dec 09 18:54:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a6iwp-0007aP-U7
	for gcvg-git-2@plane.gmane.org; Wed, 09 Dec 2015 18:54:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752795AbbLIRyg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Dec 2015 12:54:36 -0500
Received: from theos.kyriasis.com ([212.71.254.33]:40488 "EHLO
	theos.kyriasis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752646AbbLIRyf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Dec 2015 12:54:35 -0500
Received: from theos.kyriasis.com (localhost.localdomain [127.0.0.1])
	by theos.kyriasis.com (OpenSMTPD) with ESMTP id e589ff0f;
	Wed, 9 Dec 2015 17:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=kyriasis.com; h=date:from
	:to:cc:subject:message-id:references:mime-version:content-type
	:in-reply-to; s=theos; bh=JyYB5bNMfh3ekBY8dJ4SGrLIdik=; b=oinw8m
	a283nYARhiuOw5AOcvqkeDIfRvGXFm3qjmAGEitNk6vL29HXWzRbSj1g41zN+PNf
	OtIBb7XW0vb9w6ImibzLHsL4IGe15Ln4rBumWIrOAxlyCDYGlrMhbTASL6qB30oz
	djmfXNNxorvR2CuRpywIB7btFplsJhnLY7ksg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=kyriasis.com; h=date:from:to
	:cc:subject:message-id:references:mime-version:content-type
	:in-reply-to; q=dns; s=theos; b=Rx1LHu05vhb80bjxrQxJ5YZfK2f9/I8M
	/2nhCn0cq2nstfJjtrx8MGwr/kMZXVr3f4O118Cb4y8vLIFF/bQhYwR8+nOy7bO4
	Bdu2W8y4+wTGEyhiuCIg08HmjkyXtiMbTFPtQvX2uu8u1uxbHj6iUp207qvWBuWM
	Z4qV5IPsPRg=
Received: from zorg.kyriasis.com (c83-250-98-78.bredband.comhem.se [83.250.98.78])
	by theos.kyriasis.com (OpenSMTPD) with ESMTPSA id 321317d4
	TLS version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO;
	Wed, 9 Dec 2015 17:54:33 +0000 (UTC)
Mail-Followup-To: =?utf-8?B?SsO2cm4=?= Hees <dev@joernhees.de>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <35583CFA-3BEE-4844-9F85-ED73A412A97F@joernhees.de>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282195>


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 09/12, J=C3=B6rn Hees wrote:
>Hi,
>
>I've been hacking away on a library for quite some time and have a lot=20
>of commits in my private repository:
>
>A -> B -> C -> D -> E
>
>Finally, I'm nearing completion of a first version, and want to publish=20
>it to a remote called public from D onward keeping A..C to myself, so=20
>public should afterwards look like this:
>
>D -> E
>
>My main motivation is that i don't really want to put ridiculously=20
>first trials online, but still (on demand) I'd like to be able to prove=20
>how i arrived at D (think of copyright claims, etc).
>
>As (at the moment) it's pretty much impossible to reverse-engineer the=20
>hashes of commits in the chain with times and changesets, i thought=20
>just keeping D's parent pointer to C would be one of the genius=20
>advantages of git. Sadly i can't find a way to actually make this work.
>
>Can i somehow push D -> E to public making it a fully functional public=20
>repository with all the necessary objects included to checkout D or E=20
>and D still pointing to C as parent? If not, why is that?
>

Take a look at git-replace[0][1].

[0]: https://git-scm.com/2010/03/17/replace.html
[1]: https://www.kernel.org/pub/software/scm/git/docs/git-replace.html

--=20
Sincerely,
  Johannes L=C3=B6thberg
  PGP Key ID: 0x50FB9B273A9D0BB5
  https://theos.kyriasis.com/~kyrias/

--fdj2RfSjLxBAspz7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQTkBAABCgDOBQJWaGrUMxSAAAAAABUAFXBrYS1hZGRyZXNzQGdudXBnLm9yZ2pv
aGFubmVzQGt5cmlhc2lzLmNvbV8UgAAAAAAuAChpc3N1ZXItZnByQG5vdGF0aW9u
cy5vcGVucGdwLmZpZnRoaG9yc2VtYW4ubmV0RTU1MEZGRkZENDg1RTI2NEExNzE3
RTMwOTAxQzFDMzIwRUIwRDQ1RDMUgAAAAAAVABVwa2EtYWRkcmVzc0BnbnVwZy5v
cmdqb2hhbm5lc0BreXJpYXNpcy5jb20ACgkQkBwcMg6w1F2BTSAAhtr2CKV+++aB
zz2uXGPSgQGj/aWKht/l25XagUn6ilC1I+mjpr2EUJGqG8wFEyNJlMo2AeBtI7/e
fRYauBO5R8J17/hG/51NDYiDNweGQNzqxHdj0v3TUx8V5wucgQhCGKxfKOvORriy
g2eZWREbKqR2HS/0xvN1lZJrx0Mo2QuRiVp1cOjAtk6Q0ZTVOunYq4/3DvAGfLvB
yTDjP/Dq4P9Y6C/RA4YhHTkNtRCDPuXZvM+Ah0fWoBdLRQmm1lYA3Toucplu4NRB
p8Bqkkkg3chYA2g9685YrW0HcUONlUEmCs736P6lMHmQv2MwbB1JnmntfSDydP8c
NdI7piG6qGboPp2wUVZ0/hlQOPSaBmA4Rvu5W5bBSS2ia6GFchq/1nZTksAhsiaW
TOOgILDW+Cq+5ld/g1h1bXdbigw5IBx3wZemRJjfUMESQkQoe5RdKC51JjYIiSt7
NogMoPoPGWqzSOmoDOXw0a1108nDMegDbIxWNRlA0UAyRJGIf8VePc9YxqDW2PZ0
bwj1PKAeci4LYryO93Mwakp5ebIBduY+ne9IOpfnblSY1DX9gBuUNQDKHYCxGIAj
wKwSlVEhuRKxNciRhXpbjpVE7Q4DMg1Utry8ree9EFhfDRFyUKNGJVu1CISduUMf
iI3UXl0YmR05JPYuX9ZiMBcMFrJIAlZ9Uh0w4//nRXa/d27waEfbgPKiVkLWQvvn
pHlBv/BDGpWJkQJTUDH16BtLZb6Vmc9x71jOQMhdjof90QNquHD5Cdr1MQuuduCR
yoawzOKP/pZnMysQ6XnG7VbvZv6iHxAzbL8F0TwuF0kx8LgBwcocwB1t2lRJWdmR
MnNif52w4FwMl+ZXxwVUWz7aH7aniN000dbgbuNxpS4j1DGPcsayvDfczuJLayat
tjw7fh8u1shTgSS1iU3oIzQRhS2+l4MbPGkLs+5cav20y2W8UYKeCaC14A5QD58A
emg+hxdJTU9KR3UZMgxpVoAlZtxrf/9qiS3nuGo/YrkzUtoCphQ/sZ3bgNO4Ma0f
hpDYf8SHjytATgbF0Ydq8Z/PDXxnXaTPY0RpHZk3Tc6Gew6GuyjWquFkQfcxWqCa
5tCv0mbhQoUM0OJkO2caRO975pc+FIB6ew3xTCfEJHzcaBTCcJApxjPT2NhRiqwX
r0tQZSjFZF0o33rGGe1kcCEyIJs79yG55EiFC/G4mA631Ml39Bp0NT2kBSlgATFI
i55hh41Wim1UaZEOXSyPRL8zEEBbu/mS850lcNkzfcATFXsTjvZ9bgmvNiZMUi3f
Muq/UTEa9DgnMKsYGFMhLXGGTdtmIB9CpGQV2e0DAYvL74tdYzVxZfJuHiIyVPxV
NuE4UFg8Sw==
=cJM+
-----END PGP SIGNATURE-----

--fdj2RfSjLxBAspz7--
