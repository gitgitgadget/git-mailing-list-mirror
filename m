Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A09791F42D
	for <e@80x24.org>; Fri,  1 Jun 2018 23:21:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751209AbeFAXVW (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Jun 2018 19:21:22 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33302 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750991AbeFAXVV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jun 2018 19:21:21 -0400
Received: by mail-wr0-f193.google.com with SMTP id k16-v6so10471942wro.0
        for <git@vger.kernel.org>; Fri, 01 Jun 2018 16:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=vO2m4n3raFBiLtVrSR6YRP8kl0gP+knxjNj61S2zJ7c=;
        b=U2y+WtmDbn9o7Nf35U3QsA4CCwVIeHgsaVa7IqSOtR1sdTCipWvZikGv60G5j3NuRB
         zDpRms15z6ddDEKZRsgavsvCmrGMb0+yKyEMTViemT1+lvhXSdAfBYiM4hY2nNDMAwZQ
         qlbGPKNCl/EmltKjKavILDxXu5Qd07CXQ/ZmUeHk9FI96ZWsjeMTqEjnfxVJ0B74S4FA
         UWRshpa0IGxPKSzcHkCIEZHzbKL+cO/OAuXht1bx/7OBKTm0RKFHIxRu9jgh1ydIW78k
         uZ+7IlzT9srHDICvCXclaIoC0umRclELcE0a3O8+r/37eyUA1SJg1PefXNqerMCgmcOV
         YxJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=vO2m4n3raFBiLtVrSR6YRP8kl0gP+knxjNj61S2zJ7c=;
        b=Q6JyvH24Dg8V2IxYyPfmsEvZYG8g3ZmKTX7M2jTFRpPNoPO36ik59N6zX81OsjExgk
         Nlcia8cRiaiSWMX57ldA4Zb1UagexSmTJ4Cx/aMhc/24Sh51VTl9GEhKWHKnOVUw2zHl
         1n5zGcjSqhWAOZ3PCjQxMK2wUrmxOtHylkG5jvyPPvAbuUmlaKBYibU7d4Jam6wID2wl
         Eq6KVHMDV4KNyJ/1hxrUMkoi9dZveUahrkeLRv3zegIf7a+hMWBEg5dK6E2Y+aeufMfD
         2sTepn0ipc/ozfP9hKADrRpZzBRR7A7A96i47ZyieKGgwzlpljY9vn5dLw1Cp3yCwsLe
         wH/w==
X-Gm-Message-State: ALKqPwcVl5tpdVPQciIYDBqZqMxthXJwfKzTwwu0/IhF5XuZxHkOct33
        5es4DYNEpywMIwIFWzg2mSA=
X-Google-Smtp-Source: ADUXVKJBl0tcBtfTgPBsgWi/4VB1EoLPhYaCJIJJXZrcGXGENPNX6MpPTkVM5kPl3I1zG7qQaNZDjw==
X-Received: by 2002:adf:a60c:: with SMTP id k12-v6mr10334125wrc.200.1527895280201;
        Fri, 01 Jun 2018 16:21:20 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (abri204.neoplus.adsl.tpnet.pl. [83.8.102.204])
        by smtp.gmail.com with ESMTPSA id x63-v6sm4160364wma.25.2018.06.01.16.21.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Jun 2018 16:21:18 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        "gitster\@pobox.com" <gitster@pobox.com>,
        "stolee\@gmail.com" <stolee@gmail.com>,
        "avarab\@gmail.com" <avarab@gmail.com>,
        "marten.agren\@gmail.com" <marten.agren@gmail.com>,
        "peff\@peff.net" <peff@peff.net>
Subject: Re: [PATCH v3 12/20] commit-graph: verify parent list
References: <20180511211504.79877-1-dstolee@microsoft.com>
        <20180524162504.158394-1-dstolee@microsoft.com>
        <20180524162504.158394-13-dstolee@microsoft.com>
Date:   Sat, 02 Jun 2018 01:21:14 +0200
In-Reply-To: <20180524162504.158394-13-dstolee@microsoft.com> (Derrick
        Stolee's message of "Thu, 24 May 2018 16:25:52 +0000")
Message-ID: <86lgbyum8l.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <dstolee@microsoft.com> writes:

> The commit-graph file stores parents in a two-column portion of the
> commit data chunk. If there is only one parent, then the second column
> stores 0xFFFFFFFF to indicate no second parent.

All right, it is certainly nice to have this information, but isn't it
something that one caan find in Documentation/technical/commit-graph-format.txt?

>
> The 'verify' subcommand checks the parent list for the commit loaded
> from the commit-graph and the one parsed from the object database. Test
> these checks for corrupt parents, too many parents, and wrong parents.
>
> The octopus merge will be tested in a later commit.

Does this mean that after this commit but before the next one the
'verify' subcommand would have false negatives for octopus merges
(falsely indicating that commit-graph is invalid)?

>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  commit-graph.c          | 25 +++++++++++++++++++++++++
>  t/t5318-commit-graph.sh | 18 ++++++++++++++++++
>  2 files changed, 43 insertions(+)
>
> diff --git a/commit-graph.c b/commit-graph.c
> index 19ea369fc6..fff22dc0c3 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -921,6 +921,7 @@ int verify_commit_graph(struct commit_graph *g)
>  
>  	for (i = 0; i < g->num_commits; i++) {
>  		struct commit *graph_commit, *odb_commit;
> +		struct commit_list *graph_parents, *odb_parents;
>  
>  		hashcpy(cur_oid.hash, g->chunk_oid_lookup + g->hash_len * i);
>  
> @@ -938,6 +939,30 @@ int verify_commit_graph(struct commit_graph *g)
>  				     oid_to_hex(&cur_oid),
>  				     oid_to_hex(get_commit_tree_oid(graph_commit)),
>  				     oid_to_hex(get_commit_tree_oid(odb_commit)));
> +
> +		graph_parents = graph_commit->parents;
> +		odb_parents = odb_commit->parents;
> +
> +		while (graph_parents) {
> +			if (odb_parents == NULL) {
> +				graph_report("commit-graph parent list for commit %s is too long",
> +					     oid_to_hex(&cur_oid));
> +				break;
> +			}

All right, so this would catch the situation where there are more
parents for a commit in commit-graph than they are in the object
database version.

> +
> +			if (oidcmp(&graph_parents->item->object.oid, &odb_parents->item->object.oid))
> +				graph_report("commit-graph parent for %s is %s != %s",
> +					     oid_to_hex(&cur_oid),
> +					     oid_to_hex(&graph_parents->item->object.oid),
> +					     oid_to_hex(&odb_parents->item->object.oid));

All right, so this would catch the situation where parents do not match
between commit-graph and the object database.

> +
> +			graph_parents = graph_parents->next;
> +			odb_parents = odb_parents->next;
> +		}
> +
> +		if (odb_parents != NULL)
> +			graph_report("commit-graph parent list for commit %s terminates early",
> +				     oid_to_hex(&cur_oid));

So this would catch the situation where there are more parents for a
commit in the object database than they are in the commit-graph.  Does
this handle octopus merges automatically, or is it left for the future
work/commit?

>  	}
>  
>  	return verify_commit_graph_error;
> diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
> index 21cc8e82f3..12f0d7f54d 100755
> --- a/t/t5318-commit-graph.sh
> +++ b/t/t5318-commit-graph.sh
> @@ -269,6 +269,9 @@ GRAPH_BYTE_OID_LOOKUP_ORDER=`expr $GRAPH_OID_LOOKUP_OFFSET + $HASH_LEN \* 8`
>  GRAPH_BYTE_OID_LOOKUP_MISSING=`expr $GRAPH_OID_LOOKUP_OFFSET + $HASH_LEN \* 4 + 10`
>  GRAPH_COMMIT_DATA_OFFSET=`expr $GRAPH_OID_LOOKUP_OFFSET + $HASH_LEN \* $NUM_COMMITS`
>  GRAPH_BYTE_COMMIT_TREE=$GRAPH_COMMIT_DATA_OFFSET
> +GRAPH_BYTE_COMMIT_PARENT=`expr $GRAPH_COMMIT_DATA_OFFSET + $HASH_LEN`
> +GRAPH_BYTE_COMMIT_EXTRA_PARENT=`expr $GRAPH_COMMIT_DATA_OFFSET + $HASH_LEN + 4`
> +GRAPH_BYTE_COMMIT_WRONG_PARENT=`expr $GRAPH_COMMIT_DATA_OFFSET + $HASH_LEN + 3`
>  
>  # usage: corrupt_graph_and_verify <position> <data> <string>
>  # Manipulates the commit-graph file at the position
> @@ -348,4 +351,19 @@ test_expect_success 'detect incorrect tree OID' '
>  		"root tree OID for commit"
>  '
>  
> +test_expect_success 'detect incorrect parent int-id' '
> +	corrupt_graph_and_verify $GRAPH_BYTE_COMMIT_PARENT "\01" \
> +		"invalid parent"
> +'

So this would actually be caught by code introduced earlier, and not by
the one introduced in this commit -- but logically this test belongs
here, ian't it?

> +
> +test_expect_success 'detect extra parent int-id' '
> +	corrupt_graph_and_verify $GRAPH_BYTE_COMMIT_EXTRA_PARENT "\00" \
> +		"is too long"
> +'

O.K., so the commit has one parent and we have corrupted it to read as
if it had more than one (and commit-graph would then have more parents
than reality, that is the object database).

Sidenote: I think we can use regexp for checking if the error message
matches, isn't it?

> +
> +test_expect_success 'detect incorrect tree OID' '

Errr... what?  The name of this test seems very wrong...

> +	corrupt_graph_and_verify $GRAPH_BYTE_COMMIT_WRONG_PARENT "\01" \
> +		"commit-graph parent for"
> +'

So here you modify the prent list in commit graph so that the commit
number points fits within commit-graph; it would of course make the
commit-graph and the object database version of parents do not match.
Good.

> +
>  test_done
