Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B3136F409
	for <git@vger.kernel.org>; Thu,  5 Feb 2026 08:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770281542; cv=pass; b=T6I89TXuKKTiVY2FLXQ6K270F28WuYBDul/wEYh8MYQlJ1ajELGMcmIcMFR/sXSLVodt1ZLJ27Z5T+OvyRG8MuIk7p8lXNrvtyLyzbM2s+JKLBWErO9UzIDS3tnCrzAG8k0Lina3nFTzccpwzrH3o5HQq9aaZHoMvMZ+UmUSY4M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770281542; c=relaxed/simple;
	bh=YMtlzA1H+1O7R6DgvpkcsEAg2ESDKLXpF6X3adQbZaw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aFOZvP9GWZb5OWyBKIpTA+2KDyAOIQVGMGhREOm7HjfV2NNUzVaCymTLIMsbwXUdOb34bNxEu8zLU9hHg/GLYs1tyLN9ywrq61DzelST1kSBiuBb1KM0dcuQhsr9cT+2QS9LDiiaVekxfaBVJRx8l8mY8FZ2TWZcLSCS8i26Em8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=eficode.com; spf=pass smtp.mailfrom=eficode.com; dkim=pass (2048-bit key) header.d=eficode.com header.i=@eficode.com header.b=OZvF2Y7e; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=eficode.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eficode.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=eficode.com header.i=@eficode.com header.b="OZvF2Y7e"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-64b92abe63aso1399228a12.0
        for <git@vger.kernel.org>; Thu, 05 Feb 2026 00:52:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770281539; cv=none;
        d=google.com; s=arc-20240605;
        b=bYubdFlzJZ2KyI8lA7LgZvVByIychsmjymmrqXKPlCpDPcIR9oAljde3VTduPsApcy
         PeYL3FnW1Pm3LnbGGYA82fOwxW2SNXMVZ3x/5vCKGfEcgoKyeitlRduMScLlt/3pbT8P
         s27qg7PWPes3GxvsUgjosgNCaHUals6Nf2ZSTt487NwDZbwV7O7Dcs1A0KvlOtvIicvs
         GAleGyLYXX3FcPtmGRa92jiBi01JbhIGXsIY172D5hN6mwJxnYQuhAux/Ek9KrRDMtNu
         MFrea+SnYyyyrObrgJR+yMRmXyOBwX/7lxklggtriKt5Q+D4kP+xFrA83Xy2KjwOq8r8
         BhLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jEJ6HgVuYrDDvPjLbugoJijHv2aEqvSCK7a4HRNeB3E=;
        fh=JW4zn3bT3zd8M40B1KNOZ0nYsbS46Y7jtdgoWcfrYn4=;
        b=EanGlewWup25wuE7BNDIJuMGk76uqnGsHXOHVVAoUpOOMCBeja9PfDA/vy4QEaei7k
         s0Ebv2kWIQHOQr+QXe4fPbNDDlTyn5+sp/Wyp7rMiMEUcgUHnm3lqvsODgT72Oj5E1xi
         oPDwLdSKgO69fxnIFPI9Oxishu9jyylMDmX3t8TFJsoUgaMsOHVgpI+W9KKNQEGDWdhh
         cpyppYFZ/+aoX/F8v1PD7Vv8JMoh+PNFwRJn33HbabxihvqcXWqrUmsX+EzDY01LiIw8
         AXe6rTpEJ6SJitZ0fRCEdfFEIhUyyr/DOl6lILACvJKrpG9McMKaOz/2NcxNYB1+EewL
         mIiA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eficode.com; s=google; t=1770281539; x=1770886339; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jEJ6HgVuYrDDvPjLbugoJijHv2aEqvSCK7a4HRNeB3E=;
        b=OZvF2Y7eJXh19IyEbL1UaPxAnlexG+SlAjKXtck7Gof8+FT0hLwXYDcDlND9MuKLUi
         8IFePgXphSkmz4PAD+RcbuixMYogYu4dx9CIGcqBhf6ctBJ1vqof8704sDiUHbqr2kcE
         Wwl9G97dmI9Y6PQiEukhOJ3bS0AmZUkLfsr5KmTRr2utTKTrnSGbVpk7nGN0Z8btjMIZ
         wXLQiCaj9H04GDdx1749WzYLNySOYcUgjSMExlnA4PmGsueHprA709KTt5CzGVNRagus
         Du5Kwyl+lTddSQh1nmHz+/tSCmvxhMrpuo7clIVfu0hP4hOorQt6on0L+pQpp128USJq
         mtPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770281539; x=1770886339;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jEJ6HgVuYrDDvPjLbugoJijHv2aEqvSCK7a4HRNeB3E=;
        b=F4mx45vmDT2zZoHfvVOVImoV65fIbPpjlB3YOBS0AYIomVuiMbtmmtdtHQe188gKJQ
         H78BGn3pEIlO3c9twiwbG4W/CbVM9gnNXah1rZFx4rOeJL72ckLzXU3MepWWuOPUp3F+
         jJgzrYvjOzgezsflvDt/b57r4JCaLy7Y1rAW9YhGa2qEnikb6LRJYX2Aw9R5bo0fiCvW
         6T65EefrBkG0NkKIzBzdMw49Bu5VXEqFZMw685tsyYgS7vHLk4OmkbVgYcj6oFfTMqSO
         ql3PwVllG/NdQ3HefbauzArsM5s0Gqvh8d8OmHfGDJQ78CxK009kH1HNApmZywS6CzgL
         LDAw==
