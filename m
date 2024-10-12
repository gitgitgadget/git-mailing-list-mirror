Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33584315F
	for <git@vger.kernel.org>; Sat, 12 Oct 2024 06:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728714291; cv=none; b=YP82eQitTDPVVS6eW12QmBfSX8r0HYBdMJ68EvavhQurzkHzt924egfwegcrrSAeYR1s5LkRVrjzOJEcphWlukr3DhhQBZKxOQKQ4qdjXnmhcz2nWtd0sMMO/MWOZTN9jiiuMkMAU2r5ShXs8jKeCUShhjm0Vy/Nn8/eENuisSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728714291; c=relaxed/simple;
	bh=FFMX6Tnin9ChMCyAO1yTX3AvxbGvUveb1gUBxThlk0s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UYtQ028PB87PVoXBc7pU4Cnck7C+Ert1CKdnyfE38t6PGc0nqAufEnBipM/qECwZVgOnWPG1FcsSVMh+gWUtIXxRXxveTRyBsMv/qjQtQhJ3SIE7Z1g4/4aatkoWMQv0sV4Fmn1D9quX4NwkfgKeSKKPZuTZJq2dGa6h+Aoc8Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6cbe7374e74so4392166d6.1
        for <git@vger.kernel.org>; Fri, 11 Oct 2024 23:24:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728714289; x=1729319089;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PP4gKjelyjc1EsV8tQjTF2xdz+XI3K0V/SujxjZZXTo=;
        b=OOZrOg8URLWzA3mIAkbYCCw1xnMUqz4q8yshzQuui+120OaM40fsx4qEOTiuPymaAk
         0eV06eDPoMOCySgNoWKSC1oQrtL5xkRoXstH4NySOD8JoV/iyCANf3AI4Ot6dWspDJc7
         SoEJkNz8C06dAB6JKYaYXYQ+nCexVc+JzcP2h6eFR8J/9szBdlTE75+sL5CDZR+XI/m/
         KL97ix6r8FGP9/fVCt0oSgN1pRXFUxWBM29HJXiFpfuD9NZMjaCEbKWxk84drwj3PRYj
         zTO9Xt96kukpsXC0RUubRKOWiipY3XLTpEkTbvTLWaZ6R/+bccUZ4VzvkYQddH7K7FQa
         +ENg==
X-Gm-Message-State: AOJu0YySsRSwzz7y20Oqg2eN1yOvWmN9RptXxVzmIGFtKptRh/U81lw4
	DeN4QDK2Sefms248Y6a2nY3e/qKd5qkE64z/2nexBT3jKLfsm1+KLID0VjdqmUDtOpgYNfnK2Tz
	QvnJgUJS0OvJTORMURP+VRod5F90=
X-Google-Smtp-Source: AGHT+IFJ8EK2T7FRAFw/6zV4dJRZoVfhwIVXoDmzciWJ1goSAQtYzkPkDD55adxaVQyuu+hFoRuZXyL0M9Uj4CxYgIU=
X-Received: by 2002:ad4:5966:0:b0:6cb:e610:f8 with SMTP id 6a1803df08f44-6cbf00445fdmr28970606d6.12.1728714288613;
 Fri, 11 Oct 2024 23:24:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1809.git.1728370892696.gitgitgadget@gmail.com>
 <pull.1809.v2.git.1728707867.gitgitgadget@gmail.com> <8d2fa3af7964dacd09d454de4325b1d5eb7a5c3d.1728707867.git.gitgitgadget@gmail.com>
In-Reply-To: <8d2fa3af7964dacd09d454de4325b1d5eb7a5c3d.1728707867.git.gitgitgadget@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sat, 12 Oct 2024 02:24:37 -0400
Message-ID: <CAPig+cRkp3ZrykLvgDaGnKgZNV5GiFqc5zq6ZZ-fM7RJcqxM7A@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] blame: introduce --override-ignore-revs to bypass
 ignore revisions list
To: Abhijeetsingh Meena via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Kristoffer Haugsbakk <code@khaugsbakk.name>, 
	Phillip Wood <phillip.wood123@gmail.com>, 
	Abhijeetsingh Meena <abhijeetsingh.github@gmail.com>, 
	Abhijeetsingh Meena <abhijeet040403@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 12, 2024 at 12:38=E2=80=AFAM Abhijeetsingh Meena via GitGitGadg=
