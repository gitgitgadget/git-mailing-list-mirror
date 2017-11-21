Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7677D2036D
	for <e@80x24.org>; Tue, 21 Nov 2017 23:28:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751494AbdKUX2q (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 18:28:46 -0500
Received: from mail-qk0-f178.google.com ([209.85.220.178]:46231 "EHLO
        mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751445AbdKUX2p (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Nov 2017 18:28:45 -0500
Received: by mail-qk0-f178.google.com with SMTP id b85so14451680qkc.13
        for <git@vger.kernel.org>; Tue, 21 Nov 2017 15:28:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=e6yXrTxEpBy5lVfEhD+w3K/ELmKkW2fdQP06/2dsY1k=;
        b=IEYkUeFesPpRqIIS9B775JZUMX8KQvzpRn3l8T0r2Yj1KGCGxXaXBxMWUn2RWf8Ypc
         yg1Pi7u7YiMmqgOzhBaKBu8d/y1fPa7uKbudjoZ+/SMkj1szkQhXTcjP0mQ1Jx4e24qg
         N7kbXpQ0XZxIKVjrDaxF3OdkiUsTISpMFC2s3hcbgF+h2XzbTHw3idKbaUpVNmDnowqM
         k0O24Il7EY2mdCyybtPib/RCnr8b40FaCImRwQczguWP17uDQhgWUPkmp0mssgWybW/U
         JZfz1fuiC0mIxmldEyaVpXyrK1TXmUIRbxJ3AEtwxzC6pSO+BijNOK9vxsSGHd1DOIip
         i1zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=e6yXrTxEpBy5lVfEhD+w3K/ELmKkW2fdQP06/2dsY1k=;
        b=SyICpIb6hKRhuEyMIpu4mu0qF/zqcBMxTrc8Pk9uFzSbekiZxoauLxjirNH7JCaBo5
         5PmTXhN9aMau8mbcycWCup+0394co0G+YWzAjhPQYaoNwoY8B89vin/Ak0vLfGx7viCb
         o5/zGJJA0Jih+8hiY4K7K3j4o96QcD4WF+ucyG1qCSClM7TcPhfolYVo4wBA3jVRA0rn
         m5QZ/p3rUaEnsuVwS1bamKzf3tlKG2BpZFXtQ+veIijYp6xWXXq9Fny1hxzZESvG+qYz
         6cimoHlXm4yE9Naa6iSmld1MEUWCi0LgeRL41qFSTYRTrlzrDP/zomidP0Uf3c9Z+icH
         mwjw==
X-Gm-Message-State: AJaThX5UMO/68oyEKrJ7Q1/ZCfNpa9fUHfy22wsOheHkkzW92IKompSv
        m5zu2xqGnUKWySmipIy9DlkG+BEwMTplQo27NUst3KW32X8=
X-Google-Smtp-Source: AGs4zMbaQo/bGdot2y8c+UOOGvlfxBVPGnlip0PoWmvIxftF0/ex8Bh5Nvg5WESOIlIlt+dKPILdnqFMrneVXhZgFB8=
X-Received: by 10.55.76.85 with SMTP id z82mr30199720qka.346.1511306924551;
 Tue, 21 Nov 2017 15:28:44 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.85.179 with HTTP; Tue, 21 Nov 2017 15:28:43 -0800 (PST)
In-Reply-To: <20171121221717.155301-1-jonathantanmy@google.com>
References: <20171121221717.155301-1-jonathantanmy@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 21 Nov 2017 15:28:43 -0800
Message-ID: <CAGZ79kba49xP8m2gf-BAGkUhJ_=qwwr6LVJohbA+afFhjOn49w@mail.gmail.com>
Subject: Re: [RFC PATCH] xdiff/xpatience: support anchoring a line
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 21, 2017 at 2:17 PM, Jonathan Tan <jonathantanmy@google.com> wrote:
> Teach the patience diff to support prohibiting a user-specified line
> from appearing as a deletion or addition in the end result.
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
> I'm sending this out to see if a change similar to this would be
> welcome. It is useful to me as a reviewer (to check my own code, e.g.
> when checking [1]). Probably more design needs to go into this,
> including the best way to specify the "anchor" line, and the correct
> behavior when the anchor is either not found or appears more than once.
>
> Any thoughts?

The background from this whole idea is that the Myers diff algorithm
may produce the shortest diff, which is good for computer consumption
or transport, but not ideal for human review. To accommodate human
review we need to couple the diff with higher level concepts, such as
move detection or ignoring blanks.

I would imagine that this anchor can be set by a user to a function
header or other significant line, such that the commit is more in line with
the diff itself ("move code out of function A into its helper" would not
want to have the "function A" line jump around, but the code should
be removed from the function, hence you'd anchor the function).

The solution you provide is a good thing to experiment with, but
longer term, I would want to have huge record of configs in which
humans selected the best diff, such that we can use that data
to reason about better automatic diff generation.
The diff heuristic was based on a lot of human generated data,
that was generated by Michael at the time. I wonder if we want to
permanently store the anchor so the data collection will happen
automatically over time.

I had a similar idea, which would affix a given coordinate of the map[1]
to be on the path. I imagine it similar to e.g. Google Maps in which you
can select intermittent way points on your route.

When having this rather abstract coordinate, which can be
given as line number in pre and post image, then we would not
need to think about questions whether a given line is found or
appears multiple times; however users like concise input the best,
so the idea of an "anchor line" might be the best representation for
the user, which is internally translated into way points.

[1] think of http://simplygenius.net/ArticleFiles/DiffTutorial/diagonals.png

Stefan

> [1]
> https://public-inbox.org/git/20171121221256.154741-1-jonathantanmy@google.com/
> ---
>  t/t4033-diff-patience.sh | 13 +++++++++++++
>  xdiff/xpatience.c        | 29 +++++++++++++++++++++++++++--
>  2 files changed, 40 insertions(+), 2 deletions(-)
>
> diff --git a/t/t4033-diff-patience.sh b/t/t4033-diff-patience.sh
> index 113304dc5..2147fd688 100755
> --- a/t/t4033-diff-patience.sh
> +++ b/t/t4033-diff-patience.sh
> @@ -13,6 +13,19 @@ test_expect_success '--ignore-space-at-eol with a single appended character' '
>         grep "^+.*X" diff
>  '
>
> +test_expect_success 'anchor' '
> +       printf "a\nb\nc\n" >pre &&
> +       printf "c\na\nb\n" >post &&
> +
> +       # without anchor, c is moved
> +       test_expect_code 1 git diff --no-index --patience pre post >diff &&
> +       grep "^+c" diff &&
> +
> +       # with anchor, a is moved
> +       DIFF_ANCHOR=c test_expect_code 1 git diff --no-index --patience pre post >diff &&
> +       grep "^+a" diff

or rather: "c is not moved, we don't care how the diff actually looks like",
so maybe
      ! grep "+c" diff


> diff --git a/xdiff/xpatience.c b/xdiff/xpatience.c
> index a44e77632..195a60e57 100644
> --- a/xdiff/xpatience.c
> +++ b/xdiff/xpatience.c
> @@ -62,6 +62,8 @@ struct hashmap {
>                  * initially, "next" reflects only the order in file1.
>                  */
>                 struct entry *next, *previous;
> +
> +               unsigned anchor : 1;

While this is RFC, I should not expect comments, though it would
be nice to have them in the final series. ;-)

>         } *entries, *first, *last;
>         /* were common records found? */
>         unsigned long has_matches;
> @@ -70,6 +72,14 @@ struct hashmap {
>         xpparam_t const *xpp;
>  };
>
> +static int is_anchor(const char *line)
> +{
> +       char *anchor = getenv("DIFF_ANCHOR");
> +       if (!anchor)
> +               return 0;
> +       return !strncmp(line, anchor, strlen(anchor));
> +}
> +
>  /* The argument "pass" is 1 for the first file, 2 for the second. */
>  static void insert_record(int line, struct hashmap *map, int pass)
>  {
> @@ -110,6 +120,7 @@ static void insert_record(int line, struct hashmap *map, int pass)
>                 return;
>         map->entries[index].line1 = line;
>         map->entries[index].hash = record->ha;
> +       map->entries[index].anchor = is_anchor(map->env->xdf1.recs[line - 1]->ptr);
>         if (!map->first)
>                 map->first = map->entries + index;
>         if (map->last) {
> @@ -192,14 +203,28 @@ static struct entry *find_longest_common_sequence(struct hashmap *map)
>         int longest = 0, i;
>         struct entry *entry;
>
> +       /*
> +        * If not -1, this entry in sequence must never be overridden. (Also,
> +        * do not override entries in sequence before this entry, since it is
> +        * useless.)
> +        */
> +       int anchor_i = -1;
> +
>         for (entry = map->first; entry; entry = entry->next) {
>                 if (!entry->line2 || entry->line2 == NON_UNIQUE)
>                         continue;
>                 i = binary_search(sequence, longest, entry);
>                 entry->previous = i < 0 ? NULL : sequence[i];
> -               sequence[++i] = entry;
> -               if (i == longest)
> +               ++i;
> +               if (i <= anchor_i)
> +                       continue;
> +               sequence[i] = entry;
> +               if (anchor_i == -1 && entry->anchor) {
> +                       anchor_i = i;
> +                       longest = anchor_i + 1;
> +               } else if (i == longest) {
>                         longest++;
> +               }
>         }
>
>         /* No common unique lines were found */
> --
> 2.15.0.448.gf294e3d99a-goog
>
