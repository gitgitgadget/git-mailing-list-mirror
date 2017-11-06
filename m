Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A72A020A10
	for <e@80x24.org>; Mon,  6 Nov 2017 20:50:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752203AbdKFUup (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Nov 2017 15:50:45 -0500
Received: from mail-qk0-f174.google.com ([209.85.220.174]:44651 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751032AbdKFUuo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Nov 2017 15:50:44 -0500
Received: by mail-qk0-f174.google.com with SMTP id v137so2982517qkb.1
        for <git@vger.kernel.org>; Mon, 06 Nov 2017 12:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=W1xcSxHJ+6Fust/Vt8KQOd5N8uRsz0abOu7zY/TrmUo=;
        b=J7edT3CoihuSD0fekhDqKooQPCX/iyLSJIuPIACMNrCSSMdCE2MTQ+RNsEZFmHcVH3
         PyauY6lJ/I2w4EeaGIAEhwZTqxV7ZVsiafTFq6MEtDpPk/ZEKOxi9UAcFV8Km58qDTtL
         oyXjkGXVYs5pQ4Kz2xZTJ2bYA4dJ9b/f3Wa8d4o9f7awdpdEYjx0vdV9jqrWTlKQ3KVM
         3/IfHxwX9eo/8I3jr+yb4OKC8AlIAXqmupzPPhyHm4dn2thVXuZm5xPeQ5x3HDnL/Qab
         wF9kwt2Ul7gL1OzTRKIkqeQp0WBgpaWAK9Hmg8FTVER71KoPDXa/Yxl3xVnmYqXAKjAF
         qtVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=W1xcSxHJ+6Fust/Vt8KQOd5N8uRsz0abOu7zY/TrmUo=;
        b=k2wrajqT5M03mWTrNNUSKkv9ZsnzXz7JXO16Vsxm/Uzxwguu+zQxmkKq0aOw8QzYLt
         5/UP7hJjvp4OFgSWZeQG9/qOJILY/tLBzVsU7ygBev9OUc5Fa4GzCRDlVYjgXw/W9i/B
         +/29BHOHnp+gumdFTQ/ahfppgkh9ve+7bcLmft0k8xLj2gdOf/sL6Wt3odLzHD/GLZRH
         eabBk/QM3lplqRAuUGJru8gA6c+XNft8WePHIZPq/p+lwtWkVs3J0a0PVFOZQpF8bTzp
         dvJIlMc9AL1MtoGW2izIJfcrhO4oRCi1cxTOT70PFEHEGDkLVK8P+uPTjMz9Zpxcmjjp
         4oSw==
X-Gm-Message-State: AMCzsaUd0UHXaqEKHhVhD47Kc7PbLyG0WF2EbHFeuqDm2iA8XF9TEug5
        wndmIa5xilfMj6HV3JYSEXtUsVDc1Y6U3DdFPsNryg==
X-Google-Smtp-Source: ABhQp+T/ccM+tvzoF+Wnc7LIX1+HPLnQFRJ1d4gwpKzub7u2JYqnj5k1Zy6gD8Ew5LFdE02PX40zaqoxrT4aEQPYVqI=
X-Received: by 10.55.175.132 with SMTP id y126mr24781702qke.45.1510001442548;
 Mon, 06 Nov 2017 12:50:42 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Mon, 6 Nov 2017 12:50:42 -0800 (PST)
In-Reply-To: <BN6PR21MB0114B8ECD6E8A158FB4A6FBFCB520@BN6PR21MB0114.namprd21.prod.outlook.com>
References: <BN6PR21MB0114B8ECD6E8A158FB4A6FBFCB520@BN6PR21MB0114.namprd21.prod.outlook.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 6 Nov 2017 12:50:42 -0800
Message-ID: <CAGZ79kZRa6=PNtRoVMzM89ek+9uv9_+C+3-hNAaJ_W=YoeWj-w@mail.gmail.com>
Subject: Re: Bug report: git reset --hard does not fix submodule worktree
To:     "Billy O'Neal (VC LIBS)" <bion@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "Stephan T. Lavavej" <stl@exchange.microsoft.com>,
        Cody Miller <codym@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 3, 2017 at 5:46 PM, Billy O'Neal (VC LIBS)
<bion@microsoft.com> wrote:
> Hello, Git folks. I managed to accidentally break the our test lab by att=
empting to git mv a directory with a submodule inside. It seems like if a r=
eset does an undo on a mv, the workfold entry should be fixed to put the su=
bmodule in its old location. Consider the following sequence of commands:
>
> Setup a git repo with a submodule:
> mkdir metaproject
> mkdir upstream
> cd metaproject
> git init
> cd ..\upstream
> git init
> echo hello > test.txt
> git add -A
> git commit -m "an example commit"
> cd ..\metapoject
> mkdir start
> git submodule add ../upstream start/upstream
> git add -A
> git commit -m "Add submodule in start/upstream."
>
> Move the directory containing the submodule:
> git mv start target
> git add -A
> git commit -m "Moved submodule parent directory."
>
> Check that the worktree got correctly fixed by git mv; this output is as =
expected:
> type .git\modules\start\upstream\config
> [core]
>         repositoryformatversion =3D 0
>         filemode =3D false
>         bare =3D false
>         logallrefupdates =3D true
>         symlinks =3D false
>         ignorecase =3D true
>         worktree =3D ../../../../target/upstream
> [remote "origin"]
>         url =3D C:/Users/bion/Desktop/upstream
>         fetch =3D +refs/heads/*:refs/remotes/origin/*
> [branch "master"]
>         remote =3D origin
>         merge =3D refs/heads/master
>
> Now try to go back to the previous commit using git reset --hard:
> git log --oneline
>  1f560be (HEAD -> master) Moved submodule parent directory.
>  a5977ce Add submodule in start/upstream.
> git reset --hard a5977ce
>  warning: unable to rmdir target/upstream: Directory not empty
>  HEAD is now at a5977ce Add submodule in start/upstream.
>
> Check that the worktree got fixed correctly; it did not:
> type .git\modules\start\upstream\config
> [core]
>         repositoryformatversion =3D 0
>         filemode =3D false
>         bare =3D false
>         logallrefupdates =3D true
>         symlinks =3D false
>         ignorecase =3D true
>         worktree =3D ../../../../target/upstream
> [remote "origin"]
>         url =3D C:/Users/bion/Desktop/upstream
>         fetch =3D +refs/heads/*:refs/remotes/origin/*
> [branch "master"]
>         remote =3D origin
>         merge =3D refs/heads/master
>
> Is git reset intended to put the submodule in the right place?
>
> Thanks folks!

git-reset sounds like it ought to put submodules back into another director=
y.
Historically git-reset did not touch submodules at all; a recent
release introduced
the --recurse-submodules flag for git-reset, which would cover this situati=
on.
However that particular situation (with moving the submodules) seems to be
not covered yet,

./t7112-reset-submodule.sh
...
not ok 69 - git reset --hard: replace submodule with a directory must
fail # TODO known breakage



> If not, is there a command we can run before/after reset to restore consi=
stency?

The submodule "fix-it-all" command would be

    git submodule update --init --recursive

IMHO.
