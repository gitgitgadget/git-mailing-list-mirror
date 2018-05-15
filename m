Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9F2C1F406
	for <e@80x24.org>; Tue, 15 May 2018 21:12:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752570AbeEOVM3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 May 2018 17:12:29 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:42174 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752389AbeEOVM2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 May 2018 17:12:28 -0400
Received: by mail-pl0-f67.google.com with SMTP id u6-v6so759155pls.9
        for <git@vger.kernel.org>; Tue, 15 May 2018 14:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=niLh3qqZIlhlIu0Gs2BBbVA6w8n4hA2+x8C+ECfAoew=;
        b=fFhfjHSG9gMpbryTF8l6LC5BrEbUXVMqQ8JAMxn7IyCvQg7bBbzagy7xxTqkUgh1wR
         rAiDBwJw8S7LE2Bi3QcZ+KNuMamPdD0rW9EQDPNL5xk8FJe9RN5BLKrbUQIf3yMZPtbK
         qyEFK9FTHHFjhVYUblHZr6lfNJ4vix1uwMhtAFTTZQW6HNsIemNw/IeEyi2ewtjdMIBN
         Jn+EpfrhCGJk8HLCSWDoROa9Hyf4kDTrCN8s1+kt/75dyp5sRYWQ983Pu84nhpcMkmDE
         l/07CypJxwROVE7UtzYhfUMDvUG8W40y06A5p7NURmwDpQ42wSZcfBjPu8bVKEk9fQm5
         71LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=niLh3qqZIlhlIu0Gs2BBbVA6w8n4hA2+x8C+ECfAoew=;
        b=Y/JfHk9u2DvliURZcbxw9xFDERXY36w9vwwvJZnmxtOOfHqO65uBe8JeYI7+HtQmU4
         tsyQ1GyQUyOZoggsO19YyOqjDvvXJLYnw+FOYb8Wttl8nrEUWbWQlXR31cLwCvU04cHD
         zqXUoabfcCoGJJ20SKhZlQLBMwYIiRYdZ1pjjWlHwBGzen6CkKidHgoaiDP60SvSzjZr
         gjCH0cAD7jc9icMct+BL/zcKU2g7+V90of88xNOSeHm8pVN22+IQiVz9jsOj6D83v6K2
         dKgAFflY/MeIPTXtRIRj/RTDdn+pe7+4Ttx7phCGnhnaHhfpdek4HPYU9L5rU6QIVANd
         Zabw==
X-Gm-Message-State: ALKqPwf2eX1MAfKQhuvWBhofTKnJVHPm4sACEbvNAN80pFBIfGvV3CG2
        2JbmlPnTBZfvlu98gKQIvygTUz5rv9leFJWFC7cYqN+s
X-Google-Smtp-Source: AB8JxZqtXv/pdupsUfYhLx5isYU/Eh39+mzrdXvNe1zcPvs2CkbpwRVplRFxjXKKY9mK0b7/NtDHLPtpVElHQ7EKvTk=
X-Received: by 2002:a17:902:268:: with SMTP id 95-v6mr16190282plc.386.1526418748334;
 Tue, 15 May 2018 14:12:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.181.101 with HTTP; Tue, 15 May 2018 14:12:27 -0700 (PDT)
In-Reply-To: <20180511211504.79877-9-dstolee@microsoft.com>
References: <20180510173345.40577-1-dstolee@microsoft.com> <20180511211504.79877-1-dstolee@microsoft.com>
 <20180511211504.79877-9-dstolee@microsoft.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Tue, 15 May 2018 23:12:27 +0200
Message-ID: <CAN0heSrE39eXQ0A4tncmKvi36Q9yZmR9TuiDJdRW7F1Q4hHquQ@mail.gmail.com>
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

I finally sat down today and familiarized myself with the commit-graph
code a little. My biggest surprise was when I noticed that there is a
hash checksum at the end of the commit-graph-file. That in combination
with the tests where you flip some bytes...

It turns out, if my reading is right, that the hash value is written as
the commit-graph is generated, but that it is not verified as the
commit-graph is later read. I could not find any mention of your plans
here -- I understand why you would not want to verify the hash in
`load_commit_graph_one()`, at least not in every run. Anyway, this is
just an observation. Verifying the hash would affect the tests this
series adds. They might need to rewrite the hash or set some magic
environment variable. :-/ But that's for another day.

> +       for (i = 0; i < g->num_commits; i++) {
> +               struct commit *graph_commit, *odb_commit;
> +               struct commit_list *graph_parents, *odb_parents;
> +               int num_parents = 0;
> +               hashcpy(cur_oid.hash, g->chunk_oid_lookup + g->hash_len * i);

`num_commits` was derived as the commit-graph was loaded. It was derived
from offsets which were verified to be in the mmap-ed memory. So this
source address is guaranteed to be so, as well. Ok.

(Once brian's latest series hits master, this could use `oidread(...)`.)

> +               graph_commit = lookup_commit(&cur_oid);

Do we know this comes from the graph? Even with a more-or-less-messed-up
commit graph? See below.

> +               odb_commit = (struct commit *)create_object(cur_oid.hash, alloc_commit_node());
> +               if (parse_commit_internal(odb_commit, 0, 0)) {
> +                       graph_report("failed to parse %s from object database", oid_to_hex(&cur_oid));
> +                       continue;
> +               }
> +
> +               if (oidcmp(&get_commit_tree_in_graph_one(g, graph_commit)->object.oid,
> +                          get_commit_tree_oid(odb_commit)))

`get_commit_tree_in_graph_one()` will BUG rather than return NULL. So
this will not dereference NULL. Good. But might it hit the BUG? That is,
can we trust the commit coming out of `lookup_commit()` not to have
`graph_pos == COMMIT_NOT_FROM_GRAPH`?

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

(Extra blank line?)

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

Ok, ensure the lists are equally long and compare the entries.

> +
> +               if (graph_commit->generation) {

If the commit has a generation number (not an old commit graph)...

> +                       uint32_t max_generation = 0;
> +                       graph_parents = graph_commit->parents;
> +
> +                       while (graph_parents) {
> +                               if (graph_parents->item->generation == GENERATION_NUMBER_ZERO ||
> +                                   graph_parents->item->generation == GENERATION_NUMBER_INFINITY)
> +                                       graph_report("commit-graph has valid generation for %s but not its parent, %s",
> +                                                    oid_to_hex(&cur_oid),
> +                                                    oid_to_hex(&graph_parents->item->object.oid));

... then it's odd if a parent has no generation number or is not in the
graph file at all.

> +                               if (graph_parents->item->generation > max_generation)
> +                                       max_generation = graph_parents->item->generation;
> +                               graph_parents = graph_parents->next;
> +                       }
> +
> +                       if (max_generation == GENERATION_NUMBER_MAX)
> +                               max_generation--;
> +
> +                       if (graph_commit->generation != max_generation + 1)
> +                               graph_report("commit-graph has incorrect generation for %s",
> +                                            oid_to_hex(&cur_oid));

Ok. Thanks for considering adding a comment.

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

Right.

> +               }
> +       }
> +
>         return verify_commit_graph_error;
>  }

Nice. My question about `get_commit_tree_in_graph_one()` might be me
making things much harder than they are. I sort of suspect that your
usage will be quite obviously safe in retrospect.

Martin
