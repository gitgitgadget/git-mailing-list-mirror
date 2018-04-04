Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC04E1F404
	for <e@80x24.org>; Wed,  4 Apr 2018 20:38:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752134AbeDDUh6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Apr 2018 16:37:58 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:53100 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751871AbeDDUh5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Apr 2018 16:37:57 -0400
Received: by mail-wm0-f48.google.com with SMTP id g8so525788wmd.2
        for <git@vger.kernel.org>; Wed, 04 Apr 2018 13:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=V+xMx+oRh3GH7JDzDJ5tdKFKgoThbV7rnwR+gZQH1Y0=;
        b=r+VmFFhnyA+GEdxQQtQvWYM9Cox4A1FCR0QcSHlr6Eu/xq9A85kUa4rGzU3aiUXTH9
         d+rlPCsIo0tJTeK6bxKkwSZoGhPSpmxdGB2sDFR+vL2TiwsrVs2e8k4QSiMOhBhTRkOl
         0el3yHDl7WqI1tcwpd1X5MO3Zr97PSYJtpDC8ZHVJEdDs5L4cfWUWZUFW2iJvnYpE9R4
         0I8zPERNvu++BN3dYfI42ce4VdhnHTTVPr2GS6X/+4LUhsWKs/Fwz1Ugap7MaXGgHUFi
         HwrgdoLgEdlygP/JFm6uxWnKT9XeerImisjEtK0c6P9MFIyegr2Rx/EtCrdk20bpo+aB
         9Crw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=V+xMx+oRh3GH7JDzDJ5tdKFKgoThbV7rnwR+gZQH1Y0=;
        b=rESeisSc2yxJWuAx+CyvrWcEmRm/LsBBK0TRldZz+AhqOCgJXfYMljOH8mqSpaw07g
         qqwbTBeWAaqQBRomqa5cofA0R3atHN6e7YXRMhW6Dx8+qq8lSzEB+GflJ5FGRo3y3vi7
         ZzSmJ1BmTzSzuNlMqjapYI5j8jxYrTYzrz9McUqCKGptS/7OERt/GNC8FCsr0vnk4XqB
         5B5oJv4HZnhEYflCsnyZ9Fzy/ZgBZDBrDI+ip6PHZ9VUUBDvZa5OzYAzV7ciM2gYh1hT
         VeYY3YfbNQRI3hx4IKUQxd3JsZa8VRX+BHXyWK8PVxMu4VSD1aoTe9ltZzpFIwhAOxC5
         CyEg==
X-Gm-Message-State: ALQs6tCiMVCyQ3uENxGig+gimudv2M/WpV8dnWjyPBARu6G7UIb2pRei
        G1ou7Vx8Q1oxZQq7Mm83veHpamntqV+j772KgCwOUoRR7U0=
X-Google-Smtp-Source: AIpwx49ywLAt/3GS45Y7FD8ejfSOxIsm5l16IgvhLfo187ygx7NPKom/cAMJcDfgmtJhd6TtYVvSemd4RZtty180ynk=
X-Received: by 10.28.211.147 with SMTP id k141mr7653553wmg.15.1522874276069;
 Wed, 04 Apr 2018 13:37:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.223.208.210 with HTTP; Wed, 4 Apr 2018 13:37:55 -0700 (PDT)
In-Reply-To: <CAGZ79kYu-9vzee=R7uE4fhhrRj19ZT0Z5+7fPLwOpXhEr7aqUw@mail.gmail.com>
References: <CAK0XTWdpKnMbXs5sq2qsERxQO20sQW6YwL=2kfBHmSwHMmunBg@mail.gmail.com>
 <20180403222053.23132-1-eddy.petrisor@codeaurora.org> <20180403222053.23132-2-eddy.petrisor@codeaurora.org>
 <CAK0XTWf=ubDK-4=FknLSFObZrShg=7UDgR5c6iNSjrwiDngayA@mail.gmail.com> <CAGZ79kYu-9vzee=R7uE4fhhrRj19ZT0Z5+7fPLwOpXhEr7aqUw@mail.gmail.com>
