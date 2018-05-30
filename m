Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC7051F42D
	for <e@80x24.org>; Wed, 30 May 2018 22:25:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932503AbeE3WZD (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 May 2018 18:25:03 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:39833 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932392AbeE3WZC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 May 2018 18:25:02 -0400
Received: by mail-wm0-f66.google.com with SMTP id f8-v6so50642631wmc.4
        for <git@vger.kernel.org>; Wed, 30 May 2018 15:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=6li+zP+O2isaWR4c4OA5eGr92CrL1YD3Fs+eyiddXW4=;
        b=cEY+bE+0Pp265k+co57SK4ekmRkk7d6dfs2IXkaFoC/NY8SFrYMPsYEx/kyhYCnqG4
         luOafbJIynOKyICOb9zL68TLV+MgMWDBSS5aoQQUrDCKIL7+DE3v/cRfEsi9Mi5H359S
         K6nJt0Yhmss+qL4m0prymmr0sEcBSUFkYEY+ch0hnLBG1fFY5cF3+yN2PXUo83udsuUq
         KA0xEQb5bVVh4xk7OjpXVocMv/m/yKMsEnkNIHYQtPbuTGVpgFu9nO2Lp4X05uvkvO9c
         n0IKlBZCbVnH13UnpNufw9i3NtwEA5f0EOawSiQJUNU8qvsSR6/j4QMr0pf463EI1aT3
         Y45Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=6li+zP+O2isaWR4c4OA5eGr92CrL1YD3Fs+eyiddXW4=;
        b=OA/bzxj+MpXyvlR59Li3NfLze7HJnezt2KP0AE6fCPmLbWxcqD+5CcUoJbYCUgPs5R
         aW8wVLFWIEqlgu6GhPM5RaeNgqaiMaoVEM4V6jmYVUKdbQYs2MzbnArOurYtVL0M/QhU
         89dXu9L6G2CxRGYI1ccvgw+bcG7ZkKML08sZ7ZT3TcFAA5M5N4Cs54nri+C4Lkl2g9zs
         x80vrWdKizmA4gVxdDaNf0K7eXL+SkDCjPwqpDXC3lgx5KXcbbrm4UJTCFma1M/AXWWY
         i/FwdrzDGiYQEJp/YgJtOhRzy++LqFL0Mo6WR1DOuyL12vrJqrcNAxdkjZkIOGS2npAR
         IZZA==
X-Gm-Message-State: ALKqPwd6aEtfM0tKuivoa2LRBNP10vn0gd+IuTDSDkmHGx1Po2ysgzNk
        lPcqrc2K9RaCyk4Kprgbdj4=
X-Google-Smtp-Source: ADUXVKJeRxHmFKmkGVKAYqzcONnPP9XFIDmU71H7eZ76wMn24g09Ujo3FZjwG06KmsNu8dPAPsv2JA==
X-Received: by 2002:a1c:a104:: with SMTP id k4-v6mr2557101wme.106.1527719101239;
        Wed, 30 May 2018 15:25:01 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (ahg103.neoplus.adsl.tpnet.pl. [83.25.188.103])
        by smtp.gmail.com with ESMTPSA id r3-v6sm16131532wrj.78.2018.05.30.15.24.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 May 2018 15:24:59 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        "gitster\@pobox.com" <gitster@pobox.com>,
        "stolee\@gmail.com" <stolee@gmail.com>,
        "avarab\@gmail.com" <avarab@gmail.com>,
        "marten.agren\@gmail.com" <marten.agren@gmail.com>,
        "peff\@peff.net" <peff@peff.net>
Subject: Re: [PATCH v3 11/20] commit-graph: verify root tree OIDs
References: <20180511211504.79877-1-dstolee@microsoft.com>
        <20180524162504.158394-1-dstolee@microsoft.com>
        <20180524162504.158394-12-dstolee@microsoft.com>
Date:   Thu, 31 May 2018 00:24:58 +0200
In-Reply-To: <20180524162504.158394-12-dstolee@microsoft.com> (Derrick
        Stolee's message of "Thu, 24 May 2018 16:25:49 +0000")
Message-ID: <86zi0gvl1h.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <dstolee@microsoft.com> writes:

> The 'verify' subcommand must compare the commit content parsed from the
> commit-graph and compare it against the content in the object database.

You have "compare" twice in the above sentence.

> Use lookup_commit() and parse_commit_in_graph_one() to parse the commits
> from the graph and compare against a commit that is loaded separately
> and parsed directly from the object database.

All right, that looks like a nice extension of what was done in previous
patch.  We want to check that cache (serialized commit graph) matches
reality (object database).

>
> Add checks for the root tree OID.

All right; isn't it that now we check almost all information from
commit-graph that hs match in object database (with exception of commit
parents, I think).

>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  commit-graph.c          | 17 ++++++++++++++++-
>  t/t5318-commit-graph.sh |  7 +++++++
>  2 files changed, 23 insertions(+), 1 deletion(-)
>
> diff --git a/commit-graph.c b/commit-graph.c
> index 0420ebcd87..19ea369fc6 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -880,6 +880,8 @@ int verify_commit_graph(struct commit_graph *g)
>  		return verify_commit_graph_error;

NOTE: we will be checking Commit Data chunk; I think it would be good
idea to verify that size of Commit Data chunk matches (N * (H + 16) bytes)
that format gives us, so that we don't accidentally red outside of
memory if something got screwed up (like number of commits being wrong,
or file truncated).

>=20=20
>  	for (i =3D 0; i < g->num_commits; i++) {
> +		struct commit *graph_commit;
> +
>  		hashcpy(cur_oid.hash, g->chunk_oid_lookup + g->hash_len * i);
>=20=20
>  		if (i && oidcmp(&prev_oid, &cur_oid) >=3D 0)
> @@ -897,6 +899,11 @@ int verify_commit_graph(struct commit_graph *g)
>=20=20
>  			cur_fanout_pos++;
>  		}
> +
> +		graph_commit =3D lookup_commit(&cur_oid);

So now I see why we add all commits to memory (to hash structure).

> +		if (!parse_commit_in_graph_one(g, graph_commit))
> +			graph_report("failed to parse %s from commit-graph",
> +				     oid_to_hex(&cur_oid));

All right, this verifies that commit in OID Lookup chunk has parse-able
data in Commit Data chunk, isn't it?

>  	}
>=20=20
>  	while (cur_fanout_pos < 256) {
> @@ -913,16 +920,24 @@ int verify_commit_graph(struct commit_graph *g)
>  		return verify_commit_graph_error;
>=20=20
>  	for (i =3D 0; i < g->num_commits; i++) {
> -		struct commit *odb_commit;
> +		struct commit *graph_commit, *odb_commit;
>=20=20
>  		hashcpy(cur_oid.hash, g->chunk_oid_lookup + g->hash_len * i);
>=20=20
> +		graph_commit =3D lookup_commit(&cur_oid);
>  		odb_commit =3D (struct commit *)create_object(cur_oid.hash, alloc_comm=
it_node());

All right, so we have commit data from graph, and commit data from the
object database.

>  		if (parse_commit_internal(odb_commit, 0, 0)) {
>  			graph_report("failed to parse %s from object database",
>  				     oid_to_hex(&cur_oid));
>  			continue;
>  		}
> +
> +		if (oidcmp(&get_commit_tree_in_graph_one(g, graph_commit)->object.oid,
> +			   get_commit_tree_oid(odb_commit)))
> +			graph_report("root tree OID for commit %s in commit-graph is %s !=3D =
%s",
> +				     oid_to_hex(&cur_oid),
> +				     oid_to_hex(get_commit_tree_oid(graph_commit)),
> +				     oid_to_hex(get_commit_tree_oid(odb_commit)));

Maybe explicitly say that it doesn't match the value from the object
database; OTOH this may be too verbose.

>  	}
>=20=20
>  	return verify_commit_graph_error;
> diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
> index 996a016239..21cc8e82f3 100755
> --- a/t/t5318-commit-graph.sh
> +++ b/t/t5318-commit-graph.sh
> @@ -267,6 +267,8 @@ GRAPH_BYTE_FANOUT2=3D`expr $GRAPH_FANOUT_OFFSET + 4 \=
* 255`
>  GRAPH_OID_LOOKUP_OFFSET=3D`expr $GRAPH_FANOUT_OFFSET + 4 \* 256`
>  GRAPH_BYTE_OID_LOOKUP_ORDER=3D`expr $GRAPH_OID_LOOKUP_OFFSET + $HASH_LEN=
 \* 8`
>  GRAPH_BYTE_OID_LOOKUP_MISSING=3D`expr $GRAPH_OID_LOOKUP_OFFSET + $HASH_L=
EN \* 4 + 10`
> +GRAPH_COMMIT_DATA_OFFSET=3D`expr $GRAPH_OID_LOOKUP_OFFSET + $HASH_LEN \*=
 $NUM_COMMITS`
> +GRAPH_BYTE_COMMIT_TREE=3D$GRAPH_COMMIT_DATA_OFFSET

All right, so the first is entry into record in Commit Data chunk, and
the latter points into tree entry in this record -- which entry is first
field:

  Commit Data (ID: {'C', 'G', 'E', 'T' }) (N * (H + 16) bytes)
    * The first H bytes are for the OID of the root tree.

>=20=20
>  # usage: corrupt_graph_and_verify <position> <data> <string>
>  # Manipulates the commit-graph file at the position
> @@ -341,4 +343,9 @@ test_expect_success 'detect OID not in object databas=
e' '
>  		"from object database"
>  '
>=20=20
> +test_expect_success 'detect incorrect tree OID' '
> +	corrupt_graph_and_verify $GRAPH_BYTE_COMMIT_TREE "\01" \
> +		"root tree OID for commit"
> +'

All right.

I wonder if we can create a test for first check added (that Commit
Graph data parses correctly), that is the one with the following error
message:

  "failed to parse <OID> from commit-graph file".

> +
>  test_done

Regards,
--=20
Jakub Nar=C4=99bski
