Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86F81C77B7E
	for <git@archiver.kernel.org>; Thu, 25 May 2023 07:26:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239056AbjEYH0C (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 May 2023 03:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjEYH0B (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 May 2023 03:26:01 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADEA31BD
        for <git@vger.kernel.org>; Thu, 25 May 2023 00:25:54 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-75b2726f04cso33110585a.3
        for <git@vger.kernel.org>; Thu, 25 May 2023 00:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=adamj.eu; s=google; t=1684999553; x=1687591553;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M5GFQjqLw8eISzxabPHXZIx1IMxLPxR6LdGmz7U/BDg=;
        b=IlBb6Ea8PMQqmpYN+jo8675eoOYzD6JUqVyuVO0UsOLvAKsD9SqknqnxQD19dyD8R2
         lOp3s9z2cZYBMaA00nFiSN+VRJSv0bVUcefNJAuObHUOV4MELKU1JSrgubt/a6/KqK42
         vrylVSdj+mGOkidXVBzRgrQ5f7rPXmMyO7KjZawO6zp8GgP7PLR9Z6l1xKv6KfymkJL3
         6mjCu99fGtEEVv0ZpLqEiMHpU28esDyAuXivs4M84xHkSxOdYTF4sB0hH0Prijtb98c/
         K/PhYfY4to58rS6WybDwxyv+dnS/y0d8wGGo8mJCDEhtWMBL3BDIZebqye4Z4sCP+9KW
         H59g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684999553; x=1687591553;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M5GFQjqLw8eISzxabPHXZIx1IMxLPxR6LdGmz7U/BDg=;
        b=L3lNL16q9gKe3GPgVsDRlFxbvHeCEolCk1gq+/0fFyjOjZuMAa3BRlC0lDGpabxuFR
         ayxa/IQgnGUyrMswknCy2alxtMjlW+V+Dd7iGVjx0QtX57tKeWOYvp3S5bYwzw8OE1ut
         TNUrH7zUu9KhSVvwaysZHCnQXjoZBIHQ+HXcAnowFmPSm4VYUlSPEYk9W3wdRp7MHwXw
         Isa5wolpHwNhPqaRBA/hJMJzFT5AzeMwZc3tRfZHBtOrkYoOqCS8ywhzWU63BIzpIHlA
         74+ZGNa2C0mjUZBeAW9rnLF3DGXZQj5C2LNizcTCB7zYq4isFCbExohp/wmKeMs36NBz
         P6WA==
X-Gm-Message-State: AC+VfDwYH5YYNxCGQAfStBQjyXDOBiioP5IwH595p6zzMshYz2UhJHRg
        h2dZUvupIJzjio/NHDkS0nEhxutU8B8DBx36EtM=
X-Google-Smtp-Source: ACHHUZ7/oPQPpnFIqVe6lgYQiJtkXA/ebD/IW4HFEVvI90mf02hOLOtCVeCpz8hc4dRQqN9PAw0xH/13SHFT0CYhBA0=
X-Received: by 2002:a05:6214:40a:b0:623:8925:b225 with SMTP id
 z10-20020a056214040a00b006238925b225mr490059qvx.39.1684999553491; Thu, 25 May
 2023 00:25:53 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1504.git.git.1683282753768.gitgitgadget@gmail.com>
In-Reply-To: <pull.1504.git.git.1683282753768.gitgitgadget@gmail.com>
From:   Adam Johnson <me@adamj.eu>
Date:   Thu, 25 May 2023 08:25:42 +0100
Message-ID: <CAMyDDM2iwpXkZOBB+9wLDwbcu-_KzEmDvXhSwnXXaHN+KNOieQ@mail.gmail.com>
Subject: Re: [PATCH] doc: restore: remove note on --patch w/ pathspecs
To:     Adam Johnson via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, is there anything I can do to help with review?


On Fri, May 5, 2023 at 11:32=E2=80=AFAM Adam Johnson via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Adam Johnson <me@adamj.eu>
>
> This note was added with the command in 46e91b663b (checkout: split part =
of
> it to new command 'restore', 2019-04-25), but it is now inaccurate. The
> underlying builtin `add -i` implementation, made default in 0527ccb1b5 (a=
dd
> -i: default to the built-in implementation, 2021-11-30), supports pathspe=
cs,
> so `git restore -p <pathspec>...` has worked for all users since then. I
> bisected to verify this was the commit that added support.
>
> Signed-off-by: Adam Johnson <me@adamj.eu>
> ---
>     doc: restore: remove note on --patch w/ pathspecs
>
>     This note was added with the command in 46e91b663b, but it is now
>     inaccurate. The underlying builtin add -i implementation, made defaul=
t
>     in 0527ccb1b5, does support pathspecs, so git restore -p <pathspec>..=
.
>     has worked for all users since then. I bisected to verify this.
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-150=
4%2Fadamchainz%2Faj%2Fgit-restore-patch-docs-fix-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1504/a=
damchainz/aj/git-restore-patch-docs-fix-v1
> Pull-Request: https://github.com/git/git/pull/1504
>
>  Documentation/git-restore.txt | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/Documentation/git-restore.txt b/Documentation/git-restore.tx=
t
> index 5964810caa4..d31a06a673e 100644
> --- a/Documentation/git-restore.txt
> +++ b/Documentation/git-restore.txt
> @@ -51,9 +51,6 @@ leave out at most one of `A` and `B`, in which case it =
defaults to `HEAD`.
>         restore source and the restore location. See the ``Interactive
>         Mode'' section of linkgit:git-add[1] to learn how to operate
>         the `--patch` mode.
> -+
> -Note that `--patch` can accept no pathspec and will prompt to restore
> -all modified paths.
>
>  -W::
>  --worktree::
>
> base-commit: f285f68a132109c234d93490671c00218066ace9
> --
> gitgitgadget