From:   =?UTF-8?Q?Eddy_Petri=C8=99or?= <eddy.petrisor@gmail.com>
Date:   Wed, 4 Apr 2018 23:37:55 +0300
Message-ID: <CAK0XTWdSQmfqo2-WuiPtOcn_4cf60jNZ_j9Uh_HpzxUwSpA7bw@mail.gmail.com>
Subject: Re: [RFC PATCH v3 2/2] t7406: add test for non-default branch in submodule
To:     Stefan Beller <sbeller@google.com>
Cc:     =?UTF-8?Q?Eddy_Petri=C8=99or?= <eddy.petrisor@codeaurora.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2018-04-04 21:36 GMT+03:00 Stefan Beller <sbeller@google.com>:
> On Tue, Apr 3, 2018 at 3:26 PM, Eddy Petri=C8=99or <eddy.petrisor@gmail.c=
om> wrote:
>> Notes:
>>     I am aware this test is not probably the best one and maybe I
>> should have first one test that does a one level non-default, before
>> trying a test with 2 levels of submodules, but I wanted to express the
>> goal of the patch.
>
> This patch only contains the test, I presume this goes on top of
> https://public-inbox.org/git/20180403222053.23132-1-eddy.petrisor@codeaur=
ora.org/
> which you plan to later submit as one patch including both the change as =
well as
> the test.

Yes, not sure why the emails were not linked together, I specified the
in-reply-to mesage id when I "git format-patch"-ed the patches.

I wasn't actually planning to squash them in a single patch, will do,
but I guess for now it helps to focus the discussion around the test
since the implementation is still lacking, see below 2 lines comment.

>>     Currently the test fails, so I am obviously missing something.
>> Help would be appreciated.
>>
>>
>> 2018-04-04 1:20 GMT+03:00 Eddy Petri=C8=99or <eddy.petrisor@codeaurora.o=
rg>:
>>> From: Eddy Petri=C8=99or <eddy.petrisor@gmail.com>
[..]
>>> --- a/t/t7406-submodule-update.sh
>>> +++ b/t/t7406-submodule-update.sh
>>> @@ -259,6 +259,60 @@ test_expect_success 'submodule update --remote sho=
uld fetch upstream changes wit
>>>         )
>>>  '
>>>
>>> +test_expect_success 'submodule update --remote --recursive --init shou=
ld fetch module branch from .gitmodules' '
>>> +       git clone . super5 &&
>
> I found adding "test_pause &&"
> to be a great helper as it will drop you in a shell where
> you can inspect the repository.

Thanks for the pointer, I only looked at the post-failure state after
adding --debug -i --verbose, but having "test_pause" to stop and
inspect the interim stage should help a lot with debugging.

>
>>> +       git clone super5 submodl2b2 &&
>>> +       git clone super5 submodl1b1 &&
>
> We may want to cleanup after the test is done:
>
>   test_when_finished "rm submodl2b2" &&
>   test_when_finished "rm submodl1b2" &&

Sure, will do.

>>> +       cd submodl2b2 &&
>
> I'd think the test suite prefers subshells to operate in other dirs
> instead of direct cd's, just like at the end of the test.

After looking at other tests I was under the impression that the setup
phase (e.g. creating the "server" side repos) of the test was done in
the main context, while the test case (i.e. the client side, or what
the user would do) is in subshells.

> For short parts, we make heavy use of the -C option,
> So for example the code below
>        (
>                cd super &&
>                git submodule update --recursive --init
>        ) &&
>
> can be written as
>
>     git -C super submodule update --recursive --init
>
> which is shorter.

Nice.

>>> +       echo linel2b2 > l2b2 &&
>
> style: The Git test suite prefers to have the redirect adjacent to the
> file name:
>   echo hello >world

I wasn't aware of that, it seems there are some inconsistencies,
including in the modified test:

eddy@feodora:~/usr/src/git/t$ grep '> ' -c t* 2>/dev/null | grep -v
':0$' | grep 7406
t7406-submodule-update.sh:24
eddy@feodora:~/usr/src/git/t$ grep '> ' -c t* 2>/dev/null | grep -v
':0$' | wc -l
325

I suspect that a minor patch correcting these inconsistencies would be
faily fast reviewed adn accepted, of course, disconnected from this
modification.

