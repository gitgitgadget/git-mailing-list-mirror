Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A4511F42D
	for <e@80x24.org>; Mon, 28 May 2018 17:14:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934263AbeE1RLy (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 May 2018 13:11:54 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:38436 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932206AbeE1RLx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 May 2018 13:11:53 -0400
Received: by mail-wm0-f66.google.com with SMTP id m129-v6so33675699wmb.3
        for <git@vger.kernel.org>; Mon, 28 May 2018 10:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:cancel-lock:date
         :in-reply-to:message-id:mime-version;
        bh=i/A/dp8UZP3CkCzb9yY/FjQ10nmJHXw3OvbDeHVz1NY=;
        b=HqGzyJHzaNYb39BEyloYxmbmveq4tzizyptcuMjgr9umMZhRJpRiLKdMnR/+5ORX3p
         BWP4RpLaumpm59WLz3QH3aHeA8FeC6mq8pMK7HmaFQEmzTmTfx4SexxEGb6t5m6zw942
         2D+UfmBtGUS3agiQZecJ2/u4dOo7Kf+0SJRU7c886Nr/74mkJRcxUIbybwaZfypDOWiP
         2xSwth6QhqB0eSElFfPSGqa8Cwm2C4uaIJzeQPsB7tCFMRv2Cms9vAZFFwfGSkCpJjH9
         nOWjkHTZkKSiaTbIf6FyRmZlLQ8i4Ndg67PnabLQ+vyrPqS/yN6IQLLaLDh2TQxUgZqp
         Ukfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :cancel-lock:date:in-reply-to:message-id:mime-version;
        bh=i/A/dp8UZP3CkCzb9yY/FjQ10nmJHXw3OvbDeHVz1NY=;
        b=J3ZoQpUmhKRjt4uEdkdHg6UV1iea/h1abeeUkHpfxI0PW5QxWm7+QreSjAtqVXsjrv
         CjomvhGUM/MQ22cpGNMkT/9JfH8oWwEh8e9G6crFAxfNaKDeATMuopTjFV0Bnvy8wnVW
         g2d9MGEJN4CEQCGuI5vPFV35mVO6xsa94hoGe4Gus2yxmvjDREXV6QBofljblisH8n1E
         G++mIdhDqXEOubq06I8zIFz2vMcoDQzUBmt7LfKGl1Oqh+NuGjjeCNiBpBtSvT5rr9Mt
         3L0jpEW6SyrfNonRiA3fm/ZsCI04+jnaZeuwdgTWYglOOaiSOzDMn9a1Xw/ZPmX7DVai
         IPkA==
X-Gm-Message-State: ALKqPwcu8mwxZaIqZRgzAdwmPuhpdNNnZWItYzyR1sfJwPzzsZRqlXpd
        URotN/se8sOG5NQiz6Cw9GGV1LGw
X-Google-Smtp-Source: ADUXVKLjXOiy9l109cugEggk19KKFS4/ETHPgZqKi7m7gInVz1hbHc2tUyNNVrHp8vrPDSoaKmiaJg==
X-Received: by 2002:a1c:9c2:: with SMTP id 185-v6mr9384710wmj.53.1527527512446;
        Mon, 28 May 2018 10:11:52 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (egb161.neoplus.adsl.tpnet.pl. [83.21.65.161])
        by smtp.gmail.com with ESMTPSA id s2-v6sm9816605wrn.75.2018.05.28.10.11.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 May 2018 10:11:51 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Martin =?utf-8?Q?=C3=85gren?= <marten.agren@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 08/20] commit-graph: verify required chunks are present
References: <20180511211504.79877-1-dstolee@microsoft.com>
        <20180524162504.158394-1-dstolee@microsoft.com>
        <20180524162504.158394-9-dstolee@microsoft.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
Cancel-Lock: sha1:P9v3HLNBaqYco9COGltVUopeAYI=
Date:   Mon, 28 May 2018 19:11:50 +0200
In-Reply-To: <20180524162504.158394-9-dstolee@microsoft.com> (Derrick Stolee's
        message of "Thu, 24 May 2018 16:25:42 +0000")
Message-ID: <867ennyaax.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <dstolee@microsoft.com> writes:

> The commit-graph file requires the following three chunks:
>
> * OID Fanout
> * OID Lookup
> * Commit Data
>
> If any of these are missing, then the 'verify' subcommand should
> report a failure. This includes the chunk IDs malformed or the
> chunk count is truncated.

Minor nit: it should IMVHO either be "or the chunk count truncated", or
"or when the chunk count is truncated".

