Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B07A3C433F5
	for <git@archiver.kernel.org>; Wed,  9 Feb 2022 18:04:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238607AbiBISEY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Feb 2022 13:04:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238461AbiBISES (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Feb 2022 13:04:18 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2581C05CB87
        for <git@vger.kernel.org>; Wed,  9 Feb 2022 10:04:20 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id y3so9766240ejf.2
        for <git@vger.kernel.org>; Wed, 09 Feb 2022 10:04:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=37xMKqZXjw5fKI0aD4I3+IqYkgH5FsN0xE81pbDG8oI=;
        b=kItcnCPlGZH5bEmeuhVLoJAN1gJ6b8RH7+xwj8yakAREfciBiWih3oaXUX5a71dqJE
         44Y9e1oLLwImXnTnhTEZBzSG7dT4ve4n92CRCcM07XEJtfC+S9ej1gUpvo9N/mP540S/
         vpTipbW+zJTAJdLod1KQXGFx3rFqt7TxwSb5hGN0eeeK9DfmWwz9HNoEECWHME7nzrEy
         4EkZ0Beuwk6J36nVy0fYxcW1o8vYL1WbOmbBmVH8YydRswGk/b6agW3mO6kUBHyswP7J
         tSHwI9eOXWXyiffuoq3V0bztAj58XSpAO/f46hY+b/L+hp6rfaLPE6k3F1vsf1Yu4U1T
         pZ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=37xMKqZXjw5fKI0aD4I3+IqYkgH5FsN0xE81pbDG8oI=;
        b=sv3kwdCQ0nHrAa1R5xXwP8Vs0wKltmQibQD+Ms6QieR1oF2/pZaEI+NGsej+ozvpMi
         F6RbFNVkYm/aHw4+2LEyUHxbk9b0v7Ar7QMMNBpFLME3HVVX7jY1luPXlSvAq4bvRPfm
         DFDsxU1AtPqhtKRQoRJcIVqu3yD6UVgL+abosdyl9r4SSOJEoL2BZKLG3IkFAoXWw4F7
         FdA/qF9UbavMFztxtW2INGd9m1k6cK8rl7qRFQyMeiqY2erPrIjAeY43jWuER5KH9rm7
         PvZP1oEdKfvyHDT2woQ+ro2J1XqDKGQZfY8Ry7rP6U6le4pNdTHOC/PWNfLU9cHQc1YK
         msMw==
X-Gm-Message-State: AOAM533HIuWQvuDmOaPd3+e2WRF1UXaEHhUl20T10QeoC9Icjo2qMoFn
        KOZGaZhd4vIOra+eEqa/G0wsvhMIHN7SeYxfmk0=
X-Google-Smtp-Source: ABdhPJyThPN7wCidAaxOoObjHor8qCNRwlKYmcAXNHiroAm2BYpQ+rxnaOiwBubkQo2CkVhtIASVAZg2IUgtaZqazGQ=
X-Received: by 2002:a17:906:4fcb:: with SMTP id i11mr2521335ejw.269.1644429859287;
 Wed, 09 Feb 2022 10:04:19 -0800 (PST)
MIME-Version: 1.0
References: <pull.1101.v5.git.1643641259.gitgitgadget@gmail.com>
 <pull.1101.v6.git.1644269583.gitgitgadget@gmail.com> <0260ff6cac0c76c6d66187d77defef1edd4c6fb5.1644269583.git.gitgitgadget@gmail.com>
 <xmqqo83hatm1.fsf@gitster.g>
In-Reply-To: <xmqqo83hatm1.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 9 Feb 2022 10:04:07 -0800
Message-ID: <CABPp-BGj7DZY8D-Ps3fhcRik_gSGoDyoFokuUMRN_Q7Z2cbEfw@mail.gmail.com>
Subject: Re: [PATCH v6 1/6] Documentation: add extensions.worktreeConfig details
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Sean Allred <allred.sean@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?Q?Jean=2DNo=C3=ABl_AVILA?= <jn.avila@free.fr>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 8, 2022 at 2:20 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > diff --git a/Documentation/config/extensions.txt b/Documentation/config/extensions.txt
> > index 4e23d73cdca..bccaec7a963 100644
> > --- a/Documentation/config/extensions.txt
> > +++ b/Documentation/config/extensions.txt
> > @@ -6,3 +6,34 @@ extensions.objectFormat::
> >  Note that this setting should only be set by linkgit:git-init[1] or
> >  linkgit:git-clone[1].  Trying to change it after initialization will not
> >  work and will produce hard-to-diagnose issues.
> > +
> > +extensions.worktreeConfig::
> > +     If enabled, then worktrees will load config settings from the
> > +     `$GIT_DIR/config.worktree` file in addition to the
> > +     `$GIT_COMMON_DIR/config` file. Note that `$GIT_COMMON_DIR` and
> > +     `$GIT_DIR` are the same for the main working tree, while other
> > +     working trees have `$GIT_DIR` equal to
> > +     `$GIT_COMMON_DIR/worktrees/<id>/`. The settings in the
>
> The mixed use of "worktree" and "working tree" in this paragraph
> might confuse readers into thinking that the paragraph is being
> careful to make distinction between the two.  All references to
> "working tree" in the above paragraph should actually be "worktree",
> I would think.
>
>         Side note: "working tree" is in the glossary-content.txt,
>         but "worktree", which is one "working tree" + repository
>         metadata (i.e. ".git/") that may be partially shared with
>         other "worktree"s of a single repository, is not defined.
>
> This is a tangent, but I wonder why we chose to use a different
> filename (i.e. not "config" but "config.worktree") for this.  If we
> were redoing multi-worktree support from scratch, we would not reuse
> the $GIT_DIR used by the primary worktree as $GIT_COMMON_DIR, so
> that all worktrees would share a single $GIT_COMMON_DIR and
> $GIT_COMMON_DIR/config that has stuff that is shared among all the
> worktrees, while per worktree stuff is in $GIT_DIR/config even for
> the primary worktree.  But that is all water under the bridge now.
>
> Other than the terminology gotcha, looked sensible.  Migrating
> automatically and/or noticing a suspicious setting may be needed to
> help end users, but that would not be within the scope of this step.
>
> Attached is a "how about this?" glossary update suggestion.  Most of
> the existing mention of "working tree" are fine as-is because they
> only care about what is in the "working tree", but some should be
> changed to "worktree" to stress the fact that they care not just the
> "working tree" part but also the repository metadata part that is
> associated with that single "working tree".  The first hunk says
> worktree but it is clear that it is interested only in the "working
> tree" files.
>
>  Documentation/glossary-content.txt | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git c/Documentation/glossary-content.txt w/Documentation/glossary-content.txt
> index c077971335..d816512c6a 100644
> --- c/Documentation/glossary-content.txt
> +++ w/Documentation/glossary-content.txt
> @@ -312,7 +312,7 @@ Pathspecs are used on the command line of "git ls-files", "git
>  ls-tree", "git add", "git grep", "git diff", "git checkout",
>  and many other commands to
>  limit the scope of operations to some subset of the tree or
> -worktree.  See the documentation of each command for whether
> +working tree.  See the documentation of each command for whether
>  paths are relative to the current directory or toplevel.  The
>  pathspec syntax is as follows:
>  +
> @@ -446,7 +446,7 @@ exclude;;
>         interface than the <<def_plumbing,plumbing>>.
>
>  [[def_per_worktree_ref]]per-worktree ref::
> -       Refs that are per-<<def_working_tree,worktree>>, rather than
> +       Refs that are per-<<def_worktree,worktree>>, rather than
>         global.  This is presently only <<def_HEAD,HEAD>> and any refs
>         that start with `refs/bisect/`, but might later include other
>         unusual refs.
> @@ -669,3 +669,12 @@ The most notable example is `HEAD`.
>         The tree of actual checked out files.  The working tree normally
>         contains the contents of the <<def_HEAD,HEAD>> commit's tree,
>         plus any local changes that you have made but not yet committed.
> +
> +[[def_work_tree]]worktree::
> +       A repository can have zero (i.e. bare repository) or one or
> +       more worktrees attached to it. One "worktree" consists of a
> +       "working tree" and repository metadata, most of which are
> +       shared among other worktrees of a single repository, and
> +       some of which are maintained separately per worktree
> +       (e.g. the index, HEAD, per-worktree refs and per-worktree
> +       configuration file)

We could also add pseudorefs to the list of things maintained
separately in the final parenthetical comment, but otherwise looks
good.
