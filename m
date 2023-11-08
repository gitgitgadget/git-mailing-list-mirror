Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B447FD
	for <git@vger.kernel.org>; Wed,  8 Nov 2023 02:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lTQ2QVY8"
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE32C10C1
	for <git@vger.kernel.org>; Tue,  7 Nov 2023 18:22:47 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-50930f126b1so7924741e87.3
        for <git@vger.kernel.org>; Tue, 07 Nov 2023 18:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699410165; x=1700014965; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HzWQBrtqMyb57S7aMEQfsQ8uSEJThKtFEhQRLy4EMt8=;
        b=lTQ2QVY8r2UpXFAzz9xuIRN5p2Qg6XxcwwGAt7DRX1Q5gIMWUPuJrCPUyD0/65yEAJ
         XBGW+u7IQogNJ5kODJFwIhuik6bsUdnp0ofYc/UuH9vnl+Dme9vdxrsPcCbU0XVu2cSm
         Dg3oQqc1IgDH/ty+tDzDczjO/gAE/eToh0P1FAhIqrKplTe4h7AjEf3mQd2IA0Q0GGvq
         tifTzJ7XTaw3HwFvKraqsnx1BEd9x/RvP/borBFxmpv6Ca4Af8u5xv/FUq4Hv61MeKfG
         KlSw8INW00/YwKYqUpuMbKNng8rqBaGp2Mu3A/wtqPd1rxbADZCbGvest/AZdywg9AJQ
         GC4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699410165; x=1700014965;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HzWQBrtqMyb57S7aMEQfsQ8uSEJThKtFEhQRLy4EMt8=;
        b=hAdKf5ERljxF2z4mRf2Vuq6i3jWOOsSwKZ4hsmY0LohGP16J7atyOyzNaeng1dbanS
         Y6mWlGQV34nAW2E4Ij+RuU8tLRlA9xoheEqzjRJ+wsZnjdnq/7z+DzKlMwobGGe5fxmQ
         xGBDHzvm9/1puw1bM7aCuy6CcgcGNd8iqIAcl+jHo8VzjKPu6YpEAatv5PMJpa/MQcRf
         NLd+g+W4YFxBks0aFEd5668+URyz/vgvWOGM1wNdGoHIC6MZRbylF8b5YTQ2vbErDnju
         ge3pBpFfSuiLQOM9YLKV8tkUpsxSIyhJZ41UXw3WnRhdGz7QHVdA0Nf+S29p9J3YRDY/
         9ZEw==
X-Gm-Message-State: AOJu0YzGg4OQir2/ctmsSz2SoPbQzlHa05gfl88rm2becC8ZtQHLQUBO
	WMlNe0NR+LEXr7Ko+Hyu02qMcUQvvkIL+qH6G96E6mrShX5W+w==
X-Google-Smtp-Source: AGHT+IETzgpho7+Op/1k40X5nd5+QGKWUBtCePku9CGd/kCEYkj8RCIHur+TFIjTCCftsIy/dSLMZH6e2zy2AhkHQgw=
X-Received: by 2002:a05:6512:a8d:b0:507:9701:2700 with SMTP id
 m13-20020a0565120a8d00b0050797012700mr316191lfu.20.1699410165261; Tue, 07 Nov
 2023 18:22:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231107130303.GS7041@raven.inka.de>
