Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 800EE1FEB3
	for <e@80x24.org>; Mon,  9 Jan 2017 21:03:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932990AbdAIVDe (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jan 2017 16:03:34 -0500
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:49157 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932505AbdAIVDd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2017 16:03:33 -0500
Received: from PhilipOakley ([92.31.218.76])
        by smtp.talktalk.net with SMTP
        id Qh6Jc7NU746SJQh6JcUP1M; Mon, 09 Jan 2017 21:03:31 +0000
X-Originating-IP: [92.31.218.76]
X-Spam: 0
X-OAuthority: v=2.2 cv=CItoZljD c=1 sm=1 tr=0 a=e6L6E7eW+5Nb7SO+DvSdIg==:117
 a=e6L6E7eW+5Nb7SO+DvSdIg==:17 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8
 a=xtxXYLxNAAAA:8 a=b-BDnhoMdUREZg4mrBcA:9 a=QEXdDO2ut3YA:10
 a=6kGIvZw6iX1k4Y-7sg4_:22 a=xts0dhWdiJbonKbuqhAr:22
Message-ID: <80DC824CA6974DF7A65A116A5CA83E01@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Robert Dailey" <rcdailey.lists@gmail.com>
Cc:     "Git" <git@vger.kernel.org>,
        "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
References: <CAHd499BREpaHHyN89a1HchyJiQzPpdo3NSfoLLGVONEmX1m19g@mail.gmail.com> <49C0981FE7D04AE2AC0BBB011FD74B90@PhilipOakley> <CAHd499CuZBXF0AddP7AfqtzvA8rBArwqtktRmNdD-kwGUCruLg@mail.gmail.com>
Subject: Re: Rebasing a branch with merges
Date:   Mon, 9 Jan 2017 21:03:32 -0000
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="utf-8";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfApr6nHpnd1puQ3dSk6sJF6to6NsNL2TVV8O7ZNd/wuN08WcSTc7sCEmVlj/PSHT2S5FvGhzkMKLTQGtSQvbEtf3QAr5mL7pOxhX/rWa/IfP98vZW5w0
 2Rx91Q5gYq29W37HiFveiC6/7vXuizA17ondzB17TNIwtcjViKEOzBNouzJq92AvU1c4/FCdeuBiJvpYNtUEVXZ8Oh0w9Aw9AamlxzNEySG18TBgiqfP8UNW
 M2YezA0YlrCrGCr0ZS9zcQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Robert Dailey" <rcdailey.lists@gmail.com>
> On Fri, Jan 6, 2017 at 3:28 PM, Philip Oakley <philipoakley@iee.org> 
> wrote:
>> From: "Robert Dailey" <rcdailey.lists@gmail.com>
>>>
>>> Here's the scenario:
>>>
>>> I create a topic branch so one other developer and myself can work on
>>> a feature that takes 2 weeks to complete. During that 2 week period,
>>> changes are occurring on master that I need in my topic branch. Since
>>> I have a collaborator on the branch, I opt for merges instead of
>>> rebase.
>>>
>>> Each day I merge from master to the topic branch, which changes code
>>> I'm actively working in and requires semantic changes (functions
>>> renamed, moved, etc).
>>>
>>> Once I'm ready to merge the topic branch back into master, I have two
>>> options (bearing in mind the goal is to keep history as clean as
>>> possible. Furthermore this implies that the constant merging into
>>> topic from master has made the topic branch look unwieldy and
>>> difficult to audit):
>>
>>
>> a broader question zero;
>> 0. Is the merge always clean? Do you always do a preparatory fixup! to
>> ensure that the merge will be clean?
>>
>> Ensuring that the merge will be clean should greatly simplify your 
>> decision
>> about process.
>
> I don't understand what you're asking. How would I do a fixup with
> merges? Can you explain a bit? Normally the only time I use fixup! or
> squash! is for local changes prior to pushing.
>

I was using 'fixup!' figuratively, rather than literally. If I understand 
the general setup correctly, what you want is that if one does a trial 
merge, then it must merge cleanly, compile and pass all tests, or if it 
doesn't, you would need to add that extra commit to ensure that you get that 
clean merge.

The alternative is that there is extra work to be done after the 'merge' 
(which may be a management choice) to then get your nice code ready for 
wider release - it may even be someone elses job to do 'integration'.

Either way, at least if you rationalise the clean end point it becomes 
easier to discuss the start point. If both ends are 'dirty' it is an open 
argument...

>>> 1. Do a squash merge, which keeps history clean but we lose context
>>> for the important bits (the commits representing units of work that
>>> contribute to the topic itself).
>>>
>>> 2. Do a final rebase prior to merging.
>>>
>>> #2 doesn't seem to be possible due to patch ordering. For example, if
>>> I have real commits after merge commits that depend on those changes
>>> from master being present as a base at that point in time, the rebase
>>> will cause the patch before it to no longer include those changes from
>>> master.
>>
>>
>> How much of the historic fixups to cover changes on master do you want to
>> keep visible? i.e. how many fork-points are truly needed (a. by you, b. 
>> by
>> the project - personal knowledge vs corporate knowledge).?
>
>
> Again, I do not understand. Maybe the first question you asked needs
> to be understood before I can answer this one. Sorry for the trouble.
>

In some scenarios it is important to keep the record of the exact start 
point (date and place) to formally justify the work performed (time eleapsed 
etc). Now given the other part of your scenario of a moving api / function 
naming etc, you now have two reference points - the original start point, 
and the release point of the new api/names.

So at that point you probably want to merge in those changes (one way or 
another), which gives you a choice of a true merge (option 1), or adding a 
patch to cherry pick the bulk changes on master (option2), or just the api 
changes (if you can isolate them) (option3). No option is inherently 
better - it will depend on local needs.

From a clean code perspective, it's nicest if you can simply rebase your 
code, but that isn't alway possible. The hard bit is to be clear about the 
local issues, and which ones are immutable. These will decide your choice.

Philip

