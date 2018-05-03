Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A2FDB2023D
	for <e@80x24.org>; Thu,  3 May 2018 11:18:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751101AbeECLSc (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 May 2018 07:18:32 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:40548 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751075AbeECLSa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 May 2018 07:18:30 -0400
Received: by mail-wm0-f50.google.com with SMTP id j5so29725713wme.5
        for <git@vger.kernel.org>; Thu, 03 May 2018 04:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=+Op4zoVvgqvp6+0o/eKP+BjMwGx5uuh/kjqD88pGkQQ=;
        b=J/e7goGdbWZNNJkusyY+2WRYIzCSvCxF02MOx7xFoqoUJ35NWAjAnjTIHLupoFW69S
         zyl5fNL4m/lsAZ5PhMjApcIcwdDSKmkdeKwHT4JNgStfXlnLaNiw0taHMaWhchAkOhgc
         MvimK/rV5tdsPnjNp6VxN28Ak87Ud8HM+umXvWkOa6+PZkC+qF4jQe1I0LHNvUhBiSk4
         /y4J0z6dIWx+XIanWM1le4ebRydjAdFQpbQuRv/Yv8jbfLYMWTuaMWmitSUWjpmZrqNi
         nPtPcZGVpCsZXAl+ngThDQ/h9Yv9BtwM6BF9kt2AhhqmZueseHHZ1Gi0X8sowsOpzluR
         /fpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=+Op4zoVvgqvp6+0o/eKP+BjMwGx5uuh/kjqD88pGkQQ=;
        b=ZnutdXPvpMF8Y6f2Ts7VxadhClabk9ZIkgOFHFk+WEhAeZ1wgh8mV/bNVa2c4cLZhk
         EaOyy8zltgMofKFDs1OBE9oBvirri/LKFt42Qux5gal+6e1QvKdaUL25XHMVTCzYXO0g
         g9WWgLep1jwuIAXj7b6XHDm8Z9W2w5umpUcQFn4gKSDZt+DdyGvYF3nX/Dx+upqxCOWU
         mxAIC7dq+Eergc+kHyBwwQA6APQ5flJXv7rOf89Bb8//IsS1xWtEQU+1OGe8Yay3lz7x
         JUtBb7uG7mwV2gX6ySTLMtgHC2e5kcncBEGefJCOg9LyILXjNEFCkybc9/jZBW0+ijFe
         3hlA==
X-Gm-Message-State: ALQs6tD23XjXcB21dW+w7lHUIlNHOvQI9aT8aVOBURVHDV46D/YMmWpf
        jqXcFlBCwJm4fKnCW3CFq4Y=
X-Google-Smtp-Source: AB8JxZrVfo0Tvpcw8VSbmYTl07FUs89OqM4E+/ymMzdIeMPcejEHqToRglu8sTgn32I/zntv8TOF+A==
X-Received: by 10.28.177.9 with SMTP id a9mr9386160wmf.18.1525346309203;
        Thu, 03 May 2018 04:18:29 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (egn45.neoplus.adsl.tpnet.pl. [83.21.77.45])
        by smtp.gmail.com with ESMTPSA id 12sm20652415wmn.27.2018.05.03.04.18.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 03 May 2018 04:18:27 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v5 00/11] Compute and consume generation numbers
References: <20180425143735.240183-1-dstolee@microsoft.com>
        <20180501124652.155781-1-dstolee@microsoft.com>
Date:   Thu, 03 May 2018 13:18:24 +0200
In-Reply-To: <20180501124652.155781-1-dstolee@microsoft.com> (Derrick Stolee's
        message of "Tue, 1 May 2018 12:47:03 +0000")
Message-ID: <86sh79yolb.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <dstolee@microsoft.com> writes:

> Most of the changes from v4 are cosmetic, but there is one new commit:
>
> 	commit: use generation number in remove_redundant()
>
> Other changes are non-functional, but do clarify things.

