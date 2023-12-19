Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FED41C6B
	for <git@vger.kernel.org>; Tue, 19 Dec 2023 17:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Auhz5jrY"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-50c04ebe1bbso5804700e87.1
        for <git@vger.kernel.org>; Tue, 19 Dec 2023 09:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703008080; x=1703612880; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=irOggHfRMTpQCA75HYFGtBW6DLHHuy9GP3B/3F4kpU4=;
        b=Auhz5jrYBzx3m/fCmKSCFpulxWgIeyDrlTeVFhlmz1j/q7QQFBi/Fim9ciuRR5Aapv
         2TvwxiVHulb0cOKOjZUNSqcmOVn5FC2yg9AmnFsdHxS1y685CUZCiVwuwPi7tHEK1gAU
         53SqZkcBTQyaZmGSxu+jSMIL5tHsCR7NtQmYBOwwk3K920p4ELcTr0JkCOVNpWKEOTsP
         0xjs3vrgafhZVPsEcJupcLAlIVDNygHCiTFNISftxjVWgYv7pbSmlGnH55iSbXJAxDiC
         oaifvICqtxr9LNbI9K8O+pJGLxYUsB8fne4P5QSNnh0xvKwa7q8KLsuZJWe5zRkUp6JE
         KutA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703008080; x=1703612880;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=irOggHfRMTpQCA75HYFGtBW6DLHHuy9GP3B/3F4kpU4=;
        b=K+gkKQuUo4ZxqGUKhlxEoU9yleAK22tldazfT3U9Y1UT4j2T0YvYmX64VAyvE507f2
         fJBraqYnf+n3Tt2c94FGKBgdXJJ0UmZgSHO91NMXQqnxpOr+lX346xYPb/Ijg3lVDpxI
         WhZdTruiv6N6DgtLYJapj4kF0MxjJi1g71i96NNcnpdIS0+MhT4nGKHMp8PnIoe/eMFG
         pJQN0OB249MtslZYj2jKhf+qhdW0IPI776wnhOMbI7al6mG5+ZKZYnM8u41Q3Wib+UU8
         o4718kInrqJR2CVeUlKrEJuCvyqfCVY9q7ZO2FKogHvIyvE52QaCjaQMZOIfLlL26IIc
         g6tg==
X-Gm-Message-State: AOJu0YwPxB+K++Gn8/KGrXIzfp43RpLU4eWawMihuyQlbVLVxvwq/WKv
	F94iGgkdoJvnZgGUenGXBoK+urrJMJBJEO+f9Q0wFqpG/N8=
X-Google-Smtp-Source: AGHT+IH6XivOoxdGH2AN39fTSvMyU0MBl0CscxGT9BYLGUsUEfm34SOMGNaIe+zVWq1KcXkoKsAvxXs4DEG/G+fwE0w=
X-Received: by 2002:a05:6512:2103:b0:50e:2d42:cd37 with SMTP id
 q3-20020a056512210300b0050e2d42cd37mr942042lfr.33.1703008079631; Tue, 19 Dec
 2023 09:47:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAELOy+5AsRyLEs-WdYw1spqkmMDKjKSQzbogAoRBFe-zGLjvXg@mail.gmail.com>
In-Reply-To: <CAELOy+5AsRyLEs-WdYw1spqkmMDKjKSQzbogAoRBFe-zGLjvXg@mail.gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 19 Dec 2023 09:47:47 -0800
Message-ID: <CABPp-BHYfZC65Wn9popF=61Y6xHQNKEW+xPNEz_e4fOQbKbiOg@mail.gmail.com>
Subject: Re: git diff-files bug
To: Josh Reed <jriddy@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Dec 19, 2023 at 8:56=E2=80=AFAM Josh Reed <jriddy@gmail.com> wrote:
>
> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.
>
> What did you do before the bug happened? (Steps to reproduce your issue)

Let's extend your example a bit to point out when/if the index is updated..=
.

>
> > bash
> =E2=AC=A2[jreed@toolbox example-project]$ git diff-files --exit-code --pa=
tch; echo $?
> 0

$ stat --format=3D%y .git/index
2023-12-19 09:30:55.867055501 -0800

This is the modification time of the index at the very beginning.

> =E2=AC=A2[jreed@toolbox example-project]$ chmod g+w README.md

$ stat --format=3D%y .git/index
2023-12-19 09:30:55.867055501 -0800

As expected, the index has not changed just because some file changed.

> =E2=AC=A2[jreed@toolbox example-project]$ git diff-files --exit-code --pa=
tch; echo $?
> 1

$ stat --format=3D%y .git/index
2023-12-19 09:30:55.867055501 -0800

Note that the index still has not changed; diff-files will not update
it when it notices differences.  But diff-files shows us differences
between the working tree and index, and the working tree has changed.
Those changes mean that the stat information in the index no longer
matches the working tree.  That alone is enough for diff-files to give
a non-zero exit status.  This does tend to trip up folks, though.

> =E2=AC=A2[jreed@toolbox example-project]$ git diff --exit-code --patch; e=
cho $?
> 0

$ stat --format=3D%y .git/index
2023-12-19 09:33:46.773896615 -0800

Now the index _was_ updated.  So, not only are there no content
differences, and no relevant filemode differences, but the stat
information in the index now matches what is in the working tree.  So,
diff returns an exit code of 0.  (Note that this means "git diff" is
not a read-only operation, which sometimes trips up people in the
other direction.)

> =E2=AC=A2[jreed@toolbox example-project]$ git diff-files --exit-code --pa=
tch; echo $?
> 0

Right, contents match, relelvant filemodes match, and the stat
information in the index now matches what is in the working tree.
And:

$ stat --format=3D%y .git/index
2023-12-19 09:33:46.773896615 -0800

...no further changes to the index from this command, of course.

> What did you expect to happen? (Expected behavior)
>
> Git diff-files should likely ignore group permissions changes, or at leas=
t
> its output should be stable across the same worktree/index state.

It does ignore group permission changes; the problem was that stat
information in the index did not match what was in the working tree.
If you run

$ git update-index --refresh

before calling diff-files, that'll make sure the stat information is up-to-=
date.

> What happened instead? (Actual behavior)
>
> The command `git diff-files --exit-code --patch` fails with no exit code =
when
> a file mode has changed in a way that the rest of git commands ignored.
> Furthermore, subsequent git commands seem to change the behavior of `git
> diff-files` in this regard, so it's hard to tell what is the expected beh=
avior.
>
> What's different between what you expected and what actually happened?
>
> The `git diff-files --exit-code` command is inconsistent in how it behave=
s.
> I suspect it should ignore irrelavant mode changes like `g+w`, but even i=
f
> it should report them, they should produce a patch or at least have stabl=
e
> results when we re-run the command.

This has bit a few folks before; I wonder if there's a reasonable
update we can make to the documentation to address this.
