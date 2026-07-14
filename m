Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C57D2AD37
	for <git@vger.kernel.org>; Tue, 14 Jul 2026 22:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784068517; cv=pass; b=AFKJ+rltLZuVXqFv4zHVqk9wyo+UuAcywpSe2UCY5ws3xv1WJpUWpx4sDOyuJl1IatQ0QCateyq95BieZ0qCfvKMa2ikYu9jyravwheEMIDM83M4HWlS9FTl4vKt4XYSGfbnSMky7KA5OWvgJE6NUw9SOtOmt5COCJADWZFC7ls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784068517; c=relaxed/simple;
	bh=avIaPwfkET4k5ui99Rl3h7BmC472MmhpHYRlx7DhfDs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kKIYJ5NWXfwUebbeUDYdDItoYVYqINyRC4QnuGpFgR6qHupdFlLl41HhSWxkJCBStbHPHjq5ew62IdHatzf6CLFrdIU37yjUCZn1QgsX9sSpd7hr8pDQ6HTDAvd/zvQNjHwGvlQjTgI/FL9H1pbr10oGkmI6W2KaYIwH3yDmVS8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OoQrpkch; arc=pass smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OoQrpkch"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2cad8076b01so57000315ad.2
        for <git@vger.kernel.org>; Tue, 14 Jul 2026 15:35:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784068511; cv=none;
        d=google.com; s=arc-20260327;
        b=ZIJpRrsORgphbT/E1CTeNcFAdcLQ03Ei+yDC9kNV7SVMSVmfAtd67wxTVO4TZFnxge
         bpC7+qp+MMy0Jk7Du5DWmvBeLY03HbUJ9o0GohEcOcnxJO/gjKmXiRCHG1WCvzCguv/+
         qEJA+CqnWGJmfF9UhPOG5XsAD0TXGb4qToqTOwbM1Iq5OF9sWrZBgL7GLtyZGmci25mW
         GnqLNw5LBwpc156WPl+YkmsRq+tHd1Cw3JD2GuHzub8XQeaXSH7RUxiSPAXX5T596s+R
         GzGabHvktoJF3ft5sVNczfD8ohYv6LdM0m3mpyJsnQJFGigq9vJbRwkYrXpMnH8LTay7
         B6Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PbjbwkzOOVNABxCR7hzCKyWKF0BcNDVimh7rDLTtUoY=;
        fh=tRywq0+sqXbiUEVOIgeqb9aq+ZmDFGlgumczAjAR+HI=;
        b=qkT1rGWHGrWlKxfKrFydtA87EHSVJsIXbseIKT/oqEihkaE+sLiPk2jJhNX+oVk/G+
         9o+UvOldteLIp8J8E4HBc5abkHT4TVTgLe/KPzr0M0ANpiwTS7AerG2BzL+QZXjZProF
         GR8jjuwYnXWMrPGf1x8Wq4hqqGAbphGBjQK9ltt8PIkiBfUK77cDzq1fag7oFYKeEGzy
         i1JVP2IUjD4nTfUXJ810RQp67B9LzYwMv1znelGNbOm0Hb5koQl3UmU0koKiZa/hV79m
         HBxbnd5nYX6q4fEmNKN4mzMWNqXNsGLcHTaB+0U/bxgPL5AA0vKhXEiCaVq78ZveqDG5
         t3MA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784068511; x=1784673311; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PbjbwkzOOVNABxCR7hzCKyWKF0BcNDVimh7rDLTtUoY=;
        b=OoQrpkchNC3tibP1FAppKvuQ5Z6xBDW27abzKWymm4eRCXgP0ybssgkg/olcJToDA8
         0vvAXozCadoFGJ5pKOPLuv/4ixEctIThKXud6PfKWeQgkJCpQl97R3gKpHgk9ZiDaJPf
         KWaCXGOwHWT8JbvvYj5G75Z5osUF45Kl9p8mguEeTFelqpSdxYVwjN1S3Qpc6zo+vciz
         LLeApoDfbF4r7Ptaib1ejC9JDEXfOItb2YPH4lllz1izo0aase3vVrOA4y4yTi+ivAeT
         ylmXpTj9k3p11CsatAgdKFomn/7leVW+dE6GEyKlp7nc+nR9SBVGPeYWJOgxJUIiUZnG
         WQAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784068511; x=1784673311;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PbjbwkzOOVNABxCR7hzCKyWKF0BcNDVimh7rDLTtUoY=;
        b=Sp9dth4dGSsSv1LpmS8V2aHEeSXAZsrUKZsWlGBuSM/1xWANuJOP//DnGQiUc0Bbfq
         GSh8GW1GvmB4MfT7ngM1zkq21/tAtIEBW5O3ezv/2nSG/BIWbzFRg3BXGR9vmhkLXNxs
         HzuMMHkzIxTA0kq+UJnG/OUAb0/f3rMcu8iUVdBtduVyzrPDLDuddcJND+t4/hfLiJVe
         Ew4/0/Ar94ntozMLRBN+ZWfgky6AFBDyAYG0Z0B3kcXzzivecQ8qpqgqy7G14xa0a2Wz
         cbF2iouv8t1/ag0D2z5senaVM29pSVDqhl2Tvonx7gXDhMWPryy3rsHOCtRjIZU34Wzp
         74gg==
