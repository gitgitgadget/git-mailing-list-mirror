Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26A551F62E
	for <e@80x24.org>; Wed, 16 Jan 2019 15:57:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404673AbfAPP5G (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Jan 2019 10:57:06 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:36047 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbfAPP5F (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jan 2019 10:57:05 -0500
Received: by mail-vs1-f68.google.com with SMTP id v205so4216949vsc.3
        for <git@vger.kernel.org>; Wed, 16 Jan 2019 07:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Br+NTKcczIP1qz9kcTKBBLMDVPHMA6nDnlCImXgvjO0=;
        b=VKxoY1ryqhfTXncFzay9GxLaRs0eruQhUhxP1wXE+VIPyTnseHYvKutS1Tza6J9rVP
         SmtVVYeBLZON8B1HK6l98MiHDVTrfu9hgOzUq7uUD53rBIWaXF4L1W0GIzCzyy7sH+D4
         z5g8U9CIo103CVhw3MF7F1DqcDrLWZSJMwJWLM4BVeu+r4GgvNSKaG5ce+zRdA4MxANi
         eOo/k0xvL5C8a8zg+xrI+WxIoKHuTRe54HIQjGPpqmbvJFOPVdJzG1uD2bOqY/Nm20l4
         lDBhqFybunthMLz5K7n3+ol2pxglKaweFUSocNK7dPRaOKskuwEG6BBiMGQn+KvvMBa9
         OKuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Br+NTKcczIP1qz9kcTKBBLMDVPHMA6nDnlCImXgvjO0=;
        b=rQm07prqrqsBkWRxugjhk+R66DEatZsd1Q2VJIBfZYs095MW6nQs4AnEE7ZLBl2yzG
         s1v/3yvkNXyxoaLklw6IwL5T6sh0MGIqESNeypg54qdwkLrB3UwMzGjZkYwhMDQJVXWn
         cIQcVW3MxttFOp8YoR+Cqsjo/bEd/3+pvPi10ogyCEZPfc8aFuFAjVyELnthUgZ9GhUq
         SDsftge8VLfc6+Fm30+Nhg48w39Ww1DdUErwkQMdh7/bDViLmKtodoivxx0kicusLtSn
         x99pX4TC78+52tJrIFmFyS3902bc3eM4uYjc9mxHWQm3cCRjC6F4PFhy+27yaryjb0IO
         TvYQ==
X-Gm-Message-State: AJcUukf8f02Ls6cHQLHgyCgzp5UqtJefuqgNY3bzr6E6x9b/2/D/edMY
        AItVNZCNUm1w0SBmJummtUtFDt74OLdWBuBD+2s=
X-Google-Smtp-Source: ALg8bN6rGwWyN9uBcV3ZkHV9ZSAWwl5K66bfdqF6D06/jwjO/j+ygUBLxaruM2gKKQD6mI+yx7i0BA4DIYW8nVp5okQ=
X-Received: by 2002:a67:3c5c:: with SMTP id j89mr4031859vsa.117.1547654223331;
 Wed, 16 Jan 2019 07:57:03 -0800 (PST)
MIME-Version: 1.0
References: <pull.109.git.gitgitgadget@gmail.com> <598de6652cdb19b9772f322f17600c3845f208cc.1547645839.git.gitgitgadget@gmail.com>
In-Reply-To: <598de6652cdb19b9772f322f17600c3845f208cc.1547645839.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 16 Jan 2019 07:56:51 -0800
Message-ID: <CABPp-BHOkVKVpZy2RKj-ofoajGT0rgrb2TpQsXprk1_yZwtVfA@mail.gmail.com>
Subject: Re: [PATCH 1/1] t6042: work around speed optimization on Windows
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

On Wed, Jan 16, 2019 at 5:37 AM Johannes Schindelin via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> When Git determines whether a file has changed, it looks at the mtime,
> at the file size, and to detect changes even if the mtime is the same
> (on Windows, the mtime granularity is 100ns, read: if two files are
> written within the same 100ns time slot, they have the same mtime) and
> even if the file size is the same, Git also looks at the inode/device
> numbers.
>
> This design obviously comes from a Linux background, where `lstat()`
> calls were designed to be cheap.
>
> On Windows, there is no `lstat()`. It has to be emulated. And while
> obtaining the mtime and the file size is not all that expensive (you can
> get both with a single `GetFileAttributesW()` call), obtaining the
> equivalent of the inode and device numbers is very expensive (it
> requires a call to `GetFileInformationByHandle()`, which in turn
> requires a file handle, which is *a lot* more expensive than one might
> imagine).
>
> As it is very uncommon for developers to modify files within 100ns time
> slots, Git for Windows chooses not to fill inode/device numbers
> properly, but simply sets them to 0.
>
> However, in t6042 the files file_v1 and file_v2 are typically written
> within the same 100ns time slot, and they do not differ in file size. So
> the minor modification is not picked up.
>
> Let's work around this issue by avoiding the `git mv` calls in the
> 'mod6-setup: chains of rename/rename(1to2) and rename/rename(2to1)' test
> case. The target files are overwritten anyway, so it is not like we
> really rename those files. This fixes the issue because `git add` will
> now add the files as new files (as opposed to existing, just renamed
> files).

I actually read this before the cover letter (just responded in
opposite order), and the last paragraph alarmed me at first, because
it made it sound like it was dispensing with the need for rename
detection and thus breaking the intent of the testcase.  Granted,
looking at the code it becomes clear you're not changing the intent of
the testcase at all, just transforming the setup steps slightly.  In
your cover letter, you made this clear by stating that you were
replacing
    git mv <old> <new> && mv <file> <new> && git add <new>`
by
    git rm <old> && mv <file> <new> && git add <new>`
Perhaps something like that could be added here or other wording to
clarify that it's just an innocuous transformation of the setup steps?

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  t/t6042-merge-rename-corner-cases.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/t/t6042-merge-rename-corner-cases.sh b/t/t6042-merge-rename-corner-cases.sh
> index 7cc34e7579..09dfa8bd92 100755
> --- a/t/t6042-merge-rename-corner-cases.sh
> +++ b/t/t6042-merge-rename-corner-cases.sh
> @@ -1175,7 +1175,7 @@ test_expect_success 'setup nested conflicts from rename/rename(2to1)' '
>
>                 # Handle the left side
>                 git checkout L &&
> -               git mv one three &&
> +               git rm one two &&

Here you not only remove the file being renamed ('one') but also a
file being modified ('two'); you didn't mention the latter in your
commit message.  Since both are added back later it'll still work
either way on linux, but was it suffering from the same problem on
Windows?  It too was a case of both the filesize before and after
remaining the same despite contents changing, so it certainly seem
possible.

>                 mv -f file_v2 three &&
>                 mv -f file_v5 two &&
>                 git add two three &&
> @@ -1183,7 +1183,7 @@ test_expect_success 'setup nested conflicts from rename/rename(2to1)' '
>
>                 # Handle the right side
>                 git checkout R &&
> -               git mv two three &&
> +               git rm one two &&

Also here you remove both a renamed and a modified file -- though in
this case I think the file sizes change for both (each increases by
one character) so this hunk of the patch probably isn't needed.  It
doesn't hurt though, and could be considered future-proofing against
possible changes to the setup files, and may also just be nice to make
the two blocks of setup look more consistent

>                 mv -f file_v3 one &&
>                 mv -f file_v6 three &&
>                 git add one three &&
> --
> gitgitgadget


Thanks,
Elijah