X-Forwarded-Encrypted: i=1; AJvYcCVRvV3KTwD0tYGK0Qb9OvRSKa048GWiCcJc1xLTZcsW0VPqD9N+bdZaZ0v/wIKmMGsemhM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuZl8tC31d59M7kCQQ+ODC9ko18pn4Wr7xABffOzzrW2LtGOtQ
	c5fA+AwHVY+NMpj+UddS5T57uDN6rSFiZoYgSZk3ZRx9EAzrEgT3r7QuqeQWxPHaI4JGTQisEc8
	0ZvLEFA3Ei+/3U5OTsDohJSJgQGxYkpKZ8AGKMUiO
X-Gm-Gg: AZuq6aKI0Fc3VF5AZFs93nWr6+35OgUFDIZcUvOAuVJU9QjIzK/Yq+3Ca1qRiyvrbgr
	7Sq+vO1Fd7KuyQ3EnSqfD4jHMrNhnmDZn9/eGBG5t29b8uxy5A42F8vBGXM7s9g9584laGePJ1P
	gxi1KKDxepLFP8QUEqyJLdXkDuINCVCYGhGFOc28B6v2aUxurQ+u1Y3aPv/LB5/WEfTn7EE3xt9
	ijG0uVOtB3rgw92PKqw2PnrSdNK25JHWAtaFw6BP+Wk0v1geS5S+py639F3Awfze8xMpS3/CDxE
	ixK7MueDSOq39XMS78IV40q6nOlbUAc8QZzOWnK+eJne6Jogb30DZWRq18Lw1+grGHUfd52J2JP
	pJ3ZI
X-Received: by 2002:a05:6402:5207:b0:649:ce39:3bd0 with SMTP id
 4fb4d7f45d1cf-6594a1e92d8mr3633521a12.34.1770281539041; Thu, 05 Feb 2026
 00:52:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1987.git.1760818039.gitgitgadget@gmail.com>
 <pull.1987.v2.git.1763057433.gitgitgadget@gmail.com> <xmqqzf8pln62.fsf@gitster.g>
 <CA+GP4bob2A+GsVUo5vy+Mw0qJHDD5g+pyo2Ka1726ouUuS_=Wg@mail.gmail.com>
In-Reply-To: <CA+GP4bob2A+GsVUo5vy+Mw0qJHDD5g+pyo2Ka1726ouUuS_=Wg@mail.gmail.com>
From: Claus Schneider <claus.schneider@eficode.com>
Date: Thu, 5 Feb 2026 09:51:45 +0100
X-Gm-Features: AZwV_Qg67xxOn_ujcidtjCA9jh-dYn2BKWpchugV9phw3nTcKynvrJaPexlwRac
Message-ID: <CA+GP4brx2CB5giQ+7Duh2yS4qXYEuWmBVrYG9RpZdtE7FOoWKA@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] git-add : Respect submodule ignore=all and only
 add changes with --force
To: Junio C Hamano <gitster@pobox.com>
Cc: Claus Schneider via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

I have implemented the --ignore option. I believe it is done. Please
review it again for integration to 'next'.

Best regards
Claus Schneider

