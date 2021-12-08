Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C2DCC433EF
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 14:17:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234881AbhLHOVE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 09:21:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233375AbhLHOVB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 09:21:01 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E21C061746
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 06:17:30 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id w14so2054261qkf.5
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 06:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Ihn2BX6uv2A7kR8IC/eCs7waPzjt3uCNhVgDPWhC0+s=;
        b=dtQudSwcTXV/Gx+ok/swWnWmn3oRVCcWFNTy5Z192VZIgxtN0iKD351glw/BIMC5vi
         2nh2RYjAEamidLP4MpS6mq3jbs+Sii8VRNgUF/DVNn9/OXE/JQUTlMrJQyjDjdc9acfQ
         UmqcNDIrMxENjmtp6pCCiBAuPHBiMjusrIfpaoLsHL2tHhAhQ3Rv8ZY0YAzqmkvAkL7E
         37M8mnO7PQA5q5a8uTZ6JUeY1bksHa5Fm7k5PT0bufUJP3iCr0FtaZEg388WIYLR5edw
         Dl17ss067Oujkt4HpRssL8YsOtBJUcIjBAshTMO3E5UE4nUloY7j7KXNjk+4aE7r38/N
         X7Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Ihn2BX6uv2A7kR8IC/eCs7waPzjt3uCNhVgDPWhC0+s=;
        b=nFth7XPhCkYR5kW5MU+rr/rE5Nj9UA2qDGJ2TIXgIHiwiSakCuI90JdeZxFOT2P5eD
         d1gPMtodZ2LCMxNKTwJHQ/dlIt4hYxTEOH0hPZP2nZa5wZuSQIRepbvNvHyuZDNddcIT
         B7o0MCSu3bkQgHE48a7wOixPsQKcOK5FNzvPc2Hsq/sASoAUYuHMndhu2VMoh8tNgkla
         RWAaiFgaDSyDvbCEcUF0h81PsqJv+FxyOIjfBU/vlOK9s7SXkgNGn682J9DTGNjuIeFn
         7gD7ON7k46ZBL96rVI0AnkDUb+toP/B+ZaMhAReQ0G8Yvapu7VQ1sHQImzhlBmi+P/5i
         7Nqg==
X-Gm-Message-State: AOAM53264HSHp5YIt/Xsi7Eo/7kwVBwvyo5v8Dz1iNFTBtvS9JIcE90g
        HyA7q7nYix2anrO/Qv3jFzU=
X-Google-Smtp-Source: ABdhPJyuEurixLZdh3Ne95hcQlDAMDIMQU++/LSYGp8ETCtIXXQ8s/YwpN/WrXk1oaFsw+ap7erC7w==
X-Received: by 2002:a05:620a:551:: with SMTP id o17mr7048647qko.660.1638973049093;
        Wed, 08 Dec 2021 06:17:29 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:5056:be20:f10c:bfd5? ([2600:1700:e72:80a0:5056:be20:f10c:bfd5])
        by smtp.gmail.com with ESMTPSA id bk39sm1538194qkb.35.2021.12.08.06.17.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Dec 2021 06:17:28 -0800 (PST)
Message-ID: <f1cd174f-607c-0083-abef-93eff37a8480@gmail.com>
Date:   Wed, 8 Dec 2021 09:17:27 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v10 00/15] Upstreaming the Scalar command
Content-Language: en-US
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>, Matt Rogers <mattr94@gmail.com>
References: <pull.1005.v9.git.1638273289.gitgitgadget@gmail.com>
 <pull.1005.v10.git.1638538470.gitgitgadget@gmail.com>
 <CABPp-BGpe9Q5k22Yu8a=1xwu=pZYSeNQoqEgf+DN07cU4EB1ew@mail.gmail.com>
 <xmqq4k7nmksi.fsf@gitster.g>
 <nycvar.QRO.7.76.6.2112081207320.90@tvgsbejvaqbjf.bet>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <nycvar.QRO.7.76.6.2112081207320.90@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/8/2021 6:15 AM, Johannes Schindelin wrote:
