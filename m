Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B401AAE28
	for <git@vger.kernel.org>; Mon, 25 Aug 2025 15:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756136440; cv=none; b=YFYoJT8OJYGyg4AhrmrLnknsUn34rUqTZACQSknrfdxzaENgkANwnsFuq+oPbOh73GDANlngSdDq3/Ulux5wQJHGE3dF4s5OCJhe4T0dpAvqf08atpp1pPVqclqYtLuoVvfypwhlbrt9qwpgGs9uSI10opSvoD2FU+ggdpr5uX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756136440; c=relaxed/simple;
	bh=n1EY8BAM23hcgFytDBwfpKsQE6iQH8Whvh+AvkFBatE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B0deDkb2+2wJB24Tw2izHGEe9G3TBr7x5bwmNt+4Xl/t0K048e4mVEa/kuX4TxS0J4fcUQTpMsXHUYl/u0MEVw8WEDoTSt9eoj7Pk8dF67YJ7GhkYpRv5K/yVOvfPAEu6+z36Uk4tTjGQbQODeh/mI8rQomPz++DyymC72d/ge8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fw2C7H0f; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fw2C7H0f"
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3ea8b3a64c4so9878975ab.2
        for <git@vger.kernel.org>; Mon, 25 Aug 2025 08:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756136438; x=1756741238; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=De/Q+mRHqTlW45GrqophU6GXqanQF9+JoVj4DU2NE08=;
        b=Fw2C7H0fpZOhP8/NgqGEKxsJE9MY9B+DeeOHRZHO2Hrn9hDksnagTu6fNSsu6k/1iS
         yKllXwxW0x88tbjcYMVSk9dX8pMxMGcuTsddE0xURHzHoQnG/MDzwNyfwaC4AeYBWjTW
         //PeWo7LgqHKoW2vL3dm2Rc1KoA5DpOMCwrSXJZrmYnHaSE93PCjNKQp9IMlS2gIDmyv
         UKeJrFM0VbEuHdfvIC3CS9lS7ezr6BmXv2NHZN5N8NMkIKJcFfysSWz4ktjHnp1WDjQX
         Ly5ShgNcHRyscqruHJBmdS8kRoUY6x3ZHC+i8O/xBQt0pLnXrFTpDGgPqdSPv7WmYqvZ
         YQgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756136438; x=1756741238;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=De/Q+mRHqTlW45GrqophU6GXqanQF9+JoVj4DU2NE08=;
        b=l/ckuzFXIIpFGgtsLm7TduQKpjS0bthIMmlNb4ns5tuh/GKhgGGqy2ZNSSAaxGxwem
         IpXPXbl4V9vjjm+S/CIy635q0khe5Yk04c4XhyeoKRNbzYJvVxdHdWZigJvnEgsPmmsy
         eQasaOONrV20lYiU6b4oS+VYKOAKkICE+jGBzLx3USoT5EtNli4C/lPEnfuky7+KcikE
         fzS1AMAO6rP0ypMv2ujXmyBnOp+x80xP6onep33DNw/ate5ysIDHi7x5mdcmjgW1hd5Y
         QGTxmwbRztLpWmSJzHCct29kpj0kVvBhJoXoT82MnLNL5fz9hNsyij6Z7EcngyxlQkWB
         7mBw==
X-Gm-Message-State: AOJu0YzyeAlmX431pNKzRlAlyG0oAkewqGnnaBrZrs88Xzaa+iCar8O9
	3u+ohj3flUb/Ifv9AJir4W3LiJuV3IQMDLsWDKoW9Mlt6MjNFh8GwwAcrImwZi19Hcx9t/0dttq
	IHDDyYmhAr/5wISxXkLavJEhP1No69+M=
X-Gm-Gg: ASbGncu1COwKiC1Rm5d2lFDS5aNnT10SpE/SyuB3YN6TCFDom+X+eBox+oi62k9Czwo
	vyDgRfzrLL/6tqtxN/USeDNa7RM3DvCqb+PRMrvv/D6EVUSv9obXskCJuC70hGCruQqJRU6vgcx
	35q4pG11LTF2ZNdv6SrSMn++WndIs6fO0Rhxgn8FIMaeFWJFtoADrSKDAN+hkUFPypgmCq8PZ0p
	iLLTuewo5qHQIOmrDIPHuTlAIQQoCsejgMjLPQl
X-Google-Smtp-Source: AGHT+IHP+nzSmI/zThsWVIn+Zb+nY/SGLeJiRyPkv90xLXLz+PkWmN24b0BwQxoU+qcBOq7hhNfrRmhH02OMX3A0nkI=
X-Received: by 2002:a05:6e02:3cc6:b0:3e5:7e02:a06d with SMTP id
 e9e14a558f8ab-3e91f93e0dbmr165602185ab.4.1756136437760; Mon, 25 Aug 2025
 08:40:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2034.git.git.1755630882418.gitgitgadget@gmail.com> <pull.2034.v2.git.git.1755940331248.gitgitgadget@gmail.com>
