From: Max Horn <max@quendi.de>
Subject: Re: What's cooking in git.git (Mar 2014, #03; Fri, 14)
Date: Wed, 19 Mar 2014 13:32:13 +0100
Message-ID: <3CCB443D-D5CE-4C4B-910D-EC34115A695D@quendi.de>
References: <xmqqlhwcfn4a.fsf@gitster.dls.corp.google.com> <53240C0F.2050204@web.de> <xmqqha6wg3o1.fsf@gitster.dls.corp.google.com> <906CACC0-FB16-4BB8-812D-59067DE0CC89@quendi.de>
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Content-Type: multipart/signed; boundary="Apple-Mail=_9665B3DB-E0B1-49A3-9CBE-2B3BCA29CD36"; protocol="application/pgp-signature"; micalg=pgp-sha256
Cc: Junio C Hamano <gitster@pobox.com>,
	=?iso-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org, Antoine Pelisse <apelisse@gmail.com>
To: Max Horn <max@quendi.de>
X-From: git-owner@vger.kernel.org Wed Mar 19 13:32:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQFfR-0007uM-Ti
	for gcvg-git-2@plane.gmane.org; Wed, 19 Mar 2014 13:32:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964915AbaCSMcR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2014 08:32:17 -0400
Received: from wp256.webpack.hosteurope.de ([80.237.133.25]:48716 "EHLO
	wp256.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S964791AbaCSMcQ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Mar 2014 08:32:16 -0400
Received: from fb07-alg-gast1.math.uni-giessen.de ([134.176.24.161]); authenticated
	by wp256.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	id 1WQFfL-0007sc-7f; Wed, 19 Mar 2014 13:32:15 +0100
In-Reply-To: <906CACC0-FB16-4BB8-812D-59067DE0CC89@quendi.de>
X-Mailer: Apple Mail (2.1510)
X-bounce-key: webpack.hosteurope.de;max@quendi.de;1395232336;e6fcda51;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244438>


--Apple-Mail=_9665B3DB-E0B1-49A3-9CBE-2B3BCA29CD36
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=iso-8859-1


On 19.03.2014, at 11:53, Max Horn <max@quendi.de> wrote:

>=20
> On 17.03.2014, at 18:01, Junio C Hamano <gitster@pobox.com> wrote:
>=20
>> Torsten B=F6gershausen <tboegi@web.de> writes:
>>=20
>>> On 2014-03-14 23.09, Junio C Hamano wrote:
>>>> * ap/remote-hg-skip-null-bookmarks (2014-01-02) 1 commit
>>>> - remote-hg: do not fail on invalid bookmarks
>>>>=20
>>>> Reported to break tests ($gmane/240005)
>>>> Expecting a reroll.
>>> I wonder what should happen here.
>>> The change breaks all the tests in test-hg-hg-git.sh
>>> (And the breakage may prevent us from detecting other breakages)
>>>=20
>>> The ideal situation would be to have an extra test case for the =
problem
>>> which we try to fix with this patch.
>=20

[...]

> The (or at least "a") root cause has actually been discovered. Would a =
patch that adds an xfail test case for it be acceptable?
>=20
> As to the why the proposed patch causes test failures: I think this is =
due to the fact that remote-hg inserts a fake "master" branch (resp. =
"bookmark" in the hg terminology). Now, in those test cases, a hg =
repository gets created that actually contains a "null" bookmark named =
"master". When the proposed fix for the problem is added, this bookmarks =
gets ignored. But at that point, remote-hg already determined that there =
is a hg bookmark named "master", and adjusts how it works accordingly -- =
when we then remove that bookmarks, things go awry.
>=20
> But I might be wrong here, and in any case, did not yet have time to =
come up with a proper fix.

Actually, scratch that, I just came up with a fix, and also tests. Will =
submit shortly.

I'd still like to know whether it is OK to submit further patches with =
(x?)failing test cases?





--Apple-Mail=_9665B3DB-E0B1-49A3-9CBE-2B3BCA29CD36
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iF4EAREIAAYFAlMpjlEACgkQIpJVslrhe1kpKQEAsTsG1tZj95YZ70v/UIk3584i
z6PnoCv/kiQmSzYTUKkA/j/01pYC5dKDE3VPqYhuXcqe2y/D29fUlsQDcB+TjSHw
=HQ2i
-----END PGP SIGNATURE-----

--Apple-Mail=_9665B3DB-E0B1-49A3-9CBE-2B3BCA29CD36--
