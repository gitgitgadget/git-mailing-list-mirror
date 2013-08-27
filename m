From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH/RFC] core.precomposeunicode is true by default
Date: Tue, 27 Aug 2013 21:34:09 +0200
Message-ID: <521CFF31.9070607@web.de>
References: <201307270321.32398.tboegi@web.de> <7vmwp5z3iu.fsf@alter.siamese.dyndns.org> <521CAD88.4080609@web.de> <xmqqvc2rfau9.fsf@gitster.dls.corp.google.com> <521CC07B.4000504@web.de> <xmqqhaebdrp6.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 27 21:34:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEP1s-0003xA-GK
	for gcvg-git-2@plane.gmane.org; Tue, 27 Aug 2013 21:34:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753688Ab3H0TeM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Aug 2013 15:34:12 -0400
Received: from mout.web.de ([212.227.17.12]:62975 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752726Ab3H0TeM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Aug 2013 15:34:12 -0400
Received: from [192.168.209.26] ([195.67.191.23]) by smtp.web.de (mrweb102)
 with ESMTPA (Nemesis) id 0MJCSM-1VCk4R3n5e-002mDA for <git@vger.kernel.org>;
 Tue, 27 Aug 2013 21:34:10 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
In-Reply-To: <xmqqhaebdrp6.fsf@gitster.dls.corp.google.com>
X-Provags-ID: V03:K0:syFzrHIabEK6skaU3JXZabbziJIHfzjuSWeNZiKstJ++8uK74hi
 HLLdLrwaJnkOVYVheM/zFKPs+M3a9SnoFDt5iABeqf+ncnH5RfFswzRDNE/dzhFYR3tneA/
 Z6eUZ6CzsnFRFyclgijlyeo+NO4tLOFahnWoyrSgYUgsuaZw8QaHsseTgT9livTKaWV8vHp
 tyGpyYVxSj9qmilQo7ORw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233145>

On 2013-08-27 18.27, Junio C Hamano wrote:
> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>=20
>>>> 2)
>>>> When we access a repo from Windows/Linux using SAMBA,
>>> You mean s/repo/repository that resides on HFS+/?
>> Sorry being unclear here, trying being clearer with an example:
>> I have a /data/Docs on my linux box, which is handled by git
>>
>> I export /data/Docs via SAMBA, and use the Finder under Mac OS to ha=
ve it
>> mounted on my Mac OS X box:
>> //tb@Linux/Docs on /Volumes/Docs (smbfs, nodev, nosuid, mounted by t=
b)
>>>> readdir() will return decomposed.
>>>> When the repo is created by nonMacOS, core.precomposeunicode is un=
defined.
>>>> The precomposition is off, but should be on,=20
>>>> precomposed_unicode =3D -1, but should be =3D 1
>>> I do not think UTF-8-MAC is widely available; even if you flip the
>>> bit on, would it help much?
>> In the above example
>> /data/Docs/.git/config was created by Linux, so it does not have
>> core.precomposeunicode set, neither false nor true.
>> The Linux box does not have  UTF-8-MAC under iconv,
>> but will ignore core.precomposeunicode anyway (since the code is not=
 compiled here)
>>
>> The Mac OS machine sees it under /Volumes/Docs/.git/config
>> And here we want the precomposition, even if core.precomposeunicode
>> is not present in the config.
>=20
> It almost makes me wonder if you want not a per-repository but a
> per-machine configuration, i.e. "Whichever repository I am
> accessing, either on a local filesystem or shared over the network,
> readdir() on my box reports wrong paths, and I need correction."
>=20
> That, or "if it hurts, don't do the remote mount then."
No, we don't need to be that restrictive.
We already have repository/user/system wide configuration files,
allowing tweeks and this is a good thing.

Re-Re-reading $gmane/188940:=20
I am happy having the V2 patch from today being queued, thanks.

As a next step I will have a look into the advice machine.
=20
