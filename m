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
	by dcvr.yhbt.net (Postfix) with ESMTP id D8BB41F461
	for <e@80x24.org>; Thu, 27 Jun 2019 23:22:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbfF0XWL (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jun 2019 19:22:11 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36339 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbfF0XWL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jun 2019 19:22:11 -0400
Received: by mail-ed1-f65.google.com with SMTP id k21so8707729edq.3
        for <git@vger.kernel.org>; Thu, 27 Jun 2019 16:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IBwhFtXUXPZ75m5JpOqdzepf8zx65wSKeLGQpH0xLJs=;
        b=KfD00giE11vDcG14UqTEHakxoAFWML5Hn3rl6zLXScbru7pvv2Z+jth5xGx3ptSZUa
         kQs55+spNbvPLlx+rA38/M3A6fn1lapnBEIGzK5ba7f7wO9PClceXt1zekRxtiLFkf7y
         XZIeNnuQnYVld3h9ZIlgNX9co6h55vXCiBxH3AtWSEwct57vZBEzpI/qXcgtpZ1Mmx/3
         QUV3FUPtZ7eeuA6qSf/icTITWH3wy+pDrR1Hj4o+80uFRH2JVd2wFCqk1a9MdvRBC2GZ
         Ulx2Uy1n7b12prJ8iCHeQJDgBsmFD0zEVdYiLg2pTNaB5UYZmJ0IsqV/Jhy3SXKPfs//
         cR0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IBwhFtXUXPZ75m5JpOqdzepf8zx65wSKeLGQpH0xLJs=;
        b=FsBUUO/0JRuHeFBqeCx3FqoyKqgeaL0MLUJtUjLe73gxI3DkKkHDMa3N6c+tlMRAOP
         znZiByC66UVcFlT/mXiM/OYfGKa6AUW3urNAhZP73j2sEr8N+8CENuPEs5vDeybrPQ+H
         9A4ugJ6n1Sy7R863mKM6wTPbKvYUxYdQtW9SdQkHRbLwUDUxwioHye9j1CDq3oQopiPe
         7w/VRYX/Nn/HN0y5XPQce1Bmyyct06EkK7nMbQ2CD9rZAamdJiObncIVPMpGTfWRyFta
         UP3Bh6hXXjgYXp0D68dG+PNHQjCiVXrvQP8nXwnnerKaKy3KBBa+JzjIFbK2JnNReBqW
         KAyQ==
X-Gm-Message-State: APjAAAXXwNH94Os09Z+bMC0xXiOTHCnN/KG3cpc/mIaRKNpN+bv08vRh
        8frbEIiiEqGmE2jKEregkLybQFDRzx1LBsuWbwKAbw==
X-Google-Smtp-Source: APXvYqxeOZbYUOVW3ZLQ0j6BSQFEx9Z3yn+ALOuGB2A2SaPrcYREiUOY5iXNLGspK90hfdYQfqSK3qJNlcbnXaoZQNI=
X-Received: by 2002:a17:906:f0cd:: with SMTP id dk13mr5749005ejb.84.1561677728804;
 Thu, 27 Jun 2019 16:22:08 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1561588479.git.me@ttaylorr.com> <e41db267f7b7086126e9fd3fd5b1a02e38c8c077.1561588479.git.me@ttaylorr.com>
In-Reply-To: <e41db267f7b7086126e9fd3fd5b1a02e38c8c077.1561588479.git.me@ttaylorr.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 27 Jun 2019 16:21:57 -0700
Message-ID: <CA+P7+xqhFY2gcV=3f8TgemOPPiPnyZU1CgXoNSzoh60bdw1OYQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] ref-filter.c: find disjoint pattern prefixes
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Git mailing list <git@vger.kernel.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 26, 2019 at 3:44 PM Taylor Blau <me@ttaylorr.com> wrote:
>

Ok, now I've got some time to look at the code itself.

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
> @@ -1790,21 +1791,62 @@ static int filter_pattern_match(struct ref_filter *filter, const char *refname)
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
> +       const char *a = *(const char **)va;
> +       const char *b = *(const char **)vb;
>
> -       for (p = pattern; *p && !is_glob_special(*p); p++)
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
> +       for (i = 0; i < nr; i++) {
> +               char c = patterns[i][prefix->len];
> +               if (!c || is_glob_special(c)) {
> +                       string_list_append(out, prefix->buf);
> +                       return;
> +               }
> +       }

