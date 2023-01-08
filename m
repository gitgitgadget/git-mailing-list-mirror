Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51E47C54EBD
	for <git@archiver.kernel.org>; Sun,  8 Jan 2023 19:45:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbjAHTpr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Jan 2023 14:45:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjAHTpo (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Jan 2023 14:45:44 -0500
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24711137
        for <git@vger.kernel.org>; Sun,  8 Jan 2023 11:45:44 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-4bf16baa865so87926157b3.13
        for <git@vger.kernel.org>; Sun, 08 Jan 2023 11:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iqjXNac2YIyd5u6KDbky0JGzVWn7xNszkLPFeXcHCiA=;
        b=lYSNI7J74ybw7I3QQcy6sm1I7ooCLlNeHpVJn1URmTJH57cNoV9BE4oNyTyGmelXKn
         PRSM5PRIso/1e8oy/cpN1diN9M8Kai8+FfrZn/jgzBthjgWfEKCsjLfwldhT0eopGTHS
         19u8Gjq9sNZVnchIskU74jeji3SNb9aMoemGVAuCMgJkc/yH5Dx1z0uszS0JPPdaEZMm
         2Z8LGuTEYZ+G9nYLjhbNKhtu1XpIjwAquvE3AiPfJM7mMR3sBC52S7JraZ+yE1f58PQb
         CiIVRzw8ScQsMtZELJxc2MgFZzR8bFh1u7wCCk0v5lHBm6BXYhfz8+revgM8vFcWjNn2
         uJ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iqjXNac2YIyd5u6KDbky0JGzVWn7xNszkLPFeXcHCiA=;
        b=j8aVLySh58CqMTdPjUvUy89NPYYGKp9l1HewCR7ofeuRL7CfTTOZ6cXjKoghiah/Ti
         kSntJ+F6SnPWPPUFErN9xBSt/7WccZsZjpIpIQj/pCKMfB50fCIo+/nFNgMKVFAV1zGW
         ISDVG+X8plqiFKhRFtnbdq9gXo1CJEfyva2vWHV14cbdqK18BaTrKOwWfHk5YfBxGse/
         Q7pNA18CYhBDYpWYJ2qE7gKZ2OhpkZJFYnp0pKBxOLMZjK5FUtwBu47VZ7Yp7RqP3lru
         DXTYIPmXDM0UU8MjBQPt4pc6QnF0HLDTKe6/oKUzSSqGEATfI95xehfTvmOSGBlc6LO7
         c0Eg==
X-Gm-Message-State: AFqh2kpV0oNnHL6v22Ix7KCoEn/3Dt8ONWm6kuL9fienCLM/lhKuaeOT
        eBTcn6I3yHFU4OHdvvBITxRnLe/x+wCOA83i+bI=
X-Google-Smtp-Source: AMrXdXt1yf2cwjSxyQDLGm7C2dzax0ZO4+rvtrI1oAhk+rYSf97hp7EXL5XwBqoenQkseBaBcrGRtuxJhHTYIG8I4VI=
X-Received: by 2002:a05:690c:847:b0:391:7188:7454 with SMTP id
 bz7-20020a05690c084700b0039171887454mr389431ywb.212.1673207143315; Sun, 08
 Jan 2023 11:45:43 -0800 (PST)
MIME-Version: 1.0
References: <pull.1457.git.1673171924727.gitgitgadget@gmail.com>
In-Reply-To: <pull.1457.git.1673171924727.gitgitgadget@gmail.com>
From:   Preston Tunnell Wilson <prestontunnellwilson@gmail.com>
Date:   Sun, 8 Jan 2023 13:45:32 -0600
Message-ID: <CAC-j02O6z4sG85LpRNzEZ52Y-McurYDa_VnVXtqFVPBFu9kbug@mail.gmail.com>
Subject: Re: [PATCH] githooks: discuss Git operations in foreign repositories
To:     Eric Sunshine via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for this wonderful remedy, Eric! I really appreciate the
background context and how you framed the problem that I ran into.

I have two questions:
1. Documentation is a great first step in addressing this, but I'm
wondering if this should be automatic? If this is a best practice for
hook authors, could `git` do this for them automatically when running
hooks?
2. Should we add something in the `git-worktree` documentation? In
`Documentation/git-worktree.txt`, it mentions:

> BUGS
> ----
> Multiple checkout in general is still experimental, and the support
> for submodules is incomplete. ...

Would it be helpful to plant a flag in the above documentation to
point to this potential issue?

Thank you,
Preston


On Sun, Jan 8, 2023 at 3:58 AM Eric Sunshine via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Eric Sunshine <sunshine@sunshineco.com>
>
> Hook authors are periodically caught off-guard by difficult-to-diagnose
> errors when their hook invokes Git commands in a repository other than
> the local one. In particular, Git environment variables, such as GIT_DIR
> and GIT_WORK_TREE, which reference the local repository cause the Git
> commands to operate on the local repository rather than on the
> repository which the author intended. This is true whether the
> environment variables have been set manually by the user or
> automatically by Git itself. The same problem crops up when a hook
> invokes Git commands in a different worktree of the same repository, as
> well.
>
> Recommended best-practice[1,2,3,4,5,6] for avoiding this problem is for
> the hook to ensure that Git variables are unset before invoking Git
> commands in foreign repositories or other worktrees:
>
>     unset $(git rev-parse --local-env-vars)
>
> However, this advice is not documented anywhere. Rectify this
> shortcoming by mentioning it in githooks.txt documentation.
>
> [1]: https://lore.kernel.org/git/YFuHd1MMlJAvtdzb@coredump.intra.peff.net/
> [2]: https://lore.kernel.org/git/20200228190218.GC1408759@coredump.intra.peff.net/
> [3]: https://lore.kernel.org/git/20190516221702.GA11784@sigill.intra.peff.net/
> [4]: https://lore.kernel.org/git/20190422162127.GC9680@sigill.intra.peff.net/
> [5]: https://lore.kernel.org/git/20180716183942.GB22298@sigill.intra.peff.net/
> [6]: https://lore.kernel.org/git/20150203163235.GA9325@peff.net/
>
> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> ---
>     githooks: discuss Git operations in foreign repositories
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1457%2Fsunshineco%2Fhookenv-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1457/sunshineco/hookenv-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1457
>
>  Documentation/githooks.txt | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
> index a16e62bc8c8..6e9a5420b7c 100644
> --- a/Documentation/githooks.txt
> +++ b/Documentation/githooks.txt
> @@ -31,6 +31,17 @@ Hooks can get their arguments via the environment, command-line
>  arguments, and stdin. See the documentation for each hook below for
>  details.
>
> +If your hook needs to invoke Git commands in a foreign repository or in a
> +different working tree of the same repository, then it should clear local Git
> +environment variables, such as `GIT_DIR`, `GIT_WORK_TREE`, etc., which could
> +interfere with Git operations in the foreign repository since those variables
> +will be referencing the local repository and working tree. For example:
> +
> +------------
> +local_desc=$(git describe)
> +foreign_desc=$(unset $(git rev-parse --local-env-vars); git -C ../foreign-repo describe)
> +------------
> +
>  `git init` may copy hooks to the new repository, depending on its
>  configuration. See the "TEMPLATE DIRECTORY" section in
>  linkgit:git-init[1] for details. When the rest of this document refers
>
> base-commit: a38d39a4c50d1275833aba54c4dbdfce9e2e9ca1
> --
> gitgitgadget
