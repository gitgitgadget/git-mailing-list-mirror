Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D28DA20196
	for <e@80x24.org>; Tue, 12 Jul 2016 22:12:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751160AbcGLWLy (ORCPT <rfc822;e@80x24.org>);
	Tue, 12 Jul 2016 18:11:54 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:26081 "EHLO
	smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750867AbcGLWLx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2016 18:11:53 -0400
Received: from PhilipOakley ([92.22.11.179])
	by smtp.talktalk.net with SMTP
	id N5u0br96wcpskN5u0bkqah; Tue, 12 Jul 2016 23:11:41 +0100
X-Originating-IP: [92.22.11.179]
X-Spam:	0
X-OAuthority: v=2.2 cv=ILRAMUnG c=1 sm=1 tr=0 a=811fezkhcwEiY9Bhi8bArg==:117
 a=811fezkhcwEiY9Bhi8bArg==:17 a=8nJEP1OIZ-IA:10 a=ybZZDoGAAAAA:8
 a=8q6LdnVOAAAA:8 a=87ace9c65YrI5DX7-6UA:9 a=0RhZnL1DYvcuLYC8JZ5M:22
 a=jNYSTCpFY2gkngftge3H:22
Message-ID: <D94C739D5C334AFE9E5E8410147899EA@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:	"Philip Oakley" <philipoakley@iee.org>
To:	"Junio C Hamano" <gitster@pobox.com>,
	"Marc Branchaud" <marcnarc@xiplink.com>
Cc:	"GitList" <git@vger.kernel.org>, "Jeff King" <peff@peff.net>
References: <20160630202509.4472-1-philipoakley@iee.org><20160711202518.532-1-philipoakley@iee.org><20160711202518.532-5-philipoakley@iee.org><5784F43E.3080400@xiplink.com> <xmqqwpkq6b4d.fsf@gitster.mtv.corp.google.com>
Subject: Re: [PATCH v3 4/8] doc: give headings for the two and three dot notations
Date:	Tue, 12 Jul 2016 23:11:42 +0100
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfNQW8H+PMpCBTMjfLJYpC8CpEf9DkjUhvCnD7SxOmnYYC07jMNWg2pvByl2e5ieDzywOiAwvZZkFdID6MlrE19cdC/32J+KsSwDl0pmqN5bfuE961TlX
 tUGilVuYPkNjZJFmvbWhJfEZCTzgok3Iq1QpuhTVENJhg5i5py2pOU2ovdXP5Ta7kti8zoTPA+QnQ4QW5cPQGKn2w2zHJclPEb/Q7Cq/G176uH17t1KF7qYS
 0yZqP0jUZLYaQHU4q47SFA==
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: "Junio C Hamano" <gitster@pobox.com>
> Marc Branchaud <marcnarc@xiplink.com> writes:
>
>>> +The '{caret}' (caret) notation
>>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>   To exclude commits reachable from a commit, a prefix '{caret}'
>>>   notation is used.  E.g. '{caret}r1 r2' means commits reachable
>>>   from 'r2' but exclude the ones reachable from 'r1'.
>>
>> All of these headings render poorly in the manpage, at least for me
>> (Ubuntu 16.04).  Only the first word appears in bold; the '-quoted
>> text is not bold but underlined, and the rest of the header is plain.
>>
>>
>> Also, I think calling this "The ^ notation" is confusing, because
>> there's already an earlier paragraph on the "<rev>^" syntax.
>>
>> Maybe we don't need a header here?  I only suggest that because I'm
>> having trouble coming up with a nice alternative.  "Commit Exclusion"?
>
> Thanks for pointing out the potential confusion between ^X (exclude
> reachable), and X^ (the first parent).  Commit exclusion is probably
> a good heading.
>
OK - I'll see about incorporating that.

>>> -This set operation appears so often that there is a shorthand
>>> +The '..' (two-dot) range notation
>>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>
>> Perhaps "Range notation", to mirror the capitalization of "Symmetric
>> Difference" in the next header?
>>> ...
>>> +The '...' (three dot) Symmetric Difference notation
>
> This uses a strange capitalization rule.  s/notation/Notation/
> perhaps?  The same comment for "Additional Shothand notation" below.
>

I'd just capitalised the specific term. Will change.

>>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>   A similar notation 'r1\...r2' is called symmetric difference
>>>   of 'r1' and 'r2' and is defined as
>>>   'r1 r2 --not $(git merge-base --all r1 r2)'.
>>>   It is the set of commits that are reachable from either one of
>>>   'r1' (Left side) or 'r2' (Right side) but not from both.
>>>
>>> -In these two shorthands, you can omit one end and let it default to 
>>> HEAD.
>>> +In these two shorthand notations, you can omit one end and let it 
>>> default to HEAD.
>>>   For example, 'origin..' is a shorthand for 'origin..HEAD' and asks 
>>> "What
>>>   did I do since I forked from the origin branch?"  Similarly, 
>>> '..origin'
>>>   is a shorthand for 'HEAD..origin' and asks "What did the origin do 
>>> since
>>>   I forked from them?"  Note that '..' would mean 'HEAD..HEAD' which is 
>>> an
>>>   empty range that is both reachable and unreachable from HEAD.
>>
>> Unfortunately the new headings make it appear that this paragraph is
>> exclusively part of the '...' notation section.  Folks reading the
>> ..' section are likely to skip it.
>>
>> I like the examples, though.  I think it would be worthwhile to remove
>> this paragraph and fold it explicitly into the '..' and '...' notation
>> sections.
>
> An alternative would be to have
>
>    - Dotted range notations
>      - Two-dot notation
>      - Three-dot notation
>
> which would help make it stand out that defaulting is common
> characteristics between .. and ... notations.  But I can imagine
> that your "with slight duplication" variant below would work well,
> too.

I'll look into that.

>
>> So add something like this to the '..' section (only the first
>> sentence here is new):
>>
>> Either r1 or r2 can be omitted, in which case HEAD is used as
>> the default.  For example, 'origin..' is a shorthand for
>> 'origin..HEAD' and asks "What did I do since I forked from the
>> origin branch?"  Similarly, '..origin' is a shorthand for
>> 'HEAD..origin' and asks "What did the origin do since I forked
>> from them?"  Note that '..' would mean 'HEAD..HEAD' which is an
>> empty range that is both reachable and unreachable from HEAD.
>>
>> And also, add the same first sentence and a different example to the
>> ...' section.  Something like this:
>>
>> Either r1 or r2 can be omitted, in which case HEAD is used as
>> the default.  For example, 'origin...' is a shorthand for
>> 'origin...HEAD' and asks "What have I and origin both done
>> since I forked from the origin branch?"  Note that 'origin...'
>> and '...origin' ask the same question.
>
>>> +Additional '{caret}' Shorthand notations
>>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>   Two other shorthands for naming a set that is formed by a commit
>>> -and its parent commits exist.  The 'r1{caret}@' notation means all
>>> -parents of 'r1'.  'r1{caret}!' includes commit 'r1' but excludes
>>> -all of its parents.
>>> +and its parent commits exist.
>>
>> I think descriptions of <rev>^@ and <rev>^! should live under the main
>> description of <rev>^.  That part already describes the numeric
>> suffix, so describing a couple of special suffixes there seems like a
>> natural fit.
>
> I actually think this is a good place to have them described.
> <rev>^<number> is about specifying a single commit.  These two are
> not that (you can say HEAD^2^@ but you cannot say HEAD^@^2, for
> example).

These two are special cases I'm not too familiar with, particularly the r1^! 
which I didn't undesrtand from the description...

--
Philip 

