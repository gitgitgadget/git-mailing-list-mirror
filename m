Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E45C1F424
	for <e@80x24.org>; Thu, 21 Dec 2017 22:17:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754760AbdLUWRk (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Dec 2017 17:17:40 -0500
Received: from mail-pg0-f44.google.com ([74.125.83.44]:32838 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754566AbdLUWRj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Dec 2017 17:17:39 -0500
Received: by mail-pg0-f44.google.com with SMTP id g7so13784228pgs.0
        for <git@vger.kernel.org>; Thu, 21 Dec 2017 14:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+sQ5hBF9DBeO0aBMFk+X42kUF22w8klWT9H2/qV2Va0=;
        b=WW6N7Zd6yCCBjaNkZr967jnF9/viuJ8fHvAd7lHh8jQ9iQSDtQIcq4LY9Gsu4fknEb
         IYM64KJDu/xgu0W5x2w9q+CAbs16R/X5xdr3K/xMlzWPEZExvw2R6lbxd9AZJC7WZWwP
         hdrB+zIq3l1or2nDxArIByzjbU11rSm4Wmvf5otgCH4/sSlN0u6h+Eoylf7HscSQIFBS
         +Wdaei4ynW2Vlv0fqH2z/4TqmM2UVjIDdrciRYb6+pI75c2bB1n9ArxGeU6r7CRNPVg2
         0Azfzb4bX4cVLsK2nKCWydO0Bdz7tFRlpehr9QzlPwRmp68SJ5BMZDcFhLHVlOqw163F
         cFTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+sQ5hBF9DBeO0aBMFk+X42kUF22w8klWT9H2/qV2Va0=;
        b=ATujZvmgW/kdRCRk08MlKkjgfP/eeocXY03VpUfUAT0Jbe5Uab4YcCXqMB29Vi3xE4
         VAAQoG3YD+6vM/52V1QspJ8shMvBLkxhXSQGoOVBs3YJa9uUyqaxZyBaULCUlFdVnalT
         /l/sQDRd0x2Im7XdYHWkAqUtoYwy4REtIyHCMbJlSgJhhrmcpyMPZG49jTRuyjYIt5rd
         YV4IkJ45yd6r991B870hBrK4XqQ1M51TKOrHD32hKj3nv4oqrEqxP+ZHSV/hH53qAppy
         OEjs2mfE/c6VLJqd72layKLg4tSze9lCbaxjPMAkoiB4w2Gz7okBVlfN/8uQFlophER+
         TQ9w==
X-Gm-Message-State: AKGB3mKgGuZYoqKePcFpYPe5oO5jXbDNt/E5lcbfm6iTdwMW0AkErcwm
        bQcqdnISXJFDxo3Qc26I93fldc+PxABqYOuLQRYh/cCL
X-Google-Smtp-Source: ACJfBoscLxwkeIZeshRTAGWCo8GEUdjzPyNWYxnmCX3Hg5Jk3SXPmhe1U0xU7JxNgCwQqBNEd2CkXbyZUEiOPQeydtk=
X-Received: by 10.98.15.212 with SMTP id 81mr12064951pfp.106.1513894658502;
 Thu, 21 Dec 2017 14:17:38 -0800 (PST)
MIME-Version: 1.0
Received: by 10.100.129.8 with HTTP; Thu, 21 Dec 2017 14:17:18 -0800 (PST)
In-Reply-To: <CAGZ79kauYRLaPKsUKxvsc-T+KzMt2UsyoDLzdyZON_vjp6y28w@mail.gmail.com>
References: <CAFBGMVPBwxeSXCTcoBdxDbYtJo-38w=tf4T6-rNWuys=3drP+A@mail.gmail.com>
 <20171219180230.254881-1-sbeller@google.com> <xmqqk1xitl6l.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kbqntXuYuLGF7zjXfQ5X998QdEba20yy8A0cqS=DaRxFA@mail.gmail.com>
 <CAFBGMVO+P99hJ_nKgCJ4OqhMEdRdc3m8KHNS1pPrrhU_0wS6=A@mail.gmail.com>
 <CAGZ79kZf8GL1DY6Vmc-byEOOy+hrKF8X8qRPM6jNO-La+rD4uw@mail.gmail.com>
 <CAFBGMVMmLX4BjkQ8Xd4bQBCgoYYxWTU-p2pNF=b8JNsUsKXwUA@mail.gmail.com> <CAGZ79kauYRLaPKsUKxvsc-T+KzMt2UsyoDLzdyZON_vjp6y28w@mail.gmail.com>
From:   Andreas Urke <arurke@gmail.com>
Date:   Thu, 21 Dec 2017 23:17:18 +0100
Message-ID: <CAFBGMVOjCK_XnqJpTvPs=joXgfOH9SDWe0pJwmgYx-5-+FL+uA@mail.gmail.com>
Subject: Re: [PATCH] Re: Bug with "git submodule update" + subrepo with
 differing path/name?
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the detailed explanation. Although I am not too git savvy,
I believe I got the gist of it.

Regarding your question,
I would say the term "name" in an IT context makes me primarily think
of something that is specified by a user (as opposed to e.g. an "id"),
and can be altered by a user. Also, the manual mention it as a
"logical name", which would further strengthen my belief that it is an
abstraction which can be changed (as opposed to something "physical").
I would be much more reluctant to change the id of something than its
name.

In terms of the commands...In an ideal world I would obviously ask for
a --rename or mv command which would achieve what I wanted to do.
Other than that, maybe a word about this in the man for "git mv"? Or
perhaps "git submodule sync" could give me some kind of warning that I
did something strange/illegal.

Can I ask you, now that I have made this mess, do you have any
suggestion on how to rectify it or some other way to achieve my goal?
The only side-effect I have seen is this update problem (been running
this for a few months), but after your explanations I would like to
get back to solid ground. My use-case is that I need to follow a
specific folder-naming (i.e. subrepo path) convention, but I do not
want to use that naming as the repo name in our gitlab.

Regards,
Andreas

On 21 December 2017 at 19:55, Stefan Beller <sbeller@google.com> wrote:
> On Thu, Dec 21, 2017 at 8:21 AM, Andreas Urke <arurke@gmail.com> wrote:
>> If I am entering into undefined behavior territory with the renaming
>> then there might not be any point to pursue this further, but in any
>> case, script below:
>>
>> Apologies up-front for the verbosity, there are probably a lot of
>> unnecessary steps and git shortcuts missed - I just wanted it to
>> exactly match my scenario. Note that it is divided into two parts as
>> it requires you to edit .gitmodules.
>>
>> Part 1:
>>
>> cd ~/
>> # Make sub repos and add a commit to each
>> mkdir super && cd super
>> mkdir sub1 && mkdir sub2
>> cd sub1
>> git init && touch first && git add . && git commit -m "first"
>> cd ../sub2
>> git init && touch first && git add . && git commit -m "first"
>> cd ..
>>
>> # Make super repo, add subrepos, and commit
>> git init
>> git submodule add ./sub1
>> git submodule add ./sub2
>> git add .
>> git commit -m "first"
>>
>> # Edit .gitmodules, change sub2 name and path to sub2_newname:
>> # $ cat .gitmodules
>> # [submodule "sub1"]
>> # path = sub1
>> # url = ./sub1
>> # [submodule "sub2_newname"]
>> # path = sub2
>> # url = ./sub2_newname
>>
>
> A couple of things here:
> (a) In a script you could do this via
>     git config -f .gitmodules --rename-section <old> <new>
> (b) This is not just undefined, but rather Git explicitly assumes
>     the user does not rename the section themselves.
>
> The reason for this is found in gits history:
> 1. submodules were invented
> 2. submodule configuration such as where to obtain
>     the submodule from needs some place, and at the time
>     submodule.<path>.url inside the .gitmodules file seemed
>     like a good idea.
> 3. "What if we want git-mv, git-rm support for submodules?"
>     Or for example when bisecting and jumping between revisions
>     where the submodule exists or does not exists. To solve
>     this problem, the concept of a "submodule name" was invented,
>     such that the submodules git dir can be put into the
>     superprojects .git/modules/<name> dir, and the working tree
>     only needs to have a ".git" file pointing at that gitdir. The the
>     working tree of the submodule can be removed while keeping
>     the submodules git dir (with potentially important information
>     such as local-only commits) around! Success!
>
>     The transition path is also easy:
>     These newly "named" submodules have an additional entry of
>     'submodule.<name>.path =<path>'. Note how the subsection
>     part of the config changed its meaning, but that is ok, as the
>     name is allowed to be equal to the <path> value, and keeps
>     all config related to one submodule in one section. Easy but
>     confusing as now we have to adhere to a couple assumptions:
>     The <path> value must match where it is in the working tree,
>     the <name> however must not be changed because that is
>     where we'll find its repository inside the superproject.
>     And confusingly these two keys have often the same value,
>     for this historic reason.
>
> 4. (rather lately): We need to fix the submodule mess.
>     While in (3) we were unclear about name/path issues,
>     and tried to be super backwards compatible, now we'd
>     rather want the submodules to be well-defined. So we'll
>     try to write some docs, such as gitsubmodules [1] in addition
>     to the usage manual of "git submodule"[2]. Of course there is
>     still the description of the .gitmodules file[3].
>
> [1] https://www.kernel.org/pub/software/scm/git/docs/gitsubmodules.html
> [2] https://www.kernel.org/pub/software/scm/git/docs/git-submodule.html
> [3] https://www.kernel.org/pub/software/scm/git/docs/gitmodules.html
>
> I guess in [1] we'd want to add a discussion on what the <name> and
> what the <path> is for and why one can change but not the other.
>
> I think you ran into trouble here because you and Git had
> differing assumptions on some part of the submodule model.
> Is there any part of the documentation, configuration or some
> commands that would have helped explaining some of these things?
> (i.e. What do we best patch to help others from running into the
> same issue?)
>
> Thanks,
> Stefan
