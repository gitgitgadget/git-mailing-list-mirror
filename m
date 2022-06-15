Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AE58C43334
	for <git@archiver.kernel.org>; Wed, 15 Jun 2022 12:52:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347165AbiFOMwq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jun 2022 08:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347089AbiFOMwm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jun 2022 08:52:42 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F83510F4
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 05:52:40 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id a9so8719620qvt.6
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 05:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=xMpWqIsRziZm5MPT9vnjaO183p2BOe4+DPMC8tmvwNs=;
        b=edW5O9I+E+swENwjQcLuEalGWb4JqBkJ/nbllB3tXYjLqnw+aoqb9lDHbJ1mGWD+Pa
         tp/fKj7AvFinW9eU7jILTS2NKLVXW9K9beEvtUr5MocAhxgS0d8pjixIuTEK0Yr8bnYT
         7HJcMK3nSgcb7s6USEWS2ZLfR4K+XpzaWcogT7yIf40T4958czQmy6FpzkUAl/j9sPos
         CsaOZDugajgyQIBy2+9KnlfsW6wMwSUnu7N1AbTB34QNAg5bd6PturWNIfAx0EFN99H3
         72OQYO2lFncKUejrXW8OTQ/+x08T+RQmCs4PRYdvoAX6VRIaSMh8YYHuwWXzE1zAM3rH
         lhOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xMpWqIsRziZm5MPT9vnjaO183p2BOe4+DPMC8tmvwNs=;
        b=ACM1kJmHhzW+W2F2j8XIz3BGlCbi2qsHokdahvOcaMsGJS5eqDtaS+250rcn+d56b/
         ++RBYz1g/GayHAqYFMpHgvkHObachvpgDMjKDFUDULFNGP1Q0u4wRKtc68TRHHOmOuxI
         BZ2a9ermaPuGMVmWGkC5M2qiHaPtsGRx2FRTveH0CAkVngrjhOkAPfygOVYd0gitbz/e
         H3X/pags72NEmP+70epHi2c9lkUDu5L97j2S/LY5jIdvzF3PLOjR+P3vQ3W1yy+Pb0p2
         t/871v1zxb8jliDDNRCWlBe8IziRGblZMsaDj+qB0sXXwDZ8gbu5TDH+hSVHO2mQdb9Q
         ixFw==
X-Gm-Message-State: AJIora/MTm7LWhimPAe9xCLG06dMBn5nbQWnoz7+CMyab3SJRpVasEDp
        v93v4Cxlq35qxckHZLxsKHMaQBMEm2YE
X-Google-Smtp-Source: AGRyM1tbZ0O6hlDjORAcbdIoSQi5XWj4iIcX6372K2sVx1hdV3BTMtWJFLQ1sDfZJ/VlK8vWqIZ0Cg==
X-Received: by 2002:a05:6214:769:b0:46e:6d8b:adbf with SMTP id f9-20020a056214076900b0046e6d8badbfmr510636qvz.72.1655297559200;
        Wed, 15 Jun 2022 05:52:39 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:900f:fa9e:132:1bde? ([2600:1700:e72:80a0:900f:fa9e:132:1bde])
        by smtp.gmail.com with ESMTPSA id cj19-20020a05622a259300b00304f6f4199dsm9241986qtb.65.2022.06.15.05.52.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jun 2022 05:52:38 -0700 (PDT)
Message-ID: <7e5488bd-a17b-3997-072d-69e3ae0a9821@github.com>
Date:   Wed, 15 Jun 2022 08:52:38 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
Subject: Re: [RFC PATCH 0/5] fix issues in transfer.credentialsInUrl
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
References: <RFC-cover-0.5-00000000000-20220615T104503Z-avarab@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <RFC-cover-0.5-00000000000-20220615T104503Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/15/22 6:53 AM, Ævar Arnfjörð Bjarmason wrote:
> This is on top of [1], and given the "rc" phase is an RFC. This:
> 
>  * Fixes the issue of the transfer.credentialsInUrl (now renamed)

You are burying the lede here (and I had to look hard to see where
you renamed it in patch 4). I think this rename makes sense, as long
as we do that replacement before the release. Having a patch that
does only that rename as the first patch (and updates all docs, too)
would be helpful.

The doc updates should include the reference in the release notes,
too.

> not
>    finding passwords in "pushurl" URLs (in my case, the only place
>    where I'd actually put a password in a URL in a config...)
...
>  * 5/5 fixes the (major) blind spot of the warning missing "pushurl" config.

I think this is a valuable extension of the feature, and justifies
the rename. I'm mixed on whether we should add this before the
release or save it for the next cycle.

>  * 1/5 fixes a bug in an existing test, but I didn't think it was
>    worth bothering with for 2.37.0.

It's a good find, and a test fix is easy to do during the release
cycle, I think.

>  * Adds missing test coverage for reading the config from a file, not
>    the CLI.

Again, test coverage is good. No functionality needs to change.
However, one test added requires the pushurl change.

>  * 3/5 is a WIP CI target to spot the type of issue I fixed in [2],
>    it's not the first time where we have a NO_CURL=Y breakage land on
>    master...

I think that we should use CI to prevent these kinds of issues, so
I support adding this as well as leaving room for it to be changed
in the future if we notice other build issues that we can group into
this build.

>  * 4/5 attemps to "really" fix the duplicate warnings we emit, I think
>    the approach there is good, especially the part where we shouldn't
>    emit it twice in-process.
> 
>    But this currently misses e.g. "git ls-remote". I wonder if we
>    should just stick that git_config_push_parameter() condition into
>    packet_trace_identity() and call it a day.

I think these duplicate warning things should absolutely be left
until after the release. We do not have "warn" on by default, so it
will not disturb users who don't opt-in. We _should_ pursue this in
the next cycle, but with the time we can take to really be sure it
is the right approach to solving that problem.

> I think this is all non-RFC quality, except the "ls-remote" case, and
> us missing tests for that & other transport users that aren't
> clone/fetch/push.

There are some patch-order things that need to be cleaned up. I
agree that most of the code looks right.

> Derrick: Are you interested in picking this up & pursuing it after the
> release, with whatever fix-ups/rewrites etc. that you find
> appropriate?

I'm happy to review a new version of this series during the release
window that takes the high-priority items (renaming the config,
fixing tests, adding the CI build). I'd also be happy to review the
other changes as a follow-up.

Thanks,
-Stolee
