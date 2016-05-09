From: Junio C Hamano <gitster@pobox.com>
Subject: Re: t6044 broken on pu
Date: Mon, 09 May 2016 11:26:22 -0700
Message-ID: <xmqqr3dbulyp.fsf@gitster.mtv.corp.google.com>
References: <7d747193-7ba1-e274-86dc-427ed0f124c9@web.de>
	<878tzmrrfg.fsf@linux-m68k.org>
	<d1fcc54b-ddd7-b03b-79fa-2112a3f43141@web.de>
	<xmqqa8k11e8j.fsf@gitster.mtv.corp.google.com>
	<5618208c-ce45-d65c-abf8-498cfe0f2f84@web.de>
	<xmqqoa8gza1t.fsf@gitster.mtv.corp.google.com>
	<CANgJU+V9+-hTFvDxCGbQxFcHMRcFaP-NdS_P93DqXuxi1Lh4mg@mail.gmail.com>
	<20160509083323.GB14299@sigill.intra.peff.net>
	<CAPig+cTyEU1gEwD5AuODkLzF--EOqo5_MQHD5QEFpb8dgh_wrw@mail.gmail.com>
	<20160509161226.GB11861@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	demerphq <demerphq@gmail.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Andreas Schwab <schwab@linux-m68k.org>, newren@gmail.com,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon May 09 20:26:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azpt0-0000lV-5u
	for gcvg-git-2@plane.gmane.org; Mon, 09 May 2016 20:26:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751207AbcEIS00 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2016 14:26:26 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55690 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750941AbcEIS0Z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2016 14:26:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 6EA0118C9D;
	Mon,  9 May 2016 14:26:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EjPQwFyxy3Vn6SKPSeEvWbyjTLA=; b=tGDSCr
	U2ZSqZJIgVZPx0tVL6AXn8fW16xLEdWKuwOT0i1t5pn3w1Qdec26UWIulU5KYupN
	/vZu0o/5Zlj+jAUnASeEB/O+7gh8iVu1g20GMNXI6cVRMx/2MnMixW2j2tFkMSVX
	wmJ9kURPOTDkU/jiIMKt9MatO9ADIkGdgt9KI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WMwuYUqvW4aOY4gxrcs7T+M6axnDkAqA
	8dzibUj9+KaoaW+CzgCZm4UFQmqPtmv0Ppdv0vmpWhv5oEh4s9JqTFDHEUAv2fkC
	2d4lENECLEbJpFV2n/NEvYiVviFumnQ7pG7fJMsONelkgg5EmXR3akZEK/krIZjp
	CNnGW9a/ebQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 671C418C9B;
	Mon,  9 May 2016 14:26:24 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E351718C9A;
	Mon,  9 May 2016 14:26:23 -0400 (EDT)
In-Reply-To: <20160509161226.GB11861@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 9 May 2016 12:12:27 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 88F6C00E-1613-11E6-BB1D-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294035>

Jeff King <peff@peff.net> writes:

> On Mon, May 09, 2016 at 12:02:45PM -0400, Eric Sunshine wrote:
>
>> > I had that thought, too, but I think it would be an error to do so.
>> > test_seq is supposed to be a replacement for "seq", which does not
>> > understand non-numeric sequences.
>> 
>> Although, the comment block just above test_seq() in
>> test-lib-functions.sh says otherwise:
>> 
>>     Print a sequence of numbers or letters in increasing order.  This
>>     is similar to GNU seq(1), but the latter might not be available
>>     everywhere (and does not do letters).  It may be used like:
>> 
>>     for i in $(test_seq 100)
>>     do
>>         for j in $(test_seq 10 20)
>>         do
>>             for k in $(test_seq a z)
>>             do
>>                 echo $i-$j-$k
>>             done
>>         done
>>     done
>
> Oh, indeed. I apparently even Acked that documentation once upon a time. :-/
>
> Anyway, I double-checked my earlier "grep" and I do not think anybody is
> using that functionality. So I think we'd be OK to change it as long as
> we updated the documentation to match.

Yes, I think the comment should just go.  Nobody used that alphabet
form since it was written in d17cf5f3 (tests: Introduce test_seq,
2012-08-04).

> I don't really care either way whether it is replaced or not (at one
> point there were some people really interested in NO_PERL not even using
> one-liners in the test suite, but I am not one of them).

Neither am I, but I think it is prudent to drop that "letters".  The
comment even says the letter form is not portable already, so the
mention of GNU seq(1) is not helping at all.
