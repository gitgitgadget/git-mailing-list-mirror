Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BEFFC433B4
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 19:49:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19604613EB
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 19:49:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233791AbhDTTuP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 15:50:15 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61404 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233682AbhDTTuP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 15:50:15 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9D01BD02F0;
        Tue, 20 Apr 2021 15:49:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=b9BtB3jzesrfooS4SsmzgLnVqpQ=; b=fMx4bV
        0R0NVcjlsByiBPnNfH8/yNe5NyHvECdSdFSh3RcpCGOnsyknUA9S6jsKUcv4xqea
        NIKKNwHqgZOl5G8iZ68Fhgrxbrm+GE1DptmLiXDZDLmAnSSzfEEzyrxBqFtpZivS
        xA+BwfL5+r5FVJ2B0e7bDGUqmTX+2hgXhvm7g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uWhDa3QGjVw2A6FC3T0IAnFg0E3tpTaj
        AC8T8/ergfrmXaIvUy/dbWno8bazaxd3VGgi746I07E5x7CcLnp6/zjAd7jRkAA6
        KV/nJGuO578JYiwujC3h/kiK08Tk1drNy40RK5hsYEg0BEpC1axQSiRLYLTKCw1w
        5Nvfxd0nv+Y=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 93DCCD02EF;
        Tue, 20 Apr 2021 15:49:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1EFC7D02EE;
        Tue, 20 Apr 2021 15:49:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Patrick Steinhardt <ps@pks.im>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v7 04/28] hash.h: provide constants for the hash IDs
References: <pull.847.v6.git.git.1618255552.gitgitgadget@gmail.com>
        <pull.847.v7.git.git.1618832276.gitgitgadget@gmail.com>
        <f0216ae20b6988514bdb60d8fff96e18c2ce9f1d.1618832277.git.gitgitgadget@gmail.com>
Date:   Tue, 20 Apr 2021 12:49:41 -0700
In-Reply-To: <f0216ae20b6988514bdb60d8fff96e18c2ce9f1d.1618832277.git.gitgitgadget@gmail.com>
        (Han-Wen Nienhuys via GitGitGadget's message of "Mon, 19 Apr 2021
        11:37:32 +0000")
Message-ID: <xmqqlf9c68iy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8C923330-A211-11EB-8A69-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Han-Wen Nienhuys <hanwen@google.com>
>
> This will simplify referencing them from code that is not deeply integrated with
> Git, in particular, the reftable library.
>
> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> ---
>  hash.h        | 6 ++++++
>  object-file.c | 6 ++----
>  2 files changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/hash.h b/hash.h
> index 3fb0c3d4005a..b17fb2927711 100644
> --- a/hash.h
> +++ b/hash.h
> @@ -161,12 +161,18 @@ static inline int hash_algo_by_ptr(const struct git_hash_algo *p)
>  	return p - hash_algos;
>  }
>  
> +/* "sha1", big-endian */
> +#define GIT_SHA1_HASH_ID 0x73686131
> +
>  /* The length in bytes and in hex digits of an object name (SHA-1 value). */
>  #define GIT_SHA1_RAWSZ 20
>  #define GIT_SHA1_HEXSZ (2 * GIT_SHA1_RAWSZ)
>  /* The block size of SHA-1. */
>  #define GIT_SHA1_BLKSZ 64
>  
> +/* "s256", big-endian */
> +#define GIT_SHA256_HASH_ID 0x73323536

I agree that it makes sense to have symbolic constants defined in
this file.  These are values that fit in the ".format_id" member of
"struct git_hash_algo", and it is preferrable to make sure that the
names align (if I were designing in void, I would have called the
member "algo_id" and made the constants GIT_(SHA1|SHA256)_ALGO_ID).

Brian?  What's your preference ("I am fine to store HASH_ID in the
'.format_id' member" is perfectly an acceptable answer).

Thanks.
