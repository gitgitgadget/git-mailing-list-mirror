Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D19C433F5
	for <git@archiver.kernel.org>; Thu, 27 Jan 2022 06:44:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236915AbiA0GoF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jan 2022 01:44:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234487AbiA0GoE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jan 2022 01:44:04 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF15C061714
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 22:44:04 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id u18so2237236edt.6
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 22:44:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MQdcHh4zu8qIaPSI1I0s6Hj+xNNvIDZ3Cf0o8943+P4=;
        b=WpDfGqyzgG5KBrH8fvThhsGm5JZQanYysIOBjVLH6pEEcuPSypdXS+SSUWLdZmfrrQ
         SbrgjAIGE70srxPieKyMX5dIVzxGxs4KdApn2YDk3hoOlX3CfiIhaIPSWVvoK61Yh34u
         LwAo9ZjJyAwAB7zvJCmKm/k7GKyv330vJ4FaPN7KZKUGfl2J+x7YQKjAfnMe2JsIzTjs
         AaR2cgypQFM3yJNxq/bdXNvGydcyZ7PwnjxJ50n2ZYy5Eujgvi2QNzoeiLDGlCeoLuE1
         PgQcfQGf1tfZ9diDoR6CdrOHlyImzGJJok1EmJoybIRqb82+6NDlqWblMDz+OTmZUfQN
         A9oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MQdcHh4zu8qIaPSI1I0s6Hj+xNNvIDZ3Cf0o8943+P4=;
        b=5T+FZHUojXoj43qXnrtUcnlq84hDnwVltMCsOhWIvF6HSBcvsJK6q+JBUEMFTHLYSs
         zffCyYpXNIf64sm/xfT49aQKA6WmIaMa6bRA6yO17YcbLLD5UkpcjRG/AIzB6cqxZNm3
         phEHMAjcxYGlySqTWhAjgMaOmaDDGfhO3v8odTomEi6qS4O70AG9HWPOwDMErnicxqaV
         bUgKKAvnp4A2IjAMKAnGbShraDuYjOWRi+6TEszYMcYyCevTeDiKCywrD83dw6UTggts
         v/TEvnCv0uz81LX6ve5R7A0SxoIr8qCxBgdgIOiru4mlqBz0yZfjpewpjys/3rtUYFd/
         2vLA==
X-Gm-Message-State: AOAM533wLfB6giewmL+0kMJe3928AKAL0kQft9uD2HHlH2LLx56yzJXn
        1tqYZ+R1SB5pV5Ye1vfgBbg0hqtyiIFKwFf0EYw=
X-Google-Smtp-Source: ABdhPJw4PsVV/hF/h14okLLiP5R4XUUrvh0uouckuVpMJw4lzrcOBV4N6+w9AYgAJ8mdL5ruGbWbucKE8IwtBQrP6m4=
X-Received: by 2002:a50:ec1a:: with SMTP id g26mr2361931edr.228.1643265842926;
 Wed, 26 Jan 2022 22:44:02 -0800 (PST)
MIME-Version: 1.0
References: <pull.1101.v3.git.1640727143.gitgitgadget@gmail.com>
 <pull.1101.v4.git.1643136134.gitgitgadget@gmail.com> <459e09dedd71fcb64b9796bac52c3812d78f2405.1643136134.git.gitgitgadget@gmail.com>
