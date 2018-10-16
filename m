Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 161B41F453
	for <e@80x24.org>; Tue, 16 Oct 2018 02:00:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbeJPJsT (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Oct 2018 05:48:19 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34267 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726917AbeJPJsT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Oct 2018 05:48:19 -0400
Received: by mail-wr1-f66.google.com with SMTP id l6-v6so23063858wrt.1
        for <git@vger.kernel.org>; Mon, 15 Oct 2018 19:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=odjsYCjGBJpP2gmN/foaGaj2yT9/VONJ2o8NaN2dpw8=;
        b=Z1dChDgODnEakq3bP4SZmMk5AInnH7uqZmexARGTomM9lEET/Yy4Q1/eymNeiJK/BH
         cEzasX5vU8xAd634y/qh1UFGjlCqHRZ8hTf24Ky5sf23+2ds6vjCZPwZi3+CSxsPYOBY
         Oxdsly+h7Yjbtj2498vpKcZCz59lwNQKcAKVfinkKSEVBkMm2ADDdB9GMdHIAPHAotap
         ieziFSR0rrPuCaIWHASLnbGQP+Gv/n20/CdVz826MhaR/Ujt6hfOabX/jCCEqoxgnNBW
         7WZKaH7N4DG8xaL+8LKNu6XF87EuQtrXDUGlIy+Jx58SPMTwQzp3bClreJfKsMLeusLf
         hjAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=odjsYCjGBJpP2gmN/foaGaj2yT9/VONJ2o8NaN2dpw8=;
        b=PkrOiuJQacv0z3JH98ivCqN5yxV6V6zmLv54k7O522j42FYVvmnC2p37h9YxbRIxgE
         BhdAyFrkUWJlfyE0gKXSckD+qVLiurCH1/e/AbnrtPVA6DbbL3+Q8B7stfQAHH3q5Kk5
         So8zyqLtD6wJdCTCvl74gb2Sypuiu6WFJ7B8iGJP66shJYeqkhLgvrbT21fibM+lptcp
         Eyxfi48tQ5IiL4dMfmhHFaIlJjnOQ6uLeoVRazDO6xredW7SEJeeDJKx1e4QpeY2ErCJ
         F6XtIVktQMFfC7RulYfVNFvuqpIo+ejPODSnOqP8Tb/A/W0vUiGzqcrUMvz0FK8aGFsy
         U9Gg==
X-Gm-Message-State: ABuFfog7Xk+uXR95ROdujcsbVfAy2AWJcraX885cj3Eloju51W/PvKVI
        iLwooFZRPeVweVgpE/YTItIN7KWFrGs=
X-Google-Smtp-Source: ACcGV60Pw3JcxO9QqqGI2YUz5QprERIRSAw8uDTIaHvb+MGlThAVOkkG2BMdbSrsD9mKVs8dCEBm0w==
X-Received: by 2002:a5d:694c:: with SMTP id r12-v6mr1288401wrw.170.1539655220893;
        Mon, 15 Oct 2018 19:00:20 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id t198-v6sm9956144wmd.9.2018.10.15.19.00.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Oct 2018 19:00:19 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Derrick Stolee <stolee@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 13/13] commit-graph: specify OID version for SHA-256
References: <20181015021900.1030041-1-sandals@crustytoothpaste.net>
        <20181015021900.1030041-14-sandals@crustytoothpaste.net>
Date:   Tue, 16 Oct 2018 11:00:19 +0900
In-Reply-To: <20181015021900.1030041-14-sandals@crustytoothpaste.net> (brian
        m. carlson's message of "Mon, 15 Oct 2018 02:19:00 +0000")
Message-ID: <xmqqk1mi4pn0.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> Since the commit-graph code wants to serialize the hash algorithm into
> the data store, specify a version number for each supported algorithm.
> Note that we don't use the values of the constants themselves, as they
> are internal and could change in the future.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  commit-graph.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/commit-graph.c b/commit-graph.c
> index 7a28fbb03f..e587c21bb6 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -45,7 +45,14 @@ char *get_commit_graph_filename(const char *obj_dir)
>  
>  static uint8_t oid_version(void)
>  {
> -	return 1;
> +	switch (hash_algo_by_ptr(the_hash_algo)) {
> +		case GIT_HASH_SHA1:
> +			return 1;
> +		case GIT_HASH_SHA256:
> +			return 2;
> +		default:
> +			BUG("unknown hash algorithm");
> +	}

Style: align switch/case.


Shouldn't this be just using GIT_HASH_* constants instead?  Are we
expecting that it would be benefitial to allow more than one "oid
version" even within a same GIT_HASH_*?

>  }
>  
>  static struct commit_graph *alloc_commit_graph(void)
