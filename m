Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15E51FD9
	for <git@vger.kernel.org>; Wed, 27 Dec 2023 02:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AOUgyCWe"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-50e67f70f34so3486086e87.0
        for <git@vger.kernel.org>; Tue, 26 Dec 2023 18:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703643873; x=1704248673; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xb9Ymaoz2XZBWJVevjvKj81FTbFOuHU5QCAXURxpIT0=;
        b=AOUgyCWeobI0J7l/6OcJPj7zXQT7sOHF0qC2koayfob/LnqIFj4mfvF8nk972pxFoT
         ao8mmT2cFKlSYv158zWNZ167K3SwxGPdNPvwpsopwifZQz7327NQWoDL7+ORkula3ygq
         l1uu9+zNffRWZp0sol0PBRI1wPuE4DLzMxhyq6u+rzedeMtu4ul/DyEHAbkyu03IorGZ
         oW0CBenGuKLcPM/TG5UnW24Fm9r4ypkrHJ92w+0M8GqTvxqFG0xvYvrULkEyVvtdHLV3
         LCvrTWVLyXJPZwP/jmKCPRqQTr0m8n2O7LcErsuuSACKpV7KxmVbcL6WZZ3jpSSA1V+r
         XKlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703643873; x=1704248673;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xb9Ymaoz2XZBWJVevjvKj81FTbFOuHU5QCAXURxpIT0=;
        b=OraTb7qjuZ3z/JaVnfoOck87GxW+462ToKCeK01MZHZCTEcEEhnxy3NmLbSTEMO3cM
         dnKQF7VnFLtqH0XkiLJBDFEla/FUD7331g6di1GwIxqFPjY6x6so+07CM4oaynmWNsI3
         Ln5mMcBDSHQqvqBlXpT15vZfaInFEWEST4JmWg+Jwz88dfC0xIPc48Nyc+FDyjiBQdja
         VaaK6XMFjrhJiElMtxquqTO0uQZakLbqVyywYBeUtJz48WcIvKV5MUg5OlRgmZcEMpEH
         zUFykGdAStNWYgRZVvLpS+o6IlCqt8bOUF5D0KbYL15T+3ZB4mPh0Aljmvmhxa0scw7t
         HzeQ==
X-Gm-Message-State: AOJu0YxFflJNc1rX7Ki4lj48NpdHOOTvglB/QOeifZsHohlBiFcSdXeK
	GXRVXNKInyQ+ZgZNTaWcwrBpv9ZYyaW9/0LNlgI=
X-Google-Smtp-Source: AGHT+IF89m6uU6ON4ATWE1BAVGta1lniKtKTVVmP3gKl+g7pJxTE9+daeSEB8r0thrW/9ObeebH4poPeFdYcpcPr7Wo=
X-Received: by 2002:a05:6512:3745:b0:50e:27a9:167e with SMTP id
 a5-20020a056512374500b0050e27a9167emr2421484lfs.59.1703643873216; Tue, 26 Dec
 2023 18:24:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231226202102.3392518-1-sam@gentoo.org>
In-Reply-To: <20231226202102.3392518-1-sam@gentoo.org>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 26 Dec 2023 18:24:23 -0800
Message-ID: <CABPp-BFZqa2wyNUs0OfUOokGORjAguCK7-1hqK6U+SUxm8E5Lw@mail.gmail.com>
Subject: Re: [PATCH v2] diff: implement config.diff.renames=copies-harder
To: Sam James <sam@gentoo.org>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

It helps when providing a new iteration of a patch to do two things:
  (1) provide a range-diff against the previous version to make it
easier for reviewers to see what has changed
  (2) either reply to the previous submission or link to it in your
header so reviewers can find previous comments

In this case, v1 was over at
https://lore.kernel.org/git/pull.1606.git.1699010701704.gitgitgadget@gmail.=
com/.

