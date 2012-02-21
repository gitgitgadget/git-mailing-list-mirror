From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] completion: remote set-* <name> and <branch>
Date: Tue, 21 Feb 2012 14:23:11 -0800
Message-ID: <7v8vjvg71s.fsf@alter.siamese.dyndns.org>
References: <1329571973-20796-1-git-send-email-philip@foolip.org>
 <7vvcn2lyw6.fsf@alter.siamese.dyndns.org>
 <CAKHWUkZjQYnf=LwS_RC-E_7gV73AzbWjxs33E5-FL25s6_qX4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Teemu Likonen <tlikonen@iki.fi>
To: Philip =?utf-8?Q?J=C3=A4genstedt?= <philip@foolip.org>
X-From: git-owner@vger.kernel.org Tue Feb 21 23:23:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rzy7E-0005N3-Cy
	for gcvg-git-2@plane.gmane.org; Tue, 21 Feb 2012 23:23:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755787Ab2BUWXP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Feb 2012 17:23:15 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49436 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754454Ab2BUWXO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Feb 2012 17:23:14 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 63C987F2D;
	Tue, 21 Feb 2012 17:23:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=QDjHws3h2Lht
	qTTDtaDSlXgmDAQ=; b=rYvdkdFBoCeLuVV2cX0iwsTa15M0vjLE+OV1Zm3Lpgd9
	WuRf5/Lj9OKfRwUhb1+4LobeV15+SIrHDb1vyKFKEPBZU5GHVyray0zDBDSkvAtH
	OaRFTXRijo4oW4e0qJKeS2K3NGDkJx0xTQkdfLLqaafN9avQPmjaq+GuhvEbNuQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=emZvlt
	p7fKE4bnbd/8yWGctoSwIi0IVKBiJOSEcZWVr0GvLU0w7tDWQJoPCh8toqy5tuig
	HgK+HCDQQTYBAuwdbbyXLYe7UVp6QpHIDU6n9cSmHS3Q3tFPhO2MyOLBg0Qn4mW5
	XjeERLJGyb90wLIjB9wYn4cAhiDk7vyTtcVP8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 58AE47F2C;
	Tue, 21 Feb 2012 17:23:13 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AE5687F2B; Tue, 21 Feb 2012
 17:23:12 -0500 (EST)
In-Reply-To: <CAKHWUkZjQYnf=LwS_RC-E_7gV73AzbWjxs33E5-FL25s6_qX4g@mail.gmail.com> ("Philip
 =?utf-8?Q?J=C3=A4genstedt=22's?= message of "Tue, 21 Feb 2012 22:29:33
 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A451D470-5CDA-11E1-A961-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191190>

Philip J=C3=A4genstedt <philip@foolip.org> writes:

> Thanks. Perhaps git-completion.bash should not say "Send all patches
> to the current maintainer" and simply defer to SubmittingPatches?

I see you did this in your follow-up patch.  Thanks.

>>> =C2=A0{
>>> =C2=A0 =C2=A0 =C2=A0 local cur_=3D"$cur" cmd=3D"${words[1]}"
>>> =C2=A0 =C2=A0 =C2=A0 local i c=3D2 remote=3D"" pfx=3D"" lhs=3D1 no_=
complete_refspec=3D0
>>> + =C2=A0 =C2=A0 if [ "$cmd" =3D "remote" ]; then
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 c=3D$((++c))
>>> + =C2=A0 =C2=A0 fi
>>
>> I don't know about others, but auto-incrementing a variable and assi=
gning
>> the result to the same variable, while not wrong at all, hurts my br=
ain.
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0c=3D$(($c + 1))
>>
>> is far more readable and does not suggest there is any funky magic
>> involved. =C2=A0Also it is a good habit to get into not to omit $ fr=
om
>> variables inside arithmetic substitution, even though bash allows it=
 and
>> this script is meant to be consumed only by shells that understand t=
his
>> bash-ism.
>>
>> I do not know offhand if zsh groks it, but the point is that you do =
not
>> have to worry about it if you write "$(($c+1))" instead of "$((c+1))=
".
>
> CodingGuidlines suggests to follow local convention, which was
> "c=3D$((++c))". This file also uses "++n", "i++" and "((i++))". I wil=
l
> send a v2 patch that normalizes these, open to discussion of course.

OK, it was my mistake to suggest $c++ in this file; it liberally uses
dollar-less variables, and I agree that it is a good idea to stick to t=
hat
local convention.

But I think you went too far in your follow-up patch to make the increm=
ent
and decrement uniform.

"i++" is so much easier on the eye unless you must use "++i" in order t=
o
use the value of the incremented "i" in an expression, and the changes =
to
turn existing instances of free-standing "i++" to "++i" done only for t=
he
side effect of incrementing the variables look totally backwards.

Although I do not deeply care.  Just leaving the new one as you origina=
lly
wrote, i.e.

	c=3D$((++c))

would have been easier to review for the area experts, I would think.
