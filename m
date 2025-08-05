Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E92F230BFF
	for <git@vger.kernel.org>; Tue,  5 Aug 2025 21:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754429558; cv=none; b=TFK/s1GZs71zkOluBwhapRufYYzsJRd/E+Lyri0YCEUdKGgQedFhK6vvblcAdwr3nXgutKMwxgXIOknP69UbFZtrC5+dNn1vq5d+Nuvqyf39rDePCZLVegehUT63DQb6SpApnUxvS/elCo63Y27EnnZhZa9FvrGNMpR29FrqBbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754429558; c=relaxed/simple;
	bh=9BQ6rppYtUkHjwYEoahd30toyNSTz8qGWZhDEF+HHTc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fstekKMT9rlLM1Kxqe1CRT1UYc17PbfYPv+Tla07G74/KJzfHW7bMqeMokd22H3BBP3L81yAqpM7qvKvyb2PItOy/ulTHCIBiwdprlBTo3m/0E6kOU4m2p5aNBStyB8g6ctJvavXyMFmQGL6rTirWb2vohlYxnllAprAyxIcC5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WV6M04tl; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WV6M04tl"
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3e4063e731eso20039675ab.3
        for <git@vger.kernel.org>; Tue, 05 Aug 2025 14:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754429554; x=1755034354; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=22T2mosF4yY3OUxxefpKMWdEeWqeDInDmSn44LP1fFE=;
        b=WV6M04tlbHCmQV3HTpBaX4D65Hgz5NilMDeds5Z19ZkkWV1eN3Clqt2sKGnDTuo9j/
         rSEO3Pn6o2TPUNGJyrZ3k3Jj0sJrPbz7RYsJFezOdj/8miNmMcErhdSrJwg0ApKeXhq6
         2qP4nVhqbBp0EtXQmOSVg4Whw05nDpRzKsqnq2TmIMv4hM+MsZrp6nV0hhXlje2sPr+t
         L/CGB2AWBOvso+o6aKbxWwDToCzBoiGBppZv4nZpkHvMtE3fisHB5QPe3Oa888niIN34
         sX9SoXOblr6+JNIWX4mJ9l1dRptEYUZyYS3QnZiWeNxYm43JsTdMoHWmCNjsVQQ7T3q5
         Dx1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754429554; x=1755034354;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=22T2mosF4yY3OUxxefpKMWdEeWqeDInDmSn44LP1fFE=;
        b=Tr5KufGOQXuxBRd7qcu/V3FsuWVCLxMQStNaz1Cz0cZQ0A73Azvkibxg2Vx3FQd7Iu
         xnBmWbZmzr8LVZ+KasugdhO97679Lgtnyhq3iNFadgsWNQw7jSfO7agsfvScievkLg2h
         mFAvU+l+/ETHh0TXSSSnItS+atE5JGlxSxucms17VI3lLDRgbnDPAjA0ppmQkIbPPwFB
         oYyS46yd6OL3UmDWVQtdK79BOTkD01qxKz/JZPCmpqiesQXCrBO9tKG3myvpQ5WNwCKL
         rKWWkx4d66NhiaYpCCxp/zGMBkyP4L1ypBhirX6DTAjiHgURG7FN+rcIgBUv1XVbfa1m
         uR1Q==
X-Gm-Message-State: AOJu0YwiFM/f0Zn+W78ICPdQNGctKcgAgKOX8jg59mn5hE11mqC5sdzA
	TfE0M6Z0P+Qznw72dC7qa6+fVE9nj+dg/fbw63BfedBQ8MTljSCeSvtliJ6/AH+v0+iCCswzMiU
	sfikXiMLkWhFlpYO0gp88kjyxNgulaXg=
X-Gm-Gg: ASbGncsgdTksjyBcP7Kn1P7UxAl8JHHkxYVuXajrooJfhZLauG/d+KdTnNc3efbO0DZ
	0WEckLYv/FPHNzXkOleuyNV7/R7fKjPAJfW3e7ARvRabxiEFilUrJSsF8bLGJnWGR0ZSGHLLkDg
	3OIUJTlK9QPAavY7hO8CNJKoFuD8tE7PpbLJ2KYfHpMzPwC+5+0Au/HP8p90MlU59UEYrFYkKxE
	0Aq1LDDSpAjN+l2UMjvSPOL6vYIT8SnjUtwtSTR
X-Google-Smtp-Source: AGHT+IGnVg5UhvNkejWtFVvqBC9EMHs+hheJufm5l5bLsIFqoCLhyddskQebUgdnoF/Kx9ty9xvJd8AZz0npJVHEkRc=
X-Received: by 2002:a05:6e02:2486:b0:3e2:9aea:8049 with SMTP id
 e9e14a558f8ab-3e51b8fe031mr2880395ab.13.1754429553598; Tue, 05 Aug 2025
 14:32:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1941.git.1751973594.gitgitgadget@gmail.com>
 <pull.1941.v2.git.1752716054.gitgitgadget@gmail.com> <7e8f7c2d6c8c740d42bc6d157fa491b558b9ff6a.1752716054.git.gitgitgadget@gmail.com>
