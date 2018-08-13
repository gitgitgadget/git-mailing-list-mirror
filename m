Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE5A21F404
	for <e@80x24.org>; Mon, 13 Aug 2018 18:29:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730119AbeHMVNS (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 17:13:18 -0400
Received: from mail-ua1-f74.google.com ([209.85.222.74]:41753 "EHLO
        mail-ua1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728540AbeHMVNS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 17:13:18 -0400
Received: by mail-ua1-f74.google.com with SMTP id c13-v6so7878115uao.8
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 11:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Rw61NA1Cw37HNAr53b0Kp4o+VVx54D28AFiG6+JQ+0w=;
        b=OLAP5k0Rz4Q9156NVuc5Vr0VRUUnX1eXSzQH+1Etz6xxiZlZwgHIOlpopZ/vaqPOfX
         iZtkqqLGEIJxdJzEYESqPYnYa9okjqQtn1JQF+lzTvHXVj+J3aALqJJMVDp9LJ4bEa8t
         xoC7xpY9y9WwkS2tPUnD1vTbw0SFSSzZqBq+FJchHlyrbXf/nNEfh3aYrn6IEww9TRtB
         Kvf+0yvsR+UamAZJAsm/h6kH87BNz9wv8ujSnB19ACZecD/zQN6U5gQDz/rv0hKGizm+
         4LvVkV09pKmjlDcbQ0J9xZ7wS93mZZKXhm8UP8XBRzTpwPAYJuqU+MJ2fwJpAhOOvtCe
         xSAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Rw61NA1Cw37HNAr53b0Kp4o+VVx54D28AFiG6+JQ+0w=;
        b=Jg5IdRsmPvPvBCSIXFmEw6nHHRL8uZmSi8/4eHYU/ZOpHGp1H/Y0bVqx8q3gkLCoeQ
         1xFFXr+24VmoS7B4bBSLz+91doftNOleFYAdgO5A6e20z3Wgji2cXDgPz0lIbl4ll+QG
         4LL25G+EhEMVKkHuaoFpsYQb7Q+VkoTm5qhokuCU1Quzu7LGlk1zpVWqcxgiW4hO65DP
         IqGRoP4ZwyuXa9IWn8tbIUGReLCoEqwJDxlsLszZlfsWcvyefHX6CRQBRLe6A4hiIj9V
         D4MyWNzqfp4+vwUlQXQhrEO30ykJx9vXcIIjk0VCNdDgjztkwj72c5uqmEkLGILD7dZt
         HrIg==
X-Gm-Message-State: AOUpUlG2bT02+SkQuBJ9tQwp9vUUPdcCQeZIRTAr4iiiRlL0MPvD5lKv
        6H1Pw1CKrE0z1PA8LDMc5RsSCWTHBMbx1Q7lxOnS
X-Google-Smtp-Source: AA+uWPyAH/VRBggliI7A8bN+pQsaEXO9FK2aMbahM+LQOu5NKDLTiqwZL5VMhftTCGMVorTk4a1wnAwDac47DpiXV4hp
X-Received: by 2002:a1f:7d07:: with SMTP id y7-v6mr10002525vkc.45.1534184995581;
 Mon, 13 Aug 2018 11:29:55 -0700 (PDT)
Date:   Mon, 13 Aug 2018 11:29:50 -0700
In-Reply-To: <0af4ef64aa52d76a597b4e97c0626c70fb2a883b.1533941986.git.matvore@google.com>
Message-Id: <20180813182950.15723-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <0af4ef64aa52d76a597b4e97c0626c70fb2a883b.1533941986.git.matvore@google.com>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
Subject: Re: [PATCH v2 5/5] list-objects-filter: implement filter tree:none
From:   Jonathan Tan <jonathantanmy@google.com>
To:     matvore@google.com
Cc:     git@vger.kernel.org, jeffhost@microsoft.com, peff@peff.net,
        stefanbeller@gmail.com, jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> -	case LOFS_BEGIN_TREE:
> -		assert(obj->type == OBJ_TREE);
> -		/* always include all tree objects */
> -		return LOFR_MARK_SEEN | LOFR_DO_SHOW;
> -
>  	case LOFS_END_TREE:
>  		assert(obj->type == OBJ_TREE);
>  		return LOFR_ZERO;
>  
> +	case LOFS_BEGIN_TREE:
> +		assert(obj->type == OBJ_TREE);
> +		if (!filter_data->omit_trees)
> +			return LOFR_MARK_SEEN | LOFR_DO_SHOW;
> +
> +		/*
> +		 * Fallthrough to insert into omitted list for trees as well as
> +		 * blobs.
> +		 */
> +		/* fallthrough */
>  	case LOFS_BLOB:
> -		assert(obj->type == OBJ_BLOB);
>  		assert((obj->flags & SEEN) == 0);

After looking at the resulting file, I don't think saving a few lines of
code (to add the OID, then return LOFR_MARK_SEEN) is worth rearranging
the cases and falling through. Can you just add the OID-adding code to
the LOFS_BEGIN_TREE case?

> +test_expect_success 'can use tree:none to filter partial clone' '
> +	rm -rf dst &&
> +	git clone --no-checkout --filter=tree:none "file://$(pwd)/srv.bare" dst &&
> +	git -C dst rev-list master --missing=allow-any --objects >fetched_objects &&
> +	cat fetched_objects \
> +		| awk -f print_1.awk \
> +		| xargs -n1 git -C dst cat-file -t >fetched_types &&
> +	sort fetched_types -u >unique_types.observed &&
> +	echo commit > unique_types.expected &&
> +	test_cmp unique_types.observed unique_types.expected
> +'

We also need to verify that the resulting partial clone works - after
all relevant tests, can you also ensure that:
 - fsck works
 - a cat-file on an indirectly missing tree works (i.e. if you have
   commit -> A -> B and both A and B are missing, cat-file the B)
 - fsck still works after the cat-file

There is another potential issue about expanding the documentation of
the pack protocol because we now support a new type of filter, but that
is fine because the protocol currently points us to the rev-list
documentation (which is updated). We probably need a way for clients to
query servers about which filters they support, but that is definitely
beyond the scope of this patch set.

> +test_expect_success 'show missing tree objects with --missing=print' '
> +	git -C dst rev-list master --missing=print --quiet --objects >missing_objs &&
> +	sed "s/?//" missing_objs \
> +		| xargs -n1 git -C srv.bare cat-file -t \
> +		>missing_types &&
> +	sort -u missing_types >missing_types.uniq &&
> +	echo tree >expected &&
> +	test_cmp missing_types.uniq expected
> +'

As stated in my review of patch 3, also test the other --missing
arguments.

Patches 1, 2, and 4 look good to me. (Writing this here so that I don't
need to send one e-mail for each.)
