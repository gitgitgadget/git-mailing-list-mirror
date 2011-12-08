From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Dec 2011, #02; Mon, 5)
Date: Thu, 08 Dec 2011 10:19:16 -0800
Message-ID: <7vzkf3hqor.fsf@alter.siamese.dyndns.org>
References: <7v8vmqi98f.fsf@alter.siamese.dyndns.org>
 <CALkWK0mpPoZJWviBesWgy2dZ4xJrNyhED2znFid8iGbSTirPhQ@mail.gmail.com>
 <7vliqph8a6.fsf@alter.siamese.dyndns.org>
 <CALkWK0nNtvrLHxQv17jfrFQ=BcwLfgh7eE9X-nDCCYY0nsOskg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 08 19:19:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYiZ2-0003X8-LX
	for gcvg-git-2@lo.gmane.org; Thu, 08 Dec 2011 19:19:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753212Ab1LHSTU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Dec 2011 13:19:20 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45386 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752518Ab1LHSTT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Dec 2011 13:19:19 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C2C957BAD;
	Thu,  8 Dec 2011 13:19:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=iEZwo6eOIBJT
	9ItC41m2s9bOMA0=; b=ijLI9c4KWh+MxwgRgZGFTXM4MoNarc12FwGnEnXpJfy7
	YI/okQJV3LiO7WV3ZUiSHZnP/xXtEVqrMmzpftp5EdLx+lEyy7m8dvWvcFHZV6Ig
	gPEK1CF3PbrAaK0nodgmcKtH31WiHjqHxejiv6twHQk4GuEp6UWYUBeZJ78c7TY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=tLPndH
	2mRZG+fyY6m+lbfZWnVnG0hzzxwZHLb+NjjXgVQvFd/fPgKzBKSpMPdIoX6y81KO
	O3aMEZ/c7M2sUTPtNRraiTZZtCyINpaJOIgUIX2iMUbxbbJa7/NcePdYt8ZaZHfX
	APF65YK5Fx9F2ZTrleoeV5kNLsjnYrK8UVQqY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B77AE7BAC;
	Thu,  8 Dec 2011 13:19:18 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2D9E07BA8; Thu,  8 Dec 2011
 13:19:18 -0500 (EST)
In-Reply-To: <CALkWK0nNtvrLHxQv17jfrFQ=BcwLfgh7eE9X-nDCCYY0nsOskg@mail.gmail.com>
 (Ramkumar Ramachandra's message of "Wed, 7 Dec 2011 02:00:52 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 247A8644-21C9-11E1-87D1-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186583>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

>> =C2=A0* On "revert: make commit subjects in insn sheet optional"
>>
>> =C2=A0 After finding the verb and advancing the pointer "bol" at the=
 beginning of
>> =C2=A0 the object name, end_of_object_name variable points at the fi=
rst SP or LF
>> =C2=A0 using strcspn(bol, " \n"), but I wonder why we are not grabbi=
ng a run of
>> =C2=A0 hexdigits instead, i.e. strspn(bol, "0123456789abcdef"). Is t=
his so that
>> =C2=A0 we can allow something like "pick rr/revert-cherry-pick~3"?
>
> Yes, it is exactly for that reason :)

That is not explained in the commit message, which in itself is a probl=
em
that needs to be addressed, but ...

>> =C2=A0 I also wonder if this should be (sorry for pcre) "(pick|rever=
t)\s+(\S+)\s"
>> =C2=A0 instead, i.e. allow users with fat fingers to use one or more=
 SP or even HT
>> =C2=A0 to separate the verb and the operand.
>
> Hm, I'm not too enthusiastic about this change, because we don't
> advertise hand-editing the instruction sheet yet:...

=2E.. is inconsistent with the above.

If you plan to later allow editing and if you know what kind of editing
you are going to allow, it would be better to prepare the parser to acc=
ept
input with a reasonable slack, especially because you are already touch=
ing
it in this series anyway.

On the other hand, if you do not want to think about (or do not want us=
 to
get distracted by thinking about) allowing editing in this series, whic=
h
is also a sensible stance to take, the parser should be made to accept
only what the mechanism in the series would produce and error out
otherwise, leaving the entire "the user now can edit and here are the r=
ules"
part for a separate series that comes after this series is perfected.

>> =C2=A0* On "revert: allow mixed pick and revert instructions"
>>
>> =C2=A0 Reporting what we did not understand from parse_insn_line() i=
s a good
>> =C2=A0 idea, but I think the line number should be reported at the b=
eginning
>> =C2=A0 of the same line.
>
> Makes sense.  Do you like this?

Not particularly.

> -		return error(_("Unrecognized action: %.*s"), (int)len, bol);
> +		return error(_("Line %d: Unrecognized action: %.*s"),

It may be just me, but personally I prefer to see which file of what li=
ne
had the problem, i.e. "%s:%d: Unrecognized action:%s".

But if there is not much point in reporting the filename because it alw=
ays
is the same, "Unrecognized action (line %d): %s" would also be fine.
