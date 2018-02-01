Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 493B91F404
	for <e@80x24.org>; Thu,  1 Feb 2018 23:33:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751514AbeBAXdx (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Feb 2018 18:33:53 -0500
Received: from mail-pl0-f47.google.com ([209.85.160.47]:35278 "EHLO
        mail-pl0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751378AbeBAXdv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Feb 2018 18:33:51 -0500
Received: by mail-pl0-f47.google.com with SMTP id j19so4748044pll.2
        for <git@vger.kernel.org>; Thu, 01 Feb 2018 15:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6btX2faM87SmibXzK+czZUJ3cJqX0foE3OxOij8CJYk=;
        b=ExleEH1M8o7aumJAxoZvll5TWJzlkLQ9nzxSaVzwXWIGB8iGgxtHSPxCz3TJ9TTaGO
         jKQ3keb6+JxIG5X0gcMCYsdw0A5fVfyiSmV2g0nOklGYW23QAl9fUREfeLu1Gna/6UMB
         O8AMiqD1J+4F3Fl+JgqmsdezGqwGKCBtwhoB7l+NPk/B5lDf+BsOMwNgMyW/z8Sg8Q7/
         YqwgG/XTjNxT9P3Af3arHZagT9gurHpc2/GOiLj8XEbQZSeXewROIWOV6L+3ZQpoIjnL
         i21P9o/Q3cu54AXTGkBRcnAU9kQpFw2dQG2neIoHntGr/A4WzGJ95wIQsiu0IwCf9viT
         NiMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6btX2faM87SmibXzK+czZUJ3cJqX0foE3OxOij8CJYk=;
        b=PVBhdrZASFqLLK4ZhKjZrboBsWSyBts1C0y0sSUy3IQjpVzM3uhVIrlBGfHJAR745h
         +fF/4XtrESM/N4ag0O5t8QMoiPA8B6nfbrTTI1VqkSQ4FUJ5VdDPdzAVZ/6gkF/am0F7
         pqL4YGIaK7Bj4wKYX9qRv4Utppa7geMdczWiEc3vftmEcM4RI/L5aVHMyRviNum3K3pG
         v0DOmc0CVkdRGUaeUyv4xGzmKqE/de7Oc7Vqk4vkWXjaY7bA+oAajsH1DQ3csPYtSGsv
         m7W9OBcRtcYezWeDjK6MkViUhQ54x1IiEluoBVMeqXcCk7HIUSV0uIT692/jwsmRpUbl
         YJNQ==
X-Gm-Message-State: AKwxytdP9hOglU1tGtWskKxYboJ1uxR6wQ9wrkpjL929NsYRDr9ic491
        xmboe4gqTTFJTNTAljT15aHR8Pdqx9U=
X-Google-Smtp-Source: AH8x227Qh3Cm8rwd3u/EpzA5PCLZ+EH0wHzljNiJVTLkOeCUVSOABUPdNCzLHWLtGiNphOMENXWd0g==
X-Received: by 2002:a17:902:183:: with SMTP id b3-v6mr5198543plb.383.1517528031315;
        Thu, 01 Feb 2018 15:33:51 -0800 (PST)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id 184sm691867pfd.156.2018.02.01.15.33.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Feb 2018 15:33:50 -0800 (PST)
Date:   Thu, 1 Feb 2018 15:33:49 -0800
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        git@jeffhostetler.com, sbeller@google.com, dstolee@microsoft.com
Subject: Re: [PATCH v2 05/14] commit-graph: implement git-commit-graph
 --write
Message-Id: <20180201153349.c94fe3de6b632e2fd8f843cf@google.com>
In-Reply-To: <1517348383-112294-6-git-send-email-dstolee@microsoft.com>
References: <1517348383-112294-1-git-send-email-dstolee@microsoft.com>
        <1517348383-112294-6-git-send-email-dstolee@microsoft.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 30 Jan 2018 16:39:34 -0500
Derrick Stolee <stolee@gmail.com> wrote:

> diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
> index c8ea548dfb..3f3790d9a8 100644
> --- a/Documentation/git-commit-graph.txt
> +++ b/Documentation/git-commit-graph.txt
> @@ -5,3 +5,21 @@ NAME
>  ----
>  git-commit-graph - Write and verify Git commit graphs (.graph files)
>  
> +
> +SYNOPSIS
> +--------
> +[verse]
> +'git commit-graph' --write <options> [--pack-dir <pack_dir>]

Subcommands (like those in git submodule) generally don't take "--", as
far as I know.

> +static int graph_write(void)
> +{
> +	struct object_id *graph_hash = construct_commit_graph(opts.pack_dir);

I should have noticed this when I was reviewing the previous patch, but
this is probably better named write_commit_graph.

> +test_expect_success 'create commits and repack' \
> +    'for i in $(test_seq 5)
> +     do
> +        echo $i >$i.txt &&
> +        git add $i.txt &&
> +        git commit -m "commit $i" &&

You can generate commits more easily with test_commit. Also, the final
character of the test_expect_success line should be the apostrophe that
starts the big text block, like in other files. (That also means that
the backslash is unnecessary.)

> +# Current graph structure:
> +#
> +#      M3
> +#     / |\_____
> +#    / 10      15
> +#   /   |      |
> +#  /    9 M2   14
> +# |     |/  \  |
> +# |     8 M1 | 13
> +# |     |/ | \_|
> +# 5     7  |   12
> +# |     |   \__|
> +# 4     6      11
> +# |____/______/
> +# 3
> +# |
> +# 2
> +# |
> +# 1

I don't think we need such a complicated graph structure - maybe it's
sufficient to have one 2-way merge and one 3-way merge. E.g.

6
|\-.
5 \ \
|\ \ \
1 2 3 4

Also, I wonder if it is possible to test the output to a greater extent.
We don't want anything that relies on the ordering of commits
(especially since we plan on transitioning away from using SHA-1 as the
hash function) but we could still test, for example, that a 3-way merge
results in an edge list of the form "EDGE_..._..." (where the first _
does not have its high bit set, but the second one does). This could be
done by using my hex_unpack() function as seen here [1] with grep (e.g.
"45444745[0-7].......[8-9a-f].......").

[1] https://public-inbox.org/git/b9ea93edabc42754dc3643d6307c22a947eabaf3.1506714999.git.jonathantanmy@google.com/
