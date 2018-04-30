Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E01D215F4
	for <e@80x24.org>; Mon, 30 Apr 2018 23:32:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753594AbeD3Xcx (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Apr 2018 19:32:53 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:53493 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752614AbeD3Xcv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Apr 2018 19:32:51 -0400
Received: by mail-wm0-f66.google.com with SMTP id a67so8130594wmf.3
        for <git@vger.kernel.org>; Mon, 30 Apr 2018 16:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=3Kg7ox/AooWhVe/5enOtQXlU3or6LL9ZFx6Mj1U8Pyo=;
        b=SGcSj3nc2ZFNk2BUGNMjrhl+u7s+oiXm9jlx6RDLiclJHCVETB+Ce6pNqxA/EdqEMA
         31orYP+neBOZYrhhIAFeoyDNe4OWuM0Pt6I+yqHE0WvLKVzHUyXxTGhvDwphdi4YePLE
         lQolaiUI66W57qMg2PzHsbvbcM3Dj1JDHjeqS0d23Py75xB42CTvYb+/9xexWl8TpNHL
         2SxptDKnihX/HbEa4uIoe90XxAE//AHGkBg4SfhmJLMENRuPLoruvWBWIb7hmF701OBe
         YVkCeKOHVDdUhCv8tn9zI1eMncckLVTdzaqxsGdLrlEu/hdk4A1iz1qRodeU8QnltNS4
         YNOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=3Kg7ox/AooWhVe/5enOtQXlU3or6LL9ZFx6Mj1U8Pyo=;
        b=XPtg2wj7x+AsAfc24ZPuFxD3LDerc97sg4PdyM2NGxXwJXUNRhiTht6Xr1PutNxlWa
         RYPcarEZ+hZ2pJkiebt2k3OANUHvdv+xRePSsnBmgbyvY1SOMHpfvu0wuHjXFGHEjozK
         8sK0/Mhe+UXd44Hoeczsb3kGsMl/MyiAOTfCOxfy6s5JJ+tEyOgsDURoEQf1JCJuJcEd
         SkFsV3hdwh9uhI+LTmh046K7fGun5AgEZz0Ka6bjwrvvKJZ05iEDHAjQA5x15u/OnJfg
         8sOUeM3fCTDgqFMxdI3PXXTnhfdZrFeJQX2U5GJJlayWAuPlTrUL7hI2rCo5GgDvUOva
         vH1Q==
X-Gm-Message-State: ALQs6tBxuoNKJVg5Fsal74T2ywhSpIf/mb2fqDbwgS/ZBIoofgALHBAP
        0OkZuTf5FwxDot6VG21XborG6Exo
X-Google-Smtp-Source: AB8JxZoZCydNQTVcuTjhQ8nNikMItz/qTliHCmS7y5V21p7d4aVcKOPdv39U9IzNYuJk9i2lnzddWA==
X-Received: by 10.28.172.138 with SMTP id v132mr2528105wme.105.1525131170513;
        Mon, 30 Apr 2018 16:32:50 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (abqa10.neoplus.adsl.tpnet.pl. [83.8.68.10])
        by smtp.gmail.com with ESMTPSA id e7-v6sm8865920wrn.88.2018.04.30.16.32.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Apr 2018 16:32:49 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v4 10/10] commit-graph.txt: update design document
References: <20180417170001.138464-1-dstolee@microsoft.com>
        <20180425143735.240183-1-dstolee@microsoft.com>
        <20180425143735.240183-11-dstolee@microsoft.com>
