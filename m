Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 29DAF1F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 12:49:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728372AbeJKUQb (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 16:16:31 -0400
Received: from mail-qt1-f174.google.com ([209.85.160.174]:33512 "EHLO
        mail-qt1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbeJKUQb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 16:16:31 -0400
Received: by mail-qt1-f174.google.com with SMTP id q40-v6so9634265qte.0
        for <git@vger.kernel.org>; Thu, 11 Oct 2018 05:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=7ebTjkY9hEc9xHh0GvEEzO0xDxF9rvXNuSfJpsRujsg=;
        b=eBZ5vYGL2hIrounIhmEz3Du+8aXjJmPjO/c6y3ekQXS//EaovbBu7ttay0oJR8keN3
         7Wwku1zd2ni2PgGbpWPSdRXoioLAZliA/somcHCfmeDST6jJGKZ2Y4jab4YiPdaUzMr2
         ozsfv7ZU40L9kYypvoYQalIQZ/2bHo59Mi4QrivqMNT85F7Fi/ipmuXJa0oIk7f6/wWu
         NsImuYGvWDnKnjXyDm1aAWlBsbokiPdm/zrimM/vwdi761jJSumnX4LRIaJJ9f+QLJRU
         INvl702sYH1ePWmiA6y3yX53D9ScTYmwsjs7Wqq6XDRMHq77jVNQGAhc47UG/tIYBsDk
         6uIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=7ebTjkY9hEc9xHh0GvEEzO0xDxF9rvXNuSfJpsRujsg=;
        b=RrmIDVQ4nx40TfCbxv1TOWxxVUnm/yA2N3xVEfpHr33PRMvchBQtVrtlliFIyeCrKK
         xieg8aCYBns7PC7SBwop7yL0GaTcHXhzo+klNH91uEoPHMQjQJkvabSmc7BqWgvV2g9A
         +KZvqA45IOBr7VrcSnJVkbAL7fKNcq8bBQiMKAuqadxyJ7f+qHRUGUJZ4S7nOuWgdPTr
         Hsa6tXozAtuGksY7VWshm+3lKdL3wvSTfDbs069GbyhMFBSbtCAp7ioKzbBfUIRroZvW
         /gtqarxi3BCmH5ffXQwgDKpoouSmC60B/rOBPZAs+5g0766dp9JZoBDYsVMfmxjhvx1U
         Tl0Q==
X-Gm-Message-State: ABuFfoidHyAS1P8cscZnNYtKKTvKrVT2YQwWiz89eIDkduKQ4NbYrGhA
        FWe9iSWg3EMJNl0rjkSdR6M=
X-Google-Smtp-Source: ACcGV63JE1J2qQGEFgjQC3orZlrrJDtTlcrP4L70J7vUhBlEOrX2z/7lG8ufJgvwnW/r7MMKbRyN0A==
X-Received: by 2002:a0c:f042:: with SMTP id b2-v6mr1328760qvl.232.1539262167353;
        Thu, 11 Oct 2018 05:49:27 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:60fa:c2a9:b517:a087? ([2001:4898:8010:0:4a30:c2a9:b517:a087])
        by smtp.gmail.com with ESMTPSA id c8-v6sm10302008qkb.81.2018.10.11.05.49.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Oct 2018 05:49:26 -0700 (PDT)
Subject: Re: [PATCH 1/2] One filter per commit
To:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Cc:     peff@peff.net, avarab@gmail.com, szeder.dev@gmail.com
References: <20181009193445.21908-1-szeder.dev@gmail.com>
 <cover.1539219248.git.jonathantanmy@google.com>
 <ebf0a811be047e9fd24b61fea3c4a164b3d18dc0.1539219248.git.jonathantanmy@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <2f49b953-4e07-0eb6-05b8-90d2eb72994b@gmail.com>
Date:   Thu, 11 Oct 2018 08:49:24 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <ebf0a811be047e9fd24b61fea3c4a164b3d18dc0.1539219248.git.jonathantanmy@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/10/2018 9:21 PM, Jonathan Tan wrote:
> diff --git a/commit-graph.c b/commit-graph.c
> index f415d3b41f..90b0b3df90 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -715,13 +715,11 @@ static int add_ref_to_list(const char *refname,
>   static void add_changes_to_bloom_filter(struct bloom_filter *bf,
>   					struct commit *parent,
>   					struct commit *commit,
> +					int index,
>   					struct diff_options *diffopt)
>   {
> -	unsigned char p_c_hash[GIT_MAX_RAWSZ];
>   	int i;
>   
> -	hashxor(parent->object.oid.hash, commit->object.oid.hash, p_c_hash);
> -
>   	diff_tree_oid(&parent->object.oid, &commit->object.oid, "", diffopt);
>   	diffcore_std(diffopt);
>   
> @@ -756,8 +754,8 @@ static void add_changes_to_bloom_filter(struct bloom_filter *bf,
>   			the_hash_algo->update_fn(&ctx, path, p - path);
>   			the_hash_algo->final_fn(name_hash, &ctx);
>   
> -			hashxor(name_hash, p_c_hash, hash);
> -			bloom_filter_add_hash(bf, hash);
> +			hashxor(name_hash, parent->object.oid.hash, hash);
> +			bloom_filter_add_hash(bf, index, hash);
>   		} while (*p);
>   
>   		diff_free_filepair(diff_queued_diff.queue[i]);
[snip]
> @@ -768,11 +766,10 @@ static void add_changes_to_bloom_filter(struct bloom_filter *bf,
>   }
>   
>   static void fill_bloom_filter(struct bloom_filter *bf,
> -				    struct progress *progress)
> +				    struct progress *progress, struct commit **commits, int commit_nr)
>   {
>   	struct rev_info revs;
>   	const char *revs_argv[] = {NULL, "--all", NULL};
> -	struct commit *commit;
>   	int i = 0;
>   
>   	/* We (re-)create the bloom filter from scratch every time for now. */
> @@ -783,18 +780,19 @@ static void fill_bloom_filter(struct bloom_filter *bf,
>   	if (prepare_revision_walk(&revs))
>   		die("revision walk setup failed while preparing bloom filter");
>   
> -	while ((commit = get_revision(&revs))) {
> +	for (i = 0; i < commit_nr; i++) {
> +		struct commit *commit = commits[i];
>   		struct commit_list *parent;
>   
>   		for (parent = commit->parents; parent; parent = parent->next)
> -			add_changes_to_bloom_filter(bf, parent->item, commit,
> +			add_changes_to_bloom_filter(bf, parent->item, commit, i,
>   						    &revs.diffopt);
>   
[snip]
>   
> -		hashxor(pi->name_hash, p_c_hash, hash);
> -		if (bloom_filter_check_hash(&bf, hash)) {
> +		hashxor(pi->name_hash, parent->object.oid.hash, hash);
> +		if (bloom_filter_check_hash(&bf, commit->graph_pos, hash)) {
>   			/*
>   			 * At least one of the interesting pathspecs differs,
>   			 * so we can return early and let the diff machinery
One main benefit of storing on Bloom filter per commit is to avoid 
recomputing hashes at every commit. Currently, this patch only improves 
locality when checking membership at the cost of taking up more space. 
Drop the dependence on the parent oid and then we can save the time 
spent hashing during history queries.

-Stolee