In-Reply-To: <459e09dedd71fcb64b9796bac52c3812d78f2405.1643136134.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 26 Jan 2022 22:43:51 -0800
Message-ID: <CABPp-BFiJnB0u6N5JViS7T_QrC=247gRto7R8DJ5s+f2nP_bKA@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] Documentation: add extensions.worktreeConfig details
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Sean Allred <allred.sean@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 25, 2022 at 10:42 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <dstolee@microsoft.com>
>
> The extensions.worktreeConfig extension was added in 58b284a (worktree:
> add per-worktree config files, 2018-10-21) and was somewhat documented
> in Documentation/git-config.txt. However, the extensions.worktreeConfig
> value was not specified further in the list of possible config keys. The
> location of the config.worktree file is not specified, and there are
> some precautions that should be mentioned clearly, but are only
> mentioned in git-worktree.txt.
>
> Expand the documentation to help users discover the complexities of
> extensions.worktreeConfig by adding details and cross links in these
> locations (relative to Documentation/):
>
> - config/extensions.txt
> - git-config.txt
> - git-worktree.txt
>
> The updates focus on items such as
>
> * $GIT_DIR/config.worktree takes precedence over $GIT_COMMON_DIR/config.
>
> * The core.worktree and core.bare=true settings are incorrect to have in
>   the common config file when extensions.worktreeConfig is enabled.
>
> * The sparse-checkout settings core.sparseCheckout[Cone] are recommended
>   to be set in the worktree config.
>
> As documented in 11664196ac ("Revert "check_repository_format_gently():
> refuse extensions for old repositories"", 2020-07-15), this extension
> must be considered regardless of the repository format version for
> historical reasons.
>
> A future change will update references to extensions.worktreeConfig
> within git-sparse-checkout.txt, but a behavior change is needed before
> making those updates.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  Documentation/config/extensions.txt | 31 +++++++++++++++++++++++++++++
>  Documentation/git-config.txt        |  8 ++++++--
>  Documentation/git-worktree.txt      | 11 +++++++---
>  3 files changed, 45 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/config/extensions.txt b/Documentation/config/extensions.txt
> index 4e23d73cdca..5999dcb2a1f 100644
> --- a/Documentation/config/extensions.txt
> +++ b/Documentation/config/extensions.txt
> @@ -6,3 +6,34 @@ extensions.objectFormat::
>  Note that this setting should only be set by linkgit:git-init[1] or
>  linkgit:git-clone[1].  Trying to change it after initialization will not
>  work and will produce hard-to-diagnose issues.
> +
> +extensions.worktreeConfig::
> +       If enabled, then worktrees will load config settings from the
> +       `$GIT_DIR/config.worktree` file in addition to the
> +       `$GIT_COMMON_DIR/config` file. Note that `$GIT_COMMON_DIR` and
> +       `$GIT_DIR` are the same for the main worktree, while other
> +       worktrees have `$GIT_DIR` equal to
> +       `$GIT_COMMON_DIR/worktrees/<worktree-name>/`. The settings in the
> +       `config.worktree` file will override settings from any other
> +       config files.
> ++
> +When enabling `extensions.worktreeConfig`, you must be careful to move
> +certain values from the common config file to the main worktree's
> +`config.worktree` file, if present:
> ++
> +* `core.worktree` must be moved from `$GIT_COMMON_DIR/config` to
> +  `$GIT_COMMON_DIR/config.worktree`.
> +* If `core.bare` is true, then it must be moved from `$GIT_COMMON_DIR/config`
> +  to `$GIT_COMMON_DIR/config.worktree`.
> ++
> +It may also be beneficial to adjust the locations of `core.sparseCheckout`
> +and `core.sparseCheckoutCone` depending on your desire for customizable
> +sparse-checkout settings for each worktree. By default, the `git
> +sparse-checkout` builtin enables `extensions.worktreeConfig`, assigns
> +these config values on a per-worktree basis, and uses the
> +`$GIT_DIR/info/sparse-checkout` file to specify the sparsity for each
> +worktree independently. See linkgit:git-sparse-checkout[1] for more
> +details.
> ++
> +For historical reasons, `extensions.worktreeConfig` is respected
> +regardless of the `core.repositoryFormatVersion` setting.
> diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
> index 2285effb363..95cefd5e399 100644
> --- a/Documentation/git-config.txt
> +++ b/Documentation/git-config.txt
> @@ -141,9 +141,13 @@ from all available files.
>  See also <<FILES>>.
>
>  --worktree::
> -       Similar to `--local` except that `.git/config.worktree` is
> +       Similar to `--local` except that `$GIT_DIR/config.worktree` is
>         read from or written to if `extensions.worktreeConfig` is
> -       present. If not it's the same as `--local`.
> +       enabled. If not it's the same as `--local`. Note that `$GIT_DIR`
> +       is equal to `$GIT_COMMON_DIR` for the main worktree, but is of the
> +       form `.git/worktrees/<worktree-name>/` for other worktrees. See

is of the form `$GIT_DIR/worktrees/<worktree-name>/`; .git isn't even
a directory in other worktrees.

> +       linkgit:git-worktree[1] to learn how to enable
> +       `extensions.worktreeConfig`.
>
>  -f <config-file>::
>  --file <config-file>::
> diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
> index 9e862fbcf79..ea0ee9f8bb5 100644
> --- a/Documentation/git-worktree.txt
> +++ b/Documentation/git-worktree.txt
> @@ -286,8 +286,8 @@ CONFIGURATION FILE
>  ------------------
>  By default, the repository `config` file is shared across all working
>  trees. If the config variables `core.bare` or `core.worktree` are
> -already present in the config file, they will be applied to the main
> -working trees only.
> +present in the common config file and `extensions.worktreeConfig` is
> +disabled, then they will be applied to the main working trees only.

"main working trees"?  Is that an accidental plural?

>  In order to have configuration specific to working trees, you can turn
>  on the `worktreeConfig` extension, e.g.:
> @@ -307,11 +307,16 @@ them to the `config.worktree` of the main working tree. You may also
>  take this opportunity to review and move other configuration that you
>  do not want to share to all working trees:
>
> - - `core.worktree` and `core.bare` should never be shared
> + - `core.worktree` should never be shared.
> +
> + - `core.bare` should not be shared unless the value is `core.bare=false`.

The double negative makes for harder parsing.  Perhaps
    - `core.bare` should not be shared if the value is `core.bare=true`
?

>   - `core.sparseCheckout` is recommended per working tree, unless you
>     are sure you always use sparse checkout for all working trees.
>
> +See the documentation of `extensions.worktreeConfig` in
> +linkgit:git-config[1] for more details.
> +
>  DETAILS
>  -------
>  Each linked working tree has a private sub-directory in the repository's
> --
> gitgitgadget

Thanks for documenting these details; I had some very minor comments
but this is well written and very helpful.
