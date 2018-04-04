Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 058CB1F404
	for <e@80x24.org>; Wed,  4 Apr 2018 21:42:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752282AbeDDVl6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Apr 2018 17:41:58 -0400
Received: from mail-yb0-f170.google.com ([209.85.213.170]:36097 "EHLO
        mail-yb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752117AbeDDVl5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Apr 2018 17:41:57 -0400
Received: by mail-yb0-f170.google.com with SMTP id f13-v6so1868630ybp.3
        for <git@vger.kernel.org>; Wed, 04 Apr 2018 14:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=t1jA8HoEQRTyFtyF3H1aFiyaFDhKTqAKsaApAKvR2y4=;
        b=VizQX42NmMnPfxY7CitCUq7Q4tX4PNAeT3hyuXlT4MIg+9bsRs6H7EPZW014OpOivL
         adMCtaKcR12A6TYlgB0mq64o4oRgd8OcS4WNOpNCdjS37bWT3RsTfYg9LDwFITP6lR50
         FVAr0hWBoAAJmC6c1Nqqg+5yOUqKn9380GYUDocjF9HWvnSwW+F9RyQukIpno++vCvx3
         PhQ9LWgS+B7iLUgSFmCStOlUPNZCwqWs5EWkSmjmCB+pQnOvESYBfWCcHM2s/bXjsHKC
         vElur5rAqx6yFxbuiEhEiq5sWoOIiAOa0VTiTEtU+zrryuqcDNeBD3qtcsyhbZYumCFi
         HyyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=t1jA8HoEQRTyFtyF3H1aFiyaFDhKTqAKsaApAKvR2y4=;
        b=QHgQsuOdnVEbxknn11MdmgRJxf4hf7n1gH+aXhODDiFpKZ2rnpASmAI+ur4oVBzBCZ
         XwqFuqGrN7COu/sBoG/fMqcWbQm+P0uPs/6K5GV398bvnTT7jJrvum/WFyUeDMbwzZyx
         6snpGaOijno0Qp4RTJqxQ5xjRs2FzFcza6WnojnVBAXi/ZLToc2b/NEU57JuDeY6zoDA
         lvX5jkQv+U60tZkgABBw1+nw9NVzgSuhledNiVb39p3ToLzecHm7j5rA1PlTsc16Kd2w
         VRtoMe6mvjsm1lIjP8IppNjYN43PEpyjDLfKdJD8al7t3XRd7dAg+PmeXKbyHKB2WUkC
         dEPA==
X-Gm-Message-State: ALQs6tDzGHFbCTgWem6TTGtZpIwb6VN6qIjtxNXH7fTl6dH05cy5OeBO
        69mCpeUBkqX9OCpwulxURx1XHnQIMHs57SpGIhTHrQ==
X-Google-Smtp-Source: AIpwx48GWUUoMNPe1t1XAng+JEge6A+e0xvQdUbKQtUDMdGfYupNLLyu2pKYrOZeMHzqsgHGt9a2KV+8F6hq178j3Wo=
X-Received: by 2002:a25:2782:: with SMTP id n124-v6mr6065325ybn.307.1522878115887;
 Wed, 04 Apr 2018 14:41:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf81:0:0:0:0:0 with HTTP; Wed, 4 Apr 2018 14:41:55 -0700 (PDT)
In-Reply-To: <CAK0XTWdSQmfqo2-WuiPtOcn_4cf60jNZ_j9Uh_HpzxUwSpA7bw@mail.gmail.com>
References: <CAK0XTWdpKnMbXs5sq2qsERxQO20sQW6YwL=2kfBHmSwHMmunBg@mail.gmail.com>
 <20180403222053.23132-1-eddy.petrisor@codeaurora.org> <20180403222053.23132-2-eddy.petrisor@codeaurora.org>
 <CAK0XTWf=ubDK-4=FknLSFObZrShg=7UDgR5c6iNSjrwiDngayA@mail.gmail.com>
 <CAGZ79kYu-9vzee=R7uE4fhhrRj19ZT0Z5+7fPLwOpXhEr7aqUw@mail.gmail.com> <CAK0XTWdSQmfqo2-WuiPtOcn_4cf60jNZ_j9Uh_HpzxUwSpA7bw@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 4 Apr 2018 14:41:55 -0700
Message-ID: <CAGZ79kbT+AnVu-AJ9=OSt=Z2ErM5ocfoLfgx=qmHFfbnkqJqwg@mail.gmail.com>
Subject: Re: [RFC PATCH v3 2/2] t7406: add test for non-default branch in submodule
To:     =?UTF-8?Q?Eddy_Petri=C8=99or?= <eddy.petrisor@gmail.com>
Cc:     =?UTF-8?Q?Eddy_Petri=C8=99or?= <eddy.petrisor@codeaurora.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 4, 2018 at 1:37 PM, Eddy Petri=C8=99or <eddy.petrisor@gmail.com=
> wrote:

>> This patch only contains the test, I presume this goes on top of
>> https://public-inbox.org/git/20180403222053.23132-1-eddy.petrisor@codeau=
rora.org/
>> which you plan to later submit as one patch including both the change as=
 well as
>> the test.
>
> Yes, not sure why the emails were not linked together, I specified the
> in-reply-to mesage id when I "git format-patch"-ed the patches.

They are linked in public-inbox, but I noticed too late. (in gmail
they were not)

> Thanks for the pointer, I only looked at the post-failure state after
> adding --debug -i --verbose, but having "test_pause" to stop and
> inspect the interim stage should help a lot with debugging.

I also like the -x flag that stops at the failing test, but as this is the
last test of this script it is of limited use here.

> After looking at other tests I was under the impression that the setup
> phase (e.g. creating the "server" side repos) of the test was done in
> the main context, while the test case (i.e. the client side, or what
> the user would do) is in subshells.

This roughly coincides, as the client is usually in a new clone. :)

