Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCDB2C6FA82
	for <git@archiver.kernel.org>; Tue, 20 Sep 2022 00:43:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbiITAnf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Sep 2022 20:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiITAnd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2022 20:43:33 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A17052808
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 17:43:31 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id p4so1396529vsa.9
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 17:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=KIot9/ofDZflPsLVsrK6VhE5RdEDapppFzIjW1/cwWg=;
        b=bGU+Mbuk589H0CHjZK4oGLfXy6wxYhuGuhAxr9B2AEO1ciIfJuUObhdKXmaOYqgp96
         IgmOgtDfM+bTcqDa6QtCRokPkd/KGF4JmmfFQ0bRa8RXmpCGWwJbN04OtLELUd09kNdD
         Q0tZM7kFVRQj8CSHkW5mhKhQzfKcILiTgWcIPF2bVza9u2K/qOdeis3DDeS2lWQsyyOv
         BXUOHIvpkceHmamscNHa5eDfez3xhAlhb7AKZcTH9Ca0lSEYOCCWTqZRKGyg3VYUz0bz
         dfPhl4XQM31OFZvDnf5MXIxPieensX/g0p3oGkJK2pEsPTUNRE6M8UFJSE5wn5Gi8SQx
         7PMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=KIot9/ofDZflPsLVsrK6VhE5RdEDapppFzIjW1/cwWg=;
        b=k/+XzE7Kv663F6C0u8OdlJwc62YgwAPKt/Pr1ntzHgxgPVCXOBsNqijmg3Prn07Lhp
         cIKXIFnxpCr9EwIoXA8fNOzulgW1Y4x3H3UsD0RzGVj6E0lHHdfidNKi4fApeQ4C3hKh
         klsJtQ24vXXjElgA2f2vLvsOjQhdguJsjJ5VKc+Chzx4twlEMofTMvDRBR2iYqrBMcBb
         tkADb/OPKwgmo3r+DB7D9q6KNWomAj/LTbeBFlvxa6mGGOJu4HUyM3JW8E3OTCjDKfel
         YInyuDw3Tf1Kq9XKv069IBXDwDyaDxzpfs05wXV8G9/uTKHXXNY83R9yBzbbYZ2aQ6Zg
         2jvw==
X-Gm-Message-State: ACrzQf3N/Enfaf0auIZVt/Qh9qWG2sGifqNY6lx/B+x5NqBSyGOY0jmE
        XCfNMSH2HYBmEbY9oJMW7ye68oKIqHo8bQ6u5pY=
X-Google-Smtp-Source: AMsMyM6V7vVQ9ntlUtVfQWEGy900M4A0KleYaxebCh5k6KjuLLiMowIzzzhieR7L0mvbOH2R7CGNcMFYXyh5Q/pdXhY=
X-Received: by 2002:a67:ca9b:0:b0:398:4fc7:b09d with SMTP id
 a27-20020a67ca9b000000b003984fc7b09dmr7454578vsl.12.1663634610304; Mon, 19
 Sep 2022 17:43:30 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1348.git.1662747205235.gitgitgadget@gmail.com> <pull.1348.v2.git.1663614767058.gitgitgadget@gmail.com>
In-Reply-To: <pull.1348.v2.git.1663614767058.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 19 Sep 2022 17:43:15 -0700
Message-ID: <CABPp-BEB_+YoKZ=U6NPc8J+KZyMSYRsom34CeqjxUCyw0=LEyg@mail.gmail.com>
Subject: Re: [PATCH v2] Documentation: add ReviewingGuidelines
To:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Josh Steadmon <steadmon@google.com>,
        Glen Choo <chooglen@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Victoria Dye <vdye@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 19, 2022 at 12:21 PM Victoria Dye via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
[...]
> +==== Performing your review
> +- Provide your review comments per-patch in a plaintext "Reply-All" email to the
> +  relevant patch. Comments should be made inline, immediately below the relevant
> +  section(s).
> +
> +- You may find that the limited context provided in the patch diff is sometimes
> +  insufficient for a thorough review. In such cases, you can review patches in
> +  your local tree by either applying patches with linkgit:git-am[1] or checking
> +  out the associated branch from https://github.com/gitster/git once the series
> +  is tracked there.

Lots of reviews also come with "Fetch-It-Via" instructions in the
cover letter, making it really easy to grab.  Might be worth
mentioning?

Also, would it make sense for us to replace "applying" with
"downloading and applying", perhaps mentioning `b4 am` for the
downloading half?

(I tend to use the Fetch-It-Via or wait for it to show up in
gitster/git, but b4 is really nice for the other cases.)

> +- Large, complicated patch diffs are sometimes unavoidable, such as when they
> +  refactor existing code. If you find such a patch difficult to parse, try
> +  reviewing the diff produced with the `--color-moved` and/or
> +  `--ignore-space-change` options.

Similarly, Documentation refactorings or significant rewordings are
sometimes easier to view with --color-words or --color-words=.

[...]
> +See Also
> +--------
> +link:MyFirstContribution.html[MyFirstContribution]
>
> base-commit: 79f2338b3746d23454308648b2491e5beba4beff

I like this document!  I had a couple ideas that might or might not
make sense to include in the document; it looks good to me either way.