On Tue, Dec 26, 2023 at 12:21=E2=80=AFPM Sam James <sam@gentoo.org> wrote:
>
> This patch adds a config value for 'diff.renames' called 'copies-harder'
> which make it so '-C -C' is in effect always passed for 'git log -p',
> 'git diff', etc.
>
> This allows specifying that 'git log -p', 'git diff', etc should always a=
ct
> as if '-C --find-copies-harder' was passed.
>
> It has proven this especially useful for certain types of repository (lik=
e
> Gentoo's ebuild repositories) because files are often copies of a previou=
s
> version:
>
> Suppose a directory 'sys-devel/gcc' contains recipes for building
> GCC, with one file for each supported upstream branch:
>    gcc-13.x.build.recipe
>    gcc-12.x.build.recipe
>    gcc-11.x.build.recipe
>    gcc-10.x.build.recipe
>
> gcc-13.x.build.recipe was started as a copy of gcc-12.x.build.recipe
> (which was started as a copy of gcc-11.x.build.recipe, etc.). Previous ve=
rsions
> are kept around to support parallel installation of multiple versions.
>
> Being able to easily observe the diff relative to other recipes within th=
e
> directory has been a quality of life improvement for such repo layouts.
>
> Cc: Elijah Newren <newren@gmail.com>
> Cc: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Sam James <sam@gentoo.org>

While the "Cc:" lines don't hurt, note that everything above this
point is included in the commit message, so we'd typically rather
those two lines be below the triple-dashed line.

> ---
> v2: Improve the commit message using Elijah Newren's example (it is indee=
d
> precisely what I was thinking of, but phrased better), and improve the do=
cumentation
> to explain better what the new config option actually does & refer to git=
-diff's
> --find-copies-harder.
>
>  Documentation/config/diff.txt   |  8 +++++---
>  Documentation/config/status.txt |  3 ++-
>  diff.c                          | 12 +++++++++---
>  diff.h                          |  1 +
>  diffcore-rename.c               |  4 ++--
>  merge-ort.c                     |  2 +-
>  merge-recursive.c               |  2 +-
>  7 files changed, 21 insertions(+), 11 deletions(-)
>
> diff --git a/Documentation/config/diff.txt b/Documentation/config/diff.tx=
t
> index bd5ae0c337..cdd8a74ec0 100644
> --- a/Documentation/config/diff.txt
> +++ b/Documentation/config/diff.txt
> @@ -131,9 +131,11 @@ diff.renames::
>         Whether and how Git detects renames.  If set to "false",
>         rename detection is disabled. If set to "true", basic rename
>         detection is enabled.  If set to "copies" or "copy", Git will
> -       detect copies, as well.  Defaults to true.  Note that this
> -       affects only 'git diff' Porcelain like linkgit:git-diff[1] and
> -       linkgit:git-log[1], and not lower level commands such as
> +       detect copies, as well.  If set to "copies-harder", Git will spen=
d extra
> +       cycles to find more copies even in unmodified paths, see
> +       '--find-copies-harder' in linkgit:git-diff[1]. Defaults to true.
> +       Note that this affects only 'git diff' Porcelain like linkgit:git=
-diff[1]
> +       and linkgit:git-log[1], and not lower level commands such as
>         linkgit:git-diff-files[1].
>
>  diff.suppressBlankEmpty::
> diff --git a/Documentation/config/status.txt b/Documentation/config/statu=
s.txt
> index 2ff8237f8f..7ca7a4becd 100644
> --- a/Documentation/config/status.txt
> +++ b/Documentation/config/status.txt
> @@ -33,7 +33,8 @@ status.renames::
>         Whether and how Git detects renames in linkgit:git-status[1] and
>         linkgit:git-commit[1] .  If set to "false", rename detection is
>         disabled. If set to "true", basic rename detection is enabled.
> -       If set to "copies" or "copy", Git will detect copies, as well.
> +       If set to "copies" or "copy", Git will detect copies, as well.  I=
f
> +       set to "copies-harder", Git will try harder to detect copies.

It'd be nice to have the improved text from diff.renames here ("If set
to "copies-harder", Git will spend extra cycles to find more copies
even in unmodified paths.").

