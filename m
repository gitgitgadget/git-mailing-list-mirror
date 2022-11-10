Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECBF9C4332F
	for <git@archiver.kernel.org>; Thu, 10 Nov 2022 07:23:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232469AbiKJHXt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Nov 2022 02:23:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232459AbiKJHXr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2022 02:23:47 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B165F92
        for <git@vger.kernel.org>; Wed,  9 Nov 2022 23:23:46 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id f7so1735177edc.6
        for <git@vger.kernel.org>; Wed, 09 Nov 2022 23:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FWv8BtqgJEsciNYAwuxZ9XKVacAld/IuFB8ZHpB+wB8=;
        b=TCo0FkNhBr57FDOQTj311jxNpjxyzwPX43oBuKKVvwqUwQ4B20As0xgIbtUuXM4gke
         xF7AOwO2FYZP3VFzVxqdqcHopip7cjJnxqBiqFw0/8y7AhEte0VvLuIXrcsNUArEMqqB
         fxgPOfOjRh+b6uxfD1Yw85TSr7XgFkQ1UTW4c6U5cjDlIpVbICc+YhAeehvhxrc9tTWP
         rm48VQXI+q+L0ylFAbO1LQAgGqDYRBMY2XkEP8D5EFDzRLubKmOMb0MjyYhc/vtu5VfI
         Y2cGJpk+7Kz12HhftiWob9Y2I936gtbKmlgDuLqZlaPkYItXheeJVgMM2HcJc5iHucjR
         NUOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FWv8BtqgJEsciNYAwuxZ9XKVacAld/IuFB8ZHpB+wB8=;
        b=a5XPZOgNj8bZcBOHQlk0aABybFj5YElvlrKhFAjTL7G9dKNw/u0sZStY25w//XPn3+
         FqE2Q8Ri6CiYJ3ifZdn9/OZzuNZfYPZt4tZst/jOk+Pr8n7GwhfsnPfGlK0Zm8ijExz8
         439M8yjbYShB+emzWTbfhQuDj596rq56RXTJXtkw4tTdXpOuGIyge3KJ6DsNzwUDbC55
         nzhbBuhTbRTvsZVQekBzivThDWMkY2hDcx0Qy6/hNrpJbEee3iNY3yg0hTCKAZMZOrJh
         XN5Hy2Il6uDXI+5tGdCmtP21wik2e+OqdZg8du7rkYoaQdhSox7lPVrieQE96ovmOyDf
         6kZA==
X-Gm-Message-State: ACrzQf0Cs774iCsK2YhW42cHzWfxLBIuo8/aRmRyLrMF/IYRrWPV0Ass
        cEVky+ZIJmPI9kr5sKE4LAo=
X-Google-Smtp-Source: AMsMyM6lVKxxmOIbtq3JA6E/jdOwQ+/kz0l0ihRkzzW7KGEFttT78Xra33JR6yKmcJr8Xb8Qvk4haA==
X-Received: by 2002:a05:6402:1cc9:b0:456:7669:219b with SMTP id ds9-20020a0564021cc900b004567669219bmr1856132edb.221.1668065024934;
        Wed, 09 Nov 2022 23:23:44 -0800 (PST)
Received: from localhost (78-131-17-60.pool.digikabel.hu. [78.131.17.60])
        by smtp.gmail.com with ESMTPSA id ew12-20020a056402538c00b00461cdda400esm8202608edb.4.2022.11.09.23.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 23:23:43 -0800 (PST)
Date:   Thu, 10 Nov 2022 08:23:42 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, phillip.wood123@gmail.com,
        derrickstolee@github.com, jonathantanmy@google.com,
        Victoria Dye <vdye@github.com>
Subject: Re: [PATCH 1/5] cache-tree: add perf test comparing update and prime
Message-ID: <20221110072342.GA1159673@szeder.dev>
References: <pull.1411.git.1667947465.gitgitgadget@gmail.com>
 <45c198c629da1627eabf0e63539f50aaa50381bf.1667947465.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <45c198c629da1627eabf0e63539f50aaa50381bf.1667947465.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 08, 2022 at 10:44:21PM +0000, Victoria Dye via GitGitGadget wrote:
> diff --git a/t/helper/test-cache-tree.c b/t/helper/test-cache-tree.c
> new file mode 100644
> index 00000000000..2fad6d06d30
> --- /dev/null
> +++ b/t/helper/test-cache-tree.c
> @@ -0,0 +1,52 @@
> +#include "test-tool.h"
> +#include "cache.h"
> +#include "tree.h"
> +#include "cache-tree.h"
> +#include "parse-options.h"
> +
> +static char const * const test_cache_tree_usage[] = {
> +	N_("test-tool cache-tree <options> (prime|repair)"),

The code looking at 'argv[0]' below only handles "prime" and "update",
but not "repair".

> +	NULL
> +};
> +
> +int cmd__cache_tree(int argc, const char **argv)
> +{
> +	struct object_id oid;
> +	struct tree *tree;
> +	int fresh = 0;
> +	int count = 1;
> +	int i;
> +
> +	struct option options[] = {
> +		OPT_BOOL(0, "fresh", &fresh,
> +			 N_("clear the cache tree before each repetition")),
> +		OPT_INTEGER_F(0, "count", &count, N_("number of times to repeat the operation"),
> +			      PARSE_OPT_NONEG),
> +		OPT_END()
> +	};
> +
> +	setup_git_directory();
> +
> +	parse_options(argc, argv, NULL, options, test_cache_tree_usage, 0);

Here 'argc' must be updated with the return value of parse_options(),
otherwise the 'if (!argc)' condition doesn't catch what it's supposed
to, and the subsequent 'else if' segfaults when passes the NULL
argv[0] to strcmp().

> +
> +	if (read_cache() < 0)
> +		die("unable to read index file");
> +
> +	get_oid("HEAD", &oid);
> +	tree = parse_tree_indirect(&oid);
> +	for (i = 0; i < count; i++) {
> +		if (fresh)
> +			cache_tree_free(&the_index.cache_tree);
> +
> +		if (!argc)

What if argc > 1?

> +			die("Must specify subcommand");

I think it would be nice to show usage here ...

> +		else if (!strcmp(argv[0], "prime"))
> +			prime_cache_tree(the_repository, &the_index, tree);
> +		else if (!strcmp(argv[0], "update"))
> +			cache_tree_update(&the_index, WRITE_TREE_SILENT | WRITE_TREE_REPAIR);
> +		else
> +			die("Unknown command %s", argv[0]);

... and here as well.

> +	}
> +
> +	return 0;
> +}
