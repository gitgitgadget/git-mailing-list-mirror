From: Oliver Busch <oliver.busch@arc-aachen.de>
Subject: Re: Bug report: Author/Commit date in ISO 8601 format
Date: Tue, 26 Aug 2014 15:14:43 +0200
Message-ID: <53FC8843.3030309@arc-aachen.de>
References: <53FC3768.3090905@arc-aachen.de> <20140826130610.GG29180@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Aug 26 15:14:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMGaI-0003tp-OG
	for gcvg-git-2@plane.gmane.org; Tue, 26 Aug 2014 15:14:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758142AbaHZNOq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Aug 2014 09:14:46 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:61962 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754695AbaHZNOp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2014 09:14:45 -0400
Received: from [192.168.43.193] ([194.8.202.70])
	by mrelayeu.kundenserver.de (node=mreue104) with ESMTP (Nemesis)
	id 0LnSda-1WfnUy0xqQ-00heAJ; Tue, 26 Aug 2014 15:14:42 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.0
In-Reply-To: <20140826130610.GG29180@peff.net>
X-Provags-ID: V02:K0:7XPOwvPuVgqpVplZhJim8nTZAWATUDv6/3FCr2I5RwR
 EYXDPj8eOfDmUG7bwe2Vg+rPhANgnJNsHDLaNM0sjuB6xkoicO
 NIvlO8NOgwCdTdTzQi9F3XvOyB5eJmnBujHMotL0CbMz3BxGcV
 ilFnBBbHOWBd62e3x9NhLTzCG0Eeshejm0dWNFL2Dg/9lgouyb
 UiAuefFo1nBEQU0QjLYxSYBY8JoUo2CaYurb3mOl4ZxGIgyaQR
 WWbqud6lgtwDv7p7/767MKcgRra8jmqnTExvXcMAXFsT8Wi5jQ
 dAVZm8CHNc8Ac0vbzcee3EFImcYrAKnYIMqptZv1jY4XsM26ml
 qkfi6E0Ue++Don9I61lzqSQE7qZr68H15UCoxrtvH
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255901>

Peff is right, I did not think of backwards compatibility issues. I=20
believe a new option like "iso-strict" as he suggested will do the tric=
k=20
(and I'm probably not the only one to appreciate its implementation...)=
=2E

Regards,

Oliver

Am 26.08.2014 um 15:06 schrieb Jeff King:
> On Tue, Aug 26, 2014 at 09:29:44AM +0200, Oliver Busch wrote:
>
>> I encountered the following problem: When using the date formatting =
option
>> ISO (either by setting --date=3Diso or using format:%ci for the comm=
itter
>> date), the output is formatted like this:
>>
>> 2014-08-25 17:49:43 +0200
>>
>> But according to ISO 8601, should be formatted like this (see
>> http://www.w3.org/TR/NOTE-datetime):
>>
>> 2014-08-25T17:49:43+02:00
> Yeah, it is not strictly ISO but more ISO-like (to further add
> confusion, it is mostly RFC3339, which claims to be a "profile of
> ISO8601". But we don't follow the timezone conventions there. Yeesh).
>
> Interestingly, this actually came up when the feature was added:
>
>    http://thread.gmane.org/gmane.comp.version-control.git/52414/focus=
=3D52585
>
> but there was some discussion of ISO8601's weird phrasing of "T" bein=
g
> optional.
>
>> I therefore suggest to adapt the output when using --date=3Diso or
>> format:%ci to comply 100% with the ISO 8601 specs, or at least chang=
e
>> documentation to say the output is only "ISO-like".
> I think changing the output at this point would cause backwards
> compatibility problems (not to mention that it's a lot less readable =
for
> humans).
>
> Patches welcome for a documentation update. I also think something li=
ke
> --date=3Diso8601-strict might make sense for the case of feeding the
> result to another parser.
>
> -Peff
>


--=20

Oliver Busch, M.Eng.

Airport Research Center GmbH
Bismarckstra=C3=9Fe 61
52066 Aachen
Germany

Phone: +49 241 16843-161
=46ax: +49 241 16843-19
e-mail: Oliver.Busch@arc-aachen.de
Website: http://www.airport-consultants.com

Register Court: Amtsgericht Aachen HRB 7313
Ust-Id-No.: DE196450052

Managing Directors:
Dipl.-Ing. Tom Alexander Heuer