Date:   Tue, 01 May 2018 01:32:46 +0200
In-Reply-To: <20180425143735.240183-11-dstolee@microsoft.com> (Derrick
        Stolee's message of "Wed, 25 Apr 2018 14:38:03 +0000")
Message-ID: <86d0ygfext.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <dstolee@microsoft.com> writes:

> We now calculate generation numbers in the commit-graph file and use
> them in paint_down_to_common().
>
> Expand the section on generation numbers to discuss how the three
> special generation numbers GENERATION_NUMBER_INFINITY, _ZERO, and
> _MAX interact with other generation numbers.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>

Looks good.

> ---
>  Documentation/technical/commit-graph.txt | 30 +++++++++++++++++++-----
>  1 file changed, 24 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/technical/commit-graph.txt b/Documentation/tec=
hnical/commit-graph.txt
> index 0550c6d0dc..d9f2713efa 100644
> --- a/Documentation/technical/commit-graph.txt
> +++ b/Documentation/technical/commit-graph.txt
> @@ -77,6 +77,29 @@ in the commit graph. We can treat these commits as hav=
ing "infinite"
>  generation number and walk until reaching commits with known generation
>  number.
>=20=20
> +We use the macro GENERATION_NUMBER_INFINITY =3D 0xFFFFFFFF to mark commi=
ts not
> +in the commit-graph file. If a commit-graph file was written by a version
> +of Git that did not compute generation numbers, then those commits will
> +have generation number represented by the macro GENERATION_NUMBER_ZERO =
=3D 0.
> +
> +Since the commit-graph file is closed under reachability, we can guarant=
ee
> +the following weaker condition on all commits:
> +
> +    If A and B are commits with generation numbers N amd M, respectively,
> +    and N < M, then A cannot reach B.
> +
> +Note how the strict inequality differs from the inequality when we have
> +fully-computed generation numbers. Using strict inequality may result in
> +walking a few extra commits,

The linux kernel commit graph has maximum of 513 commits sharing the
same generation number, but is is 5.43 commits sharing the same
generation number on average, with standard deviation 10.70; median is
even lower: it is 2, with 5.35 median absolute deviation (MAD).

So on average it would be a few extra commits.  Right.

>                               but the simplicity in dealing with commits
> +with generation number *_INFINITY or *_ZERO is valuable.

As I wrote before, handling those corner cases in more complicated, but
not that complicated.  We could simply use stronger condition if both
generation numbers are ordinary generation numbers, and weaker condition
when at least one generation number has one of those special values.

> +
> +We use the macro GENERATION_NUMBER_MAX =3D 0x3FFFFFFF to for commits who=
se
> +generation numbers are computed to be at least this value. We limit at
> +this value since it is the largest value that can be stored in the
> +commit-graph file using the 30 bits available to generation numbers. This
> +presents another case where a commit can have generation number equal to
> +that of a parent.

Ordinary generation numbers, where stronger condition holds, are those
between GENERATION_NUMBER_ZERO < gen(C) < GENERATION_NUMBER_MAX.

> +
>  Design Details
>  --------------
>=20=20
> @@ -98,17 +121,12 @@ Future Work
>  - The 'commit-graph' subcommand does not have a "verify" mode that is
>    necessary for integration with fsck.
>=20=20
> -- The file format includes room for precomputed generation numbers. These
> -  are not currently computed, so all generation numbers will be marked as
> -  0 (or "uncomputed"). A later patch will include this calculation.
> -

Good.

>  - After computing and storing generation numbers, we must make graph
>    walks aware of generation numbers to gain the performance benefits they
>    enable. This will mostly be accomplished by swapping a commit-date-ord=
ered
>    priority queue with one ordered by generation number. The following
> -  operations are important candidates:
> +  operation is an important candidate:
>=20=20
> -    - paint_down_to_common()
>      - 'log --topo-order'

Another possible candidates:

       - remove_redundant() - see comment in previous patch
       - still_interesting() - where Git uses date slop to stop walking
         too far

>=20=20
>  - Currently, parse_commit_gently() requires filling in the root tree

One important issue left is handling features that change view of
project history, and their interaction with commit-graph feature.

What would happen, if we turn on commit-graph feature, generate commit
graph file, and then:

  * use graft file or remove graft entries to cut history, or remove cut
    or join two [independent] histories.
  * use git-replace mechanims to do the same
  * in shallow clone, deepen or shorten the clone

What would happen if without re-generating commit-graph file (assuming
tha Git wouldn't do it for us), we run some feature that makes use of
commit-graph data:

  - git branch --contains
  - git tag --contains
  - git rev-list A..B

Best,
--=20
Jakub Nar=C4=99bski