>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  commit-graph.c          |  9 +++++++++
>  t/t5318-commit-graph.sh | 29 +++++++++++++++++++++++++++++
>  2 files changed, 38 insertions(+)
>
> diff --git a/commit-graph.c b/commit-graph.c
> index 55b41664ee..06e3e4f9ba 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -860,5 +860,14 @@ int verify_commit_graph(struct commit_graph *g)
>  		return 1;
>  	}
>  
> +	verify_commit_graph_error = 0;
> +

By the way, if chunk count is less than 3, then by pigeonhole principle
at least one required chunk is missing.

> +	if (!g->chunk_oid_fanout)
> +		graph_report("commit-graph is missing the OID Fanout chunk");
> +	if (!g->chunk_oid_lookup)
> +		graph_report("commit-graph is missing the OID Lookup chunk");
> +	if (!g->chunk_commit_data)
> +		graph_report("commit-graph is missing the Commit Data chunk");

Nice and simple.  Good.

> +
>  	return verify_commit_graph_error;
>  }
> diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
> index bd64481c7a..4ef3fe3dc2 100755
> --- a/t/t5318-commit-graph.sh
> +++ b/t/t5318-commit-graph.sh
> @@ -249,6 +249,15 @@ test_expect_success 'git commit-graph verify' '
>  
>  GRAPH_BYTE_VERSION=4
>  GRAPH_BYTE_HASH=5
> +GRAPH_BYTE_CHUNK_COUNT=6
> +GRAPH_CHUNK_LOOKUP_OFFSET=8
> +GRAPH_CHUNK_LOOKUP_WIDTH=12
> +GRAPH_CHUNK_LOOKUP_ROWS=5
> +GRAPH_BYTE_OID_FANOUT_ID=$GRAPH_CHUNK_LOOKUP_OFFSET
> +GRAPH_BYTE_OID_LOOKUP_ID=`expr $GRAPH_CHUNK_LOOKUP_OFFSET + \
> +			      1 \* $GRAPH_CHUNK_LOOKUP_WIDTH`
> +GRAPH_BYTE_COMMIT_DATA_ID=`expr $GRAPH_CHUNK_LOOKUP_OFFSET + \
> +				2 \* $GRAPH_CHUNK_LOOKUP_WIDTH`
>  
>  # usage: corrupt_graph_and_verify <position> <data> <string>
>  # Manipulates the commit-graph file at the position
> @@ -283,4 +292,24 @@ test_expect_success 'detect bad hash version' '
>  		"hash version"
>  '
>  
> +test_expect_success 'detect bad chunk count' '
> +	corrupt_graph_and_verify $GRAPH_BYTE_CHUNK_COUNT "\02" \
> +		"missing the Commit Data chunk"
> +'

As I wrote before, this test assumes that the last chunk (the one not
counted because of changed / corrupted chunk count) is the Commit Data
chunk.  This may be true for corrent implementation, but it is not
required by the format.

Better solution would be to check for "missing the .* chunk"; as I
understand you can pass the regexp to grep, not only strings.


Another thing would be to check if there are gaps in the file, or if the
whole file is being used.  Changing chunk count to a smaller number
would mean that chunks would not cover the rest of files.

By the way, would the following be detected:

  	corrupt_graph_and_verify $GRAPH_BYTE_CHUNK_COUNT "\05"

that is corrupting the chunk count to be larger than the number of
actual chunks?  Or is it left for later?

> +
> +test_expect_success 'detect missing OID fanout chunk' '
> +	corrupt_graph_and_verify $GRAPH_BYTE_OID_FANOUT_ID "\0" \

We could have used "X" or " " in place of "\0", but admittedly the
latter is a better check - it also checks if there are problems with
handling of NUL character ("\0") in chunk names.

> +		"missing the OID Fanout chunk"
> +'
> +
> +test_expect_success 'detect missing OID lookup chunk' '
> +	corrupt_graph_and_verify $GRAPH_BYTE_OID_LOOKUP_ID "\0" \
> +		"missing the OID Lookup chunk"
> +'
> +
> +test_expect_success 'detect missing commit data chunk' '
> +	corrupt_graph_and_verify $GRAPH_BYTE_COMMIT_DATA_ID "\0" \
> +		"missing the Commit Data chunk"
> +'

What happens if the terminating pseudo-chunk name "\0\0\0\0" gets
corrupted?  Would it be detected (or maybe it is handled by later patch
in the series)?

> +
>  test_done
