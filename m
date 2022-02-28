Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B01AAC433EF
	for <git@archiver.kernel.org>; Mon, 28 Feb 2022 16:39:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237842AbiB1Qk1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 11:40:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbiB1Qk0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 11:40:26 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2471B606F4
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 08:39:47 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id c14so8587309qvk.10
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 08:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=UMGrlx7SpyPbQSvwAv/3wFii9KTh+qQzSEiHMKGD1pU=;
        b=QEa6QqXEzW9fmXBR48fM+++pJfrtsNZjI2+C/xu1zUGbw2XqUbLqW2qPZPCDe16DnM
         v0MzbzbKZesughW8T3hHKWmIyCEo0OrF+7Wl6boq/7w/e3dtCwbuz64p6jEDXOdYNJ5D
         skz4g9shYEMKNNQIPFQgEAb7+rPsle+Rue4o5L5rgLeWvj+KjH86jgU4vN+CGcNlFzTz
         6ly+xDswpozOXLuGAHwzIQkqeWD65XYEKNTCrSIPpRlnbp7l9Mhw0W2b9+BCIZNga+2K
         VvON7t7Fyvp1YSBkRdwBg6huXZGBdp+4CPEp3AdzVpz536ynEGOf5glxK/8+YvDQUgLA
         D4nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=UMGrlx7SpyPbQSvwAv/3wFii9KTh+qQzSEiHMKGD1pU=;
        b=cj0kGhNhK+xPThvFlr+jhBInNgVgodVwVvHvxjC5osBxLGiYimGhHkRvznRkfdRNwJ
         Th5YNASKSxGhISXWI4U+h3EDDWQlhJQ8e/BkXdIMc2znyWiYajHG+gQncgrJeaJqC7sP
         R4V++Mhp2WYZxx5ItsElrBy8wD3gnmVVjNCJ/3gNk1nccu4/DM7KpkQbok0cxPUtpowo
         hUEii8K8bQqUL47nH3ue/E8i1tP9vDCSg5G5h8bu2nyHdfLdPQcM8BrAt84ATpgYFoVV
         x9O9dfZ8WOdnTIyxKM/DvGlF17iopLb5rGQBWgSO1CGURQrVqYdjRlZGBRncmmyTUC7y
         yy3g==
X-Gm-Message-State: AOAM533n4/jw6mCvhG/tZ95GS+bK4cQz8CgsoMtsvsgBnydE4IdbWSRO
        ejFNDCslA5om6ZsffP37cEjd
X-Google-Smtp-Source: ABdhPJzvowpNugeSWv2h5qV40ndNKiKoVT8jSHI5E33jvXOPQY2KuQMgtO8ZNdhopoBlh0q8eC4w+Q==
X-Received: by 2002:a05:6214:1548:b0:432:a21a:2759 with SMTP id t8-20020a056214154800b00432a21a2759mr13531032qvw.88.1646066386164;
        Mon, 28 Feb 2022 08:39:46 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id q9-20020a05622a030900b002dd2c3a9fccsm7463305qtw.38.2022.02.28.08.39.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 08:39:45 -0800 (PST)
Message-ID: <e74d72bc-b6f5-2e1c-63d1-d3a580f3dc11@github.com>
Date:   Mon, 28 Feb 2022 11:39:43 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 5/7] commit-graph: document file format v2
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, gitster@pobox.com,
        abhishekkumar8222@gmail.com
References: <pull.1163.git.1645735117.gitgitgadget@gmail.com>
 <7f9b65bd22551fd7fd5d2f0bf18aee8c25f1db99.1645735117.git.gitgitgadget@gmail.com>
 <220225.86a6ee7eid.gmgdl@evledraar.gmail.com>
 <d19f5ee8-af92-805f-7ea2-8285862c1123@github.com>
 <220228.86pmn73toq.gmgdl@evledraar.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <220228.86pmn73toq.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/28/2022 9:27 AM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Mon, Feb 28 2022, Derrick Stolee wrote:
> 
>> On 2/25/2022 5:31 PM, Ævar Arnfjörð Bjarmason wrote:

