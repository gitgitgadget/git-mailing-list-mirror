Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91083AA1A0
	for <git@vger.kernel.org>; Tue, 11 Nov 2025 13:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762866098; cv=none; b=QqAaC8F11j2HNStZPRVxB8/zJ0C5mKwJ0MxknLxG7yfBZ2Je3kp7UHzEGZLliSnjAEqP1PpK8TDlslebyNG0S27Ea/sP5hcO9xuyBcXmE4HExogKesC/9vQiehUA1S4KPb0+boYT4X5i2JJ/PVrW/asKnuHpuPAXW9lfyXYwlUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762866098; c=relaxed/simple;
	bh=F8mxozdoKiPG2jjGBAKDNI77QVMCuYOTullLTzrux9k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PZ8pUgv1QDxpuYMVTNtrfIMzxZUZj6wnCIGX1Ai8bmY/henChrSZ4Vxz7FkqozkysN9FtmqbV6h6Rxl1aAYfB4k/l5vBAe64dU3tsbk8imFVv6QJNlcUTp4NY0q2BkPUXvu2bNBbjaqNu59c1p7ilgz2UC4WCAK0c4oawf3P1a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IAjmIK+a; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IAjmIK+a"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-64198771a9bso3685854a12.2
        for <git@vger.kernel.org>; Tue, 11 Nov 2025 05:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762866094; x=1763470894; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wJyFzgQeAgGpUp4j6wEEHw5+QWznB18q8TRVAib+3mM=;
        b=IAjmIK+aGUjWM1kShU3kH5lD1gtjwWmhs8iL+WbUZ+6ZN5h7uIr4VgX2BUn5izHhPh
         vhZ18jJgmTM76LxeCMlNU2wi9GadZ33/PouyLBf+2JJU9N175+Z0vnlJmcFVD3NZmyR6
         PVbvU+DWn8MWSxXp4Eo7LYj6G/sSS8um2dL9q2frFjPUmbsfS2vRNEdabRI86KwBK8nH
         8BlNgPEHmQhwIp3XMl7vbcxuomqXNWf9mCrwgOrqOER7zOgMIOfsxPRNfj5ELgF2bp+l
         hrUYWBKJcyCYswdMuuZy0upyOhmV0kKIToIY5SF2FkiUZuycrmHnpFpj3gc7yriTpgrK
         6ekw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762866094; x=1763470894;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wJyFzgQeAgGpUp4j6wEEHw5+QWznB18q8TRVAib+3mM=;
        b=T0jcj1ce1oflr8uCSfc7Ysa97RnmqF0PK42wEIm5qQuOa/imDRt6FNk8YxKcSHSmeU
         OW4/81gvA0/FMkvEtiv+UBz8MV/NiRGw5nSFSHMHSYfKNoVVgb3i6mxEEQDbqT44RdID
         gaKXDeC+QtYKReDS3wp91AohZjP4lQ8hOP726opV1GICHTDTHJcKS+UiV2RECR4ucmHd
         0d0qLMeIQTJJ0ka7rC+U5esMNjzy1+Mb+oaKoxC5AsM7IUJXmPQWn3rKfXhafFEiLLXP
         4X7K4TGe6bSuUfUoZ2ec/0YaEFAgtDy0P9qNT5ReNcWE8+T0ZSZci3hzaEkIHLUg9e3h
         /qWA==
X-Forwarded-Encrypted: i=1; AJvYcCWGJDpDdOjdrVcOTMC41lujflN2duSMIurZGIk6T8R21S7xJHZ73i9+MQy0/dfPDfjJ3cs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIwaf/MejfiDpYdHWOFreCA/uVMA8iFdY0vvXHVGfcUEIkUiwG
	FbZB0XEoVea+cOq/J9UhupS3cGkbFOKbdBBfA46R5svkCZJVSHFFet3ALE4WVTNUJRmvPiEnZNl
	urGaTHyJ15qZC3ZjTkSzg/uAftSQAUd0=