> Hi Junio,
> 
> On Sun, 5 Dec 2021, Junio C Hamano wrote:
> 
>> Elijah Newren <newren@gmail.com> writes:
>>
>>> From your wording it sounds like the plan might not include moving
>>> these tests over.  Perhaps it doesn't make sense to move them all
>>> over, but since they've caught problems in both Scalar and core Git,
>>> it would be nice to see many of those tests come to Git as well as
>>> part of a future follow on series.

Moving the C# test suite over doesn't make a lot of sense. We also
are re-using the test suite from VFS for Git, which is probably overkill
here. Those tests were created due to issues that arose with the virtual
filesystem (paired with the GVFS protocol for finding missing objects)
and most of them probably don't test anything interesting in Scalar.

When we _do_ find something interesting in that suite, we port over the
test as a normal Git test so the regression is avoided in the future.

We work to test the -rc0 version of every release with our custom patches
in microsoft/git and then run them through the Scalar and VFS for Git
functional tests as a necessary step before releasing to our internal
users. Since we are doing that already, it is a better use of time to
port tests that actually matter when they come up rather than port the
entire test suite.

>> Yeah, we may be initially queuing this without tests for expediency,
>> but a production code cannot go forever without CI tests to ensure
>> continued code health.  People make changes in other parts of the
>> system Scalar may depend on and unknowingly break some assumption
>> Scalar makes on it.

I think it is important to keep in mind that the Scalar features that
are being submitted here are getting Git-style tests included. The only
thing that is missing right now is a firm link with Git's CI system,
which can be added quickly once things have calmed down in the build
system.

If we are interested in doing something more substantial that is
closer to the Scalar functional tests, then it is important to know
that those tests are running against a production server to clone
data and fetch it dynamically throughout. That is not exactly something
we have done in the Git test suite before.

In fact, I don't think Scalar introduces anything novel here: if we
want to add more coverage of running Git commands while in a
sparse-checkout _and_ partial clone _and_ have a lot of optional config
set, then we can do that independently of Scalar. 'scalar clone' just
sets up a repository in a state that an expert user could do themselves,
so should we spend a lot of effort creating that environment in our
test suite?

We have this already in some form:

1. t1091 and t1092 try to cover important sparse-checkout behavior.

2. t0410, t5616, and others try to cover important partial clone
   behavior.

3. Our GIT_TEST_* variables that are enabled in one of our CI runs
   test many of the advanced config options enabled by Scalar.

The thing that is missing is "all of these things at once" which
would be difficult to do across the test suite with our current test
design. I'm happy to provide the service of checking the Scalar
functional tests before each release as an expensive way to check
that combination of configuration without adding that cost to every
CI run and developer inner loop.
 
> The Scalar Functional Tests were designed with Azure Repos in mind, i.e.
> they specifically verify that the `gvfs-helper` (emulating Partial Clone
> using the predecessor of Partial Clone, the GVFS protocol) manages to
> access the repositories in the intended way.
> 
> I do not know off-hand how entangled the GVFS part is in the test suite,
> but from what I recall, every single test starts with cloning a test
> repository. From Azure Repos. Using the `gvfs-helper`.

There is a single test that checks that 'scalar clone' against github.com
works appropriately [1]. We don't duplicate all of the other tests in
this environment.

[1] https://github.com/microsoft/scalar/blob/68b6e70d77f1c7c13be9f35848a042604f3fb2f1/Scalar.FunctionalTests/Tests/MultiEnlistmentTests/ScalarCloneFromGithub.cs

> Which means that the `gvfs-helper` would need to be upstreamed and be
> maintained in the git.git repository proper.
> 
> Previously I was under the impression that that might be met with grumpy
> rejection.
> 
> I do realize, though, that clarity of intention has been missing from this
> mail thread all around, so let me ask point blank: Junio, do you want me
> to include upstreaming `gvfs-helper` in the overall Scalar plan?

I, for one, don't think that has much value for the core Git project.

Thanks,
-Stolee
