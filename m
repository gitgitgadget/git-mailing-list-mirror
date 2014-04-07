From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v9 11/11] Documentation: add documentation for 'git interpret-trailers'
Date: Mon, 07 Apr 2014 09:52:59 -0700
Message-ID: <xmqq4n25nkt0.fsf@gitster.dls.corp.google.com>
References: <20140401191831.353.99271.chriscool@tuxfamily.org>
	<20140401192023.353.34477.chriscool@tuxfamily.org>
	<20140402003938.GE6851@google.com>
	<CAP8UFD1hrXDdwKokLH_j=vwWoViC9sSJHf0gTFubh-oFQao4MA@mail.gmail.com>
	<xmqqob0gohc2.fsf@gitster.dls.corp.google.com>
	<xmqqk3b4ogwu.fsf@gitster.dls.corp.google.com>
	<CAP8UFD38TE=5zxvkDvLRsDTpC6zDo6EN5q_HJMQPbUBcfJVsSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	git <git@vger.kernel.org>, Josh Triplett <josh@joshtriplett.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 07 18:53:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WXCnl-0008Dq-Pt
	for gcvg-git-2@plane.gmane.org; Mon, 07 Apr 2014 18:53:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753641AbaDGQxF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Apr 2014 12:53:05 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43996 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753197AbaDGQxC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Apr 2014 12:53:02 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 70C6E7A596;
	Mon,  7 Apr 2014 12:53:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=goBbPIppEU6fkmcOJ6zepnuB3lo=; b=fB0H6z
	GvapbAShO9luS2Pzws8dO0v1Hv7CUntMq70GJYfuRxYn/hFLWEOkb97Lv1At66Q1
	o3yn+kFu3uwuVSCyBt6NijlPZPz1AXEyKdhgMJm67sFbojdbf0RrlNbNn3+MgzUK
	08is2/1Nmi+cMFpkXalBS7ruWdowtNEj43IRg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oT+F+uWF8iDhzLRM9Pi0xpcHWZRaKvGR
	0ieQKamxiidmJFv9H1g/1ZM6du0aOOo4QziWHoj26mBrLtxv9IcjPkmJXXjH8YhT
	irSDkS/BEY6grIGW1zeXSsYWOtqv7nTVtGChFrXOxIOjibYDTOrTE6Mp+bqJpW0/
	FdIhELi8zM4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5E31F7A595;
	Mon,  7 Apr 2014 12:53:02 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 55F237A589;
	Mon,  7 Apr 2014 12:53:01 -0400 (EDT)
In-Reply-To: <CAP8UFD38TE=5zxvkDvLRsDTpC6zDo6EN5q_HJMQPbUBcfJVsSg@mail.gmail.com>
	(Christian Couder's message of "Mon, 7 Apr 2014 11:39:01 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 146B5378-BE75-11E3-8F1A-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245866>

Christian Couder <christian.couder@gmail.com> writes:

> On Sat, Apr 5, 2014 at 12:42 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> Christian Couder <christian.couder@gmail.com> writes:
>>> "The following features are planned but not yet implemented:
>>>         - add more tests related to commands
>>>         - add examples in documentation
>>>         - integration with "git commit""
>>
>> I was planning to merge the series to 'next', but perhaps we should
>> wait at least for the first two items (I do not think the third one
>> is necessary to block the series).
>
> I will send soon a new version of the series with more tests and fixes.
> It will also contains a patch that adds an empty line before the
> trailers in the output if there is not already one.

Ah, yes, that one was mentioned in the reviews, I remember.

> After that I plan to work on adding examples to the documentation.

OK, thanks.

> First accepting both ':' and '=' means one can see the "git
> interpret-trailers" as acting on trailers only. Not just on trailers
> from the intput message and option parameters from the command line.

Sorry, you lost me.  What does "acting on trailers only" really
mean?  Do you mean the command should/can be run without any command
line options, pick up the existing "Signed-off-by:" and friends in
its input and emit its output, somehow taking these existing ones as
its instruction regarding how to transform the input to its output?

> And second there is also a practical advantage, as the user can
> copy-paste trailers directly from other messages into the command line
> to pass them as arguments to "git interpret-trailers" without the need
> to replace the ':' with '='. Even if this command is not often used
> directly by users, it might simplify scripts using it.
>
> Third there is a technical advantage which is that the code that
> parses arguments from the command line can be the same as the code
> that parses trailers from the input message.

I do not see these two as valid arguments to make the command line
more complex to the end users---who now need to know that only this
command treats its command line in a funny way, accepting a colon in
place of an equal sign.

A different way to sell a colon, e.g.

    Consider the instruction sed takes on its command line.
    (e.g. "sed 's/frotz/nitfol/' <xyzzy").  In the most general
    form, you would always give it as the value of an '-e' option
    (e.g. "sed -e 's/frotz/nitfol' <xyzzy"), but you are allowed to
    be loose in limited occassions.  "Key:value" is like that, and
    in the most general form, it actually needs to be spelled as
    "-e 'Key:value'".

is possible, but I do not think it is a particularly good analogy,
because what you have as the alternative is "Key=value", and not
"-e 'Key:value'", or "--Key=value" (the last would probably be the 
most natural way to express this).
