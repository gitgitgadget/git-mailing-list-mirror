From: Luis Henriques <henrix@camandro.org>
Subject: Re: no-xmailer tests fail under Mac OS
Date: Thu, 11 Dec 2014 22:35:50 +0000
Message-ID: <87h9x124s9.fsf@camandro.org>
References: <CAO2U3Qg3KsjvWJFza4MfiQDa2LbCpOy1Nxf9Vt3NSgXc7Bee9g@mail.gmail.com>
	<20141206053434.GF31301@peff.net>
	<CAO2U3QjkJRPrFvapK=LDU_GG5Ne6_zVD+S61JP+iV_Xi-gk5JQ@mail.gmail.com>
	<20141206063245.GA5966@peff.net>
	<CAO2U3QgDMpKwqsjzPNECpJw4z+WbboX5ug7Shu5v5ZCuPsKuGQ@mail.gmail.com>
	<20141206071234.GA6850@peff.net>
	<xmqq1to5et1j.fsf@gitster.dls.corp.google.com>
	<20141211221339.GA9478@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Blume <blume.mike@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Dec 11 23:36:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XzCL7-0003mJ-EA
	for gcvg-git-2@plane.gmane.org; Thu, 11 Dec 2014 23:36:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758924AbaLKWf7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Dec 2014 17:35:59 -0500
Received: from haggis.mythic-beasts.com ([93.93.131.56]:55164 "EHLO
	haggis.mythic-beasts.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757793AbaLKWf6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Dec 2014 17:35:58 -0500
Received: from [217.129.142.138] (port=62109 helo=localhost)
	by haggis.mythic-beasts.com with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA1:128)
	(Exim 4.80)
	(envelope-from <henrix@camandro.org>)
	id 1XzCKw-0004WO-Go; Thu, 11 Dec 2014 22:35:55 +0000
In-Reply-To: <20141211221339.GA9478@peff.net> (Jeff King's message of "Thu, 11
	Dec 2014 17:13:39 -0500")
X-BlackCat-Spam-Score: -28
X-Mythic-Debug: Threshold =  On = 
X-Spam-Status: No, score=-2.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261298>

Jeff King <peff@peff.net> writes:

> On Thu, Dec 11, 2014 at 02:11:04PM -0800, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>>=20
>> > On Fri, Dec 05, 2014 at 11:07:37PM -0800, Michael Blume wrote:
>> >
>> >> > Ah, right, we might be looking for 0 sometimes. The right way t=
o do it
>> >> > without destroying the &&-chaining is:
>> >> >
>> >> >   { grep ^X-Mailer: out || true } &&
>> >> >   test_line_count =3D $expected mailer
>> >>=20
>> >> Hmm, it doesn't look like that helper is &&-chained though? So it
>> >> seems like we could just do without the &&
>> >
>> > You're right, but that is IMHO a bug. We would not notice if send-=
email
>> > or format-patch barfed, and we are expecting to find no X-Mailer (=
we
>> > wouldn't, but for the wrong reason).
>>=20
>> Let me patch this up further by amending the SQUASH??? at the tip.
>>=20
>>  t/t9001-send-email.sh | 11 +++++------
>>  1 file changed, 5 insertions(+), 6 deletions(-)
>> [...]
>
> Yeah, looks good to me.
>
> -Peff

Same here.  Thanks a lot for fixing this.

Cheers,
--
Lu=C3=ADs