X-Gm-Message-State: AOJu0YyNih9XFIYLhJVrN5kAHfGq7xEbmYDdaiX8RlOWONOsEgqYp9Yj
	HZUvn3NiwvgfVPKa3uA8majzkT2AUAIInuEVkMfLUFUPhhqKZwIhmAZaVdPJhlBMNn1MX4n166l
	Sd2SPNOJaIjch2bOTJt/v4gtbac2Ii6814zlu
X-Gm-Gg: AfdE7clkOOk6rTSgiUQJVV/kcD0vmxTdTYlwBdaGjHY6rr5wHgSlk8muf16wVgTuRre
	2MswAdt6X9FzbDleb/jB+y+CJYNZAZeXt0bj6aMzrZlfOyumylK2zU2j99aXDOR4xMiEhvrpXIg
	a9YNEWJNKklWAf7oh8fSV1pyBAoWKPsDR9VJuvygjPECBh3VsmSD2nYN+tmzB5x29lQGQP8/I2S
	ILEJLqGPuBLEunXKJzze1As+hIYA9IYVJkthynHtJBeZJNk9Df819FiofPZaZgd3DrCgkU/34y5
	0D5fgtpwMkBVJolFSTya26jEGEYH+I/R9FnYtAYL15PCFZ1Qf+O1K8f0slyqbjP5bhMSeph7O5I
	cFUClgvJyc9hS2qfDdBluJZesig9NoiSGF5n1ftptUosciPw=
X-Received: by 2002:a17:903:1a2d:b0:2cc:5f48:5764 with SMTP id
 d9443c01a7336-2cee9bacb60mr58297545ad.44.1784068511290; Tue, 14 Jul 2026
 15:35:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2155.git.1781710256081.gitgitgadget@gmail.com> <CALnO6CD9P4+e=YPdKaLfSBOk-H3_ir64pBP-qMKNNvzUNqunXQ@mail.gmail.com>
In-Reply-To: <CALnO6CD9P4+e=YPdKaLfSBOk-H3_ir64pBP-qMKNNvzUNqunXQ@mail.gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Tue, 14 Jul 2026 18:34:59 -0400
X-Gm-Features: AUfX_myT1PdUubmuBD9PYCObuzJ89Aj3rOb1jpuzCUTEJd0FDhvggQQCCWhYafY
Message-ID: <CALnO6CB1vJ7RtBzTUSJSfYtfH+W2MZCFEkqNWeBXbWJ2r3Pdyg@mail.gmail.com>
Subject: Re: [PATCH] completion: zsh: support completion after "git -C <path>"
To: Lutz Lengemann via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Lutz Lengemann <lutz@lengemann.net>, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lutz,

