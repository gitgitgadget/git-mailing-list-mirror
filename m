Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4FA22FDEC
	for <git@vger.kernel.org>; Wed, 20 Aug 2025 21:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755724518; cv=none; b=ln6Pe3wug8JOGZJIskWkcr6G9yL8aOnkaUiS8CDPsfX7j5R8NBTQyX5r1zc4nAMgjPCkN9ZeXG9JtDobJzlhf2+/pIxwU5OJmZucLr1xH1Ng/6rLhdjqoAbhp8q6QNBbYCU7fxZgO7nekNMm0zyzHBGz7cwRJhSkucY8o5xh0Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755724518; c=relaxed/simple;
	bh=TR3g00EwatOElipH1hjbj30OpsH812CqYgqCJxnTd0E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f9DJUwnPeuUI233CVZFyB2jgQ4H3zpxWszy2URY460lq0ky3YNmjys0f6JYlClO8C0p9jWEJDsSI/den/QrF/5qtxO3ONPKFraeAy0cVV0EWhVIwrFLTpy7IV1N4Dwr3tSwO2cYHjn5OPTtjUTdL2xpablHYDTmwOQXZiCgl1BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f/T5P7XG; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f/T5P7XG"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-afcb7a16441so47332866b.2
        for <git@vger.kernel.org>; Wed, 20 Aug 2025 14:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755724515; x=1756329315; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bw3c76hfs47VAD1K7dfub4c6tgimARY0G2S3Pc7GueA=;
        b=f/T5P7XGNFxHoFGMI1Il2KDEcXgYnfM93bgmj61Mi5ofgS4BH03l2rhR5Fqjc7iQNH
         bfp+ouhoHgUJamMYH58bWIJfym3zqLzcy5QmzDHBatTBTFQha8PCCyuES8lcq5omY0kF
         5zruY4a+Gan1OqLlEfklPufbI+hG4X1wsiOtKTFu9uZsHMeMAFu5krqsCQJ2LsoirFvB
         86uwUdmu3tkMt+odIPOTGC+Ado18KG/5PJfl47R/6TK+2TBdejhB8auvpY/YgsTFBIuf
         HxUhdqFvTr3FQC003cYLB1YJYFLENRkh+SIdwzZ7ZBey+8j7Jn8QG06xG9KA8j8If3Ku
         +j7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755724515; x=1756329315;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bw3c76hfs47VAD1K7dfub4c6tgimARY0G2S3Pc7GueA=;
        b=MxI/RP+R2C98St4tdYFC3IAcuyCCX7mUwR7fewZUvNJMAIJtvQGtyEaVfTXF8xlA1v
         ar2HgJvXZhA7hKSifeUA5xHa+0YTvDhM5bA69LnEMLis/08c9oLVxQ96crQRwbhW9pGz
         xQix4coTkKRVNqreG4NhbG8lQMCoS6OfnCFtiIcFP9lvbvE656poMtTEbt+mOSNv4a4T
         RDQ42XjgpZofIm24v8H6x69G7cXXhK97vC6lt63UEinllO2U4EoHc6mNp6+d9INKv8VU
         x+US77e6RCntQMAp1926T0RCx3ZK2v72N6yAJvIcbhbOGqKd11KhVH//jBG+Q1P8tMBB
         8BsQ==
X-Gm-Message-State: AOJu0YwBLwVbHDaA/rCRgIzxCx0Kw7Aph/SEwjjeayWzwIrcO9B5jMUx
	DPX7sVjzIVWErodJHBz9u01l6Plifrd0hVnnMVIvcAliWvAX4d7iQxhHbtdXJG6W67cEzmcjLuX
	hBkSuvYUVjCVOQit0AHKgmegbXOYT2FE=
