From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git send-email should not allow 'y' for in-reply-to
Date: Fri, 11 Jan 2013 14:18:46 -0800
Message-ID: <7vy5fz9xdl.fsf@alter.siamese.dyndns.org>
References: <A0DB01D693D8EF439496BC8B037A0AEF322039A7@xmb-rcd-x15.cisco.com>
 <20130111212325.GA18193@sigill.intra.peff.net>
 <CALWbr2xasF1y9j3G=-fQ9Wwg41Ymv=MMsWoqyuhweDov9KpRvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	"Matt Seitz \(matseitz\)" <matseitz@cisco.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 11 23:19:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TtmwP-00022H-Fu
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jan 2013 23:19:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755705Ab3AKWSt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2013 17:18:49 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46464 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755655Ab3AKWSs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2013 17:18:48 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 62CFBB48E;
	Fri, 11 Jan 2013 17:18:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=y67ZKReR2Wi6FCrtW4Al0ypWs/Q=; b=V+PXry
	76gdqMH4Xug4/KihFAIVy1+vQPFkZdGgO+E2m/gY8/TUbrLct72zO1ZYSunw/TPC
	WkXufR4YkAasVptEJYOOxSpCkeicenWcYf3YxxsIjawEHX1kpi0PiyJbUrfbmTFh
	7QVBLAePOL1i2tsjNWc/BT3o6t8B7KBHqpTwQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wNeppJ8OLJOvgWHyUvOKmEvYv0kpAhDn
	vaKmxkd2KQ3qLhG1pYQ84xb8yYInp0g0dc0Q5wxvhfCe1EwK+121RiaX/JrcJUq9
	SqtZMqQd2iLw69o5UjgfMid+PjQNGrsi1+W7UWCgVjCq0W+8El0hDEJEj19YSnlw
	bne8kIR0M/I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 56263B48D;
	Fri, 11 Jan 2013 17:18:48 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id ABD76B48A; Fri, 11 Jan 2013
 17:18:47 -0500 (EST)
In-Reply-To: <CALWbr2xasF1y9j3G=-fQ9Wwg41Ymv=MMsWoqyuhweDov9KpRvg@mail.gmail.com> (Antoine
 Pelisse's message of "Fri, 11 Jan 2013 22:53:16 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DE9C5FDA-5C3C-11E2-B881-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213250>

Antoine Pelisse <apelisse@gmail.com> writes:

> On Fri, Jan 11, 2013 at 10:23 PM, Jeff King <peff@peff.net> wrote:
>> On Fri, Jan 11, 2013 at 08:13:57PM +0000, Matt Seitz (matseitz) wrote:
>>
>>> > > How about "What Message-ID to use as In-Reply-To for the first email?"
>>> > > or "Provide the Message-ID to use as In-Reply-To for the first
>>> > > email:".
>>> >
>>> > seem fine to me. Maybe somebody who has been confused by it can offer
>>> > more. At any rate, patches welcome.
>>>
>>> Suggestion: "Message-ID to use as In-Reply-To for the first email:".
>>>
>>> Simple and unlikely to generate a "y" or "n" response.  Putting
>>> "Message-ID" first makes it more obvious what data is being asked for
>>> by this prompt.
>>
>> You'd think. But the existing message that has been causing problems is:
>>
>>   Message-ID to be used as In-Reply-To for the first email?
>>
>> which is more or less what you are proposing. I do think a colon rather
>> than a question mark helps indicate that the response is not yes/no.
>
> That is true.
>
> I'm definitely not a wording person, but assuming people who make the
> mistake probably don't read the whole sentence out of laziness (that
> might be somehow extreme though ;), starting it with "what" makes it
> obvious at first sight that you can't answer yes/no.
> That is not true if the message starts with Message-ID .. which
> doesn't look like a question. Now it feels like you have agree or not.

The exchange, when you do not have a configuration, goes like this:

    $ git send-email 0001-filename-of-the-patch.patch
    0001-filename-of-the-patch.patch
    Who should the emails be sent to (if any)? junio
    Are you sure you want to use <junio> [y/N]? y
    Message-ID to be used as In-Reply-To for the first email (if any)? 

Why not do this instead?

    $ git send-email 0001-filename-of-the-patch.patch
    0001-filename-of-the-patch.patch
    Who should the emails be sent to (if any)? junio
    Are you sure you want to use <junio> [y/N]? y
    Is this a response to an existing message [y/N]? y
    What is the Message-ID of the message you are replying to?
