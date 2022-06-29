Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 649AFC43334
	for <git@archiver.kernel.org>; Wed, 29 Jun 2022 17:58:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232192AbiF2R6p (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jun 2022 13:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232086AbiF2R6a (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jun 2022 13:58:30 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BAD01D329
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 10:58:22 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-101dc639636so22448726fac.6
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 10:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=g/jSnMZlz7tUzHtFvQ9NqzR8oCxiDPcehh3Q1Uo5dsQ=;
        b=iVozl9y8XOxVGAAthlZJeh/VQCwbCrZommGS9MZJFrjw3QOtNcG1Qum+l/N7S2VnGa
         x1nFhx7XGRwX59UekqPPwtwNxbqLW1QE8SxGrkEqFPyUonNKkjLNT94BnvOZ45vogzdM
         pXRorY9kwN6FvJdHqzufvX4cXsYAvEYTETS/dGon2E1Z21lJDNo4YGDXmW5RV6UtqczH
         p2Fk72G0LLgickM8RjlNjaQ38mwd47GPzLPa/KExwNP7mhuWLk4UNIgkB1UmlkShleIX
         A7g0s0v+XYWj5f4/PwwaFz1QjMTfj2Nww49GQ0wHqzZ1AQ8/bDrfC5s+kBz2kPDeUKVE
         3dlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=g/jSnMZlz7tUzHtFvQ9NqzR8oCxiDPcehh3Q1Uo5dsQ=;
        b=H2Jer0Vmvzrgc5OvCg4iM+qljIjGYRhyKB1bQFSVENZW9yWrhMLXp/CqcRYJBTdE5c
         Ki7ZIAimzsIwpA1u1/4CuIzPRGYZ2h00LZcg0kyNhCEP9hBV0wcip/UOGZf9etYbXupU
         xJGhiXVJAggjdvKYPS6aA7RfXUo5W5gQSCJqSUObSnJZp+TnMYE8wg4wlL78L1zFls++
         2jN8yX6n70N1Pig8jkNMwsDd2yeSTPdpwDRqDYvoHoTPAPSAa5PsRKJay7lUZUNt5Z7B
         BsCgzR9qfMdaZiz6ZyiKUQ2iNJjCeqZ0NtiT7d6qtzjHH5dTFmsopdplfLSAvvmJqRJK
         6lKw==
X-Gm-Message-State: AJIora8XBjXfrOItbgqNTiCE2ucUSGnFPiNZmD9H/iYJ4qCxdaV8DhXD
        nGhUBMlnDjh1SVOSP4IOKMVD
X-Google-Smtp-Source: AGRyM1swJIsgjD9niW/t6YdZoGGeYFNZFspxcXo2rMrgidi7+vU2oYRsW3tTKxpjDju//7zaD/5G3g==
X-Received: by 2002:a05:6870:f71d:b0:fe:3ed6:d447 with SMTP id ej29-20020a056870f71d00b000fe3ed6d447mr2815644oab.26.1656525501370;
        Wed, 29 Jun 2022 10:58:21 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:8945:6633:39ae:9965? ([2600:1700:e72:80a0:8945:6633:39ae:9965])
        by smtp.gmail.com with ESMTPSA id i6-20020a056870c1c600b00101ae32e179sm11353745oad.51.2022.06.29.10.58.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jun 2022 10:58:20 -0700 (PDT)
Message-ID: <994f2efd-0789-afad-ba0d-27da9692b289@github.com>
Date:   Wed, 29 Jun 2022 13:58:18 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 2/2] scalar: convert README.md into a technical design doc
Content-Language: en-US
To:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, gitster@pobox.com,
        Victoria Dye <vdye@github.com>
References: <pull.1275.git.1656521925.gitgitgadget@gmail.com>
 <870bd90e47e918f37db5a8d444e5c9a5717f9c17.1656521926.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <870bd90e47e918f37db5a8d444e5c9a5717f9c17.1656521926.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/29/2022 12:58 PM, Victoria Dye via GitGitGadget wrote:
> From: Victoria Dye <vdye@github.com>
> 
> Replace 'README.md' with 'technical/scalar.txt' (still in 'contrib/'). In
> addition to reformatting for asciidoc, elaborate on the background, purpose,
> and design choices that went into Scalar.
> 
> This document is intended to persist in the 'Documentation/technical/'
> directory after Scalar has been moved into the root of Git (out of

I wonder if it is a good idea to move this into Documentation/technical/ _now_,
so we can have this document as part of "core Git's roadmap" as much as we can
say that. Part of the roadmap is moving the Scalar code out of contrib/ and
finalizing how users (or distributors) can install the 'scalar' binary.

It can be helpful to include the details of what steps to take to compile and
test the 'scalar' executable. That documentation will then be updated when
Scalar moves out of contrib/.

> +Scalar
> +======
> +
> +Scalar is a built-in repository management tool that optimizes Git for use in

I think "built-in" is unnecessary here. It makes me think of Git builtins and
otherwise does not add much to the description.

> +large repositories. It accomplishes this by helping users to take advantage of
> +advanced performance features in Git. Unlike most other Git built-in commands,
> +Scalar is not executed as a subcommand of 'git'; rather, it is built as a
> +separate executable containing its own series of subcommands.

Good to have this distinction.

> +Scalar is a large enough project that it is being upstreamed incrementally,
> +living in `contrib/` until it is feature-complete. So far, the following patch
> +series have been accepted:
> +
> +- `scalar-the-beginning`: The initial patch series which sets up
> +  `contrib/scalar/` and populates it with a minimal `scalar` command that
> +  demonstrates the fundamental ideas.
> +
> +- `scalar-c-and-C`: The `scalar` command learns about two options that can be
> +  specified before the command, `-c <key>=<value>` and `-C <directory>`.
> +
> +- `scalar-diagnose`: The `scalar` command is taught the `diagnose` subcommand.
> +
> +Roughly speaking (and subject to change), the following series are needed to
> +"finish" this initial version of Scalar:

I like how you have these two sections. As you move forward in this roadmap,
the diff to the document should look like you are _moving_ the sentence above.

> +- Finish Scalar features: Enable the built-in FSMonitor in Scalar
> +  enlistments and implement `scalar help`. At the end of this series, Scalar
> +  should be feature-complete from the perspective of a user.

Wow, we're so close!

> +- Generalize features not specific to Scalar: In the spirit of
> +  making Scalar configure only what is needed for large repo performance, move

(nit: Strange wrapping on the first line)

> +  common utilities into other parts of Git. Some of this will be internal-only,
> +  but one major change will be generalizing `scalar diagnose` for use with any
> +  Git repository.
> +
> +- Move Scalar to toplevel: Make `scalar` a built-in component of Git by

Here, I would say "included" instead of built-in. Or is there another term we
should use to avoid confusion with "git <cmd>" builtins.

> +  moving it out of `contrib/` and into the root of `git`. The actual change will
> +  be relatively small, but this series will also contain expanded testing to
> +  ensure Scalar is stable and performant.

Perhaps "This change will also integrate Scalar into Git's test suite and CI
checks."

You mention "performant" which makes me think that performance tests are intended
to be part of this change. It makes me think it would be interesting to have our
existing performance tests create a mode where they compare a "vanilla" Git repo
to one registered with Scalar, but otherwise runs the same tests already in the
t/perf/ test scripts. This is a wide aside so feel free to ignore me.

> +Finally, there are two additional patch series that exist in Microsoft's fork of
> +Git, but there is no current plan to upstream them. There are some interesting
> +ideas there, but the implementation is too specific to Azure Repos and/or VFS
> +for Git to be of much help in general.
> +
> +These still exist mainly because the GVFS protocol is what Azure Repos has
> +instead of partial clone, while Git is focused on improving partial clone:
> +
> +- `scalar-with-gvfs`: The primary purpose of this patch series is to support
> +  existing Scalar users whose repositories are hosted in Azure Repos (which does
> +  not support Git's partial clones, but supports its predecessor, the GVFS
> +  protocol, which is used by Scalar to emulate the partial clone).
> +
> +  Since the GVFS protocol will never be supported by core Git, this patch series
> +  will remain in Microsoft's fork of Git.
> +
> +- `run-scalar-functional-tests`: The Scalar project developed a quite
> +  comprehensive set of integration tests (or, "Functional Tests"). They are the
> +  sole remaining part of the original C#-based Scalar project, and this patch
> +  adds a GitHub workflow that runs them all.
> +
> +  Since the tests partially depend on features that are only provided in the
> +  `scalar-with-gvfs` patch series, this patch cannot be upstreamed.

We've had a good track record of identifying when an upstream change causes a
failure in the Scalar Functional Tests and then porting that test into the Git test
suite. I expect that to continue, but it has also not happened in a while. This is
probably because the test coverage now has a significant amount of overlap. Many
of the tests were created specifically for VFS for Git and strangeness around the
virtual filesystem layer. Several of those have found interesting corner cases in
Git's sparse-checkout feature, but these have probably been resolved by now.

Thanks for doing this work, Victoria. I'm excited to see how the project progresses
with your new plan.

Thanks,
-Stolee
