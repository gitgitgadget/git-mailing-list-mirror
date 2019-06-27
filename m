Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3857C1F461
	for <e@80x24.org>; Thu, 27 Jun 2019 00:37:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728730AbfF0Ah6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Jun 2019 20:37:58 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33434 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728133AbfF0Ah4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jun 2019 20:37:56 -0400
Received: by mail-ed1-f68.google.com with SMTP id i11so5399272edq.0
        for <git@vger.kernel.org>; Wed, 26 Jun 2019 17:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4aolBQxTiEENi2P9S36u/cUUcqpWDaTAwxwucwL3si4=;
        b=ABMc/PgUcby+bFhT1IJNd1tKLqGVpODS0wwfXPaEZZ05gCyaTnNAae/7DDIw0d2Ugc
         6pIAw+DNTZl/hRKEE6tdm/qBYIiI0EB36HcH8nV+2e0f749ojCenzhy708SzpyZLv7Fs
         nFOeYjosCiNr4tgk6z0owTr7H5s3rcMMLMTb5GHtCV5QQ0uVkS/0f/yiawbeO+YtC2KS
         ww8vJlRabY0ZB7CRXzfuE6xR+fefUfK3WQstE/+frwKpnThrFEvB9zfpEy0T/CGyBakR
         +GnzO+3eCnwoGbvXReTYSYCPF2dJkgdtGJB9ah8cWUEYK/PD6o3T6PyITneJIsZeJsk5
         ZNtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4aolBQxTiEENi2P9S36u/cUUcqpWDaTAwxwucwL3si4=;
        b=M7KD+qpC20bKxcwzbFfE4ZZXt1FTT5gSgUNgUwk6CokjbrzZfWPFmo46U+T5RpuLCp
         NOnDEH3aPMRwnFfvT1y/YeTHioGDj/uqOgP5aD5wClb0vQA+0+bmVaJNERcTy4djri2g
         U/c+V6Ji/UEERzgxnxGu3CKejwnPYFrqSrg4Qkhc6sAPvA7I7zl1lOiENvGkGao9Si9b
         si82wLJqfOHXVANudH/cjjG++S9XiuJVePpgA72HGM1LGxwdynN4WeTe03YKZoBNXMpH
         rUdn/4RRUiR5kRqkhe7BDDPfLzK1UBUPoMVaTJDGLBxcdBZLTMJxLOhOJ1KwSSRZoIfy
         cvaw==
X-Gm-Message-State: APjAAAVA88molcSGnhmggHxXsM68YCl1tk87xwGNY9C4UljIrqbrwV9+
        0U9OIM1ZqL4eFPAPl4tl2C4gSXy9hh+tG9Z/XJQ6gw==
X-Google-Smtp-Source: APXvYqw9Zj1XmkT1N0qeYvWh31aVKBiQPTjkDuZG5s+ziEzXW5J5xr62mJ7kmc5q39687IxCsTS2QId/67tn842+Zh0=
X-Received: by 2002:a17:906:d201:: with SMTP id w1mr518174ejz.303.1561595873964;
 Wed, 26 Jun 2019 17:37:53 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1561588479.git.me@ttaylorr.com> <e41db267f7b7086126e9fd3fd5b1a02e38c8c077.1561588479.git.me@ttaylorr.com>
In-Reply-To: <e41db267f7b7086126e9fd3fd5b1a02e38c8c077.1561588479.git.me@ttaylorr.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Wed, 26 Jun 2019 17:37:42 -0700
Message-ID: <CA+P7+xqQv4UZMy7fEHnGHejU6nvhVKgkSruXdmW-akqUG1TLKA@mail.gmail.com>
Subject: Re: [PATCH 1/1] ref-filter.c: find disjoint pattern prefixes
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Git mailing list <git@vger.kernel.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 26, 2019 at 3:44 PM Taylor Blau <me@ttaylorr.com> wrote:
>
> Since cfe004a5a9 (ref-filter: limit traversal to prefix, 2017-05-22),
> the ref-filter code has sought to limit the traversals to a prefix of
> the given patterns.
>
> That code stopped short of handling more than one pattern, because it
> means invoking 'for_each_ref_in' multiple times. If we're not careful
> about which patterns overlap, we will output the same refs multiple
> times.

Right.

>
> For instance, consider the set of patterns 'refs/heads/a/*',
> 'refs/heads/a/b/c', and 'refs/tags/v1.0.0'. If we na=C4=8Fvely ran:
>
>   for_each_ref_in("refs/heads/a/*", ...);
>   for_each_ref_in("refs/heads/a/b/c", ...);
>   for_each_ref_in("refs/tags/v1.0.0", ...);
>
> we would see 'refs/heads/a/b/c' (and everything underneath it) twice.
>

Explaining why we ignored solving this before..

> Instead, we want to partition the patterns into disjoint sets, where we
> know that no ref will be matched by any two patterns in different sets.
> In the above, these are:
>
>   - {'refs/heads/a/*', 'refs/heads/a/b/c'}, and
>   - {'refs/tags/v1.0.0'}