>         Defaults to the value of diff.renames.
>
>  status.showStash::
> diff --git a/diff.c b/diff.c
> index a2def45644..585acf9a99 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -206,8 +206,11 @@ int git_config_rename(const char *var, const char *v=
alue)
>  {
>         if (!value)
>                 return DIFF_DETECT_RENAME;
> +       if (!strcasecmp(value, "copies-harder"))
> +               return DIFF_DETECT_COPY_HARDER;
>         if (!strcasecmp(value, "copies") || !strcasecmp(value, "copy"))
> -               return  DIFF_DETECT_COPY;
> +               return DIFF_DETECT_COPY;
> +

I pointed out in response to v1 that these last couple lines, while a
nice cleanup, should be in a separate patch.

>         return git_config_bool(var,value) ? DIFF_DETECT_RENAME : 0;
>  }
>
> @@ -4849,8 +4852,11 @@ void diff_setup_done(struct diff_options *options)
>         else
>                 options->flags.diff_from_contents =3D 0;
>
> -       if (options->flags.find_copies_harder)
> +       /* Just fold this in as it makes the patch-to-git smaller */
> +       if (options->flags.find_copies_harder || options->detect_rename =
=3D=3D DIFF_DETECT_COPY_HARDER) {

Again, I already responded to v1 that four of your lines were too long
and needed to be split.  All four remain unsplit in your resubmission.
For future reference, when you resubmit a patch, please either (a)
first respond to the review explaining why you don't agree with the
suggested changes, or (b) include the fixes reviewers point out, or
(c) state in your cover letter or explanation after the '---' why you
chose to not include the suggested changes.

> +               options->flags.find_copies_harder =3D 1;
>                 options->detect_rename =3D DIFF_DETECT_COPY;
> +       }
>
>         if (!options->flags.relative_name)
>                 options->prefix =3D NULL;
> @@ -5281,7 +5287,7 @@ static int diff_opt_find_copies(const struct option=
 *opt,
>         if (*arg !=3D 0)
>                 return error(_("invalid argument to %s"), opt->long_name)=
;
>
> -       if (options->detect_rename =3D=3D DIFF_DETECT_COPY)
> +       if (options->detect_rename =3D=3D DIFF_DETECT_COPY || options->de=
tect_rename =3D=3D DIFF_DETECT_COPY_HARDER)
>                 options->flags.find_copies_harder =3D 1;
>         else
>                 options->detect_rename =3D DIFF_DETECT_COPY;
> diff --git a/diff.h b/diff.h
> index 66bd8aeb29..b29e5b777f 100644
> --- a/diff.h
> +++ b/diff.h
> @@ -555,6 +555,7 @@ int git_config_rename(const char *var, const char *va=
lue);
>
>  #define DIFF_DETECT_RENAME     1
>  #define DIFF_DETECT_COPY       2
> +#define DIFF_DETECT_COPY_HARDER 3
>
>  #define DIFF_PICKAXE_ALL       1
>  #define DIFF_PICKAXE_REGEX     2
> diff --git a/diffcore-rename.c b/diffcore-rename.c
> index 5a6e2bcac7..856291d66f 100644
> --- a/diffcore-rename.c
> +++ b/diffcore-rename.c
> @@ -299,7 +299,7 @@ static int find_identical_files(struct hashmap *srcs,
>                 }
>                 /* Give higher scores to sources that haven't been used a=
lready */
>                 score =3D !source->rename_used;
> -               if (source->rename_used && options->detect_rename !=3D DI=
FF_DETECT_COPY)
> +               if (source->rename_used && options->detect_rename !=3D DI=
FF_DETECT_COPY && options->detect_rename !=3D DIFF_DETECT_COPY_HARDER)
>                         continue;
>                 score +=3D basename_same(source, target);
>                 if (score > best_score) {
> @@ -1405,7 +1405,7 @@ void diffcore_rename_extended(struct diff_options *=
options,
>         trace2_region_enter("diff", "setup", options->repo);
>         info.setup =3D 0;
>         assert(!dir_rename_count || strmap_empty(dir_rename_count));
> -       want_copies =3D (detect_rename =3D=3D DIFF_DETECT_COPY);
> +       want_copies =3D (detect_rename =3D=3D DIFF_DETECT_COPY || detect_=
rename =3D=3D DIFF_DETECT_COPY_HARDER);
>         if (dirs_removed && (break_idx || want_copies))
>                 BUG("dirs_removed incompatible with break/copy detection"=
);
>         if (break_idx && relevant_sources)
> diff --git a/merge-ort.c b/merge-ort.c
> index 6491070d96..7749835465 100644
> --- a/merge-ort.c
> +++ b/merge-ort.c
> @@ -4782,7 +4782,7 @@ static void merge_start(struct merge_options *opt, =
struct merge_result *result)
>          * sanity check them anyway.
>          */
>         assert(opt->detect_renames >=3D -1 &&
> -              opt->detect_renames <=3D DIFF_DETECT_COPY);
> +              opt->detect_renames <=3D DIFF_DETECT_COPY_HARDER);
>         assert(opt->verbosity >=3D 0 && opt->verbosity <=3D 5);
>         assert(opt->buffer_output <=3D 2);
>         assert(opt->obuf.len =3D=3D 0);
> diff --git a/merge-recursive.c b/merge-recursive.c
> index e3beb0801b..d52dd53660 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -3708,7 +3708,7 @@ static int merge_start(struct merge_options *opt, s=
truct tree *head)
>         assert(opt->branch1 && opt->branch2);
>
>         assert(opt->detect_renames >=3D -1 &&
> -              opt->detect_renames <=3D DIFF_DETECT_COPY);
> +              opt->detect_renames <=3D DIFF_DETECT_COPY_HARDER);
>         assert(opt->detect_directory_renames >=3D MERGE_DIRECTORY_RENAMES=
_NONE &&
>                opt->detect_directory_renames <=3D MERGE_DIRECTORY_RENAMES=
_TRUE);
>         assert(opt->rename_limit >=3D -1);
> --
> 2.43.0

The patch looks close, but it does continue to violate style
guidelines and make unrelated changes, like v1.  And the wording in
one of the documentation blurbs could be improved a little.  Looking
forward to a v3 with those fixed.
