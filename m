Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69D3E1F453
	for <e@80x24.org>; Fri, 26 Apr 2019 13:55:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbfDZNz5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Apr 2019 09:55:57 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34247 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbfDZNz5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Apr 2019 09:55:57 -0400
Received: by mail-ed1-f68.google.com with SMTP id a6so3280369edv.1
        for <git@vger.kernel.org>; Fri, 26 Apr 2019 06:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=ueDYroBTgLr5cmVeG2OZHd84kAlkvf/qIAq26gbJJ3M=;
        b=Vbs2R1ljldeLENw0P+BjNI//6meIh7UUnQkUSBnZptMjzKHJp5POHbBhzXXFhGcb5Z
         9etkQX9QKBJ855hmDQSMDDCdTcyv3fMsqhzeuGXGQO8Kt58LfMJiel+TMr4XBgEVMNen
         I8zK8Xm+Dgwj7/4DEZ1sLlP+vMGXGy5efF0HJEP2cjrbJg9O0P/NphBnGBXcUmjBj88m
         4fcDNkWJYtxgJ7ifCPIso8CKZZ7HATXKMChi7JOJ6xhu+9QSvX4uWRYloKVtHs+gTcDD
         EoDNTU43NlSeUPTGga+hv3ZDIUCAFkLfVRevrF4Q5KYXU8VMsIK6A82pNM+vmL8ajoKh
         8IMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=ueDYroBTgLr5cmVeG2OZHd84kAlkvf/qIAq26gbJJ3M=;
        b=nZtqdlLF7D1XUoHecr3MHxswnUm5wB3bP9j6HDldfYXmNDAc+uFRHihFpCpXXZygif
         TOAvFjopRbqfc/N73yJBsO43nZnYYS1/VeuSJXrkcoIxgcRIjaT+xnrpG7ZCbrHaEkx6
         fzIcgT8/cee/n9PjOCpziVXem3OYcwkJ5S6qhsGQ+G2rsSXavawxiYGwL8obobFFBpRT
         ktQZ3L4ZNV4F0y3CyzQ/Vgxw7+zwy8MPJo26IhMgwVR5GdCtA3c/gMo3d41eMA5MQZVj
         oc06/sW7rhCptGYAhbh8mbBPSbs8fqLTZ3Qz5Si8cIGY6UGwH5jelM4Jd0HQDGJ+B5Y0
         aVAA==
X-Gm-Message-State: APjAAAVyD6AkTUwP6p3zuZtCba4LIF4Vv0Ar7Je3WeieNP0Y2cSQxckl
        bAICyzQYYvSwxYgJ5mXt3QI=
X-Google-Smtp-Source: APXvYqwnkEqIg3cssn6Oor/zGcKZ+G12gQza+M9oHl8OOpOWrBgfdXeQ0/GgXlhXnRCZPfyfXSv1nQ==
X-Received: by 2002:a50:b513:: with SMTP id y19mr5941262edd.100.1556286954233;
        Fri, 26 Apr 2019 06:55:54 -0700 (PDT)
Received: from evledraar ([5.57.21.49])
        by smtp.gmail.com with ESMTPSA id w10sm6998522edh.62.2019.04.26.06.55.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Apr 2019 06:55:53 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, sandals@crustytoothpaste.net,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/5] Create commit-graph file format v2
References: <pull.112.git.gitgitgadget@gmail.com> <pull.112.v2.git.gitgitgadget@gmail.com> <87a7gdspo4.fsf@evledraar.gmail.com> <xmqqef5pwldc.fsf@gitster-ct.c.googlers.com> <878svxrwsh.fsf@evledraar.gmail.com> <0a8fb6ec-d35c-45d7-3442-0e8298efca4b@gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <0a8fb6ec-d35c-45d7-3442-0e8298efca4b@gmail.com>
Date:   Fri, 26 Apr 2019 15:55:51 +0200
Message-ID: <874l6kswew.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Apr 26 2019, Derrick Stolee wrote:

