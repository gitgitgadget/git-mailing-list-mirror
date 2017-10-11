Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 393DA20372
	for <e@80x24.org>; Wed, 11 Oct 2017 08:23:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757036AbdJKIXc (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Oct 2017 04:23:32 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:43393 "EHLO
        alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751415AbdJKIXa (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 11 Oct 2017 04:23:30 -0400
X-AuditID: 12074414-0d3ff70000006ddf-ab-59ddd5001c3f
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 7C.F6.28127.005DDD95; Wed, 11 Oct 2017 04:23:28 -0400 (EDT)
Received: from [192.168.69.190] (p57BCCD9E.dip0.t-ipconnect.de [87.188.205.158])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v9B8NP7B006385
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Wed, 11 Oct 2017 04:23:27 -0400
Subject: Re: [PATCH v2 21/24] refs: convert resolve_ref_unsafe to struct
 object_id
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>
References: <20171009011132.675341-1-sandals@crustytoothpaste.net>
 <20171009011132.675341-22-sandals@crustytoothpaste.net>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <0fda8531-7f2a-1a01-a9d1-a4d699f5bebf@alum.mit.edu>
Date:   Wed, 11 Oct 2017 10:23:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20171009011132.675341-22-sandals@crustytoothpaste.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnleLIzCtJLcpLzFFi42IRYndR1GW8ejfS4NAWZovn60+wW3Rd6Way
        +NHSw2zRNvMHk8Xmze0sDqwey2/+ZfJYsKnU41nvHkaPz5vkAliiuGxSUnMyy1KL9O0SuDI+
        bD3LUvCTt+L373eMDYytXF2MnBwSAiYSJ6dcZ+5i5OIQEtjBJHFw02MWCOcCk8Sb4/eZQKqE
        BUIk5i3bzwJiiwh4Scx/NIMVxGYWKJB43n6HEcQWEqiR6Dy4CMxmE9CVWNTTDNbLK2Av8WT7
        ZrA4i4CqxN07+4DiHByiAhESGzbyQ5QISpyc+QRsPKeAi8SeltdsEOPVJf7Mu8QMYYtL3Hoy
        nwnClpfY/nYO8wRGgVlI2mchaZmFpGUWkpYFjCyrGOUSc0pzdXMTM3OKU5N1i5MT8/JSi3Qt
        9HIzS/RSU0o3MULCXWQH45GTcocYBTgYlXh4Ba7fiRRiTSwrrsw9xCjJwaQkyqsw526kEF9S
        fkplRmJxRnxRaU5q8SFGCQ5mJRHe4ItAOd6UxMqq1KJ8mJQ0B4uSOO+3xep+QgLpiSWp2amp
        BalFMFkZDg4lCd7nl4EaBYtS01Mr0jJzShDSTBycIMN5gIa/A6nhLS5IzC3OTIfIn2JUlBLn
        fQWSEABJZJTmwfXC0tErRnGgV4R5Oa4AVfEAUxlc9yugwUxAg0XT7oAMLklESEk1MMr9Dkq4
        71l2js91l+5dV0mNNTuWNMQms1g1bxe/wa949L9XzV9Nm2PLWuz33DrVL3ml4kJQL5/cCRW3
        2NTkh1PfGC+eKbci+Zz2PO+th97xxSqyyF7rtCuru/Nf5ciVO1X7De6trLqu7C1a/er2kbf8
        H97vOxJ82WTR8VMNsRurHrKGx/Y2rlZiKc5INNRiLipOBACy9TD4IgMAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/09/2017 03:11 AM, brian m. carlson wrote:
> Convert resolve_ref_unsafe to take a pointer to struct object_id by
> converting one remaining caller to use struct object_id, converting the
> declaration and definition, and applying the following semantic patch:
> 
> @@
> expression E1, E2, E3, E4;
> @@
> - resolve_ref_unsafe(E1, E2, E3.hash, E4)
> + resolve_ref_unsafe(E1, E2, &E3, E4)
> 
> @@
> expression E1, E2, E3, E4;
> @@
> - resolve_ref_unsafe(E1, E2, E3->hash, E4)
> + resolve_ref_unsafe(E1, E2, E3, E4)
> 
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  blame.c                   |  4 ++--
>  builtin/fsck.c            |  2 +-
>  refs.c                    | 28 ++++++++++++++--------------
>  refs.h                    |  4 ++--
>  refs/files-backend.c      |  8 ++++----
>  sequencer.c               |  2 +-
>  t/helper/test-ref-store.c |  6 +++---
>  transport-helper.c        |  7 +++----
>  worktree.c                |  2 +-
>  9 files changed, 31 insertions(+), 32 deletions(-)
> 
> [...]
> diff --git a/refs.h b/refs.h
> index bb0dcd97af..4eedc880c6 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -62,10 +62,10 @@ struct worktree;

The docstring above this hunk needs to be adjusted.

>  const char *refs_resolve_ref_unsafe(struct ref_store *refs,
>  				    const char *refname,
>  				    int resolve_flags,
> -				    unsigned char *sha1,
> +				    struct object_id *oid,
>  				    int *flags);
>  const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
> -			       unsigned char *sha1, int *flags);
> +			       struct object_id *oid, int *flags);
>  
>  char *refs_resolve_refdup(struct ref_store *refs,
>  			  const char *refname, int resolve_flags,
> [...]
Michael
