Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	LOTS_OF_MONEY,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD3371F453
	for <e@80x24.org>; Wed, 23 Jan 2019 23:56:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbfAWX4f (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Jan 2019 18:56:35 -0500
Received: from mail-yw1-f74.google.com ([209.85.161.74]:35251 "EHLO
        mail-yw1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfAWX4f (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jan 2019 18:56:35 -0500
Received: by mail-yw1-f74.google.com with SMTP id d73so2130279ywd.2
        for <git@vger.kernel.org>; Wed, 23 Jan 2019 15:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=EIkWOFUGet3rzOc+v0wB4QoZxnEgKiEEucjA+TXQMSE=;
        b=YIlGotMZTm+rt/RwpNK47s35ysNA0tvSsbnRtyQAnXLifaA+kmOmMfOLGMnczkNdlT
         pADk0/964CG5VMR9peM223Ff/wkfru0snNCRZIT4/LX3UYIziXCg7/sQuQSlYMrb3a09
         1FWBIeIFdJuO12NC1Uo+j7TH1WtMeRSv10O7EXPTDPoTOoFZzdkyS/E3aJ1ixX2cZaV3
         CixI2xGWEzHWOG82i/waFfFHX0uevQsR58YDavPxdIjWT4ia99RaGIFeWfUP/X3fD5ck
         Pl747dATBNOqHmwzjH/GMd/1O++mtsfCQR8sySEldNGmS/Aqlkt5oElGu3TJiYsykbE2
         V69A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=EIkWOFUGet3rzOc+v0wB4QoZxnEgKiEEucjA+TXQMSE=;
        b=lKmoSm9Q6pFM6oZBZIIy10Ihw66Eo0jDg7j5jSLboUQcKzdbHumcWLuBt0uKhK1vYN
         Ia5aFXAIwpAgM+4TnzOv2GpTgmvGPhrV4DZ9rj1p02ePvGZ8VMZKRZNF4tMCqQAMXBlG
         kMZz8GB5afb2wnDXLA2hgjeyQkygBWWCpT8x1SZ0zKBbTXMVoADVibjzP7q1nWh+AhTd
         DzWk3HvT232dq0TpkbywVxYbAd+Dp4FoiyGYx2Se3iISQDEjIfem80RZZ4d7N+Ceo92m
         PK032sl9zQ7AWT6TlePKP03s5QZSCa5U2QYbcalHnzIxGV03gl2aHARgy9V2x9ipyId4
         kaeg==
X-Gm-Message-State: AJcUukcLbvsKrhZnhEz1DPmcaFAJDt53qujmivvRLnSvBgK6pnXUDExv
        vPGYE87zNkUwmcZC1EtOzcI3S5YrJNpqV/HQ+F62
X-Google-Smtp-Source: ALg8bN6wpV/LUsjEk3dEbsOPnCWWdomTVflGota1+Z5XplistzM1i/lFPa0c32ErIlIYLae57oYgQuyJdFefcAnTTtoy
X-Received: by 2002:a25:63c3:: with SMTP id x186mr2016601ybb.63.1548287794446;
 Wed, 23 Jan 2019 15:56:34 -0800 (PST)
Date:   Wed, 23 Jan 2019 15:56:30 -0800
In-Reply-To: <c55e0a738c79c30affcf2cb68564c01c36c66dff.1548280753.git.gitgitgadget@gmail.com>
Message-Id: <20190123235630.183779-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <c55e0a738c79c30affcf2cb68564c01c36c66dff.1548280753.git.gitgitgadget@gmail.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: Re: [PATCH 5/6] commit-graph: implement file format version 2
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitgitgadget@gmail.com
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        avarab@gmail.com, gitster@pobox.com, dstolee@microsoft.com,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> +Version 2:
> +
> +  1-byte number (C) of "chunks"
> +
> +  1-byte reachability index version number:
> +      Currently, the only valid number is 1.
> +
> +  1-byte (reserved for later use)
> +      Current clients expect this value to be zero, and will not
> +      try to read the commit-graph file if it is non-zero.
> +
> +  4-byte format identifier for the hash algorithm:
> +      If this identifier does not agree with the repository's current
> +      hash algorithm, then the client will not read the commit graph.

[snip]

> diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
> index b79d6263e9..3ff5e3b48d 100755
> --- a/t/t5318-commit-graph.sh
> +++ b/t/t5318-commit-graph.sh
> @@ -65,7 +65,8 @@ graph_read_expect() {
>  		NUM_CHUNKS=$((3 + $(echo "$2" | wc -w)))
>  	fi
>  	cat >expect <<- EOF
> -	header: 43475048 1 1 $NUM_CHUNKS 0
> +	header: 43475048 2 $NUM_CHUNKS 1 0
> +	hash algorithm: 73686131
>  	num_commits: $1
>  	chunks: oid_fanout oid_lookup commit_metadata$OPTIONAL
>  	EOF
> @@ -390,10 +391,14 @@ test_expect_success 'detect bad signature' '
>  '
>  
>  test_expect_success 'detect bad version' '
> -	corrupt_graph_and_verify $GRAPH_BYTE_VERSION "\02" \
> +	corrupt_graph_and_verify $GRAPH_BYTE_VERSION "\03" \
>  		"graph version"
>  '
>  
> +test_expect_success 'detect version 2 with version 1 data' '
> +	corrupt_graph_and_verify $GRAPH_BYTE_VERSION "\02" \
> +		"reachability index version"
> +'
>  test_expect_success 'detect bad hash version' '
>  	corrupt_graph_and_verify $GRAPH_BYTE_HASH "\02" \
>  		"hash version"

Should there also be a test that the "reserved" section be 0 and the
4-byte identifier agrees with the repo's hash algorithm? I assume that
this can be done by "corrupting" the version to 2 and then truly
corrupting the subsequent bytes.

Other than that, this and the previous patches look good.
