From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH] unpack-trees.c: check return value of lstat()
Date: Mon, 07 Mar 2011 16:59:10 +0100
Message-ID: <4D7500CE.8000106@web.de>
References: <201103062013.52793.tboegi@web.de>	<vpqfwr0hwu0.fsf@bauges.imag.fr> <4D73E577.1010604@web.de> <vpqpqq4ge71.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	drizzd@aon.at, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Mar 07 16:59:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pwcq7-0000ax-8T
	for gcvg-git-2@lo.gmane.org; Mon, 07 Mar 2011 16:59:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753307Ab1CGP7N convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Mar 2011 10:59:13 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:49355 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750881Ab1CGP7N (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Mar 2011 10:59:13 -0500
Received: from smtp05.web.de  ( [172.20.4.166])
	by fmmailgate01.web.de (Postfix) with ESMTP id 5505618A94A9F;
	Mon,  7 Mar 2011 16:59:11 +0100 (CET)
Received: from [213.64.3.195] (helo=birne.lan)
	by smtp05.web.de with asmtp (WEB.DE 4.110 #2)
	id 1Pwcpy-0005tE-00; Mon, 07 Mar 2011 16:59:11 +0100
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
In-Reply-To: <vpqpqq4ge71.fsf@bauges.imag.fr>
X-Sender: tboegi@web.de
X-Provags-ID: V01U2FsdGVkX19PaOf0uyNsG2zkigjyjRATyVxwVlpVMMKfE8tg
	mirN0JPxkkyvkZadbS+Trj3+2OQztje6VXrpODHRxYlfAJMgjn
	Ztfugs9DQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168593>

On 06.03.11 21:57, Matthieu Moy wrote:
> Torsten B=F6gershausen <tboegi@web.de> writes:
>=20
>> On 06.03.11 20:29, Matthieu Moy wrote:
>>> Torsten B=F6gershausen <tboegi@web.de> writes:
>>>
>>>> +		if (!lstat(path, &st))
>>>> +			return check_ok_to_remove(path, len, DT_UNKNOWN, NULL, &st,
>>>> +			                          error_type, o);
>>>>  	} else if (!lstat(ce->name, &st))
>>>
>>> What happens if lstat returns a non-0 value?
>> The result of "st" is 100% garbage, and should not be passed to
>> anybody.
>=20
> With your code, you don't do a return, you'll reach the end of the
> function without calling return, which is probably the worst thing yo=
u
> could expect.
>=20
>> v1.7.4 says:
>> commit e39212ab08e8d37dda5d8fd32b54099fe01dbbdb
>> Merge: 716958c 9e08273
>=20
> You've cut the date:
>=20
> commit e39212ab08e8d37dda5d8fd32b54099fe01dbbdb
> Merge: 716958c 9e08273
> Author: Junio C Hamano <gitster@pobox.com>
> Date:   Wed Dec 22 14:40:26 2010 -0800
>=20
> =3D> no big surprise that you don't see the bugfix from Jan 12th.
>=20
>>> Anyway, this seems to have been fixed by a93e53018 (Wed Jan 12 20:2=
8:09
>>> 2011, unpack-trees: handle lstat failure for existing file) already=
=2E
>=20
> Did you look at the content of this commit?
>=20
>> (And I had to correct drizzd@aon.a -> drizzd@aon.at)
>=20
> Yes, because you've mis-spelled it in the first place and I didn't fi=
x
> it ;-).
>=20

Ojojo,
While working with the best tracking tool, I lost tracking myself.
That's why I missed Jonathans fix and learned today 9e08273 !=3D a93e53=
018
Thanks for the patience, (and sorry for the noise)
/Torsten
