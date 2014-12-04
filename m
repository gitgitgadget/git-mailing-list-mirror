From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] introduce git root
Date: Thu, 04 Dec 2014 12:19:53 -0800
Message-ID: <xmqqr3wfrwuu.fsf@gitster.dls.corp.google.com>
References: <1417291211-32268-1-git-send-email-arjun024@gmail.com>
	<2AC7B765F56B4AA8A0DB76E8C670A889@PhilipOakley>
	<CAJFMrCEciWXhBb36MVeFPi7Y7D=9zQ2xGPpiyUz9y4_hOh_taw@mail.gmail.com>
	<vpqoaro99xd.fsf@anie.imag.fr>
	<xmqqd284rryz.fsf@gitster.dls.corp.google.com>
	<CAP8UFD2jES1i+6zOt1gXqTWFy1UHu2GBwAisQktd_Ymbj9Db2g@mail.gmail.com>
	<20141202070415.GC1948@peff.net>
	<xmqqd282m09j.fsf@gitster.dls.corp.google.com>
	<20141204092251.GC27455@peff.net>
	<xmqqlhmntf02.fsf@gitster.dls.corp.google.com>
	<vpqegsfchi4.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>,
	Christian Couder <christian.couder@gmail.com>,
	Arjun Sreedharan <arjun024@gmail.com>,
	Philip Oakley <philipoakley@iee.org>, Git <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Dec 04 21:20:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwcsZ-00033T-K0
	for gcvg-git-2@plane.gmane.org; Thu, 04 Dec 2014 21:20:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754651AbaLDUT4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2014 15:19:56 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63509 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754637AbaLDUTz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2014 15:19:55 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D40F323DC0;
	Thu,  4 Dec 2014 15:19:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UNKga/zfD4szfUwrXHIzs4roqmA=; b=T4gqfF
	e1fZ8+IPzqLY2lnl7vT7MuT4odvE4u73Bdb/NR3tJx6h+gGp1J1FY9JzRtAXVORj
	WI2JD7Ful8sk6O8IKZWg9QrMCPrYo0Bqa5rcq/SFp3EsOLBfCLdU/lIydUcaMykN
	LVj4X4zphRxmvK+p6QpCQ+SScQfWH573TXzwg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=s+lpvyRMNDI8SRLd8Tz0PuhJROQSg9DX
	YsSrkXV9bS/SK8vP34G4sESySJrI6F89ubWdRmllVZTK/SYyHX3i1iQ0FY4LayaY
	dPEiL6VqBhYzonMJssfXJMaxqvUBMfmmXG0E7sPbKps5u2bUe7ezNY+v+6C0Bxe3
	ELw7DV6B+9c=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CA07023DBE;
	Thu,  4 Dec 2014 15:19:54 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5090223DBC;
	Thu,  4 Dec 2014 15:19:54 -0500 (EST)
In-Reply-To: <vpqegsfchi4.fsf@anie.imag.fr> (Matthieu Moy's message of "Thu,
	04 Dec 2014 21:00:35 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E8AFC566-7BF2-11E4-B474-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260796>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Jeff King <peff@peff.net> writes:
>>
>>> Christian raised the issue of cluttering the "git --option"
>>> namespace,
>>> and I do agree that's a potential issue. 
>>
>> I am not sure if that is an issue at all. You will need the same
>> number of options to cover all the necessary "computables" somewhere
>> anyway.
>>
>> "git --show-this-or-that-computable" is not more or not less
>> cluttering compared to "git var --show-this-or-that-computable".
>
> I disagree.
>
> Right now, a user reading "man git" sees --version, --help, -C,
> --exec-path, --html-path, --man-path, ... at a flat list (it's actually
> the first thing he can read from the man page).

Ahh, OK, you are worried about these "--give-me-computed-values"
mixed with other kinds of options.  I didn't consider that part of
the equation.

OK, "git var --exec-path" (and --friends), that is.
