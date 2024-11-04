Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989EFBA34
	for <git@vger.kernel.org>; Mon,  4 Nov 2024 08:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730710091; cv=none; b=HzI1my6L87O+cpdBzdyA9VU4nf4zEG0uOGgPDZx39L12PCF85h7F6Yq4T/8LLDBzW5r+SBoy6jQ1gqZiR4VUJzLLrbalXPSOBdMo0/nRbdcqr5t/oSaaUpFZIx/7eQfwXnQkXPlaRcmNb/jdYqeNdaV0fIB3tJ+6rkoOuRqvs6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730710091; c=relaxed/simple;
	bh=/xb7M9ihKcYlGoaj/yY/88ckIHgMQ56yv0A31gFX9co=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WH6WmeXGuUrjENU7PhYWUl7fpg8+czoV+8F8CqQ9Ni37bZ+owsV/EUCqNj5XoBjWRtR5gCcu/+FQyqMI3qSxZobnrb0p6P55sJMBAvERZxZMb05fYVVW4fHfPeDuPPPvbXBZi24N6aWxoU8FRj64qvi26XpkRu72UM1br7ZiNFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S/Mwi7vL; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S/Mwi7vL"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2e3d523a24dso3005061a91.0
        for <git@vger.kernel.org>; Mon, 04 Nov 2024 00:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730710088; x=1731314888; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R4nhNh/gxdVXaCGIQ6c6qLpKv5ffFYpIAo+25ZfUTtU=;
        b=S/Mwi7vLPSF+Kx9UwrvtFZ+gwK9HPeYT5cQlnxk8M3aRk4y4xRHH2a4ot1aZEmBo4S
         HBOqn4M5GCuLWv3CX0/kd5ImTV89h2b3+04VAGte4za6JR8Yyr9NWaFkDDeym7sybnux
         aVbFu/o6EGxzz0HalCwSSrbh8tOnXn2uMT9Vp3fM3SKAO77Z81Wk+9m7fBSFWiny+SzL
         RbqMpm0f4NYNn731NSwXAJbmrlDZHWTwli+AyphE8ikTfRw8dLIrBFBljQ2L5QQiDE4c
         ywBqV0pVacVckgJTtHY324o2QEcW2Zto2KNDPKFsNBrIPYnQHxBH0NyANoayq+kWfMcG
         38SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730710088; x=1731314888;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R4nhNh/gxdVXaCGIQ6c6qLpKv5ffFYpIAo+25ZfUTtU=;
        b=Luwf7vHn7vMmT0f732r/+p406Y6GXWLhGR6yjZEaznIH18K/6p0Th5HBzyVquJ3UJI
         YZtR1nnq2NhCqWfaPuzej+FLwLFDny9VNZNe0ZyscTDKjzujpTl5r0duAv/Iugr1lTnn
         xZUuPTjMBB9akiBse/HH4QgiSYhm7Nc2cO9FqyfBh1MVTtm6F0cqGiWtdvy0s3xIL06y
         kGypiZchYSuh4zMEDWKpKrGPlUMVz31b/4/9cSFeAI+pWDckVX7edI2W66gJECus5Icm
         TbAZj1iqrksh40PLsmS3wMHEPKT/UFzmF4c/e+W6g6/XbSKOhbAH9KWiZn1Cyi5j/hks
         +SeQ==
X-Gm-Message-State: AOJu0Yyhin/WM7kKYJwR077+Vw3T3x3MoiezRrbuTc3VFOgZjqFw7h84
	w11GNPzPC/mC89wThuJB1bklctKpiT0j8b1VYll0jZdWWK1baP2d3CDbxO8htoXSxywsSSCNHPS
	toxUuZ/TTTlUWLxeJwA5/HScQ3gA=
X-Google-Smtp-Source: AGHT+IEFIkpAHAkf42uUlvmAlGkcI+QUCXqxt/yYqfFgJW2L7r2j09hlmuS4zM/hlDZQ31RrBNe+Fger6sAbs5buaZc=
X-Received: by 2002:a17:90a:ca8e:b0:2e2:bad2:69ba with SMTP id
 98e67ed59e1d1-2e8f106b4aamr32358580a91.14.1730710087645; Mon, 04 Nov 2024
 00:48:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1782.v3.git.1726741439445.gitgitgadget@gmail.com> <pull.1782.v4.git.1728073292874.gitgitgadget@gmail.com>
In-Reply-To: <pull.1782.v4.git.1728073292874.gitgitgadget@gmail.com>
From: Shubham Kanodia <shubham.kanodia10@gmail.com>
Date: Mon, 4 Nov 2024 14:17:30 +0530
Message-ID: <CAG=Um+1Ox9wDJixK+9dugVO4m37TSqjqYEc7eLQZK0rUuWzwrA@mail.gmail.com>
Subject: Re: [PATCH v4] remote: allow specifying refs to prefetch
To: Shubham Kanodia via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, "Patrick Steinhardt [ ]" <ps@pks.im>, 
	"Junio C Hamano [ ]" <gitster@pobox.com>, "Derrick Stolee [ ]" <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 5, 2024 at 1:51=E2=80=AFAM Shubham Kanodia via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Shubham Kanodia <shubham.kanodia10@gmail.com>
