Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA695C3DA78
	for <git@archiver.kernel.org>; Sat, 14 Jan 2023 08:21:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjANIV3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Jan 2023 03:21:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjANIV2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Jan 2023 03:21:28 -0500
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C5D4692
        for <git@vger.kernel.org>; Sat, 14 Jan 2023 00:21:27 -0800 (PST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-4c131bede4bso315243997b3.5
        for <git@vger.kernel.org>; Sat, 14 Jan 2023 00:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cwlDgwNe00QjRxJ/KFqCI/yX1AcECCUWL7MSZzenkMI=;
        b=lqfY5RjV5xzT5HHyRrn7Rb6V0nnEezYXGBHaZakoC1zv3sWEEfB1dhE1OUxGlofm5T
         OCPZBHoNHTGGy5ei+xN+BQjSKTkK07EA0dA/sImBP1BKGXxWtqaSmVQzL+XoEetBX2Ph
         wKYPEmgUynlLLSOqlGHoStm+URnYENXCy7Q5o8FPijfWC6W8AcwKEfIgjSVMQzwwd2Do
         Y1s9v5vuV9Iz17tAqBeLnNi+Y6UK49klG9DdmAeZybdWVE3kqTuGAECxm0DQhIj9Gc9e
         8nNonl2Kjzriur7xt0u7ay+fS6bhwme30dlbdJSHk4CrjULu5+9sBfm30ozLm/e+Avey
         Snrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cwlDgwNe00QjRxJ/KFqCI/yX1AcECCUWL7MSZzenkMI=;
        b=0dpGl7ddA9T+nmWf6S6WP6oZCOQfJK5+GBXBnhgjUdakIZLOeHKGtG7vmQ4IDLg+pC
         ZT0j4d2igvE7Ds1Vho76qC4TvkNuvYI3uqRxRIHEPQiUSxfkz27RPZUWYB0kHCg0LPbm
         vdfCr+CSog9Nbd/uTfi+OA0hudGKoxyJnfNY4ppTe2uurVbB6ZIOyvjOZ14ffngKJCzb
         j/64/q/yIF1E4F7ek9CncOwsUgaX4mP5QHUij7QA7lLAkOSZLaSRLi1tj0jcm/FlW3mF
         B5cqr7oXkKTUpV53kX3ShPxi/dNGrBA5TK+MhPyv+DoGhxVHW7j2WVdPPkVeBqSKXaoW
         Ykvg==
X-Gm-Message-State: AFqh2kpkuplHhetb7ncQEavJAa4HSnsKc6U7cOLC78RIMD5NFRZYBok+
        1juC61FDNqy+f/eouFvIFrYYMamY2MLBoVUXjbM=
X-Google-Smtp-Source: AMrXdXs+JVL+UuW72heN+TC0R33PGk6SYgmLNgrTVTW2PefGQ28qdbooGgDxJnYCwzA20W5kwh4OeIjmm26qQX5ai4U=
X-Received: by 2002:a0d:c201:0:b0:488:7800:3b03 with SMTP id
 e1-20020a0dc201000000b0048878003b03mr1557999ywd.209.1673684486431; Sat, 14
 Jan 2023 00:21:26 -0800 (PST)
MIME-Version: 1.0
References: <pull.1463.git.1673584914.gitgitgadget@gmail.com> <1d1330243109d499d1c07f6518265b2e163406ef.1673584914.git.gitgitgadget@gmail.com>
In-Reply-To: <1d1330243109d499d1c07f6518265b2e163406ef.1673584914.git.gitgitgadget@gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sat, 14 Jan 2023 16:21:14 +0800
Message-ID: <CAOLTT8Qx6chcA7MEY9Hzeq9U5pfR-fC8aOxhZMvYvi8ZtQeVdA@mail.gmail.com>
Subject: Re: [PATCH 2/4] ls-files: clarify descriptions of file selection options
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren via GitGitGadget <gitgitgadget@gmail.com> =E4=BA=8E2023=E5=B9=
=B41=E6=9C=8813=E6=97=A5=E5=91=A8=E4=BA=94 12:41=E5=86=99=E9=81=93=EF=BC=9A
>
> From: Elijah Newren <newren@gmail.com>
>
> The previous descriptions of the file selection options were very easy
> to misunderstand.  For example:
>
>   * "Show cached files in the output"
>     This could be interpreted as meaning "show files which have been
>     modified and git-add'ed, i.e. files which have cached changes
>     relative to HEAD".
>
>   * "Show deleted files"
>     This could be interpreted as meaning "for each `git rm $FILE` we
>     ran, show me $FILE"
>
>   * "Show modified files"
>     This could be interpreted as meaning "show files which have been
>     modified and git-add'ed" or as "show me files that differ from HEAD"
>     or as "show me undeleted files different from HEAD" (given that
>     --deleted is a separate option), none of which are correct.
>
> Further, it's not very clear when some options only modify and/or
> override other options, as was the case with --ignored, --directory, and
> --unmerged (I've seen folks confused by each of them on the mailing
> list, sometimes even fellow git developers.)
>
> Tweak these definitions, and the one for --killed, to try to make them
> all a bit more clear.  Finally, also clarify early on that duplicate
> reports for paths are often expected (both when (a) there are multiple
> entries for the file in the index -- i.e. when there are conflicts, and
> also (b) when the user specifies options that might pick the same file
> multiple times, such as `git ls-files --cached --deleted --modified`
> when there is a file with an unstaged deletion).
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  Documentation/git-ls-files.txt | 37 ++++++++++++++++++++++------------
>  1 file changed, 24 insertions(+), 13 deletions(-)
>
> diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.=
txt
> index cb071583f8b..f89ab1bfc98 100644
> --- a/Documentation/git-ls-files.txt
> +++ b/Documentation/git-ls-files.txt
> @@ -29,21 +29,26 @@ This merges the file listing in the index with the ac=
tual working
>  directory list, and shows different combinations of the two.
>
>  One or more of the options below may be used to determine the files
> -shown:
> +shown, and each file may be printed multiple times if there are
> +multiple entries in the index or multiple statuses are applicable for
> +the relevant file selection options.
>

`--deduplicate` option can be used to remove deduped output.

>  OPTIONS
>  -------
>  -c::
>  --cached::
> -       Show cached files in the output (default)
> +       Show all files cached in Git's index, i.e. all tracked files.
> +       (This is the default if no -c/-s/-d/-o/-u/-k/-m/--resolve-undo
> +       options are specified.)
>
>  -d::
>  --deleted::
> -       Show deleted files in the output
> +       Show files with an unstaged deletion
>

This is a nice fix: make it clear to the user that only files in the
working tree are deleted, not in the index.

>  -m::
>  --modified::
> -       Show modified files in the output
> +       Show files with an unstaged modification (note that an unstaged
> +       deletion also counts as an unstaged modification)
>

Good to mention that deleted files are also modified, otherwise no one
looking at the documentation would know that.

>  -o::
>  --others::
> @@ -51,11 +56,14 @@ OPTIONS
>
>  -i::
>  --ignored::
> -       Show only ignored files in the output. When showing files in the
> -       index, print only those matched by an exclude pattern. When
> -       showing "other" files, show only those matched by an exclude
> -       pattern. Standard ignore rules are not automatically activated,
> -       therefore at least one of the `--exclude*` options is required.
> +       Show only ignored files in the output.  Must be used with
> +       either an explicit '-c' or '-o'.  When showing files in the
> +       index (i.e. when used with '-c'), print only those files
> +       matching an exclude pattern.  When showing "other" files
> +       (i.e. when used with '-o'), show only those matched by an
> +       exclude pattern.  Standard ignore rules are not automatically
> +       activated, therefore at least one of the `--exclude*` options
> +       is required.
>
>  -s::
>  --stage::
> @@ -64,19 +72,22 @@ OPTIONS
>  --directory::
>         If a whole directory is classified as "other", show just its
>         name (with a trailing slash) and not its whole contents.
> +       Has no effect without -o/--others.
>
>  --no-empty-directory::
>         Do not list empty directories. Has no effect without --directory.
>
>  -u::
>  --unmerged::
> -       Show unmerged files in the output (forces --stage)
> +       Show information about unmerged files in the output, but do
> +       not show any other tracked files (forces --stage, overrides
> +       --cached).
>
>  -k::
>  --killed::
> -       Show files on the filesystem that need to be removed due
> -       to file/directory conflicts for checkout-index to
> -       succeed.
> +       Show untracked files on the filesystem that need to be removed
> +       due to file/directory conflicts for tracked files to be able to
> +       be written to the filesystem.
>
>  --resolve-undo::
>         Show files having resolve-undo information in the index
> --
> gitgitgadget
>
