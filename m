Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99AA9C433EF
	for <git@archiver.kernel.org>; Mon, 11 Jul 2022 23:05:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231858AbiGKXFe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jul 2022 19:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbiGKXFc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jul 2022 19:05:32 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB0147D794
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 16:05:30 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id v4-20020a17090abb8400b001ef966652a3so9735689pjr.4
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 16:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Z7UD7cQnClb2WWTXzN0i5eSrDVgbTEjvUy4E0CUhbHw=;
        b=QS9g2ewh92KV8918EITQN80W2CZvJ8jZCNlQ5Q2x/DIMW9bphCbOp4gt+vKSn86QSH
         5guMPQ6aWyYEurrJU4JFn+qQlUaGPZvDLLaKPmMURVyUScc6t8K/SlRNwSdod96wBbpB
         +NuNh12In2rN95chhxCTc3x0ZPboBzr/0heXYcDv2Win2EKz7uC1QSDFwJfzUUhborrH
         53sXBy/B6xa55m8sobuEZuf+YIHTbwVAXpxf6hb0yjmLFodB2JZlEmnjDtYCqtoTd4w5
         uWzuy8lVQQeQXyHhmn7vyp6WQsqw+JDu5ewvhxj9DCbie5aKbcKwL6ux5bbUpW5wyA4F
         45xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Z7UD7cQnClb2WWTXzN0i5eSrDVgbTEjvUy4E0CUhbHw=;
        b=nQ52jMUEQvAFqc3xFLlye1V+xuQ+82xtlKYhQUB8I7GNKuKDojCP/JtLMbAxT+/bHv
         MA7OY0swAEGnD/k8MA96o6NUn19BUUU3J5EwnfKLOLK7j40BKMwsslVDORaDWhm4EbSM
         oTRx7O4T/Q7Ma+SRyj1VncqMYkhaNg+zYQsUZqACJHk2kDkx5/yVjQTS2igZMAMKI9ai
         BoSm3AHth8zgUYKOMb9oRgr+p/SeETWK912aVefd+xtC4kVSAS8CyfK/0uRIcYGo52tJ
         xttjSdvokP4MrQLK46ZKoa2HXOdKtGFbDujFaRznPGSAwvleEz7kgvVMz+OizEsV6TLL
         qWJQ==
X-Gm-Message-State: AJIora8Y+2Hd7HWferw4KZUA3LoZJF87hCIgtyVrU/Kb81dCOqNOq55A
        thY6I0ZQcqQhCZZNWzQfYQVN
X-Google-Smtp-Source: AGRyM1toxHz/L4iNa4tmw9j3THLN9vwvOjP+osjflzyi/MfC8ZRIX7uEyfg/vnIQoUCLN88KijyJhA==
X-Received: by 2002:a17:902:d64a:b0:16c:2755:428d with SMTP id y10-20020a170902d64a00b0016c2755428dmr19307336plh.79.1657580730144;
        Mon, 11 Jul 2022 16:05:30 -0700 (PDT)
Received: from [192.168.0.104] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id h191-20020a6283c8000000b0051bba89c2bcsm5281774pfe.58.2022.07.11.16.05.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jul 2022 16:05:29 -0700 (PDT)
Message-ID: <ee9ea998-fb9d-1bf0-635a-e1627c7c1c40@github.com>
Date:   Mon, 11 Jul 2022 16:05:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH 2/2] scalar: convert README.md into a technical design doc
Content-Language: en-US
To:     Derrick Stolee <derrickstolee@github.com>,
        Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, gitster@pobox.com
References: <pull.1275.git.1656521925.gitgitgadget@gmail.com>
 <870bd90e47e918f37db5a8d444e5c9a5717f9c17.1656521926.git.gitgitgadget@gmail.com>
 <994f2efd-0789-afad-ba0d-27da9692b289@github.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <994f2efd-0789-afad-ba0d-27da9692b289@github.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee wrote:
