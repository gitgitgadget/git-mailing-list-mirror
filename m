Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFA601F406
	for <e@80x24.org>; Sat, 12 May 2018 21:17:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751855AbeELVRj (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 May 2018 17:17:39 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:45108 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751739AbeELVRi (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 May 2018 17:17:38 -0400
Received: by mail-pl0-f67.google.com with SMTP id bi12-v6so5173028plb.12
        for <git@vger.kernel.org>; Sat, 12 May 2018 14:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=xg3cm61VGHtHYLCsDYnRE4N6OvLJBqdjxHifaqSTDl8=;
        b=dJR5JZal8eCfWc/HyCoaiAqcbWSugBdZqH9h0nIUgzz3Ypl0fXYKJ+l5Tv+u4ufcy9
         pcAcpCyJLjU4Ue0CSxck7n/s2UDkoRUvT6HqBPjUPqwPGwUQhD8WV6t8t3YNgKOXEATi
         7UGrX0Z1EQmuM6BwNE8O+XF//2kJZrBJr6DTrOsTxStesTirotLz4nitsd32gKerZ5rc
         YTYYYyYhvva9e4hssUck3plAYJ4jFJYgdEM4pQ7V7adk6T4NbnMoe2bLX0ID0Vunp5Ih
         P0wYA9CW1kKusprwdqjPM5WaVYMcFIS8kThYG6mrugiGLiYvMmTFqUzBXz1XxDqSptW2
         g0gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xg3cm61VGHtHYLCsDYnRE4N6OvLJBqdjxHifaqSTDl8=;
        b=ZN9n3lGKRLwa8ngClcrLlZ73udvrg6lhfomiAHDOmAFgjLhAHt/PDu2eCORlGbINVK
         L6dnN0AFszL56d1LI9TlrSASJ1rgr77+xg27rUHBaDaX6UWa8VdR93b1N2xWafLsM6vT
         ULvVnTTEDITgs2flywwBEqy/jR+z3nMaKQBriR+jvhqMvB2kv87SfOxQafDAFDtc9yri
         b8OX1YTA8J+e0Rv/bN/MxJ5ro4z48S4F5ZhVyOQdTxazKh+/fXVFHiUtuhbrXosT6sGa
         vrmAKVrOCIJdqm7u4fYzHGyGYS+35L9NLW1KB0E47MKdelsFheqP+4Ag7pP7sXErFfjv
         kAaQ==
X-Gm-Message-State: ALKqPwcErKKLkwETkAKuIsnfotKq0fl0ja9R7B65GFFY4PYuzwhbbgd6
        MxKEu/+DZC7nh5Kow0d9Gcm1LhIzpOt85Dtbi4E=
X-Google-Smtp-Source: AB8JxZrBpzefhup6hk3EiHMdWE2xeYhXhCsD2rcnLUhXu46V7/fvDkI7Ozahm7zyxJn6jiaKaFRSST3i3i9MuhW23Ak=
X-Received: by 2002:a17:902:b94a:: with SMTP id h10-v6mr3811016pls.321.1526159858261;
 Sat, 12 May 2018 14:17:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.236.187.139 with HTTP; Sat, 12 May 2018 14:17:37 -0700 (PDT)
In-Reply-To: <20180511211504.79877-9-dstolee@microsoft.com>
References: <20180510173345.40577-1-dstolee@microsoft.com> <20180511211504.79877-1-dstolee@microsoft.com>
 <20180511211504.79877-9-dstolee@microsoft.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sat, 12 May 2018 23:17:37 +0200
Message-ID: <CAN0heSo2sTgVSoxUiugSaEjev+0eyzCRA5ZmQVr6FRtKkyGJsQ@mail.gmail.com>
Subject: Re: [PATCH v2 08/12] commit-graph: verify commit contents against odb
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "peff@peff.net" <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11 May 2018 at 23:15, Derrick Stolee <dstolee@microsoft.com> wrote:
> When running 'git commit-graph verify', compare the contents of the
> commits that are loaded from the commit-graph file with commits that are
> loaded directly from the object database. This includes checking the
> root tree object ID, commit date, and parents.
>
> Parse the commit from the graph during the initial loop through the
> object IDs to guarantee we parse from the commit-graph file.
>
> In addition, verify the generation number calculation is correct for all
> commits in the commit-graph file.
>
> While testing, we discovered that mutating the integer value for a
> parent to be outside the accepted range causes a segmentation fault. Add
> a new check in insert_parent_or_die() that prevents this fault. Check
> for that error during the test, both in the typical parents and in the
> list of parents for octopus merges.

This paragraph and the corresponding fix and test feel like a separate
patch to me. (The commit message of it could be "To test the next patch,
we threw invalid data at `git commit-graph verify, and it crashed in
pre-existing code, so let's fix that first" -- there is definitely a
connection.) Is this important enough to fast-track to master in time
for 2.18? My guess would be no.

> +
> +       if (pos >= g->num_commits)
> +               die("invalide parent position %"PRIu64, pos);

s/invalide/invalid/

> @@ -875,6 +879,8 @@ int verify_commit_graph(struct commit_graph *g)
>                 return 1;
>
>         for (i = 0; i < g->num_commits; i++) {
> +               struct commit *graph_commit;
> +
>                 hashcpy(cur_oid.hash, g->chunk_oid_lookup + g->hash_len * i);
>
>                 if (i && oidcmp(&prev_oid, &cur_oid) >= 0)
> @@ -892,6 +898,10 @@ int verify_commit_graph(struct commit_graph *g)
>
>                         cur_fanout_pos++;
>                 }
> +
> +               graph_commit = lookup_commit(&cur_oid);
> +               if (!parse_commit_in_graph_one(g, graph_commit))
> +                       graph_report("failed to parse %s from commit-graph", oid_to_hex(&cur_oid));
>         }

Could this end up giving ridiculous amounts of output? It would depend
on the input, I guess.

>         while (cur_fanout_pos < 256) {
> @@ -904,5 +914,95 @@ int verify_commit_graph(struct commit_graph *g)
>                 cur_fanout_pos++;
>         }
>
> +       if (verify_commit_graph_error)
> +               return 1;

Well, here we give up before running into *too* much problem.

> +       for (i = 0; i < g->num_commits; i++) {
> +               struct commit *graph_commit, *odb_commit;
> +               struct commit_list *graph_parents, *odb_parents;
> +               int num_parents = 0;
> +
> +               hashcpy(cur_oid.hash, g->chunk_oid_lookup + g->hash_len * i);
> +
> +               graph_commit = lookup_commit(&cur_oid);
> +               odb_commit = (struct commit *)create_object(cur_oid.hash, alloc_commit_node());
> +               if (parse_commit_internal(odb_commit, 0, 0)) {
> +                       graph_report("failed to parse %s from object database", oid_to_hex(&cur_oid));
> +                       continue;
> +               }
> +
> +               if (oidcmp(&get_commit_tree_in_graph_one(g, graph_commit)->object.oid,
> +                          get_commit_tree_oid(odb_commit)))
> +                       graph_report("root tree object ID for commit %s in commit-graph is %s != %s",
> +                                    oid_to_hex(&cur_oid),
> +                                    oid_to_hex(get_commit_tree_oid(graph_commit)),
> +                                    oid_to_hex(get_commit_tree_oid(odb_commit)));
> +
> +               if (graph_commit->date != odb_commit->date)
> +                       graph_report("commit date for commit %s in commit-graph is %"PRItime" != %"PRItime"",
> +                                    oid_to_hex(&cur_oid),
> +                                    graph_commit->date,
> +                                    odb_commit->date);
> +
> +
> +               graph_parents = graph_commit->parents;
> +               odb_parents = odb_commit->parents;
> +
> +               while (graph_parents) {
> +                       num_parents++;
> +
> +                       if (odb_parents == NULL)
> +                               graph_report("commit-graph parent list for commit %s is too long (%d)",
> +                                            oid_to_hex(&cur_oid),
> +                                            num_parents);
> +
> +                       if (oidcmp(&graph_parents->item->object.oid, &odb_parents->item->object.oid))
> +                               graph_report("commit-graph parent for %s is %s != %s",
> +                                            oid_to_hex(&cur_oid),
> +                                            oid_to_hex(&graph_parents->item->object.oid),
> +                                            oid_to_hex(&odb_parents->item->object.oid));
> +
> +                       graph_parents = graph_parents->next;
> +                       odb_parents = odb_parents->next;
> +               }
> +
> +               if (odb_parents != NULL)
> +                       graph_report("commit-graph parent list for commit %s terminates early",
> +                                    oid_to_hex(&cur_oid));
> +
> +               if (graph_commit->generation) {
> +                       uint32_t max_generation = 0;
> +                       graph_parents = graph_commit->parents;
> +
> +                       while (graph_parents) {
> +                               if (graph_parents->item->generation == GENERATION_NUMBER_ZERO ||
> +                                   graph_parents->item->generation == GENERATION_NUMBER_INFINITY)
> +                                       graph_report("commit-graph has valid generation for %s but not its parent, %s",
> +                                                    oid_to_hex(&cur_oid),
> +                                                    oid_to_hex(&graph_parents->item->object.oid));
> +                               if (graph_parents->item->generation > max_generation)
> +                                       max_generation = graph_parents->item->generation;
> +                               graph_parents = graph_parents->next;
> +                       }
> +
> +                       if (max_generation == GENERATION_NUMBER_MAX)
> +                               max_generation--;

I'm not too familiar with these concepts. Is this a trick in preparation
for this:

> +
> +                       if (graph_commit->generation != max_generation + 1)

Any way that could give a false negative? (I'm not sure it would matter
much.) Maybe "if (!MAX && generation != max + 1)".

> +                               graph_report("commit-graph has incorrect generation for %s",
> +                                            oid_to_hex(&cur_oid));
> +               } else {
> +                       graph_parents = graph_commit->parents;
> +
> +                       while (graph_parents) {
> +                               if (graph_parents->item->generation)
> +                                       graph_report("commit-graph has generation ZERO for %s but not its parent, %s",
> +                                                    oid_to_hex(&cur_oid),
> +                                                    oid_to_hex(&graph_parents->item->object.oid));
> +                               graph_parents = graph_parents->next;
> +                       }
> +               }
> +       }
> +
>         return verify_commit_graph_error;
>  }

At this point, I should admit that I went through the above thinking
"right, makes sense, ok, sure". I was not really going "hmm, I wonder
..." This looks like the real meat of "verify", and I'll try to look it
over with a fresh pair of eyes tomorrow.

> diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh

> +       corrupt_data $objdir/info/commit-graph 1134 "\01" &&

> +       corrupt_data $objdir/info/commit-graph 1312 "\01" &&

> +       corrupt_data $objdir/info/commit-graph 1332 "\01" &&

> +       corrupt_data $objdir/info/commit-graph 1712 "\01" &&

> +       corrupt_data $objdir/info/commit-graph 1340 "\01" &&
> +       corrupt_data $objdir/info/commit-graph 1344 "\01" &&

Could you document these numbers somehow? (Maybe even calculate them
from constant inputs, although that might be a form of premature
optimization.) When some poor soul has to derive the corresponding
numbers for a commit-graph with NewHash, they will thank you.

Martin
