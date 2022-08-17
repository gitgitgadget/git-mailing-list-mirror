Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CDC5C25B08
	for <git@archiver.kernel.org>; Wed, 17 Aug 2022 23:47:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233622AbiHQXrW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Aug 2022 19:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242226AbiHQXrR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Aug 2022 19:47:17 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC6E6A5C43
        for <git@vger.kernel.org>; Wed, 17 Aug 2022 16:47:15 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id r69so13241574pgr.2
        for <git@vger.kernel.org>; Wed, 17 Aug 2022 16:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=8GcqWVPhcIm/QN3fC7cZIzYMtrFRYJJEmw3J8g5ATRg=;
        b=YSqjuwzOMcFDb/fJMcVsKne6IpYmwW8ymASmR7yFtJiXUwRP+LRb8xi3SFm2AXuDFO
         X4mIhPIyzRzHo1XqlhJm8DPXGOA58j1GGQD1LQiuR274osiv2XATV/6jt6rlzdAzmkTv
         AdMR+F2h9c+vwu2vEA2hMy5Gv/N26cKHO8WGvMS/fHzOkwQa/i5/6M9VVfXYd2ArpR8p
         q6LmxAkT6Ba6aKTCvz4s+APk5DlrvKEzlpjSx06i5uaRd2QmJ/kfUGLT2ng9L6+7zjOC
         Qer0cUGaB8P6hehR9NJ78g9bvKLI+7o0E8Ajg98Ye9jlWsLNkF/IQ38rH2Bc2s91GdbV
         sZew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=8GcqWVPhcIm/QN3fC7cZIzYMtrFRYJJEmw3J8g5ATRg=;
        b=RznwvD3CCW8cu1XFQFKQ9KAo/VB7m20d97GN+FGWLhemmqR6pthWFj42HGyioIS1Mb
         9eNkJa/o9QiABD+hLpyykIaCg+U7VPehXFoIV2IbW93YHNw0QhgFcOWK4kg+0/5Ut3Ji
         TjNWf6wtOhre4yje+Jd8/bqQSJzzag6ek/s83CFsHBuRCAjr665xHo4Iz3LGsHUKOtzE
         TckNR576L70ZSPlA46Mlqk94xqeepoteu8rKpbjfWlnt1GnhTQHJ36Y7vhPhXVUVoQG8
         G5OmRdPkkTrNVQFiWAcmOFGiByJuVVeCAhgQqeL3/t+nyxEr2Fkgqyg3MmiUaqcxtlR9
         BcNQ==
X-Gm-Message-State: ACgBeo1abeBROXNW+s8cLrCEreIkG0bzFtOweMJJKWyWpjViPyxW7sBq
        tpUEDsso19jI1T0zq6XW85/Z
X-Google-Smtp-Source: AA6agR6KdhdX+d+nx52zBCdbU5wDEccl9gzAc5YQt/sjThKbRL6HdlIYz8G81MPnrRnnMg4sTWTR0A==
X-Received: by 2002:a65:4501:0:b0:3fc:4895:283b with SMTP id n1-20020a654501000000b003fc4895283bmr458418pgq.231.1660780035214;
        Wed, 17 Aug 2022 16:47:15 -0700 (PDT)
Received: from [192.168.0.104] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id i5-20020a635405000000b004298d7b6e70sm31907pgb.54.2022.08.17.16.47.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Aug 2022 16:47:14 -0700 (PDT)
Message-ID: <3a238691-c37f-39a1-f4f6-2b8f9b4c4dcb@github.com>
Date:   Wed, 17 Aug 2022 16:47:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH v2 3/5] scalar: enable built-in FSMonitor on `register`
Content-Language: en-US
To:     Derrick Stolee <derrickstolee@github.com>,
        Matthew John Cheetham via GitGitGadget 
        <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc:     johannes.schindelin@gmx.de, mjcheetham@outlook.com,
        gitster@pobox.com
References: <pull.1324.git.1660673269.gitgitgadget@gmail.com>
 <pull.1324.v2.git.1660694290.gitgitgadget@gmail.com>
 <5fdf8337972d7092aba06a9c750f42cd5868e630.1660694290.git.gitgitgadget@gmail.com>
 <f5388e4d-7eb7-9333-6a8e-86ce449aced0@github.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <f5388e4d-7eb7-9333-6a8e-86ce449aced0@github.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee wrote:
