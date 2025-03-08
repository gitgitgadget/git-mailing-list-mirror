Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDB217C77
	for <git@vger.kernel.org>; Sat,  8 Mar 2025 16:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741449924; cv=none; b=BL963McYxNk6xPeGjRX6OYTTNPK2Zf2AEC6DB97WwV1KSO8O8pvFmj3rhMQGwg9Z/xfsjcM94WL8lTCWTpxE+6GvdjCPt0QTOyBkv0iaFk8jDvsrbqaHRSNwi4RwjDf+4WbeRkY+C3xdklR3H2T233z5kgkn8WI7kdNbMJzIHeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741449924; c=relaxed/simple;
	bh=LipiVOsAyXYWwBi0f1ANr88eM8pQMDsKgwHRqSVhjy4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RdnlrEJLd6aq2Pe21eh3BrwwKznlt3fG0ot0ifu0pwtV9kk51OLyYfCOj53lHw+7u0uMPffF6oTYp0UvV2IfqU4B8h8pUuoSZK3dsUJFaUFd2vU9XJRswjipY2ayCSy066Toy1pQNnDYB52NKZMgY3bs1gHvD5kvwbXFKQKkSto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UOOuccEA; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UOOuccEA"
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3d4469b35e4so11160575ab.1
        for <git@vger.kernel.org>; Sat, 08 Mar 2025 08:05:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741449921; x=1742054721; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ihKcp8dBzvATMRtzXirpP+xfxhNgxfvNVaHoFx276zw=;
        b=UOOuccEAhs9Qym7u7zS6qQz0xZpbckcwjZve8r0xeM3iWBlYhlC9WvZcTMk0rTe4iX
         VoB+67Lv2cnCX63BX+Jozkw8MCw0tTHT+kFZ3oNSMOZBto2aQyaShYFEw7zVogVDkuB/
         eUPE+QgTDHmmYqcOSps7GVS12yvFNyAkKdJU5RoEj6r86Oi369uduMtlFNvLhqeD6OOu
         XaLH2sS2Ss2OMUhNNykuyEzw9wi8DghYxFLEWOIFFbGCuP+3BU52geoEFX7UHJ+7me/L
         /xh1KDL2JNPOoEcn21wyHbFgx2pw88jJ/8hNN0X8uUcwtR6yxGHk37MrtQ8qHOwW96YO
         69Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741449921; x=1742054721;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ihKcp8dBzvATMRtzXirpP+xfxhNgxfvNVaHoFx276zw=;
        b=rSSyfMPYVI5n77DXoInuEQxQOKIBoAVkF3udLQ0g+opY/YVpFdhwis1KHFP5RRrkqn
         arRK9gUxA5rt7W0fRUyW9BnGnFM3+tlN736GzNiTk+V7pHaNbwSiaUSlsMuPQvgigmLX
         gHX/YdlQl9PkkPgOL8HyWxF7QKaqWdBKryqA2cbLobhQN76nzNpVMT9vHSTFqhE9j7X9
         eeqeJgi+Pa/uuFAotrX+PX6ro9OdBMH/jkz+zD1PaqhzHA9Fy+Rd9r9C97PFajWyGIQX
         QJIz9dP8O2y/TojNhQw8ykHM0dyY2UjKddk4mSaY4LmL4oVkQQlaoGfM98JmSzJ/8OOz
         Fqbw==
X-Gm-Message-State: AOJu0YzhnoC8kTDCZHoSXVv3AXhtLiO03s9c73XVZHZX3babdoble/78
	CGk/8In9iLvJnCIj36WQnhXLLffXtDesFuMBNkoOcfJWRWwhTwGU6gJQRjxRd7H9oEW9pFljUkb
	xUuFi63Ci9RzIjgE3GkCAh8bEdtB1uQ==
X-Gm-Gg: ASbGncuYvJCHvTLSVwLkNFiclEpKhYn09X17UxSNNCW6UOhw6QlE8RwKt2u+gsGnJFn
	7pwh4Pr3YaoLrrKVzgNxMcrIN7+z/a9YywhMhZozKx1S4bmJY/G3rhbsuZw7qW6InZtH8FAoeEe
	ncm1fikJRWxG4E1W+G8mzOqWZCnQXLb8uphZaupjt7Mm9yxGHJyC6IrPqjc9U=