Ok, so we loop over the patterns, find the last character up to our
current prefix length, and check if it's either the end of the string,
or a special glob character. I assume that the patterns are sorted so
that prefix->len never goes past the array?

If we find one, we just add this to the list and return, since we
found an unambigous one.

Otherwise, we keep searching recursively.

So, prefix is a strbuf, and its length will initially be zero. So, we
check all patterns, up to the prefix length and check the character
just past the end of our prefix. If it matches a NUL or glob
character, then we have found an exact match up to a glob, so this
gets returned.

Otherwise we continue:

> +
> +       i = 0;
> +       while (i < nr) {
> +               size_t end;
> +

Here, we're going to loop from beginning to end of all of the strings.

> +               /*
> +               * Set "end" to the index of the element _after_ the last one
> +               * in our group.
> +               */
> +               for (end = i + 1; end < nr; end++) {
> +                       if (patterns[i][prefix->len] != patterns[end][prefix->len])
> +                               break;
> +               }
> +

We break on the first string which doesn't have the same length as our
current prefix, but start with the ones after the current loop
iteration.

> +               strbuf_addch(prefix, patterns[i][prefix->len]);
> +               find_longest_prefixes_1(out, prefix, patterns + i, end - i);
> +               strbuf_setlen(prefix, prefix->len - 1);
> +

We'll add the next character to the prefix, and then find longest
prefixes again.

This basically has us recurse and keep adding additional characters,
essentially splitting the strings apart by their disjoint sets.

I think this works, but it's definitely not clear from reading exactly
what is going on. I think this algorithm would benefit from a comment,
since it doesn't quite seem to match your description in the commit
message.

> +               i = end;
> +       }
> +}
> +
> +static void find_longest_prefixes(struct string_list *out,
> +                                 const char **patterns)
> +{
> +       struct argv_array sorted = ARGV_ARRAY_INIT;
> +       struct strbuf prefix = STRBUF_INIT;
> +
> +       argv_array_pushv(&sorted, patterns);
> +       QSORT(sorted.argv, sorted.argc, qsort_strcmp);
> +

We've sorted the patterns, and then we call find_longest_prefixes_1. Ok.

> +       find_longest_prefixes_1(out, &prefix, sorted.argv, sorted.argc);
> +
> +       argv_array_clear(&sorted);
> +       strbuf_release(&prefix);
>  }
>
>  /*
> @@ -1817,7 +1859,8 @@ static int for_each_fullref_in_pattern(struct ref_filter *filter,
>                                        void *cb_data,
>                                        int broken)
>  {
> -       struct strbuf prefix = STRBUF_INIT;
> +       struct string_list prefixes = STRING_LIST_INIT_DUP;
> +       struct string_list_item *prefix;
>         int ret;
>
>         if (!filter->match_as_path) {
> @@ -1843,21 +1886,15 @@ static int for_each_fullref_in_pattern(struct ref_filter *filter,
>                 return for_each_fullref_in("", cb, cb_data, broken);
>         }
>
> -       if (filter->name_patterns[1]) {
> -               /*
> -                * multiple patterns; in theory this could still work as long
> -                * as the patterns are disjoint. We'd just make multiple calls
> -                * to for_each_ref(). But if they're not disjoint, we'd end up
> -                * reporting the same ref multiple times. So let's punt on that
> -                * for now.
> -                */
> -               return for_each_fullref_in("", cb, cb_data, broken);
> +       find_longest_prefixes(&prefixes, filter->name_patterns);
> +
> +       for_each_string_list_item(prefix, &prefixes) {
> +               ret = for_each_fullref_in(prefix->string, cb, cb_data, broken);
> +               if (ret)
> +                       break;
>         }
>
> -       find_longest_prefix(&prefix, filter->name_patterns[0]);
> -
> -       ret = for_each_fullref_in(prefix.buf, cb, cb_data, broken);
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
> +       git for-each-ref --format="%(refname)" \
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
> +       git for-each-ref --format="%(refname)" \
> +               refs/tags/testtag "refs/tags/testtag-*" >actual &&
> +       test_cmp expected actual
> +'
> +
>  cat >expected <<\EOF
>  'refs/heads/master'
>  'refs/remotes/origin/master'
> --
> 2.21.0.203.g358da99528
