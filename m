Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E59F61F453
	for <e@80x24.org>; Wed,  3 Oct 2018 23:08:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbeJDF6r (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Oct 2018 01:58:47 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:33175 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726198AbeJDF6r (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Oct 2018 01:58:47 -0400
Received: by mail-ot1-f67.google.com with SMTP id q50so3162241otd.0
        for <git@vger.kernel.org>; Wed, 03 Oct 2018 16:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ylzAUGveaHfl0YKzHQvFq9pFMPOEhoFgKQKtYnaGKVo=;
        b=bcHdVhTESp2En4ip5METlQys8ff7+SVgoTx2dHMsMQXWsRspeQEEUTIyaLfdYol/V1
         AG4TBECFugZqW562j7OUuecWdjwEhzo4RIHcdw0kXcNnmYif5wzn05AMJ8l2zI8aXNvf
         c+Ygbfp0NOdNvoSOiURHrlMp3rqeX2Y+LStYFXtxSdzkKsgo+zS8mMqxNzJu0o9oMO3c
         OWq3NQA2VKglI2S0o6VkkTRZ9tZbX/bNsKaBgxOFVfIlEJwYxgG9b/p2LaZ0J2RhgY1e
         5NHovZjeV6c+PmfQS0gvvnmCdErV5ipNb64aH/rUMelDhIJKZtqO2JBBFAu4wGg16WhU
         nuUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ylzAUGveaHfl0YKzHQvFq9pFMPOEhoFgKQKtYnaGKVo=;
        b=J18VfRIMgvjUK3c5lHEUpRke78kaHAIeRKceQtxKFzhVYIy10b//BTe2S64KjBI5Sp
         P7n0mIeD5D7aI07UahQ9IfL/fYF+jqxTHSg2VcJf4ODqwQRDb2OaF7pBl7W+aDpscibT
         FdrygeXU+LXjg8oiuqENiJVcR04lkynjnFIp9cMuDNgaKHCeW5cMYMf3Y3QhkACtsDaK
         wo1VA1cfSl2L3N5MAIFYYw39NA+YNWIdML7hU3Ccop5/JaJ+RkMIMqHndOJcdOEivvZ6
         JSuyhf+xxUPb/wklqFo6bycVf4mv4Xk5OaHgRcJz9k/yl6ibRe5T5sp1EOoOqX+BPDRF
         nEJQ==
X-Gm-Message-State: ABuFfogyGz6Pj38ugGiYUsvRVkmdsA05aIiai1qBmJfB1M0TnqR9EKWC
        CH+0EVIvuq2y36rHQo4ByNmPlZRb+vz4FgDG/RdNCtqb9aWP
X-Google-Smtp-Source: ACcGV62Gff4apUoeTRVakU4ntNSB3iN1Fh+d1Vfu2L10Wg0Tch+fSoLYz6yH2sVdT6nso00CqUm9MS+QEO4ULqTbRJo=
X-Received: by 2002:a9d:3ea5:: with SMTP id b34-v6mr1996139otc.341.1538608098898;
 Wed, 03 Oct 2018 16:08:18 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1533854545.git.matvore@google.com> <cover.1538592829.git.matvore@google.com>
In-Reply-To: <cover.1538592829.git.matvore@google.com>
From:   Matthew DeVore <matvore@google.com>
Date:   Wed, 3 Oct 2018 16:08:06 -0700
Message-ID: <CAMfpvhLmXyk5MKoe=zC_sVgURwcxLBWL3zZWkrncGeL0FcyQDQ@mail.gmail.com>
Subject: Re: [PATCH v10 0/8] filter: support for excluding all trees and blobs
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>, git@jeffhostetler.com,
        jeffhost@microsoft.com, Jeff King <peff@peff.net>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>, pclouds@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 3, 2018 at 12:52 PM Matthew DeVore <matvore@google.com> wrote:
>
> This is a minor change to the previous rollup. It moves positional
> arguments to the end of git-rev-list invocations. Here is an interdiff
> from v9:
...
There is another problem with this patchset related to dropped exit
codes and pipelines. In t6112, we run "git cat-file -t" on an object
with was rm'd without being promised. It was printing an error and
going undetected because it was upstream in a pipeline. The file was
removed in the previous test.

So I fixed the previous test to clone the repository before
manipulating it, and I fixed the latter test to not mask Git exit
codes :) (This is a really insidious pattern and I should have taken
it more seriously.) Below is an interdiff. The two tests are added in
different commits, so each commit had to be fixed up.

I'll send a re-roll in two days or so if there are no more comments.

diff --git a/t/t6112-rev-list-filters-objects.sh
b/t/t6112-rev-list-filters-objects.sh
index 5a61614b1..c8e3d87c4 100755
--- a/t/t6112-rev-list-filters-objects.sh
+++ b/t/t6112-rev-list-filters-objects.sh
@@ -210,16 +210,21 @@ test_expect_success 'verify sparse:oid=oid-ish
omits top-level files' '
 test_expect_success 'rev-list W/ --missing=print and
--missing=allow-any for trees' '
         TREE=$(git -C r3 rev-parse HEAD:dir1) &&

-        rm r3/.git/objects/$(echo $TREE | sed "s|^..|&/|") &&
+        # Create a spare repo because we will be deleting objects
from this one.
+        git clone r3 r3.b &&

-        git -C r3 rev-list --quiet --missing=print --objects HEAD
>missing_objs 2>rev_list_err &&
+        rm r3.b/.git/objects/$(echo $TREE | sed "s|^..|&/|") &&
+
+        git -C r3.b rev-list --quiet --missing=print --objects HEAD \
+                >missing_objs 2>rev_list_err &&
         echo "?$TREE" >expected &&
         test_cmp expected missing_objs &&

         # do not complain when a missing tree cannot be parsed
         test_must_be_empty rev_list_err &&

-        git -C r3 rev-list --missing=allow-any --objects HEAD >objs
2>rev_list_err &&
+        git -C r3.b rev-list --missing=allow-any --objects HEAD \
+                >objs 2>rev_list_err &&
         ! grep $TREE objs &&
         test_must_be_empty rev_list_err
 '
@@ -228,12 +233,13 @@ test_expect_success 'rev-list W/ --missing=print
and --missing=allow-any for tre

 test_expect_success 'verify tree:0 includes trees in "filtered" output' '
         git -C r3 rev-list --quiet --objects --filter-print-omitted \
-                --filter=tree:0 HEAD |
-        awk -f print_1.awk |
+                --filter=tree:0 HEAD >revs &&
+
+        awk -f print_1.awk revs |
         sed s/~// |
-        xargs -n1 git -C r3 cat-file -t |
-        sort -u >filtered_types &&
+        xargs -n1 git -C r3 cat-file -t >unsorted_filtered_types &&

+        sort -u unsorted_filtered_types >filtered_types &&
         printf "blob\ntree\n" >expected &&
         test_cmp expected filtered_types
 '
