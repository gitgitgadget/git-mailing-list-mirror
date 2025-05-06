Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDB4255222
	for <git@vger.kernel.org>; Tue,  6 May 2025 00:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746490108; cv=none; b=fUqCXIP380x37BFHFDlHPcf9aGsIubTwuP2667QCAGE2SGHS+uSy+KrP5r4ScyBmtJ6TUErIMpM6Se99Aylye41jczZx24yo91e2q6Ddn1PF1df08WmxbmcgRXkS5+SoN/LiduwNYz4it/ilIkqyUwmATnUBaOWNNnyiQCwJaoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746490108; c=relaxed/simple;
	bh=/gOPlhN6v5OAQ9B5Y6Xed4wUlIMP+AwERbcYtsH7Yrg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OETW+DVfMdL7xFIGQ/BMX7uMdQQLNI23jtzHc7vlFqYuoinWFbIZOCB7q0XBL6iS0y/J0VWfumQooLuJXMjNyvfBCO1FMGD0BFrFcWk1qPeqafR+Qiz9yHnf/mSRWIj8XKy8M+ruP4BQ2DhUtRVeiaq/1j5eqKGK816qKvABGa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-72b87587c61so191628a34.0
        for <git@vger.kernel.org>; Mon, 05 May 2025 17:08:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746490105; x=1747094905;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H1IXzRJZdMj5SyHEb6Wr/bVSIvJgOJsLKkyme0skv6c=;
        b=MnKtsk4TbMmf0vHO4KvgENJvHpYSXyQ/Fb496TpS4jsDRhjrLpXsEnoh8WGL+tYMcV
         YneMNkNWQOOY+iqfbXEjBYQUuHlba9ecHv1BCxeKpKeHFflYpj56PskFfzSMSQUDPwBE
         Hiu2ew5TRewcKJUsxlgSRgmEkBfZRf9xXawFHjscdWZYtKHcOY9E1+BaQldY7Lpp/Egj
         wIlPXMswOWBrwCz7vib+9C4XfMh4iYmlru5tYOJO0hmRuSK+nw0W3c//XAdTOhej0sTC
         cAf5NWfZJLZCXH7zNL54TD9XfeNN4lGoM4rxbeXYi3Cr89Y5hemRdu7JgwS7SpjWOQWQ
         CfJw==
X-Gm-Message-State: AOJu0YwGE/ZgpOxCUU2X8YbgnIAPF+yo2PbyzsXAFp6Om7iMTYnG+eNp
	z4S0Bx1Nlavo4INYH55U191HwOR5tDPPPJ2Meez+DPtXScszhYNemt1y+SMV1Sz4iU5S31a7vBo
	ioTeX/sg8LTxCT6onif7Ux8MwDqA38ewS
X-Gm-Gg: ASbGncsU0ltNGGk2/vcM8fcH2DwLeDGJk2un6DqUMNiwoU/XI656ZgwuRykauG5BZml
	gUJuidljdzq6FG8s65yYMVEnpWePYauQlcD4fOsk7wvi1O/0hZi0tpRNHS3cc9yfvi9OEo06FES
	gwk1REkrvU29wgpM6xQKWxjcCwnz0miTSIwjHufu1+VnGgtYFUz5WRYoI=
X-Google-Smtp-Source: AGHT+IG8GMzf6bdpNoAdlvU63lib5cUQxFHYHlyugPzxj4KO/qZdOpYhall9SbDnarYK+D7xre7e/5WuqcV0feVUqoI=
X-Received: by 2002:ac8:7d14:0:b0:48b:6eeb:f98e with SMTP id
 d75a77b69052e-48c30f741c7mr79272381cf.2.1746489739961; Mon, 05 May 2025
 17:02:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1915.git.1746436719.gitgitgadget@gmail.com> <b4b7854f330af7588b12e3361bed40723febddad.1746436719.git.gitgitgadget@gmail.com>