> On 4/26/2019 4:33 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>
>> On Fri, Apr 26 2019, Junio C Hamano wrote:
>>>
>>> Thanks always for your careful review and thoughtful comments, by
>>> the way.
>
> I agree that these comments are extremely helpful.
>
>>>> Now as noted in my series we now on 'master' downgrade that to a warni=
ng
>>>> (along with the rest of the errors):
>>>>
>>>>     $ ~/g/git/git --exec-path=3D$PWD status
>>>>     error: commit-graph version 2 does not match version 1
>>>>     On branch master
>>>>     [...]
>>>>
>>>> ...and this series sets the default version for all new graphs to v2.>=
>>> The phrasing seems odd.  It is unclear, even to me who is vaguely
>>> familiar with the word "commit-graph" and is aware of the fact that
>>> the file format is being updated, what
>>>
>>>     "commit-graph version 2 does not match version 1"
>>
>> Yeah it should really say:
>>
>>     "commit-graph is of version 2, our maximum supported version is 1"
>
> I agree this phrasing is better. Please see the patch I just submitted [1]
> to try and improve these messages.
>
> [1] https://public-inbox.org/git/pull.181.git.gitgitgadget@gmail.com/
>
>> Hindsight is 20/20, but more generally I wonder if we should have these
>> format versions match that of the git version (unlikely to change it
>> twice in the same release...) which would allow us to say things like:
>>
>>     "commit-graph needs v2.22.0 or later, we have the version written by=
 v2.18.0..v2.21.0"
>>
>> But of course dealing with those larger integers in the code/gaps is
>> also messy :)
>
> There are a couple issues with using the version numbers, from my
> perspective:
>
> 1. We don't do that anywhere else, like the index file.
>
> 2. The microsoft/git fork takes certain performance changes faster
>    than core git, and frequently ships versions between major version
>    updates. Our 2.17 had the commit-graph, for instance. It's also
>    possible that we'd take commit-graph v2 earlier than the core Git
>    major release.

Good points. I'm just blathering on and playing architecture astronaut
:)

>>> wants to say.  Do I have version #2 on disk and the running binary
>>> only understands version #1?  Or do I have version #1 on disk and
>>> the binary expected version #2?  How would I get out of this
>>> situation?  Is it sufficient to do "rm -f .git/info/commit-graph*"
>>> and is it safe?
>>
>> Yeah. An rm of .git/info/commit-graph is safe, so is "-c
>> core.commitGraph=3Dfalse" as a workaround.
>
> That is true. I'm not sure the error message is the right place to
> describe the workaround.

Yeah for sure, it should Just Work...