On Fri, Nov 14, 2025 at 2:53=E2=80=AFPM Claus Schneider
<claus.schneider@eficode.com> wrote:
>
> Thanks Junio - well received and noted. I have updated the PR
> description accordingly, but I have not changed the "--force" in the
> description even though I have implemented
> ''--include-ignored-submodules' as Philip had the input not to use
> "--force". He suggested using a new option. Philips comment:
>
> > I'm not convinced that the approach of using "--force" is a good idea a=
s
> > it conflates ignoring changes to tracked paths (which is what
> > submodule.<name>.ignore" does) with ignoring untracked paths (which is
> > what ".gitignore" does). If we're happy to break existing uses that rel=
y
> > on the current behavior then having a new option to override
> > submodule.<name>.ignore strikes me as a better way forward. I don't hav=
e
> > much experience of using submodules so I can't comment on whether
> > changing the behavior is a good idea or not.
>
> I think it will be more simple to use the '--force' option though and
> keep the amount of options lower and less to remember. Given your
> comments about more usages of bytes for option also becomes obsolete
> if we stick to "--force". I am happy to do so.
>
> I am investigating your other comments on the patches in the meantime.
>
> On Thu, Nov 13, 2025 at 8:58=E2=80=AFPM Junio C Hamano <gitster@pobox.com=
> wrote:
> >
> > "Claus Schneider via GitGitGadget" <gitgitgadget@gmail.com> writes:
> >
> > > The feature of configuring a submodule to "ignore=3Dall" is nicely re=
spected
> > > in commands "status" and "diff".
> >
> > "nicely respected" is not very informative for those who do not know
> > what the setting does.  Saying something like
> >
> >     "git status" and "git diff" will not report modified submodules
> >     with submodule.<name>.ignore set to "all".
> >
> > would not waste significantly more bytes than what you wrote, and is
> > more helpful.
> >
> > > However the "add" command does not respect
> > > the configuration the same way.
> >
> > Again, "does not respect" and then what?  Running "git add" on a
> > submodule with submodule.<name>.ignore set to "all" does what?
> > Complains that it has changes but because .ignore is set it won't
> > add?  Adds it silently?  Something else?
> >
> > > The behavior is problematic for the logic
> > > between status/diff and add.
> >
> > After this sentence, "because ..." is missing.  Please help readers
> > understand the issue you perceive as problematic more easily.
> >
> > I am guessing that you are assuming that an "add", after "diff" or
> > "status" said there is no change, is expected to be a no-op, but I
> > cannot be sure if that is what you are referring to here with the
> > reason left unsaid like the above.
> >
> > > Secondly it makes it problematic to track
> > > branches in the submodule configuration as developers unintentionally=
 keeps
> > > add submodule updates and get conflicts for no intentional reason. Bo=
th adds
> > > unnecessary friction to the usage of submodules.
> > >
> > > The patches implement the same logical behavior for ignore=3Dall subm=
odules as
> > > regular ignored files. The status now does not show any diff - nor wi=
ll the
> > > add command update the reference submodule reference. If you add the
> > > submodule path which is ignore=3Dall then you are presented with a me=
ssage
> > > that you need to use the --force option.
> >
> > I vaguely recall that an earlier discussion between you and Phillip
> > were concluding against "--force"?  I personally feel it is in line
> > with "git add foo.o" (when '*.o' is in .gitignore) gets rejected and
> > "git add -f foo.o" is a way to override it, but in the list of
> > patches below, I see --include-ignored-submodules (no, our command
> > line option names do not use underscore for inter-word-gaps), so I
> > suspect the description in the cover letter around here is stale?
> >
> >
> > > The branch=3D, ignore=3Dall (and
> > > update=3Dnone) now works great with update --remote,
> >
> > Again, "great" is not very informative, and as bad as "nicely
> > respected".  Avoid using these adjectives loaded with unnecessary
> > value judgements, and instead trust your readers.  They are
> > intelligent to judge if the updated behaviour is great or not for
> > themselves.  Try to use the same bytes on helping readers understand
> > what actually happens.
> >
> > > but developers does not
> >
> > "do not".
> >
> > > have to consider changes in the updates of the submodule sha1. The
> > > implementation removes a friction of working with submodules and can =
be used
> > > like the repo tool with branches configured. The submodule status rep=
ort
> > > could be used for build/release documentation for reproduction of a s=
etup.
> > >
> > > A few tests used the adding of submodules without --force, hence they=
 have