In-Reply-To: <20231107130303.GS7041@raven.inka.de>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 7 Nov 2023 18:21:00 -0800
Message-ID: <CABPp-BEAU8rPeNHphut0ZxcLdH0pzjh+Z_CF+rg2uhvVZoZfxg@mail.gmail.com>
Subject: Re: Error when "git mv" file in a sparsed checkout
To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Nov 7, 2023 at 5:32=E2=80=AFAM Josef Wolf <jw@raven.inka.de> wrote:
>
> Hello,
>
> I have used the procedure described below for many years. In fact,
> this procedure is part of a script which I am using for about 10 years.
> This procedure was definitely working with git-2-25-1 and git-2.26.2.
>
> Now, with git-2.34.1 (on a freshly installed ubuntu-22.04), this
> procedure fails.
>
> Here is what I do:
>
> I want to rename a file on a branch which is not currently checked out
> without messing/touching my current working directory.
>
> For this, I first create a clone of the repo with shared git-directory:
>
>   $ SANDBOX=3D/var/tmp/manage-scans-X1pKZQiey
>   $ WT=3D$SANDBOX/wt
>   $ GIT=3D$SANDBOX/git
>
>   $ mkdir -p $SANDBOX
>   $ git --work-tree $WT --git-dir $GIT clone -qns -n ~/upstream-repo $GIT
>
> Then, I do a sparse checkout in this clone, containing only the file
> that is to be renamed:
>
>   $ cd $WT
>   $ echo 'path/to/old-filename' >>$GIT/info/sparse-checkout
>   $ git --work-tree $WT --git-dir $GIT config core.sparsecheckout true
>   $ git --work-tree $WT --git-dir $GIT checkout -b the-branch remotes/ori=
gin/the-branch
>   Switched to a new branch 'the-branch'
>
> Next step would be to "git mv" the file:
>
>   $ mkdir -p /path/to  # already exists, but should do no harm
>   $ git --work-tree $WT --git-dir $GIT mv path/to/old-filename path/to/ne=
w-filename

sparse checkouts are designed such that only files matching the
patterns in the sparse-checkout file should be present in the working
tree, so renaming to a path that should not be present is problematic.
We could possibly have "git-mv" immediately remove the path from the
working tree (while leaving the new pathname in the index), but that's
problematic in that users often overlook the index and only look at
the working tree and might think the file was deleted instead of
renamed.  Not immediately removing it is potentially even worse,
because any subsequent operation (particularly ones like checkout,
reset, merge, rebase, etc.) are likely to nuke the file from the
working tree and the fact that the removal is delayed makes it much
harder for users to understand and diagnose.

So, Stolee fixed this to make it throw an error; see
https://lore.kernel.org/git/pull.1018.v4.git.1632497954.gitgitgadget@gmail.=
com/
for details.  His description did focus on cone mode, but you'll note
that none of my explanation here did.  The logic for making this an
error fully applies to non-cone mode for all the same reasons.

If you want to interact with `path/to/new-filename` as a path within
your sparse checkout (as suggested by your git-mv command), then that
path should actually be part of your sparse checkout.  In other words,
you should add `path/to/new-filename` to $GIT/info/sparse-checkout and
do so _before_ attempting your `git mv` command.  If you don't like
that for some reason, you are allowed to instead ignore the
problematic consequences of renaming outside the sparse-checkout by
providing the `--sparse` flag.  Both of these possibilities are
documented in the hints provided along with the error message you
showed below:

>   The following paths and/or pathspecs matched paths that exist
>   outside of your sparse-checkout definition, so will not be
>   updated in the index:
>   path/to/new-filename
>   hint: If you intend to update such entries, try one of the following:
>   hint: * Use the --sparse option.
>   hint: * Disable or modify the sparsity rules.
>   hint: Disable this message with "git config advice.updateSparsePath fal=
se"
>
> This error is something I have not expected.
>
> Error message suggests, there already exists a file named "new-filename".=
 This
> is not true at all. There is no file named "new-filename" in the entire
> repository. Not in any directory of any branch.

You are correct; the wording of the error message here is suboptimal
and seems to have been focused more on the git-add case (the error
message is shared by git-add, git-mv, and git-rm).  Thanks for
pointing it out!  We could improve that wording, perhaps with
something like:

    The following paths and/or pathspecs match paths that are
    outside of your sparse-checkout definition, so will not be
    updated:

Which is still slightly slanted towards git-add and git-rm cases, but
I hope it works better than the current message.  Thoughts?
