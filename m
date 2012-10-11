From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 00/12] Wildmatch v4
Date: Thu, 11 Oct 2012 09:09:04 -0700
Message-ID: <7vlifd7zz3.fsf@alter.siamese.dyndns.org>
References: <1349865651-31889-1-git-send-email-pclouds@gmail.com>
 <7vd30panxo.fsf@alter.siamese.dyndns.org>
 <7v1uh5aar7.fsf@alter.siamese.dyndns.org>
 <CACsJy8B2JJmUbjAauMwbg95fCvPdUYqy4CKZp3ac44XHoh1NLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 11 18:09:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TMLK4-0006XH-K2
	for gcvg-git-2@plane.gmane.org; Thu, 11 Oct 2012 18:09:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754776Ab2JKQJJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Oct 2012 12:09:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53443 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751642Ab2JKQJH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Oct 2012 12:09:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0A2708616;
	Thu, 11 Oct 2012 12:09:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=2xYjjB6EePyP
	XiK7KeeBaapVitE=; b=psggVZazuAQB73MmDo8HIb67vQWabLeLW4iNvckPjlOS
	9T69LaCE/FW0w/b/LXG0ex1TYtg94PZRuBcDkM56+yHwcMlkwgZzQc0Ic47L7T8N
	QUqxjjnkGb7RyBiZpFyTabo6sxhYJAlzr3XpaQ+mgqWBilJjtV95pyUZqCIT1pY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Wxy22Z
	Zk7GXNUKs8dhyQ7RvjLYKexO/F8p5v+F12wZi0bGwog3y2CWNCgv9uOuBVy5yqIm
	tU/LxXtg6Jaitgnk1dJSzhKqAc7PMi8EAIczOLT8H2ZpzHKt36qBygv4+OmFXEr6
	jFaUxL/c+UiowumC07HslRQ2kub/isuLrBr9s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E847D8606;
	Thu, 11 Oct 2012 12:09:06 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4795D8605; Thu, 11 Oct 2012
 12:09:06 -0400 (EDT)
In-Reply-To: <CACsJy8B2JJmUbjAauMwbg95fCvPdUYqy4CKZp3ac44XHoh1NLQ@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Thu, 11 Oct 2012 18:56:55 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FB74BA52-13BD-11E2-9AE2-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207482>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> On Thu, Oct 11, 2012 at 11:33 AM, Junio C Hamano <gitster@pobox.com> =
wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writ=
es:
>>>
>>>> Really small updates. I did not want to resend it this soon but th=
is
>>>> may fix the compile errors for Junio.
>>
>> t3070 seems to break TAP,
>>
>>     *** prove ***
>>     t3070-wildmatch.sh .. Failed 1/151 subtests
>>
>>     Test Summary Report
>>     -------------------
>>     t3070-wildmatch.sh (Wstat: 0 Tests: 150 Failed: 0)
>>       Parse errors: Tests out of sequence.  Found (76) but expected =
(75)
>>                     Tests out of sequence.  Found (77) but expected =
(76)
>>                     Tests out of sequence.  Found (78) but expected =
(77)
>>                     Tests out of sequence.  Found (79) but expected =
(78)
>>                     Tests out of sequence.  Found (80) but expected =
(79)
>>     Displayed the first 5 of 77 TAP syntax errors.
>>
>> This probably is due to this part of the output:
>>
>>     ok 72 - wildmatch 1 1 [ab] [\[:]ab]
>>     ok 73 - wildmatch 1 1 ?a?b \??\?b
>>     ok 74 - wildmatch 1 1 abc ^G^Hok 75 - wildmatch 0 0 foo
>>     ok 76 - wildmatch 1 0 foo/bar/baz/to **/t[o]
>>     ok 77 - wildmatch 1 1 a1B [[:alpha:]][[:digit:]][[:upper:]]
>>
>
> It seems to prove fine here with perl 5.12.3, Test-Harness-3.230,
> bash-4.0_p38. What version do you use?

I seem to have Perl 5.10.1, Test::Harness 3.17, Dash 0.5.5.1.  But
as you can see above, what is _fed_ to the Perl-side is broken
(notice the concatenation at the end of "ok 74"), so I do not think
versions of Perl-side matters.

I suspect that this is the immediate culprit:

    match 1 1 'abc' '\a\b\c'

The symptom looks like that somebody is interpreting \a as BEL, \b
as backspace, etc. when showing the "ok ..." line, no?