In-Reply-To: <7e8f7c2d6c8c740d42bc6d157fa491b558b9ff6a.1752716054.git.gitgitgadget@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 5 Aug 2025 14:32:22 -0700
X-Gm-Features: Ac12FXwOdSkg4URiUEnXzj5WsZQovdgSLde1kMs2n42k9nc8focrdrQ2EpMSsW8
Message-ID: <CABPp-BFzMLGJwz4QqYtvw3zRYgmC=Mb8T8GCOsrLZqT2z+8H7A@mail.gmail.com>
Subject: Re: [PATCH v2 2/8] sparse-checkout: add basics of 'clean' command
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, Patrick Steinhardt <ps@pks.im>, 
	Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 6:34=E2=80=AFPM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:

Sorry for the long delay in responding...

[...]
> Add a new subcommand to 'git sparse-checkout' that removes these
> tracked-but-sparse directories. This necessarily removes all files
> contained within, including tracked and untracked files. Of particular

Nice to see tracked files also being addressed in v2.

> importance are ignored and excluded files which would normally be
> ignored even by 'git clean -f' unless the '-x' or '-X' option is
> provided. This is the most extreme method for doing this, but it works
> when the sparse-checkout is in cone mode and is expected to rescope
> based on directories, not files.
>
> The current implementation always deletes these sparse directories
> without warning. This is unacceptable for a released version, but those
> features will be added in changes coming immediately after this one.
>
> Note that untracked directories within the sparse-checkout remain.

You've changed the wording here relative to v1, but you haven't
addressed the part that was ambiguous/misleading in v1.  In fact, you
may have made a different part ambiguous as well, and made readers
think that this sentence contradicts your above claims that this
command is meant to clean out untracked directories underneath sparse
directories.  Perhaps something like:

"Note that untracked directories in the sparse-checkout that are not
within sparse directories will not be removed by this command; it only
cleans up paths under directories that are supposed to be sparse."

> Further, directories that contain staged changes or files in merge
> conflict states are not deleted.

Doesn't this sentence conflict with your above statement that "This
necessarily removes all files contained within, including tracked and
untracked files."?

> This is a detail that is partly hidden
> by the implementation which relies on collapsing the index to a sparse
> index in-memory and only deleting directories that are listed as sparse
> in the index.
>
> If a staged change exists, then that entry is not stored as a sparse
> tree entry and thus remains on-disk until committed or reset.

This seems a bit surprising -- if a file's modifications are staged,
then you can use it and other files in the index to write new trees
all the way up to the toplevel, so you should be able to get a sparse
tree entry without problem.  I'd only expect problems if you had
unstaged changes, or higher order stages; perhaps you could clarify
here?

> There are some interesting cases around merge conflict resolution, but
> that will be carefully analyzed in the future.

...okay, so you did clarify for the higher order stages, but I'm still
confused about staged vs unstaged without conflicts.

>
> Signed-off-by: Derrick Stolee <stolee@gmail.com>
> ---
>  Documentation/git-sparse-checkout.adoc | 11 ++++-
>  builtin/sparse-checkout.c              | 64 +++++++++++++++++++++++++-
>  t/t1091-sparse-checkout-builtin.sh     | 38 +++++++++++++++
>  3 files changed, 111 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-sparse-checkout.adoc b/Documentation/git-s=
parse-checkout.adoc
> index 529a8edd9c1e..6db88f00781d 100644
> --- a/Documentation/git-sparse-checkout.adoc
> +++ b/Documentation/git-sparse-checkout.adoc
> @@ -9,7 +9,7 @@ git-sparse-checkout - Reduce your working tree to a subse=
t of tracked files
>  SYNOPSIS
>  --------
>  [verse]
> -'git sparse-checkout' (init | list | set | add | reapply | disable | che=
ck-rules) [<options>]
> +'git sparse-checkout' (init | list | set | add | reapply | disable | che=
ck-rules | clean) [<options>]
>
>
>  DESCRIPTION
> @@ -111,6 +111,15 @@ flags, with the same meaning as the flags from the `=
set` command, in order
>  to change which sparsity mode you are using without needing to also resp=
ecify
>  all sparsity paths.
>
> +'clean'::
> +       Remove all files in tracked directories that are outside of the
> +       sparse-checkout definition. This subcommand requires cone-mode

So, this sentence implies that it'll wipe out all untracked or ignored
files or tracked files with either unstaged, staged, or conflicted
entries.  Your commit message says it'll discuss conflicted entries
later, but conflicts about whether staged or unstaged changes will be
wiped.

