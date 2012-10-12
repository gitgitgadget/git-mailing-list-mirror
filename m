From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 00/12] Wildmatch v4
Date: Fri, 12 Oct 2012 10:05:06 -0700
Message-ID: <7vbog74o59.fsf@alter.siamese.dyndns.org>
References: <1349865651-31889-1-git-send-email-pclouds@gmail.com>
 <7vd30panxo.fsf@alter.siamese.dyndns.org>
 <7v1uh5aar7.fsf@alter.siamese.dyndns.org>
 <CACsJy8B2JJmUbjAauMwbg95fCvPdUYqy4CKZp3ac44XHoh1NLQ@mail.gmail.com>
 <507848DF.6060301@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Fri Oct 12 19:05:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TMifu-00040G-C6
	for gcvg-git-2@plane.gmane.org; Fri, 12 Oct 2012 19:05:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757391Ab2JLRFM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Oct 2012 13:05:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33501 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755847Ab2JLRFK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Oct 2012 13:05:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3DB8D9379;
	Fri, 12 Oct 2012 13:05:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=ufDMgV8zhAOj
	76KnDH06TTmxJmI=; b=Q6rbq6kfwD6Le+AcUL1GRP/GgE35qGbg7ia+yq6oUTS7
	l5pM5ElupWAm7+DR222E7iW7Bw1RA6e24hRB3GDhLJ4oGWla8eH+2eep0zdAJDOQ
	KPdJZZWJ9Ye2FLMHCzf3cO0R1XIsvcyJ1iBTB7jvohma3pSLKUL6V7cjc3p0e80=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=ffiCXJ
	Aj+J7KOkFXlWPkCjSj7tKWGfkH1zed5A/O7qW82/XMpS6u+ZvECTn3R+ymXJRaeT
	JnlcnG+m7A+JDLCC7FW3GRT3Rep4R2GgJFfrnNLeeVWfR3+chnt0wwW8XuQtRL5N
	PV1Sho8nHxJYQO0wnuTTa9Juz5mN342O9AllI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2B3C09372;
	Fri, 12 Oct 2012 13:05:10 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 62EED9371; Fri, 12 Oct 2012
 13:05:08 -0400 (EDT)
In-Reply-To: <507848DF.6060301@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of "Fri, 12 Oct 2012 18:44:15 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F9D81C62-148E-11E2-9AE3-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207558>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> On 11.10.12 13:56, Nguyen Thai Ngoc Duy wrote:
>> On Thu, Oct 11, 2012 at 11:33 AM, Junio C Hamano <gitster@pobox.com>=
 wrote:
>>> Junio C Hamano <gitster@pobox.com> writes:
>>>
>>>> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> wri=
tes:
>>>>
>>>>> Really small updates. I did not want to resend it this soon but t=
his
>>>>> may fix the compile errors for Junio.
>>>
>>> t3070 seems to break TAP,
>>>
>>>     *** prove ***
>>>     t3070-wildmatch.sh .. Failed 1/151 subtests
>>>
>>>     Test Summary Report
>>>     -------------------
>>>     t3070-wildmatch.sh (Wstat: 0 Tests: 150 Failed: 0)
>>>       Parse errors: Tests out of sequence.  Found (76) but expected=
 (75)
>>>                     Tests out of sequence.  Found (77) but expected=
 (76)
>>>                     Tests out of sequence.  Found (78) but expected=
 (77)
>>>                     Tests out of sequence.  Found (79) but expected=
 (78)
>>>                     Tests out of sequence.  Found (80) but expected=
 (79)
>>>     Displayed the first 5 of 77 TAP syntax errors.
>>>
>>> This probably is due to this part of the output:
>>>
>>>     ok 72 - wildmatch 1 1 [ab] [\[:]ab]
>>>     ok 73 - wildmatch 1 1 ?a?b \??\?b
>>>     ok 74 - wildmatch 1 1 abc ^G^Hok 75 - wildmatch 0 0 foo
>>>     ok 76 - wildmatch 1 0 foo/bar/baz/to **/t[o]
>>>     ok 77 - wildmatch 1 1 a1B [[:alpha:]][[:digit:]][[:upper:]]
>>>
>>=20
>> It seems to prove fine here with perl 5.12.3, Test-Harness-3.230,
>> bash-4.0_p38. What version do you use?
>>=20
> Some problems even here (Mac OS) commit 2aeb6d4d7884f4c4425
>
> not ok 61 - wildmatch 0 0 \ \
> not ok 62 - wildmatch 0 0 /\ */\
> not ok 69 - wildmatch 1 1 [ab] [[:]ab]
> not ok 71 - wildmatch 1 1 [ab] [[:digit]ab]
> not ok 80 - wildmatch 1 0 1 [[:digit:][:upper:][:space:]]
> not ok 81 - wildmatch 0 0 1 [[:digit:][:upper:][:spaci:]]
> not ok 88 - wildmatch 1 0 _ [[:alnum:][:alpha:][:blank:][:cntrl:][:di=
git:][:graph:][:lower:][:print:][:punct:][:space:][:upper:][:xdigit:]]
> not ok 89 - wildmatch 1 0 _ [[:alnum:][:alpha:][:blank:][:cntrl:][:di=
git:][:graph:][:lower:][:print:][:punct:][:space:][:upper:][:xdigit:]]
> not ok 93 - wildmatch 1 1 y [a-c[:digit:]x-z]
>
> I have 2 perls,...

The problem under discussion was that the output from passing tests
were mangled and not interpreted correctly by a program that
analyzes them, which happens to be written in Perl.  Even in that
context, it was pointless to ask for Perl versions, as it was clear
that the input to that Perl-written program, i.e. output from the
tests, were not formatted correctly to say "ok NN message".

If you are getting "not ok", I do not think you need to look at your
Perl.  The wildmatch tests are failing, and it is far more likely
that the wildmatch code is failing in your environment, than the
test harness that runs wildmatch code is failing.

Neither the wildmatch code itself (in C), nor the test harness that
is giving you the above "not ok" (in shell) depends on Perl.

Thanks for a report, but the debugging needs to see how the matching
code in mildmatch misbehaves.

I suspect it is another case where the platform fnmatch (from MacOS)
is not behaving as these tests expect.

Nguyen, how about updating the match () shell function in 3070 so
that it not just says not-ok, but indicates what failed (wildmatch
failed, or wildmatch passed but fnmatch failed), at least when the
test is run as "./t3070-*.sh -v -i"?
