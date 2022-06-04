Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3FB5C43334
	for <git@archiver.kernel.org>; Sat,  4 Jun 2022 13:12:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348035AbiFDNMY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Jun 2022 09:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347023AbiFDNMW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Jun 2022 09:12:22 -0400
Received: from smtp-out-1.talktalk.net (smtp-out-1.talktalk.net [62.24.135.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB876315
        for <git@vger.kernel.org>; Sat,  4 Jun 2022 06:12:20 -0700 (PDT)
Received: from app-12.app.tt.ham.xion.oxcs.net ([185.74.64.161])
        by smtp.talktalk.net with SMTP
        id xTZingiVnBJ1LxTZinsKdJ; Sat, 04 Jun 2022 14:12:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1654348339;
        bh=LqWWrzr5K7f7A/hsC2XoQK1MYmBhnwBTt4LUDQ6NfgI=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject;
        b=nBf08rGmqDq+yFsgtlpHD1gda8YKNoGY5XFjMBAiyEAykNXhJLq/FPn28yfvOoD+s
         Ma9X768Ewc3h1PaE86jlOkaoao1C8uE5Hqyl86bmDt55uTbc2paMgpxJExqFT3ojG2
         Jk9vkKFwObVat5P9z+BHVkZY+1L/5VRhdAk/Otto=
Date:   Sat, 4 Jun 2022 14:12:18 +0100 (BST)
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Jinoh Kang <luke1337@theori.io>,
        Glen Choo <chooglen@google.com>, Paul Tan <pyokagan@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        Jeff Smith <whydoubt@gmail.com>, Taylor Blau <me@ttaylorr.com>
Message-ID: <1340013130.540405.1654348338278@apps.talktalk.co.uk>
In-Reply-To: <RFC-patch-15.15-16bd2270b4c-20220603T183608Z-avarab@gmail.com>
References: <RFC-cover-00.15-00000000000-20220603T183608Z-avarab@gmail.com>
 <RFC-patch-15.15-16bd2270b4c-20220603T183608Z-avarab@gmail.com>
Subject: Re: [RFC PATCH 15/15] config.mak.dev: add and use
 ASSERT_FOR_FANALYZER() macro
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev79
X-Originating-IP: 31.185.185.192
X-Originating-Client: open-xchange-appsuite
X-CMAE-Envelope: MS4wfGNw1cbG0cLpE/3XcoHNKKYXdHxUdnqIZIzW6PKoFw1C37UH5Y3DnEU+W5H3USqe3MEE6BRlgJ6tJeW+HnsL3NR47XQf6tSL61rNkcs5W4Y4O19o8gT5
 4K0P/bduzJKEhFo0qTyKsE2RYgmE4WXWMav6VkDkxO16vqFj2mlixKPJ5raqVGpG3rhGU4m2wB+tqVUCiGxLzs6OzFrX4on6N+yUN6m9QHhnMt3ZKdKsLWqG
 Qckg68JeBIuis9n4Aq1HSnB2Bpzgcli0o4oWRZCJ+i9nR3MJ0ZBj5tdpCjd1DXquOpLb2Ow4GwwzFFsDr6WU3G9zVDoa5ps3E6mq0h+aHItRV458nyTk9A0G
 XKIL8Lls5di9LbH3uEjzFJ7C7aOTT35JUm6vNfrdyQkATcHE4cic/g33RlS1O4PRE4zCIZk9KLL0koPN23Jsz2H7xNN0215iApJKCREgkyuIbLqYuYoMkRK9
 TdeMd58PMjvyDE+q
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 03 June 2022 at 19:37 =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@g=
mail.com> wrote:
>=20
>=20
> Add an ASSERT_FOR_FANALYZER() macro to quiet those -fanalyzer issues

If the purpose of the macro is to silence -fanalyzer then it would perhaps =
be better to name it after that purpose rather than the way that it is impl=
emented. SILENCE_FANALYZER_WARNING() or something like that.

> that haven't been diagnosed yet to either change the code involved, or
> to add an assert() or BUG() to it to placate GCC v12's -fanalyzer
> mode.
>=20
> As in the preceding commit we could also use -Wno-error=3D* here, which
> was the initial implementation in config.mak.dev, i.e. something like:
>=20
> =09## -Wno-error=3Danalyzer-null-dereference
> =09$(eval $(call fn_disable_analyzer, \
> =09=09-Wno-error=3Danalyzer-null-dereference, \
> =09=09dir \
> =09=09gpg-interface \
> =09=09graph \
> =09=09range-diff \
> =09=09utf8 \
> =09))
> =09## -Wno-error=3Danalyzer-null-dereference: pre-gcc12
> =09ifeq ($(filter gcc12,$(COMPILER_FEATURES)),)
> =09$(eval $(call fn_disable_analyzer, \
> =09=09-Wno-error=3Danalyzer-null-dereference, \
> =09=09merge \
> =09=09builtin/name-rev \
> =09))
> =09endif
>=20
> But any such approach will unfortunately quiet *all* in the relevant
> files, including any new ones. Instead we want to quiet specific
> issues involved with ASSERT_FOR_FANALYZER().

I had a hard time understanding this, maybe

But any such approach will unfortunately miss any new warnings as it silenc=
es them for the whole file.

Best Wishes

Phillip

>=20
> A drawback of this overall approach is that this only works under
> e.g. CFLAGS=3D-O0, but not CFLAGS=3D-O3. The compiler takes the liberty t=
o
> re-arrange our code to get around these assert()s, and other new
> issues will also crop up. All of this is expected (-fanalyzer is
> subject to optimization passes, like most other options), but let's
> focus on -O0 for now.
>=20
> Commentary on specific cases:
>=20
>  * builtin/name-rev.c: Since 45a14f578e1 (Revert "name-rev: release
>    unused name strings", 2022-04-22) GCC v12's -fanalyzer has complained
>    about this code, per Ren=C3=A9's analysis in [1] it's incorrect to do
>    so. So let's add an ASSERT_FOR_FANALYZER() to placate it.
>=20
>  * graph.c: In 0f0f389f120 (graph: tidy up display of left-skewed
>    merges, 2019-10-15) a previous "assert" was removed, and another
>    unconditional deference of the return value of
>    first_interesting_parent() was added without checking it. Since it
>    can return NULL let's add ASSERT_FOR_FANALYZER()'s here to note for
>    -fanalyzer that we won't be dereferencing these in practice.
>=20
> 1. https://lore.kernel.org/git/dece627d-ccf8-2375-0c50-c59637e561d3@web.d=
e/
>=20
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  builtin/name-rev.c |  1 +
>  config.mak.dev     |  4 ++++
>  dir.c              |  1 +
>  git-compat-util.h  | 16 ++++++++++++++++
>  gpg-interface.c    |  2 ++
>  graph.c            |  2 ++
>  line-log.c         |  2 ++
>  unpack-trees.c     |  1 +
>  utf8.c             |  1 +
>  9 files changed, 30 insertions(+)
>=20
> diff --git a/builtin/name-rev.c b/builtin/name-rev.c
> index 02ea9d16330..419159961b9 100644
> --- a/builtin/name-rev.c
> +++ b/builtin/name-rev.c
> @@ -223,6 +223,7 @@ static void name_rev(struct commit *start_commit,
>  =09=09=09if (commit_is_before_cutoff(parent))
>  =09=09=09=09continue;
> =20
> +=09=09=09ASSERT_FOR_FANALYZER(name);
>  =09=09=09if (parent_number > 1) {
>  =09=09=09=09generation =3D 0;
>  =09=09=09=09distance =3D name->distance + MERGE_TRAVERSAL_WEIGHT;
> diff --git a/config.mak.dev b/config.mak.dev
> index d6f5be92297..1d47fc04163 100644
> --- a/config.mak.dev
> +++ b/config.mak.dev
> @@ -83,6 +83,10 @@ endif
> =20
>  DEVELOPER_CFLAGS +=3D -fanalyzer
> =20
> +ifeq ($(filter no-suppress-analyzer,$(DEVOPTS)),)
> +DEVELOPER_CFLAGS +=3D -DSUPPRESS_FSANITIZER
> +endif
> +
>  ## -fanalyzer exists exists as of gcc10, but versions older than gcc12
>  ## have a lot of false positives.
>  ifeq ($(filter gcc12,$(COMPILER_FEATURES)),)
> diff --git a/dir.c b/dir.c
> index 3633c0852ee..c80b584b4a7 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -3781,6 +3781,7 @@ static void invalidate_one_directory(struct untrack=
ed_cache *uc,
>  =09=09=09=09     struct untracked_cache_dir *ucd)
>  {
>  =09uc->dir_invalidated++;
> +=09ASSERT_FOR_FANALYZER(ucd);
>  =09ucd->valid =3D 0;
>  =09ucd->untracked_nr =3D 0;
>  }
> diff --git a/git-compat-util.h b/git-compat-util.h
> index 96293b6c43a..a553884c048 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -984,6 +984,21 @@ static inline unsigned long cast_size_t_to_ulong(siz=
e_t a)
>  =09return (unsigned long)a;
>  }
> =20
> +/**
> + * Transitory helper macro to quiet currently known GCC -fsanitizer
> + * issues.
> + *
> + * We lie to it and say that we're confident that the given "expr" to
> + * ASSERT_FOR_FANALYZER() cannot be NULL (or 0). Those
> + * grandfathered-in issues should be fixed, but at least we're
> + * stemming the tide.
> + */
> +#ifdef SUPPRESS_FSANITIZER
> +#define ASSERT_FOR_FANALYZER(expr) assert((expr))
> +#else
> +#define ASSERT_FOR_FANALYZER(expr) do {} while (0)
> +#endif
> +
>  #ifdef HAVE_ALLOCA_H
>  # include <alloca.h>
>  # define xalloca(size)      (alloca(size))
> @@ -1037,6 +1052,7 @@ int xstrncmpz(const char *s, const char *t, size_t =
len);
>  =09BUILD_ASSERT_OR_ZERO(sizeof(*(dst)) =3D=3D sizeof(*(src))))
>  static inline void copy_array(void *dst, const void *src, size_t n, size=
_t size)
>  {
> +=09ASSERT_FOR_FANALYZER(dst);
>  =09if (n)
>  =09=09memcpy(dst, src, st_mult(size, n));
>  }
> diff --git a/gpg-interface.c b/gpg-interface.c
> index 280f1fa1a58..9cba3b86e45 100644
> --- a/gpg-interface.c
> +++ b/gpg-interface.c
> @@ -242,6 +242,7 @@ static void parse_gpg_output(struct signature_check *=
sigc)
>  =09=09=09=09=09next =3D strchrnul(line, ' ');
>  =09=09=09=09=09replace_cstring(&sigc->key, line, next);
>  =09=09=09=09=09/* Do we have signer information? */
> +=09=09=09=09=09ASSERT_FOR_FANALYZER(next);
>  =09=09=09=09=09if (*next && (sigcheck_gpg_status[i].flags & GPG_STATUS_U=
ID)) {
>  =09=09=09=09=09=09line =3D next + 1;
>  =09=09=09=09=09=09next =3D strchrnul(line, '\n');
> @@ -283,6 +284,7 @@ static void parse_gpg_output(struct signature_check *=
sigc)
>  =09=09=09=09=09 */
>  =09=09=09=09=09limit =3D strchrnul(line, '\n');
>  =09=09=09=09=09for (j =3D 9; j > 0; j--) {
> +=09=09=09=09=09=09ASSERT_FOR_FANALYZER(next);
>  =09=09=09=09=09=09if (!*next || limit <=3D next)
>  =09=09=09=09=09=09=09break;
>  =09=09=09=09=09=09line =3D next + 1;
> diff --git a/graph.c b/graph.c
> index 568b6e7cd41..39f7e95d4ab 100644
> --- a/graph.c
> +++ b/graph.c
> @@ -1105,6 +1105,7 @@ static void graph_output_post_merge_line(struct git=
_graph *graph, struct graph_l
>  =09=09=09seen_this =3D 1;
> =20
>  =09=09=09for (j =3D 0; j < graph->num_parents; j++) {
> +=09=09=09=09ASSERT_FOR_FANALYZER(parents);
>  =09=09=09=09par_column =3D graph_find_new_column_by_commit(graph, parent=
s->item);
>  =09=09=09=09assert(par_column >=3D 0);
> =20
> @@ -1138,6 +1139,7 @@ static void graph_output_post_merge_line(struct git=
_graph *graph, struct graph_l
>  =09=09=09}
>  =09=09}
> =20
> +=09=09ASSERT_FOR_FANALYZER(first_parent);
>  =09=09if (col_commit =3D=3D first_parent->item)
>  =09=09=09parent_col =3D col;
>  =09}
> diff --git a/line-log.c b/line-log.c
> index 51d93310a4d..1295f46deaf 100644
> --- a/line-log.c
> +++ b/line-log.c
> @@ -154,6 +154,7 @@ static void range_set_union(struct range_set *out,
>  =09while (i < a->nr || j < b->nr) {
>  =09=09struct range *new_range;
>  =09=09if (i < a->nr && j < b->nr) {
> +=09=09=09ASSERT_FOR_FANALYZER(rb);
>  =09=09=09if (ra[i].start < rb[j].start)
>  =09=09=09=09new_range =3D &ra[i++];
>  =09=09=09else if (ra[i].start > rb[j].start)
> @@ -166,6 +167,7 @@ static void range_set_union(struct range_set *out,
>  =09=09=09new_range =3D &ra[i++];
>  =09=09else                       /* a exhausted */
>  =09=09=09new_range =3D &rb[j++];
> +=09=09ASSERT_FOR_FANALYZER(new_range);
>  =09=09if (new_range->start =3D=3D new_range->end)
>  =09=09=09; /* empty range */
>  =09=09else if (!out->nr || out->ranges[out->nr-1].end < new_range->start=
) {
> diff --git a/unpack-trees.c b/unpack-trees.c
> index a1d0ff3a4d3..b6e10b05a00 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -2195,6 +2195,7 @@ static int verify_clean_subdirectory(const struct c=
ache_entry *ce,
>  =09char *pathbuf;
>  =09int cnt =3D 0;
> =20
> +=09ASSERT_FOR_FANALYZER(ce);
>  =09if (S_ISGITLINK(ce->ce_mode)) {
>  =09=09struct object_id oid;
>  =09=09int sub_head =3D resolve_gitlink_ref(ce->name, "HEAD", &oid);
> diff --git a/utf8.c b/utf8.c
> index de4ce5c0e68..3ffc0a97f3b 100644
> --- a/utf8.c
> +++ b/utf8.c
> @@ -130,6 +130,7 @@ static ucs_char_t pick_one_utf8_char(const char **sta=
rt, size_t *remainder_p)
>  =09 */
>  =09remainder =3D (remainder_p ? *remainder_p : 999);
> =20
> +=09ASSERT_FOR_FANALYZER(remainder < 1 || s);
>  =09if (remainder < 1) {
>  =09=09goto invalid;
>  =09} else if (*s < 0x80) {
> --=20
> 2.36.1.1124.g577fa9c2ebd
>
