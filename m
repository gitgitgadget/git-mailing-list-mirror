Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC3171F42D
	for <e@80x24.org>; Wed, 30 May 2018 13:34:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752780AbeE3NeN (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 May 2018 09:34:13 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:43907 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751559AbeE3NeL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 May 2018 09:34:11 -0400
Received: by mail-wr0-f196.google.com with SMTP id d2-v6so14110239wrm.10
        for <git@vger.kernel.org>; Wed, 30 May 2018 06:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=bhnbeGIcMELvM0jqm6VEq+gzXQw7upJpFxhYVUdzeWA=;
        b=Lj7EORX80BiqOjhmNqJb2hsedsGUB66RXxddvOfRARTElZd4X3Wkco/BudNWCyqhqj
         J56B75YXFkxLe0eBVK4qzsiOyvjYVKRcHic6VUeKSKj26gm7OVYPD48pRfh/zha1uW4R
         rNbptGXpkup5M9FiXSmMq9qOTtLSrDaIKIZdQdCU6P1NdpwlakaMcfc4wBHd3bpy0BMk
         6YkGXvmk4EJny0N/krE7iyQRX9aoqUDYdgbKfxljQa21qwrbLHQwfuOjX0XiZ5ZKP0n7
         cA5c7pFlgM8vwU0HnYJbYbP3rsIM5BvKOo2JE6rAKcZ0TiCNKwXzddU+gDK0Ai6a1s17
         MWGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=bhnbeGIcMELvM0jqm6VEq+gzXQw7upJpFxhYVUdzeWA=;
        b=RKxjxq4EiKV0B62Nw5X1P0Cfgh9JnDLtagrD/SWNmQVjdlZmaQQlmDdE7HwRhqMFYB
         wmLSHhfdrg0baLWIAiMZNsUOKIM+EOKuI9Dhymy+6TkhNrfJ+Nniz7R3BIlFt9dCUVc3
         DBIiWch0ukkMtZ3vXCEEU2nrSnw9JuJO/i1lt2JrWIytTc7uJ4hV9UiAKIya26TVJGyf
         vI3MRPVtlrWn2Dc2C+/iMjp3UtZZMD6jhTEVDBhRjZbMS2hWJiQUhwFMEo17X4aXPPEq
         LY1iCoqPEhcRoin2bt1olU3tR3sceWYKaFkxr77ESUPj6erZKRC5WsnCS2cFgLXRBtRh
         W+Pg==
X-Gm-Message-State: ALKqPwcgTPpzqIsvGukDMPBDe8cZZWg2yEgtyttSIFwG0hUhXe6L9xrd
        nIXbTub/zmF+AROJUNNpUR4=
X-Google-Smtp-Source: ADUXVKKQJ//p+8Af7Z3k99hro3G7SbLMYLb3Ayh2lkzwYjIiKr8ZD4oHWIEiLov0nibuzbUTR8wKJA==
X-Received: by 2002:adf:9383:: with SMTP id 3-v6mr2091925wrp.220.1527687250562;
        Wed, 30 May 2018 06:34:10 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (ahg103.neoplus.adsl.tpnet.pl. [83.25.188.103])
        by smtp.gmail.com with ESMTPSA id r6-v6sm39405097wrg.73.2018.05.30.06.34.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 May 2018 06:34:08 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        "gitster\@pobox.com" <gitster@pobox.com>,
        "stolee\@gmail.com" <stolee@gmail.com>,
        "avarab\@gmail.com" <avarab@gmail.com>,
        "marten.agren\@gmail.com" <marten.agren@gmail.com>,
        "peff\@peff.net" <peff@peff.net>
Subject: Re: [PATCH v3 09/20] commit-graph: verify corrupt OID fanout and lookup
References: <20180511211504.79877-1-dstolee@microsoft.com>
        <20180524162504.158394-1-dstolee@microsoft.com>
        <20180524162504.158394-10-dstolee@microsoft.com>
Date:   Wed, 30 May 2018 15:34:06 +0200
In-Reply-To: <20180524162504.158394-10-dstolee@microsoft.com> (Derrick
        Stolee's message of "Thu, 24 May 2018 16:25:45 +0000")
Message-ID: <86in75w9m9.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <dstolee@microsoft.com> writes:

> In the commit-graph file, the OID fanout chunk provides an index into
> the OID lookup. The 'verify' subcommand should find incorrect values
> in the fanout.
>
> Similarly, the 'verify' subcommand should find out-of-order values in
> the OID lookup.

O.K., the OID Lookup chunk is checked together with OID Fanout chunk
because those two chunks are tightly connected: OID Fanout is fanout
into OID Lookup.

>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  commit-graph.c          | 36 ++++++++++++++++++++++++++++++++++++
>  t/t5318-commit-graph.sh | 22 ++++++++++++++++++++++
>  2 files changed, 58 insertions(+)
>
> diff --git a/commit-graph.c b/commit-graph.c
> index 06e3e4f9ba..cbd1aae514 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -855,6 +855,9 @@ static void graph_report(const char *fmt, ...)
>=20=20
>  int verify_commit_graph(struct commit_graph *g)
>  {
> +	uint32_t i, cur_fanout_pos =3D 0;
> +	struct object_id prev_oid, cur_oid;

Minor nitpick about the naming convention: why cur_*, and not curr_*?

> +
>  	if (!g) {
>  		graph_report("no commit-graph file loaded");
>  		return 1;
> @@ -869,5 +872,38 @@ int verify_commit_graph(struct commit_graph *g)
>  	if (!g->chunk_commit_data)
>  		graph_report("commit-graph is missing the Commit Data chunk");
>=20=20
> +	if (verify_commit_graph_error)
> +		return verify_commit_graph_error;
> +

Before checking that commits in OID Lookup are sorted, and that OID
Fanout correctly points into OID Lookup (thus also checking that OID
Lookup is sorted), it would be good to verify that sizes of those chunks
are correct.

Out of 4 standrd chunks, 1 of them (OIDF) has constant size, and 2 of
them have size given by number of commits and hash size
 - OID Fanout is (256 * 4 bytes)
 - OID Lookup is (N * H bytes),
   where N is number of commits, and H is hash size

The one that is more significant is if number of commits gets corrupted
upwards, and walking through OID Lookup would lead us out of bounds,
outside the file size.

IIRC we have checked that all chunks fit within file size, isn't it?

> +	for (i =3D 0; i < g->num_commits; i++) {
> +		hashcpy(cur_oid.hash, g->chunk_oid_lookup + g->hash_len * i);

Why do you use hashcpy() here, but oidcpy() below?

> +
> +		if (i && oidcmp(&prev_oid, &cur_oid) >=3D 0)

All right, OIDs needs to be sorted in ascending lexicographical order,
and the above condition checks that this constraint is fullfilled.=20

> +			graph_report("commit-graph has incorrect OID order: %s then %s",
> +				     oid_to_hex(&prev_oid),
> +				     oid_to_hex(&cur_oid));

Nice informative error message.

> +
> +		oidcpy(&prev_oid, &cur_oid);
> +
> +		while (cur_oid.hash[0] > cur_fanout_pos) {
> +			uint32_t fanout_value =3D get_be32(g->chunk_oid_fanout + cur_fanout_p=
os);
> +			if (i !=3D fanout_value)
> +				graph_report("commit-graph has incorrect fanout value: fanout[%d] =
=3D %u !=3D %u",
> +					     cur_fanout_pos, fanout_value, i);
> +
> +			cur_fanout_pos++;
> +		}

The k-th entry of fanout, F[k], stores the number of OIDs with first
byte at most k.

Let's examine it in detail on a simple example:

   fanout                     lookup
   ------                     ------
   0 : 0  ---------------> 0: 1xxxx....
   1 : 2  -----\           1: 1yyyy....
   2 : 2  ------\--------> 2: 3xxxx....
   3 : 3  ---------------> 3: 4xxxx....

We are checking that after most significant byte (first byte) changes,
then all fanout position up to the current first byte value (exclusive)
point to current position in OID Lookup chunk.

Seems all right; it would be nice to come up with rigorous proof that it
is all right.

> +	}
> +
> +	while (cur_fanout_pos < 256) {
> +		uint32_t fanout_value =3D get_be32(g->chunk_oid_fanout + cur_fanout_po=
s);
> +
> +		if (g->num_commits !=3D fanout_value)
> +			graph_report("commit-graph has incorrect fanout value: fanout[%d] =3D=
 %u !=3D %u",
> +				     cur_fanout_pos, fanout_value, i);
> +
> +		cur_fanout_pos++;
> +	}

All right, this checks that all remaining fanout entries, up and
including the 255-ith entry store the total number of commits, N.

> +
>  	return verify_commit_graph_error;
>  }
> diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
> index 4ef3fe3dc2..c050ef980b 100755
> --- a/t/t5318-commit-graph.sh
> +++ b/t/t5318-commit-graph.sh
> @@ -247,6 +247,7 @@ test_expect_success 'git commit-graph verify' '
>  	git commit-graph verify >output
>  '
>=20=20
> +HASH_LEN=3D20
>  GRAPH_BYTE_VERSION=3D4
>  GRAPH_BYTE_HASH=3D5
>  GRAPH_BYTE_CHUNK_COUNT=3D6
> @@ -258,6 +259,12 @@ GRAPH_BYTE_OID_LOOKUP_ID=3D`expr $GRAPH_CHUNK_LOOKUP=
_OFFSET + \
>  			      1 \* $GRAPH_CHUNK_LOOKUP_WIDTH`
>  GRAPH_BYTE_COMMIT_DATA_ID=3D`expr $GRAPH_CHUNK_LOOKUP_OFFSET + \
>  				2 \* $GRAPH_CHUNK_LOOKUP_WIDTH`
> +GRAPH_FANOUT_OFFSET=3D`expr $GRAPH_CHUNK_LOOKUP_OFFSET + \
> +			  $GRAPH_CHUNK_LOOKUP_WIDTH \* $GRAPH_CHUNK_LOOKUP_ROWS`
> +GRAPH_BYTE_FANOUT1=3D`expr $GRAPH_FANOUT_OFFSET + 4 \* 4`
> +GRAPH_BYTE_FANOUT2=3D`expr $GRAPH_FANOUT_OFFSET + 4 \* 255`
> +GRAPH_OID_LOOKUP_OFFSET=3D`expr $GRAPH_FANOUT_OFFSET + 4 \* 256`
> +GRAPH_BYTE_OID_LOOKUP_ORDER=3D`expr $GRAPH_OID_LOOKUP_OFFSET + $HASH_LEN=
 \* 8`

Something that I forgot to write about in previous patch.

POSIX shell includes $(( ... )) for arithmetic expansion, there is
nowadays no need to use $(expr ...), and even more no need to use
pre-POSIX `expr ...`.

TLDR: use $(( ... )), not `expr ... `.

>=20=20
>  # usage: corrupt_graph_and_verify <position> <data> <string>
>  # Manipulates the commit-graph file at the position
> @@ -312,4 +319,19 @@ test_expect_success 'detect missing commit data chun=
k' '
>  		"missing the Commit Data chunk"
>  '
>=20=20
> +test_expect_success 'detect incorrect fanout' '
> +	corrupt_graph_and_verify $GRAPH_BYTE_FANOUT1 "\01" \

How can you be sure that this value is incorrect?

> +		"fanout value"
> +'
> +
> +test_expect_success 'detect incorrect fanout' '
> +	corrupt_graph_and_verify $GRAPH_BYTE_FANOUT2 "\01" \
> +		"fanout value"
> +'

I would prefer if different tests had different description.  Those two
are both 'detect incorrect layout'.  What is the difference between them?

> +
> +test_expect_success 'detect incorrect OID order' '
> +	corrupt_graph_and_verify $GRAPH_BYTE_OID_LOOKUP_ORDER "\01" \
> +		"incorrect OID order"
> +'

How can you be sure that this value is incorrect, or rather that it
would be always incorrect?

> +
>  test_done

--=20
Jakub Nar=C4=99bski
