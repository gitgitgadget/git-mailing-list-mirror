Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A4022018E
	for <e@80x24.org>; Fri,  5 Aug 2016 18:00:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161580AbcHER7s (ORCPT <rfc822;e@80x24.org>);
	Fri, 5 Aug 2016 13:59:48 -0400
Received: from mail-it0-f45.google.com ([209.85.214.45]:34841 "EHLO
	mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161510AbcHER7k (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Aug 2016 13:59:40 -0400
Received: by mail-it0-f45.google.com with SMTP id u186so28093056ita.0
        for <git@vger.kernel.org>; Fri, 05 Aug 2016 10:59:39 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=P3rQia29CDtdQNoHITPJCPdghXfRdobSWMghaeuBO08=;
        b=ohmwq4C6QC9oMM/nrF+ozSqxhCF2vha1Ztwr5nU/5VTzP7q8RU6IPfoTRZoNaF6QJJ
         gdj51pMOnB43T95ieD0KTp0hyhG9HJcFrKM3pINnOwEAk0qpm/fW4ijhRgqhTdDdq8Wd
         nV9M+c/NVvSTJIbB76dXV+JnuRCPG6aZudHZ8y9/A2Ig7aH6nGYPbe7BixPhaXz3z1RJ
         Ha4gx0OnpeCIgb22rtgbe/3j9yRfz/ZFidl4YZ+7Id+wQBID22CbowzuXVUX+s91hI5n
         1PHcYCBpV9SF+wm11xVdilFoG4tMKw7ph9vcB582sAVhqd6AIrbpOKQMNg+VnF69GgYl
         1WRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=P3rQia29CDtdQNoHITPJCPdghXfRdobSWMghaeuBO08=;
        b=Nk/qzhg7HDUfXcG/HA/g6Lp/l49s9NDeS1WGC67jk2w5kOTAWMcl5IJJ4vbGLMcyjJ
         oqTN/CE9Htu068HGrqhbXQSSnY5MGm8bbVggrnkUfZg/5D6M7r8LTydMsi8ayrp5mccH
         ePLQfevnqV9P8QNSrq9l8eQTIUTHFugtuCKo5wb5AKS6w1ON5sCoq3U4BAvyEZRV4Aea
         5UlZ6lzaOB6tDgHBGN5xL1LyTtSZXKzbel8DmrFJpIy38xaFLu66/BUBnAisOQupwRbA
         x0KXjNHN3T4fLaq/ld2Bb3tvZ2Aq7NXKWbYVXSHPzC6f5+59S1uh/MXQFSDmEg0zaQ8c
         QZTA==
X-Gm-Message-State: AEkoous+pjd14vk3mmgPLGOUFfm8tp2uQ4MVG6LmEgnnNp1LSyIYNTefYnEAaCJVaLOmv2H6vteYPXP1iGEYJhLd
X-Received: by 10.36.228.138 with SMTP id o132mr5799645ith.49.1470419978338;
 Fri, 05 Aug 2016 10:59:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Fri, 5 Aug 2016 10:59:37 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1608050925240.5786@virtualbox>
References: <cover.1469547160.git.johannes.schindelin@gmx.de>
 <cover.1470051326.git.johannes.schindelin@gmx.de> <8ff71aba37be979f05abf88f467ec932aa522bdd.1470051326.git.johannes.schindelin@gmx.de>
 <xmqqlh0gjpr6.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1608021004080.79248@virtualbox>
 <xmqqy44ec15p.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1608031021050.79248@virtualbox>
 <CAPc5daXJzMsJf5K84XBFuQ5=q_OwtYUW2FikZ2QsZWk8fa9jgg@mail.gmail.com>
 <alpine.DEB.2.20.1608031753431.107993@virtualbox> <CAGZ79kYWdZCNW_eBi5aLAacyBZJXQ9xyOWMBmjNsYT5NWjr-Og@mail.gmail.com>
 <alpine.DEB.2.20.1608041730130.5786@virtualbox> <CAGZ79kaTT3NgKj8akB8t9b1BF3i6sXe7Un9oq5KP8077Wz-E+g@mail.gmail.com>
 <alpine.DEB.2.20.1608050925240.5786@virtualbox>
From:	Stefan Beller <sbeller@google.com>
Date:	Fri, 5 Aug 2016 10:59:37 -0700
Message-ID: <CAGZ79ka5OknKYo_CgBpB16EQjwU5B35yNFWx569K-LPmHuSqWA@mail.gmail.com>
Subject: Re: patch submission process, was Re: [PATCH v6 06/16]
 merge_recursive: abort properly upon errors
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Johannes,

On Fri, Aug 5, 2016 at 1:20 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Stefan,
>
> On Thu, 4 Aug 2016, Stefan Beller wrote:
>
>> On Thu, Aug 4, 2016 at 8:58 AM, Johannes Schindelin
>> <Johannes.Schindelin@gmx.de> wrote:
>> >
>> >> If we were to change our workflows drastically, I'd propose to go a
>> >> way[1] similar to notedb in Gerrit, or git-series,
>> >
>> > Gerrit is a huge, non-distributed system. Complex, too. If we change
>> > the patch submission process, we should make things *easier*, not
>> > *harder*. So I think Gerrit is pretty much out of the question.
>>
>> I did not propose to use Gerrit or git-series or git appraise.
>>
>> However whenever I see these projects talking to each other, the talk
>> focuses on a "unified review storage format" pretty often, which would
>> make them compatible with each other.
>
> Unless you have a splendid idea how to integrate that unified format with
> our review process on the mailing list, I think this makes for a fine
> discussion elsewhere. I'd really like to focus on the Git project and its
> patch contribution process in this here thread.
>
>> So then I could choose git-series, while you could go with git appraise
>> (although that is written in go, so maybe too fancy already ;)
>
> I think you misunderstood me in a big way.
>
> New languages are awesome. I play with new toys whenever I find the time
> (and streamlining the contribution process would give me more time for
> that). You are talking to a person who implemented the Householder
> transformation in Postscript, a 6502 assembler in Forth, and a music
> composing system in Emacs Lisp. No language is to fancy for me. "me", as
> in "me, personally".
>
> Now let's think about Git for a moment, and its language choices, and the
> rationale behind them. The majority of the critically important code is
> written in C. Is C a good language? Decent, yes, but of course also
> limiting, Resource leaks are very easy to overlook, and we have a share of
> them. No object orientation, so when we need to "subclass", we have no
> compile time safety. The pre-processor constructs make static analysis
> nigh impossible. Plenty of downsides. So why was it chosen? Developers are
> *familiar* with it, that's why. Similar considerations apply to the use of
> shell scripts, and to Perl, to a certain extent.

Which is changing slowly over time IMHO. The "new generation" of
developers may not have in-depth knowledge of shelll or perl any more,
but rather python or java maybe.

>
> I am not talking about contrib/ of course. That's fair game, it contains
> only non-critical/fringe stuff.
>
> Note that the same rationale goes for choosing to accept patch submissions
> via mail to a list that is not subscribers-only.
>
> When it comes to inviting developers to contribute to your project,
> personal preferences become irrelevant, the deciding factor becomes how
> easy it is to join. Is the language popular, many developers already
> familiar with it? Is the build system readily available? Are the
> maintainers responsive?

I agree. I really do.

I had some discussion at lunch yesterday about different attitudes of open
source projects towards new contributions. An example was the Eclipse
projects that scare off potential new contributors (specially these
fly by single patch submissions) as you need to interact through their
instance of Gerrit after signing a CLA.


Git on the other hand doesn't do
a bad job, e.g. I started with a patch that ought to be a single shot drive
by patch. About 780 others wrote one patch and were never seen again:

    $ git shortlog -sne |grep 1 |wc -l
    788

So our process is not too bad for the time. However email is as a
communication tool is dying [1] eventually?

Let's examine if we get less one time contributions over time:

    for i in $(seq 11 -1 1) ; do
        x_1=$(git shortlog -sne --since $i.years --until
$(($i-1)).years |grep 1 |wc -l)
        printf "$i\t$x_1\n"
    done

11       81
10       94
9        175
8        148
7        139
6        118
5        108
4        149
3        109
2        106
1        99

Looking at these numbers the number of one time patch contributions
spiked 9 years ago and declined since then (4 years ago seems to be
an outlier)

And I do not think the decline of one off contributions is because Git as
a project is in decline, but has other reasons. Maybe the project is in better
shape now that there are less one-off worthy contributions? Or the
contribution process is not appealing to a lot of new comers?

[1] I could not find a scientific paper that evaluates communcation
habits of people, but these may give a feel for it:
https://www.quora.com/Why-are-young-people-abandoning-email
https://news.ycombinator.com/item?id=3554466
http://www.twistimage.com/blog/archives/nobody-uses-email-anymore/
http://www.emailisnotdead.com/

>
> I vividly remember my reaction to Darcs, for example. It's written in
> Haskell. I am a mathematician originally, so Haskell appeals to me. Did
> the choice of language appear to be designed to keep contributors out? To
> me, it looked that way.
>
> Other example: submitGit. I really like what its intention. For a while, I
> even hoped to move my *own* patch submissions to submitGit. I planned to
> help get the kinks out of the code by contributing to it. It is written in
> Scala, using a web application and testing framework I have not
> encountered elsewhere. I struggled with installing it locally and wrapping
> my head around the coding paradigms, for 1.5 days (which was all I could
> afford at that time). Then I had to give up. Which made me very sad. I
> would not have written my mail-path-series.sh tool if submitGit had been
> written in node.js, for example, with which I am familiar enough to jump
> right in.

Why did you desire to set it up yourself and not just use it?
(I'd guess one of the underlying reasons could be sticking to FOSS principles,
i.e. you want to be in control of what you use; But there I would argue to
just approach it pragmatically. When it ceases to exist, there is time to
look for an alternative.)

>
> So I hope you understand better now why I find Rust a poor choice for
> something like git-series, because it should not waste contributors' time
> by insisting that their price of entry is learning a new language they are
> unfamiliar with, using a new packaging system, installing a new build
> setup. I would find Clojure, Crystal or Swift just as poor a choice. Even
> node.js. It is just too much of a "Keep Out" sign for busy developers. And
> all the developers worth their salt are busy.

Ideally you would not need to touch the internals of said tool, hence no
need to learn Rust? Of course no tool is perfect, so eventually you'd want
to look at the internals.

You can take the same argument for our current contribution process.
Is it easier to learn a new language or setup a proper mail client that
doesn't screw up your emails?
Depending on the language, it is really easy to get started
and have some results out in a day or two.

>
>> > Additionally, I would like to point out that defining a way to store
>> > reviews in Git is not necessarily improving the way our code
>> > contribution process works. If you want to record the discussions
>> > revolving around the code, I think public-inbox already does a pretty
>> > good job at that.
>>
>> Yeah recording is great, but we want to talk about replying and
>> modifying a series? So if I see a patch flying by on the mailing list,
>> ideally I could attach a "!fixup, signed off by Stefan" thing to that
>> patch. (I said "thing" as I do not necessarily mean email here.
>
> Right. I briefly considered suggesting a new tool that would operate on
> attachments, integrating tightly with the local git.git checkout. Briefly.
> I had to reject this idea because I do not think that requiring new tools
> just to contribute to Git would fly well.

Well it would be part of Git?
I consider Git a toolbox that has all kinds of useful tools to deal with
code, i.e. transporting, diffing, storing. And transporting is a broad
category: we have push/pull with various protocols,
bundles for sneaker net and send-email for "pushing over email".

So we can have another transport tool that helps our own workflow?

>
>> > I guess I have no really good idea yet, either, how to retain the ease
>> > of access of sending mails to the list, yet somehow keep a strong tie
>> > with the original data stored in Git.
>>
>> Does it have to be email? Transmitting text could be solved differently
>> as well.
>
> Well, you can only convince old-timers like Junio and Peff incrementally,
> by showing them something that makes their life easier, and that they do
> not *have* to use.
>
> Additionally, keep in mind that the single thing *all* potential
> contributors have in common is access to email.

As I said above, this may not be true any more in the far future.
However I guess email is still a good base layer.


>
> So yes, I think that any improvement would have to happen incrementally,
> opt-in. Meaning: on top of the current process.

The current process is free text on a mailing list for replies, so developing
a tool on top of this "data format" is really hard.

>
>> With git push/fetch we can interact with a git remote and pertain the
>> state (commits, ancestor graph) at a full level even including notes
>> that comment on commits.
>
> Including much more, in fact: *any* kind of data.
>
> But how to build on top of the current process, where some reviewers jump
> in via NNTP, for crying out loud? How to ensure the integrity between what
> is flying around as mails and what is present in the Git repository?

Currently we don't. It breaks all the time. (C.f. Junio: "This is whitespace
broken,; no need to resend I'll fix it up locally")

>
>> git send-email/format-patch recently learned to include a base commit
>
> You may have noticed that my mail-patch-series.sh-generated code
> submissions contain that base commit. But they still do not contain the
> SHA-1s of my local commits corresponding to the patches, and even if they
> did, the replies with suggested edits would most likely have lost said
> information.
>
> I also hate to break it to you that git-send-email is not going to be part
> of any solution.

It's written in perl, so it's not one of the core parts of Git that you
mentioned above. I do use it though for my submission process.

But both send-email as well as mail-patch-series as well as git-series
are all about the *sending* part. Not about the back and forth part, i.e.
these don't deal with: "here is a fixup on top". And by that I mean
receiving mails and applying them. git-am is there as a front-end
once you obtained the mail, but from what I get, your original problem
is to get up to date with the latest state, that is either in pu or a proposed
fixup mail on top of your series?

>
>> You wrote:
>> > In short, I agree that our patch submission process is a saber tooth
>> > tiger that still reflects pre-Git times. While we use Git's tools, the
>> > workflow really tries to cut out Git as much as possible, in favor of
>> > pure mails with non-corrupted, non-HTML patches in them, a charmingly
>> > anachronistic requirement until you try to use state-of-the-art mail
>> > clients to send them.
>>
>> And there are two ways out:
>> * either we teach git how to deal with emails (completely, i.e.
>> sending+receiving)
>> * or we change the development model (e.g. no emails any more)
>>
>> There is no golden third way IMHO.
>
> There are plenty more options.
>
> In Git for Windows, I would accept patches via mail (curiously, nobody
> tried that in the past 12 months, not that I recall). I accept Pull
> Requests. I try to use patches mentioned in issue comments (!) and apply
> them.

That is great!

>
> The point is: you do not *have* to limit yourself to accepting patches
> *only* in one way.

I am not sure who the "you" is here.

You said:

> Well, you can only convince old-timers like Junio and Peff incrementally,
> by showing them something that makes their life easier, and that they do
> not *have* to use.

They like email and it works for them. Are you suggesting Junio and Jeff
should accept pull request like you do?

For me as a contributor, I'll just use email for now for exactly this reason.
I have it setup and know the quirks (which I occasionally forget, so it breaks
again), but it is working "good enough".

>
> Another option would be to come up with a non-opinionated tool that helps
> with submitting *and accepting* patches via mail. Non-opinionated, as in:
> it does not expect to write an entire raw mail and have that entire raw
> mail transmitted intact. It could, for example, generate human-consumable
> plain text and *also* an attachment that the tool understands. This tool
> could then even show a GUI to help with inspecting the relevant
> code/patches.

So a new email client that is specially adapted to the needs of the
Git workflow?

>
> Yet another option would be to have a tool that integrates with the Git
> repository of the Git mailing list represented by public-inbox.

So my first reaction to that would be: you could push you patches to
that public inbox and it is translated to emails sent on your behalf.

Which is reinventing submitGit just in a more accessible language?

>
> Plenty more options.
>
> Ciao,
> Dscho

Thanks for writing such a long email, I missed some of the
more subtle points before indeed.

Thanks,
Stefan
