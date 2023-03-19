Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D28C7618A
	for <git@archiver.kernel.org>; Sun, 19 Mar 2023 06:12:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbjCSGMp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Mar 2023 02:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjCSGMn (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Mar 2023 02:12:43 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE96D23862
        for <git@vger.kernel.org>; Sat, 18 Mar 2023 23:12:40 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id bp27so11249144lfb.6
        for <git@vger.kernel.org>; Sat, 18 Mar 2023 23:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679206359;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0oeMVsDulE3Ct7OMDqw4BbKxYDn0YouTaKaozynzUgU=;
        b=mJX5gQuQ0WWdj+yv2kljpV6M9ccIQ1/pnzTlpU+MDLRqssnOqexKWqxphdm15O7+ud
         yu61zdZhM+lETVU5GYfQ0Vvl0sCYxvWYMmPpVEyTWMConY5UBkhrWRMa/208ctybIxZE
         wkEziuxJ/vKZq0a78LHWRyoxBdiVxJhPyZWevLbh7OOEUh/bj9F6MXomDdqLsmL7RZ5a
         4hoMrlCCL9JCSUS8hc4lyRXMRrNtGSG9Tj59FutZHai1hcT2Nmomgo8ZfOfMxrtZGp8c
         pMO+O2kJLFACSqKHghF5WcNZrMDmHWy7qjfvTauIWLKsYJYOtgQEB0973ch7wK/Sbi4f
         vGBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679206359;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0oeMVsDulE3Ct7OMDqw4BbKxYDn0YouTaKaozynzUgU=;
        b=uv6+f5SK3MfP3y10r3Xma4WaJi11QRxAdHHm5PkC7oVKOZ0OXjkQvlTRRGTpOYKeJi
         F+IZ2wfXbW5Muh7X0zmbtJSmT2yvlDxfkJIigsrIsQGejvFaTCRHXRXo3tv7xgKL3oP3
         Vog2ZgaqLR7Zc1dvfi9Qtop1JVSJJ1qas+oMbQpWSM1EDoUm3d3c/6/fCAvhH0vZIvpw
         0EEZVU0c4jU27Cu8vmc7As3Fleqh+KQpUCF49/h5SMWbqouGGJDfNcrmMbGdRysqG+5V
         yNB3ZJJJDmmn0wzW/v5C1ejA3D5g/wa/8YqVQeNLn1Fzm0JN5W/FWlSHmZ7U7s8dE8UT
         gvpg==
X-Gm-Message-State: AO0yUKX8hsrOnr+ReosMSl3nYl33ASnHaE/7q8E0gFu+13rSsuwKbG78
        M2Pu4S5bjcmLFZZKgjNIIXpLpCNTipVi+7qAbCM=
X-Google-Smtp-Source: AK7set8d9QakHwgqnCGiYDhTe38wOIps0vOS90Vi5PNCRRHdgQyzDxkrGtLZZtJK1Adc6kh5ecru4aw9M0AgB44aS+8=
X-Received: by 2002:ac2:55aa:0:b0:4d8:62e5:4f66 with SMTP id
 y10-20020ac255aa000000b004d862e54f66mr6041731lfg.7.1679206358942; Sat, 18 Mar
 2023 23:12:38 -0700 (PDT)
MIME-Version: 1.0
References: <cover-00.17-00000000000-20230317T152724Z-avarab@gmail.com> <patch-16.17-86e24add191-20230317T152725Z-avarab@gmail.com>
In-Reply-To: <patch-16.17-86e24add191-20230317T152725Z-avarab@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 18 Mar 2023 23:12:26 -0700
Message-ID: <CABPp-BGQuNhDfE24POO5d-ETZn1ajFTXE0ZZBjvccmjV7x3yGQ@mail.gmail.com>
Subject: Re: [PATCH 16/17] post-cocci: adjust comments for recent repo_* migration
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 17, 2023 at 9:22=E2=80=AFAM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarma=
son
<avarab@gmail.com> wrote:
>
> In preceding commits we changed many calls to macros that were
> providing a "the_repository" argument to invoke corresponding repo_*()
> function instead. Let's follow-up and adjust references to those in
> comments, which coccinelle didn't (and inherently can't) catch.

Nice.

> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  builtin/branch.c   | 2 +-
>  builtin/shortlog.c | 2 +-
>  cache.h            | 4 ++--
>  commit.h           | 4 ++--
>  diff.h             | 2 +-
>  object-file.c      | 2 +-
>  object-store.h     | 4 ++--
>  pretty.c           | 2 +-
>  refs.c             | 2 +-
>  sequencer.c        | 6 +++---
>  strbuf.h           | 6 +++---
>  11 files changed, 18 insertions(+), 18 deletions(-)
>
> diff --git a/builtin/branch.c b/builtin/branch.c
> index bbcfb34b3c6..45910039e6b 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -156,7 +156,7 @@ static int branch_merged(int kind, const char *name,
>         /*
>          * After the safety valve is fully redefined to "check with
>          * upstream, if any, otherwise with HEAD", we should just
> -        * return the result of the in_merge_bases() above without
> +        * return the result of the repo_in_merge_bases() above without
>          * any of the following code, but during the transition period,
>          * a gentle reminder is in order.
>          */
> diff --git a/builtin/shortlog.c b/builtin/shortlog.c
> index 62f91b8b932..f287a6acd03 100644
> --- a/builtin/shortlog.c
> +++ b/builtin/shortlog.c
> @@ -176,7 +176,7 @@ static void insert_records_from_trailers(struct short=
log *log,
>                 return;
>
>         /*
> -        * Using format_commit_message("%B") would be simpler here, but
> +        * Using repo_format_commit_message("%B") would be simpler here, =
but
>          * this saves us copying the message.
>          */
>         commit_buffer =3D repo_logmsg_reencode(the_repository, commit, NU=
LL,
> diff --git a/cache.h b/cache.h
> index d835ac8b4d2..555354e1961 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -443,7 +443,7 @@ void validate_cache_entries(const struct index_state =
*istate);
>  /*
>   * Bulk prefetch all missing cache entries that are not GITLINKs and tha=
t match
>   * the given predicate. This function should only be called if
> - * has_promisor_remote() returns true.
> + * repo_has_promisor_remote() returns true.
>   */
>  typedef int (*must_prefetch_predicate)(const struct cache_entry *);
>  void prefetch_cache_entries(const struct index_state *istate,
> @@ -1201,7 +1201,7 @@ void check_repository_format(struct repository_form=
at *fmt);
>   * terminated.
>   *
>   * The non-`_r` version returns a static buffer which remains valid unti=
l 4
> - * more calls to find_unique_abbrev are made.
> + * more calls to repo_find_unique_abbrev are made.
>   *
>   * The `_r` variant writes to a buffer supplied by the caller, which mus=
t be at
>   * least `GIT_MAX_HEXSZ + 1` bytes. The return value is the number of by=
tes
> diff --git a/commit.h b/commit.h
> index e98ee6e698e..d4adf111019 100644
> --- a/commit.h
> +++ b/commit.h
> @@ -130,7 +130,7 @@ const void *get_cached_commit_buffer(struct repositor=
y *, const struct commit *,
>  /*
>   * Get the commit's object contents, either from cache or by reading the=
 object
>   * from disk. The resulting memory should not be modified, and must be g=
iven
> - * to unuse_commit_buffer when the caller is done.
> + * to repo_unuse_commit_buffer when the caller is done.
>   */
>  const void *repo_get_commit_buffer(struct repository *r,
>                                    const struct commit *,
> @@ -139,7 +139,7 @@ const void *repo_get_commit_buffer(struct repository =
*r,
>  /*
>   * Tell the commit subsystem that we are done with a particular commit b=
uffer.
>   * The commit and buffer should be the input and return value, respectiv=
ely,
> - * from an earlier call to get_commit_buffer.  The buffer may or may not=
 be
> + * from an earlier call to repo_get_commit_buffer.  The buffer may or ma=
y not be
>   * freed by this call; callers should not access the memory afterwards.
>   */
>  void repo_unuse_commit_buffer(struct repository *r,
> diff --git a/diff.h b/diff.h
> index 8b510eb579d..0aa36e81261 100644
> --- a/diff.h
> +++ b/diff.h
> @@ -614,7 +614,7 @@ void diff_warn_rename_limit(const char *varname, int =
needed, int degraded_cc);
>  #define DIFF_STATUS_FILTER_BROKEN      'B'
>
>  /*
> - * This is different from find_unique_abbrev() in that
> + * This is different from repo_find_unique_abbrev() in that
>   * it stuffs the result with dots for alignment.
>   */
>  const char *diff_aligned_abbrev(const struct object_id *sha1, int);
> diff --git a/object-file.c b/object-file.c
> index 141cf85f25b..47c52681640 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -267,7 +267,7 @@ int hash_algo_by_length(int len)
>
>  /*
>   * This is meant to hold a *small* number of objects that you would
> - * want read_object_file() to be able to return, but yet you do not want
> + * want repo_read_object_file() to be able to return, but yet you do not=
 want
>   * to write them into the object store (e.g. a browse-only
>   * application).
>   */
> diff --git a/object-store.h b/object-store.h
> index b47849d4e7e..9217ae83064 100644
> --- a/object-store.h
> +++ b/object-store.h
> @@ -216,7 +216,7 @@ struct raw_object_store {
>         /*
>          * A fast, rough count of the number of objects in the repository=
.
>          * These two fields are not meant for direct access. Use
> -        * approximate_object_count() instead.
> +        * repo_approximate_object_count() instead.
>          */
>         unsigned long approximate_object_count;
>         unsigned approximate_object_count_valid : 1;
> @@ -343,7 +343,7 @@ void assert_oid_type(const struct object_id *oid, enu=
m object_type expect);
>
>  /*
>   * Enabling the object read lock allows multiple threads to safely call =
the
> - * following functions in parallel: repo_read_object_file(), read_object=
_file(),
> + * following functions in parallel: repo_read_object_file(),
>   * read_object_with_reference(), oid_object_info() and oid_object_info_e=
xtended().
>   *
>   * obj_read_lock() and obj_read_unlock() may also be used to protect oth=
er
> diff --git a/pretty.c b/pretty.c
> index 076d1c363e7..23ac06b93f3 100644
> --- a/pretty.c
> +++ b/pretty.c
> @@ -719,7 +719,7 @@ const char *repo_logmsg_reencode(struct repository *r=
,
>                  * Otherwise, we still want to munge the encoding header =
in the
>                  * result, which will be done by modifying the buffer. If=
 we
>                  * are using a fresh copy, we can reuse it. But if we are=
 using
> -                * the cached copy from get_commit_buffer, we need to dup=
licate it
> +                * the cached copy from repo_get_commit_buffer, we need t=
o duplicate it
>                  * to avoid munging the cached copy.
>                  */
>                 if (msg =3D=3D get_cached_commit_buffer(r, commit, NULL))
> diff --git a/refs.c b/refs.c
> index aeae31c972f..cd7537bce64 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1821,7 +1821,7 @@ const char *refs_resolve_ref_unsafe(struct ref_stor=
e *refs,
>                         return NULL;
>
>                 /*
> -                * dwim_ref() uses REF_ISBROKEN to distinguish between
> +                * repo_dwim_ref() uses REF_ISBROKEN to distinguish betwe=
en
>                  * missing refs and refs that were present but invalid,
>                  * to complain about the latter to stderr.
>                  *
> diff --git a/sequencer.c b/sequencer.c
> index aa3ebb47d98..fb5a540fa04 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -768,9 +768,9 @@ static int is_index_unchanged(struct repository *r)
>         /*
>          * If head_commit is NULL, check_commit, called from
>          * lookup_commit, would have indicated that head_commit is not
> -        * a commit object already.  parse_commit() will return failure
> +        * a commit object already.  repo_parse_commit() will return fail=
ure
>          * without further complaints in such a case.  Otherwise, if
> -        * the commit is invalid, parse_commit() will complain.  So
> +        * the commit is invalid, repo_parse_commit() will complain.  So
>          * there is nothing for us to say here.  Just return failure.
>          */
>         if (repo_parse_commit(the_repository, head_commit))
> @@ -5365,7 +5365,7 @@ static const char *label_oid(struct object_id *oid,=
 const char *label,
>          * For "uninteresting" commits, i.e. commits that are not to be
>          * rebased, and which can therefore not be labeled, we use a uniq=
ue
>          * abbreviation of the commit name. This is slightly more complic=
ated
> -        * than calling find_unique_abbrev() because we also need to make
> +        * than calling repo_find_unique_abbrev() because we also need to=
 make
>          * sure that the abbreviation does not conflict with any other
>          * label.
>          *
> diff --git a/strbuf.h b/strbuf.h
> index f6dbb9681ee..b980f9edc6d 100644
> --- a/strbuf.h
> +++ b/strbuf.h
> @@ -631,7 +631,7 @@ void strbuf_add_separated_string_list(struct strbuf *=
str,
>  void strbuf_list_free(struct strbuf **list);
>
>  /**
> - * Add the abbreviation, as generated by find_unique_abbrev, of `sha1` t=
o
> + * Add the abbreviation, as generated by repo_find_unique_abbrev(), of `=
sha1` to
>   * the strbuf `sb`.
>   */
>  struct repository;
> @@ -706,14 +706,14 @@ static inline void strbuf_complete_line(struct strb=
uf *sb)
>
>  /*
>   * Copy "name" to "sb", expanding any special @-marks as handled by
> - * interpret_branch_name(). The result is a non-qualified branch name
> + * repo_interpret_branch_name(). The result is a non-qualified branch na=
me
>   * (so "foo" or "origin/master" instead of "refs/heads/foo" or
>   * "refs/remotes/origin/master").
>   *
>   * Note that the resulting name may not be a syntactically valid refname=
.
>   *
>   * If "allowed" is non-zero, restrict the set of allowed expansions. See
> - * interpret_branch_name() for details.
> + * repo_interpret_branch_name() for details.
>   */
>  void strbuf_branchname(struct strbuf *sb, const char *name,
>                        unsigned allowed);
> --
> 2.40.0.rc1.1034.g5867a1b10c5

Looks good.