> +       sparse-checkout to be sure that we know which directories are
> +       both tracked and all contained paths are not in the sparse-checko=
ut.
> +       This command can be used to be sure the sparse index works
> +       efficiently, though it does not require enabling the sparse index

[...]
> diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
[...]
> +       if (convert_to_sparse(repo->index, SPARSE_INDEX_MEMORY_ONLY) ||
> +           repo->index->sparse_index =3D=3D INDEX_EXPANDED)
> +               die(_("failed to convert index to a sparse index; resolve=
 merge conflicts and try again"));

In the commit message, though, you said that it'd also fail to convert
a tree with a staged change to a sparse directory.  And I thought in
our discussion on v1 we found out that unstaged changes would prevent
converting to sparse.  Shouldn't the error message be more general,
then?

[...]
> diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout=
-builtin.sh
> index ab3a105ffff2..a48eedf766d2 100755
> --- a/t/t1091-sparse-checkout-builtin.sh
> +++ b/t/t1091-sparse-checkout-builtin.sh
> @@ -1050,5 +1050,43 @@ test_expect_success 'check-rules null termination'=
 '
>         test_cmp expect actual
>  '
>
> +test_expect_success 'clean' '
> +       git -C repo sparse-checkout set --cone deep/deeper1 &&
> +       mkdir repo/deep/deeper2 repo/folder1 &&
> +       touch repo/deep/deeper2/file &&
> +       touch repo/folder1/file &&
> +
> +       cat >expect <<-\EOF &&
> +       Removing deep/deeper2/
> +       Removing folder1/
> +       EOF
> +
> +       git -C repo sparse-checkout clean >out &&
> +       test_cmp expect out &&
> +
> +       test_path_is_missing repo/deep/deeper2 &&
> +       test_path_is_missing repo/folder1
> +'
> +
> +test_expect_success 'clean with staged sparse change' '
> +       git -C repo sparse-checkout set --cone deep/deeper1 &&
> +       mkdir repo/deep/deeper2 repo/folder1 repo/folder2 &&
> +       touch repo/deep/deeper2/file &&
> +       touch repo/folder1/file &&
> +       echo dirty >repo/folder2/a &&
> +
> +       git -C repo add --sparse folder1/file &&
> +
> +       # deletes deep/deeper2/ but leaves folder1/ and folder2/
> +       cat >expect <<-\EOF &&
> +       Removing deep/deeper2/
> +       EOF
> +
> +       git -C repo sparse-checkout clean >out &&
> +       test_cmp expect out &&
> +
> +       test_path_is_missing repo/deep/deeper2 &&
> +       test_path_exists repo/folder1

What about repo/folder2/ ?

Anyway, this test shows that neither staged nor unstaged changes are
cleaned up (which at least resolves the conflicting documentation you
provided on the matter) -- or would if you also checked repo/folder2.

What it doesn't show is that tracked files with neither staged nor
unstaged changes are not cleaned up either:

$ mkdir repo/folder2
$ echo dirty >repo/folder2/a
$ touch repo/folder2/untracked
$ cd repo
$ git status --porcelain
 M folder2/a
?? folder2/untracked

# So, we have both a unstaged change and an untracked file; let's undo
the unstaged change

$ git checkout HEAD folder2/a
Updated 1 path from 8cc814f
$ git status --porcelain
?? folder2/untracked
$ ls folder2/
a  untracked

# Both files are still present -- the untracked file, and the
untracked file with no changes either staged or unstaged -- what does
`git sparse-checkout clean` do?

$ git sparse-checkout clean
$ ls folder2/
a  untracked
$ git status --porcelain
?? folder2/untracked

# Absolutely nothing.  Not only does it not clean anything up, it
gives no warnings about not cleaning up what should be cleaned up.
Let's try sparse-checkout reapply:

$ git sparse-checkout reapply
warning: directory 'folder2/' contains untracked files, but is not in
the sparse-checkout cone
$ git status --porcelain
?? folder2/untracked
$ ls folder2/
untracked

# So `sparse-checkout reapply` does correctly remove folder2/a for us,
while warning about the untracked file.  (If folder2/a would have
still had changes, it would have warned about it instead of
removing.).  Let's try `sparse-checkout clean` now...

$ git sparse-checkout clean
Removing folder2/
$ git status --porcelain
$ ls folder2/
ls: cannot access 'folder2/': No such file or directory
$

I think these cases either need to be a new testcase or part of this
last testcase, and the commit message and documentation should be
clearer about tracked-and-staged, tracked-with-unstaged-changes, and
tracked-with-no-changes files...or at least comment that they'll be
discussed later in the patch series.  (I have a feeling I just did a
lot of work to discover as I read your next patches that you cover
these later...)