>> I'd say "let's improve the error", but that ship has sailed, and we can
>> do better than an error here, no matter how it's phrased...
>>
>>>> I think this is *way* too aggressive of an upgrade path. If these
>>>> patches go into v2.22.0 then git clients on all older versions that gr=
ok
>>>> the commit graph (IIRC v2.18 and above) will have their git completely
>>>> broken if they're in a mixed-git-version environmen.>
>> I should note that "all older versions..." here is those that have
>> core.commitGraph=3Dtrue set. More details in 43d3561805 ("commit-graph
>> write: don't die if the existing graph is corrupt", 2019-03-25).
>>
>>>> Is it really so important to move to v2 right away that we need to risk
>>>> those breakages? I think even with my ab/commit-graph-fixes it's still
>>>> too annoying (I was mostly trying to fix other stuff...). If only we
>>>> could detect "we should make a new graph now" ....
>>>
>>> True.
>
> You are right, this is too aggressive and I should have known better. I'll
> update in the next version to keep a default to v1. Not only do we have t=
his
> downgrade risk, there is no actual benefit in this series alone. This only
> sets up the ability for other features.
>
>> Having slept on my earlier
>> https://public-inbox.org/git/87a7gdspo4.fsf@evledraar.gmail.com/ I think
>> I see a better way to deal with this than my earlier suggestion that we
>> perform some version flip-flop dance on the single "commit-graph" file:
>>
>> How about just writing .git/objects/info/commit-graph-v2, and for the
>> upcoming plan when where they'll be split have some dir/prefix there
>> where we include the version?
>>
>> That means that:
>>
>>  1. If there's an existing v1 "commit-graph" file we don't write a v2 at
>>     that path in v2.22, although we might have some "write v1 (as well
>>     as v2?) for old client compat" config where we opt-in to do that.
>>
>>  2. By default in v2.22 we read/write a "commit-graph-v2" file,
>>     preferring it over the v1 "commit-graph", falling back on earlier
>>     versions if it's not there (until gc --auto kicks in on v2.22 and
>>     makes a v2 graph).
>>
>>  3. If you have concurrent v2.21 and v2.22 clients accessing the repo
>>     you might end up generating one commit-graph or the other depending
>>     on who happens to trigger "gc --auto".
>>
>>     Hopefully that's a non-issue since an out-of-date graph isn't
>>     usually a big deal, and client versions mostly march forward. But
>>     v2.22 could also learn some "incremental gc" where it says "my v2 is
>>     older, v1 client must have refreshed it, I'll refresh mine/both".
>>
>>  4. v2.22 and newer versions will have some code in git-gc where we'll
>>     eventually readdir() .git/objects/info and remove graphs that are
>>     too old per some new config (say
>>     "gc.pruneOlderCommitGraphVersions=3D180 days").
>>
>> This means that:
>>
>>  A. GOOD: Now and going forward we can fearlessly create new versions of
>>     the graph without worrying/testing how older clients deal with it.
>>
>>  B. BAD: We are going to eat ~2x the disk space for commit-graphs while
>>     such transitions are underway. I think that's fine. They're
>>     relatively small compared to .git/objects, and we'll eventually "gc"
>>     the old ones.
>
> We could also write 'commit-graph-v2' and delete 'commit-graph' and if
> someone downgrades they would just have a performance issue, not a failur=
e.
>
>>  C. BAD: Different versions of git might perform wildly differently (new
>>     version slower) since their respective preferred graph versions
>>     might have a very different/up-to-date number of commits v.s. what's
>>     in the packs.
>>
>> I think "A" outweighs "B" && "C" in this case. It's "just" a caching
>> data structure, and git works without it. So we can be a lot looser than
>> say updating the index/pack format.
>>
>> Worst case things slow down but still work, and as noted in #3 above if
>> we care it can be mitigated (but I don't, I think we can safely assume
>> "client versions march forward").
>
> While I agree that this downgrade path can be a problem, I don't like the
> idea of adding a version in the filename. The whole point of having a ver=
sioned
> file format is so we can make these changes without changing the filename.
>
> Is it sufficient to remove the auto-upgrade path, at least for a few major
> versions? And I can learn from past mistakes and change the response to
> the other version information in the v2 file (reach index version, hash v=
ersion,
> unused value in 8th byte) and instead make them non-fatal warnings.

I think there's two things here, and for *me* just one of them would be
enough for "screw it, let's write another file":

 1. Our "you have v2" error reporting for all versions until the one we
    haven't released yet sucks/hard errors.

    So right *now* I think few people turn on core.commitGraph=3Dtrue, I
    do, you do, I just convinced GitLab to do it (after doing it myself
    & carrying patches...):
    https://gitlab.com/gitlab-org/gitaly/issues/1627

    I think we both want to get to a point where core.commitGraph=3Dtrue
    is the default though, because it's cheap to make it, and it rocks
    for a lot of use-cases, meanwhile people are toggling it on manually
    at an increasing rate.

    So that combined with some distros/OSs upgrading at a glacial pace
    basically means that we'd *at least* need to do the equivalent of a
    one-off "commit-graph" -> "commit-graph-verion-2-and-beyond",
    because just like some OSs are still shipping with git 1.8.* or 2.11
    whatever, we're also going to have the versions where this is hard
    erroring in production somewhere for a long time.

    It would suck with even a "conservative" upgrade path to need to
    wait until 2022 or something just so I can have a commit graph that
    by default has the number of objects or whatever other small thing
    we add to it because we're paranoid that it hasn't been N versions
    since we stopped hard-erroring on v2.

    There's a lot of such mixed-version cases, e.g. running a server
    cluster where the git data is on NFS and you're in the process of
    updating git on some "client" nodes but not others, now if the git
    version is one of the ones impacted and you e.g. run gitlab the new
    version will ruin your day. Ditto a user on their laptop testing a
    git from debian testing and going back to stable etc, only to find
    that their repos broke.

 2. While we *can* say a lost commit-graph is "just a performance issue,
    not a failure", which is easy enough to make the case for v2.22 and
    beyond if we fix a couple of things, I think this is becoming less
    and less acceptable in practice.

    E.g. I have some things now where I pretty much hard-rely on it if I
    don't want a CPU/IO spike as some commands that take 5ms now start
    taking 30s (e.g. "what branch is this on" in the GitLab UI)., which
    would happen if we have one file and switch to v2 by default at some
    point (and v3, ...).

