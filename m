Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C2F3F211B4
	for <e@80x24.org>; Fri, 11 Jan 2019 22:30:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725777AbfAKWak (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Jan 2019 17:30:40 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55865 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbfAKWak (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jan 2019 17:30:40 -0500
Received: by mail-wm1-f66.google.com with SMTP id y139so3757626wmc.5
        for <git@vger.kernel.org>; Fri, 11 Jan 2019 14:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=+oL1YEZsnptkr6mX8YfDyINRORRGQKBEvR8BbeVrYDk=;
        b=FCrwILBUFamRih6Yth2YuHv8mveKFLCMO6IQ3f698kDoG1azn6NPjKO6BWIoUVx88V
         YfVWGXTPUTe00LSIsEfi+UB7tLm0RT+E7M2/Xw5+vxeCe4W0qKnatgWTeTY7HYGnXfOT
         zlBr6HiqIZUj+o/ZK0BvXgNAj0ciiExmYJwYzHweZGx+QxWYx9LOwTEV3zao8MOH4ggQ
         m9tU9gpbP8BD0QgkahLkW/aOx3DHpLSVrBQBPDLYfJ5SLQAuSM3k1fQR+iwdiGx/Cj6O
         DpK3nlO7GL2s+VKhc4ed5gbGIL98nedoqfXBZVAdEQDaq/hmNvs0F+gyVN/H6K66qCnZ
         GQ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=+oL1YEZsnptkr6mX8YfDyINRORRGQKBEvR8BbeVrYDk=;
        b=uYYg0KyfwXRNzb8OWn1NAdwT9muNbaTFqC1lSfYmaKx3xRFX4LKVEUoNSKykFJlzBU
         0ltGvZ+ifCHPKuqnIKKRtuJnUC8AJkzF7UyapQx/XugsFO66ThidUVOrnLOk15gAHRRR
         /HEhOjRJAr8BGTW6Cdcynp7Qze9F27cGwfhkTZtS63BN5YUXnLPTnuozuFYufgM6E3hf
         174jLbhG2+zzQFLfsNMRyxxjCRnVE8dpwAQPF6Ee1aQLRU4/UthnF0vtAj4GhWp///yU
         mQfF4GQnsip/W4FS3BMT/ODchPnhZCmj2sWqBABe/zV1x787fmoXT0Ve4Z42VDRuxge9
         ACDw==
X-Gm-Message-State: AJcUuke8wH8k3c7jzCgwbn+zxhy0UpbZlMOCjwzsDO5QijYVCbfzPJ8A
        6gqGLj3OlOJztIdY0LWIUzM=
X-Google-Smtp-Source: ALg8bN7AYNF+dAqRy2EIzRBccCKzlUEd6mkp3EeuOnosOIFT8OCYSPy/HJHbd5b5rzPIlQK+QqLhmw==
X-Received: by 2002:a1c:a6c2:: with SMTP id p185mr3480211wme.133.1547245836975;
        Fri, 11 Jan 2019 14:30:36 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 67sm98795052wra.37.2019.01.11.14.30.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Jan 2019 14:30:36 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, avarab@gmail.com,
        jrnieder@gmail.com, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v4 3/6] pack-objects: add --sparse option
References: <pull.89.v3.git.gitgitgadget@gmail.com>
        <pull.89.v4.git.gitgitgadget@gmail.com>
        <ab733daff5398fd07ff051c323f51b70efbc2e57.1544822533.git.gitgitgadget@gmail.com>
Date:   Fri, 11 Jan 2019 14:30:35 -0800
In-Reply-To: <ab733daff5398fd07ff051c323f51b70efbc2e57.1544822533.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Fri, 14 Dec 2018
        13:22:19 -0800 (PST)")
Message-ID: <xmqqmuo6yghg.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <dstolee@microsoft.com>
>
> Add a '--sparse' option flag to the pack-objects builtin. This
> allows the user to specify that they want to use the new logic
> for walking trees. This logic currently does not differ from the
> existing output, but will in a later change.
>
> Create a new test script, t5322-pack-objects-sparse.sh, to ensure
> the object list that is selected matches what we expect. When we
> update the logic to walk in a sparse fashion, the final test will
> be updated to show the extra objects that are added.

Somehow checking the "these are exactly what we expect" feels
brittle.  In a history with three relevant commits A---B---C,
packing B..C could omit trees and blobs in C that appear in A but
not in B, but traditionally, because we stop traversal at B and do
not even look at A, we do not notice that such objects that need to
complete C's tree are already available in a repository that has B.
The approach of test in this patch feels similar to saying "we must
send these duplicates because we must stay dumb", even though with a
perfect knowledge about the history, e.g. bitmap, we would be able
to omit these objects in A that appear in C but not in B.

I think we want to test test both "are we sending enough, even
though we might be wasting some bandwidth by not noticing the other
side already have some?" and "are we still avoiding from becoming
overly stupid, even though we may be cheating to save traversal cost
and risking to redundantly send some objects?"

IOW, a set of tests to make sure that truly new objects are all sent
by seeing what is sent is a strict superset of what we expect.  And
another set of tests to make sure that objects that are so obviously
(this criterion may be highly subjective) be present in the
receiving repository (e.g. the tree object of commit B and what it
contains when seinding B..C) are never sent, even when using an
algorithm that are tuned for traversal cost over bandwidth
consumption.

The code change in this step looks all trivially good, and it may
want to be squashed into the previous step to become a single patch.
Otherwise, [2/6] would be adding a dead code that nobody exercises
until this step.

Thanks.


> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  Documentation/git-pack-objects.txt |  11 ++-
>  builtin/pack-objects.c             |   5 +-
>  t/t5322-pack-objects-sparse.sh     | 115 +++++++++++++++++++++++++++++
>  3 files changed, 129 insertions(+), 2 deletions(-)
>  create mode 100755 t/t5322-pack-objects-sparse.sh
>
> diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
> index 40c825c381..e45f3e680d 100644
> --- a/Documentation/git-pack-objects.txt
> +++ b/Documentation/git-pack-objects.txt
> @@ -14,7 +14,7 @@ SYNOPSIS
>  	[--local] [--incremental] [--window=<n>] [--depth=<n>]
>  	[--revs [--unpacked | --all]] [--keep-pack=<pack-name>]
>  	[--stdout [--filter=<filter-spec>] | base-name]
> -	[--shallow] [--keep-true-parents] < object-list
> +	[--shallow] [--keep-true-parents] [--sparse] < object-list
>  
>  
>  DESCRIPTION
> @@ -196,6 +196,15 @@ depth is 4095.
>  	Add --no-reuse-object if you want to force a uniform compression
>  	level on all data no matter the source.
>  
> +--sparse::
> +	Use the "sparse" algorithm to determine which objects to include in
> +	the pack, when combined with the "--revs" option. This algorithm
> +	only walks trees that appear in paths that introduce new objects.
> +	This can have significant performance benefits when computing
> +	a pack to send a small change. However, it is possible that extra
> +	objects are added to the pack-file if the included commits contain
> +	certain types of direct renames.
> +
>  --thin::
>  	Create a "thin" pack by omitting the common objects between a
>  	sender and a receiver in order to reduce network transfer. This
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index 5f70d840a7..7d5b0735e3 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -84,6 +84,7 @@ static unsigned long pack_size_limit;
>  static int depth = 50;
>  static int delta_search_threads;
>  static int pack_to_stdout;
> +static int sparse;
>  static int thin;
>  static int num_preferred_base;
>  static struct progress *progress_state;
> @@ -3135,7 +3136,7 @@ static void get_object_list(int ac, const char **av)
>  
>  	if (prepare_revision_walk(&revs))
>  		die(_("revision walk setup failed"));
> -	mark_edges_uninteresting(&revs, show_edge, 0);
> +	mark_edges_uninteresting(&revs, show_edge, sparse);
>  
>  	if (!fn_show_object)
>  		fn_show_object = show_object;
> @@ -3292,6 +3293,8 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
>  		{ OPTION_CALLBACK, 0, "unpack-unreachable", NULL, N_("time"),
>  		  N_("unpack unreachable objects newer than <time>"),
>  		  PARSE_OPT_OPTARG, option_parse_unpack_unreachable },
> +		OPT_BOOL(0, "sparse", &sparse,
> +			 N_("use the sparse reachability algorithm")),
>  		OPT_BOOL(0, "thin", &thin,
>  			 N_("create thin packs")),
>  		OPT_BOOL(0, "shallow", &shallow,
> diff --git a/t/t5322-pack-objects-sparse.sh b/t/t5322-pack-objects-sparse.sh
> new file mode 100755
> index 0000000000..81f6805bc3
> --- /dev/null
> +++ b/t/t5322-pack-objects-sparse.sh
> @@ -0,0 +1,115 @@
> +#!/bin/sh
> +
> +test_description='pack-objects object selection using sparse algorithm'
> +. ./test-lib.sh
> +
> +test_expect_success 'setup repo' '
> +	test_commit initial &&
> +	for i in $(test_seq 1 3)
> +	do
> +		mkdir f$i &&
> +		for j in $(test_seq 1 3)
> +		do
> +			mkdir f$i/f$j &&
> +			echo $j >f$i/f$j/data.txt
> +		done
> +	done &&
> +	git add . &&
> +	git commit -m "Initialized trees" &&
> +	for i in $(test_seq 1 3)
> +	do
> +		git checkout -b topic$i master &&
> +		echo change-$i >f$i/f$i/data.txt &&
> +		git commit -a -m "Changed f$i/f$i/data.txt"
> +	done &&
> +	cat >packinput.txt <<-EOF &&
> +	topic1
> +	^topic2
> +	^topic3
> +	EOF
> +	git rev-parse			\
> +		topic1			\
> +		topic1^{tree}		\
> +		topic1:f1		\
> +		topic1:f1/f1		\
> +		topic1:f1/f1/data.txt | sort >expect_objects.txt
> +'
> +
> +test_expect_success 'non-sparse pack-objects' '
> +	git pack-objects --stdout --revs <packinput.txt >nonsparse.pack &&
> +	git index-pack -o nonsparse.idx nonsparse.pack &&
> +	git show-index <nonsparse.idx | awk "{print \$2}" >nonsparse_objects.txt &&
> +	test_cmp expect_objects.txt nonsparse_objects.txt
> +'
> +
> +test_expect_success 'sparse pack-objects' '
> +	git pack-objects --stdout --revs --sparse <packinput.txt >sparse.pack &&
> +	git index-pack -o sparse.idx sparse.pack &&
> +	git show-index <sparse.idx | awk "{print \$2}" >sparse_objects.txt &&
> +	test_cmp expect_objects.txt sparse_objects.txt
> +'
> +
> +# Demonstrate that both algorithms send "extra" objects because
> +# they are not in the frontier.
> +
> +test_expect_success 'duplicate a folder from f3 and commit to topic1' '
> +	git checkout topic1 &&
> +	echo change-3 >f3/f3/data.txt &&
> +	git commit -a -m "Changed f3/f3/data.txt" &&
> +	git rev-parse			\
> +		topic1~1		\
> +		topic1~1^{tree}		\
> +		topic1^{tree}		\
> +		topic1			\
> +		topic1:f1		\
> +		topic1:f1/f1		\
> +		topic1:f1/f1/data.txt	\
> +		topic1:f3		\
> +		topic1:f3/f3		\
> +		topic1:f3/f3/data.txt | sort >expect_objects.txt
> +'
> +
> +test_expect_success 'non-sparse pack-objects' '
> +	git pack-objects --stdout --revs <packinput.txt >nonsparse.pack &&
> +	git index-pack -o nonsparse.idx nonsparse.pack &&
> +	git show-index <nonsparse.idx | awk "{print \$2}" >nonsparse_objects.txt &&
> +	test_cmp expect_objects.txt nonsparse_objects.txt
> +'
> +
> +test_expect_success 'sparse pack-objects' '
> +	git pack-objects --stdout --revs --sparse <packinput.txt >sparse.pack &&
> +	git index-pack -o sparse.idx sparse.pack &&
> +	git show-index <sparse.idx | awk "{print \$2}" >sparse_objects.txt &&
> +	test_cmp expect_objects.txt sparse_objects.txt
> +'
> +
> +test_expect_success 'duplicate a folder from f1 into f3' '
> +	mkdir f3/f4 &&
> +	cp -r f1/f1/* f3/f4 &&
> +	git add f3/f4 &&
> +	git commit -m "Copied f1/f1 to f3/f4" &&
> +	cat >packinput.txt <<-EOF &&
> +	topic1
> +	^topic1~1
> +	EOF
> +	git rev-parse		\
> +		topic1		\
> +		topic1^{tree}	\
> +		topic1:f3 | sort >expect_objects.txt
> +'
> +
> +test_expect_success 'non-sparse pack-objects' '
> +	git pack-objects --stdout --revs <packinput.txt >nonsparse.pack &&
> +	git index-pack -o nonsparse.idx nonsparse.pack &&
> +	git show-index <nonsparse.idx | awk "{print \$2}" >nonsparse_objects.txt &&
> +	test_cmp expect_objects.txt nonsparse_objects.txt
> +'
> +
> +test_expect_success 'sparse pack-objects' '
> +	git pack-objects --stdout --revs --sparse <packinput.txt >sparse.pack &&
> +	git index-pack -o sparse.idx sparse.pack &&
> +	git show-index <sparse.idx | awk "{print \$2}" >sparse_objects.txt &&
> +	test_cmp expect_objects.txt sparse_objects.txt
> +'
> +
> +test_done