>> style: The Git test suite prefers to have the redirect adjacent to the
>> file name:
>>   echo hello >world
>
> I wasn't aware of that, it seems there are some inconsistencies,
> including in the modified test:
>
> eddy@feodora:~/usr/src/git/t$ grep '> ' -c t* 2>/dev/null | grep -v
> ':0$' | grep 7406
> t7406-submodule-update.sh:24
> eddy@feodora:~/usr/src/git/t$ grep '> ' -c t* 2>/dev/null | grep -v
> ':0$' | wc -l
> 325

Thanks for digging up numbers!

> I suspect that a minor patch correcting these inconsistencies would be
> faily fast reviewed adn accepted, of course, disconnected from this
> modification.

There are two schools of thought, one of them is to fix things up
whenever you see fit. I am very sympathetic to this one.

The other is found in Documentation/CodingGuidelines:

 - Fixing style violations while working on a real change as a
   preparatory clean-up step is good, but otherwise avoid useless code
   churn for the sake of conforming to the style.

   "Once it _is_ in the tree, it's not really worth the patch noise to
   go and fix it up."
   Cf. http://lkml.iu.edu/hypermail/linux/kernel/1001.3/01069.html

> Yes, I was trying to replicate the redox-os case which has this structure=
:
>
> redox-os (master branch)
>    + rust (@some commit on a non-default)
>           + src/llvm (@some commit on a non-default branch)
>
> This section is making sure the b2 branch has other content than the
> default one and setting the expectation for level2 submodule branch,
> later.

Oh, cool!

>
>>>> +       git rev-parse --verify HEAD >../expectl1 &&
>>>> +       git checkout master &&
>>
>> We go back to master, which doesn't have the nested submodule?
>
> exactly, since the desired behaviour is to have in the nested
> submodule the b2 branch.

Well if the nested submodule doesn't exist at HEAD, then git should
not change branches in there, only on checking out/ updating to a state
that has the nested sub? (I may missunderstand things here)

> I guess I could have added the level2 submodule@master on l1's master
> branch, but I didn't see much point in that since it should be enough
> now.
>
> It might make more sense if master and b2, and, respectively master
> and l1 have diverging histories, but for now that is probably overkill
> and it will make sense in the context of shallow cloning of
> submodules, which I haven't yet tackled except presenting the idea.

ok.

>
>>>> +       cd ../super5 &&
>>>> +       echo super_with_2_chained_modules > super5 &&
>>>> +       git add super5 &&
>>>> +       test_tick &&
>>>> +       git commit -m "commit on default branch in super5" &&
>>>> +       git submodule add ../submodl1b1 submodl1b1 &&
>>>> +       git config -f .gitmodules submodule."submodl1b1".branch b1 &&
>>>> +       git add .gitmodules &&
>>>> +       test_tick &&
>>>> +       git commit -m "add l1 module with branch b1 in super5" &&
>>
>> now we do this again without the nested submodule, just one repo
>> as a submodule?
>
> My intention was to have super5 -> submodl1b1@b1 -> submodl2b2@b2 on
> the "server" side.
> But are you saying I just implemented super5 -> sbmodl1b1@master due
> to the previous master checkout in submodl1b1?

No. I was a little confused about the code.

>
>>>> +       git submodule init submodl1b1 &&
>>>> +       git clone super5 super &&
>>
>> does super exist here already? (I did not check, but IIRC
>> super and super{1-4} are there as we count upwards to
>> find a name that is ok.
>
> I created it in the first step of the test with the intention to have
> super5 as the "server" and "super" as the client clone.

oh, ok.

>
>>
>>>> +       (
>>>> +               cd super &&
>>>> +               git submodule update --recursive --init
>>>> +       ) &&
>>>> +       (
>>>> +               cd submodl1b1 &&
>>>> +               git rev-parse --verify HEAD >../../actuall1 &&
>>>> +               test_cmp ../../expectl1 ../../actuall1
>>>> +       ) &&
>>>> +       (
>>>> +               cd submodl2b2 &&
>>>> +               git rev-parse --verify HEAD >../../../actuall2 &&
>>>> +               test_cmp ../../../expectl2 ../../../actuall2
>>>> +       )
>
> As a general idea for a test, does it look sane?

Yes, I think it is a sane approach. Thanks for writing such a test!

> Do you think I should I start with a just one level of submodule with
> a non-default branch (super -> l1@b1), or it this OK?
> In my view, having 2 levels makes sure the recursive part is also
> addressed and verified.

I totally agree.

Stefan
