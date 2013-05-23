From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v6] Add new git-related helper to contrib
Date: Thu, 23 May 2013 16:33:13 -0500
Message-ID: <CAMP44s0X-79Pn4gq_rqBbti-xUobyYDc8Gy-3-g=sq8siZqq8g@mail.gmail.com>
References: <1368978823-18247-1-git-send-email-felipe.contreras@gmail.com>
	<7vr4gyizti.fsf@alter.siamese.dyndns.org>
	<CAMP44s0pXLmjVUwsVWiN2G5QReh80spXjvy_6GuUGRz1RmUbLQ@mail.gmail.com>
	<7vd2siiqsr.fsf@alter.siamese.dyndns.org>
	<CAMP44s2ETSxebGxXJV_BYEqTC5gJMVdQLbnTUomrie2rHhdmDg@mail.gmail.com>
	<7v8v36iq3e.fsf@alter.siamese.dyndns.org>
	<7v4nduipvb.fsf@alter.siamese.dyndns.org>
	<7vzjvmh98r.fsf@alter.siamese.dyndns.org>
	<CAMP44s1_=HSgZA=abHJ3sgDbUyfkF78qO+sR1+Aact3o7bAgLA@mail.gmail.com>
	<7vvc6ah81g.fsf@alter.siamese.dyndns.org>
	<CAMP44s37a0_wVVef+QVnLNvc8Uos_XpCZAtpX0RmQyMcuJHUHw@mail.gmail.com>
	<CAMP44s18ps9JtY7+mvXVbuZu3cm7bHnK1vCzMWqBdvawLr+zzA@mail.gmail.com>
	<7v8v35hc11.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 23 23:33:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ufd8d-0000Mo-Dg
	for gcvg-git-2@plane.gmane.org; Thu, 23 May 2013 23:33:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759606Ab3EWVdR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 May 2013 17:33:17 -0400
Received: from mail-lb0-f176.google.com ([209.85.217.176]:62838 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759561Ab3EWVdQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 May 2013 17:33:16 -0400
Received: by mail-lb0-f176.google.com with SMTP id x10so3981355lbi.35
        for <git@vger.kernel.org>; Thu, 23 May 2013 14:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=alxxbHYMmU8mfMjO1fTA1ZOp67EW9j7JJq1tZxpR7a8=;
        b=PKFKXaIpXrGgdrcoNVyp45I8/7Exz8BR5w0PBfFyNqDUJ2qqtKbF0+nYslBHbhedF2
         iIyDqOB1lTDuBA7iopGmZBWYHj4eltX7jl3+BeIuTHgRn7G5pgRfIQEkzZ+Q1SOTw5Nc
         JHbeXDowRgI+OogWNB1QTI4FTgXGYXMrLCinGVQq9XUu724gA4OZCfie7OMCCG/AV4YB
         o1HNLaz2bHt+GoJVl0gH/3vztcgI7fJSsh1bxxfKcNBuECXe1w5B4d97ubk/TrrH53Jq
         drP+18BfWyELXoG8GAFeYXpkERxCXhxtTyG+nLMcavarAdLoDL4Qbg5RUqnBEmWNw9Pk
         +1ow==
X-Received: by 10.112.63.169 with SMTP id h9mr7388133lbs.135.1369344794286;
 Thu, 23 May 2013 14:33:14 -0700 (PDT)
Received: by 10.114.174.170 with HTTP; Thu, 23 May 2013 14:33:13 -0700 (PDT)
In-Reply-To: <7v8v35hc11.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225302>

On Thu, May 23, 2013 at 11:54 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> On Wed, May 22, 2013 at 11:07 PM, Felipe Contreras
>> <felipe.contreras@gmail.com> wrote:
>>> On Wed, May 22, 2013 at 7:08 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>>>
>>>>>> IIRC, git-gui runs two blames, one without any -C and one with (I do
>>>>>> not offhand recall how many -C it uses) to show both.
>>>>>
>>>>> 'git blame' is a very expensive operation, perhaps we should add
>>>>> another option so users don't need to run two blames to find this.
>>>>
>>>> Yes, you could add a "struct origin *suspect_in_the_same_file" next
>>>> to the current "struct origin *suspect" to the blame_entry in order
>>>> to represent the origin you would get if you were to stop at a "move
>>>> across files" event, and keep digging, when you are operating under
>>>> "-C -C" or higher mode.
>>>
>>> No, this is what I meant:
>>
>> But that would not print the right line numbers, so perhaps:
>
> Users of full-output may want to be able to see the same thing.
>
> I have a suspicion that you misread what assign_blame() does.  The
> first inner loop to find one "suspect" is really what it says.  It
> loops over blame entries in the scoreboard but it is not about
> finding one "entry", but is to find one "suspect".  The "ent" found
> in the loop that you store in tmp_ent is no more special than any
> other "ent" that shares the same "suspect" as its origin.

It is stored because it's the only structure that has the line
numbers. If the blame is passed to another 'ent', the original line
numbers are gone. We could manually copy the line numbers to three
variables, or we could copy the whole thing to one variable. The rest
of the 'ent' doesn't matter.

> Imagine that your scoreboard originally has three blocks of text
> (i.e. blame_entry) A, B, and C, and the current suspect for A and C
> are the same, while we already know what the final guilty party for
> B is (which may be some descendant of the "suspect").

I don't see how that's possible, but whatever.

> Once we find one "suspect" in the first inner loop, the call to
> pass_blame() does everything it can do to exonerate that "suspect".
>
> It runs a single diff between the suspect and each of its parents to
> find lines in both A and C that can be blamed to one of these
> parents, and blame entries A and C are split into pieces, some of
> which still have the same suspect as their origin, which are where
> their lines originate from, while others are attributable to these
> parents or their ancestors.
>
> If you keep the original entry for A to do something special, like
> printing what the original range of A was before it was split by
> pass_blame(), wouldn't you need to do the same for C?

tmp_ent is only used when there's no entry taken the guilt away from
A. If the blame entry of A is split, and the result of the split has a
different filename, found_guilty() would not be called, and thus we
won't show the blame entry, and we want to show it.

And yes, we would need to do the same for C, and we would once the
turn of C comes along. If it's possible that A descendant from A takes
the blame for C, then sure, we would need to do ensure C is printed
before it's gone, but pass_blame(A) would not destroy C.

> We will not
> be visiting C later in the outer while(1) loop, as a single call to
> pass_blame() for "suspect" we did when we found it in A has already
> taken care of it.

It took care of A's suspect, but not C. Isn't it possible that C is
split further and creates another blame entry? Either way, in
--incremental we want to print C as well, whether it's the guilty one
or not.

> I am not sure what you are trying to achieve with that found-guilty
> logic, even if the "save away in tmp_ent" logic is changed to keep
> all the blame entries that have "suspect" we are looking at as their
> origin.

> When the current suspect is found to have passed all lines
> intact from its parents, we will see found-guilty left to be false.

What? When a 'blame entry' passes the whole blame to a parent,
found_guilty is false, so we print the entry, which is exactly what we
want to do.

> How would it make the original blame_entry (perhaps halfway) guilty
> in that situation?

I thought 'guilty' meant that it was guilty of adding those lines to
the 'final' text, so it ends up in the non-incremental blame. In that
sense those blame entries are not guilty.

But they are still blame entries, and we want to print all blame
entries in incremental, guilty or not.

-- 
Felipe Contreras
