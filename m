Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD302DFA41
	for <git@vger.kernel.org>; Tue, 15 Apr 2025 03:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744686697; cv=none; b=HLhP1Z8ThlK29UL+PgWnIgUQZzTtF6yZwvbodnDxkNLHQbyny7+vNhQ9oX0JI1gP5DoM0yiKCwwY/J7ADYc+19WW2kOsjenbID/EJ3QIAedEZwnzMXo3pN0IGwuMxqipxVWm9zPtfG6ZfyoI+yhNdGPOGa44Sj1mkSzne0iXL70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744686697; c=relaxed/simple;
	bh=oAmamBp+6p9y3PH87CWU6+B+95PrhYW/+oxtLs2ks3g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IwhOei3U05GGWMJOuCh/Ugzgmyt9wBKHl6W+vvV74IZaeffr+OhBsmWr+tbE1yuDLvAA2c2elJV5zdJ9C2Ts3+/j2TnlzwREo8hDmfkGSRTQ97lRvYEiIxdFWjPdE9VY5hBS+IdCDpDllPh2KRgsdeEjPhBKnr5yEExent4ncWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y3xd4+Aa; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y3xd4+Aa"
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3d434c84b7eso34511005ab.1
        for <git@vger.kernel.org>; Mon, 14 Apr 2025 20:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744686693; x=1745291493; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BVicHRKNYd5aPtDvk0j/wPEmUyZzT61AGA6jSq/3hYQ=;
        b=Y3xd4+AaoCHczNxKkUUd43S+4+i+hzlhwBDmgjeLL7RC9ObfpZ8g2jUVTzl257MJ9T
         ZtoS2FMtlsgHUc1B0ei56ZnlVckMyBOuxkN/JGIgrZ6L52AxMZB7oWPAYBV9JfkJxlwt
         Jba+hY28nqmP7eUY/yY0Gswdz7nhlZPYlf+mdnJ/gIkMFmBMmRtBLRDy9nD6JQjcawq3
         P/IWfzc2gA+qDErsbYZGPX8pQMlMFnq8TH4j5A1sU2Pj86DoU26rBwmFsKAZu1zKhzNd
         30QpUcJlbbbI9xc70zD+3Ao4QfELzIQ1hSnoI9hcziLVT2ytGnf1DicqCxsCK8H8iGD0
         E16w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744686693; x=1745291493;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BVicHRKNYd5aPtDvk0j/wPEmUyZzT61AGA6jSq/3hYQ=;
        b=NvA6Dxz4+dSiDjFjbuU9jclyppYltEdc5jTxkpqP0cM1MG00gk21SsDpAchOPtQI0L
         n+cp+RCjNe3sVVXbPpPKzgIcBx2q/0XLCK0Jm5f9T+A9ZWwTQDyOLLzD8kqpMfWgYAtm
         4YhEspxvO0ArTL6pYmaL78OCO7rF4dav9dniuJHQniZf3O8Okx0MNf6Y9p2Tm2pTowGa
         sf2p/vGo0uk5H/Da+8GJJBDKv5A0sUzTBQbYYUaGWa1jVSwLM+YZXZ+VB7plocYL736q
         WAYcHpwwJUTSTFJ/Hwbg0tZmAclaHR1NfVi98AOe1STJlOtCMFGxhw2L37j/2mBJebVx
         BAYw==
X-Gm-Message-State: AOJu0YyanIy//oGMJpaR3ETH75C3+qjOsSAnLsFSIba5ESR6RTLV37WC
	jo7OBUavdrU1brlFlO1XRESewMzyOhGXYtZwnSddTCkv0p9B020BjMT9DRjfDzcr5OGs9anIuG7
	kJ5mbdMfrKGQNomz5SP5+wcr0NWQ=
X-Gm-Gg: ASbGncuW/f1c5hrL+15REfj9YkQr3kPgwN/M/4Q3+ab21Gh226ggWS2PWfPB2ZXHQBW
	/4HniMdzIJO4RYuVknPqOyz6pEw/8LNAxS7TIwpwIK5SIEwVhQfsEJz5lZi3O7SZpcBmpZpCIbw
	RYmFYX85188x1NGxwvxYVUMU8aZ47TLBcHzlxGTpwz9pmOqwQDPPmVIsA=