On Thu, Jun 18, 2026 at 1:43=E2=80=AFPM D. Ben Knoble <ben.knoble@gmail.com=
> wrote:
>
> [apologies in advance for the strange format below]
>
> On Wed, Jun 17, 2026 at 11:37=E2=80=AFAM Lutz Lengemann via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> >
> > From: Lutz Lengemann <lutz@lengemann.net>
> >
> > The zsh completion wrapper (__git_zsh_main) did not handle the global -=
C
> > option, so "git -C <path> <command> <TAB>" offered nothing and could no=
t
> > complete a command's arguments.
> >
> > Three things are needed to make it work, all scoped to -C:
> >
> >   - Add -C to the _arguments specification, so completion no longer sto=
ps
> >     at it.
> >
> >   - Advance __git_cmd_idx past any leading "-C <path>" options. The ind=
ex
> >     is hard-coded to 1, i.e. the command is assumed to be the first
> >     argument; with -C present the command sits two words later for each
> >     -C, so the bash helpers otherwise look at the wrong word and produc=
e
> >     nothing.
> >
> >   - Collect the -C paths into __git_C_args, as __git_main does. The bas=
h
> >     helpers run git to resolve aliases and list refs; without the -C
> >     paths they run in the current directory, so completion fails whenev=
er
> >     the cwd is not the target repository or the command is an alias.
> >
> > With these, "git -C <path> <command> <TAB>" completes the command, its
> > options and its arguments, including outside the repository, through
> > aliases, and with repeated -C options.
> >
> > Signed-off-by: Lutz Lengemann <lutz@lengemann.net>
> > ---
> >     completion: zsh: support completion after "git -C "
> >
> >     This patch is intentionally scoped to -C, but the underlying proble=
m is
> >     more general. The zsh wrapper hard-codes __git_cmd_idx=3D1, i.e. it
> >     assumes the command is always the first argument. That assumption b=
reaks
> >     argument completion after any global option that precedes the comma=
nd,
> >     not just -C =E2=80=94 e.g. --git-dir, --work-tree, --namespace, -c,=
 and
> >     -p/--paginate. After those, git <opt> <command> <TAB> currently
> >     completes the command name but not its arguments.
> >
> >     The same approach generalizes cleanly: instead of skipping only lea=
ding
> >     -C options, walk all leading global options and their arguments to
> >     locate the command and its true index (mirroring the option scan in
> >     __git_main in git-completion.bash), while collecting -C into
> >     __git_C_args and --git-dir into __git_dir as today.
> >
> >     I kept this revision narrow for reviewability and because git -C is=
 the
> >     case where I miss the completion, but I'm happy to extend it to cov=
er
> >     the other global options in a follow-up (or fold it into this patch=
) if
> >     that's preferred.
>
> See Junio's review for whether we should expand in this patch or a follow=
-up.
>
> In reply to Junio:
>
> > [the new handling only knows about -C]
> > Doesn't it want to do something similar to what __git_main in
> > git-completion.bash does at the beginning, namely, this part?
>
> Yeah, we probably do want to skip over -c, etc. (I see some support for
> --bare and --git-dir, but not skipping over it.) Still, this patch makes
> things no worse in that regard, and improves the situation for -C
> AFAICT.
>
> In reply to Lutz:
>
> > +        local -a __git_C_args
> > +        local -i i=3D2
> > +
> > +        while [[ ${orig_words[i]} =3D=3D -C ]]; do
> > +            __git_C_args+=3D(-C ${orig_words[i+1]})
> > +            (( __git_cmd_idx +=3D 2 ))
> > +            (( i +=3D 2 ))
> > +        done
>
> I don't see either of these 2 local variables used anywhere else=E2=80=A6
>
> =E2=80=A6well, except the Bash completion helpers, I suppose. But we mark=
 these