> > > been updated to use the --force option.
> > >
> > > Claus Schneider(Eficode) (5):
> > >   read-cache: update add_files_to_cache take param
> > >     include_ignored_submodules
> > >   read-cache: add/read-cache respect submodule ignore=3Dall
> > >   tests: add new t2206-add-submodule-ignored.sh to test ignore=3Dall
> > >     scenario
> > >   tests: fix existing tests when add an ignore=3Dall submodule
> > >   Documentation: add --include_ignored_submodules + ignore=3Dall conf=
ig
> > >
> > >  .devcontainer/Dockerfile            |  70 +++++++++++++++
> > >  .devcontainer/Dockerfile.standalone |  76 ++++++++++++++++
> > >  .devcontainer/devcontainer.json     |  25 ++++++
> > >  Documentation/config/submodule.adoc |  13 +--
> > >  Documentation/git-add.adoc          |   5 ++
> > >  Documentation/gitmodules.adoc       |   5 +-
> > >  builtin/add.c                       |   4 +-
> > >  builtin/checkout.c                  |   2 +-
> > >  builtin/commit.c                    |   2 +-
> > >  read-cache-ll.h                     |   2 +-
> > >  read-cache.c                        |  54 ++++++++++-
> > >  t/lib-submodule-update.sh           |   6 +-
> > >  t/meson.build                       |   1 +
> > >  t/t2206-add-submodule-ignored.sh    | 134 ++++++++++++++++++++++++++=
++
> > >  t/t7508-status.sh                   |   2 +-
> > >  15 files changed, 384 insertions(+), 17 deletions(-)
> > >  create mode 100644 .devcontainer/Dockerfile
> > >  create mode 100644 .devcontainer/Dockerfile.standalone
> > >  create mode 100644 .devcontainer/devcontainer.json
> > >  create mode 100755 t/t2206-add-submodule-ignored.sh
> > >
> > >
> > > base-commit: 81f86aacc4eb74cdb9c2c8082d36d2070c666045
> > > Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-198=
7%2FPraqma%2Frespect-submodule-ignore-v2
> > > Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1987/P=
raqma/respect-submodule-ignore-v2
> > > Pull-Request: https://github.com/gitgitgadget/git/pull/1987
> > >
> > > Range-diff vs v1:
> > >
> > >  1:  d98cca698d ! 1:  5796009122 read-cache: update add_files_to_cach=
e to take param ignored_too(--force)
> > >      @@ Metadata
> > >       Author: Claus Schneider(Eficode) <claus.schneider@eficode.com>
> > >
> > >        ## Commit message ##
> > >      -    read-cache: update add_files_to_cache to take param ignored=
_too(--force)
> > >      +    read-cache: update add_files_to_cache take param include_ig=
nored_submodules
> > >
> > >      -    The ignored_too parameter is added to the function add_file=
s_to_cache for
> > >      -    usage of explicit updating the index for the updated submod=
ule using the
> > >      -    explicit patchspec to the submodule.
> > >      +    The include_ignored_submodules parameter is added to the fu=
nction
> > >      +    add_files_to_cache for usage of explicit updating the index=
 for the updated