X-Google-Smtp-Source: AGHT+IGlIzyN/r34i3TXqPzAIOS6+r9nL51rGeQcI8+wyiMuuN8CYBJbAF4hHpHWqeZ2Fbk5XKosOnbC1UZNJnlzhzs=
X-Received: by 2002:a05:6e02:6:b0:3a7:88f2:cfa9 with SMTP id
 e9e14a558f8ab-3d7ec225f03mr133550915ab.11.1744686693131; Mon, 14 Apr 2025
 20:11:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1744413969.git.me@ttaylorr.com> <cover.1744661167.git.me@ttaylorr.com>
 <a2ec1b826ceb88c33e2b91c6beef49c21ce36632.1744661167.git.me@ttaylorr.com>
In-Reply-To: <a2ec1b826ceb88c33e2b91c6beef49c21ce36632.1744661167.git.me@ttaylorr.com>
From: Elijah Newren <newren@gmail.com>
Date: Mon, 14 Apr 2025 20:11:22 -0700
X-Gm-Features: ATxdqUGvyYls6Ha5ilufVrxknZvIYvyWZ7y8SVIxjvr8mVCbG7mnvmEI71o_ZOc
Message-ID: <CABPp-BHwewWMp1CY4jAr=sWwxE9of2Q73nyXQ5wpOELJZQ1OPg@mail.gmail.com>
Subject: Re: [PATCH v2 8/8] repack: exclude cruft pack(s) from the MIDX where possible
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 14, 2025 at 1:06=E2=80=AFPM Taylor Blau <me@ttaylorr.com> wrote=
:
>
> In ddee3703b3 (builtin/repack.c: add cruft packs to MIDX during
> geometric repack, 2022-05-20), repack began adding cruft pack(s) to the
> MIDX with '--write-midx' to ensure that the resulting MIDX was always
> closed under reachability in order to generate reachability bitmaps.
>
> Suppose you have a once-unreachable object packed in a cruft pack, which
> later on becomes reachable from one or more objects in a geometrically
> repacked pack. That once-unreachable object *won't* appear in the new
> pack, since the cruft pack was specified as neither included nor
> excluded to 'pack-objects --stdin-packs'.

I believe you are talking about the state before your series (i.e.,
this is carrying on from the previous paragraph), but it reads as
though you are talking about the state after the first seven patches
of this series.  Some kind of connection wording to clarify would
really help here.

> If the bitmap selection
> process picks one or more commits which reach the once-unreachable
> objects, commit ddee3703b3 ensures that the MIDX will be closed under
> reachability. Without it, we would fail to generate a MIDX bitmap.

After reading this part, I had to go back and re-read and figure out
what point in time everything was referring to.

> ddee3703b3 alludes to the fact that this is sub-optimal by saying
>
>     [...] it's desirable to avoid including cruft packs in the MIDX
>     because it causes the MIDX to store a bunch of objects which are
>     likely to get thrown away.
>
> , which is true, but hides an even larger problem. If repositories
> rarely prune their unreachable objects and/or have many of them, the
> MIDX must keep track of a large number of objects which bloats the MIDX
> and slows down object lookup.
>
> This is doubly unfortunate because the vast majority of objects in cruft
> pack(s) are unlikely to be read, but object reads that go through the
> MIDX have to search through them anyway.

"have to search through them"?  That could be read to suggest those
individual objects are read, rather than just traversed over.  Maybe
"...unlikely to be read, so the enlarged MIDX is for mostly tracking
known-to-likely-be-irrelevant objects", or something like that?

> This patch causes geometrically-repacked packs to contain a copy of any
> once-unreachable object(s) with 'git pack-objects --stdin-packs=3Dfollow'=
,
> allowing us to avoid including any cruft packs in the MIDX. This is
> because a sequence of geometrically-repacked packs that were all
> generated with '--stdin-packs=3Dfollow' are guaranteed to have their unio=
n
> be closed under reachability.
>
> Note that you cannot guarantee that a collection of packs is closed
> under reachability if not all of them were generated with following as

maybe: ...with "follow" as above.  "follow" or "following" feels like
it needs quotes so the reader understands its meant as the name of a
mode, rather than a verb in the sentence.