> local, so how do they propagate to the other functions?
>
> Still, I was able to try this out with the somewhat hacky
>
>     zsh # new shell :)
>     # absolute path important
>     autoload -Uz $PWD/contrib/completion/git-completion.zsh
>     compdef git-completion.zsh git
>
>     git -C <tab>
>
> and it does prioritize directories there (though I still get a listing
> of files afterwards, so the screen is taken up by that gigantic listing
> in git.git, for example).
>
> By the way, I've realized that "git -<tab>" has the same problem (a
> giant list of files after the other option completions), and worse has
> some _funky_ output!
>
>     git -<tab> # without patch
>     (option)
>     --bare
>     --exec-path
>     --git-dir
>     --help
>     --html-path
>     --info-path
>     --man-path
>     --namespace
>     --no-pager
>     --no-replace-objects
>     --paginate
>     --version
>     --work-tree
>
>     -p
>
>     # treat the repository as a bare repository
>     # path to where your core git programs are installed
>     # set the path to the repository
>     # prints the synopsis and a list of the most commonly used commands
>     # print the path where gits HTML documentation is installed
>     # print the path where the Info files are installed
>     # print the manpath (see `man(1)`) for the man pages
>     # set the git namespace
>     # do not pipe git output into a pager
>     # do not use replacement refs to replace git objects
>     # pipe all output into less
>     # prints the git suite version
>     # set the path to the working tree
>     [ed: the above block repeats twice more before the (file) listing bel=
ow]
>     (file)
>     [=E2=80=A6]
>
> Here's the output of _complete_help (^Xh by default) in both situations,
> in case that helps to understand either the extra files listing (1) in
> the example further back or the issue with single letter options (2)
> just mentioned:
>
> 1: tags in context :completion::complete:git::
>     option-C-1     (_arguments __git_zsh_main _git git-completion.zsh)
>     use-compctl    (_default _git git-completion.zsh)
>     globbed-files  (_files _default _git git-completion.zsh)
> tags in context :completion::complete:git:option-C-1:
>     directories    (_directories _arguments __git_zsh_main _git
> git-completion.zsh)
>     globbed-files  (_files _directories _arguments __git_zsh_main _git
> git-completion.zsh)
>     all-files      (_files _directories _arguments __git_zsh_main _git
> git-completion.zsh)
>
> 2: tags in context :completion::complete:git::
>     argument-1 options  (_arguments __git_zsh_main _git)
>     use-compctl         (_default _git)
>     globbed-files       (_files _default _git)
> tags in context :completion::complete:git:argument-1:
>     common-commands alias-commands all-commands  (__git_zsh_main _git)
>     common-commands                              (__git_zsh_cmd_common
> __git_zsh_main _git)
>     alias-commands                               (__git_zsh_cmd_alias
> __git_zsh_main _git)
>     all-commands                                 (__git_zsh_cmd_all
> __git_zsh_main _git)
> tags in context :completion::complete:git:options:
>     options  (_arguments __git_zsh_main _git)
>
> > +        '*-C[run as if git was started in <path>]: :_directories' \
>
> We should probably note in the log message that the _directories
> completion will not account for previous -C; that is, after typing
>
>     git -C dir -C <tab>
>
> we will complete directories in ".", not "dir". That's probably a
> reasonable limitation for now, but I think we could do _slightly_ better
> by using a state "->dir" or something, accumulating the current prefix,
> and passing that to _directories as a prefix with -W (see _path_files in
> zshcompsys, which _directories delegates to via _files, IIUC).
>
> --
> D. Ben Knoble

Any progress here? I just found my local copy of this patch and was
briefly surprised to see it hadn't graduated anywhere (until I
realized conversation had stalled at this point).

--=20
D. Ben Knoble