I wonder if out perf framework in t/perf could help here to show
performance gains for the whole series.  Though it may not include
operations that are most helped by this one.

For commit-graph feature if would be nice, if feasible, to see changes
in performance from before version, checking both state where feature is
enabled to see the gains, and state where feature is disabled to see if
there are no performance regressions.

>
> Inter-diff from v4:

O.K., now to commenting on inter-changes.

> diff --git a/Documentation/technical/commit-graph.txt b/Documentation/tec=
hnical/commit-graph.txt
> index d9f2713efa..e1a883eb46 100644
> --- a/Documentation/technical/commit-graph.txt
> +++ b/Documentation/technical/commit-graph.txt
> @@ -125,9 +125,10 @@ Future Work
>    walks aware of generation numbers to gain the performance benefits they
>    enable. This will mostly be accomplished by swapping a commit-date-ord=
ered
>    priority queue with one ordered by generation number. The following
> -  operation is an important candidate:
> +  operations are important candidates:
>
>      - 'log --topo-order'
> +    - 'tag --merged'
>
>  - Currently, parse_commit_gently() requires filling in the root tree
>    object for a commit. This passes through lookup_tree() and consequently

O.K., this is about discussion in "branch --contains / tag --merged
inconsistency" thread:

  https://public-inbox.org/git/87fu3g67ry.fsf@lant.ki.iif.hu/t/#u

