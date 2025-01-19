Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A6C19A298
	for <git@vger.kernel.org>; Sun, 19 Jan 2025 22:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737325820; cv=none; b=YHJVtlr/D0EVsvs/Pu1vXsrGc2/HZaSGyG6TE9MdeXQw3HoOf9k1xfJqSDcowWJ93+NrtUipbCTxFFWqRpXKaT2rcuSsLkKAdePjh3qLvqGGJ1cuMlYNIoPBL990Y02vrY9A5P6p9r/fAjsoqB51kBCU3cl6y/S4l9jX473MpRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737325820; c=relaxed/simple;
	bh=RrZC6VjAdoXQb2R52WkjnGuWBJmlDFlw7BPTWZUVMJE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pX0tJnga7tlHBSHSNNups3uZpYPnjzaHu3sIIwS/cVSMAfHXCTvdtjn7K7nJrH2VWzGSu8wudAlA39Dmy8NQuRM5Qo5hLpb0HIaEECXRFPn8LNr82bUTTZI3sU2HW5MLs1u1BsWbzcEPTpTpFQQlyg9UQ0EyGTQ9zvuUsf5huFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7b6f534bf40so25683085a.3
        for <git@vger.kernel.org>; Sun, 19 Jan 2025 14:30:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737325817; x=1737930617;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UIsAb/L4G40JRi/6FeSP4wcaN+0oHl0vLoKswWIe7jw=;
        b=VFhiToc7X/wPJ2feKWVKfPh0rPJvHlzffgSDQ3XJ3q/phoZxigIO3mh0Jr2YJIk7oA
         iCz6fb+LqDZl/tlvE3q0D0UfguasR9fb+x4/bq0K9WE7Li/OSMSY2KpCj1cYDKt1onlk
         HavUeqDwvDl+WX5eourWnHglaz0ZY3epG27pHP1v2JwlTWqy4/a2j3Z3v7pB8LNzscOf
         +q4D1TwIWjzBYbPuVbICLCynMV4hiWmFB0GJhNDup8l/+pXSj6Ms8lCV710JfuS55woW
         Oz9CwcLh2XrXeezs/OBh3JAPh4qfuyVfGir49qDucczyYrk4bKo29ECBprBDet5/r2ip
         PRTg==
X-Gm-Message-State: AOJu0Yziw8lNwxN00eum4USIzUXLvFgX+SRMp3cgq0gxOnTh12E9IJrX
	TUZaow5kJiq68uUr7JW3GTgQ58TrDPnLZ8U8oK/frtJ4m8EXD6L5uZUysXZGRyiW3xaQaP6GVB9
	Q5U1MCEH6qP0OIO3PNeIPjr/K878=
X-Gm-Gg: ASbGncsQ3vB1Ac8bxYiH61GADfqvbQNxf/PUxv/kWDXGghbP1xGdlrK68KbOhXl5B4W
	pGH5+80HDlu2Zq8sMsWZe349x1nejZuEGZCB2rMZaWPGUelhKFA==
X-Google-Smtp-Source: AGHT+IEG05rK6dx7f4489XZOUspDIf/RwnrT0oXBxBia4VbnQvp722KJYDBVQozjtR1+3ECmPHtajOvyc1hfqgmAOlM=
X-Received: by 2002:a05:6214:d84:b0:6e1:688c:73db with SMTP id
 6a1803df08f44-6e1b21f4c4dmr62542666d6.8.1737325816731; Sun, 19 Jan 2025
 14:30:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1829.git.1731653548549.gitgitgadget@gmail.com> <pull.1829.v2.git.1737063335673.gitgitgadget@gmail.com>
In-Reply-To: <pull.1829.v2.git.1737063335673.gitgitgadget@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sun, 19 Jan 2025 17:30:05 -0500
X-Gm-Features: AbW1kvZtEdbEaye_h5UrsqehbKSiTR9TSRQv52yESndiMCh9tNyKQ95ufGqyZSY
Message-ID: <CAPig+cRpKKpVHT8x6nOx1KNjWR=hywz-nHZga9fhiXMXD7KOSw@mail.gmail.com>
Subject: Re: [PATCH v2] worktree: detect from secondary worktree if main
 worktree is bare
To: Olga Pilipenco via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, 
	Junio C Hamano <gitster@pobox.com>, Olga Pilipenco <olga.pilipenco@shopify.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 16, 2025 at 4:35=E2=80=AFPM Olga Pilipenco via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> Setup:
> 1. Have a bare repo with core.bare =3D true in config.worktree
> 2. Create a new worktree
>
> Behavior:
> From the secondary worktree the main worktree appears as non-bare.
>
> Expected:
> From the secondary worktree the main worktree should appear as bare.
>
> Why current behavior is not good?
> If the main worktree is detected as not bare it doesn't allow
> checking out the branch of the main worktree. There are possibly
> other problems associated with that behavior.
>
> Why is it happening?
> While we're inside the secondary worktree we don't initialize the main
> worktree's repository with its configuration.

Okay, this is clearly a very real problem and explains this comment
added by f3534c98e4 (worktree: update is_bare heuristics, 2019-04-19):

    NEEDSWORK: If this function is called from a secondary worktree and
    config.worktree is present, is_bare_repository_cfg will reflect the
    contents of config.worktree, not the contents of the main worktree.
    This means that worktree->is_bare may be set to 0 even if the main
    worktree is configured to be bare.

(Aside: I recall reading this comment when Jonathan added it but
wasn't able to dig into it at the time to really understand it, and
never got back around to it. Now, after studying your patch, I
understand what it was about.

> How is it fixed?
> Load actual configs of the main worktree. Also, skip the config loading
> step if we're already inside the current worktree because in that case we
> rely on is_bare_repository() to return the correct result.

I found that I had to dig around a bit to fully understand the problem
expressed by this commit message. Perhaps adding a bit more detail
would help? Here's my attempt at rewriting the above (also in a way
which is more idiomatic to this project):

    When extensions.worktreeConfig is true and the main worktree is
    bare -- that is, its config.worktree file contains core.bare=3Dtrue
    -- commands run from secondary worktrees incorrectly see the main
    worktree as not bare. As such, those commands incorrectly think
    that the repository's default branch (typically "main" or
    "master") is checked out in the bare repository even though it's
    not. This makes it impossible, for instance, to checkout or delete
    the default branch from a secondary worktree, among other
    shortcomings.

    This problem occurs because, when extensions.worktreeConfig is
    true, commands run in secondary worktrees only consult
    $commondir/config and $commondir/worktrees/<id>/config.worktree,
    thus they never see the main worktree's core.bare=3Dtrue setting in
    $commondir/config.worktree.

    Fix this problem by consulting the main worktree's config.worktree
    file when checking whether it is bare. (This extra work is
    performed only when running from a secondary worktree.)

> Other solutions considered:
> Alternatively, instead of incorrectly always using
> `the_repository` as the main worktree's repository, we can detect
> and load the actual repository of the main worktree and then use
> that repository's `is_bare` value extracted from correct configs.
> However, this approach is a bit riskier and could also affect
> performance. Since we had the assignment `worktree->repo =3D
> the_repository` for a long time already, I decided it's safe to
> keep it as it is for now; it can be still fixed separately from
> this change.

I found this paragraph somewhat confusing because it seems to conflate
a repository (i.e. the shared object database) with the `struct
repository` type, and the configuration which happens to get loaded
and stored (as one of *many* members) of the repository structure. I
had to read it several times to understand that this was talking about
instantiating a separate `struct repository` initialized from the main
worktree configuration. I agree that doing so would likely be overkill
and could impact performance negatively. I understand that you added
this paragraph because SubmittingPatches suggests to do so, but I
think it can probably be omitted in this case unless it can be
rewritten to be more clear (but even then I doubt it is necessary to
keep it).

> Real life use case:
> 1. Have a bare repo
> 2. Create a worktree from the bare repo
> 3. In the secondary worktree enable sparse-checkout - this enables
> extensions.worktreeConfig and keeps core.bare=3Dtrue setting in
> config.worktree of the bare worktree
> 4. The secondary worktree or any other non-bare worktree created
> won't be able to use branch main (not even once), but it should be
> able to.

This is mostly repeating what was said earlier, thus probably isn't
adding any value to the commit message. I'd probably drop it.

> Signed-off-by: Olga Pilipenco <olga.pilipenco@shopify.com>
> ---
>     Changes since v1:
>
>      * no code changes
>      * rebased with maint
>      * CC added

Sorry. I've had your v1 sitting in my ever-increasingly-large backlog
of patches to look at, but have been extra busy the last many months
and never managed to get to it.

>     Existing broken functionality forces our project to use hacks on bare
>     repo that we'd like to avoid. I would really appreciate reviews of th=
is
>     patch to move closer towards fixing the issue. This is my first
>     contribution to git/git, I apologize if I got lost in the instruction=
s,
>     but I tried my best to follow the rules.

Your submission is fine. Unfortunately, the project has a lack of
reviewers but no lack of submitters, so sometimes patches get
overlooked or simply buried.

> diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
> @@ -410,6 +410,20 @@ test_expect_success 'bare main worktree has HEAD at =
branch deleted by secondary
> +test_expect_success 'secondary worktree can switch to main if common dir=
 is bare worktree' '

The use of "common dir" is a bit confusing. Also, this patch is fixing
the more general problem that secondary worktrees think that the bare
main worktree has a branch checked out. So, perhaps a better title
would be:

    secondary worktrees recognize core.bare=3Dtrue in main config.worktree

or something?

> +       test_when_finished "rm -rf bare_repo non_bare_repo secondary_work=
tree" &&
> +       git init -b main non_bare_repo &&
> +       test_commit -C non_bare_repo x &&
> +
> +       git clone --bare non_bare_repo bare_repo &&
> +       git -C bare_repo config extensions.worktreeConfig true &&
> +       git -C bare_repo config unset core.bare &&
> +       git -C bare_repo config --worktree core.bare true &&
> +
> +       git -C bare_repo worktree add ../secondary_worktree &&
> +       git -C secondary_worktree checkout main
> +'

Very straightforward and exactly what I expected to see once I
understood the problem.

> diff --git a/worktree.c b/worktree.c
> @@ -65,6 +65,28 @@ static int is_current_worktree(struct worktree *wt)
> +static int is_bare_git_dir(const char *git_dir)

Nit: I wonder if a name such as is_main_worktree_bare() would clue
readers in a bit more?

> +{
> +       int bare =3D 0;
> +       struct config_set cs =3D { { 0 } };

This is not your fault since this construct is used elsewhere in this
file (from which I presume you copied it), but project consensus is
that using the notation `{{0}}` to work around a complaint from the
Apple compiler (and only the Apple compiler) should be avoided, and
that `{0}` is preferred. So, if you reroll, changing this to `{0}` may
make other reviewers happy (or you can leave it as is to be consistent
with existing precedence in this file; I don't feel strongly about
it).

> +       char *config_file;
> +       char *worktree_config_file;
> +
> +       config_file =3D xstrfmt("%s/config", git_dir);
> +       worktree_config_file =3D xstrfmt("%s/config.worktree",  git_dir);
> +
> +       git_configset_init(&cs);
> +       git_configset_add_file(&cs, config_file);
> +       git_configset_add_file(&cs, worktree_config_file);

Genuine question: I haven't thought too deeply about it, but do we
gain anything by loading $commondir/config here -- which is shared by
the main worktree and all secondary worktrees -- considering that it
was already loaded and consulted by the earlier is-bare check before
this function was even called?

> +       git_configset_get_bool(&cs, "core.bare", &bare);
> +
> +       git_configset_clear(&cs);
> +       free(config_file);
> +       free(worktree_config_file);
> +       return bare;

Everything gets cleaned up correctly. Good.

> @@ -77,18 +99,16 @@ static struct worktree *get_main_worktree(int skip_re=
ading_head)
> +       /*
> +        * NEEDSWORK: the_repository is not always main worktree's reposi=
tory
> +       */
>         worktree->repo =3D the_repository;
>         worktree->path =3D strbuf_detach(&worktree_path, NULL);

I found this new NEEDSWORK comment rather confusing the first several
times I read the patch. It wasn't until I finally realized that the
reference to `the_repository` here is the same reference to
`the_repository` in the commit message -- which confused me, as well
-- that I understood what this was trying to say. The actual problem,
of course, is that the _configuration_ stored in `the_repository` is
the secondary worktree's configuration, not the main worktree's
configuration. Considering that this patch addresses that problem, I'd
probably just drop this new comment altogether (unless, perhaps, you
rewrite it to talk about the _configuration_ stored in
`the_repository`).

> -       /*
> -        * NEEDSWORK: If this function is called from a secondary worktre=
e and
> -        * config.worktree is present, is_bare_repository_cfg will reflec=
t the
> -        * contents of config.worktree, not the contents of the main work=
tree.
> -        * This means that worktree->is_bare may be set to 0 even if the =
main
> -        * worktree is configured to be bare.
> -        */
> -       worktree->is_bare =3D (is_bare_repository_cfg =3D=3D 1) ||
> -               is_bare_repository();
>         worktree->is_current =3D is_current_worktree(worktree);
> +       worktree->is_bare =3D (is_bare_repository_cfg =3D=3D 1) ||
> +               is_bare_repository() ||
> +               (!worktree->is_current && is_bare_git_dir(repo_get_common=
_dir(the_repository)));

This is performing the expensive check only if the earlier checks left
the question unanswered. Good.