>
> When using 'git fetch --prefetch', all fetchable refs are prefetched
> by default. In large repositories with many refs, this can lead to
> unnecessary network traffic and increased disk space use.
>
> Introduce a new configuration option 'remote.<name>.prefetchref' that
> allows users to specify specific ref patterns to be prefetched during
> a 'git fetch --prefetch' operation.
>
> The 'prefetchref' option accepts a space-separated list of ref
> patterns (e.g., 'refs/heads/main !refs/heads/feature/*'). When the
> '--prefetch' option is used with 'git fetch', only the refs matching
> these patterns will be prefetched.
>
> Signed-off-by: Shubham Kanodia <shubham.kanodia10@gmail.com>
> ---
>     remote: introduce config to set prefetch refs
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1782%2F=
pastelsky%2Fsk%2Fremote-prefetchref-v4
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1782/paste=
lsky/sk/remote-prefetchref-v4
> Pull-Request: https://github.com/gitgitgadget/git/pull/1782
>
> Range-diff vs v3:
>
>  1:  717d5957c47 ! 1:  e3d8aee1ea8 remote: introduce config to set prefet=
ch refs
>      @@ Metadata
>       Author: Shubham Kanodia <shubham.kanodia10@gmail.com>
>
>        ## Commit message ##
>      -    remote: introduce config to set prefetch refs
>      +    remote: allow specifying refs to prefetch
>
>      -    This commit introduces a new configuration option,
>      -    remote.<name>.prefetchref, which allows users to specify specif=
ic
>      -    ref patterns to be prefetched during a git fetch --prefetch
>      -    operation.
>      +    When using 'git fetch --prefetch', all fetchable refs are prefe=
tched
>      +    by default. In large repositories with many refs, this can lead=
 to
>      +    unnecessary network traffic and increased disk space use.
>
>      -    The new option accepts a space-separated list of ref patterns.
>      -    When the --prefetch option is used with git fetch, only the ref=
s
>      -    matching these patterns will be prefetched, instead of the
>      -    default behavior of prefetching all fetchable refs.
>      +    Introduce a new configuration option 'remote.<name>.prefetchref=
' that
>      +    allows users to specify specific ref patterns to be prefetched =
during
>      +    a 'git fetch --prefetch' operation.
>
>      -    Example usage in .git/config:
>      -    [remote "origin"]
>      -        prefetchref =3D "refs/heads/main refs/heads/feature/*"
>      -
>      -    This change allows users to optimize their prefetch operations,=
 potentially
>      -    reducing network traffic and improving performance for large re=
positories
>      -    with many refs.
>      +    The 'prefetchref' option accepts a space-separated list of ref
>      +    patterns (e.g., 'refs/heads/main !refs/heads/feature/*'). When =
the
>      +    '--prefetch' option is used with 'git fetch', only the refs mat=
ching
>      +    these patterns will be prefetched.
>
>           Signed-off-by: Shubham Kanodia <shubham.kanodia10@gmail.com>
>
>      @@ Documentation/config/remote.txt: remote.<name>.fetch::
>         linkgit:git-fetch[1].
>
>       +remote.<name>.prefetchref::
>      -+    Specify the refs to be prefetched when fetching from this remo=
te.
>      -+    The value is a space-separated list of ref patterns (e.g., "re=
fs/heads/master !refs/heads/develop*").
>      -+    This can be used to optimize fetch operations by specifying ex=
actly which refs should be prefetched.
>      ++ Specify the refs to be prefetched when fetching from this
>      ++ remote. The value is a space-separated list of ref patterns
>      ++ (e.g., "refs/heads/main !refs/heads/develop*"). This can be
>      ++ used to optimize fetch operations by specifying exactly which
>      ++ refs should be prefetched.
>       +
>        remote.<name>.push::
>         The default set of "refspec" for linkgit:git-push[1]. See
>         linkgit:git-push[1].
>
>        ## builtin/fetch.c ##
>      -@@
>      - #include "trace.h"
>      - #include "trace2.h"
>      - #include "bundle-uri.h"
>      -+#include "wildmatch.h"
>      -
>      - #define FORCED_UPDATES_DELAY_WARNING_IN_MS (10 * 1000)
>      -
>       @@ builtin/fetch.c: static void filter_prefetch_refspec(struct refs=
pec *rs)
>         }
>        }
>
>      ++static int pattern_matches_ref(const char *pattern, const char *re=
fname)
>      ++{
>      ++ if (strchr(pattern, '*'))
>      ++         return match_refspec_name_with_pattern(pattern, refname, =
NULL, NULL) !=3D 0;
>      ++ return strcmp(pattern, refname) =3D=3D 0;
>      ++}
>      ++
>       +static int matches_prefetch_refs(const char *refname, const struct=
 string_list *prefetch_refs)