> diff --git a/commit-graph.c b/commit-graph.c
> index aebd242def..a8c337dd77 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -248,6 +248,7 @@ static struct commit_list **insert_parent_or_die(stru=
ct commit_graph *g,
>  static void fill_commit_graph_info(struct commit *item, struct commit_gr=
aph *g, uint32_t pos)
>  {
>         const unsigned char *commit_data =3D g->chunk_commit_data + GRAPH=
_DATA_WIDTH * pos;
> +       item->graph_pos =3D pos;
>         item->generation =3D get_be32(commit_data + g->hash_len + 8) >> 2;
>  }
>

Minor bugfix.

> @@ -454,8 +455,7 @@ static void write_graph_chunk_data(struct hashfile *f=
, int hash_len,
>                 else
>                         packedDate[0] =3D 0;
>
> -               if ((*list)->generation !=3D GENERATION_NUMBER_INFINITY)
> -                       packedDate[0] |=3D htonl((*list)->generation << 2=
);
> +               packedDate[0] |=3D htonl((*list)->generation << 2);
>
>                 packedDate[1] =3D htonl((*list)->date);
>                 hashwrite(f, packedDate, 8);

Minor bugfix.

> @@ -589,18 +589,17 @@ static void close_reachable(struct packed_oid_list =
*oids)
>         }
>  }
>
> -static void compute_generation_numbers(struct commit** commits,
> -                                      int nr_commits)
> +static void compute_generation_numbers(struct packed_commit_list* commit=
s)
>  {
>         int i;
>         struct commit_list *list =3D NULL;
>
> -       for (i =3D 0; i < nr_commits; i++) {
> -               if (commits[i]->generation !=3D GENERATION_NUMBER_INFINIT=
Y &&
> -                   commits[i]->generation !=3D GENERATION_NUMBER_ZERO)
> +       for (i =3D 0; i < commits->nr; i++) {
> +               if (commits->list[i]->generation !=3D GENERATION_NUMBER_I=
NFINITY &&
> +                   commits->list[i]->generation !=3D GENERATION_NUMBER_Z=
ERO)
>                         continue;
>
> -               commit_list_insert(commits[i], &list);
> +               commit_list_insert(commits->list[i], &list);
>                 while (list) {
>                         struct commit *current =3D list->item;
>                         struct commit_list *parent;

Refactoring: signature change from pair of struct commit** + int to
struct packed_commit_list*.

I think that it makes code a bit uglier for no gain, but that is just my
personal opinion; it is a matter of taste.

> @@ -621,10 +620,10 @@ static void compute_generation_numbers(struct commi=
t** commits,
>                         if (all_parents_computed) {
>                                 current->generation =3D max_generation + =
1;
>                                 pop_commit(&list);
> -                       }
>
> -                       if (current->generation > GENERATION_NUMBER_MAX)
> -                               current->generation =3D GENERATION_NUMBER=
_MAX;
> +                               if (current->generation > GENERATION_NUMB=
ER_MAX)
> +                                       current->generation =3D GENERATIO=
N_NUMBER_MAX;
> +                       }
>                 }
>         }
>  }

Bugfix (though it didn't result in wrong information writen out, just in
inconsistent state in the middle of computation).

> @@ -752,7 +751,7 @@ void write_commit_graph(const char *obj_dir,
>         if (commits.nr >=3D GRAPH_PARENT_MISSING)
>                 die(_("too many commits to write graph"));
>
> -       compute_generation_numbers(commits.list, commits.nr);
> +       compute_generation_numbers(&commits);
>
>         graph_name =3D get_commit_graph_filename(obj_dir);
>         fd =3D hold_lock_file_for_update(&lk, graph_name, 0);

The other side of signature change.

> diff --git a/commit.c b/commit.c
> index e2e16ea1a7..5064db4e61 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -835,7 +835,9 @@ static struct commit_list *paint_down_to_common(struc=
t commit *one, int n,
>                 int flags;
>
>                 if (commit->generation > last_gen)
> -                       BUG("bad generation skip");
> +                       BUG("bad generation skip %8x > %8x at %s",
> +                           commit->generation, last_gen,
> +                           oid_to_hex(&commit->object.oid));
>                 last_gen =3D commit->generation;
>
>                 if (commit->generation < min_generation)

More detailed BUG() message, always nice to have.

> @@ -947,6 +949,7 @@ static int remove_redundant(struct commit **array, in=
t cnt)
>                 parse_commit(array[i]);
>         for (i =3D 0; i < cnt; i++) {
>                 struct commit_list *common;
> +               uint32_t min_generation =3D GENERATION_NUMBER_INFINITY;
>
>                 if (redundant[i])
>                         continue;
> @@ -955,8 +958,12 @@ static int remove_redundant(struct commit **array, i=
nt cnt)
>                                 continue;
>                         filled_index[filled] =3D j;
>                         work[filled++] =3D array[j];
> +
> +                       if (array[j]->generation < min_generation)
> +                               min_generation =3D array[j]->generation;
>                 }
> -               common =3D paint_down_to_common(array[i], filled, work, 0=
);
> +               common =3D paint_down_to_common(array[i], filled, work,
> +                                             min_generation);
>                 if (array[i]->object.flags & PARENT2)
>                         redundant[i] =3D 1;
>                 for (j =3D 0; j < filled; j++)

New commit in series.  Change looks quite short, gives measurable
performance gains (in appropriate case).

> @@ -1073,7 +1080,7 @@ int in_merge_bases_many(struct commit *commit, int =
nr_reference, struct commit *
>         for (i =3D 0; i < nr_reference; i++) {
>                 if (parse_commit(reference[i]))
>                         return ret;
> -               if (min_generation > reference[i]->generation)
> +               if (reference[i]->generation < min_generation)
>                         min_generation =3D reference[i]->generation;
>         }
>
>

Style change.

> -- >8 --
>
> Derrick Stolee (11):
>   ref-filter: fix outdated comment on in_commit_list
>   commit: add generation number to struct commmit
>   commit-graph: compute generation numbers
>   commit: use generations in paint_down_to_common()
>   commit-graph: always load commit-graph information
>   ref-filter: use generation number for --contains
>   commit: use generation numbers for in_merge_bases()
>   commit: add short-circuit to paint_down_to_common()
>   commit: use generation number in remove_redundant()
>   merge: check config before loading commits
>   commit-graph.txt: update design document

It looks like the series is maturing nicely.

Best,
--=20
Jakub Nar=C4=99bski
