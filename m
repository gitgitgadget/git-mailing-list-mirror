Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BAE1C433F5
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 15:54:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239147AbhLGP5w (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 10:57:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233306AbhLGP5u (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 10:57:50 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87965C061574
        for <git@vger.kernel.org>; Tue,  7 Dec 2021 07:54:19 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id a11so15008861qkh.13
        for <git@vger.kernel.org>; Tue, 07 Dec 2021 07:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=4Jv/eaBgSuyUCdOtmo6tOh/BBtxF9gEtZhg5kXmA6no=;
        b=T+JJhkqqA5hosgyOaW+YUG1HslOFgEGkiBQIOe1INR/1DrtjJXbR7wZkR47C0bwHEZ
         DAQISB8+HmLosvv3hrBhv39NSjZvt9DsprDFBLEtdR38Q5k/iy+cy82OmA95RayUVRQC
         yGTaYX/Up6qJ6Mf8Uui66iGgzi2bMF1FiWC6qLp/IT7x1ZtwvKaKhnF3Z8ziLxHpNzMP
         5FSyYHudGAzrCBxCavWgOoHSmER2qgTEQarC9SakBn1A2CF6eFqJxYXrRSYM1BsXZQ1a
         0Hoire9HUNeY3CwRjpefaE4gvSwcUkWbHh6Mh7da8x7ZgJcBlzLjpbQ2lvw0d/Tu4WaW
         grCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=4Jv/eaBgSuyUCdOtmo6tOh/BBtxF9gEtZhg5kXmA6no=;
        b=6yYPj1xgtGHKD4BnN7O3nVAs+uGjCIUADLboii+1yszlEI3ZtfzfusT70VGYd/+8D2
         WK+wk0xcSCi53jDccl+TNy8MI/6jqNWsHDuYgE6WeyzlzvCv+5nu4ijbLnSJrOi7kgN3
         HQxT7x+CRb9LXafQeaYvRExjCuhyTG4+v9y/APoF6V6F3FrWKpChMzBuZ/0sN699e4h+
         fwqftJeXqPf5bJ0obbN54ftj7Vrj50lXEdh4hNvaFvV3wXF+LWnB4o0/XqNh8hC62dDr
         gbQWtNfIo41bLgyo7FpUhbkMTUAq1Df6f9VjxpMT58dg22zcud1ilAIveszPGpYi1Alk
         xvLA==
X-Gm-Message-State: AOAM531xiZdL6IFdPG6q6ItUP+ew18MbrK83YahrjaU/x2CmW/Gz0A29
        Kdm9c80SAiHMhRMFnwSS3YQ=
X-Google-Smtp-Source: ABdhPJwxlD6jK7f3F14ossTsnvwCRLP646mW3v+fYLTdnTPbzNoHmMK/BtvomLloF3KkSX2Y8mmHag==
X-Received: by 2002:a05:620a:298e:: with SMTP id r14mr41446191qkp.509.1638892458395;
        Tue, 07 Dec 2021 07:54:18 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:1d54:16a5:5c65:4b5? ([2600:1700:e72:80a0:1d54:16a5:5c65:4b5])
        by smtp.gmail.com with ESMTPSA id ay42sm8342722qkb.40.2021.12.07.07.54.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Dec 2021 07:54:17 -0800 (PST)
Message-ID: <4ffbfd5f-6cfa-ab71-e663-355b33d513df@gmail.com>
Date:   Tue, 7 Dec 2021 10:54:16 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: What's cooking in git.git (Dec 2021, #01; Fri, 3)
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqh7bpqhf0.fsf@gitster.g>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqh7bpqhf0.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/3/2021 8:37 PM, Junio C Hamano wrote:
> This is probably the first issue of the "What's cooking" report, in
> which all topics have some sort of description.
> 
> That's a small achievement, at least for me.

Thank you for continuing to do this monumental amount of work.
 
> Even better, each and every topic is annotated with some sort of
> verdict (like "Will discard", "Expecting a reroll", "Will merge to
> 'next'?" etc.).  There is no topic in the "Undecided" category when
> this report is fed to "cook -w" script (found in the 'todo' branch).
> 
> A handful of topics are added to 'next', and we have about 40 topics
> cooking there.  For them, the future is automated---they spend about
> a week in 'next', and if we find issues in them, we incrementally
> improve them, or get merged to 'master'.
> 
> Then we have about a dozen topics that are marked for 'next' (please
> raise your hand if you have objection before a real damage is done),
> and 8 more that may be ready for 'next' (please raise your hand if
> you want to nudge them in either direction, for or against).

> * ds/trace2-regions-in-tests (2021-11-29) 2 commits
>  - t/t*: remove custom GIT_TRACE2_EVENT_NESTING
>  - test-lib.sh: set GIT_TRACE2_EVENT_NESTING
> 
>  The default setting for trace2 event nesting was too low to cause
>  test failures, which is worked around by bumping it up in the test
>  framework.
> 
>  Will merge to 'next'.
>  source: <pull.1085.git.1638193666.gitgitgadget@gmail.com>

I agree this is ready. Some additional discussion is in the thread,
but it is all about how to build upon this fix.

> * en/keep-cwd (2021-12-01) 11 commits
>  - t2501: simplify the tests since we can now assume desired behavior
>  - dir: new flag to remove_dir_recurse() to spare the original_cwd
>  - dir: avoid incidentally removing the original_cwd in remove_path()
>  - stash: do not attempt to remove startup_info->original_cwd
>  - rebase: do not attempt to remove startup_info->original_cwd
>  - clean: do not attempt to remove startup_info->original_cwd
>  - symlinks: do not include startup_info->original_cwd in dir removal
>  - unpack-trees: add special cwd handling
>  - unpack-trees: refuse to remove startup_info->original_cwd
>  - setup: introduce startup_info->original_cwd
>  - t2501: add various tests for removing the current working directory
> 
>  Many git commands that deal with working tree files try to remove a
>  directory that becomes empty (i.e. "git switch" from a branch that
>  has the directory to another branch that does not would attempt
>  remove all files in the directory and the directory itself).  This
>  drops users into an unfamiliar situation if the command was run in
>  a subdirectory that becomes subject to removal due to the command.
>  The commands have been taught to keep an empty directory if it is
>  the directory they were started in to avoid surprising users.
> 
>  Needs review.
>  There are some comments on earlier rounds; the latest one needs a
>  serious review or at least Acks from past commentors.
>  source: <pull.1140.v5.git.git.1638340854.gitgitgadget@gmail.com>

I've been meaning to get back to this one. I'll see what I can do
today.

> * ds/fetch-pull-with-sparse-index (2021-11-29) 3 commits
>  - ls-files: add --sparse option
>  - fetch/pull: use the sparse index
>  - Merge branch 'ld/sparse-diff-blame' into ds/fetch-pull-with-sparse-index
>  (this branch uses ld/sparse-diff-blame and vd/sparse-reset.)
> 
>  "git fetch" and "git pull" are now declared sparse-index clean.
>  Also "git ls-files" learns the "--sparse" option to help debugging.
> 
>  Expecting a reroll?
>  Discussion seems to have stalled, with a few loose ends questions.
>  source: <pull.1080.git.1637077083.gitgitgadget@gmail.com>

I do plan to re-roll, but with all of the movement in vd/sparse-reset
and ld/sparse-diff-blame, I paused work on this. As those topics
become more stable, I will revisit this and the comments that are
still outstanding.

I have another sparse index topic [1] that came out _after_ this
cooking email that is higher priority, since it fixes a bug.

[1] https://lore.kernel.org/git/pull.1092.v2.git.1638799837.gitgitgadget@gmail.com/

> * js/scalar (2021-12-01) 17 commits
>  - scalar: implement the `version` command
>  - scalar: implement the `delete` command
>  - scalar: teach 'reconfigure' to optionally handle all registered enlistments
>  - scalar: allow reconfiguring an existing enlistment
>  - scalar: implement the `run` command
>  - scalar: teach 'clone' to support the --single-branch option
>  - scalar: implement the `clone` subcommand
>  - scalar: implement 'scalar list'
>  - scalar: let 'unregister' handle a deleted enlistment directory gracefully
>  - scalar: 'unregister' stops background maintenance
>  - scalar: 'register' sets recommended config and starts maintenance
>  - ci: also run the `scalar` tests
>  - cmake: optionally build `scalar`, too
>  - scalar: create test infrastructure
>  - scalar: start documenting the command
>  - scalar: create a rudimentary executable
>  - scalar: add a README with a roadmap
> 
>  Add pieces from "scalar" to contrib/.
> 
>  Need to pick up the reroll before merging to 'next'.
>  cf. <pull.1005.v10.git.1638538470.gitgitgadget@gmail.com>
>  source: <pull.1005.v9.git.1638273289.gitgitgadget@gmail.com>

I look forward to moving to the next stages of this work.

Thanks,
-Stolee
