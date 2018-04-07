Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75DD91F404
	for <e@80x24.org>; Sat,  7 Apr 2018 22:37:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752291AbeDGWhU (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Apr 2018 18:37:20 -0400
Received: from mail-lf0-f42.google.com ([209.85.215.42]:39494 "EHLO
        mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752272AbeDGWhT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Apr 2018 18:37:19 -0400
Received: by mail-lf0-f42.google.com with SMTP id p142-v6so5101288lfd.6
        for <git@vger.kernel.org>; Sat, 07 Apr 2018 15:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=HMzFrCZnvTiIEbI8lSxWQAihnshmF6t4/mtZqv/ySCU=;
        b=Ir8J58A3mZt1frNBbGhLKQZpzaQKGWxpeOk0qMeVtrUyqydWuzTs1jc2ZzZAwrCOSU
         RhRUjX/nMb1EuCYLqZrQz2NUWuJ4xV9qsQwUPSK6NJrvB3v0lzM3CoEel9WXzOxo1BAJ
         vyW8Kr504fd6tsMdatoupAlQTb8mSDMDvV0J9PBoB7udvy2sKZKw0MdIm7POpp6cb1em
         wAErLPc857B35jqX+ZXTEZZpBJIRlYif56JX5q6NDOlb3XWtw+8w2F/7VkhuLtpW9qoP
         Emzcj6dhysqo2VYim3OAdxZHlwB/arWTYbX2x0SQSScYkdWdd3km/4engsEGjCD/wQzh
         5j8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=HMzFrCZnvTiIEbI8lSxWQAihnshmF6t4/mtZqv/ySCU=;
        b=cHLIfxvuraIS5/QdN1i4H46aPsl0zAOTU+AqH4M5HU52HZ59/GCTDTcapNbnIN9V82
         F0mxdwb3rzjwGjJ5CZP7BwnPIsD/mlXTmecdhDoWY/oEgS5dNAdbQDE+2EhU++M1eyWD
         d1qFxl8cYGqSAqvlo35lPyCMI4GpvfOGiS9rDizABKFBFw8AkZSzkZJTtXDvrZKsIbRv
         sPTMlVeCfp8OKtlhHTb3fShSRhv5QDWLbuX7tF4fuUmEi+MOA4e744sZ2aiDyLsrR1qY
         a5gzp5ilV0jhzGgM36kKzWOeHdMNiJmzlrVeH1SYzHfBwtfEQYAKSoEN1GBcJBuev1FI
         LQGQ==
X-Gm-Message-State: AElRT7Fjx6Je1WR9n5Meuy3RrdRMalIO7wGe74E0/uag265z4VK6d2M+
        bImJ7o5GlYWyceb2ol2m39c=
X-Google-Smtp-Source: AIpwx4/mAt0uQYwoHZ+lA3/IwNxR2jfUHmh95295imvvV9nqCKjzUs6wixpI+p+HQpjUDTrBf6FLfA==
X-Received: by 10.46.32.154 with SMTP id g26mr19587653lji.71.1523140637135;
        Sat, 07 Apr 2018 15:37:17 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (aga121.neoplus.adsl.tpnet.pl. [83.25.156.121])
        by smtp.gmail.com with ESMTPSA id p9-v6sm2722925lfh.93.2018.04.07.15.37.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 07 Apr 2018 15:37:16 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Szeder =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v4 00/13] Serialized Git Commit Graph
References: <4d1ee202-7d79-d73c-6e05-d0fc85db943c@gmail.com>
        <1519066406-81663-1-git-send-email-dstolee@microsoft.com>
        <867eptkeeq.fsf@gmail.com>
        <f5d8934e-afc2-39d4-b7d5-e5ba5e5021a1@gmail.com>
        <861sfxekeo.fsf@gmail.com>
        <d3060103-7fab-3b6c-e968-cb49f3f23acb@gmail.com>
Date:   Sun, 08 Apr 2018 00:37:12 +0200
In-Reply-To: <d3060103-7fab-3b6c-e968-cb49f3f23acb@gmail.com> (Derrick
        Stolee's message of "Mon, 2 Apr 2018 11:02:09 -0400")
Message-ID: <86po3aej8n.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> On 4/2/2018 10:46 AM, Jakub Narebski wrote:
>> Derrick Stolee <stolee@gmail.com> writes:
> [...]
>> I see the FELINE-index as a stronger form of generation numbers (called
>> also level of the vertex / node), in that it allows to negative-cut even
>> more, pruning paths that are known to be unreachable (or marking nodes
>> known to be unreachable in the "calculate difference" scenario).
>>
>> Also, FELINE-index uses two integer numbers (coordinates in 2d space);
>> one of those indices can be the topological numbering (topological
>> sorting order) of nodes in the commit graph.  That would help to answer
>> even more Git questions.
>
> This two-dimensional generation number is helpful for non-reachability
> queries, but is something that needs the "full" commit graph in order
> to define the value for a single commit (hence the O(N lg N)
> performance mentioned below). Generation numbers are effective while
> being easy to compute and immutable.

O(N log N) is the cost of sort algorithm, namely peforming topological
sorting of commits.  Which Git can currently do.

We can use the main idea behind FELINE index, namely weak dominance
drawing, while perhaps changing the detail.  The main idea is that if
you draw edges of DAG always to be in selected quadrant -- the default
is drawing them up and to the right, then paths would also always be in
the same quadrant; if target node is not in given quadrant with respect
to source node, then target node cannot be reached from source node.

For fast answering of reachability queries it is important to have
minimal number of false positives (falsely implied paths), that is
situation where FELINE index does imply that there could be a path, but
in fact target is not reachable from the source.  The authors propose a
heuristics: use positions in [some] topological order for X coordinates
of FELINE index, and generate new optimal locally topological sorting to
use for Y coordinates.


Generation numbers (which can be used together with FELINE index, and
what paper does use -- calling them Level Filter) have the advantage of
being able to be calculated incrementally. I think this is what you
wanted to say.

I think it would be possible to calculate FELINE index incrementally,
too.  If Git's topological order is stable, at least for X coordinates
of FELINE index it would be easy.


I have started experimenting with this approach in Jupyter Notebook,
available on Google Colaboratory (you can examine it, run it and edit it
from web browser -- the default is to use remote runtime on Google
cloud).  Currently I am at the stage of reproducing the theoretical
parts of the FELINE paper.

  https://colab.research.google.com/drive/1V-U7_slu5Z3s5iEEMFKhLXtaxSu5xyzg
  https://drive.google.com/file/d/1V-U7_slu5Z3s5iEEMFKhLXtaxSu5xyzg/view?us=
p=3Dsharing

> I wonder if FELINE was compared directly to a one-dimensional index (I
> apologize that I have not read the paper in detail, so I don't
> understand the indexes they compare against).

They have compared FELINE using real graphs (like ArXiv, Pubmed,
CiteseerX, Uniprot150m) and synthetic DAG against:
 - GRAIL (Graph Reachability Indexing via RAndomized Interval Labeling)
 - FERRARI (Flexible and Efficient Reachability Range Assignment for
   gRapth Indexing), with interval set compression to approximate ones
 - Nuutila's INTERVAL, which extracts complete transitive closure of
   the graph and stores it using PWAH bit-vector compression
 - TF-Label (Topological Folding LABELling)

>                                                It also appears the
> graphs they use for their tests are not commit graphs, which have a
> different shape than many of the digraphs studies by that work.

I plan to check how FELINE index works for commit graphs in
above-mentioned Jupyter Notebook.

> This is all to say: I would love to see an interesting study in this
> direction, specifically comparing this series' definition of
> generation numbers to the 2-dimensional system in FELINE, and on a
> large sample of commit graphs available in open-source data sets
> (Linux kernel, Git, etc.) and possibly on interesting closed-source
> data sets.

I wonder if there are more recent works, with even faster solutions.

>>> The case for "Can X reach Y?" is mostly for commands like 'git branch
>>> --contains', when 'git fetch' checks for forced-updates of branches,
>>> or when the server decides enough negotiation has occurred during a
>>> 'git fetch'. While these may be worth investigating, they also benefit
>>> greatly from the accelerated graph walk introduced in the current
>>> format.
>>>
>>> I would be happy to review any effort to extend the commit-graph
>>> format to include such indexes, as long as the performance benefits
>>> outweigh the complexity to create them.
>>>
>>> [2] http://citeseerx.ist.psu.edu/viewdoc/download?doi=3D10.1.1.719.8396=
&rep=3Drep1&type=3Dpdf

I wonder if next low-hanging branch would be to store topological
ordering of commits.  It could be done, I think, with two chunks (or two
parts of one chunk): first to store position in topological order for
each commit (entries sorted by hash), second to store list of commits in
topological order (entries sorted by topological sort).

>>
>> The complexity of calculating FELINE index is O(|V| log(|V|) + |E|), the
>> storage complexity is 2*|V|.
>>
>
> This would be very easy to add as an optional chunk, since it can use
> one row per commit.

Right.

--=20
Jakub Nar=C4=99bski