> On 8/16/2022 7:58 PM, Matthew John Cheetham via GitGitGadget wrote:
> 
>> +#ifdef HAVE_FSMONITOR_DAEMON_BACKEND
>> +		/*
>> +		 * Enable the built-in FSMonitor on supported platforms.
>> +		 */
>> +		{ "core.fsmonitor", "true" },
>> +#endif
>> +	if (fsmonitor_ipc__is_supported() && start_fsmonitor_daemon())
>> +		return error(_("could not start the FSMonitor daemon"));
>> +
> 
> I initially worried if fsmonitor_ipc__is_supported() could use some
> run-time information to detect if FS Monitor is supported (say, existence
> of a network share or something). However, that implementation is
> currently defined as a constant depending on
> HAVE_FSMONITOR_DAEMON_BACKEND.
> 
> The reason I was worried is that we could enable core.fsmonitor=true based
> on the compile-time macro, but then avoid starting the daemon based on the
> run-time results. If we get into this state, would the user's 'git status'
> calls start complaining about the core.fsmonitor=true config because it is
> not supported?
> 
> The most future-proof thing to do might be to move the config write out of
> the set_recommended_config() and into start_fsmonitor_daemon(). Perhaps
> rename it to enable_fsmonitor() so it can fail due to writing the config
> _or_ for starting the daemon. The error message would change, then, too.

I spent some time digging into this, and I think gating both the config and
subsequent 'git fsmonitor--daemon start' on having platform *and* repository
support is a good idea. I'll update the next version to both set the
'core.fsmonitor' config and start the daemon only if the built-in FSMonitor
is fully supported.

(warning: long-winded tangent mostly unrelated to FSMonitor)

In the process of testing FSMonitor behavior, I think found other issues
with Scalar registration. Specifically, the test I wrote attempted to
'scalar register' a bare repo, since bare directories are incompatible with
FSMonitor. After seeing that FSMonitor was *not* incompatible with the
repository, I found that Scalar was 1) ignoring the bare repository and, as
a result, 2) identifying my Git clone (way above GIT_CEILING_DIRECTORIES) as
the "enlistment root". I think 1) might be fine as-is - uniformly ignoring
bare repos seems like a reasonable choice - but 2) seems like more of a
problem. 

Right now, 'setup_enlistment_directory()' searches for the repo root
beginning at directory '<dir>', which is either a user-provided path or
current working directory. It checks whether '<dir>' or '<dir>/src' is a
repo root: if so, it sets the enlistment info; otherwise, it repeats the
process with the parent of '<dir>' until the repo root is found. For
example, given the following directory structure:

somedir
└── enlistment
    ├── src
    │   └── .git
    └── test
        └── data

'scalar register somedir/enlistment/test/data' will search:

  * somedir/enlistment/test/data/src
  * somedir/enlistment/test/data
  * somedir/enlistment/test/src
  * somedir/enlistment/test
  * somedir/enlistment/src

The current usage of GIT_CEILING_DIRECTORIES relies on the fact that, when
invoking a normal 'git' command, 'setup_git_directory()' only searches
upwards from the current working directory to find the repo root; it's a
clear "yes" or "no" as to whether that search passes a ceiling directory.
Scalar isn't as clear, since it searches for the repo root both "downwards"
into '<dir>/src' *and* upwards through the parents of '<dir>'. It's not
totally clear to me what the "right" behavior for Scalar is, but my current
thought is to follow the same rules as 'setup_git_directory()', but for the
*enlistment* root rather than the repository root. It's more restrictive
than GIT_CEILING_DIRECTORIES on a normal git repo, e.g.:

1. 'GIT_CEILING_DIRECTORIES=somedir/enlistment git -C somedir/enlistment/src status' 
   is valid.
2. 'GIT_CEILING_DIRECTORIES=somedir/enlistment scalar register somedir/enlistment/src'
   is not valid.

but since Scalar works on the entire enlistment (not just the repo inside of
it), I think it makes sense to prevent it from crossing a ceiling directory
boundary.

What do you think? Hopefully my rambling wasn't too confusing (if it is,
please let me know what I can clarify). 

> 
> Or maybe I'm making a mountain out of a mole hill and what exists here is
> perfectly fine.
> 
>> +test_lazy_prereq BUILTIN_FSMONITOR '
>> +	git version --build-options | grep -q "feature:.*fsmonitor--daemon"
>> +'
> 
> It looks like we already have a FSMONITOR_DAEMON prereq in test-lib.sh.
> Should we use that instead?

Works for me, happy to reuse code wherever possible. :)

> 
> Thanks,
> -Stolee

