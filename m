From: Stefan Beller <stefanbeller@googlemail.com>
Subject: Re: [PATCH] Fix some sparse warnings
Date: Tue, 16 Jul 2013 23:18:53 +0200
Message-ID: <51E5B8BD.8090202@googlemail.com>
References: <51E431F1.6050002@ramsay1.demon.co.uk> <51E4E0C0.3060604@viscovery.net> <20130716062122.GA4964@sigill.intra.peff.net> <6BDA2E3E7318418BBB2C19B475B2B118@PhilipOakley>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig62CC7940A7ED28BF3EC28CA1"
Cc: Jeff King <peff@peff.net>, Johannes Sixt <j.sixt@viscovery.net>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Tue Jul 16 23:19:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UzCeG-0004Zg-GS
	for gcvg-git-2@plane.gmane.org; Tue, 16 Jul 2013 23:19:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933981Ab3GPVS7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jul 2013 17:18:59 -0400
Received: from mail-we0-f177.google.com ([74.125.82.177]:58938 "EHLO
	mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933694Ab3GPVS5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jul 2013 17:18:57 -0400
Received: by mail-we0-f177.google.com with SMTP id m19so1084190wev.36
        for <git@vger.kernel.org>; Tue, 16 Jul 2013 14:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type;
        bh=ymPef4iTz4pwXmiucXqN5I5eDAwjrFeu9hoNQXq44Rw=;
        b=hnfn6E4lfTOSltt5bmQhEAGWh0ykb5BT9hVu1F3gHnk1lzV8jh7PL2yUxTHTckDCK6
         OncENbg1GqyxK3Sa92CuJIulcp5qEJQR0/pGlYt/S55uMWA8e6nikqd7kjSsUa7u2G4Z
         cwSAhvbVSrY8gPIdyfsekefcy5siLVKbkzcu53i3pqf4b0Y2stCZ2EaDQim8deUjNzPn
         6EwdZXsh2OISYtbQJUJ/NPwvjvrP6nbxC4THJF7gww2rkHFgCxY2OLB4NPVNgWnfpuJx
         75SzsvvpcVQXsm+n2NpzAX74WCETGG+92vuG1Jm6Of9gYrqPR2hxfOh0TuHwoZh8Dr1L
         +zxA==
X-Received: by 10.194.19.3 with SMTP id a3mr2704114wje.54.1374009536293;
        Tue, 16 Jul 2013 14:18:56 -0700 (PDT)
Received: from [192.168.1.3] (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id h8sm5273235wie.1.2013.07.16.14.18.54
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 16 Jul 2013 14:18:55 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130623 Thunderbird/17.0.7
In-Reply-To: <6BDA2E3E7318418BBB2C19B475B2B118@PhilipOakley>
X-Enigmail-Version: 1.4.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230585>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig62CC7940A7ED28BF3EC28CA1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 07/16/2013 10:53 PM, Philip Oakley wrote:
> From: "Jeff King" <peff@peff.net>
> Sent: Tuesday, July 16, 2013 7:21 AM
>> On Tue, Jul 16, 2013 at 07:57:20AM +0200, Johannes Sixt wrote:
>>
>>> Am 7/15/2013 19:31, schrieb Ramsay Jones:
>>> > Sparse issues three "Using plain integer as NULL pointer" warnings.=

>>> > Each warning relates to the use of an '{0}' initialiser expression
>>> > in the declaration of an 'struct object_info'.
>>>
>>> I question the value of this warning. Initialization with '=3D {0}' i=
s
>>> a
>>> well-established idiom, and sparse should know about it. Also, plain
>>> 0
>>> *is* a null pointer constant.
>>
>> I agree with you. It's not a bug, and I think sparse is being overly
>> picky here; it is missing the forest for the trees in interpreting the=

>> idiom.
>>
>> Still, it may be worth tweaking in the name of eliminating compiler
>> noise, since it does not cost us very much to do so (and I believe we
>> have done so in the past, too).
>>
>> We could also ask people with sparse to turn off the "use NULL instead=

>> of 0" warning, but I think it _is_ a useful warning elsewhere (even
>> though it is never a bug, it violates our style guidelines and may be
>> an
>> indication of a bug). It would be nice if sparse learned to ignore the=

>> warning in this particular idiom, but I am not going to hold my breath=

>> for that.
>>
>> -Peff
>> --=20
>=20
> On the subject of warnings and null pointers, yesterday's Code Project
> news linked to a blog on the problems of unexpected optimization bugs,
> such as dereferencing a null pointer. "Finding Undefined Behavior Bugs
> by Finding Dead Code" http://blog.regehr.org/archives/970 which links t=
o
> the draft of an interesting paper
> [http://pdos.csail.mit.edu/~xi/papers/stack-sosp13.pdf]
>=20
> Does anyone run the "new static checker called 'Stack' that precisely
> identifies unstable code"? [though the paper's conclusion says 'All
> Stack source code will be publicly available.' which suggests it's not
> yet available]
>=20
> Or use the =E2=80=98-fno-delete-null-pointer-checks=E2=80=99 referred t=
o in the blog
> comments (see also index : kernel/git/torvalds/linux.git "Add
> '-fno-delete-null-pointer-checks' to gcc CFLAGS"
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/=
?id=3Da3ca86aea507904148870946d599e07a340b39bf
>=20
>=20
> You're probably already aware of these aspects but I thought it worth
> mentioning for the wider readership.
>=20
> regards
>=20
> Philip
>=20
>=20

I recently started contributing and I used cppcheck found at
https://github.com/danmar/cppcheck to submit the patches
at origin/sb/misc-fixes
As it is originally for C++, that tool throws lots of
false-positives (i.e. warns about null pointer dereferencing
when it's not possible to be a null pointer) unfortunately.

Also I hear llvm/clang comes with a good static code analyzer,
which I tried today on a different project.
Though I could not figure out how to use that on a pure C project
such as git, as that tool seems to require a C++ compilation for
doing its static code analysis.

The blog post you linked to seems very interesting and promising. :)

Regards,
Stefan



--------------enig62CC7940A7ED28BF3EC28CA1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJR5bi9AAoJEJQCPTzLflhqb6kP/20YSIZLRrHWQoMNvtMWsGg9
44SmsySzfGqrtgJr79R0cWHrK3d3rk51O6qQ5HSxdCepwKKg1W5b5AuXNZcC0uTw
X9tLLgHc3289dPeEwpbVBK5fAJwJ5hntEd8yYx2cW4gEUmiQDmaCKNheXNGCR0nn
WN9H8sE0sY62Qpz3toLileyWr5gYpl294ksM5EQkqb2U/4SFPtdXQRYG8OGaRHng
/aB4DqaqpYPYTYjqfw92C0Axa081cak+XVcl89rJtJeWJK1PH2zLnzXrHm5v3ZdT
ePsYe9mG18W9U5OuaWZn634XLt8caAQd02lWSZT5v7bkTSvpdb3o1/fcBHWiRU9Z
1+TpWRgT2fJCD46WeDRHQrPQelA/XlUnWH5GaVOQ7r8i8yS6BKbhWgv1EvehVdVk
XMceARfd2JRYCk61+uw4BoAYNC+dORTo7KiWBu64MSA8aBM3GSyKC8G79sYTC7Th
GOth9eboRd8P687PfhfGavIYdO0V6/cb0JR43wY2dOQXYEWK7lwRZxgypcS+hsPQ
tOp29MxM9t+ABcV7fecjM/qL8PUTsuWcDdRivGN3FAB5WyVJqlfO6Rt/5CRcVVDO
FWIziVRTzNRq7pKJ4aK+S2Dgnyfs/3qpYXGtAz14nk2MqOhsM4c8i7evuWpNJX55
phSsOvuDB2FBIgK+BVZ1
=58ro
-----END PGP SIGNATURE-----

--------------enig62CC7940A7ED28BF3EC28CA1--
