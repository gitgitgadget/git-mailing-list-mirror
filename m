From: Stefan Beller <stefanbeller@gmail.com>
Subject: Re: GSoC Project | Improvise git bisect
Date: Sat, 19 Mar 2016 15:05:33 -0700
Message-ID: <56EDCD2D.9040806@gmail.com>
References: <CAFZEwPN-oUDNnc_PBeP2Q4msJAHenkiLtE+Oo75R+uTTwUKpYQ@mail.gmail.com>
 <vpqoaaahbvi.fsf@anie.imag.fr>
 <CAP8UFD2fudNtGpUHTYjZKXCErocuRS65E=5tH_+_tsNFbmHCBA@mail.gmail.com>
 <CAFZEwPMeejJEMjYbx1sJsH0UNygDEdtNazceOePo81Abi0dHHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Lars Schneider <larsxschneider@gmail.com>,
	Jeff King <peff@peff.net>, Troy Moure <troy.moure@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Kevin Daudt <me@ikke.info>,
	Philip Oakley <philipoakley@iee.org>, s-beyer@gmx.net
To: Pranit Bauva <pranit.bauva@gmail.com>,
	Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 19 23:05:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ahP0L-0006KH-Km
	for gcvg-git-2@plane.gmane.org; Sat, 19 Mar 2016 23:05:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932384AbcCSWFi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Mar 2016 18:05:38 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:32906 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932143AbcCSWFg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Mar 2016 18:05:36 -0400
Received: by mail-pf0-f196.google.com with SMTP id x3so23091218pfb.0
        for <git@vger.kernel.org>; Sat, 19 Mar 2016 15:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=Bm43uKKEP5F2HVFVhUN3DWkHNOq849dX7Thq4X681fg=;
        b=f4B0ykSYujJ8QMTaKAiJwgW9Is16RWjT1O4GowyIef0nQ+/Y0vtGu2BpOTY64LO8R1
         46zgYOPzgqHmlahLdo6upPqLs1Pa4kd5ebVQnqQmxTGrdBVfIQVd7pILZlI5arhovAdX
         htH/ZbuEuxH0yikHiGDBYl8TnzNP2/Q/4vgynlC2LOkvmJSiUiiXmPPlskRZe77TBeev
         oTsJSpCB+dgqhdtzGgEy6PpOGCAVTt4EVB3V8rOj4swEI6Y+mHeorVApQ2LNbTBfaAK1
         ari/Y09YsAcxx3NhQtswKRH8DAQq5lEvkseDr/k730gPOS2WWBrlgxKLWInHy1s+kGRO
         EiTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=Bm43uKKEP5F2HVFVhUN3DWkHNOq849dX7Thq4X681fg=;
        b=P1YKPs5P/4hCt9x0l0Ku4k0msjncGjUQ8fyyOtww+Fth+nP8z21pHj6266wMIHd8EO
         r4FqwP50b6sePYrEwRV5wwGe9ZcsDEdwyiBFPEhUeQ8sGqC/5CUMJ7J06odtPgEVnkQd
         h+ZrQq8/K0hX/2EJDfKRbbnTTV5lLqkKaU/quG/EABnqcuqxPP6haOtHrPDemYDujlp8
         AXAkPATqKVCcRF+D3JUMh1E7/ZNz46K70C6z7WeCiigunSX6CnyHmPJTVj1SYI7ht6Pm
         WN3IXaQIP0m6PIZ5SwkUKz9RW2KmBBIQt5PpDCh9Rwltw1pr8b5FRqcS1ar5SDD6VEYm
         brEA==
X-Gm-Message-State: AD7BkJLTLqvZX0yHXbmm7tbNQ+5Qd9sbGSZZVedb7tGQyu2pxdoMpJLdeyXEZk0RPwpXRg==
X-Received: by 10.66.167.145 with SMTP id zo17mr33660391pab.73.1458425135967;
        Sat, 19 Mar 2016 15:05:35 -0700 (PDT)
Received: from [192.168.2.6] (c-73-252-161-196.hsd1.ca.comcast.net. [73.252.161.196])
        by smtp.googlemail.com with ESMTPSA id 23sm30091217pfs.34.2016.03.19.15.05.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 19 Mar 2016 15:05:35 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
In-Reply-To: <CAFZEwPMeejJEMjYbx1sJsH0UNygDEdtNazceOePo81Abi0dHHQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289324>

