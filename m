Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BEB2C21D0
	for <git@vger.kernel.org>; Thu, 18 Jun 2026 17:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781804617; cv=pass; b=DtThZVseo/Nb20nQwOEptySkPgr4M1bq+hGYVxzH5a2eITw05dgZeiMEsDyWdnSA+fktG9AwAo7A0Fs5ZUAkqRF5Q7xacpCu7v/LezsEk0XzqI6lpCAaiAUQ4FYLqWvQ2SsrEgoD8C2btq1Yr+P4JRlb9U5iVpDsvIHApVLvvPI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781804617; c=relaxed/simple;
	bh=0uU32dycXIv8J0yapWLLh6SCdNM2Qd4b64eUKw6OK88=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=osphKv0BCkZbqWHFgovLHqanUCFHpldJJvBE04a/1+3QkrLKT+lTnk9UIxTo9Lma6eiTJyNaSCwe6Y6lBI+65BM/uy/s9uBpA07kF4KsUkF4LNNsNXkCItVG1aAsvjf4ongQ8SbKEMn+gsWR7K3I0gzjp9WMf4QmWcJRiBWAKcs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O4/mBduG; arc=pass smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O4/mBduG"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-845385adf4cso654219b3a.0
        for <git@vger.kernel.org>; Thu, 18 Jun 2026 10:43:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781804616; cv=none;
        d=google.com; s=arc-20240605;
        b=lmOz6VK+o84SLaILqr7BUQkPziQUMzcIWgOE+U/GeveueLFuum2dTnrNbWUZYHnAln
         8nZc6w2nT9RekIkWrzrJ9YlfjFMxeqQETWa9a+kmLmBfVN/aC4YmezoMZi2EIKHziyVz
         IBhf4kOnNoD2zkZZKvd0px0g3QZkQ/FPHZyIKxKNi9/kikvfb2g9RY5g4W1DevTQKq0h
         oLpoxZZUih6EMCTo3AvyYTCzuu8YR7vxJdNO7JKDRbbnXfI8XdUFedgSlwdmJ0TeMavi
         B/P4PLyWytv267I1gdLt5ktRDLWJNsmbuIl/RvkGFfMfVOjynFjFJoJapU2tKA22KnXb
         7mvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HeFwxc0QE+FHjzXq6ZOCbVqTGzWLr+NYWIxWftnO3/Y=;
        fh=tRywq0+sqXbiUEVOIgeqb9aq+ZmDFGlgumczAjAR+HI=;
        b=HMElQIhpQUXffagh0HjdCsHU9kvVa6gQvAdmODUBt9+7QxAC8aJOGq+mixXCPnc1FV
         EofwidhG7ujIGk2yAju5yQjH4GhJd0jbPUH2HQ6AZtRgycJOK7RDD0wix53MJE7NWC2n
         nNA4JfvIAO3/8N5TrsUQTwHGDoxF182obERHizniKWVKV+TJbNkwpprjt9Hx6Up8gVlB
         8lYS/4cuGV3RvVR1cxbSK0U7hUrFhJew1eUFV67vZtlhOc6rsddSfAfmd9tuGhbxgNik
         p0yTvjV10WYpFlQl5ImNcGXbYSb3pQ+2wfZLtsKz4XqBpRQbAFyf1YdPnuFqAG+gCC5X
         JD7Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781804616; x=1782409416; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HeFwxc0QE+FHjzXq6ZOCbVqTGzWLr+NYWIxWftnO3/Y=;
        b=O4/mBduGaxV5HC+a8GgKDZJ8fDq3gn0sG6PQO+Nl8dYEfWU2ZaVV9yDgARmUl8ACiL
         JDK0leRev296Z6RMRbUdRzx5HgeGK5SI/vD4bAOw4S7R22aQroYy/E/SfViAxe1O0abD
         tQk++ScfjvbcM/T8xN6rQARmIz30iKyefk7xCSmza/Vz/OZHs7tXtEXQYJI0hEUqpAxh
         tjH0OYO4Yy17r9bOlsQRSR4VTy3TDRI+4VemUv99KV3aGffoFERPjIEpdfwjj0qSKZD3
         pnJPoNx00FjtJL1S1KanDNwcebBQlkTMDvijJfTMwybtABGScIVw4tG+wWJchNVXbBcB
         /QGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781804616; x=1782409416;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HeFwxc0QE+FHjzXq6ZOCbVqTGzWLr+NYWIxWftnO3/Y=;
        b=qIAQ31bmzFKxlrOeXlR+EkvwzGTubYP+hT1olz4LMgF6V9PknB7r7lYefvAbyoyqgV
         fWhuIATVpTbxTBaMZPFztW9fVlK/0kCe6ovaKnp9dSZyqRAl8c4yALWJoE3QH3tTuwNU
         RH/y6D77Q8nlUYsNocnGp09xFJWLTTUaq07XpZz6U18+QCMKlPBEAvtf4DvOqK6M8UMt
         Xv9gLxo/pPqyNSZggEz4nYUgZmOJoxXwiQM0xGVCGevHj/33+Mphk+ZO25VikzXJavTm
         gi1gSHF+tZZ4hKmdylEbsO2jfJScUdF5DXkpebfdDjf+Y6zqUBL6rd8lSlIVIGc445UW
         8sUw==