> On 6/29/2022 12:58 PM, Victoria Dye via GitGitGadget wrote:
>> From: Victoria Dye <vdye@github.com>
>>
>> Replace 'README.md' with 'technical/scalar.txt' (still in 'contrib/'). In
>> addition to reformatting for asciidoc, elaborate on the background, purpose,
>> and design choices that went into Scalar.
>>
>> This document is intended to persist in the 'Documentation/technical/'
>> directory after Scalar has been moved into the root of Git (out of
> 
> I wonder if it is a good idea to move this into Documentation/technical/ _now_,
> so we can have this document as part of "core Git's roadmap" as much as we can
> say that. Part of the roadmap is moving the Scalar code out of contrib/ and
> finalizing how users (or distributors) can install the 'scalar' binary.
> 

I initially hesitated in doing this because I felt it was a bit premature,
but your comment prompted me to look more closely at other docs in
'Documentation/technical'. Precedent seems to indicate that the doc should
be added *before* implementation (either in the same series as the
implementation [1] or separately [2]), so I'll do the same here. Thanks for
the suggestion!

[1] https://lore.kernel.org/git/daa9a6bcefbce977606484d502f5cfd7fca63ecc.1614111270.git.gitgitgadget@gmail.com/
[2] https://lore.kernel.org/git/20171208192636.13678-1-git@jeffhostetler.com/

> It can be helpful to include the details of what steps to take to compile and
> test the 'scalar' executable. That documentation will then be updated when
> Scalar moves out of contrib/.
> 

As part of the move out of 'contrib/', I was planning on having Scalar built
and installed the same as any built-in (albeit in 'bin/' - like 'gitk',
'git-cvsserver', etc. - rather than 'libexec/git-core'). In that case, there
won't be any special steps needed to build/install 'scalar', so any
instructions here would be temporary. I could include those instructions in
the meantime, but with Scalar incomplete, I'm not sure whether that would be
valuable.

All that said, if later reviews/iterations lead to Scalar needing special
steps to build/install, I'll definitely include them here.

>> +Scalar
>> +======
>> +
>> +Scalar is a built-in repository management tool that optimizes Git for use in
> 
> I think "built-in" is unnecessary here. It makes me think of Git builtins and
> otherwise does not add much to the description.
> 
>> +large repositories. It accomplishes this by helping users to take advantage of
>> +advanced performance features in Git. Unlike most other Git built-in commands,
>> +Scalar is not executed as a subcommand of 'git'; rather, it is built as a
>> +separate executable containing its own series of subcommands.
> 
> Good to have this distinction.
> 
>> +Scalar is a large enough project that it is being upstreamed incrementally,
>> +living in `contrib/` until it is feature-complete. So far, the following patch
>> +series have been accepted:
>> +
>> +- `scalar-the-beginning`: The initial patch series which sets up
>> +  `contrib/scalar/` and populates it with a minimal `scalar` command that
>> +  demonstrates the fundamental ideas.
>> +
>> +- `scalar-c-and-C`: The `scalar` command learns about two options that can be
>> +  specified before the command, `-c <key>=<value>` and `-C <directory>`.
>> +
>> +- `scalar-diagnose`: The `scalar` command is taught the `diagnose` subcommand.
>> +
>> +Roughly speaking (and subject to change), the following series are needed to
>> +"finish" this initial version of Scalar:
> 
> I like how you have these two sections. As you move forward in this roadmap,
> the diff to the document should look like you are _moving_ the sentence above.
> 
>> +- Finish Scalar features: Enable the built-in FSMonitor in Scalar
>> +  enlistments and implement `scalar help`. At the end of this series, Scalar
>> +  should be feature-complete from the perspective of a user.
> 
> Wow, we're so close!
> 
>> +- Generalize features not specific to Scalar: In the spirit of
>> +  making Scalar configure only what is needed for large repo performance, move
> 
> (nit: Strange wrapping on the first line)
> 
>> +  common utilities into other parts of Git. Some of this will be internal-only,
>> +  but one major change will be generalizing `scalar diagnose` for use with any
>> +  Git repository.
>> +
>> +- Move Scalar to toplevel: Make `scalar` a built-in component of Git by
> 
> Here, I would say "included" instead of built-in. Or is there another term we
> should use to avoid confusion with "git <cmd>" builtins.
> 
>> +  moving it out of `contrib/` and into the root of `git`. The actual change will
>> +  be relatively small, but this series will also contain expanded testing to
>> +  ensure Scalar is stable and performant.
> 
> Perhaps "This change will also integrate Scalar into Git's test suite and CI
> checks."
> 
> You mention "performant" which makes me think that performance tests are intended
> to be part of this change. It makes me think it would be interesting to have our
> existing performance tests create a mode where they compare a "vanilla" Git repo
> to one registered with Scalar, but otherwise runs the same tests already in the
> t/perf/ test scripts. This is a wide aside so feel free to ignore me.
> 

This is a really interesting idea! My original plan was to add some basic
tests around the operations 'scalar' should (directly or indirectly) speed
up. I think I'll still need to do that anyway (e.g., for things like 'scalar
clone' vs 'git clone'), but I'll also try to find a (repeatable) way to
compare standard repo vs. Scalar enlistment performance in the existing perf
tests.

>> +Finally, there are two additional patch series that exist in Microsoft's fork of
>> +Git, but there is no current plan to upstream them. There are some interesting
>> +ideas there, but the implementation is too specific to Azure Repos and/or VFS
>> +for Git to be of much help in general.
>> +
>> +These still exist mainly because the GVFS protocol is what Azure Repos has
>> +instead of partial clone, while Git is focused on improving partial clone:
>> +
>> +- `scalar-with-gvfs`: The primary purpose of this patch series is to support
>> +  existing Scalar users whose repositories are hosted in Azure Repos (which does
>> +  not support Git's partial clones, but supports its predecessor, the GVFS
>> +  protocol, which is used by Scalar to emulate the partial clone).
>> +
>> +  Since the GVFS protocol will never be supported by core Git, this patch series
>> +  will remain in Microsoft's fork of Git.
>> +
>> +- `run-scalar-functional-tests`: The Scalar project developed a quite
>> +  comprehensive set of integration tests (or, "Functional Tests"). They are the
>> +  sole remaining part of the original C#-based Scalar project, and this patch
>> +  adds a GitHub workflow that runs them all.
>> +
>> +  Since the tests partially depend on features that are only provided in the
>> +  `scalar-with-gvfs` patch series, this patch cannot be upstreamed.
> 
> We've had a good track record of identifying when an upstream change causes a
> failure in the Scalar Functional Tests and then porting that test into the Git test
> suite. I expect that to continue, but it has also not happened in a while. This is
> probably because the test coverage now has a significant amount of overlap. Many
> of the tests were created specifically for VFS for Git and strangeness around the
> virtual filesystem layer. Several of those have found interesting corner cases in
> Git's sparse-checkout feature, but these have probably been resolved by now.
> 
> Thanks for doing this work, Victoria. I'm excited to see how the project progresses
> with your new plan.
> 
> Thanks,
> -Stolee

