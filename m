Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B64C433F5
	for <git@archiver.kernel.org>; Fri,  3 Dec 2021 15:48:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381881AbhLCPvn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Dec 2021 10:51:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233978AbhLCPvn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Dec 2021 10:51:43 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2BFAC061751
        for <git@vger.kernel.org>; Fri,  3 Dec 2021 07:48:18 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id v1so13358090edx.2
        for <git@vger.kernel.org>; Fri, 03 Dec 2021 07:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yQdWemKpqySB9S5U7jGIztknGkUvn8rlhLmeZvcg2Eo=;
        b=p5qzEXGQ4BFaTwfGFPT16GidlhBaoPF2qAotsxoJbtJqcOi7YFUgGmhTjgBkUTVYpo
         xONXLMdpG/P9ZJDVxEmidtpmT44oGVdDJoUa5ZrTAwFgvis+096ZfTGOR3uWJsyqwaxI
         RVuNp3mXVMeg4cDM+UVWBe9AW7Ccqld39dEKCw/Z19Uwx+a+7YOOHzqiatIRqKMLxoS5
         Mh41csT0nTN9RfByR1TGBNIhNjxOn/OkSlhTKbloChhYcClzzl+thmIGXo9pGjXAMFv2
         V/UcjOztGJ1U40G178I9APLQSomWN81COgmk+Oys5WzGDR6CEjtSGzU5K9Stl8cuQnLE
         xlLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yQdWemKpqySB9S5U7jGIztknGkUvn8rlhLmeZvcg2Eo=;
        b=CQEnX7OPDgKDTQvQdsbyve3mfSdDUQ4m/LMM67hEVQFTQ/q+CxvjjVAz73Cqilrtgr
         0TbAtpDTX5chKpoLtxEAA9ZjJmQU2iZIs/ya+kuqkdW+rJX0H69ZafR64D85AkGhB1Ml
         uCso5T+2WDjpMVAmKzS4ItBqN4X8xD6n5qm8cqeD0AcR0Dss/w+qGb0aXMjaXQjGPrt+
         IwVlQaWD4Feolyx1p0LJniKmQ8McnQmJ4r+Ryf3jujDgLcVQTtCEEFpJoVH+QZHr46dQ
         0mb7WtEHPpRRhPb0tHjekys1rNUF9j8KpvJSFYBGagHDhU8Jx2MdAdqhvdyQQ8JpbZGH
         qdFA==
X-Gm-Message-State: AOAM532pDirO8svRG0n9d93q0UMncCnnJ8vRsfQ7htEK9dwCzBIBohuu
        Z6Y6K02fm1NoaFVlTGdWy4S+VIaJCd9dED0VzSE=
X-Google-Smtp-Source: ABdhPJxewz4PZaJs75JMkVcJMJB4xZazURGJN+0UPMFNdQF9MlwckU0VLl+lUv8hBjdYo2AigWeSxNzuUng0Hq63b8Q=
X-Received: by 2002:a05:6402:1014:: with SMTP id c20mr27952726edu.186.1638546496105;
 Fri, 03 Dec 2021 07:48:16 -0800 (PST)
MIME-Version: 1.0
References: <pull.1005.v9.git.1638273289.gitgitgadget@gmail.com> <pull.1005.v10.git.1638538470.gitgitgadget@gmail.com>
In-Reply-To: <pull.1005.v10.git.1638538470.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 3 Dec 2021 07:48:04 -0800
Message-ID: <CABPp-BGpe9Q5k22Yu8a=1xwu=pZYSeNQoqEgf+DN07cU4EB1ew@mail.gmail.com>
Subject: Re: [PATCH v10 00/15] Upstreaming the Scalar command
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Matt Rogers <mattr94@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 3, 2021 at 5:34 AM Johannes Schindelin via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> tl;dr: This series contributes the core part of the Scalar command to the
> Git project. This command provides a convenient way to clone/initialize very
> large repositories (think: monorepos).
>
> Note: This patch series' focus is entirely on Scalar, on choosing sensible
> defaults and offering a delightful user experience around working with
> monorepos, and not about changing any existing paradigms for contrib/ (even
> if catching up on the mail thread is likely to give interested readers that
> false impression).
>
> Changes since v9:
>
>  * The patches to build Scalar and run its tests as part of Git's CI/PR,
>    have been dropped because a recent unrelated patch series does not
>    interact well with them.


i.e. basically undoing this:

...
> Changes since v6:
...
>  * I added two patches that I had planned on keeping in an add-on patch
>    series for later, to build and test Scalar as part of the CI. I am still
>    not 100% certain that it is a good idea to do so already now, but let's
>    see what the reviewers have to say.

...and returning to the original plan:

...
> On top of this patch series, I have lined up a few more:
...
>  4. A few patches to optionally build and install scalar as part of a
>     regular Git install (also teaching git help scalar to find the Scalar
>     documentation

Avoiding the issues and adding the CI later seems reasonable to me.
You addressed the last of my points in v9; I think this version is
good to go.  But one quick comment...

> These are included in my vfs-with-scalar branch thicket
> [https://github.com/dscho/git/commits/vfs-with-scalar]. On top of that, this
> branch thicket also includes patches I do not plan on upstreaming, mainly
> because they are too specific either to VFS for Git, or they support Azure
> Repos (which does not offer partial clones but speaks the GVFS protocol,
> which can be used to emulate partial clones).
>
> One other thing is very interesting about that vfs-with-scalar branch
> thicket: it contains a GitHub workflow which will run Scalar's quite
> extensive Functional Tests suite. This test suite is quite comprehensive and
> caught us a lot of bugs in the past, not only in the Scalar code, but also
> core Git.

From your wording it sounds like the plan might not include moving
these tests over.  Perhaps it doesn't make sense to move them all
over, but since they've caught problems in both Scalar and core Git,
it would be nice to see many of those tests come to Git as well as
part of a future follow on series.