X-Gm-Gg: ASbGncsV3I0OE4x6NNWkTJ1lPBkrnzxR+q51LMSinDzNkfJ95E9eSnO+dO9nBSYDUL9
	lZZJE7EBT8RhPWG8Q2MzuCcMTfWegW0F3KNMjN3BLNAwWCXAPEKXlt0Iol+f9Reppj8V43yn22U
	cncLSuJAFk+CpYnzo58Xnmopd/S5bqu6ucYjXIRt6gCBLJ/n8E4C4iYXFgVKiAPn29nuDdP4P6u
	yrxjoK9f3PTDzMpzUnHjp9pTwQF3u88JYLdVHV/HiQ2J7Pf/ZSIy/2rPw==
X-Google-Smtp-Source: AGHT+IFogwSypQ1oze1DZJckeexVk23o3G3u8JBJj3rztmFXOiiZK4KIwQQeIKvgKrFFZNcX7rOKgICjOc13gkwbkf4=
X-Received: by 2002:a05:6402:2714:b0:63c:533f:4b25 with SMTP id
 4fb4d7f45d1cf-6415dc1ae7bmr10581160a12.15.1762866093678; Tue, 11 Nov 2025
 05:01:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1997.git.1762683774166.gitgitgadget@gmail.com> <6be20c41-15a0-4732-bd12-4927a59a9f59@gmail.com>
In-Reply-To: <6be20c41-15a0-4732-bd12-4927a59a9f59@gmail.com>
From: ZheNing Hu <adlternative@gmail.com>
Date: Tue, 11 Nov 2025 21:01:22 +0800
X-Gm-Features: AWmQ_bkz07_W9efGzawz23vx1arXleLvPBHcOwzhrkZ6sIweXriN7v0jLxapYJg
Message-ID: <CAOLTT8TPrNTCjHwJfdeei+t8+7AxGC-dvbq-4oHJ=qNn_c+-jQ@mail.gmail.com>
Subject: Re: [PATCH] commit: add --committer option
To: phillip.wood@dunelm.org.uk
Cc: ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Phillip Wood <phillip.wood123@gmail.com> =E4=BA=8E2025=E5=B9=B411=E6=9C=881=
1=E6=97=A5=E5=91=A8=E4=BA=8C 00:50=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi ZheNing
>
> On 09/11/2025 10:22, ZheNing Hu via GitGitGadget wrote:
> > From: ZheNing Hu <adlternative@gmail.com>
> >
> >
> >      This patch introduces the --committer option to git-commit, provid=
ing:
> >
> >       1. Consistency with the existing --author option
> >       2. A more convenient alternative to environment variables
> >       3. Better support for automated workflows and scripts
> >       4. Improved user experience when managing multiple identities
>
> What's the use case for the same person committing under different
> identities? We already have a config mechanism to set different
> identities for different repositories but I'm struggling to see why
> someone would want to create commits under multiple identities in a
> single repository. For scripts it easy enough to set the relevant
> environment variables if a tool wants to create commits under its own
> identity.
>

I frequently need to distinguish between different user.name and user.email
configurations on our company's internal GitHub.

The current problems are:

When I misconfigure (which happens occasionally), git commit --author only =
fixes
the author part, I still need to additionally set GIT_COMMITTER_NAME and
GIT_COMMITTER_EMAIL environment variables to fix the committer information
These environment variables are painful to use, requiring manual setup
every time

If a --committer option could be provided to align with --author, users wou=
ldn't
need to remember and use these additional environment variables.
This would greatly simplify the workflow and reduce cognitive overhead.


