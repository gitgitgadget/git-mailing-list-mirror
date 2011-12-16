From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] attribute "eol" with "crlf"
Date: Fri, 16 Dec 2011 15:24:21 -0800
Message-ID: <7v39ckgkwq.fsf@alter.siamese.dyndns.org>
References: <CAN0XMO+OOdTJ+aNMSc2G3RVc7Wfypr4+7dU3US9GVAmMiSJ7cg@mail.gmail.com>
 <vpqr504wf70.fsf@bauges.imag.fr> <7vmxasgqlm.fsf@alter.siamese.dyndns.org>
 <CAN0XMOL674Hw_LctTC+8NNqA84Of6dMjdKT0SU+DWMG7EYShYQ@mail.gmail.com>
 <7vehw4go0v.fsf@alter.siamese.dyndns.org>
 <CAN0XMOKts7UR6eSYWA9-xj-YCpprvhbqwfdbq4U6Hfrn0nUONQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git <git@vger.kernel.org>
To: Ralf Thielow <ralf.thielow@googlemail.com>
X-From: git-owner@vger.kernel.org Sat Dec 17 00:24:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rbh8g-0002tw-6G
	for gcvg-git-2@lo.gmane.org; Sat, 17 Dec 2011 00:24:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752090Ab1LPXY0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Dec 2011 18:24:26 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63743 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750898Ab1LPXYY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Dec 2011 18:24:24 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3FE60589C;
	Fri, 16 Dec 2011 18:24:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=xDdUimQ/jm4H
	AsD5h4sB2n5pA2Y=; b=gqhF3Lloim+IgmEQlfBdWwds+2R+s2bCYvk5ciUGo3VM
	4EbJ9j4eb2cUEUehC4mAm+8MLvKMvYfPC83FfkQe+5MCFkRvVi4PeVKKOXBDQAyV
	32jPmHwKxhJZ9qIIr5OE8AQh8uWLYLkATNdmxKP/Ws07D3y+6wCkefdDCFx8kZ8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=QuCQsM
	rUeiTMhVsoa1gJ9vdEwuWgPxD6XAAkijFYBlSLwz2elWZJO0KnzwCIOBoeeyuIYw
	MsmJQiSkfDJmPoUneLBUaD9hNrLhDQmWIYDlzAKGSbFpofA/yC3ZfU3ZzYNSatUO
	2Qqo7URWeI6gYRceaFZfNu0EVOhD5DghfBI80=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 377675892;
	Fri, 16 Dec 2011 18:24:23 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B7E645891; Fri, 16 Dec 2011
 18:24:22 -0500 (EST)
In-Reply-To: <CAN0XMOKts7UR6eSYWA9-xj-YCpprvhbqwfdbq4U6Hfrn0nUONQ@mail.gmail.com> (Ralf
 Thielow's message of "Fri, 16 Dec 2011 23:36:07 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1627B146-283D-11E1-9CCC-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187334>

Ralf Thielow <ralf.thielow@googlemail.com> writes:

> Basicly I want to force the line endings of the files on my
> project. :/

You need to fix the data you have recorded with CRLF in the repository =
if
you are using eol=3Dcrlf, which means "This file wants to ..." (see bel=
ow; I
do not want to type the same thing again).

> 2011/12/16 Junio C Hamano <gitster@pobox.com>:
>> Ralf Thielow <ralf.thielow@googlemail.com> writes:
>>
>>> So i have to commit ".gitattributes" and everything is fine for me =
after!?
>>
>> No. =C2=A0Sorry if I was unclear, but I do not see which part was un=
clear in
>> what I wrote, so...
>>
>>>> The sequence adds "test\r\n" file without .gitattributes to have t=
he
>>>> repository record that exact byte sequence for the file. But then =
later
>>>> goes around and says "This file wants to express the end of line w=
ith CRLF
>>>> on the filesystem, so please replace LF in the repository represen=
tation
>>>> to CRLF when checking out, and replace CRLF in the working tree to=
 LF when
>>>> checking in".
>>>>
>>>> So it is not surprising that "\r\n" coming from the repository is =
replaced
>>>> to "\r\r\n" when checked out. As far as the repository data is con=
cerned,
>>>> that line has a funny byte with value "\r" at the end, immediately=
 before
>>>> the line terminator "\n".
>>>>
>>>> What you said is _technically_ correct in that sense.
>>>> ...