X-Gm-Message-State: AOJu0YwIN0uJZSCbrZ7NXnq6M4Vp1YdrisW7C4gStWiWciLZBHgRRhYG
	nbQT4FxfF7TOV1xtCE+Yt9oqBxOE9W5Gz9d8O8vLQetiRYWr1Jc+y9/OBwJvwc6JG2HiavNGhIz
	r9l7mLHEQZAhpXQLaydzxWd2hOG5+/vQJXHGeijA=
X-Gm-Gg: AfdE7cmJJezKTWShBT3SWvGhaOezlLCkCDcE0AAMRUu73V0/w/gbfyMFgmM4Ixm/p0D
	p6tXpzIuI87YczZiQfmOE3jiHscYwERMYZhZC4bw1k67Tdszmv4TCW/q3hmA4wRsNr6NuHzrHUH
	piKIGJ5kYXrtBHsjEB/qILsfwVhkp8iAvZDYaT4cGkHE2/e6XhyyEaJrOmUImO9n1fIvKJcZ4CH
	vCXDF2Q2pHi1tQu/D1A9iymeol9tg6yAYSDPKVzNiQjaIXJumJqjYSgvbsMciKthA1nl9RHPSUA
	v1kBoDAVGQiopHCs+ErBEDf9UKgx+rWvNoGjP/yitPUftwp9ztwi0ftXJvgzUf0YMOx55w==
X-Received: by 2002:a05:6a00:2d84:b0:842:422b:259f with SMTP id
 d2e1a72fcca58-8453b07c89bmr5301465b3a.10.1781804615830; Thu, 18 Jun 2026
 10:43:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2155.git.1781710256081.gitgitgadget@gmail.com>
In-Reply-To: <pull.2155.git.1781710256081.gitgitgadget@gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Thu, 18 Jun 2026 13:43:24 -0400
X-Gm-Features: AVVi8CfL-g9WENxlBhuBtdnYw1KO2n93UQQlsDYwvenChG_PesxJvjD8YeV2Q5Q
Message-ID: <CALnO6CD9P4+e=YPdKaLfSBOk-H3_ir64pBP-qMKNNvzUNqunXQ@mail.gmail.com>
Subject: Re: [PATCH] completion: zsh: support completion after "git -C <path>"
To: Lutz Lengemann via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Lutz Lengemann <lutz@lengemann.net>, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[apologies in advance for the strange format below]

On Wed, Jun 17, 2026 at 11:37=E2=80=AFAM Lutz Lengemann via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Lutz Lengemann <lutz@lengemann.net>
>
> The zsh completion wrapper (__git_zsh_main) did not handle the global -C
> option, so "git -C <path> <command> <TAB>" offered nothing and could not
> complete a command's arguments.
>
> Three things are needed to make it work, all scoped to -C:
>
>   - Add -C to the _arguments specification, so completion no longer stops
>     at it.
>
>   - Advance __git_cmd_idx past any leading "-C <path>" options. The index
>     is hard-coded to 1, i.e. the command is assumed to be the first
>     argument; with -C present the command sits two words later for each
>     -C, so the bash helpers otherwise look at the wrong word and produce
>     nothing.
>
>   - Collect the -C paths into __git_C_args, as __git_main does. The bash
>     helpers run git to resolve aliases and list refs; without the -C
>     paths they run in the current directory, so completion fails whenever
>     the cwd is not the target repository or the command is an alias.
>
> With these, "git -C <path> <command> <TAB>" completes the command, its
> options and its arguments, including outside the repository, through
> aliases, and with repeated -C options.
>
> Signed-off-by: Lutz Lengemann <lutz@lengemann.net>
> ---
>     completion: zsh: support completion after "git -C "
>
>     This patch is intentionally scoped to -C, but the underlying problem =
is
>     more general. The zsh wrapper hard-codes __git_cmd_idx=3D1, i.e. it
>     assumes the command is always the first argument. That assumption bre=
aks
>     argument completion after any global option that precedes the command=
,
>     not just -C =E2=80=94 e.g. --git-dir, --work-tree, --namespace, -c, a=
nd
>     -p/--paginate. After those, git <opt> <command> <TAB> currently
>     completes the command name but not its arguments.
>
>     The same approach generalizes cleanly: instead of skipping only leadi=
ng
>     -C options, walk all leading global options and their arguments to
>     locate the command and its true index (mirroring the option scan in
>     __git_main in git-completion.bash), while collecting -C into
>     __git_C_args and --git-dir into __git_dir as today.
>
>     I kept this revision narrow for reviewability and because git -C is t=
he
>     case where I miss the completion, but I'm happy to extend it to cover
>     the other global options in a follow-up (or fold it into this patch) =
if
>     that's preferred.