et
<gitgitgadget@gmail.com> wrote:
> The git blame command can ignore a list of revisions specified either
> through the --ignore-revs-file option or the blame.ignoreRevsFile
> configuration. This feature is useful for excluding irrelevant
> commits, such as formatting changes or large refactors, from blame
> annotations.
>
> However, users may encounter cases where they need to
> temporarily override these configurations to inspect all commits,
> even those excluded by the ignore list. Currently, there is no
> simple way to bypass all ignore revisions settings in one go.
>
> This patch introduces the --override-ignore-revs option (or -O),
> which allows users to easily bypass the --ignore-revs-file
> option, --ignore-rev option and the blame.ignoreRevsFile
> configuration. When this option is used, git blame will completely
> disregard all configured ignore revisions lists.

It's not clear from this description whether ".git-blame-ignore-revs"
is also ignored by --override-ignore-revs. Looking at the
implementation, it appears that it is, but it would be good to state
so here.

> The motivation behind this feature is to provide users with more
> flexibility when dealing with large codebases that rely on
> .git-blame-ignore-revs files for shared configurations, while
> still allowing them to disable the ignore list when necessary
> for troubleshooting or deeper inspections.
>
> Signed-off-by: Abhijeetsingh Meena <abhijeet040403@gmail.com>
> ---
> diff --git a/builtin/blame.c b/builtin/blame.c
> @@ -901,6 +902,7 @@ int cmd_blame(int argc,
>                 OPT_STRING_LIST(0, "ignore-rev", &ignore_rev_list, N_("re=
v"), N_("ignore <rev> when blaming")),
>                 OPT_STRING_LIST(0, "ignore-revs-file", &ignore_revs_file_=
list, N_("file"), N_("ignore revisions from <file>")),
> +               OPT_BOOL('O', "override-ignore-revs", &override_ignore_re=
vs, N_("override all configurations that exclude revisions")),

We don't normally allocate a short option name ("-O" in this case)
when introducing a new option since short option names are considered
a valuable and limited resource. A short option name may be added
*later* if experience shows that the option is popular enough that the
convenience of the short option name is warranted.

> @@ -1119,7 +1121,11 @@ parse_done:
> -       build_ignorelist(&sb, &ignore_revs_file_list, &ignore_rev_list);
> +
> +       if (!override_ignore_revs) {
> +               build_ignorelist(&sb, &ignore_revs_file_list, &ignore_rev=
_list);
> +       }

A style nit and questions and observations...

nit: drop the braces around the one-line `if` body

Is the all-or-nothing behavior implemented by this patch desirable? If
so, should the command warn or error out if the user gives conflicting
options like --ignore-revs-file and --override-ignore-revs together?

A common behavior of many Git commands when dealing with options is
"last wins", and following that precedent could make this new option
even much more useful by allowing the user to ignore project-supplied
ignore-revs but still take advantage of the feature with a different
set of ignore-revs that make sense to the local user. For instance:

    git blame --override-ignore-revs --ignore-revs-file=3Dmy-ignore-revs ..=
.

> diff --git a/t/t8016-blame-override-ignore-revs.sh b/t/t8016-blame-overri=
de-ignore-revs.sh
> new file mode 100755

Let's avoid allocating a new test number just for this single new
test. Instead, the existing t8013-blame-ignore-revs.sh would probably
be a good home for this new test.

> @@ -0,0 +1,25 @@
> +test_expect_success 'blame: override-ignore-revs' '
> +    test_commit first-commit hello.txt hello &&
> +
> +    echo world >>hello.txt &&
> +    test_commit second-commit hello.txt &&
> +
> +    sed "1s/hello/hi/" <hello.txt > hello.txt.tmp &&

style: drop space after redirection operator

    sed "1s/hello/hi/" <hello.txt >hello.txt.tmp &&

> +    mv hello.txt.tmp hello.txt &&
> +    test_commit third-commit hello.txt &&
> +
> +    git blame hello.txt >expect &&
> +    git rev-parse HEAD >.git-blame-ignore-revs &&
> +    git blame -O hello.txt >actual &&
> +
> +    test_cmp expect actual
> +'

What is this test actually checking? It doesn't seem to use
--override-ignore-revs at all.