X-Google-Smtp-Source: AGHT+IGOCU6SmAisvbdmD+PYH/gSdKj3rhNZCW9LFFjeoPSSdvMGpRoaPvL+DV6L5L6vgMsrzkeLOD2WoiTTV5AiPbs=
X-Received: by 2002:a92:ca49:0:b0:3d2:b66b:94cd with SMTP id
 e9e14a558f8ab-3d441930332mr111122235ab.3.1741449920871; Sat, 08 Mar 2025
 08:05:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250307-b4-pks-objects-without-the-repository-v3-0-7bccf408731e@pks.im>
 <20250307-b4-pks-objects-without-the-repository-v3-12-7bccf408731e@pks.im>
In-Reply-To: <20250307-b4-pks-objects-without-the-repository-v3-12-7bccf408731e@pks.im>
From: Elijah Newren <newren@gmail.com>
Date: Sat, 8 Mar 2025 08:05:09 -0800
X-Gm-Features: AQ5f1JqE5YvUmMszpxqc9ypUHDPDei0qZW9Hyd0OCEwBzI7pEBn0Fur9xDwec7U
Message-ID: <CABPp-BG0AtKdUH2g8+_f0J0ViWs5xZKM9kCcbWYZ=uEu6bswdQ@mail.gmail.com>
Subject: Re: [PATCH v3 12/12] hash: stop depending on `the_repository` in `null_oid()`
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>, 
	Justin Tobler <jltobler@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 7, 2025 at 6:20=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrote=
:
>
> The `null_oid()` function returns the object ID that only consists of
> zeroes. Naturally, this ID also depends on the hash algorithm used, as
> the number of zeroes is different between SHA1 and SHA256. Consequently,
> the function returns the hash-algorithm-specific null object ID.
>
> This is currently done by depending on `the_hash_algo`, which implicitly
> makes us depend on `the_repository`. Refactor the function to instead
> pass in the hash algorithm for which we want to retrieve the null object
> ID. Adapt callsites accordingly by passing in `the_repository`, thus
> bubbling up the dependency on that global variable by one layer.
>
> There are a couple of trivial exceptions for subsystems that already got
> rid of `the_repository`. These subsystems instead use the repository
> that is available via the calling context:
>
>   - "builtin/grep.c"
>   - "grep.c"
>   - "refs/debug.c"
>
> There are also two non-trivial exceptions:
>
>   - "diff-no-index.c": Here we know that we may not have a repository
>     initialized at all, so we cannot rely on `the_repository`. Instead,
>     we adapt `diff_no_index()` to get a `struct git_hash_algo` as
>     parameter. The only caller is located in "builtin/diff.c", where we
>     know to call `repo_set_hash_algo()` in case we're running outside of
>     a Git repository. Consequently, it is fine to continue passing
>     `the_repository->hash_algo` even in this case.
>
>   - "builtin/ls-files.c": There is an in-flight patch series that drops
>     `USE_THE_REPOSITORY_VARIABLE` in this file, which causes a semantic
>     conflict because we use `null_oid()` in `show_submodule()`. The
>     value is passed to `repo_submodule_init()`, which may use the object
>     ID to resolve a tree-ish in the superproject from which we want to
>     read the submodule config. As such, the object ID should refer to an
>     object in the superproject, and consequently we need to use its hash
>     algorithm.
>
> This means that we could in theory just not bother about this edge case
> at all and just use `the_repository` in "diff-no-index.c". But doing so
> would feel misdesigned.

Very minor, but this was a bit jarring to me -- shouldn't this
paragraph be indented over since it is a continuation of the second
bullet above?

