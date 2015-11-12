From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH] http: fix some printf format warnings on 32-bit builds
Date: Thu, 12 Nov 2015 11:58:58 +0000
Message-ID: <56447F02.2000105@ramsayjones.plus.com>
References: <56428A6A.5010406@ramsayjones.plus.com>
 <CAPig+cR+jXgw7+kUK9vrZxNbytwyK3gzgm1YPf_6s57_UxPaBA@mail.gmail.com>
 <56437F3F.7050305@ramsayjones.plus.com>
 <CAPig+cS54yTsZ8NWjyh6kj6nXy966EkYPHh_sjMbMcDGemnFuA@mail.gmail.com>
 <5643ABF0.5080207@ramsayjones.plus.com> <5644232C.2060700@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
	Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu Nov 12 12:59:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZwqX5-0004hT-As
	for gcvg-git-2@plane.gmane.org; Thu, 12 Nov 2015 12:59:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754146AbbKLL7K convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Nov 2015 06:59:10 -0500
Received: from avasout01.plus.net ([84.93.230.227]:32999 "EHLO
	avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753876AbbKLL7J (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Nov 2015 06:59:09 -0500
Received: from [10.0.2.15] ([146.199.93.105])
	by avasout01 with smtp
	id gbz41r0032GQ2gJ01bz5sm; Thu, 12 Nov 2015 11:59:07 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=MbeRwMLf c=1 sm=1 tr=0
 a=SWxm+s7FAPvPP0IAAWI2og==:117 a=SWxm+s7FAPvPP0IAAWI2og==:17 a=0Bzu9jTXAAAA:8
 a=EBOSESyhAAAA:8 a=IkcTkHD0fZMA:10 a=kXoeVqkTA2PPXVXe58kA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <5644232C.2060700@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281218>



On 12/11/15 05:27, Torsten B=C3=B6gershausen wrote:
>>Ah. OK, so %ld for long and %lld for long long, I suppose.
> Only if you have a system that's support it.
>=20
> Linux does, Windows not.

Sure, but I was speculating specifically about Eric's mac (which I
have no experience with).

>=20
>> Hmm, not that it matters, but I wonder what the PRId64 macro is. ;-)
> It's "I64d" for Windows, and "lld" for all Gnu based systems and othe=
rs,

[On Gnu systems, I believe it is %lld on 32-bit and %ld on 64-bit.]

Again, I was commenting on Eric's mac, which _seems_ to allow
the use of both %ld and %lld when printing 64-bit integers, so
which does it choose for PRId64 ...

>=20
> When you do printf("%lld %ld", long_long_var, long_var),
> the "printf runtime" under Windows will treat "%lld" as "%ld", and pr=
int
> the lower part of long_long_var.
> And will not pull a long long from stack, but a long, resulting i all=
 kinds of confusion
>=20
> So whenever a long long is printed, I can warmly recommend to use
>=20
> PRId64

Indeed.

ATB,
Ramsay Jones
