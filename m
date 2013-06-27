From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [RFC/PATCH 0/1] cygwin: Remove the Win32 l/stat() functions
Date: Thu, 27 Jun 2013 17:19:14 +0200
Message-ID: <51CC57F2.8010805@web.de>
References: <51C5FD28.1070004@ramsay1.demon.co.uk> <51C7A875.6020205@gmail.com> <7va9mf6txq.fsf@alter.siamese.dyndns.org> <51C9EE26.9010006@kdbg.org> <7vppv928jx.fsf@alter.siamese.dyndns.org> <51CAF863.4020803@web.de> <51CB62FC.4070001@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>, dpotapov@gmail.com,
	Mark Levedahl <mlevedahl@gmail.com>, mhagger@alum.mit.edu,
	Jeff King <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Thu Jun 27 17:19:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UsDyp-0006g2-DP
	for gcvg-git-2@plane.gmane.org; Thu, 27 Jun 2013 17:19:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752227Ab3F0PTX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 Jun 2013 11:19:23 -0400
Received: from mout.web.de ([212.227.15.3]:52774 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751569Ab3F0PTX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Jun 2013 11:19:23 -0400
Received: from [192.168.209.26] ([195.67.191.23]) by smtp.web.de (mrweb101)
 with ESMTPA (Nemesis) id 0Lh6UN-1UW65t2uj1-00oZOk; Thu, 27 Jun 2013 17:19:16
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:17.0) Gecko/20130509 Thunderbird/17.0.6
In-Reply-To: <51CB62FC.4070001@ramsay1.demon.co.uk>
X-Provags-ID: V03:K0:hC9DCUX8cqrN3HZcmBBKtB5w5pjKK3mu4ANpJ8mWawM6Xqs9Cfh
 jXWxl7kJUeppmiasmf1IUcYQE/h3BCetyaVL+Q69sspWFYAQVK+oXvh0bl3VpADn+PuoVv5
 HoPDQNFXzO5I67nKoV+VHYgtRCJ7gmrDi4IxLHzgREcY++5lkRGanvmco7ITWrdGnZTH+c3
 pzZDDRWPino8D8Qh+jq/g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229109>

On 2013-06-26 23.54, Ramsay Jones wrote:
> Torsten B=F6gershausen wrote:
>> On 2013-06-25 23.18, Junio C Hamano wrote:
>>> Johannes Sixt <j6t@kdbg.org> writes:
>>>
>>>> Some context: This is about a patch by Ramsay that removes the
>>>> "schizophrenic lstat" hack for Cygwin. Junio, can you please queue=
 that
>>>> patch in pu?
>>>
>>> Sure.  Thanks.
>>
>> First of all,
>> thanks for the work.
>>
>> Here some "benchmark" results,=20
>> (The test run of the test suite did the same amout of time).
>=20
> The test suite runs noticeably faster for me.
>=20
>>
>> But:
>> git status -uno in real life takes double the time,
>> git 1.8.3 compared against "pu with the vanilla l/stat"
>>   =20
>>     1 second ->  2 seconds on linux kernel
>> 0.2 seconds -> 0.4 seconds on git.git=20
>=20
> Hmm, OK, I guess I will have to try something else. Sigh :(
>=20
>> Do we have any known problems with the current implementation ?
>=20
> Yes. The next branch is currently broken. (see reply to Junio)
>=20
>> Does speed matter ?
>>
>> One vote to keep the special cygwin functions.
>> (And have a look how to improve the core.filemode)
>=20
> I don't understand this (parenthetical) comment; could you
> elaborate on this.
>=20
> ATB,
> Ramsay Jones
This is probably wrong information:
I had in mind that cygwin sets core.filemode=3Dfalse,
which is quite annoying when exchanging .sh files with linux.
But that seems to be wrong, a quick test shows that core.filemode=3Dtru=
e.
Sorry for confusion.