On 19.03.2016 09:49, Pranit Bauva wrote:
> On Sat, Mar 19, 2016 at 9:44 PM, Christian Couder
> <christian.couder@gmail.com> wrote:
>> Hi,
>>
>> On Sat, Mar 19, 2016 at 1:48 PM, Matthieu Moy
>> <Matthieu.Moy@grenoble-inp.fr> wrote:
>>>> Subject: Re: GSoC Project | Improvise git bisect
>>>                                    ^^^^
>>>
>>> "Improve" I guess.
>>>
>>> Pranit Bauva <pranit.bauva@gmail.com> writes:
>>>
>>>> Hey everyone!
>>>
>>> Hi,
>>>
>>>> What I understood is that let's say the repository is like :
>>>>
>>>>          C13
>>>>            |
>>>>          C12
>>>>            |
>>>>          C11 (merge commit)
>>>>        /   |
>>>>      |   C10
>>>>      |     |
>>>>      |   C9
>>>>      |     |
>>>>      |   C6 (merge commit)
>>>>    C8    |   \
>>>>      |   C3    |
>>>>    C7    |     |
>>>>        \   |     C5
>>>>          C2    |
>>>>            |     C4
>>>>            |    /
>>>>           C1
>>>>  (master branch)
>>>
>>> When drawing ascii-art diagrams like this, try to use a fixed-width
>>> font. It looks ugly in my mailer.
>>
>> Ah, it looks ok in gmail.
>>
>>>> The commits numbers ie. C1...C13 are according to the time stamp, C1
>>>> being the first.
>>>
>>> One information is missing: which is the first parent.
>>
>> Yeah it is not clear but we can suppose that the first parents are
>> among C1, C2, C3,C6, C9, C10, C11, C12 and C13.
>> So the first parent of C11 would be C10 and the first parent of C6 would be C3.
>>
>>>> On starting to debug with git bisect, given that C12 is bad and C1 is
>>>> good, it starts a binary search from C1...C13. ie. It first goes to
>>>> C7,
>>
>> First if C1 is good and C12 is bad then the binary search is between C1 and C12.
>> C13 is excluded.
>>
>>> I don't think so. It tries to find a commit which cuts the graph into 2
>>> sub-graphs with roughly the same number of commits. If you pick C7, then
>>> C7 is bad, the regression may be anywhere except C1, C2, C7. This does
>>> not reduce the scope much.
>>
>> If C7 is bad then, as C1 is good the "first bad commit" is C7 or C2.
>> It's when C7 is good that C7 and C2 are excluded.
>>
>>> I guess you picked C7 because of the timestamps. "bisect" picks the
>>> commit according to the graph topology.
>>
>> Yeah. Basically it will pick the commit that is the farther away from
>> the "bad" and "good" commits.
>> That means C6 or C9 will be picked, so it looks like the graph is not
>> a good example of why --first-parent could be useful.
>>
>>>> if its all good, it goes to C10 and so on an so forth. If C7 is not
>>>> good, it goes to C4 and so on and so forth. This just makes the job of
>>>> debugging a bit difficult for a repo which has only 1 mainstream
>>>> repository and it just has some short-term branches to instantly get
>>>> stuff done.
>>>
>>> Why?
>>>
>>>> It can be simplified by using --first-parent. Given C1 is good and C12
>>>> is bad, it will find the mean between {C1, C2, C3, C6, C9, C10, C11,
>>>> C12, C13} which is C9, see if its good.
>>
>> It would find C6 or C9 even without --first-parent.
>>
>>> Do you mean that C10 is the first parent of C11, and C3 the first parent
>>> of C6? That's an un-usual graphical convention: usually we represent
>>> first parent as leftmost parent.
>>
>> Yeah.
>>
>>>> If not then it will go to C3
>>>> and then C2, if good then it will go to C6, if not good then it will
>>>> go to C5 and then C4. This will greatly simplify the job of debugging.
>>>
>>> Again, why?
>>>
>>> The missing part in your explanation is probably:
>>>
>>> Some projects do not enforce the policy "each commit must be compilable
>>> and correct", but instead consider that only commits on the mainline
>>> should have this property.
>>
>> Yeah. And there were previous discussions on the mailing list where
>> --first-parent was discussed.
>> It would be nice if they were refered to. They might talk about other
>> interesting use cases.
>>
>>> This typically allows history like
>>>
>>>  A Merge feature A
>>>  |\
>>>  | B fix bug in feature A
>>>  | |
>>>  | C fix compilation error in previous commit
>>>  | |
>>>  | D implement feature A
>>>  |/
>>>  E Merge feature B
>>>  ...
>>>
>>> When bisecting through such history, testing commits B and C is
>>> meaningless, but it still makes sense to bisect through the mainling
>>> commits A and E. In this case, we can consider that if E is good and A
>>> is bad, then the regression was introduced in A.
>>>
>>> Once we know that, we can actually continue the bisection: "OK, the
>>> regression was introduced in mainline at merge commit A, let's see if
>>> the branch being merged is bisectable", which could be recursive if the
>>> topic branch contains merge commits.
> 
> I guess I had quite a lot of conceptual doubts regarding this. I will
> search more about this.

Once upon a time, a discussion produced this proposal[1],
which tries to split up the set as good as possible (50:50) instead
of inspecting the branch/merging structure of the underlying graph.

There was a recent series on bisect by Stephan Beyer[2], who is cc'd
now, maybe he has some thoughts on improving bisect.

Thanks,
Stefan


[1]
https://docs.google.com/document/d/1hzF8fZbsQtKwUPH60dsEwVZM2wmESFq713SeAsg_hkc/edit?usp=sharing

[2] http://comments.gmane.org/gmane.comp.version-control.git/287513

> 
>>>
>>>>  - Rewrite git-bisect.sh as bisect.c and bisect.h
>>>>
>>>>  For this I plan to go along the guidelines of Paul Tan's previous
>>>> year work. I have followed his work and his way seems nice to go about
>>>> with rewriting.
>>>
>>> Please elaborate. Your proposal needs to be convincing enough that
>>> mentors accept to commit to mentoring the project. "I'll do like Paul
>>> Tan" is by far not sufficient.
>>>
>>> I'm actually not sure the same plan applies here: there's already a C
>>> helper for bisect, so an incremental rewrite may be more appropriate:
>>> port functions one by one from shell to C untill the shell part is
>>> empty.
>>
>> Yeah, I think an incremental rewrite is more appropriate.
>>
>>> I don't know the bisect code well enough to know which approach would
>>> work best.
> 
> Sorry it was a mistake on my part. I should have explained it in very
> detail. I will do it within a day.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