> above. One tell-tale sign that not all geometrically-repacked packs in
> the MIDX were generated with following is to see if there is a pack in

same here with "following"...and below.

> the existing MIDX that is not going to be somehow represented (either
> verbatim or as part of a geometric rollup) in the new MIDX.
>
> If there is, then starting to generate packs with following during
> geometric repacking won't work, since it's open to the same race as
> described above.
>
> But if you're starting from scratch (e.g., building the first MIDX after
> an all-into-one '--cruft' repack), then you can guarantee that the union
> of subsequently generated packs from geometric repacking *is* closed
> under reachability.
>
> Detect when this is the case and avoid including cruft packs in the MIDX
> where possible. The existing behavior remains the default, and the new
> behavior is available with the config 'repack.midxMustIncludeCruft' set
> to 'false'.
>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  Documentation/config/repack.adoc |   7 ++
>  builtin/repack.c                 | 162 +++++++++++++++++++++++++++----
>  t/t7704-repack-cruft.sh          |  90 +++++++++++++++++
>  3 files changed, 241 insertions(+), 18 deletions(-)
>
> diff --git a/Documentation/config/repack.adoc b/Documentation/config/repa=
ck.adoc
> index c79af6d7b8..e9e78dcb19 100644
> --- a/Documentation/config/repack.adoc
> +++ b/Documentation/config/repack.adoc
> @@ -39,3 +39,10 @@ repack.cruftThreads::
>         a cruft pack and the respective parameters are not given over
>         the command line. See similarly named `pack.*` configuration
>         variables for defaults and meaning.
> +
> +repack.midxMustContainCruft::
> +       When set to true, linkgit:git-repack[1] will unconditionally incl=
ude
> +       cruft pack(s), if any, in the multi-pack index when invoked with
> +       `--write-midx`. When false, cruft packs are only included in the =
MIDX
> +       when necessary (e.g., because they might be required to form a
> +       reachability closure with MIDX bitmaps). Defaults to true.
> diff --git a/builtin/repack.c b/builtin/repack.c
> index f3330ade7b..ee43a4f4c1 100644
> --- a/builtin/repack.c
> +++ b/builtin/repack.c
> @@ -39,6 +39,7 @@ static int write_bitmaps =3D -1;
>  static int use_delta_islands;
>  static int run_update_server_info =3D 1;
>  static char *packdir, *packtmp_name, *packtmp;
> +static int midx_must_contain_cruft =3D 1;
>
>  static const char *const git_repack_usage[] =3D {
>         N_("git repack [-a] [-A] [-d] [-f] [-F] [-l] [-n] [-q] [-b] [-m]\=
n"
> @@ -107,6 +108,10 @@ static int repack_config(const char *var, const char=
 *value,
>                 free(cruft_po_args->threads);
>                 return git_config_string(&cruft_po_args->threads, var, va=
lue);
>         }
> +       if (!strcmp(var, "repack.midxmustcontaincruft")) {
> +               midx_must_contain_cruft =3D git_config_bool(var, value);
> +               return 0;
> +       }
>         return git_default_config(var, value, ctx, cb);
>  }
>
> @@ -687,6 +692,77 @@ static void free_pack_geometry(struct pack_geometry =
*geometry)
>         free(geometry->pack);
>  }
>
> +static int midx_has_unknown_packs(char **midx_pack_names,
> +                                 size_t midx_pack_names_nr,
> +                                 struct string_list *include,
> +                                 struct pack_geometry *geometry,
> +                                 struct existing_packs *existing)
> +{
> +       size_t i;
> +
> +       string_list_sort(include);
> +
> +       for (i =3D 0; i < midx_pack_names_nr; i++) {
> +               const char *pack_name =3D midx_pack_names[i];
> +
> +               /*
> +                * Determine whether or not each MIDX'd pack from the exi=
sting
> +                * MIDX (if any) is represented in the new MIDX. For each=
 pack
> +                * in the MIDX, it must either be:
> +                *
> +                *  - In the "include" list of packs to be included in th=
e new
> +                *    MIDX. Note this function is called before the inclu=
de
> +                *    list is populated with any cruft pack(s).
> +                *
> +                *  - Below the geometric split line (if using pack geome=
try),
> +                *    indicating that the pack won't be included in the n=
ew
> +                *    MIDX, but its contents were rolled up as part of th=
e
> +                *    geometric repack.
> +                *
> +                *  - In the existing non-kept packs list (if not using p=
ack
> +                *    geometry), and marked as non-deleted.
> +                */
> +               if (string_list_has_string(include, pack_name)) {
> +                       continue;
> +               } else if (geometry) {
> +                       struct strbuf buf =3D STRBUF_INIT;
> +                       uint32_t j;
> +
> +                       for (j =3D 0; j < geometry->split; j++) {
> +                               strbuf_reset(&buf);
> +                               strbuf_addstr(&buf, pack_basename(geometr=
y->pack[j]));
> +                               strbuf_strip_suffix(&buf, ".pack");
> +                               strbuf_addstr(&buf, ".idx");
> +
> +                               if (!strcmp(pack_name, buf.buf)) {
> +                                       strbuf_release(&buf);
> +                                       break;
> +                               }
> +                       }
> +
> +                       strbuf_release(&buf);
> +
> +                       if (j < geometry->split)
> +                               continue;
> +               } else {
> +                       struct string_list_item *item;
> +
> +                       item =3D string_list_lookup(&existing->non_kept_p=
acks,
> +                                                 pack_name);
> +                       if (item && !pack_is_marked_for_deletion(item))
> +                               continue;
> +               }
> +
> +               /*
> +                * If we got to this point, the MIDX includes some pack t=
hat we
> +                * don't know about.
> +                */
> +               return 1;
> +       }
> +
> +       return 0;
> +}
> +
>  struct midx_snapshot_ref_data {
>         struct tempfile *f;
>         struct oidset seen;
> @@ -755,6 +831,8 @@ static void midx_snapshot_refs(struct tempfile *f)
>
>  static void midx_included_packs(struct string_list *include,
>                                 struct existing_packs *existing,
> +                               char **midx_pack_names,
> +                               size_t midx_pack_names_nr,
>                                 struct string_list *names,
>                                 struct pack_geometry *geometry)
>  {
> @@ -808,26 +886,55 @@ static void midx_included_packs(struct string_list =
*include,
>                 }
>         }
>
> -       for_each_string_list_item(item, &existing->cruft_packs) {
> +       if (midx_must_contain_cruft ||
> +           midx_has_unknown_packs(midx_pack_names, midx_pack_names_nr,
> +                                  include, geometry, existing)) {
>                 /*
> -                * When doing a --geometric repack, there is no need to c=
heck
> -                * for deleted packs, since we're by definition not doing=
 an
> -                * ALL_INTO_ONE repack (hence no packs will be deleted).
> -                * Otherwise we must check for and exclude any packs whic=
h are
> -                * enqueued for deletion.
> +                * If there are one or more unknown pack(s) present (see
> +                * midx_has_unknown_packs() for what makes a pack
> +                * "unknown") in the MIDX before the repack, keep them
> +                * as they may be required to form a reachability
> +                * closure if the MIDX is bitmapped.
>                  *
> -                * So we could omit the conditional below in the --geomet=
ric
> -                * case, but doing so is unnecessary since no packs are m=
arked
> -                * as pending deletion (since we only call
> -                * `mark_packs_for_deletion()` when doing an all-into-one
> -                * repack).
> +                * For example, a cruft pack can be required to form a
> +                * reachability closure if the MIDX is bitmapped and one
> +                * or more of its selected commits reaches a once-cruft
> +                * object that was later made reachable.

The antecedent of "its" is unclear here; just spell it out to reduce
how much thinking the reader needs to do?

>                  */
> -               if (pack_is_marked_for_deletion(item))
> -                       continue;
> +               for_each_string_list_item(item, &existing->cruft_packs) {
> +                       /*
> +                        * When doing a --geometric repack, there is no
> +                        * need to check for deleted packs, since we're
> +                        * by definition not doing an ALL_INTO_ONE
> +                        * repack (hence no packs will be deleted).
> +                        * Otherwise we must check for and exclude any
> +                        * packs which are enqueued for deletion.
> +                        *
> +                        * So we could omit the conditional below in the
> +                        * --geometric case, but doing so is unnecessary
> +                        *  since no packs are marked as pending
> +                        *  deletion (since we only call
> +                        *  `mark_packs_for_deletion()` when doing an
> +                        *  all-into-one repack).
> +                        */
> +                       if (pack_is_marked_for_deletion(item))
> +                               continue;
>
> -               strbuf_reset(&buf);
> -               strbuf_addf(&buf, "%s.idx", item->string);
> -               string_list_insert(include, buf.buf);
> +                       strbuf_reset(&buf);
> +                       strbuf_addf(&buf, "%s.idx", item->string);
> +                       string_list_insert(include, buf.buf);
> +               }
> +       } else {
> +               /*
> +                * Modern versions of Git will write new copies of
> +                * once-cruft objects when doing a --geometric repack.

"Modern versions of Git" -> "Modern versions of Git with the
appropriate config setting" ?


> +                *
> +                * If the MIDX has no cruft pack, new packs written
> +                * during a --geometric repack will not rely on the
> +                * cruft pack to form a reachability closure, so we can
> +                * avoid including them in the MIDX in that case.
> +                */
> +               ;
>         }
>
>         strbuf_release(&buf);
> @@ -1142,6 +1249,8 @@ int cmd_repack(int argc,
>         struct tempfile *refs_snapshot =3D NULL;
>         int i, ext, ret;
>         int show_progress;
> +       char **midx_pack_names =3D NULL;
> +       size_t midx_pack_names_nr =3D 0;
>
>         /* variables to be filled by option parsing */
>         int delete_redundant =3D 0;
> @@ -1356,7 +1465,10 @@ int cmd_repack(int argc,
>                     !(pack_everything & PACK_CRUFT))
>                         strvec_push(&cmd.args, "--pack-loose-unreachable"=
);
>         } else if (geometry.split_factor) {
> -               strvec_push(&cmd.args, "--stdin-packs");
> +               if (midx_must_contain_cruft)
> +                       strvec_push(&cmd.args, "--stdin-packs");
> +               else
> +                       strvec_push(&cmd.args, "--stdin-packs=3Dfollow");
>                 strvec_push(&cmd.args, "--unpacked");
>         } else {
>                 strvec_push(&cmd.args, "--unpacked");
> @@ -1478,6 +1590,16 @@ int cmd_repack(int argc,
>
>         string_list_sort(&names);
>
> +       if (get_local_multi_pack_index(the_repository)) {
> +               uint32_t i;
> +               struct multi_pack_index *m =3D
> +                       get_local_multi_pack_index(the_repository);
> +
> +               ALLOC_ARRAY(midx_pack_names, m->num_packs);
> +               for (i =3D 0; i < m->num_packs; i++)
> +                       midx_pack_names[midx_pack_names_nr++] =3D xstrdup=
(m->pack_names[i]);
> +       }
> +
>         close_object_store(the_repository->objects);
>
>         /*
> @@ -1519,7 +1641,8 @@ int cmd_repack(int argc,
>
>         if (write_midx) {
>                 struct string_list include =3D STRING_LIST_INIT_DUP;
> -               midx_included_packs(&include, &existing, &names, &geometr=
y);
> +               midx_included_packs(&include, &existing, midx_pack_names,
> +                                   midx_pack_names_nr, &names, &geometry=
);
>
>                 ret =3D write_midx_included_packs(&include, &geometry, &n=
ames,
>                                                 refs_snapshot ? get_tempf=
ile_path(refs_snapshot) : NULL,
> @@ -1570,6 +1693,9 @@ int cmd_repack(int argc,
>         string_list_clear(&names, 1);
>         existing_packs_release(&existing);
>         free_pack_geometry(&geometry);
> +       for (size_t i =3D 0; i < midx_pack_names_nr; i++)
> +               free(midx_pack_names[i]);
> +       free(midx_pack_names);
>         pack_objects_args_release(&po_args);
>         pack_objects_args_release(&cruft_po_args);
>
> diff --git a/t/t7704-repack-cruft.sh b/t/t7704-repack-cruft.sh
> index 8aebfb45f5..2b0a55f8fd 100755
> --- a/t/t7704-repack-cruft.sh
> +++ b/t/t7704-repack-cruft.sh
> @@ -724,4 +724,94 @@ test_expect_success 'cruft repack respects --quiet' =
'
>         )
>  '
>
> +setup_cruft_exclude_tests() {
> +       git init "$1" &&
> +       (
> +               cd "$1" &&
> +
> +               git config repack.midxMustContainCruft false &&
> +
> +               test_commit one &&
> +
> +               test_commit --no-tag two &&
> +               two=3D"$(git rev-parse HEAD)" &&
> +               test_commit --no-tag three &&
> +               three=3D"$(git rev-parse HEAD)" &&
> +               git reset --hard one &&
> +               git reflog expire --all --expire=3Dall &&
> +
> +               GIT_TEST_MULTI_PACK_INDEX=3D0 git repack --cruft -d &&
> +
> +               git merge $two &&
> +               test_commit four
> +       )
> +}
> +
> +test_expect_success 'repack --write-midx excludes cruft where possible' =
'
> +       setup_cruft_exclude_tests exclude-cruft-when-possible &&
> +       (
> +               cd exclude-cruft-when-possible &&
> +
> +               GIT_TEST_MULTI_PACK_INDEX=3D0 \
> +               git repack -d --geometric=3D2 --write-midx --write-bitmap=
-index &&
> +
> +               test-tool read-midx --show-objects $objdir >midx &&
> +               cruft=3D"$(ls $packdir/*.mtimes)" &&
> +               test_grep ! "$(basename "$cruft" .mtimes).idx" midx &&
> +
> +               git rev-list --all --objects --no-object-names >reachable=
.raw &&
> +               sort reachable.raw >reachable.objects &&
> +               awk "/\.pack$/ { print \$1 }" <midx | sort >midx.objects =
&&
> +
> +               test_cmp reachable.objects midx.objects
> +       )
> +'
> +
> +test_expect_success 'repack --write-midx includes cruft when instructed'=
 '
> +       setup_cruft_exclude_tests exclude-cruft-when-instructed &&
> +       (
> +               cd exclude-cruft-when-instructed &&
> +
> +               GIT_TEST_MULTI_PACK_INDEX=3D0 \
> +               git -c repack.midxMustContainCruft=3Dtrue repack \
> +                       -d --geometric=3D2 --write-midx --write-bitmap-in=
dex &&
> +
> +               test-tool read-midx --show-objects $objdir >midx &&
> +               cruft=3D"$(ls $packdir/*.mtimes)" &&
> +               test_grep "$(basename "$cruft" .mtimes).idx" midx &&
> +
> +               git cat-file --batch-check=3D"%(objectname)" --batch-all-=
objects \
> +                       >all.objects &&
> +               awk "/\.pack$/ { print \$1 }" <midx | sort >midx.objects =
&&
> +
> +               test_cmp all.objects midx.objects
> +       )
> +'
> +
> +test_expect_success 'repack --write-midx includes cruft when necessary' =
'
> +       setup_cruft_exclude_tests exclude-cruft-when-necessary &&
> +       (
> +               cd exclude-cruft-when-necessary &&
> +
> +               test_path_is_file $(ls $packdir/pack-*.mtimes) &&
> +               ls $packdir/pack-*.idx | sort >packs.all &&
> +               grep -o "pack-.*\.idx$" packs.all >in &&
> +
> +               git multi-pack-index write --stdin-packs --bitmap <in &&
> +
> +               test_commit five &&
> +               GIT_TEST_MULTI_PACK_INDEX=3D0 \
> +               git repack -d --geometric=3D2 --write-midx --write-bitmap=
-index &&
> +
> +               test-tool read-midx --show-objects $objdir >midx &&
> +               awk "/\.pack$/ { print \$1 }" <midx | sort >midx.objects =
&&
> +               git cat-file --batch-all-objects --batch-check=3D"%(objec=
tname)" \
> +                       >expect.objects &&
> +               test_cmp expect.objects midx.objects &&
> +
> +               grep "^pack-" midx >midx.packs &&
> +               test_line_count =3D "$(($(wc -l <packs.all) + 1))" midx.p=
acks
> +       )
> +'
> +
>  test_done
> --
> 2.49.0.229.gc267761125.dirty
