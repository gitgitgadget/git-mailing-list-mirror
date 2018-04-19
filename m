Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BAB851F404
	for <e@80x24.org>; Thu, 19 Apr 2018 15:58:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753562AbeDSP6j (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Apr 2018 11:58:39 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:42501 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753251AbeDSP6i (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Apr 2018 11:58:38 -0400
Received: by mail-wr0-f195.google.com with SMTP id s18-v6so15413271wrg.9
        for <git@vger.kernel.org>; Thu, 19 Apr 2018 08:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=TTQNFwv26bJy7miB8Grf2EPgAKiu1LqH3QYYZ0OX0GA=;
        b=ddIgsylpb15aNpB2EeYfW9skTKGUA9pqCqCzxijrrF3CZPv1ScovbmvX9Czn8Hs7A/
         hRnzjIB2twCX5IAB+zG5WbaKuwlNu4tv1nasOdINY9hRGF5MaTWqkjVoeGNh0m41i/J/
         koldU3CMox+Y3x/CQRwqijpUywkQSwwJd8z2yaKSqagzjOyCYKCEjA7amOYrB5fWs5U3
         i/Rr02xsF7ZWqiKpPJR+GGPJ8GMspMcfi56i/9i9SsQFMlS+RiwYeGJzCKMAdiOdXgNe
         Scs1HBJ95bhXgU5N+TL8iQQrWOHs2UDbm1grpCdJIB2NgTYCfdIXjwjxcCwhlKwzkr4F
         UG7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=TTQNFwv26bJy7miB8Grf2EPgAKiu1LqH3QYYZ0OX0GA=;
        b=NNpswIstOp+WTFM7zrR4yRb8iByL2C7pQyHChP3zFI5AB0Ys0qVlb8Qp1nsYKF3hvv
         UM1PrEZ3ClD9DG/i5YDGy1w1CbYT/PBgHd6nv9le+ZNIV+EzxX4GvIRka8SnraOclu3p
         9JOB+B2Vhj6WEGdxg2c0cmD3BxunD4ohSZWFwUePJi7/ZM9gGI6eEEYm9a1/E1lfPwQ/
         YrxIFgDznJuDR8v3ioEvkvHi2cYummS9MdmPFpnFJYTNktzIqGTawXE4pUpkCmTtxR3N
         at6RlXxqq4bchYdAAznF9PbOk9vHrZoHIFgyyuAlwi46hTE6QoJqG5QI5YzGRl9qCmW1
         Vquw==
X-Gm-Message-State: ALQs6tAMglEyEprfHmC5VdrK8jn+D3laUktm8yKdCBgCnpM8X+zqAxDO
        8h4a4wAeEq4/EzmDFBrZvzs=
X-Google-Smtp-Source: AIpwx4/Njj1GJUQXObMYPKXEu0rzh5kek3aVmIPcte0Bu+nEQV1USSOklFphB4w+/YLvtThqtbCfaw==
X-Received: by 2002:adf:a315:: with SMTP id c21-v6mr5534582wrb.195.1524153516805;
        Thu, 19 Apr 2018 08:58:36 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (egc153.neoplus.adsl.tpnet.pl. [83.21.66.153])
        by smtp.gmail.com with ESMTPSA id p25sm3702088wmi.14.2018.04.19.08.58.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Apr 2018 08:58:35 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [RFC PATCH 03/12] commit-graph: check file header information
References: <20180417181028.198397-1-dstolee@microsoft.com>
        <20180417181028.198397-4-dstolee@microsoft.com>
Date:   Thu, 19 Apr 2018 17:58:34 +0200
In-Reply-To: <20180417181028.198397-4-dstolee@microsoft.com> (Derrick Stolee's
        message of "Tue, 17 Apr 2018 18:10:39 +0000")
Message-ID: <86fu3rfas5.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <dstolee@microsoft.com> writes:

> During a run of 'git commit-graph check', list the issues with the
> header information in the commit-graph file. Some of this information
> is inferred from the loaded 'struct commit_graph'.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  commit-graph.c | 29 ++++++++++++++++++++++++++++-
>  1 file changed, 28 insertions(+), 1 deletion(-)
>
> diff --git a/commit-graph.c b/commit-graph.c
> index cd0634bba0..c5e5a0f860 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -820,7 +820,34 @@ void write_commit_graph(const char *obj_dir,
>  	oids.nr = 0;
>  }
>  
> +static int check_commit_graph_error;
> +#define graph_report(...) { check_commit_graph_error = 1; printf(__VA_ARGS__); }

Shouldn't 'do { ... } while(0);' trick be used here, like e.g. for
trace_performance macro?

> +
>  int check_commit_graph(struct commit_graph *g)
>  {
> -	return !g;
> +	if (!g) {
> +		graph_report(_("no commit-graph file loaded"));
> +		return 1;
> +	}
> +
> +	check_commit_graph_error = 0;
> +

The load_commit_graph_one() function does its own checks, some of whose
are present below, and some of whose are missing.

If it is used, then why duplicate tests - you would not get here as you
would die earlier.

If it is not used, then some tests are missing.

> +	if (get_be32(g->data) != GRAPH_SIGNATURE)
> +		graph_report(_("commit-graph file has incorrect header"));

The load_commit_graph_one() shows more detailed information:

                     "graph signature %X does not match signature %X",
		      graph_signature, GRAPH_SIGNATURE)

Also, load_commit_graph_one() checks that the file is not too short, and
we actually can access whole header.

> +
> +	if (*(g->data + 4) != 1)
> +		graph_report(_("commit-graph file version is not 1"));

Again:

                     "graph version %X does not match version %X",
		      graph_version, GRAPH_VERSION

Also, here we hardcode the commit-graph file version to 1.

Accidentally, don't we offer backward compatibility, in that if git can
read commit-graph file version 2, it can also read commit-graph file
version 1?

> +	if (*(g->data + 5) != GRAPH_OID_VERSION)
> +		graph_report(_("commit-graph OID version is not 1 (SHA1)"));

In one part we use symbolic constant, on the other hardcoded values.  If
GRAPH_OID_VERSION changes, what then?

Also:

                     "hash version %X does not match version %X",
		      hash_version, GRAPH_OID_VERSION

> +
> +	if (!g->chunk_oid_fanout)
> +		graph_report(_("commit-graph is missing the OID Fanout chunk"));
> +	if (!g->chunk_oid_lookup)
> +		graph_report(_("commit-graph is missing the OID Lookup chunk"));
> +	if (!g->chunk_commit_data)
> +		graph_report(_("commit-graph is missing the Commit Data chunk"));

All right.

> +	if (g->hash_len != GRAPH_OID_LEN)
> +		graph_report(_("commit-graph has incorrect hash length: %d"), g->hash_len);

We could be more detailed in error report: what hash length should be,
then?

> +
> +	return check_commit_graph_error;
>  }

No tests of malformed commit-graph file?
