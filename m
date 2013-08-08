From: Stefan Beller <stefanbeller@googlemail.com>
Subject: Re: Reproducible, corrupt packfile after fresh
Date: Thu, 08 Aug 2013 14:18:49 +0200
Message-ID: <52038CA9.5090602@googlemail.com>
References: <52037F47.5010302@exxcellent.de> <52037F84.9060006@exxcellent.de> <f1d8f80d6fa3678ac043bfdb19bebf6bf4261273@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig7B2CC94CBD7ACEF078BBA2F3"
Cc: git@vger.kernel.org
To: gitml.jexpert@recursor.net
X-From: git-owner@vger.kernel.org Thu Aug 08 14:18:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7PBB-0000iX-3l
	for gcvg-git-2@plane.gmane.org; Thu, 08 Aug 2013 14:18:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757767Ab3HHMSx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Aug 2013 08:18:53 -0400
Received: from mail-we0-f171.google.com ([74.125.82.171]:41787 "EHLO
	mail-we0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757599Ab3HHMSw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Aug 2013 08:18:52 -0400
Received: by mail-we0-f171.google.com with SMTP id q55so2457506wes.16
        for <git@vger.kernel.org>; Thu, 08 Aug 2013 05:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type;
        bh=g1W3HUJR3rk8wlD2G+T5/FVeCP51XaS4fCx51H5Ru9c=;
        b=aWAucuvTtH5mhTUCNyGXR9yTtwA+d+IALIzvloY8f6gy6EQRoYHUVyTKK6/7gJ7Oxd
         KbBmjgROkuKzal7qhjxfvjgfNHTGpWQ9bMCl3lFjLYKWE551wewwvHRSM2l9hSsxksdt
         /+b/xLkOHidSsq3OGQzzOSeHEYHNaGAaVW4MZoqV4wejGWeznTGO0BV4xGVtIjlXRbqg
         tOUIhMrWRp7tJ1sLguhZLXrvocz91zL+BIVj4qcGmTwUtQ/QKMPQC6mxSXPdPT3hovie
         7+8HVxu/T4fx3uOEIEXto/ed6k5PbEikYexHhMBmZ7kvrZt9AwbqAd+1/jj/I2l/mCmO
         bmgA==
X-Received: by 10.194.104.170 with SMTP id gf10mr3033697wjb.90.1375964329303;
        Thu, 08 Aug 2013 05:18:49 -0700 (PDT)
Received: from [192.168.1.3] (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id nb12sm14288721wic.3.2013.08.08.05.18.48
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 08 Aug 2013 05:18:48 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130623 Thunderbird/17.0.7
In-Reply-To: <f1d8f80d6fa3678ac043bfdb19bebf6bf4261273@localhost>
X-Enigmail-Version: 1.4.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231874>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7B2CC94CBD7ACEF078BBA2F3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 08/08/2013 01:56 PM, gitml.jexpert@recursor.net wrote:
> I'm a heavy user of git-svn and experience an issue with one specific
> (git-svn) repository: 'git fsck' reports a corrupt packfile after every=

> checkout.
>=20
> Now I'm totally puzzled about the cause and what do about it.
> This is what I do:
>=20
>     git svn init -s http://svn.foo.com/myproject myproject.git
>     cd myproject.git
>     git svn fetch         # Much more reliable than 'git-svn clone'
>=20
> This checks out ~2100 commits and executes 2 git-gc during checkout. Th=
e
> final .git repo size is about 940MB. Then I run
>=20
>     git fsck
>=20
> =E2=9E=9C myproject.git git:(master) git fsck
> Checking object directories: 100% (256/256), done.
> error: packed 0f5f33639bfc1a781fe080c31a1f076d9a25c1d3 from
> .git/objects/pack/pack-6a6f5355584a5d71215d5fc867ce09602ceab533.pack is=

> corrupt
> *** glibc detected *** git: free(): invalid pointer: 0x00007f46a09e9010=
 ***
> =3D=3D=3D=3D=3D=3D=3D Backtrace: =3D=3D=3D=3D=3D=3D=3D=3D=3D
> /lib/x86_64-linux-gnu/libc.so.6(+0x7eb96)[0x7f46d9ebab96]
> git[0x4ddf46]
> git[0x4b4123]
> git[0x431524]
> git[0x405ce8]
> git[0x4050e2]
> /lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xed)[0x7f46d9e5d76d]=

> git[0x405529]
> =3D=3D=3D=3D=3D=3D=3D Memory map: =3D=3D=3D=3D=3D=3D=3D=3D
> 00400000-0055f000 r-xp 00000000 fc:01 12452043
>  /usr/bin/git
> 0075e000-0075f000 r--p 0015e000 fc:01 12452043
>  /usr/bin/git
>=20
> ....
>=20
>=20
> This only affects this very particular git-svn repo (and I have dozens
> of them). The error happens reproducible on every fresh checkout as
> described above. The backtrace does not appear always. The object is a
> very large blob
>=20
>     git show 0f5f33639bfc1a781fe080c31a1f076d9a25c1d3 | wc -c
>     39524691
>=20
>=20
> Any hints what to do?
>=20
> Thanks
> - Ben
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

Hi,

Regarding the backtrace, would it be possible to install debug symbols,
so the backtrace is a little more meaningful?
If you distribution doesn't provide debug symbols, compiling git=20
yourself is rather easy (git clone && make && make install=20
[defaults to ~/bin, so not root required for installing apart=20
from missing dependencies])

Stefan



--------------enig7B2CC94CBD7ACEF078BBA2F3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJSA4ypAAoJEJQCPTzLflhqCfAP/1ARyCile312pggKQ69fQodg
wcS9ZU/71ltMlFhSxG1Om2jv7wCEHZyOpS44fe1WUgj/+RwIJLMZ07tkpJvopCjx
w1hWAclZSzvajLEFqUsAI7swG3wNl7NX3hm2WrcVzCU6UMLpcTzsHN148bVAX8sV
sLa0kSHIXs2pQlRkYJ9EhzruT5ecHGiqilNsv4Hp1/ZaH7fTHLJ8M3MJfHeuiqB9
mtMw2Kx5WYzfEO8TMajmFqvSAZgfIbRyGt5Mv5spTQ5lJrhphkFXR76vHvHt/N18
PUh3ujGeuXOa4RYul5Y67UXEA5xBZ1swVcTsxfhgCKIERRlx+8b8IO3SEJNUSqgc
tKP1GCzWt+YwoHsgIqzJys7UFWotDecYBKBYLnH1aA5tEejIbJl5pZy7NGH254QO
hhPdq7UPK3ok7ykPfnfJ2BB6HQkaKoIU7ghZRZptfmK21Kv/eKpDyRASXS3Nl5he
QfCg9uYebhWx9+9jh5DU/tmkuCJIB+2eO0dsZdeM0fwddMId4Is+6hADCPgHGQ1D
oL2td1X8z1Yws9Jrhu1KnDj4WFt4/G4oxfa3+FxvwS8rUs3+IBQIyF9MG87IxKzb
dCZXuknjp2p2WbPpOgdjD8zWt4cN7Te0wYgA9T1FSPggHPbSfpNOkpk2FPKDNZxH
dcSLyHyeUDnR1E2mal1/
=jh1R
-----END PGP SIGNATURE-----

--------------enig7B2CC94CBD7ACEF078BBA2F3--
