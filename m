From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: What's cooking in git.git (Jul 2013, #09; Mon, 29)
Date: Sat, 03 Aug 2013 09:04:09 +0200
Message-ID: <51FCAB69.9010706@web.de>
References: <7vk3k9yol3.fsf@alter.siamese.dyndns.org> <51F94DFD.5020101@ramsay1.demon.co.uk> <7v4nbav9ys.fsf@alter.siamese.dyndns.org> <51FACA67.8090207@ramsay1.demon.co.uk> <51FCA820.9070907@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	mhagger@alum.mit.edu, mlevedahl@gmail.com,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>
To: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sat Aug 03 09:04:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V5VtC-0001fS-W1
	for gcvg-git-2@plane.gmane.org; Sat, 03 Aug 2013 09:04:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751033Ab3HCHEO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 3 Aug 2013 03:04:14 -0400
Received: from mout.web.de ([212.227.15.14]:49466 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750936Ab3HCHEN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Aug 2013 03:04:13 -0400
Received: from [192.168.209.26] ([195.67.191.23]) by smtp.web.de (mrweb102)
 with ESMTPA (Nemesis) id 0LmLc6-1UWj612bzu-00ZyJS for <git@vger.kernel.org>;
 Sat, 03 Aug 2013 09:04:12 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
In-Reply-To: <51FCA820.9070907@web.de>
X-Provags-ID: V03:K0:WvdUwyp7egG7MO/3/qonJc+74THnpDLsmeRA3SdWoQqOc19UonU
 zlK14ldf9Zkd88Zfra6O8cdg2frv+Hena9MbYDLVgp3mDlDmzHtWHJbRUWg5pbMtE1Nu2Ik
 EOgX7Q/R4nnqDYNcifw7UXD6kt2Mx1PmsUCe1H78ZVfHW+FR37oeVch5OU6VQ9uD2252nGU
 0++zeyvbQ7cC065O6U2hA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231566>

On 2013-08-03 08.50, Torsten B=F6gershausen wrote:
> On 2013-08-01 22.51, Ramsay Jones wrote:
>> Junio C Hamano wrote:
>>> Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:
>>>
>>>>>  I am personally in favor of this simpler solution.  Comments?
>>>>
>>>> I had expected this to me marked for 'master'.
>>>>
>>>> Has this simply been overlooked, or do you have reservations about
>>>> applying this patch?
>>>
>>> I am just being careful and do want to keep it cooking in 'next'
>>> during the feature freeze.  The more users work with 'next' (not
>>> "work *on* 'next'"), the more confidence we would be with, and
>>> hopefully this can be one of the topis that graduate early after
>>> the 1.8.4 release.
>>
>> Hmm, this patch is a bug-fix for a bug that (currently) will be
>> _introduced_ by v1.8.4.
>>
>> Do you want me to try and find a different bug-fix for v1.8.4?
>> (Although that would most likely be more risky than simply taking
>> this patch! ;-) ).
>>
>> ATB,
>> Ramsay Jones
>=20
> I just managed to run v1.8.4-rc1 under cygwin 1.7, and it all passed.
> Good work, thanks.
>=20
> I realized that core.filemode is true by default, which
> by default switches of the stat()/lstat() code in cygwin.c
>=20
> Which bug fix are we missing for v1.8.4 ?
> /Torsten

Oh, the problem is of course that users have existing repos
where core.filemode =3D false.

So I think we can and should remove compat/cygwin.[ch] without further
cooking, to be on the save side.

(Just to be sure: this is what we are talking about ?)
/Torsten
=20
