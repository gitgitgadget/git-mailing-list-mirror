Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BB3D1F42D
	for <e@80x24.org>; Tue, 27 Mar 2018 08:59:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751211AbeC0I7z (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Mar 2018 04:59:55 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:43150 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751054AbeC0I7w (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Mar 2018 04:59:52 -0400
Received: by mail-qt0-f193.google.com with SMTP id s48so22916019qtb.10
        for <git@vger.kernel.org>; Tue, 27 Mar 2018 01:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=lyOeTzLVGslSjliYZdjuCeD4v78HGfHXa7WxLzpVJkQ=;
        b=tl7bQH7bcX/v3UW31eGAtZAcs4ljR/DbLxZVVnHJyDtsjlEVDNUOcundK0iuTNR0cq
         t8kAKRBTWfVm1pCbGTvwcN6ydPOqf2kfFvZzfRgVvD8kKIQwlQS3DxvjQ2BoMf5vx5NZ
         ZTxcEzkeky2GRLzV/HWZototJk8i42+nm48xWiX3I0k2V44Hq3eU9tFgy4c1EnREPFnL
         nRxxpmA4Ag5tsT/b21ybfXZ7v7MYzmBLXg+aR7Az9h8jnu81GxI1oZ0OihbS7T1UWXKq
         2mXsHn4BSbXTrUr5Nf+HrcT3hww9ov6BwGfy9Jr/j3lZeMgdutZJRiLLPLt4rGCuL4Dz
         Acuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=lyOeTzLVGslSjliYZdjuCeD4v78HGfHXa7WxLzpVJkQ=;
        b=lgFrIb4LTrgQqu/wm23Uzg0qgjtaPh0sIIVYbTywGRyzRW+8yMGHHNOigNBkXmYv9P
         q2yB5zoQYc+ZV65Vwjcjx6OGq6nAuZeuRNjd7x8SKPAyhNuN2KzR/bDqXK9Zhk+XKaNj
         Avgwduj42WXj3t2K5pgDjv84u/MlYyhCuGLG9EpVBrDGQ6CIg2CaHp1Oplu8NosKELlQ
         x2X4hu+L5fanQKkcyJykyCi2POxlX6yWTN0C/6GpjGYgPOmbRx/Ilj9Ut6qDKQYPlmPK
         2uiGQMd+T6cciRMTjgiXV4PxknigZT18+ruNEGm9dYyb3478lW6Xmhy2Qim63IW6zb5w
         HxGg==
X-Gm-Message-State: AElRT7E+egmfVsZKQ4fibJ26Ka93kbnG9pmt0fXLZGCKAhGQfdAYodmr
        lq5qZ9KGOZEAoKlykcJsbIy1Gv3eyU6cPaVFoZY=
X-Google-Smtp-Source: AG47ELtuMQhH/0OONFWHUNvrSQrSr5DXK7YIsjTvGqHAHyf6CVxxN7RoD9ff5sQOgmys7HbQcWvamt0pVnCJKnKE2uM=
X-Received: by 10.200.42.37 with SMTP id k34mr47184641qtk.101.1522141192156;
 Tue, 27 Mar 2018 01:59:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.174.202 with HTTP; Tue, 27 Mar 2018 01:59:51 -0700 (PDT)
In-Reply-To: <20180325134947.25828-3-t.gummerer@gmail.com>
References: <20180317222219.4940-1-t.gummerer@gmail.com> <20180325134947.25828-1-t.gummerer@gmail.com>
 <20180325134947.25828-3-t.gummerer@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 27 Mar 2018 04:59:51 -0400
X-Google-Sender-Auth: esKE15fWdiB4OqTgx1_HqfyPN48
Message-ID: <CAPig+cSNYdJwBS1me+bkELDmrPHgDZJDwjA=o=O4CzQBT=jpzQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/6] worktree: be clearer when "add" dwim-ery kicks in
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 25, 2018 at 9:49 AM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> Currently there is no indication in the "git worktree add" output that
> a new branch was created.  This would be especially useful information
> in the case where the dwim of "git worktree add <path>" kicks in, as the
> user didn't explicitly ask for a new branch, but we create one from
> them.

Failed to notice this last time around: s/from/for/

Perhaps Junio can tweak it when queuing.

> Print some additional output showing that a branch was created and the
> branch name to help the user.
>
> This will also be useful in the next commit, which introduces a new kind

It's no longer the _next_ commit which does this. Perhaps say instead
"a subsequent commit". (Again, perhaps Junio can tweak it since it's
not worth a re-roll.)

> of dwim-ery of checking out the branch if it exists instead of refusing
> to create a new worktree in that case, and where it's nice to tell the
> user which kind of dwim-ery kicked in.
>
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> ---
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> @@ -318,6 +318,9 @@ static int add_worktree(const char *path, const char *refname,
> +       if (opts->new_branch)
> +               fprintf_ln(stderr, _("creating branch '%s'"), opts->new_branch);

I didn't think of this before, but what happens with the original
dwim-ery you added which checks out a remote branch matching the
worktree name if no such local branch exists? I was wondering if we'd
want to see a distinct and more informative message in that case, such
as "creating branch '%s' from remote '%s'" or something. However, I
see that we're already getting a message:

    Branch 'foo' set up to track remote branch 'foo' from 'origin'.
    creating branch 'foo'
    new worktree HEAD is now at d3adb33f boople

which is a bit weird since tracking appears to be set up before the
branch itself is created. I thought that this was another UI
regression of the sort I mentioned in [1], however, the messages were
out of order even before the current patch series:

    Branch 'foo' set up to track remote branch 'foo' from 'origin'.
    Preparing foo (identifier foo)
    Checking out files: 100% (9999/9999), done.
    HEAD is now at d3adb33f boople

This highlights another regression introduced by this series. Patch
1/6 suppresses the "Checking out files:" message, which is a bit
unfortunate for decent sized worktrees. I'm not sure I'm entirely
happy about that loss. Thoughts?

[1]: https://public-inbox.org/git/CAPig+cT8i9L9kbhx=b0sG4_QYNdoEDPW-1xypM9xzBqPmqR__Q@mail.gmail.com/

>         fprintf(stderr, _("new worktree HEAD is now at %s"),
>                 find_unique_abbrev(commit->object.oid.hash, DEFAULT_ABBREV));