> Thanks
>
> Phillip
>
> >      The implementation follows the same pattern as the --author option=
,
> >      accepting the format "Name " and properly validating the input.
> >
> > Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1997%=
2Fadlternative%2Fzh%2Fimplement-committer-option-v1
> > Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1997/adl=
ternative/zh/implement-committer-option-v1
> > Pull-Request: https://github.com/gitgitgadget/git/pull/1997
> >
> >   Documentation/git-commit.adoc |  9 +++-
> >   builtin/commit.c              | 58 ++++++++++++++++++++++++-
> >   t/t7509-commit-authorship.sh  | 80 ++++++++++++++++++++++++++++++++++=
+
> >   3 files changed, 144 insertions(+), 3 deletions(-)
> >
> > diff --git a/Documentation/git-commit.adoc b/Documentation/git-commit.a=
doc
> > index 54c207ad45..a015c8328e 100644
> > --- a/Documentation/git-commit.adoc
> > +++ b/Documentation/git-commit.adoc
> > @@ -12,7 +12,7 @@ git commit [-a | --interactive | --patch] [-s] [-v] [=
-u[<mode>]] [--amend]
> >          [--dry-run] [(-c | -C | --squash) <commit> | --fixup [(amend|r=
eword):]<commit>]
> >          [-F <file> | -m <msg>] [--reset-author] [--allow-empty]
> >          [--allow-empty-message] [--no-verify] [-e] [--author=3D<author=
>]
> > -        [--date=3D<date>] [--cleanup=3D<mode>] [--[no-]status]
> > +        [--date=3D<date>] [--committer=3D<committer>] [--cleanup=3D<mo=
de>] [--[no-]status]
> >          [-i | -o] [--pathspec-from-file=3D<file> [--pathspec-file-nul]=
]
> >          [(--trailer <token>[(=3D|:)<value>])...] [-S[<keyid>]]
> >          [--] [<pathspec>...]
> > @@ -181,6 +181,13 @@ See linkgit:git-rebase[1] for details.
> >   `--date=3D<date>`::
> >       Override the author date used in the commit.
> >
> > +`--committer=3D<committer>`::
> > +     Override the committer for the commit. Specify an explicit commit=
ter using the
> > +     standard `A U Thor <committer@example.com>` format. Otherwise _<c=
ommitter>_
> > +     is assumed to be a pattern and is used to search for an existing
> > +     commit by that author (i.e. `git rev-list --all -i --author=3D<co=
mmitter>`);
> > +     the commit author is then copied from the first such commit found=
.
> > +
> >   `-m <msg>`::
> >   `--message=3D<msg>`::
> >       Use _<msg>_ as the commit message.
> > diff --git a/builtin/commit.c b/builtin/commit.c
> > index 0243f17d53..88e77cbaab 100644
> > --- a/builtin/commit.c
> > +++ b/builtin/commit.c
> > @@ -49,7 +49,7 @@ static const char * const builtin_commit_usage[] =3D =
{
> >          "           [--dry-run] [(-c | -C | --squash) <commit> | --fix=
up [(amend|reword):]<commit>]\n"
> >          "           [-F <file> | -m <msg>] [--reset-author] [--allow-e=
mpty]\n"
> >          "           [--allow-empty-message] [--no-verify] [-e] [--auth=
or=3D<author>]\n"
> > -        "           [--date=3D<date>] [--cleanup=3D<mode>] [--[no-]sta=
tus]\n"
> > +        "           [--date=3D<date>] [--committer=3D<committer>] [--c=
leanup=3D<mode>] [--[no-]status]\n"
> >          "           [-i | -o] [--pathspec-from-file=3D<file> [--pathsp=
ec-file-nul]]\n"
> >          "           [(--trailer <token>[(=3D|:)<value>])...] [-S[<keyi=
d>]]\n"
> >          "           [--] [<pathspec>...]"),
> > @@ -112,6 +112,7 @@ static enum {
> >   } commit_style;
> >
> >   static const char *force_author;
> > +static const char *force_committer;
> >   static char *logfile;
> >   static char *template_file;
> >   /*
> > @@ -690,6 +691,48 @@ static void determine_author_info(struct strbuf *a=
uthor_ident)
> >       free(date);
> >   }
> >
> > +static void determine_committer_info(struct strbuf *committer_ident)
> > +{
> > +     char *name, *email, *date;
> > +     struct ident_split committer;
> > +
> > +     name =3D xstrdup_or_null(getenv("GIT_COMMITTER_NAME"));
> > +     email =3D xstrdup_or_null(getenv("GIT_COMMITTER_EMAIL"));
> > +     date =3D xstrdup_or_null(getenv("GIT_COMMITTER_DATE"));
> > +
> > +     if (force_committer) {
> > +             struct ident_split ident;
> > +
> > +             if (split_ident_line(&ident, force_committer, strlen(forc=
e_committer)) < 0)
> > +                     die(_("malformed --committer parameter"));
> > +             set_ident_var(&name, xmemdupz(ident.name_begin, ident.nam=
e_end - ident.name_begin));
> > +             set_ident_var(&email, xmemdupz(ident.mail_begin, ident.ma=
il_end - ident.mail_begin));
> > +
> > +             if (ident.date_begin) {
> > +                     struct strbuf date_buf =3D STRBUF_INIT;
> > +                     strbuf_addch(&date_buf, '@');
> > +                     strbuf_add(&date_buf, ident.date_begin, ident.dat=
e_end - ident.date_begin);
> > +                     strbuf_addch(&date_buf, ' ');
> > +                     strbuf_add(&date_buf, ident.tz_begin, ident.tz_en=
d - ident.tz_begin);
> > +                     set_ident_var(&date, strbuf_detach(&date_buf, NUL=
L));
> > +             }
> > +     }
> > +
> > +     if (force_date) {
> > +             struct strbuf date_buf =3D STRBUF_INIT;
> > +             if (parse_force_date(force_date, &date_buf))
> > +                     die(_("invalid date format: %s"), force_date);
> > +             set_ident_var(&date, strbuf_detach(&date_buf, NULL));
> > +     }
> > +
> > +     strbuf_addstr(committer_ident, fmt_ident(name, email, WANT_COMMIT=
TER_IDENT, date,
> > +                             IDENT_STRICT));
> > +     assert_split_ident(&committer, committer_ident);
> > +     free(name);
> > +     free(email);
> > +     free(date);
> > +}
> > +
> >   static int author_date_is_interesting(void)
> >   {
> >       return author_message || force_date;
> > @@ -1321,6 +1364,9 @@ static int parse_and_validate_options(int argc, c=
onst char *argv[],
> >       if (force_author && renew_authorship)
> >               die(_("options '%s' and '%s' cannot be used together"), "=
--reset-author", "--author");
> >
> > +     if (force_committer && !strchr(force_committer, '>'))
> > +             force_committer =3D find_author_by_nickname(force_committ=
er);
> > +
> >       if (logfile || have_option_m || use_message)
> >               use_editor =3D 0;
> >
> > @@ -1709,6 +1755,7 @@ int cmd_commit(int argc,
> >               OPT_FILENAME('F', "file", &logfile, N_("read message from=
 file")),
> >               OPT_STRING(0, "author", &force_author, N_("author"), N_("=
override author for commit")),
> >               OPT_STRING(0, "date", &force_date, N_("date"), N_("overri=
de date for commit")),
> > +             OPT_STRING(0, "committer", &force_committer, N_("committe=
r"), N_("override committer for commit")),
> >               OPT_CALLBACK('m', "message", &message, N_("message"), N_(=
"commit message"), opt_parse_m),
> >               OPT_STRING('c', "reedit-message", &edit_message, N_("comm=
it"), N_("reuse and edit message from specified commit")),
> >               OPT_STRING('C', "reuse-message", &use_message, N_("commit=
"), N_("reuse message from specified commit")),
> > @@ -1785,6 +1832,7 @@ int cmd_commit(int argc,
> >
> >       struct strbuf sb =3D STRBUF_INIT;
> >       struct strbuf author_ident =3D STRBUF_INIT;
> > +     struct strbuf committer_ident =3D STRBUF_INIT;
> >       const char *index_file, *reflog_msg;
> >       struct object_id oid;
> >       struct commit_list *parents =3D NULL;
> > @@ -1930,8 +1978,13 @@ int cmd_commit(int argc,
> >               append_merge_tag_headers(parents, &tail);
> >       }
> >
> > +     if (force_committer) {
> > +             determine_committer_info(&committer_ident);
> > +     }
> > +
> >       if (commit_tree_extended(sb.buf, sb.len, &the_repository->index->=
cache_tree->oid,
> > -                              parents, &oid, author_ident.buf, NULL,
> > +                              parents, &oid, author_ident.buf,
> > +                              force_committer ? committer_ident.buf : =
NULL,
> >                                sign_commit, extra)) {
> >               rollback_index_files();
> >               die(_("failed to write commit object"));
> > @@ -1980,6 +2033,7 @@ cleanup:
> >       free_commit_extra_headers(extra);
> >       free_commit_list(parents);
> >       strbuf_release(&author_ident);
> > +     strbuf_release(&committer_ident);
> >       strbuf_release(&err);
> >       strbuf_release(&sb);
> >       free(logfile);
> > diff --git a/t/t7509-commit-authorship.sh b/t/t7509-commit-authorship.s=
h
> > index 8e373b566b..45527f6a70 100755
> > --- a/t/t7509-commit-authorship.sh
> > +++ b/t/t7509-commit-authorship.sh
> > @@ -12,6 +12,11 @@ author_header () {
> >       sed -n -e '/^$/q' -e '/^author /p'
> >   }
> >
> > +committer_header () {
> > +     git cat-file commit "$1" |
> > +     sed -n -e '/^$/q' -e '/^committer /p'
> > +}
> > +
> >   message_body () {
> >       git cat-file commit "$1" |
> >       sed -e '1,/^$/d'
> > @@ -171,4 +176,79 @@ test_expect_success '--reset-author with CHERRY_PI=
CK_HEAD' '
> >       test_cmp expect actual
> >   '
> >
> > +test_expect_success '--committer option overrides committer' '
> > +     git checkout Initial &&
> > +     echo "Test --committer" >>foo &&
> > +     test_tick &&
> > +     git commit -a -m "test committer" --committer=3D"Custom Committer=
 <custom@committer.example>" &&
> > +     committer_header HEAD >actual &&
> > +     grep "Custom Committer <custom@committer.example>" actual
> > +'
> > +
> > +test_expect_success '--committer with pattern search' '
> > +     echo "Test committer pattern" >>foo &&
> > +     test_tick &&
> > +     git commit -a -m "test committer pattern" --committer=3D"Frigate"=
 &&
> > +     committer_header HEAD >actual &&
> > +     grep "Frigate <flying@over.world>" actual
> > +'
> > +
> > +test_expect_success '--committer malformed parameter' '
> > +     echo "Test malformed" >>foo &&
> > +     test_tick &&
> > +     test_must_fail git commit -a -m "test malformed" --committer=3D"m=
alformed committer"
> > +'
> > +
> > +test_expect_success '--committer with --amend option' '
> > +     git checkout -f Initial &&
> > +     echo "Test committer with amend" >>foo &&
> > +     test_tick &&
> > +     git commit -a -m "initial commit for amend test" &&
> > +     echo "Modified for amend" >>foo &&
> > +     test_tick &&
> > +     git commit -a --amend --no-edit \
> > +             --author=3D"Test Author <test@author.example>" \
> > +             --committer=3D"Test Committer <test@committer.example>" &=
&
> > +     author_header HEAD >actual_author &&
> > +     grep "Test Author <test@author.example>" actual_author &&
> > +     committer_header HEAD >actual_committer &&
> > +     grep "Test Committer <test@committer.example>" actual_committer
> > +'
> > +
> > +test_expect_success 'GIT_COMMITTER_* environment variables' '
> > +     git checkout -f Initial &&
> > +     echo "Test env vars" >>foo &&
> > +     test_tick &&
> > +     GIT_COMMITTER_NAME=3D"Env Committer" \
> > +     GIT_COMMITTER_EMAIL=3D"env@test.example" \
> > +     git commit -a -m "test committer env vars" &&
> > +     committer_header HEAD >actual &&
> > +     grep "Env Committer <env@test.example>" actual
> > +'
> > +
> > +test_expect_success '--committer overrides GIT_COMMITTER_* environment=
 variables' '
> > +     echo "Test override" >>foo &&
> > +     test_tick &&
> > +     GIT_COMMITTER_NAME=3D"Env Committer" \
> > +     GIT_COMMITTER_EMAIL=3D"env@test.example" \
> > +     git commit -a -m "test override" \
> > +             --committer=3D"Override Committer <override@test.example>=
" &&
> > +     committer_header HEAD >actual &&
> > +     grep "Override Committer <override@test.example>" actual
> > +'
> > +
> > +test_expect_success '--date with --committer changes both author and c=
ommitter dates' '
> > +     git checkout -f Initial &&
> > +     echo "Test date override" >>foo &&
> > +     test_tick &&
> > +     git commit -a -m "test date" \
> > +             --author=3D"Date Author <date@author.example>" \
> > +             --committer=3D"Date Committer <date@committer.example>" \
> > +             --date=3D"2024-06-15 10:30:00 +0800" &&
> > +     git log -1 --format=3D"%ai" >author_date &&
> > +     git log -1 --format=3D"%ci" >committer_date &&
> > +     grep "2024-06-15 10:30:00 +0800" author_date &&
> > +     grep "2024-06-15 10:30:00 +0800" committer_date
> > +'
> > +
> >   test_done
> >
> > base-commit: 4badef0c3503dc29059d678abba7fac0f042bc84
>
