From: =?UTF-8?B?w4FuZ2VsIEdvbnrDoWxleg==?= <ingenit@zoho.com>
Subject: Re: [PATCH] Remove "bashism" from contrib/thunderbird-patch-inline/appp.sh
Date: Wed, 30 Mar 2011 00:48:14 +0200
Message-ID: <4D9261AE.5070103@zoho.com>
References: <AANLkTin-USDnTxeKT_KOZW5kgC0vFXYbMNP9ct6fzbUC@mail.gmail.com> <4D9103D3.5010403@zoho.com> <7vei5qtnc5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 30 00:44:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4hdn-00060G-LH
	for gcvg-git-2@lo.gmane.org; Wed, 30 Mar 2011 00:44:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752170Ab1C2Wny convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Mar 2011 18:43:54 -0400
Received: from sender1.zohomail.com ([72.5.230.95]:32036 "EHLO
	sender1.zohomail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751683Ab1C2Wnx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2011 18:43:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type; 
  b=UThaVRr4LBciqgkmvI+52/z94lDZlGuS7rn18dY1bSsbz5aTTF8yUw9gNWmMPOL8UU0siLPjhDhe
    1dG/pyNlR8xTKq8Mah5NcFTybJc7lBqcXJQO2LsTuMFSkNW3wGKt  
Received: from [192.168.1.26] (7.Red-83-54-101.dynamicIP.rima-tde.net [83.54.101.7]) by mx.zohomail.com
	with SMTPS id 1301438632953718.461405822257; Tue, 29 Mar 2011 15:43:52 -0700 (PDT)
User-Agent: Thunderbird
In-Reply-To: <7vei5qtnc5.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170336>

Junio C Hamano wrote:
> =C3=81ngel Gonz=C3=A1lez <ingenit@zoho.com> writes:
>=20
>> This is wrong.
>=20
> Not really.
>=20
>> You are replacing bash with sh:
>>> -#!/bin/bash
>>> +#!/bin/sh
>>
>> but the script still uses bash-specific syntax (aka. bashishms):
>=20
> Do you mean some of the parts you quoted are bashism?

I was pointing to the $( ) as a bashishm

>>>  PATCH=3D$(zenity --file-selection)
>=20
> Even though ancient shells I grew up with did not have $(), it is a w=
ay
> backticks should have been written by Bourne from day one.  Historica=
lly,
> handling nesting and interraction between double-quotes and backticks
> correctly was a nightmare to get right, and different implementations=
 of
> shells got them always wrong.  If you use $(), the headaches go away.

> These days, we don't know of any POSIX shell that is widely used and =
does
> not understand $().  As such, the above construct is perfectly safe a=
nd
> even preferred over ``.  Welcome to the 21st century ;-)
>
> The only major platform that didn't have a reasonable shell was Solar=
is,
> but we already have written its /bin/sh off as broken and unusable, a=
nd
> suggest people to use xpg4 or xpg6 shell (see the Makefile).

I have to agree with you. $() is a much saner syntax. Still, the goal
was portability.
Reading your message, and considering the Solaris note, it might have
been fine as it was. I have also checked the "Shell Command Language"
section of IEEE Std 1003.1 and it does require $() use.

Albeit being a single line I would still change it, it is now a much
weaker position. Thanks for your insight.
