Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65330C43217
	for <git@archiver.kernel.org>; Sat,  2 Oct 2021 23:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D80661A7D
	for <git@archiver.kernel.org>; Sat,  2 Oct 2021 23:36:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234247AbhJBXht (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 Oct 2021 19:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234210AbhJBXho (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Oct 2021 19:37:44 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A00C0613EC
        for <git@vger.kernel.org>; Sat,  2 Oct 2021 16:35:57 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id x7so47711999edd.6
        for <git@vger.kernel.org>; Sat, 02 Oct 2021 16:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n7+E5tLQ1JCPtw+eOQ4u89KjzCivpdF3D2fQ4Vklvyw=;
        b=FSY9J2iXIAoQXWsq5tGpLKhLFRjlNYcB/H4uNdzvO92o3A5LLac7hrqhtK+BxsZz5m
         pLxaHJJehg2iQUfxFGn4zngvh3ZSUH88LbFp8MsZB9SsxKAn0EpKATQF4CVWeaChzhfL
         SZfAaNSAFFOyoGLrae6j2F0KFJwDYo7XRf8mc1P1WcLHYQy3JINncy0Nrqie7f1gX7Ux
         PLTg92dGFnFLbCkyGzjGw55r3zG7CcW24UVQ0YhFOPnA12SxmW+iwVapvceeFtT9x5a7
         fCrVcB8v0c85kPxK+sIzB83E1FZ90xyfBuLpckSuacckGwabcDPh3xeKsOTbIENoQaGk
         wccA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n7+E5tLQ1JCPtw+eOQ4u89KjzCivpdF3D2fQ4Vklvyw=;
        b=3ZYXmr8LdSqxNn4a+2yyyl65hdWvgpB6LdHVKYOXG1+1cbR2Ut3sRIVoFQf5Tp8tAY
         Jl7ZsAHI8bVf3o1y6K/Euot+nAIkIdvcxIfqEn0OZJn5S30yQxVfSZeGFG3VMw4PyE/A
         l9iXVBeYu2+3bPw/O1WDo0DD1jPJ/4NGtRYxI8GcobPxDB6Xp8Enx6lyKis9j5hnLl9O
         97M7DPsfem/qaWq5uq+c0xxpHu9tihSSTEdykTIwcDJDmGU850PjRPvFlOJ7ogIGSsCn
         hKJilZXDOlehYcO/Kv1P4A3MAcc9zYfnTnMr/K3ltmueoBhB+ZMkX99PRzJ3MnoFmmIU
         xPDA==
X-Gm-Message-State: AOAM5333/UyFmadEvVQ1VOcNVKoal/dDWlaAfgIZEz9OmPTa9PFbzMWU
        5hV66M4GRYmj+A+7jEY4zMN2TlNihG3TLNYvAj4=
X-Google-Smtp-Source: ABdhPJzNQcTynCv82omWiMptkVpc9pAQY7AT4jFN6OS2y/uf1cbqWrkJ4Uk8+MaRHUKG6s3vjWwHfdSy5uJzjT9Hq9s=
X-Received: by 2002:a17:906:8cd:: with SMTP id o13mr6782600eje.341.1633217756292;
 Sat, 02 Oct 2021 16:35:56 -0700 (PDT)
MIME-Version: 1.0
References: <20211002213046.725892-1-aclopte@gmail.com>
In-Reply-To: <20211002213046.725892-1-aclopte@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 2 Oct 2021 16:35:43 -0700
Message-ID: <CABPp-BFyNamEVkEZsEhY9w3yCHg4uU-hkuHjvzj-BoGtvDBFZg@mail.gmail.com>
Subject: Re: [PATCH 1/2] Documentation/diff-format: state in which cases
 porcelain status is T
To:     Johannes Altmanninger <aclopte@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 2, 2021 at 2:38 PM Johannes Altmanninger <aclopte@gmail.com> wrote:
>
> Porcelain status letter T is documented as "type of the file", which
> is technically correct but not enough information for users that are
> not so familiar with this term from systems programming. In particular,
> given that the only supported file types are regular files and symbolic
> links,

and submodules (though users aren't likely to think of that as a "file" type)

> the term "file type" is surely opaque to the many(?) users who
> are not aware that symbolic links can be tracked - I thought that a
> "chmod +x" would result in a T status (wrong, it's M).

Heh, I've probably made that mistake before...and I was actually
thinking of exactly that case while reading this commit message.  Just
goes to show that I'm prone to repeat my mistakes.  Anyway, I'm glad
you discussed the executable bit case in the commit message.

> Explicitly document the three file types (including submodules).
> This makes life easier for tool authors, but has potential to go
> out of date if a new type is ever added. We could avoid this with a
> targeted test, or by using a reStructuredText directive to include the
> list of file types from a single source.  Probably not worth it. The
> next patch will copy this snippet to git-status.txt though.
>
> Signed-off-by: Johannes Altmanninger <aclopte@gmail.com>
> ---
>
> (The implementation calls the third type "gitlink" but for users that's
> always a submodule, AFAICT)
>
>  Documentation/diff-format.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/diff-format.txt b/Documentation/diff-format.txt
> index fbbd410a84..7a9c3b6ff4 100644
> --- a/Documentation/diff-format.txt
> +++ b/Documentation/diff-format.txt
> @@ -59,7 +59,7 @@ Possible status letters are:
>  - D: deletion of a file
>  - M: modification of the contents or mode of a file
>  - R: renaming of a file
> -- T: change in the type of the file
> +- T: change in the type of the file (regular file, symbolic link or submodule)
>  - U: file is unmerged (you must complete the merge before it can
>    be committed)
>  - X: "unknown" change type (most probably a bug, please report it)
> --
> 2.33.0.rc2.dirty

Thanks, this change looks good to me, modulo the tiny comment on the
commit message about submodules being another file type.