X-Gm-Gg: ASbGncte6MsmQBGA8SPqQBZgyGrNFYvnABEeDprq6qz66jY29FiJ+eUQCR28ATpRyJ6
	Tesc/Ju1iPAZ+l1blH1NYjdo4FFuDdgDZz3YYR98dkDcxTU9Q2oOZ+LVVkNDA/+WmOqWmPXIkiV
	jd2/QyLVw4MdJowzMeznrWVl9mHMQoTKHQKE5oDSaKQ38UIiHwJ7nmXQmPCDwJlCip+i+7ZzlIs
	e7vWKc4s0rG8v07W1G+LspaiInyuh1w+TVV4KP2CL6nWI1oagIhJ1DYk6soFQ==
X-Google-Smtp-Source: AGHT+IEuR9EXfF3mtyNsq09w1w6so7hoEL0DpRcH23OD6qamY+R5kngGVl5U06TBYf8rMZKvtIbpcHkOseSCedBWnbQ=
X-Received: by 2002:a17:907:7e91:b0:af9:3d0a:f38f with SMTP id
 a640c23a62f3a-afe074ccf73mr23636466b.0.1755724514834; Wed, 20 Aug 2025
 14:15:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819-b4-pks-history-builtin-v1-0-9b77c32688fe@pks.im> <20250819-b4-pks-history-builtin-v1-10-9b77c32688fe@pks.im>
In-Reply-To: <20250819-b4-pks-history-builtin-v1-10-9b77c32688fe@pks.im>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Wed, 20 Aug 2025 17:15:03 -0400
X-Gm-Features: Ac12FXz37nASGqgx_JYXUyfFhU9KpxYgghJXYYiNQXQpLqcTwFeZo6WyJl8CaB8
Message-ID: <CALnO6CAPugqDC8sGO1Si=5Wk-pz52BF84Ai7ZQjwb3vLMs6A=A@mail.gmail.com>
Subject: Re: [PATCH RFC 10/11] add-patch: add support for in-memory index patching
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 20, 2025 at 4:17=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> With `run_add_p()` callers have the ability to apply changes from a
> specific revision to a repository's index. This infra supports several
> different modes, like for example applying changes to the index,
> worktree or both.
>
> One feature that is missing though is the ability to apply changes to an
> in-memory index different from the repository's index. Add a new
> function `run_add_p_index()` to plug this gap.
>
> This new function will be used in a subsequent commit.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  add-patch.c | 111 ++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++--
>  add-patch.h |   8 +++++
>  2 files changed, 116 insertions(+), 3 deletions(-)
>
> diff --git a/add-patch.c b/add-patch.c
> index 1bcbc91de9..adef20c02b 100644
> --- a/add-patch.c
> +++ b/add-patch.c
> @@ -1849,9 +1853,12 @@ static int patch_update_file(struct add_p_state *s=
,
>                                          NULL, 0, NULL, 0))
>                                 error(_("'git apply' failed"));
>                 }
> -               if (repo_read_index(s->r) >=3D 0)
> +               read_index_from(s->index, s->index_file, s->r->gitdir);
> +               if (read_index_from(s->index, s->index_file, s->r->gitdir=
) >=3D 0 &&
> +                   s->index =3D=3D s->r->index) {
>                         repo_refresh_and_write_index(s->r, REFRESH_QUIET,=
 0,
>                                                      1, NULL, NULL, NULL)=
;
> +               }
>         }

Is this call to read_index_from duplicated? I don't see anything that
indicates that would be desirable here.