>>> Or maybe they won't. I just found it surprising when reviewing this to
>>> not find an answer to why that approach wasn't
>>> considered.
>>
>> The point is to create a new format that can be chosen when deployed
>> in an environment where older Git versions will not exist (such as
>> a Git server). The new version is not chosen by default and instead
>> is opt-in through the commitGraph.generationVersion config option.
>>
>> Perhaps in a year or two we would consider making this the new
>> default, but there is no rush to do so.
> 
> Looking into this a bit more I think that in either case this is less of
> a big deal after my 43d35618055 (commit-graph write: don't die if the
> existing graph is corrupt, 2019-03-25), which came out of some of those
> discussions at the time of [1].
> 
> I.e. now a client that only understands version N-1 will warn when
> loading it, wheras it's only if a pre-v2.22.0 client (which has that
> commit) reads the repository that we'd hard die on it, correct?
> 
> But speaking of hyper-focus. I think that arguably applies to you in
> this case when considering the trade-offs of these sorts of format
> changes :)
> 
> I.e. you're primarily considering cases of say a git server (presumably
> running on GitHub) or another such deployment where it's easy to have
> full control over all of your versions "in the wild".

I'm thinking of servers, yes, but also 99% of clients who only upgrade
(or _maybe_ downgrade to a recent, previous version occasionally).
 
> And thus a three-phase rollout of something like a format change can be
> done in a timely and predictable manner.
> 
> But git is used by *a lot* of people in a bunch of different
> scenarios. E.g.:
> 
>  * A shared (hopefully read-only) NFS mounted by remote "unmanaged" clients.
>  * A tarred-up directory including a .git, which may be transferred to
>    a machine with a pre-v2.22.0 version.
> 
> Or even softer cases of failure, such as:
> 
>  * A cronjob causes an alert/incident somewhere because the server 
>    operator started writing a new version, but forgot about a set
>    of machines that are still on the old version.

It is important to continue supporting these cases, and this change does
not cause any issues for them. However, this handful of corner cases
should not block progress in the main cases.

> I think that even if it's less conceptually clean it's worth considering
> being over backwards to be kinder to such use-cases, unless it's really
> required for other reasons to break such in-the-wild use-cases.
> 
> Or in this case, if it's thought to be worth it to help reviewers decide
> by separating the performance improvement aspect from the changed
> interaction between new graphs and older clients.
> 
> As a further nit on the proposed end-state here: Do I understand it
> correctly that commitGraph.generationVersion=[1|2] (i.e. on current
> "master") will always result in a file that's compatible with older
> versions, since the only thing "v2" there controls now is to write the
> optional GDAT and GDOV chunks?
> 
> Whereas going from commitGraph.generationVersion=2 to
> commitGraph.generationVersion=3 in this series will impact older clients
> as noted above, since we're bumping the version (of the file, to 2 if
> the config is 3, which as Junio noted is a bit confusing).
> 
> I think if you're set on going down the path of bumping the top-level
> version that deserves to be made much clearer in the added
> documentation. Right now the only hint to that is a passing mention that
> for v3:
> 
>     [it] will be incompatible with some old versions of Git
> 
> Which if we're opting for breaking format changes really should note
> some of the caveats above, that pre-v2.22.0 hard-dies, and probably
> describe "some old versions of Git" a bit more clearly.
> 
> It actually means once this gets released "the git version that was the
> latest one you could download yesterday". Which a reader of the docs
> probably won't expect when starting to play with this in mixed-version
> environment.
> 
> 1. https://lore.kernel.org/git/87h8acivkh.fsf@evledraar.gmail.com/

This documentation could be altered to be specific about versions,
but such a specific change makes assumptions of the version that will
include it. As of now, the generation number v2 fixes will _probably_
get in for 2.36 and the format change would have enough time to cook
for 2.37, so I'll update the docs to refer to that version explicitly.

The pre-2.22.0 change might be helpful to mention, but it could also be
noise to the reader. We can revisit this when these patches are
submitted again in another thread. There's also concern about third-
party tools like libgit2. I'd rather draw the line as "tread carefully
here" than "here is so much information that a reader might think it
is all they need to know".

Thanks,
-Stolee
