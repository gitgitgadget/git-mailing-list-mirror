From: Christian Couder <christian.couder@gmail.com>
Subject: Re: GSoC Project | Improvise git bisect
Date: Sat, 19 Mar 2016 17:14:09 +0100
Message-ID: <CAP8UFD2fudNtGpUHTYjZKXCErocuRS65E=5tH_+_tsNFbmHCBA@mail.gmail.com>
References: <CAFZEwPN-oUDNnc_PBeP2Q4msJAHenkiLtE+Oo75R+uTTwUKpYQ@mail.gmail.com>
	<vpqoaaahbvi.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Pranit Bauva <pranit.bauva@gmail.com>,
	Git List <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Lars Schneider <larsxschneider@gmail.com>,
	Jeff King <peff@peff.net>, troy.moure@gmail.com,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Kevin Daudt <me@ikke.info>,
	Philip Oakley <philipoakley@iee.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sat Mar 19 17:14:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ahJW9-0006N2-Pl
	for gcvg-git-2@plane.gmane.org; Sat, 19 Mar 2016 17:14:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754857AbcCSQON (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Mar 2016 12:14:13 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:34944 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754685AbcCSQOL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Mar 2016 12:14:11 -0400
Received: by mail-wm0-f48.google.com with SMTP id l68so61805635wml.0
        for <git@vger.kernel.org>; Sat, 19 Mar 2016 09:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=wYsObkbqL1K+DayOdi27PGmCOReeyvUAr91T/A5MRDw=;
        b=CUa8gXiHn9rdeIZLvQy5gBnwwJ2ZuCJIQI7tlgzmhwEwPHtD86CJxVzvmZEfyx6W/x
         AMaLJ/Ga1dalBYn/zuzi7y/GvJu5mbAH3SdxzTMLdTVMysl6UeKTVT36y0HvLu6uUrUl
         01rJjcC2lRBpNV8tVc+UqAVXKshZ4z97LpDPIb1zOV06w+z0wsSHrYihBz/1VzL1jka9
         Rw9D8fzjkxFu95PuCNxzVPtD+Okr1TxuPrQUU3hSDdYUAq2jzqZmhwRK5GVVA7wGNpr4
         mnwoJmNm7F87Z5QHIDPmefR0Q91N2ggzs5vOvY7XvnG5CnW2zZFREt7Nmi91DrHMVk8D
         1vyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=wYsObkbqL1K+DayOdi27PGmCOReeyvUAr91T/A5MRDw=;
        b=KYHcqvF2gVxMHlSArNXSLw75OR/4FIT+F3vrLKAhtPKhgoRwR7l7hvSQ/e6GfEXZmn
         pfA41ojwmpQZUwTyt6Wi8j3XID6uzn1ffaWVWup4pLy5nsMOTkXNg0t3EIUjqRs1tm6r
         HT2pYbKxcILwdMqdXA40W2T0vmpFA6aPJR//F/dpRv3oyFtxn8GfV9u6/EYEpJaIVCas
         5xCA+HFxSWgHFGT+iH+e3ZCcnBT05pmJVu5O+RYJYNFhK9MRKPORMoFkH2Og0V1/5jTC
         27PP/ApVpatpd/IJnzjcfa5MV+5N56HUQTYhv7rRLY6VdiT3U1F4I6pkQJEbsF/1mRxe
         ztJQ==
X-Gm-Message-State: AD7BkJJWhSHbQ5gMNflZZhTG5CIVbvENardAlV5V18BBbDETmZhPFxEYYR0DMnrX/hNwm94egeeGVDv+v2L9lA==
X-Received: by 10.28.97.10 with SMTP id v10mr126407wmb.62.1458404049547; Sat,
 19 Mar 2016 09:14:09 -0700 (PDT)
Received: by 10.194.151.131 with HTTP; Sat, 19 Mar 2016 09:14:09 -0700 (PDT)
In-Reply-To: <vpqoaaahbvi.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289311>

Hi,

On Sat, Mar 19, 2016 at 1:48 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
>> Subject: Re: GSoC Project | Improvise git bisect
>                                    ^^^^
>
> "Improve" I guess.
>
> Pranit Bauva <pranit.bauva@gmail.com> writes:
>
>> Hey everyone!
>
> Hi,
>
>> What I understood is that let's say the repository is like :
>>
>>          C13
>>            |
>>          C12
>>            |
>>          C11 (merge commit)
>>        /   |
>>      |   C10
>>      |     |
>>      |   C9
>>      |     |
>>      |   C6 (merge commit)
>>    C8    |   \
>>      |   C3    |
>>    C7    |     |
>>        \   |     C5
>>          C2    |
>>            |     C4
>>            |    /
>>           C1
>>  (master branch)
>
> When drawing ascii-art diagrams like this, try to use a fixed-width
> font. It looks ugly in my mailer.

Ah, it looks ok in gmail.

>> The commits numbers ie. C1...C13 are according to the time stamp, C1
>> being the first.
>
> One information is missing: which is the first parent.

Yeah it is not clear but we can suppose that the first parents are
among C1, C2, C3,C6, C9, C10, C11, C12 and C13.
So the first parent of C11 would be C10 and the first parent of C6 would be C3.

>> On starting to debug with git bisect, given that C12 is bad and C1 is
>> good, it starts a binary search from C1...C13. ie. It first goes to
>> C7,

First if C1 is good and C12 is bad then the binary search is between C1 and C12.
C13 is excluded.

> I don't think so. It tries to find a commit which cuts the graph into 2
> sub-graphs with roughly the same number of commits. If you pick C7, then
> C7 is bad, the regression may be anywhere except C1, C2, C7. This does
> not reduce the scope much.

If C7 is bad then, as C1 is good the "first bad commit" is C7 or C2.
It's when C7 is good that C7 and C2 are excluded.

> I guess you picked C7 because of the timestamps. "bisect" picks the
> commit according to the graph topology.

Yeah. Basically it will pick the commit that is the farther away from
the "bad" and "good" commits.
That means C6 or C9 will be picked, so it looks like the graph is not
a good example of why --first-parent could be useful.

>> if its all good, it goes to C10 and so on an so forth. If C7 is not
>> good, it goes to C4 and so on and so forth. This just makes the job of
>> debugging a bit difficult for a repo which has only 1 mainstream
>> repository and it just has some short-term branches to instantly get
>> stuff done.
>
> Why?
>
>> It can be simplified by using --first-parent. Given C1 is good and C12
>> is bad, it will find the mean between {C1, C2, C3, C6, C9, C10, C11,
>> C12, C13} which is C9, see if its good.

It would find C6 or C9 even without --first-parent.

> Do you mean that C10 is the first parent of C11, and C3 the first parent
> of C6? That's an un-usual graphical convention: usually we represent
> first parent as leftmost parent.

Yeah.

>> If not then it will go to C3
>> and then C2, if good then it will go to C6, if not good then it will
>> go to C5 and then C4. This will greatly simplify the job of debugging.
>
> Again, why?
>
> The missing part in your explanation is probably:
>
> Some projects do not enforce the policy "each commit must be compilable
> and correct", but instead consider that only commits on the mainline
> should have this property.

Yeah. And there were previous discussions on the mailing list where
--first-parent was discussed.
It would be nice if they were refered to. They might talk about other
interesting use cases.

> This typically allows history like
>
>  A Merge feature A
>  |\
>  | B fix bug in feature A
>  | |
>  | C fix compilation error in previous commit
>  | |
>  | D implement feature A
>  |/
>  E Merge feature B
>  ...
>
> When bisecting through such history, testing commits B and C is
> meaningless, but it still makes sense to bisect through the mainling
> commits A and E. In this case, we can consider that if E is good and A
> is bad, then the regression was introduced in A.
>
> Once we know that, we can actually continue the bisection: "OK, the
> regression was introduced in mainline at merge commit A, let's see if
> the branch being merged is bisectable", which could be recursive if the
> topic branch contains merge commits.
>
>>  - Rewrite git-bisect.sh as bisect.c and bisect.h
>>
>>  For this I plan to go along the guidelines of Paul Tan's previous
>> year work. I have followed his work and his way seems nice to go about
>> with rewriting.
>
> Please elaborate. Your proposal needs to be convincing enough that
> mentors accept to commit to mentoring the project. "I'll do like Paul
> Tan" is by far not sufficient.
>
> I'm actually not sure the same plan applies here: there's already a C
> helper for bisect, so an incremental rewrite may be more appropriate:
> port functions one by one from shell to C untill the shell part is
> empty.

Yeah, I think an incremental rewrite is more appropriate.

> I don't know the bisect code well enough to know which approach would
> work best.

Best,
Christian.