> > >      +    submodule using the explicit patchspec to the submodule.
> > >
> > >           Signed-off-by: Claus Schneider(Eficode) <claus.schneider@ef=
icode.com>
> > >
> > >        ## builtin/add.c ##
> > >      +@@ builtin/add.c: N_("The following paths are ignored by one of=
 your .gitignore files:\n");
> > >      + static int verbose, show_only, ignored_too, refresh_only;
> > >      + static int ignore_add_errors, intent_to_add, ignore_missing;
> > >      + static int warn_on_embedded_repo =3D 1;
> > >      ++static int include_ignored_submodules;
> > >      +
> > >      + #define ADDREMOVE_DEFAULT 1
> > >      + static int addremove =3D ADDREMOVE_DEFAULT;
> > >      +@@ builtin/add.c: static struct option builtin_add_options[] =
=3D {
> > >      +        OPT_BOOL( 0 , "ignore-errors", &ignore_add_errors, N_("=
just skip files which cannot be added because of errors")),
> > >      +        OPT_BOOL( 0 , "ignore-missing", &ignore_missing, N_("ch=
eck if - even missing - files are ignored in dry run")),
> > >      +        OPT_BOOL(0, "sparse", &include_sparse, N_("allow updati=
ng entries outside of the sparse-checkout cone")),
> > >      ++    OPT_BOOL(0, "include-ignored-submodules", &include_ignored=
_submodules, N_("add submodules even if they has configuration ignore=3Dall=
")),
> > >      +        OPT_STRING(0, "chmod", &chmod_arg, "(+|-)x",
> > >      +                   N_("override the executable bit of the liste=
d files")),
> > >      +        OPT_HIDDEN_BOOL(0, "warn-embedded-repo", &warn_on_embed=
ded_repo,
> > >       @@ builtin/add.c: int cmd_add(int argc,
> > >               else
> > >                       exit_status |=3D add_files_to_cache(repo, prefi=
x,
> > >                                                         &pathspec, ps=
_matched,
> > >       -                                                 include_spars=
e, flags);
> > >      -+                                                 include_spars=
e, flags, ignored_too);
> > >      ++                                                 include_spars=
e, flags, include_ignored_submodules);
> > >
> > >               if (take_worktree_changes && !add_renormalize && !ignor=
e_add_errors &&
> > >                   report_path_error(ps_matched, &pathspec))
> > >      @@ read-cache.c: void overlay_tree_on_index(struct index_state *=
istate,
> > >               int include_sparse;
> > >               int flags;
> > >               int add_errors;
> > >      -+       int ignored_too;
> > >      ++       int include_ignored_submodules;
> > >        };
> > >
> > >        static int fix_unmerged_status(struct diff_filepair *p,
> > >       @@ read-cache.c: static void update_callback(struct diff_queue_=
struct *q,
> > >      +                default:
> > >      +                        die(_("unexpected diff status %c"), p->=
status);
> > >      +                case DIFF_STATUS_MODIFIED:
> > >      +-               case DIFF_STATUS_TYPE_CHANGED:
> > >      ++               case DIFF_STATUS_TYPE_CHANGED: {
> > >      ++                       struct stat st;
> > >      ++                       if (!lstat(path, &st) && S_ISDIR(st.st_=
mode)) { // only consider submodule if it is a directory
> > >      ++                               const struct submodule *sub =3D=
 submodule_from_path(data->repo, null_oid(the_hash_algo), path);
> > >      ++                               if (sub && sub->name && sub->ig=
nore && !strcmp(sub->ignore, "all")) {
> > >      ++                                       int pathspec_matches =
=3D 0;
> > >      ++                                       char *norm_pathspec =3D=
 NULL;
> > >      ++                                       int ps_i;
> > >      ++                                       trace_printf("ignore=3D=
all %s\n", path);
> > >      ++                                       trace_printf("pathspec =
%s\n",
> > >      ++                                                       (data->=
pathspec && data->pathspec->nr) ? "has pathspec" : "no pathspec");
> > >      ++                                       /* Safely scan all path=
spec items (q->nr may exceed pathspec->nr). */
> > >      ++                                       if (data->pathspec) {
> > >      ++                                               for (ps_i =3D 0=
; ps_i < data->pathspec->nr; ps_i++) {
> > >      ++                                                       const c=
har *m =3D data->pathspec->items[ps_i].match;
> > >      ++                                                       if (!m)
> > >      ++                                                              =
 continue;
> > >      ++                                                       norm_pa=
thspec =3D xstrdup(m);
> > >      ++                                                       strip_d=
ir_trailing_slashes(norm_pathspec);
> > >      ++                                                       if (!st=
rcmp(path, norm_pathspec)) {
> > >      ++                                                              =
 pathspec_matches =3D 1;
> > >      ++                                                              =
 FREE_AND_NULL(norm_pathspec);
> > >      ++                                                              =
 break;
> > >      ++                                                       }
> > >      ++                                                       FREE_AN=
D_NULL(norm_pathspec);
> > >      ++                                               }
> > >      ++                                       }
> > >      ++                                       if (pathspec_matches) {
> > >      ++                                               if (data->inclu=
de_ignored_submodules && data->include_ignored_submodules > 0) {
> > >      ++                                                       trace_p=
rintf("Add ignored=3Dall submodule due to --include_ignored_submodules: %s\=
n", path);
> > >      ++                                               } else {
> > >      ++                                                       printf(=
_("Skipping submodule due to ignore=3Dall: %s"), path);
> > >      ++                                                       printf(=
_("Use --include_ignored_submodules, if you really want to add them.") );
> > >      ++                                                       continu=
e;
> > >      ++                                               }
> > >      ++                                       } else {
> > >      ++                                               /* No explicit =
pathspec match -> skip silently (or with trace). */
> > >      ++                                               trace_printf("p=
athspec does not match %s\n", path);
> > >      ++                                               continue;
> > >      ++                                       }
> > >      ++                               }
> > >      ++                       }
> > >      +                        if (add_file_to_index(data->index, path=
, data->flags)) {
> > >      +                                if (!(data->flags & ADD_CACHE_I=
GNORE_ERRORS))
> > >      +                                        die(_("updating files f=
ailed"));
> > >      +@@ read-cache.c: static void update_callback(struct diff_queue_=
struct *q,
> > >
> > >        int add_files_to_cache(struct repository *repo, const char *pr=
efix,
> > >                              const struct pathspec *pathspec, char *p=
s_matched,
> > >       -                      int include_sparse, int flags)
> > >      -+                      int include_sparse, int flags, int ignor=
ed_too )
> > >      ++                      int include_sparse, int flags, int inclu=
de_ignored_submodules )
> > >        {
> > >               struct update_callback_data data;
> > >               struct rev_info rev;
> > >      @@ read-cache.c: int add_files_to_cache(struct repository *repo,=
 const char *prefix
> > >               data.include_sparse =3D include_sparse;
> > >               data.flags =3D flags;
> > >       +       data.repo =3D repo;
> > >      -+       data.ignored_too =3D ignored_too;
> > >      ++       data.include_ignored_submodules =3D include_ignored_sub=
modules;
> > >       +       data.pathspec =3D (struct pathspec *)pathspec;
> > >
> > >               repo_init_revisions(repo, &rev, prefix);
> > >  2:  d1b02617e6 ! 2:  9ec79b9a11 read-cache: let read-cache respect s=
ubmodule ignore=3Dall and --force
> > >      @@ Metadata
> > >       Author: Claus Schneider(Eficode) <claus.schneider@eficode.com>
> > >
> > >        ## Commit message ##
> > >      -    read-cache: let read-cache respect submodule ignore=3Dall a=
nd --force
> > >      +    read-cache: add/read-cache respect submodule ignore=3Dall
> > >
> > >      -    Given the submdule configuration is ignore=3Dall then only =
update the
> > >      -    submdule if the --force option is given and the submodule i=
s explicit
> > >      -    given in the pathspec.
> > >      +    Submodules configured with ignore=3Dall are now skipped dur=
ing add operations
> > >      +    unless overridden by --include-ignored-submodules and the s=
ubmodule path is
> > >      +    explicitly specified.
> > >
> > >           A message is printed (like ignored files) guiding the user =
to use the
> > >      -    --force flag if the user has explicitely want to update the=
 submodule
> > >      -    reference.
> > >      +    --include-ignored-submodules flag if the user has explicite=
ly want to update
> > >      +    the submodule reference.
> > >
> > >           The reason for the change is support submodule branch track=
ing or
> > >           similar and git status state nothing and git add should not=
 add either.
> > >      @@ Commit message
> > >           the submodule is already tracked.
> > >
> > >           The change opens up a lot of possibilities for submodules t=
o be used
> > >      -    more freely and a like the repo tool. A submodule can be ad=
ded for many
> > >      +    more freely and simular to the repo tool. A submodule can b=
e added for many
> > >           more reason and loosely coupled dependencies to the super r=
epo which often
> > >           gives the friction of handle the explicit commits and updat=
es without
> > >           the need for tracking the submodule sha1 by sha1.
> > >      @@ read-cache.c
> > >        /* Mask for the name length in ce_flags in the on-disk index *=
/
> > >
> > >       @@ read-cache.c: static void update_callback(struct diff_queue_=
struct *q,
> > >      -                default:
> > >      -                        die(_("unexpected diff status %c"), p->=
status);
> > >      -                case DIFF_STATUS_MODIFIED:
> > >      --               case DIFF_STATUS_TYPE_CHANGED:
> > >      -+               case DIFF_STATUS_TYPE_CHANGED: {
> > >      -+                       struct stat st;
> > >      -+                       if (!lstat(path, &st) && S_ISDIR(st.st_=
mode)) { // only consider submodule if it is a directory
> > >      -+                               const struct submodule *sub =3D=
 submodule_from_path(data->repo, null_oid(the_hash_algo), path);
> > >      -+                               if (sub && sub->name && sub->ig=
nore && !strcmp(sub->ignore, "all")) {
> > >      -+                                       int pathspec_matches =
=3D 0;
> > >      -+                                       char *norm_pathspec =3D=
 NULL;
> > >      -+                                       int ps_i;
> > >      -+                                       trace_printf("ignore=3D=
all %s\n", path);
> > >      -+                                       trace_printf("pathspec =
%s\n",
> > >      -+                                                       (data->=
pathspec && data->pathspec->nr) ? "has pathspec" : "no pathspec");
> > >      -+                                       /* Safely scan all path=
spec items (q->nr may exceed pathspec->nr). */
> > >      -+                                       if (data->pathspec) {
> > >      -+                                               for (ps_i =3D 0=
; ps_i < data->pathspec->nr; ps_i++) {
> > >      -+                                                       const c=
har *m =3D data->pathspec->items[ps_i].match;
> > >      -+                                                       if (!m)
> > >      -+                                                              =
 continue;
> > >      -+                                                       norm_pa=
thspec =3D xstrdup(m);
> > >      -+                                                       strip_d=
ir_trailing_slashes(norm_pathspec);
> > >      -+                                                       if (!st=
rcmp(path, norm_pathspec)) {
> > >      -+                                                              =
 pathspec_matches =3D 1;
> > >      -+                                                              =
 FREE_AND_NULL(norm_pathspec);
> > >      -+                                                              =
 break;
> > >      -+                                                       }
> > >      -+                                                       FREE_AN=
D_NULL(norm_pathspec);
> > >      -+                                               }
> > >      -+                                       }
> > >      -+                                       if (pathspec_matches) {
> > >      -+                                               if (data->ignor=
ed_too && data->ignored_too > 0) {
> > >      -+                                                       trace_p=
rintf("Forcing add of submodule ignored=3Dall due to --force: %s\n", path);
> > >      -+                                               } else {
> > >      -+                                                       printf(=
_("Skipping submodule due to ignore=3Dall: %s"), path);
> > >      -+                                                       printf(=
_("Use -f if you really want to add them.") );
> > >      -+                                                       continu=
e;
> > >      -+                                               }
> > >      -+                                       } else {
> > >      -+                                               /* No explicit =
pathspec match -> skip silently (or with trace). */
> > >      -+                                               trace_printf("p=
athspec does not match %s\n", path);
> > >      -+                                               continue;
> > >      -+                                       }
> > >      -+                               }
> > >      -+                       }
> > >      -                        if (add_file_to_index(data->index, path=
, data->flags)) {
> > >      -                                if (!(data->flags & ADD_CACHE_I=
GNORE_ERRORS))
> > >      -                                        die(_("updating files f=
ailed"));
> > >      +                                        }
> > >      +                                        if (pathspec_matches) {
> > >      +                                                if (data->inclu=
de_ignored_submodules && data->include_ignored_submodules > 0) {
> > >      +-                                                       trace_p=
rintf("Add ignored=3Dall submodule due to --include_ignored_submodules: %s\=
n", path);
> > >      ++                                                       trace_p=
rintf("Add submodule due to --include_ignored_submodules: %s\n", path);
> > >      +                                                } else {
> > >      +                                                        printf(=
_("Skipping submodule due to ignore=3Dall: %s"), path);
> > >      +                                                        printf(=
_("Use --include_ignored_submodules, if you really want to add them.") );
> > >      +@@ read-cache.c: static void update_callback(struct diff_queue_=
struct *q,
> > >      +                                                }
> > >      +                                        } else {
> > >      +                                                /* No explicit =
pathspec match -> skip silently (or with trace). */
> > >      +-                                               trace_printf("p=
athspec does not match %s\n", path);
> > >      ++                                               trace_printf("P=
athspec to submodule does not match explicitly: %s\n", path);
> > >      +                                                continue;
> > >      +                                        }
> > >      +                                }
> > >      +@@ read-cache.c: static void update_callback(struct diff_queue_=
struct *q,
> > >                                       data->add_errors++;
> > >                               }
> > >                               break;
> > >  3:  8f3d5f7ec1 ! 3:  399a153b95 tests: add new t2206-add-submodule-i=
gnored.sh to test ignore=3Dall scenario
> > >      @@ Commit message
> > >           config with ignore=3Dall also behaves as intended with conf=
iguration in
> > >           .gitmodules and configuration given on the command line.
> > >
> > >      -    Testfile is added to meson.build for execution.
> > >      +    The usage of --include_ignored_submodules is showcased and =
tested in the
> > >      +    test suite.
> > >      +
> > >      +    The test file is added to meson.build for execution.
> > >
> > >           Signed-off-by: Claus Schneider(Eficode) <claus.schneider@ef=
icode.com>
> > >
> > >      @@ t/t2206-add-submodule-ignored.sh (new)
> > >       +# This test covers the behavior of "git add", "git status" and=
 "git log" when
> > >       +# dealing with submodules that have the ignore=3Dall setting i=
n
> > >       +# .gitmodules. It ensures that changes in such submodules are
> > >      -+# ignored by default, but can be staged with "git add --force"=
.
> > >      ++# ignored by default, but can be staged with "git add --includ=
e-ignored-submodules".
> > >       +
> > >       +# shellcheck disable=3DSC1091
> > >       +. ./test-lib.sh
> > >      @@ t/t2206-add-submodule-ignored.sh (new)
> > >       +'
> > >       +
> > >       +#6
> > >      -+# check that 'git add --force .' does not stage the change in =
the submodule
> > >      ++# check that 'git add --include-ignored-submodules .' does not=
 stage the change in the submodule
> > >       +# and that 'git status' does not show it as modified
> > >      -+test_expect_success 'main: check --force add . and status'  '
> > >      ++test_expect_success 'main: check --include-ignored-submodules =
add . and status'  '
> > >       +       cd "${base_path}" &&
> > >       +       cd main &&
> > >      -+       GIT_TRACE=3D1 git add --force . &&
> > >      ++       GIT_TRACE=3D1 git add --include-ignored-submodules . &&
> > >       +       ! git status --porcelain | grep "^M  sub$" &&
> > >       +       echo
> > >       +'
> > >      @@ t/t2206-add-submodule-ignored.sh (new)
> > >       +'
> > >       +
> > >       +#8
> > >      -+# check that 'git add --force sub' does stage the change in th=
e submodule
> > >      -+# check that 'git add --force ./sub/' does stage the change in=
 the submodule
> > >      ++# check that 'git add --include-ignored-submodules sub' does s=
tage the change in the submodule
> > >      ++# check that 'git add --include-ignored-submodules ./sub/' doe=
s stage the change in the submodule
> > >       +# and that 'git status --porcelain' does show it as modified
> > >       +# commit it..
> > >       +# check that 'git log --ignore-submodules=3Dnone' shows the su=
bmodule change
> > >      @@ t/t2206-add-submodule-ignored.sh (new)
> > >       +test_expect_success 'main: check force add sub and ./sub/ and =
status'  '
> > >       +       cd "${base_path}" &&
> > >       +       cd main &&
> > >      -+       echo "Adding with --force should work: git add --force =
sub" &&
> > >      -+       GIT_TRACE=3D1 git add --force sub &&
> > >      ++       echo "Adding with --include-ignored-submodules should w=
ork: git add --include-ignored-submodules sub" &&
> > >      ++       GIT_TRACE=3D1 git add --include-ignored-submodules sub =
&&
> > >       +       git status --porcelain | grep "^M  sub$" &&
> > >       +       git restore --staged sub &&
> > >       +       ! git status --porcelain | grep "^M  sub$" &&
> > >      -+       echo "Adding with --force should work: git add --force =
./sub/" &&
> > >      -+       GIT_TRACE=3D1 git add --force ./sub/ &&
> > >      ++       echo "Adding with --include-ignored-submodules should w=
ork: git add --include-ignored-submodules ./sub/" &&
> > >      ++       GIT_TRACE=3D1 git add --include-ignored-submodules ./su=
b/ &&
> > >       +       git status --porcelain | grep "^M  sub$" &&
> > >       +       git commit -m "update submodule pointer" &&
> > >       +       ! git status --porcelain | grep "^ M sub$" &&
> > >  4:  58563a7b90 ! 4:  93c95954f1 tests: fix existing tests when add a=
n ignore=3Dall submodule
> > >      @@ Metadata
> > >        ## Commit message ##
> > >           tests: fix existing tests when add an ignore=3Dall submodul=
e
> > >
> > >      -    There are tests that rely on "git add <submodule>" also add=
s it. A --force
> > >      -    is needed with this enhancement hence they are added accord=
ingly in these
> > >      -    tests.
> > >      +    There are tests that rely on "git add <submodule>" to add u=
pdates in the
> > >      +    parent repository. A new option --include-ignored-submodule=
s is introduced
> > >      +    as it is now needed with this enhancement.
> > >
> > >           Updated tests:
> > >           - t1013-read-tree-submodule.sh ( fixed in: t/lib-submodule-=
update.sh )
> > >      +    - t2013-checkout-submodule.sh ( fixed in: t/lib-submodule-u=
pdate.sh )
> > >           - t7406-submodule-update.sh
> > >           - t7508-status.sh
> > >
> > >      @@ t/lib-submodule-update.sh: create_lib_submodule_repo () {
> > >                               git push origin modifications
> > >                       ) &&
> > >       -               git add sub1 &&
> > >      -+               git add --force sub1 &&
> > >      ++               git add --include-ignored-submodules sub1 &&
> > >                       git commit -m "Modify sub1" &&
> > >
> > >                       git checkout -b add_nested_sub modify_sub1 &&
> > >      @@ t/lib-submodule-update.sh: create_lib_submodule_repo () {
> > >                       git -C sub1 submodule add --branch no_submodule=
 ../submodule_update_sub2 sub2 &&
> > >                       git -C sub1 commit -a -m "add a nested submodul=
e" &&
> > >       -               git add sub1 &&
> > >      -+               git add --force sub1 &&
> > >      ++               git add --include-ignored-submodules sub1 &&
> > >                       git commit -a -m "update submodule, that update=
s a nested submodule" &&
> > >                       git checkout -b modify_sub1_recursively &&
> > >                       git -C sub1 checkout -b modify_sub1_recursively=
 &&
> > >      @@ t/lib-submodule-update.sh: create_lib_submodule_repo () {
> > >                       git -C sub1 add sub2 &&
> > >                       git -C sub1 commit -m "update nested sub" &&
> > >       -               git add sub1 &&
> > >      -+               git add --force sub1 &&
> > >      ++               git add --include-ignored-submodules sub1 &&
> > >                       git commit -m "update sub1, that updates nested=
 sub" &&
> > >                       git -C sub1 push origin modify_sub1_recursively=
 &&
> > >                       git -C sub1/sub2 push origin modify_sub1_recurs=
ively &&
> > >      @@ t/t7508-status.sh: test_expect_success 'git commit will commi=
t a staged but igno
> > >        test_expect_success 'git commit --dry-run will show a staged b=
ut ignored submodule' '
> > >               git reset HEAD^ &&
> > >       -       git add sm &&
> > >      -+       git add --force sm &&
> > >      ++       git add --include-ignored-submodules sm &&
> > >               cat >expect << EOF &&
> > >        On branch main
> > >        Your branch and '\''upstream'\'' have diverged,
> > >  5:  416695f439 < -:  ---------- Documentation: update add --force an=
d submodule ignore=3Dall config
> > >  -:  ---------- > 5:  ee84190cd8 Documentation: add --include_ignored=
_submodules + ignore=3Dall config
