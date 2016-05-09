From: Junio C Hamano <gitster@pobox.com>
Subject: Re: t6044 broken on pu
Date: Mon, 09 May 2016 11:22:39 -0700
Message-ID: <xmqqvb2num4w.fsf@gitster.mtv.corp.google.com>
References: <7d747193-7ba1-e274-86dc-427ed0f124c9@web.de>
	<878tzmrrfg.fsf@linux-m68k.org>
	<d1fcc54b-ddd7-b03b-79fa-2112a3f43141@web.de>
	<xmqqa8k11e8j.fsf@gitster.mtv.corp.google.com>
	<5618208c-ce45-d65c-abf8-498cfe0f2f84@web.de>
	<xmqqoa8gza1t.fsf@gitster.mtv.corp.google.com>
	<6871653f-248f-ef9a-1947-0ed88783ad8b@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andreas Schwab <schwab@linux-m68k.org>, newren@gmail.com,
	Git Mailing List <git@vger.kernel.org>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon May 09 20:22:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azppP-0004yK-87
	for gcvg-git-2@plane.gmane.org; Mon, 09 May 2016 20:22:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751447AbcEISWn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 May 2016 14:22:43 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57161 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750941AbcEISWm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 May 2016 14:22:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 367CC189CF;
	Mon,  9 May 2016 14:22:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=LbZgsr0tzEcB
	HmB6vZ7gq6XhZ+Q=; b=WpYLekKtcbwdFdZzebNEZHVWKl3Kz/jMM9qO122N6Fcw
	JqWgSaH33b2FUi/z3qXD2tDHqCCiTwns4o0iYe0MZ4YIi6oI3BxnUIas9sKpZnMN
	ohImavOhrcgrpMddgWEgPaR83NkbTtviNlUp13SNcxzYeBjvmjemfqp/CiKT+rg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Sybi8/
	ZgK+LVIJZaVrKBCz2ODU8PmzlaIddOet6N4PJEIgyxugevhQhJrleWKcWVhqNBb6
	fcRkiUAtRwLASSxdM5eo8DKTwsRBNBamg7LsUzmARHhiEgWqcqnFW72zXAOhJwtj
	x8Tcy1tl0vMulxM/GeRSomUAaoib6MCG1q614=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2EB57189CE;
	Mon,  9 May 2016 14:22:41 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9E770189CD;
	Mon,  9 May 2016 14:22:40 -0400 (EDT)
In-Reply-To: <6871653f-248f-ef9a-1947-0ed88783ad8b@web.de> ("Torsten
	=?utf-8?Q?B=C3=B6gershausen=22's?= message of "Mon, 9 May 2016 06:43:30
 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 03E0B49C-1613-11E6-9D68-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294034>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> On 08.05.16 20:20, Junio C Hamano wrote:
>> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>>
>>> May a  simple
>>>  printf "1\n2\n3\n4\n5\n6\n7\n8\n9\n10\n"
>>>
>>> be an option ?
>> If you were to do that, at least have the decency to make it more
>> readable by doing something like:
>>
>> 	printf "%s\n" 1 2 3 4 5 6 7 8 9 10
>>
>> ;-)
>>
>> But as I said, as a response to "t6044 broken on pu" bug report,
>> s/seq/test_seq/ is the only sensible change.
>>
>> Improving "test_seq, the alternative to seq" is a separate topic.
>>
>> If you have aversion to $PERL, perhaps do them without using
>> anything what is not expected to be built-in in modern shells,
>> perhaps like this?
> Please don't get me wrong -

I don't.

> I wasn't really clear why:

So is it now clear?

The title of the bug report is "t6044 broken on pu". The analysis of
the issue is "We use 'test_seq 1 10' when we want one to ten on each
line in the output to use in test to make sure it is portable, but a
new commit forgot the portability issue and used seq instead".

The only sensible fix is "Use test_seq like everybody else".

Improving the implementation of test_seq is a totally separate
issue.  It may be a good thing to do independently to save external
program, and the effect of such change will not be limited to t6044
but all other existing users of test_seq.

And that is why it must be done as a separate topic.

Why you think it is a good idea to update t6044 with printf
"1\n2\n3\n4\n5\n6\n7\n8\n9\n10\n" is beyond me--don't you want to
make sure that existing users of test_seq benefits the same way?