>       +{
>      -+ int i;
>      -+ int has_positive =3D 0;
>      -+ int matched_positive =3D 0;
>      -+ int matched_negative =3D 0;
>      ++ int has_positive =3D 0, matched_positive =3D 0, matched_negative =
=3D 0;
>       +
>      -+ for (i =3D 0; i < prefetch_refs->nr; i++) {
>      ++ for (int i =3D 0; i < prefetch_refs->nr; i++) {
>       +         const char *pattern =3D prefetch_refs->items[i].string;
>       +         int is_negative =3D (*pattern =3D=3D '!');
>      ++         if (is_negative) pattern++;
>      ++         else has_positive =3D 1;
>       +
>      -+         if (is_negative)
>      -+                 pattern++;
>      -+         else
>      -+                 has_positive =3D 1;
>      -+
>      -+         if (wildmatch(pattern, refname, 0) =3D=3D 0) {
>      -+                 if (is_negative)
>      -+                         matched_negative =3D 1;
>      -+                 else
>      -+                         matched_positive =3D 1;
>      ++         if (pattern_matches_ref(pattern, refname)) {
>      ++                 if (is_negative) matched_negative =3D 1;
>      ++                 else matched_positive =3D 1;
>       +         }
>       + }
>       +
>      -+ if (!has_positive)
>      -+         return !matched_negative;
>      -+
>      -+ return matched_positive && !matched_negative;
>      -+}
>      -+
>      -+
>      -+static void ref_remove(struct ref **head, struct ref *to_remove)
>      -+{
>      -+ struct ref **pp, *p;
>      -+
>      -+ for (pp =3D head; (p =3D *pp) !=3D NULL; pp =3D &p->next) {
>      -+         if (p =3D=3D to_remove) {
>      -+                 *pp =3D p->next;
>      -+                 return;
>      -+         }
>      -+ }
>      ++ return has_positive ? (matched_positive && !matched_negative) : !=
matched_negative;
>       +}
>       +
>        static struct ref *get_ref_map(struct remote *remote,
>                                const struct ref *remote_refs,
>                                struct refspec *rs,
>       @@ builtin/fetch.c: static struct ref *get_ref_map(struct remote *r=
emote,
>      +  struct hashmap existing_refs;
>         int existing_refs_populated =3D 0;
>
>      ++ struct ref *prefetch_filtered_ref_map =3D NULL, **ref_map_tail =
=3D &prefetch_filtered_ref_map;
>      ++ struct ref *next;
>      ++
>         filter_prefetch_refspec(rs);
>       +
>         if (remote)
>      @@ builtin/fetch.c: static struct ref *get_ref_map(struct remote *re=
mote,
>       +  * Filter out advertised refs that we don't want to fetch during
>       +  * prefetch if a prefetchref config is set
>       +  */
>      ++
>       + if (prefetch && remote->prefetch_refs.nr) {
>      -+         struct ref *ref, *next;
>      -+         for (ref =3D ref_map; ref; ref =3D next) {
>      -+                 next =3D ref->next;
>      ++         prefetch_filtered_ref_map =3D NULL;
>      ++         ref_map_tail =3D &prefetch_filtered_ref_map;
>      ++
>      ++         for (rm =3D ref_map; rm; rm =3D next) {
>      ++                 next =3D rm->next;
>      ++                 rm->next =3D NULL;
>       +
>      -+                 if (!matches_prefetch_refs(ref->name, &remote->pr=
efetch_refs)) {
>      -+                                 ref_remove(&ref_map, ref);
>      -+                                 free_one_ref(ref);
>      ++                 if (matches_prefetch_refs(rm->name, &remote->pref=
etch_refs)) {
>      ++                         *ref_map_tail =3D rm;
>      ++                         ref_map_tail =3D &rm->next;
>      ++                 } else {
>      ++                         free_one_ref(rm);
>       +                 }
>       +         }
>      ++         ref_map =3D prefetch_filtered_ref_map;
>       + }
>       +
>         ref_map =3D ref_remove_duplicates(ref_map);
>      @@ remote.c: static int handle_config(const char *key, const char *v=
alue,
>         else if (!strcmp(subkey, "url")) {
>                 if (!value)
>                         return config_error_nonbool(key);
>      +@@ remote.c: struct strvec *push_url_of_remote(struct remote *remot=
e)
>      +  return remote->pushurl.nr ? &remote->pushurl : &remote->url;
>      + }
>      +
>      +-static int match_name_with_pattern(const char *key, const char *na=
me,
>      ++int match_refspec_name_with_pattern(const char *key, const char *n=
ame,
>      +                             const char *value, char **result)
>      + {
>      +  const char *kstar =3D strchr(key, '*');
>      +@@ remote.c: static int refspec_match(const struct refspec_item *re=
fspec,
>      +                   const char *name)
>      + {
>      +  if (refspec->pattern)
>      +-         return match_name_with_pattern(refspec->src, name, NULL, =
NULL);
>      ++         return match_refspec_name_with_pattern(refspec->src, name=
, NULL, NULL);
>      +
>      +  return !strcmp(refspec->src, name);
>      + }
>      +@@ remote.c: static int query_matches_negative_refspec(struct refsp=
ec *rs, struct refspec_ite
>      +                  const char *key =3D refspec->dst ? refspec->dst :=
 refspec->src;
>      +                  const char *value =3D refspec->src;
>      +
>      +-                 if (match_name_with_pattern(key, needle, value, &=
expn_name))
>      ++                 if (match_refspec_name_with_pattern(key, needle, =
value, &expn_name))
>      +                          string_list_append_nodup(&reversed, expn_=
name);
>      +          } else if (refspec->matching) {
>      +                  /* For the special matching refspec, any query sh=
ould match */
>      +@@ remote.c: static void query_refspecs_multiple(struct refspec *rs=
,
>      +          if (!refspec->dst || refspec->negative)
>      +                  continue;
>      +          if (refspec->pattern) {
>      +-                 if (match_name_with_pattern(key, needle, value, r=
esult))
>      ++                 if (match_refspec_name_with_pattern(key, needle, =
value, result))
>      +                          string_list_append_nodup(results, *result=
);
>      +          } else if (!strcmp(needle, key)) {
>      +                  string_list_append(results, value);
>      +@@ remote.c: int query_refspecs(struct refspec *rs, struct refspec_=
item *query)
>      +          if (!refspec->dst || refspec->negative)
>      +                  continue;
>      +          if (refspec->pattern) {
>      +-                 if (match_name_with_pattern(key, needle, value, r=
esult)) {
>      ++                 if (match_refspec_name_with_pattern(key, needle, =
value, result)) {
>      +                          query->force =3D refspec->force;
>      +                          return 0;
>      +                  }
>      +@@ remote.c: static char *get_ref_match(const struct refspec *rs, c=
onst struct ref *ref,
>      +                  const char *dst_side =3D item->dst ? item->dst : =
item->src;
>      +                  int match;
>      +                  if (direction =3D=3D FROM_SRC)
>      +-                         match =3D match_name_with_pattern(item->s=
rc, ref->name, dst_side, &name);
>      ++                         match =3D match_refspec_name_with_pattern=
(item->src, ref->name, dst_side, &name);
>      +                  else
>      +-                         match =3D match_name_with_pattern(dst_sid=
e, ref->name, item->src, &name);
>      ++                         match =3D match_refspec_name_with_pattern=
(dst_side, ref->name, item->src, &name);
>      +                  if (match) {
>      +                          matching_refs =3D i;
>      +                          break;
>      +@@ remote.c: static struct ref *get_expanded_map(const struct ref *=
remote_refs,
>      +
>      +          if (strchr(ref->name, '^'))
>      +                  continue; /* a dereference item */
>      +-         if (match_name_with_pattern(refspec->src, ref->name,
>      ++         if (match_refspec_name_with_pattern(refspec->src, ref->na=
me,
>      +                                      refspec->dst, &expn_name) &&
>      +              !ignore_symref_update(expn_name, &scratch)) {
>      +                  struct ref *cpy =3D copy_ref(ref);
>
>        ## remote.h ##
>       @@
>      @@ remote.h: struct remote {
>         /*
>          * The setting for whether to fetch tags (as a separate rule from=
 the
>          * configured refspecs);
>      +@@ remote.h: int count_refspec_match(const char *, struct ref *refs=
, struct ref **matched_ref
>      +
>      + int check_ref_type(const struct ref *ref, int flags);
>      +
>      ++int match_refspec_name_with_pattern(const char *key, const char *n=
ame,
>      ++                                 const char *value, char **result)=
;
>      ++
>      + /*
>      +  * Free a single ref and its peer, or an entire list of refs and t=
heir peers,
>      +  * respectively.
>
>        ## t/t7900-maintenance.sh ##
>       @@ t/t7900-maintenance.sh: test_expect_success 'prefetch multiple r=
emotes' '
>      @@ t/t7900-maintenance.sh: test_expect_success 'prefetch multiple re=
motes' '
>       +         git checkout -b feature && test_commit feature-commit-2 &=
&
>       +         git checkout -b wip/test && test_commit wip-test-commit-2=
 &&
>       +         git checkout -b topic/x && test_commit topic-x-commit-2 &=
&
>      -+         git push -f origin feature wip/test topic/x&&
>      ++         git push -f origin feature wip/test topic/x &&
>       +         cd .. &&
>       +
>       +         git config remote.remote2.prefetchref "refs/heads/feature=
" &&
>      -+         fetchargs=3D"--prefetch --prune --no-tags --no-write-fetc=
h-head --recurse-submodules=3Dno --quiet" &&
>      -+         GIT_TRACE2_EVENT=3D"$(pwd)/prefetch-positive.txt" git mai=
ntenance run --task=3Dprefetch 2>/dev/null &&
>      ++         fetchargs=3D"--prefetch --prune --no-tags --no-write-fetc=
h-head \
>      ++                 --recurse-submodules=3Dno --quiet" &&
>      ++         GIT_TRACE2_EVENT=3D"$(pwd)/prefetch-positive.txt" \
>      ++                 git maintenance run --task=3Dprefetch 2>/dev/null=
 &&
>       +         test_subcommand git fetch remote2 $fetchargs <prefetch-po=
sitive.txt &&
>       +
>       +         git rev-parse refs/prefetch/remotes/remote2/feature &&
>      @@ t/t7900-maintenance.sh: test_expect_success 'prefetch multiple re=
motes' '
>       +         cd .. &&
>       +
>       +         git config remote.remote3.prefetchref "!refs/heads/wip/*"=
 &&
>      -+         fetchargs=3D"--prefetch --prune --no-tags --no-write-fetc=
h-head --recurse-submodules=3Dno --quiet" &&
>      -+         GIT_TRACE2_EVENT=3D"$(pwd)/prefetch-negative.txt" git mai=
ntenance run --task=3Dprefetch 2>/dev/null &&
>      ++         fetchargs=3D"--prefetch --prune --no-tags --no-write-fetc=
h-head \
>      ++                 --recurse-submodules=3Dno --quiet" &&
>      ++         GIT_TRACE2_EVENT=3D"$(pwd)/prefetch-negative.txt" \
>      ++                 git maintenance run --task=3Dprefetch 2>/dev/null=
 &&
>       +         test_subcommand git fetch remote3 $fetchargs <prefetch-ne=
gative.txt &&
>       +         git rev-parse refs/prefetch/remotes/remote3/feature &&
>       +         git rev-parse refs/prefetch/remotes/remote3/topic/x &&
>      @@ t/t7900-maintenance.sh: test_expect_success 'prefetch multiple re=
motes' '
>       +         git push -f origin feature topic/x topic/y &&
>       +         cd .. &&
>       +
>      -+         git config remote.remote4.prefetchref "refs/heads/topic/*=
 !refs/heads/topic/y" &&
>      -+         fetchargs=3D"--prefetch --prune --no-tags --no-write-fetc=
h-head --recurse-submodules=3Dno --quiet" &&
>      -+         GIT_TRACE2_EVENT=3D"$(pwd)/prefetch-mixed.txt" git mainte=
nance run --task=3Dprefetch 2>/dev/null &&
>      ++         git config remote.remote4.prefetchref \
>      ++                 "refs/heads/topic/* !refs/heads/topic/y" &&
>      ++         fetchargs=3D"--prefetch --prune --no-tags --no-write-fetc=
h-head \
>      ++                 --recurse-submodules=3Dno --quiet" &&
>      ++         GIT_TRACE2_EVENT=3D"$(pwd)/prefetch-mixed.txt" \
>      ++                 git maintenance run --task=3Dprefetch 2>/dev/null=
 &&
>       +         test_subcommand git fetch remote4 $fetchargs <prefetch-mi=
xed.txt &&
>       +
>       +         test_must_fail git rev-parse refs/prefetch/remotes/remote=
4/feature &&
>
>
>  Documentation/config/remote.txt |  7 +++
>  builtin/fetch.c                 | 53 ++++++++++++++++++++
>  remote.c                        | 24 ++++++----
>  remote.h                        |  6 +++
>  t/t7900-maintenance.sh          | 85 +++++++++++++++++++++++++++++++++
>  5 files changed, 167 insertions(+), 8 deletions(-)
>
> diff --git a/Documentation/config/remote.txt b/Documentation/config/remot=
e.txt
> index 8efc53e836d..186f439ed7b 100644
> --- a/Documentation/config/remote.txt
> +++ b/Documentation/config/remote.txt
> @@ -33,6 +33,13 @@ remote.<name>.fetch::
>         The default set of "refspec" for linkgit:git-fetch[1]. See
>         linkgit:git-fetch[1].
>
> +remote.<name>.prefetchref::
> +       Specify the refs to be prefetched when fetching from this
> +       remote. The value is a space-separated list of ref patterns
> +       (e.g., "refs/heads/main !refs/heads/develop*"). This can be
> +       used to optimize fetch operations by specifying exactly which
> +       refs should be prefetched.
> +
>  remote.<name>.push::
>         The default set of "refspec" for linkgit:git-push[1]. See
>         linkgit:git-push[1].
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index b2b5aee5bf2..74603cfabe0 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -485,6 +485,32 @@ static void filter_prefetch_refspec(struct refspec *=
rs)
>         }
>  }
>
> +static int pattern_matches_ref(const char *pattern, const char *refname)
> +{
> +       if (strchr(pattern, '*'))
> +               return match_refspec_name_with_pattern(pattern, refname, =
NULL, NULL) !=3D 0;
> +       return strcmp(pattern, refname) =3D=3D 0;
> +}
> +
> +static int matches_prefetch_refs(const char *refname, const struct strin=
g_list *prefetch_refs)
> +{
> +       int has_positive =3D 0, matched_positive =3D 0, matched_negative =
=3D 0;
> +
> +       for (int i =3D 0; i < prefetch_refs->nr; i++) {
> +               const char *pattern =3D prefetch_refs->items[i].string;
> +               int is_negative =3D (*pattern =3D=3D '!');
> +               if (is_negative) pattern++;
> +               else has_positive =3D 1;
> +
> +               if (pattern_matches_ref(pattern, refname)) {
> +                       if (is_negative) matched_negative =3D 1;
> +                       else matched_positive =3D 1;
> +               }
> +       }
> +
> +       return has_positive ? (matched_positive && !matched_negative) : !=
matched_negative;
> +}
> +
>  static struct ref *get_ref_map(struct remote *remote,
>                                const struct ref *remote_refs,
>                                struct refspec *rs,
> @@ -501,7 +527,11 @@ static struct ref *get_ref_map(struct remote *remote=
,
>         struct hashmap existing_refs;
>         int existing_refs_populated =3D 0;
>
> +       struct ref *prefetch_filtered_ref_map =3D NULL, **ref_map_tail =
=3D &prefetch_filtered_ref_map;
> +       struct ref *next;
> +
>         filter_prefetch_refspec(rs);
> +
>         if (remote)
>                 filter_prefetch_refspec(&remote->fetch);
>
> @@ -610,6 +640,29 @@ static struct ref *get_ref_map(struct remote *remote=
,
>         else
>                 ref_map =3D apply_negative_refspecs(ref_map, &remote->fet=
ch);
>
> +       /**
> +        * Filter out advertised refs that we don't want to fetch during
> +        * prefetch if a prefetchref config is set
> +        */
> +
> +       if (prefetch && remote->prefetch_refs.nr) {
> +               prefetch_filtered_ref_map =3D NULL;
> +               ref_map_tail =3D &prefetch_filtered_ref_map;
> +
> +               for (rm =3D ref_map; rm; rm =3D next) {
> +                       next =3D rm->next;
> +                       rm->next =3D NULL;
> +
> +                       if (matches_prefetch_refs(rm->name, &remote->pref=
etch_refs)) {
> +                               *ref_map_tail =3D rm;
> +                               ref_map_tail =3D &rm->next;
> +                       } else {
> +                               free_one_ref(rm);
> +                       }
> +               }
> +               ref_map =3D prefetch_filtered_ref_map;
> +       }
> +
>         ref_map =3D ref_remove_duplicates(ref_map);
>
>         for (rm =3D ref_map; rm; rm =3D rm->next) {
> diff --git a/remote.c b/remote.c
> index 8f3dee13186..6752c73370f 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -141,6 +141,7 @@ static struct remote *make_remote(struct remote_state=
 *remote_state,
>         ret->prune =3D -1;  /* unspecified */
>         ret->prune_tags =3D -1;  /* unspecified */
>         ret->name =3D xstrndup(name, len);
> +       string_list_init_dup(&ret->prefetch_refs);
>         refspec_init(&ret->push, REFSPEC_PUSH);
>         refspec_init(&ret->fetch, REFSPEC_FETCH);
>
> @@ -166,6 +167,7 @@ static void remote_clear(struct remote *remote)
>         free((char *)remote->uploadpack);
>         FREE_AND_NULL(remote->http_proxy);
>         FREE_AND_NULL(remote->http_proxy_authmethod);
> +       string_list_clear(&remote->prefetch_refs, 0);
>  }
>
>  static void add_merge(struct branch *branch, const char *name)
> @@ -456,6 +458,12 @@ static int handle_config(const char *key, const char=
 *value,
>                 remote->prune =3D git_config_bool(key, value);
>         else if (!strcmp(subkey, "prunetags"))
>                 remote->prune_tags =3D git_config_bool(key, value);
> +       else if (!strcmp(subkey, "prefetchref")) {
> +               if (!value)
> +                       return config_error_nonbool(key);
> +               string_list_split(&remote->prefetch_refs, value, ' ', -1)=
;
> +               return 0;
> +       }
>         else if (!strcmp(subkey, "url")) {
>                 if (!value)
>                         return config_error_nonbool(key);
> @@ -868,7 +876,7 @@ struct strvec *push_url_of_remote(struct remote *remo=
te)
>         return remote->pushurl.nr ? &remote->pushurl : &remote->url;
>  }
>
> -static int match_name_with_pattern(const char *key, const char *name,
> +int match_refspec_name_with_pattern(const char *key, const char *name,
>                                    const char *value, char **result)
>  {
>         const char *kstar =3D strchr(key, '*');
> @@ -900,7 +908,7 @@ static int refspec_match(const struct refspec_item *r=
efspec,
>                          const char *name)
>  {
>         if (refspec->pattern)
> -               return match_name_with_pattern(refspec->src, name, NULL, =
NULL);
> +               return match_refspec_name_with_pattern(refspec->src, name=
, NULL, NULL);
>
>         return !strcmp(refspec->src, name);
>  }
> @@ -969,7 +977,7 @@ static int query_matches_negative_refspec(struct refs=
pec *rs, struct refspec_ite
>                         const char *key =3D refspec->dst ? refspec->dst :=
 refspec->src;
>                         const char *value =3D refspec->src;
>
> -                       if (match_name_with_pattern(key, needle, value, &=
expn_name))
> +                       if (match_refspec_name_with_pattern(key, needle, =
value, &expn_name))
>                                 string_list_append_nodup(&reversed, expn_=
name);
>                 } else if (refspec->matching) {
>                         /* For the special matching refspec, any query sh=
ould match */
> @@ -1014,7 +1022,7 @@ static void query_refspecs_multiple(struct refspec =
*rs,
>                 if (!refspec->dst || refspec->negative)
>                         continue;
>                 if (refspec->pattern) {
> -                       if (match_name_with_pattern(key, needle, value, r=
esult))
> +                       if (match_refspec_name_with_pattern(key, needle, =
value, result))
>                                 string_list_append_nodup(results, *result=
);
>                 } else if (!strcmp(needle, key)) {
>                         string_list_append(results, value);
> @@ -1043,7 +1051,7 @@ int query_refspecs(struct refspec *rs, struct refsp=
ec_item *query)
>                 if (!refspec->dst || refspec->negative)
>                         continue;
>                 if (refspec->pattern) {
> -                       if (match_name_with_pattern(key, needle, value, r=
esult)) {
> +                       if (match_refspec_name_with_pattern(key, needle, =
value, result)) {
>                                 query->force =3D refspec->force;
>                                 return 0;
>                         }
> @@ -1456,9 +1464,9 @@ static char *get_ref_match(const struct refspec *rs=
, const struct ref *ref,
>                         const char *dst_side =3D item->dst ? item->dst : =
item->src;
>                         int match;
>                         if (direction =3D=3D FROM_SRC)
> -                               match =3D match_name_with_pattern(item->s=
rc, ref->name, dst_side, &name);
> +                               match =3D match_refspec_name_with_pattern=
(item->src, ref->name, dst_side, &name);
>                         else
> -                               match =3D match_name_with_pattern(dst_sid=
e, ref->name, item->src, &name);
> +                               match =3D match_refspec_name_with_pattern=
(dst_side, ref->name, item->src, &name);
>                         if (match) {
>                                 matching_refs =3D i;
>                                 break;
> @@ -2076,7 +2084,7 @@ static struct ref *get_expanded_map(const struct re=
f *remote_refs,
>
>                 if (strchr(ref->name, '^'))
>                         continue; /* a dereference item */
> -               if (match_name_with_pattern(refspec->src, ref->name,
> +               if (match_refspec_name_with_pattern(refspec->src, ref->na=
me,
>                                             refspec->dst, &expn_name) &&
>                     !ignore_symref_update(expn_name, &scratch)) {
>                         struct ref *cpy =3D copy_ref(ref);
> diff --git a/remote.h b/remote.h
> index b901b56746d..9ffef206f23 100644
> --- a/remote.h
> +++ b/remote.h
> @@ -5,6 +5,7 @@
>  #include "hashmap.h"
>  #include "refspec.h"
>  #include "strvec.h"
> +#include "string-list.h"
>
>  struct option;
>  struct transport_ls_refs_options;
> @@ -77,6 +78,8 @@ struct remote {
>
>         struct refspec fetch;
>
> +       struct string_list prefetch_refs;
> +
>         /*
>          * The setting for whether to fetch tags (as a separate rule from=
 the
>          * configured refspecs);
> @@ -207,6 +210,9 @@ int count_refspec_match(const char *, struct ref *ref=
s, struct ref **matched_ref
>
>  int check_ref_type(const struct ref *ref, int flags);
>
> +int match_refspec_name_with_pattern(const char *key, const char *name,
> +                                       const char *value, char **result)=
;
> +
>  /*
>   * Free a single ref and its peer, or an entire list of refs and their p=
eers,
>   * respectively.
> diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
> index abae7a97546..fc1b5d14e75 100755
> --- a/t/t7900-maintenance.sh
> +++ b/t/t7900-maintenance.sh
> @@ -245,6 +245,91 @@ test_expect_success 'prefetch multiple remotes' '
>         test_subcommand git fetch remote2 $fetchargs <skip-remote1.txt
>  '
>
> +test_expect_success 'prefetch with positive prefetch ref patterns' '
> +       test_create_repo filter-prefetch-positive &&
> +       (
> +               cd filter-prefetch-positive &&
> +               test_commit initial &&
> +               git clone . clone2 &&
> +               git remote add remote2 "file://$(pwd)/clone2" &&
> +
> +               cd clone2 &&
> +               git checkout -b feature && test_commit feature-commit-2 &=
&
> +               git checkout -b wip/test && test_commit wip-test-commit-2=
 &&
> +               git checkout -b topic/x && test_commit topic-x-commit-2 &=
&
> +               git push -f origin feature wip/test topic/x &&
> +               cd .. &&
> +
> +               git config remote.remote2.prefetchref "refs/heads/feature=
" &&
> +               fetchargs=3D"--prefetch --prune --no-tags --no-write-fetc=
h-head \
> +                       --recurse-submodules=3Dno --quiet" &&
> +               GIT_TRACE2_EVENT=3D"$(pwd)/prefetch-positive.txt" \
> +                       git maintenance run --task=3Dprefetch 2>/dev/null=
 &&
> +               test_subcommand git fetch remote2 $fetchargs <prefetch-po=
sitive.txt &&
> +
> +               git rev-parse refs/prefetch/remotes/remote2/feature &&
> +               test_must_fail git rev-parse refs/prefetch/remotes/remote=
2/wip/test &&
> +               test_must_fail git rev-parse refs/prefetch/remotes/remote=
2/topic/x
> +       )
> +'
> +
> +test_expect_success 'prefetch with negative prefetch ref patterns' '
> +       test_create_repo filter-prefetch-negative &&
> +       (
> +               cd filter-prefetch-negative &&
> +               test_commit initial &&
> +               git clone . clone3 &&
> +               git remote add remote3 "file://$(pwd)/clone3" &&
> +               cat .git/config &&
> +
> +               cd clone3 &&
> +               git checkout -b feature && test_commit feature-commit-3 &=
&
> +               git checkout -b wip/test && test_commit wip-test-commit-3=
 &&
> +               git checkout -b topic/x && test_commit topic-x-commit-3 &=
&
> +               git push -f origin feature wip/test topic/x &&
> +               cd .. &&
> +
> +               git config remote.remote3.prefetchref "!refs/heads/wip/*"=
 &&
> +               fetchargs=3D"--prefetch --prune --no-tags --no-write-fetc=
h-head \
> +                       --recurse-submodules=3Dno --quiet" &&
> +               GIT_TRACE2_EVENT=3D"$(pwd)/prefetch-negative.txt" \
> +                       git maintenance run --task=3Dprefetch 2>/dev/null=
 &&
> +               test_subcommand git fetch remote3 $fetchargs <prefetch-ne=
gative.txt &&
> +               git rev-parse refs/prefetch/remotes/remote3/feature &&
> +               git rev-parse refs/prefetch/remotes/remote3/topic/x &&
> +               test_must_fail git rev-parse refs/prefetch/remotes/remote=
3/wip/test
> +       )
> +'
> +
> +test_expect_success 'prefetch with positive & negative prefetch ref patt=
erns' '
> +       test_create_repo filter-prefetch-mixed &&
> +       (
> +               cd filter-prefetch-mixed &&
> +               test_commit initial &&
> +               git clone . clone4 &&
> +               git remote add remote4 "file://$(pwd)/clone4" &&
> +
> +               cd clone4 &&
> +               git checkout -b feature && test_commit feature-commit-4 &=
&
> +               git checkout -b topic/x && test_commit topic-x-commit-4 &=
&
> +               git checkout -b topic/y && test_commit topic-y-commit-4 &=
&
> +               git push -f origin feature topic/x topic/y &&
> +               cd .. &&
> +
> +               git config remote.remote4.prefetchref \
> +                       "refs/heads/topic/* !refs/heads/topic/y" &&
> +               fetchargs=3D"--prefetch --prune --no-tags --no-write-fetc=
h-head \
> +                       --recurse-submodules=3Dno --quiet" &&
> +               GIT_TRACE2_EVENT=3D"$(pwd)/prefetch-mixed.txt" \
> +                       git maintenance run --task=3Dprefetch 2>/dev/null=
 &&
> +               test_subcommand git fetch remote4 $fetchargs <prefetch-mi=
xed.txt &&
> +
> +               test_must_fail git rev-parse refs/prefetch/remotes/remote=
4/feature &&
> +               test_must_fail git rev-parse refs/prefetch/remotes/remote=
4/topic/y &&
> +               git rev-parse refs/prefetch/remotes/remote4/topic/x
> +       )
> +'
> +
>  test_expect_success 'loose-objects task' '
>         # Repack everything so we know the state of the object dir
>         git repack -adk &&
>
> base-commit: 2e7b89e038c0c888acf61f1b4ee5a43d4dd5e94c
> --
> gitgitgadget

A friendly bump to revive this thread to see if the code looks good to
you Junio.