>>> +       git checkout -b b2 &&
>>> +       git add l2b2 &&
>>> +       test_tick &&
>>> +       git commit -m "commit on b2 branch in l2" &&
>>> +       git rev-parse --verify HEAD >../expectl2 &&
>
> So until now we made a commit in a submodule on branch b2
> and wrote it out to an expect file.

Yes, I was trying to replicate the redox-os case which has this structure:

redox-os (master branch)
   + rust (@some commit on a non-default)
          + src/llvm (@some commit on a non-default branch)

This section is making sure the b2 branch has other content than the
default one and setting the expectation for level2 submodule branch,
later.

>>> +       git checkout master &&
>>> +       cd ../submodl1b1 &&
>>> +       git checkout -b b1 &&
>>> +       echo linel1b1 > l1b1 &&
>>> +       git add l1b1 &&
>>> +       test_tick &&
>>> +       git commit -m "commit on b1 branch in l1" &&
>
> very similar to above, just in another repo
> instead of making a commit yourself, you may want to use
>     test_commit <name>
> then you don't need to call echo/add/commit yourself.

thanks for the pointer, will change that since my purpose for the
commit was to make sure default branch (master) and b1 branch are
different

>>> +       git submodule add ../submodl2b2 submodl2b2 &&
>>> +       git config -f .gitmodules submodule."submodl2b2".branch b2 &&
>>> +       git add .gitmodules &&
>>> +       test_tick &&
>>> +       git commit -m "add l2 module with branch b2 in l1 module in bra=
nch b1" &&
>
> So one submodule is made to be a submodule of the other
> with a specific branch (b2)

correct

>>> +       git submodule init submodl2b2 &&
>
> git submodule add ought to have initialized that submodule
> already, I am not sure we need the explicit init here.

I think that from my tests I saw that without it the submodule wasn't
there, but I might be mistaken, will check.

>>> +       git rev-parse --verify HEAD >../expectl1 &&
>>> +       git checkout master &&
>
> We go back to master, which doesn't have the nested submodule?

exactly, since the desired behaviour is to have in the nested
submodule the b2 branch.
I guess I could have added the level2 submodule@master on l1's master
branch, but I didn't see much point in that since it should be enough
now.

It might make more sense if master and b2, and, respectively master
and l1 have diverging histories, but for now that is probably overkill
and it will make sense in the context of shallow cloning of
submodules, which I haven't yet tackled except presenting the idea.

>>> +       cd ../super5 &&
>>> +       echo super_with_2_chained_modules > super5 &&
>>> +       git add super5 &&
>>> +       test_tick &&
>>> +       git commit -m "commit on default branch in super5" &&
>>> +       git submodule add ../submodl1b1 submodl1b1 &&
>>> +       git config -f .gitmodules submodule."submodl1b1".branch b1 &&
>>> +       git add .gitmodules &&
>>> +       test_tick &&
>>> +       git commit -m "add l1 module with branch b1 in super5" &&
>
> now we do this again without the nested submodule, just one repo
> as a submodule?

My intention was to have super5 -> submodl1b1@b1 -> submodl2b2@b2 on
the "server" side.
But are you saying I just implemented super5 -> sbmodl1b1@master due
to the previous master checkout in submodl1b1?

>>> +       git submodule init submodl1b1 &&
>>> +       git clone super5 super &&
>
> does super exist here already? (I did not check, but IIRC
> super and super{1-4} are there as we count upwards to
> find a name that is ok.

I created it in the first step of the test with the intention to have
super5 as the "server" and "super" as the client clone.

>
>>> +       (
>>> +               cd super &&
>>> +               git submodule update --recursive --init
>>> +       ) &&
>>> +       (
>>> +               cd submodl1b1 &&
>>> +               git rev-parse --verify HEAD >../../actuall1 &&
>>> +               test_cmp ../../expectl1 ../../actuall1
>>> +       ) &&
>>> +       (
>>> +               cd submodl2b2 &&
>>> +               git rev-parse --verify HEAD >../../../actuall2 &&
>>> +               test_cmp ../../../expectl2 ../../../actuall2
>>> +       )

As a general idea for a test, does it look sane?

Do you think I should I start with a just one level of submodule with
a non-default branch (super -> l1@b1), or it this OK?
In my view, having 2 levels makes sure the recursive part is also
addressed and verified.

--=20
Eddy Petri=C8=99or