In-Reply-To: <b4b7854f330af7588b12e3361bed40723febddad.1746436719.git.gitgitgadget@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Mon, 5 May 2025 20:02:09 -0400
X-Gm-Features: ATxdqUG2VXeLj6Qc1ZyGoXQg0L5-gx6d9EilWYsj1EehY2lehIHyeQb0e1ea-DQ
Message-ID: <CAPig+cQmnAiHo8su6UBaKnZ=UZwgwMbDFA6ewMAfvCRR0RFzbw@mail.gmail.com>
Subject: Re: [PATCH 3/3] add-interactive: add new "context" subcommand
To: Leon Michalak via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Leon Michalak <leonmichalak6@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 5, 2025 at 5:19=E2=80=AFAM Leon Michalak via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> This teaches `add/commit --interactive` a new "context" subcommand, which
> changes the amount of context lines subsequent subcommands like "patch"
> or "diff" generate in their diffs.
>
> Signed-off-by: Leon Michalak <leonmichalak6@gmail.com>
> ---
> diff --git a/Documentation/git-add.adoc b/Documentation/git-add.adoc
> @@ -265,14 +265,15 @@ and type return, like this:
>  ------------
>      *** Commands ***
>        1: status       2: update       3: revert       4: add untracked
> -      5: patch        6: diff         7: quit         8: help
> +      5: patch        6: diff         7: context      8: quit
> +      9: help
>      What now> 1

I'm not a `git add/commit --interactive' user, but I can imagine that
inserting "context" at 7 and bumping "quit" and "help" to 8 and 9,
respectively, is going to play havoc with muscle memory people have
built up over the years. To make this more friendly for existing
users, I'd suggest adding this new command at the end of the list
without changing the existing command numbers.

Also, looking at this list, I can't help but think that "context"
feels out of place among the other action-oriented commands. Moreover,
if --interactive mode grows more configuration/setting-like commands
in the future, do we really want to keep extending this menu for them?
Specifically, I'm wondering if it would instead make sense to
introduce a new item "9: settings" which takes the user to a
"Settings" submenu from which the number of context lines can be set.

> -The main command loop has 6 subcommands (plus help and quit).
> +The main command loop has 7 subcommands (plus help and quit).

Since you're touching this anyhow, let's fix this maintenance burden
once and for all by writing more it generically, perhaps like this:

   The main command loop has several subcommands (plus help and quit).

> +context::
> +
> +  This lets you change the amount of context lines shown in diffs that
> +  the 'patch' and 'diff' subcommands generate.

s/amount/number/

> diff --git a/add-interactive.c b/add-interactive.c
> @@ -1061,6 +1118,8 @@ static int run_help(struct add_i_state *s, const st=
ruct pathspec *ps UNUSED,
> +       color_fprintf_ln(stdout, s->help_color, "context       - %s",
> +                        _("change how many context lines diffs are gener=
ated with"));

Perhaps:

    _("change the number of diff context lines"));

> @@ -1087,6 +1146,16 @@ static void choose_prompt_help(struct add_i_state =
*s)
> +static void choose_prompt_help_context(struct add_i_state *s)
> +{
> +       color_fprintf_ln(stdout, s->help_color, "%s",
> +                        _("Prompt help:"));
> +       color_fprintf_ln(stdout, s->help_color, "<n>        - %s",
> +                        _("specify new context lines amount"));

Likewise:

    _("change number of diff context lines"));

> +       color_fprintf_ln(stdout, s->help_color, "           - %s",
> +                        _("(empty) finish selecting"));

"finish selecting" looks like a copy/paste error from elsewhere in
this source file. Perhaps you meant something like:

    _("(empty) don't change number of context lines"));

> diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
> @@ -1230,4 +1237,23 @@ test_expect_success 'hunk splitting works with dif=
f.suppressBlankEmpty' '
> +test_expect_success 'change context works' '
> +       git reset --hard &&
> +       cat >template <<-\EOF &&
> +       firstline
> +       preline
> +       TARGET
> +       postline
> +       lastline
> +       EOF
> +       sed "/TARGET/d" >x <template &&
> +       git update-index --add x &&
> +       git commit -m initial &&
> +       sed "s/TARGET/ADDED/" >x <template &&
> +       test_write_lines p 1 | git add -i >output &&
> +       grep firstline output &&
> +       test_write_lines c 0 p 1 | git add -i >output &&
> +       ! grep firstline output
> +'

This script does have its share of bare `grep` invocations, but these
days we prefer `test_grep`, which also appears often in this script,
so the following would be more appropriate:

    test_grep firstline output &&
    ...
    test_grep ! firstline output

Note the placement of "!" when used with `test_grep`.