See Junio's review for whether we should expand in this patch or a follow-u=
p.

In reply to Junio:

> [the new handling only knows about -C]
> Doesn't it want to do something similar to what __git_main in
> git-completion.bash does at the beginning, namely, this part?

Yeah, we probably do want to skip over -c, etc. (I see some support for
--bare and --git-dir, but not skipping over it.) Still, this patch makes
things no worse in that regard, and improves the situation for -C
AFAICT.

In reply to Lutz:

> +        local -a __git_C_args
> +        local -i i=3D2
> +
> +        while [[ ${orig_words[i]} =3D=3D -C ]]; do
> +            __git_C_args+=3D(-C ${orig_words[i+1]})
> +            (( __git_cmd_idx +=3D 2 ))
> +            (( i +=3D 2 ))
> +        done

I don't see either of these 2 local variables used anywhere else=E2=80=A6

=E2=80=A6well, except the Bash completion helpers, I suppose. But we mark t=
hese
local, so how do they propagate to the other functions?

Still, I was able to try this out with the somewhat hacky

    zsh # new shell :)
    # absolute path important
    autoload -Uz $PWD/contrib/completion/git-completion.zsh
    compdef git-completion.zsh git

    git -C <tab>

and it does prioritize directories there (though I still get a listing
of files afterwards, so the screen is taken up by that gigantic listing
in git.git, for example).

By the way, I've realized that "git -<tab>" has the same problem (a
giant list of files after the other option completions), and worse has
some _funky_ output!

    git -<tab> # without patch
    (option)
    --bare
    --exec-path
    --git-dir
    --help
    --html-path
    --info-path
    --man-path
    --namespace
    --no-pager
    --no-replace-objects
    --paginate
    --version
    --work-tree

    -p

    # treat the repository as a bare repository
    # path to where your core git programs are installed
    # set the path to the repository
    # prints the synopsis and a list of the most commonly used commands
    # print the path where gits HTML documentation is installed
    # print the path where the Info files are installed
    # print the manpath (see `man(1)`) for the man pages
    # set the git namespace
    # do not pipe git output into a pager
    # do not use replacement refs to replace git objects
    # pipe all output into less
    # prints the git suite version
    # set the path to the working tree
    [ed: the above block repeats twice more before the (file) listing below=
]
    (file)
    [=E2=80=A6]

Here's the output of _complete_help (^Xh by default) in both situations,
in case that helps to understand either the extra files listing (1) in
the example further back or the issue with single letter options (2)
just mentioned:

1: tags in context :completion::complete:git::
    option-C-1     (_arguments __git_zsh_main _git git-completion.zsh)
    use-compctl    (_default _git git-completion.zsh)
    globbed-files  (_files _default _git git-completion.zsh)
tags in context :completion::complete:git:option-C-1:
    directories    (_directories _arguments __git_zsh_main _git
git-completion.zsh)
    globbed-files  (_files _directories _arguments __git_zsh_main _git
git-completion.zsh)
    all-files      (_files _directories _arguments __git_zsh_main _git
git-completion.zsh)

2: tags in context :completion::complete:git::
    argument-1 options  (_arguments __git_zsh_main _git)
    use-compctl         (_default _git)
    globbed-files       (_files _default _git)
tags in context :completion::complete:git:argument-1:
    common-commands alias-commands all-commands  (__git_zsh_main _git)
    common-commands                              (__git_zsh_cmd_common
__git_zsh_main _git)
    alias-commands                               (__git_zsh_cmd_alias
__git_zsh_main _git)
    all-commands                                 (__git_zsh_cmd_all
__git_zsh_main _git)
tags in context :completion::complete:git:options:
    options  (_arguments __git_zsh_main _git)

> +        '*-C[run as if git was started in <path>]: :_directories' \

We should probably note in the log message that the _directories
completion will not account for previous -C; that is, after typing

    git -C dir -C <tab>

we will complete directories in ".", not "dir". That's probably a
reasonable limitation for now, but I think we could do _slightly_ better
by using a state "->dir" or something, accumulating the current prefix,
and passing that to _directories as a prefix with -W (see _path_files in
zshcompsys, which _directories delegates to via _files, IIUC).

--=20
D. Ben Knoble