In-Reply-To: <pull.2034.v2.git.git.1755940331248.gitgitgadget@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Mon, 25 Aug 2025 08:39:00 -0700
X-Gm-Features: Ac12FXzQlHEFcKMu084JolUMc6BD5NnnV9-YAoUY4Ckmm8kkmvH6qh9z-C77Ji0
Message-ID: <CABPp-BHCQjFtpr8meUqhGEiTgsqZ9KTWcpLYA8yEPUsCAceAGg@mail.gmail.com>
Subject: Re: [PATCH v2] doc:clarify which remotes can be used when contributing
To: Daniele Sassoli via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Daniele Sassoli <danielesassoli@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 23, 2025 at 2:12=E2=80=AFAM Daniele Sassoli via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Daniele Sassoli <danielesassoli@gmail.com>
>
> The docs mostly point to using git/git as one's remote, however, when it
> comes to Sending a PR to GitGitGadget section, the reader is told to use
> gitgitgadget/git, with no mention of git/git, potentially leading to
> some confusion.
>
> Clarify that both gitgitgadget/git and git/git can be used, albeit with
> some differences.
>
> Signed-off-by: Daniele Sassoli <danielesassoli@gmail.com>
> ---
>     doc:clarify which remotes can be used when contributing
>
>     cc: Elijah Newren newren@gmail.com
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-203=
4%2FDanieleSassoli%2Fclarify-remote-to-use-v2
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2034/D=
anieleSassoli/clarify-remote-to-use-v2
> Pull-Request: https://github.com/git/git/pull/2034
>
> Range-diff vs v1:
>
>  1:  850097696a4 ! 1:  b34070c03e3 doc:clarify which remotes can be used =
when contributing
>      @@ Documentation/MyFirstContribution.adoc: Now you should be able to=
 go and check o
>
>        In order to have your code tested and formatted for review, you ne=
ed to start by
>       -opening a Pull Request against `gitgitgadget/git`. Head to
>      -+opening a Pull Request against either `gitgitgadget/git` or `git/g=
it`, depending
>      -+on which mirror you initially cloned from. Head to
>      - https://github.com/gitgitgadget/git and open a PR either with the =
"New pull
>      - request" button or the convenient "Compare & pull request" button =
that may
>      - appear with the name of your newly pushed branch.
>      -+If you're using https://github.com/git/git as your remote, you wil=
l need to
>      -+open the pull-request from your fork, selecting `git/git` as base.
>      +-https://github.com/gitgitgadget/git and open a PR either with the =
"New pull
>      +-request" button or the convenient "Compare & pull request" button =
that may
>      +-appear with the name of your newly pushed branch.
>      ++opening a Pull Request against either `gitgitgadget/git` or `git/g=
it`. Head to
>      ++https://github.com/gitgitgadget/git or https://github.com/git/git =
and open a PR
>      ++either with the "New pull request" button or the convenient "Compa=
re & pull
>      ++request" button that may appear with the name of your newly pushed=
 branch.
>       +
>       +The differences between using `gitgitgadget/git` and `git/git` as =
your base can
>       +be found [here](https://gitgitgadget.github.io/#should-i-use-gitgi=
tgadget-on-gitgitgadgets-git-fork-or-on-gits-github-mirror)
>
>
>  Documentation/MyFirstContribution.adoc | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/MyFirstContribution.adoc b/Documentation/MyFir=
stContribution.adoc
> index aca7212cfe2..bbb7b45bd4a 100644
> --- a/Documentation/MyFirstContribution.adoc
> +++ b/Documentation/MyFirstContribution.adoc
> @@ -908,10 +908,13 @@ Now you should be able to go and check out your new=
ly created branch on GitHub.
>  =3D=3D=3D Sending a PR to GitGitGadget
>
>  In order to have your code tested and formatted for review, you need to =
start by
> -opening a Pull Request against `gitgitgadget/git`. Head to
> -https://github.com/gitgitgadget/git and open a PR either with the "New p=
ull
> -request" button or the convenient "Compare & pull request" button that m=
ay
> -appear with the name of your newly pushed branch.
> +opening a Pull Request against either `gitgitgadget/git` or `git/git`. H=
ead to
> +https://github.com/gitgitgadget/git or https://github.com/git/git and op=
en a PR
> +either with the "New pull request" button or the convenient "Compare & p=
ull
> +request" button that may appear with the name of your newly pushed branc=
h.
> +
> +The differences between using `gitgitgadget/git` and `git/git` as your b=
ase can
> +be found [here](https://gitgitgadget.github.io/#should-i-use-gitgitgadge=
t-on-gitgitgadgets-git-fork-or-on-gits-github-mirror)
>
>  Review the PR's title and description, as they're used by GitGitGadget
>  respectively as the subject and body of the cover letter for your change=
. Refer
>
> base-commit: 1fa68948c3d76328236cac73d2adf33c905bd8e3
> --
> gitgitgadget

This version looks good to me; thanks!