Is this disjoint set calculation already existing, or did you have to
add it in this patch?

>
> Given one of these disjoint sets, what is a suitable pattern to pass to
> 'for_each_ref_in'? One approach is to compute the longest common prefix
> over all elements in that disjoint set, and let the caller cull out the
> refs they didn't want. Computing the longest prefix means that in most
> cases, we won't match too many things the caller would like to ignore.
>
> The longest common prefixes of the above are:
>
>   - {'refs/heads/a/*', 'refs/heads/a/b/c'} -> refs/heads/a/*
>   - {'refs/tags/v1.0.0'}                   -> refs/tags/v1.0.0
>
> We instead invoke:
>
>   for_each_ref_in("refs/heads/a/*", ...);
>   for_each_ref_in("refs/tags/v1.0.0", ...);
>
> Which provides us with the refs we were looking for with a minimal
> amount of extra cruft, but never a duplicate of the ref we asked for.
>
> Implemented here is an algorithm which accomplishes the above, which
> works as follows:
>
>   1. Lexicographically sort the given list of patterns.
>
>   2. Initialize 'prefix' to the empty string, where our goal is to
>      build each element in the above set of longest common prefixes.
>
>   3. Consider each pattern in the given set, and emit 'prefix' if it
>      reaches the end of a pattern, or touches a wildcard character. The
>      end of a string is treated as if it precedes a wildcard. (Note that
>      there is some room for future work to detect that, e.g., 'a?b' and
>      'abc' are disjoint).

Neat, so you're calculating disjoint patterns inline while also
figuring out which one is the "best" for any given pattern set...
Neat!

>
>   4. Otherwise, recurse on step (3) with the slice of the list
>      corresponding to our current prefix (i.e., the subset of patterns
>      that have our prefix as a literal string prefix.)
>
> This algorithm is 'O(kn + n log(n))', where 'k' is max(len(pattern)) for
> each pattern in the list, and 'n' is len(patterns).
>

ok, so if we can assume that k is some relatively small constant
number (since the maximum pattern length isn't likely to grow without
bounds), this is O(n*log(n)) on the number of patterns, so we don't
even approach n^2 even when we are given a large number of patterns.
Nice!

> By discovering this set of interesting patterns, we reduce the runtime
> of multi-pattern 'git for-each-ref' (and other ref traversals) from
> O(N) to O(n log(N)), where 'N' is the total number of packed references.

So here, n is the number of patterns still? This seems like a pretty
significant gane when we have a large number of packed references.

>
> Running 'git for-each-ref refs/tags/a refs/tags/b' on a repository with
> 10,000,000 refs in 'refs/tags/huge-N', my best-of-five times drop from:
>
>   real    0m5.805s
>   user    0m5.188s
>   sys     0m0.468s
>
> to:
>
>   real    0m0.001s
>   user    0m0.000s
>   sys     0m0.000s
>

That's a pretty significant decrease!

> On linux.git, the times to dig out two of the latest -rc tags drops from
> 0.002s to 0.001s, so the change on repositories with fewer tags is much
> less noticeable.
>

This explains why it might not have been done before.. many
repositories wouldn't benefit much.

That said, the patch description doesn't make it seem very
complicated. I did run out of time reading the message, so I'll have
to follow up reviewing the actual change below later. I think the
description of the goal and solution is sound though.

Thanks,
Jake

> Co-authored-by: Jeff King <peff@peff.net>
> Signed-off-by: Jeff King <peff@peff.net>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  ref-filter.c            | 89 +++++++++++++++++++++++++++++------------
>  t/t6300-for-each-ref.sh | 26 ++++++++++++
>  2 files changed, 89 insertions(+), 26 deletions(-)
>
> diff --git a/ref-filter.c b/ref-filter.c
> index 8500671bc6..3e10fd647b 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -20,6 +20,7 @@
>  #include "commit-slab.h"
>  #include "commit-graph.h"
>  #include "commit-reach.h"
> +#include "argv-array.h"
>
>  static struct ref_msg {
>         const char *gone;
> @@ -1790,21 +1791,62 @@ static int filter_pattern_match(struct ref_filter=
 *filter, const char *refname)
>         return match_pattern(filter, refname);
>  }
>
> -/*
> - * Find the longest prefix of pattern we can pass to
> - * `for_each_fullref_in()`, namely the part of pattern preceding the
> - * first glob character. (Note that `for_each_fullref_in()` is
> - * perfectly happy working with a prefix that doesn't end at a
> - * pathname component boundary.)
> - */
> -static void find_longest_prefix(struct strbuf *out, const char *pattern)
> +static int qsort_strcmp(const void *va, const void *vb)
>  {
> -       const char *p;
> +       const char *a =3D *(const char **)va;
> +       const char *b =3D *(const char **)vb;
>
> -       for (p =3D pattern; *p && !is_glob_special(*p); p++)
> -               ;
> +       return strcmp(a, b);
> +}
>
> -       strbuf_add(out, pattern, p - pattern);
> +static void find_longest_prefixes_1(struct string_list *out,
> +                                 struct strbuf *prefix,
> +                                 const char **patterns, size_t nr)
> +{
> +       size_t i;
> +
> +       for (i =3D 0; i < nr; i++) {
> +               char c =3D patterns[i][prefix->len];
> +               if (!c || is_glob_special(c)) {
> +                       string_list_append(out, prefix->buf);
> +                       return;
> +               }
> +       }
> +
> +       i =3D 0;
> +       while (i < nr) {
> +               size_t end;
> +
> +               /*
> +               * Set "end" to the index of the element _after_ the last =
one
> +               * in our group.
> +               */
> +               for (end =3D i + 1; end < nr; end++) {
> +                       if (patterns[i][prefix->len] !=3D patterns[end][p=
refix->len])
> +                               break;
> +               }
> +
> +               strbuf_addch(prefix, patterns[i][prefix->len]);
> +               find_longest_prefixes_1(out, prefix, patterns + i, end - =
i);
> +               strbuf_setlen(prefix, prefix->len - 1);
> +
> +               i =3D end;
> +       }
> +}
> +
> +static void find_longest_prefixes(struct string_list *out,
> +                                 const char **patterns)
> +{
> +       struct argv_array sorted =3D ARGV_ARRAY_INIT;
> +       struct strbuf prefix =3D STRBUF_INIT;
> +
> +       argv_array_pushv(&sorted, patterns);
> +       QSORT(sorted.argv, sorted.argc, qsort_strcmp);
> +
> +       find_longest_prefixes_1(out, &prefix, sorted.argv, sorted.argc);
> +
> +       argv_array_clear(&sorted);
> +       strbuf_release(&prefix);
>  }
>
>  /*
> @@ -1817,7 +1859,8 @@ static int for_each_fullref_in_pattern(struct ref_f=
ilter *filter,
>                                        void *cb_data,
>                                        int broken)
>  {
> -       struct strbuf prefix =3D STRBUF_INIT;
> +       struct string_list prefixes =3D STRING_LIST_INIT_DUP;
> +       struct string_list_item *prefix;
>         int ret;
>
>         if (!filter->match_as_path) {
> @@ -1843,21 +1886,15 @@ static int for_each_fullref_in_pattern(struct ref=
_filter *filter,
>                 return for_each_fullref_in("", cb, cb_data, broken);
>         }
>
> -       if (filter->name_patterns[1]) {
> -               /*
> -                * multiple patterns; in theory this could still work as =
long
> -                * as the patterns are disjoint. We'd just make multiple =
calls
> -                * to for_each_ref(). But if they're not disjoint, we'd e=
nd up
> -                * reporting the same ref multiple times. So let's punt o=
n that
> -                * for now.
> -                */
> -               return for_each_fullref_in("", cb, cb_data, broken);
> +       find_longest_prefixes(&prefixes, filter->name_patterns);
> +
> +       for_each_string_list_item(prefix, &prefixes) {
> +               ret =3D for_each_fullref_in(prefix->string, cb, cb_data, =
broken);
> +               if (ret)
> +                       break;
>         }
>
> -       find_longest_prefix(&prefix, filter->name_patterns[0]);
> -
> -       ret =3D for_each_fullref_in(prefix.buf, cb, cb_data, broken);
> -       strbuf_release(&prefix);
> +       string_list_clear(&prefixes, 0);
>         return ret;
>  }
>
> diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
> index d9235217fc..ab69aa176d 100755
> --- a/t/t6300-for-each-ref.sh
> +++ b/t/t6300-for-each-ref.sh
> @@ -345,6 +345,32 @@ test_expect_success 'Verify descending sort' '
>         test_cmp expected actual
>  '
>
> +cat >expected <<\EOF
> +refs/tags/testtag
> +refs/tags/testtag-2
> +EOF
> +
> +test_expect_success 'exercise patterns with prefixes' '
> +       git tag testtag-2 &&
> +       test_when_finished "git tag -d testtag-2" &&
> +       git for-each-ref --format=3D"%(refname)" \
> +               refs/tags/testtag refs/tags/testtag-2 >actual &&
> +       test_cmp expected actual
> +'
> +
> +cat >expected <<\EOF
> +refs/tags/testtag
> +refs/tags/testtag-2
> +EOF
> +
> +test_expect_success 'exercise glob patterns with prefixes' '
> +       git tag testtag-2 &&
> +       test_when_finished "git tag -d testtag-2" &&
> +       git for-each-ref --format=3D"%(refname)" \
> +               refs/tags/testtag "refs/tags/testtag-*" >actual &&
> +       test_cmp expected actual
> +'
> +
>  cat >expected <<\EOF
>  'refs/heads/master'
>  'refs/remotes/origin/master'
> --
> 2.21.0.203.g358da99528