> Remove the `USE_THE_REPOSITORY_VARIABLE` preprocessor define in
> "hash.c".
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
[...]
> diff --git a/merge-ort.c b/merge-ort.c
> index 46e78c3ffa6..eb3a834652a 100644
> --- a/merge-ort.c
> +++ b/merge-ort.c
> @@ -1817,7 +1817,7 @@ static int merge_submodule(struct merge_options *op=
t,
>                 BUG("submodule deleted on one side; this should be handle=
d outside of merge_submodule()");
>
>         if ((sub_not_initialized =3D repo_submodule_init(&subrepo,
> -               opt->repo, path, null_oid()))) {
> +               opt->repo, path, null_oid(the_hash_algo)))) {
>                 path_msg(opt, CONFLICT_SUBMODULE_NOT_INITIALIZED, 0,
>                          path, NULL, NULL, NULL,
>                          _("Failed to merge submodule %s (not checked out=
)"),
> @@ -2199,7 +2199,7 @@ static int handle_content_merge(struct merge_option=
s *opt,
>                 two_way =3D ((S_IFMT & o->mode) !=3D (S_IFMT & a->mode));
>
>                 merge_status =3D merge_3way(opt, path,
> -                                         two_way ? null_oid() : &o->oid,
> +                                         two_way ? null_oid(the_hash_alg=
o) : &o->oid,
>                                           &a->oid, &b->oid,
>                                           pathnames, extra_marker_size,
>                                           &result_buf);
> @@ -2231,7 +2231,7 @@ static int handle_content_merge(struct merge_option=
s *opt,
>         } else if (S_ISGITLINK(a->mode)) {
>                 int two_way =3D ((S_IFMT & o->mode) !=3D (S_IFMT & a->mod=
e));
>                 clean =3D merge_submodule(opt, pathnames[0],
> -                                       two_way ? null_oid() : &o->oid,
> +                                       two_way ? null_oid(the_hash_algo)=
 : &o->oid,
>                                         &a->oid, &b->oid, &result->oid);
>                 if (clean < 0)
>                         return -1;
> @@ -2739,7 +2739,7 @@ static void apply_directory_rename_modifications(st=
ruct merge_options *opt,
>                 assert(!new_ci->match_mask);
>                 new_ci->dirmask =3D 0;
>                 new_ci->stages[1].mode =3D 0;
> -               oidcpy(&new_ci->stages[1].oid, null_oid());
> +               oidcpy(&new_ci->stages[1].oid, null_oid(the_hash_algo));
>
>                 /*
>                  * Now that we have the file information in new_ci, make =
sure
> @@ -2752,7 +2752,7 @@ static void apply_directory_rename_modifications(st=
ruct merge_options *opt,
>                                 continue;
>                         /* zero out any entries related to files */
>                         ci->stages[i].mode =3D 0;
> -                       oidcpy(&ci->stages[i].oid, null_oid());
> +                       oidcpy(&ci->stages[i].oid, null_oid(the_hash_algo=
));
>                 }
>
>                 /* Now we want to focus on new_ci, so reassign ci to it. =
*/
> @@ -3122,7 +3122,7 @@ static int process_renames(struct merge_options *op=
t,
>                         if (type_changed) {
>                                 /* rename vs. typechange */
>                                 /* Mark the original as resolved by remov=
al */
> -                               memcpy(&oldinfo->stages[0].oid, null_oid(=
),
> +                               memcpy(&oldinfo->stages[0].oid, null_oid(=
the_hash_algo),
>                                        sizeof(oldinfo->stages[0].oid));
>                                 oldinfo->stages[0].mode =3D 0;
>                                 oldinfo->filemask &=3D 0x06;
> @@ -3994,7 +3994,7 @@ static int process_entry(struct merge_options *opt,
>                         if (ci->filemask & (1 << i))
>                                 continue;
>                         ci->stages[i].mode =3D 0;
> -                       oidcpy(&ci->stages[i].oid, null_oid());
> +                       oidcpy(&ci->stages[i].oid, null_oid(the_hash_algo=
));
>                 }
>         } else if (ci->df_conflict && ci->merged.result.mode !=3D 0) {
>                 /*
> @@ -4041,7 +4041,7 @@ static int process_entry(struct merge_options *opt,
>                                 continue;
>                         /* zero out any entries related to directories */
>                         new_ci->stages[i].mode =3D 0;
> -                       oidcpy(&new_ci->stages[i].oid, null_oid());
> +                       oidcpy(&new_ci->stages[i].oid, null_oid(the_hash_=
algo));
>                 }
>
>                 /*
> @@ -4163,11 +4163,11 @@ static int process_entry(struct merge_options *op=
t,
>                         new_ci->merged.result.mode =3D ci->stages[2].mode=
;
>                         oidcpy(&new_ci->merged.result.oid, &ci->stages[2]=
.oid);
>                         new_ci->stages[1].mode =3D 0;
> -                       oidcpy(&new_ci->stages[1].oid, null_oid());
> +                       oidcpy(&new_ci->stages[1].oid, null_oid(the_hash_=
algo));
>                         new_ci->filemask =3D 5;
>                         if ((S_IFMT & b_mode) !=3D (S_IFMT & o_mode)) {
>                                 new_ci->stages[0].mode =3D 0;
> -                               oidcpy(&new_ci->stages[0].oid, null_oid()=
);
> +                               oidcpy(&new_ci->stages[0].oid, null_oid(t=
he_hash_algo));
>                                 new_ci->filemask =3D 4;
>                         }
>
> @@ -4175,11 +4175,11 @@ static int process_entry(struct merge_options *op=
t,
>                         ci->merged.result.mode =3D ci->stages[1].mode;
>                         oidcpy(&ci->merged.result.oid, &ci->stages[1].oid=
);
>                         ci->stages[2].mode =3D 0;
> -                       oidcpy(&ci->stages[2].oid, null_oid());
> +                       oidcpy(&ci->stages[2].oid, null_oid(the_hash_algo=
));
>                         ci->filemask =3D 3;
>                         if ((S_IFMT & a_mode) !=3D (S_IFMT & o_mode)) {
>                                 ci->stages[0].mode =3D 0;
> -                               oidcpy(&ci->stages[0].oid, null_oid());
> +                               oidcpy(&ci->stages[0].oid, null_oid(the_h=
ash_algo));
>                                 ci->filemask =3D 2;
>                         }
>
> @@ -4304,7 +4304,7 @@ static int process_entry(struct merge_options *opt,
>                 /* Deleted on both sides */
>                 ci->merged.is_null =3D 1;
>                 ci->merged.result.mode =3D 0;
> -               oidcpy(&ci->merged.result.oid, null_oid());
> +               oidcpy(&ci->merged.result.oid, null_oid(the_hash_algo));
>                 assert(!ci->df_conflict);
>                 ci->merged.clean =3D !ci->path_conflict;
>         }

What you have is an improvement since it's at least making things
explicit, but these should really be opt->repo->hash_algo.

> diff --git a/merge-recursive.c b/merge-recursive.c
> index 5dfaf32b2c1..d88e61b07a9 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -502,7 +502,7 @@ static int get_tree_entry_if_blob(struct repository *=
r,
>
>         ret =3D get_tree_entry(r, tree, path, &dfs->oid, &dfs->mode);
>         if (S_ISDIR(dfs->mode)) {
> -               oidcpy(&dfs->oid, null_oid());
> +               oidcpy(&dfs->oid, null_oid(the_hash_algo));
>                 dfs->mode =3D 0;
>         }
>         return ret;
> @@ -1238,7 +1238,7 @@ static int merge_submodule(struct merge_options *op=
t,
>         if (is_null_oid(b))
>                 return 0;
>
> -       if (repo_submodule_init(&subrepo, opt->repo, path, null_oid())) {
> +       if (repo_submodule_init(&subrepo, opt->repo, path, null_oid(the_h=
ash_algo))) {
>                 output(opt, 1, _("Failed to merge submodule %s (not check=
ed out)"), path);
>                 return 0;
>         }
> @@ -1698,7 +1698,7 @@ static int handle_file_collision(struct merge_optio=
ns *opt,
>
>         /* Store things in diff_filespecs for functions that need it */
>         null.path =3D (char *)collide_path;
> -       oidcpy(&null.oid, null_oid());
> +       oidcpy(&null.oid, null_oid(the_hash_algo));
>         null.mode =3D 0;
>
>         if (merge_mode_and_contents(opt, &null, a, b, collide_path,
> @@ -2898,14 +2898,14 @@ static int process_renames(struct merge_options *=
opt,
>                         dst_other.mode =3D ren1->dst_entry->stages[other_=
stage].mode;
>                         try_merge =3D 0;
>
> -                       if (oideq(&src_other.oid, null_oid()) &&
> +                       if (oideq(&src_other.oid, null_oid(the_hash_algo)=
) &&
>                             ren1->dir_rename_original_type =3D=3D 'A') {
>                                 setup_rename_conflict_info(RENAME_VIA_DIR=
,
>                                                            opt, ren1, NUL=
L);
>                         } else if (renamed_to_self) {
>                                 setup_rename_conflict_info(RENAME_NORMAL,
>                                                            opt, ren1, NUL=
L);
> -                       } else if (oideq(&src_other.oid, null_oid())) {
> +                       } else if (oideq(&src_other.oid, null_oid(the_has=
h_algo))) {
>                                 setup_rename_conflict_info(RENAME_DELETE,
>                                                            opt, ren1, NUL=
L);
>                         } else if ((dst_other.mode =3D=3D ren1->pair->two=
->mode) &&
> @@ -2924,7 +2924,7 @@ static int process_renames(struct merge_options *op=
t,
>                                                       1, /* update_cache =
*/
>                                                       0  /* update_wd    =
*/))
>                                         clean_merge =3D -1;
> -                       } else if (!oideq(&dst_other.oid, null_oid())) {
> +                       } else if (!oideq(&dst_other.oid, null_oid(the_ha=
sh_algo))) {
>                                 /*
>                                  * Probably not a clean merge, but it's
>                                  * premature to set clean_merge to 0 here=
,

This will textually conflict with my upcoming series to delete
merge-recursive.[ch].  Luckily, it'll be easy to resolve, since the
changes will just be irrelevant...  :-)

[...]

The rest of the changes looked good to me.
