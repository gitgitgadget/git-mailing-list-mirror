Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C68CD20899
	for <e@80x24.org>; Sat,  5 Aug 2017 20:34:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751662AbdHEUeU (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 Aug 2017 16:34:20 -0400
Received: from mail-wm0-f41.google.com ([74.125.82.41]:36189 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751401AbdHEUeT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Aug 2017 16:34:19 -0400
Received: by mail-wm0-f41.google.com with SMTP id t201so42287172wmt.1
        for <git@vger.kernel.org>; Sat, 05 Aug 2017 13:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=GsXkPMkTH71UtuH3SJW494geOD/VWHur9e/uwqPRx8A=;
        b=iqz3qx9XjLAFHawFHx6iMIXowqNEW1KW9phpwzyXMrTYYrYwQJMBKLA9aPee+8dVSP
         gcIk7bc5938QocwdlmTDWc+/kxksUFWqdRPnnLQaRP4SF/5viTVD/nQMY8GjuqAzHsdb
         oEKSTzv/ZJh7wCJ/hWmx7tf/WKkSyg+h3Wa/aoelJYwXboOZvZKH9OIoLw8ZCTAsFrkN
         PVAInKxwqIjkOQN/DECNUNCGPfQuFgHeaOZJIsN+BCa6e8L+QfLdIGq/4JCwHTPyKEIF
         MZu8lCr1kClZ+YfcSCvPhli6U1HGpA5URIrrw3iTt1a0uG9c2MKJhpI/DmvvWPk5R0OO
         er2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=GsXkPMkTH71UtuH3SJW494geOD/VWHur9e/uwqPRx8A=;
        b=S4j4A9e6myT8xDRuWLAwkHk1bwufj3Fc5OGAp0l6SxtGiOH/Mx/VLoKq1O0Ug2ig5q
         dlepxpqDqb/xr42NYEJjRkfJlhZgAc8VNhzhq6mkhmPBZRA4c9eKaftocoGj/+FLAFua
         ztNGBAxslpRn92u8v1NOA1a1bHRmQYdAwtD26fJwGKXEupbadkwziW+QjSZ1wvj4X/ei
         wjt9Sz+fPtnaujPeqmEBt7y1h92mEAo+/jzb7T5G5prU7ZNW7RQTYVr+QukYIBBjZ0z9
         3U/TxP6mYPoIbOu/Wnwx4dWThuB4p2Gfc20pYjcziQWKwGTLCvo6K6SEwPWQhlSJ7mta
         YRvg==
X-Gm-Message-State: AIVw110NJeYuYTEUhpHmt7YWTLzsgSiyH83omLjwtgg3A9eVP9/TshwG
        RkpvY2x+264pBw==
X-Received: by 10.80.146.209 with SMTP id l17mr6801980eda.160.1501965257941;
        Sat, 05 Aug 2017 13:34:17 -0700 (PDT)
Received: from snth (157-157-140-194.dsl.dynamic.simnet.is. [157.157.140.194])
        by smtp.gmail.com with ESMTPSA id r19sm4069421edb.45.2017.08.05.13.34.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 05 Aug 2017 13:34:16 -0700 (PDT)
Received: from avar by snth with local (Exim 4.84_2)
        (envelope-from <avarab@gmail.com>)
        id 1de5m3-0004KY-Ge; Sat, 05 Aug 2017 22:34:15 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Sahil Dua <sahildua2305@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Jul 2017, #09; Mon, 31)
References: <xmqqfudcgryb.fsf@gitster.mtv.corp.google.com> <232547ab-3b87-debc-36a4-d2285ec10a06@ramsayjones.plus.com> <CALiud+nm9wu4rBY6zBXmenJj_0Mn7xeU_FAvSdn4fdH+q--Jag@mail.gmail.com> <xmqqd18cweak.fsf@gitster.mtv.corp.google.com>
User-agent: Debian GNU/Linux 8.9 (jessie); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <xmqqd18cweak.fsf@gitster.mtv.corp.google.com>
Date:   Sat, 05 Aug 2017 22:34:15 +0200
Message-ID: <87shh57nzs.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Aug 03 2017, Junio C. Hamano jotted:

> Sahil Dua <sahildua2305@gmail.com> writes:
>
>> Ah! I had skipped this reply from Ramsay earlier.
>>
>> On Tue, Aug 1, 2017 at 1:36 AM, Ramsay Jones
>> ...
>>>>  I personally do not think "branch --copy master backup" while on
>>>>  "master" that switches to "backup" is a good UI, and I *will* say
>>>>  "I told you so" when users complain after we merge this down to
>>>>  'master'.
>>>
>>> I wouldn't normally comment on an issue like this because I am
>>> not very good at specifying, designing and evaluating UIs (so
>>> who in their right mind would listen to me). ;-)
>>>
>>> FWIW, I suspect that I would not like using this interface either
>>> and would, therefore, not use it.
>>
>> Does that mean you'd use it when "branch --copy feature-branch
>> new-feature-branch" in the case when you would want to start working
>> on a new branch (to modify or experiment with your current feature
>> branch) on top of a branch keeping intact all the configuration and
>> logs?
>
> I am not Ramsay, but your choice of branch names in your question,
> i.e. "branch --copy feature new-feature", is what we do not agree
> with in the first place, especially when we are *on* the "feature"
> branch.
>
> We view "copy A B" as a way to make a back-up of A in B.  I.e. We
> want to keep working on A, but just in case we screw up badly, make
> a backup copy of A in B, so that we can recover by a "branch --move
> B A" later if needed.  So touching B is the last thing we want to do
> after "copy A B" operation---hence we do not want to switch to B.
>
> That is not to say that you are wrong to wish to create a new
> branch, check it out and start working on it with a single command.
> We already have such a command all Git users are accustomed to,
> which is "git checkout -b new-feature-branch feature-branch".
>
> That existing command does not copy things other than the commit
> object name from "feature-branch", and I do not think it should by
> default.  But I do not think it is wrong to extend it with a new
> option (think of it as "checkout --super-b" ;-) to copy other things
> like branch descriptions etc.
>
> So from that point of view, your new feature conceptually fits a lot
> better to "git checkout", and does not belong to "git branch".  That
> is why I do not think "git branch --copy A B" while you are on A
> should check out B after creating the copy.

We've talked how this UX should look before on-list. Rather than
re-hashing the arguments I had before I thought it was useful to present
it as a table. Here's how the patch looks now:

    |----------------------------+--------------+-------+---------+-----------------+-------------|
    | cmd                        | creates new? | moves | copies? | ...with config? | checks out? |
    |----------------------------+--------------+-------+---------+-----------------+-------------|
    | branch <name>              | Y            | N     | N       | N               | N           |
    | checkout <name>            | Y            | N     | N       | N               | Y           |
    | checkout -b <name> <start> | Y            | N     | Y       | N               | Y           |
    | branch -m <name>           | Y            | Y     | N       | Y               | Y           |
    | NEW: branch -c <name>      | Y            | N     | Y       | Y               | Y           |
    |----------------------------+--------------+-------+---------+-----------------+-------------|

In previous discussion my understanding was that you preferred the
following (as an ad-hoc word-diff)

    |----------------------------+--------------+-------+---------+-----------------+-------------|
    | cmd                        | creates new? | moves | copies? | ...with config? | checks out? |
    [... stuff above this point is the same ...]
    | NEW: branch -c <name>      | Y            | N     | Y       | Y               | {-Y, +N}    |
    |----------------------------+--------------+-------+---------+-----------------+-------------|

I.e. have "branch -c <name>" but just make it not checkout the new
thing. What you're describing above sounds to me like:

    |-------------------------------------------+--------------+-------+---------+-----------------+-------------|
    | cmd                                       | creates new? | moves | copies? | ...with config? | checks out? |
    [... stuff above this point is the same ...]
    | branch -m <name>                          | Y            | Y     | N       | Y               | Y           |
    [... so is branch -m but included for context ...]
    | NEW: checkout --super-b -b <name> <start> | Y            | N     | Y       | Y               | Y           |
    |-------------------------------------------+--------------+-------+---------+-----------------+-------------|

As (IIRC) noted in some earlier mail of mine: I don't disagree with what
you're suggesting, and this horror of a checkout/branch UX is not
something anyone would have made from scratch with the benefit of
hindsight.

However we have 2x commands that checkout branches now and do some
combination of creating, moving and copying them (with & without
config).

I think given that we have "branch -m <name>" already introducing a
"branch -c <name>" that does exactly the same thing except "leaves old
name behind" was the simplest thing both in terms of explaining it to
users and to implement, since all the code except removing the old
config section will be shared with "branch -m".

But having this "checkout --super-b -b <name> <start>" would make the UX
even uglier, since now we have a command that does 99% of what "branch
-m <name>" does, but is invoked differently.

I think this end state would make more sense:

    |----------------------------------------+--------------+-------+---------+-----------------+-------------|
    | cmd                                    | creates new? | moves | copies? | ...with config? | checks out? |
    |----------------------------------------+--------------+-------+---------+-----------------+-------------|
    | branch <name>                          | Y            | N     | N       | N               | N           |
    | checkout <name>                        | Y            | N     | N       | N               | Y           |
    | checkout -b <name> <start>             | Y            | N     | Y       | N               | Y           |
    | DEPRECATED (WARNS): branch -m <name>   | Y            | Y     | N       | Y               | Y           |
    | NEW: checkout --move -b <name> <start> | Y            | Y     | N       | Y               | Y           |
    | NEW: checkout --copy -b <name> <start> | Y            | N     | Y       | Y               | Y           |
    |----------------------------------------+--------------+-------+---------+-----------------+-------------|

I.e. let's just move this functionality to "git checkout" and deprecate
"branch -m" (which we could alias to begin with to checkout --move".

I think *that* would make sense, but not the half-assed solution of
moving a new checkout command to git-checkout while we have an analogous
checkout command in git-branch without being deprecated.
