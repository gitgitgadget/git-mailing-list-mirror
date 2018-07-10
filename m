Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27A4C1F85A
	for <e@80x24.org>; Tue, 10 Jul 2018 11:53:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753072AbeGJLxv (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jul 2018 07:53:51 -0400
Received: from mail-ed1-f50.google.com ([209.85.208.50]:35903 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751715AbeGJLxu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jul 2018 07:53:50 -0400
Received: by mail-ed1-f50.google.com with SMTP id t3-v6so16352360eds.3
        for <git@vger.kernel.org>; Tue, 10 Jul 2018 04:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k5Kq99yeBHbwe6bQ6HauASqwu+7LzGdgbMck9DQOaVU=;
        b=WrYhjqJ2N4k8XA4L0nPWPDmrSXsGXxylbdKtvXGkymThmarH3fFKiEKmAhUsQ7oTtK
         KBDZvOqntHRL/8HdCSEgnmaAm9x8ln5dYeeHW/Matom/87erPBsYvYIHk43ym2ZkmSLl
         u6i+/oce+eibNUQSoQoBJY1HaBw6HxQdIbf7hc4h4dEY6lED0ZEF4SbF8PmNGViULdXp
         efIFCzYSLfpE5gpZ6av+PA36pjg6YkmOURP4fiE5zb5Tcz5lJDuc+5QIFoCT670dbkL2
         pm9LJkDOH+nIChI9nC01wxl9muyDVUDVhc76UnXqnw7GLkT6pQdYccRFQV/XabPnZOYz
         WRxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k5Kq99yeBHbwe6bQ6HauASqwu+7LzGdgbMck9DQOaVU=;
        b=G1NFUwIiDomOOikQE1Y3J9ti8GcanFg0dsWxijctBlwSRSvldrALS8+ODz/T77qZYw
         chyl7eHBEO7zmbPPQx4qsBBH5UyhLR6NCbUaKVt5GrXg84L+eCJydTVVBJPnnrPY+At6
         YiaBt/tsMkkkLzpIrHlhjsYldFsm8thNB1eXsMzamPl9IaY9BZ9Nnh5NAVe1FgRDuNQI
         Sn6u0J9qu+OpenC8Wd1oVQLbXye99NJmFar4WS5kelQW2MhmBhA+u2VjLlN7mvI9oAfK
         SI/I5ioOq0GGfYTqbEvZybMR+psQyxuhPrOBcmWvANrf0pdPZ/zrW2X8ACDCXjMczwCd
         sbRw==
X-Gm-Message-State: APt69E1DeiQplEKDiwItGtV05ehaOKNyTVzO6pdM1bLZl+PZWiI2O3u6
        K8i6V13+M4+VoKKNJikTqVQ=
X-Google-Smtp-Source: AAOMgpfqjJVuiOQvZ0IUUo/33OIhN7aR+ntvryPCgNN97EA2yLkl8Ea/7n2Ft0+NkbQiqvFfncxi3w==
X-Received: by 2002:a50:ec0b:: with SMTP id g11-v6mr22820132edr.38.1531223629266;
        Tue, 10 Jul 2018 04:53:49 -0700 (PDT)
Received: from localhost.localdomain (x4db10d5d.dyn.telefonica.de. [77.177.13.93])
        by smtp.gmail.com with ESMTPSA id e2-v6sm4207272edn.11.2018.07.10.04.53.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 10 Jul 2018 04:53:48 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 6/6] commit-graph: add repo arg to graph readers
Date:   Tue, 10 Jul 2018 13:53:44 +0200
Message-Id: <20180710115344.14392-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.18.0.273.g57f1ecce9c
In-Reply-To: <f1ccfdccc851039cf62978d162cd9de99ea619de.1531168854.git.jonathantanmy@google.com>
References: <cover.1529616356.git.jonathantanmy@google.com> <cover.1531168854.git.jonathantanmy@google.com> <f1ccfdccc851039cf62978d162cd9de99ea619de.1531168854.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> diff --git a/t/helper/test-repository.c b/t/helper/test-repository.c
> new file mode 100644
> index 0000000000..5fff540a26
> --- /dev/null
> +++ b/t/helper/test-repository.c
> @@ -0,0 +1,88 @@
> +#include "test-tool.h"
> +#include "cache.h"
> +#include "commit-graph.h"
> +#include "commit.h"
> +#include "config.h"
> +#include "object-store.h"
> +#include "object.h"
> +#include "repository.h"
> +#include "tree.h"
> +
> +static void test_parse_commit_in_graph(const char *gitdir, const char *worktree,
> +				       const struct object_id *commit_oid)
> +{
> +	struct repository r;
> +	struct commit *c;
> +	struct commit_list *parent;
> +
> +	/*
> +	 * Create a commit independent of any repository.
> +	 */
> +	c = lookup_commit(commit_oid);
> +
> +	repo_init(&r, gitdir, worktree);
> +
> +	if (!parse_commit_in_graph(&r, c))
> +		die("Couldn't parse commit");
> +
> +	printf("%lu", c->date);

32-bit builds complain about this:

  t/helper/test-repository.c: In function 'test_parse_commit_in_graph':
  t/helper/test-repository.c:28:9: error: format '%lu' expects argument of type 'long unsigned int', but argument 2 has type 'timestamp_t {aka long long unsigned int}' [-Werror=format=]
    printf("%lu", c->date);
         ^
  cc1: all warnings being treated as errors
  Makefile:2262: recipe for target 't/helper/test-repository.o' failed
  make: *** [t/helper/test-repository.o] Error 1

> +	for (parent = c->parents; parent; parent = parent->next)
> +		printf(" %s", oid_to_hex(&parent->item->object.oid));
> +	printf("\n");
> +
> +	repo_clear(&r);
> +}