>
>         putchar('\n');
> @@ -1864,6 +1871,8 @@ int run_add_p(struct repository *r, enum add_p_mode=
 mode,
>  {
>         struct add_p_state s =3D {
>                 .r =3D r,
> +               .index =3D r->index,
> +               .index_file =3D r->index_file,
>                 .answer =3D STRBUF_INIT,
>                 .buf =3D STRBUF_INIT,
>                 .plain =3D STRBUF_INIT,
> @@ -1922,3 +1931,99 @@ int run_add_p(struct repository *r, enum add_p_mod=
e mode,
>         add_p_state_clear(&s);
>         return 0;
>  }
> +
> +int run_add_p_index(struct repository *r,
> +                   struct index_state *index,
> +                   const char *index_file,
> +                   struct interactive_options *opts,
> +                   const char *revision,
> +                   const struct pathspec *ps)
> +{
> +       struct patch_mode mode =3D {
> +               .apply_args =3D { "--cached", NULL },
> +               .apply_check_args =3D { "--cached", NULL },
> +               .prompt_mode =3D {
> +                       N_("Stage mode change [y,n,q,a,d%s,?]? "),
> +                       N_("Stage deletion [y,n,q,a,d%s,?]? "),
> +                       N_("Stage addition [y,n,q,a,d%s,?]? "),
> +                       N_("Stage this hunk [y,n,q,a,d%s,?]? ")
> +               },
> +               .edit_hunk_hint =3D N_("If the patch applies cleanly, the=
 edited hunk "
> +                                    "will immediately be marked for stag=
ing."),
> +               .help_patch_text =3D
> +                       N_("y - stage this hunk\n"
> +                          "n - do not stage this hunk\n"
> +                          "q - quit; do not stage this hunk or any of th=
e remaining "
> +                               "ones\n"
> +                          "a - stage this hunk and all later hunks in th=
e file\n"
> +                          "d - do not stage this hunk or any of the late=
r hunks in "
> +                               "the file\n"),
> +               .index_only =3D 1,
> +       };
> +       struct add_p_state s =3D {
> +               .r =3D r,
> +               .index =3D index,
> +               .index_file =3D index_file,
> +               .answer =3D STRBUF_INIT,
> +               .buf =3D STRBUF_INIT,
> +               .plain =3D STRBUF_INIT,
> +               .colored =3D STRBUF_INIT,
> +               .mode =3D &mode,
> +               .revision =3D revision,
> +       };
> +       struct strbuf parent_revision =3D STRBUF_INIT;
> +       char parent_tree_oid[GIT_MAX_HEXSZ + 1];
> +       size_t binary_count =3D 0;
> +       struct commit *commit;
> +       int ret;
> +
> +       commit =3D lookup_commit_reference_by_name(revision);
> +       if (!commit) {
> +               err(&s, _("Revision does not refer to a commit"));
> +               ret =3D -1;
> +               goto out;
> +       }
> +
> +       if (commit->parents)
> +               oid_to_hex_r(parent_tree_oid, get_commit_tree_oid(commit-=
>parents->item));
> +       else
> +               oid_to_hex_r(parent_tree_oid, r->hash_algo->empty_tree);
> +
> +       strbuf_addf(&parent_revision, "%s~", revision);
> +       mode.diff_cmd[0] =3D "diff-tree";
> +       mode.diff_cmd[1] =3D "-r";
> +       mode.diff_cmd[2] =3D parent_tree_oid;
> +
> +       interactive_config_init(&s.cfg, r, opts);
> +
> +       if (parse_diff(&s, ps) < 0) {

I noticed run_add_p() calls discard_index() right before parse_diff()
[but it also reads/refreshes the index there]. Sounds like that's not
something we need for in-memory indices?

> +               ret =3D -1;
> +               goto out;
> +       }
> +
> +       for (size_t i =3D 0; i < s.file_diff_nr; i++) {
> +               if (s.file_diff[i].binary && !s.file_diff[i].hunk_nr)
> +                       binary_count++;
> +               else if (patch_update_file(&s, s.file_diff + i))
> +                       break;
> +       }
> +
> +       if (s.file_diff_nr =3D=3D 0) {
> +               err(&s, _("No changes."));
> +               ret =3D -1;
> +               goto out;
> +       }
> +
> +       if (binary_count =3D=3D s.file_diff_nr) {
> +               err(&s, _("Only binary files changed."));
> +               ret =3D -1;
> +               goto out;
> +       }
> +
> +       ret =3D 0;
> +
> +out:
> +       strbuf_release(&parent_revision);
> +       add_p_state_clear(&s);
> +       return ret;
> +}

This single call to add_p_state_clear() is probably easier to follow
than the original in run_add_p(). Nice.

--=20
D. Ben Knoble
