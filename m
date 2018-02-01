Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A19291FAE2
	for <e@80x24.org>; Thu,  1 Feb 2018 22:23:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751853AbeBAWXG (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Feb 2018 17:23:06 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:37460 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751827AbeBAWXE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Feb 2018 17:23:04 -0500
Received: by mail-pl0-f68.google.com with SMTP id ay8so4625858plb.4
        for <git@vger.kernel.org>; Thu, 01 Feb 2018 14:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oO73NCI4uDffqjWcWY9lUZ7uungV0+EG3d+OX+dAd8A=;
        b=pWtkRWlpQaziOsFva4q/fgCCDC1ri1sfTnlC5hiMKgbpcCLZGBdZNrpOhQT7lG1r5w
         kBjNdmsW15pgG4DTG9eaf7Mr2YH//UAoh1cBQ8pbqHLVRsiYNqm4t7QLf+RzppgUfiZ+
         OQh7SrINRb1dSAJAj0vZorHxAD1Igyk7yHobsIid8OtAS/IXYE57f9D+F/YzenXQnOc7
         NspZdLEwqq7loVAOKuTwyHxrZcMOoUBpJQvFEoKwsJZxwmfckZteMgDTXYA80SPW1CeY
         QufPOStxSU1lg0JB7j+YNDnWqyIddrj81+8UlEceKib2CipnRgrri5If/D05cqDErmMG
         xELg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oO73NCI4uDffqjWcWY9lUZ7uungV0+EG3d+OX+dAd8A=;
        b=EjI0d7eHYYd55n6evrqDOJyObGQo30cqa4wCloijSi9jUxKsT8kUA8EyhvLX6ho748
         zwWOFf/BUCrcTAGPia25yxSj1Jdal3qC6rJBeuZ6eia9W1jvZYCBuU1vXm9qkqaR1CSu
         gpYbM7fkJphUBEDjRSCelJOVEWJtD5CvxTyMfyoCRYFyZ43KvTMrdCCyFc+6bodBKDEo
         J6vGuQBeW/5SzdAswxsiQTKkZuVGBXO1FeedX/3TmYk91LBmZTuOPII4kOmDzS0LRPdr
         vBScfhdJM1rl8mNCFmUUsCegr7PmfSNiEOIgW6wXSyu4+k+AqE+2B9Gewb0kB6Cn7WDF
         64Ig==
X-Gm-Message-State: AKwxytfRVMuJmInzZ1URmHB+UyTZKo48YRiDoIjVTE8UQX2Y7S3+fPpw
        DI4hzzY2WOQwOYcCS+lCJS5VkPRASOo=
X-Google-Smtp-Source: AH8x226xyVvlW0MZQqXSjcPgqWqG5dpSRY86FXKqhU1x8JZR79D8wc0nrTNzhtvFUy2EASRc8f8Ikg==
X-Received: by 2002:a17:902:d81:: with SMTP id 1-v6mr33881440plv.270.1517523783546;
        Thu, 01 Feb 2018 14:23:03 -0800 (PST)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id u86sm618232pfa.102.2018.02.01.14.23.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Feb 2018 14:23:02 -0800 (PST)
Date:   Thu, 1 Feb 2018 14:23:02 -0800
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        git@jeffhostetler.com, sbeller@google.com, dstolee@microsoft.com
Subject: Re: [PATCH v2 04/14] commit-graph: implement
 construct_commit_graph()
Message-Id: <20180201142302.02182cee02d4e44134a1be50@google.com>
In-Reply-To: <1517348383-112294-5-git-send-email-dstolee@microsoft.com>
References: <1517348383-112294-1-git-send-email-dstolee@microsoft.com>
        <1517348383-112294-5-git-send-email-dstolee@microsoft.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 30 Jan 2018 16:39:33 -0500
Derrick Stolee <stolee@gmail.com> wrote:

> +#define GRAPH_SIGNATURE 0x43475048 /* "CGPH" */
> +#define GRAPH_CHUNKID_OIDFANOUT 0x4f494446 /* "OIDF" */
> +#define GRAPH_CHUNKID_OIDLOOKUP 0x4f49444c /* "OIDL" */
> +#define GRAPH_CHUNKID_DATA 0x43444154 /* "CDAT" */
> +#define GRAPH_CHUNKID_LARGEEDGES 0x45444745 /* "EDGE" */

Could all these just be string constants? sha1write can handle them well
enough.

> +static void write_graph_chunk_fanout(struct sha1file *f,
> +				     struct commit **commits,
> +				     int nr_commits)
> +{
> +	uint32_t i, count = 0;
> +	struct commit **list = commits;
> +	struct commit **last = commits + nr_commits;
> +
> +	/*
> +	 * Write the first-level table (the list is sorted,
> +	 * but we use a 256-entry lookup to be able to avoid
> +	 * having to do eight extra binary search iterations).
> +	 */
> +	for (i = 0; i < 256; i++) {
> +		uint32_t swap_count;
> +
> +		while (list < last) {
> +			if ((*list)->object.oid.hash[0] != i)
> +				break;
> +			count++;
> +			list++;
> +		}
> +
> +		swap_count = htonl(count);
> +		sha1write(f, &swap_count, 4);

You can use sha1write_be32() instead of swapping.

> +static void write_graph_chunk_large_edges(struct sha1file *f,
> +					  struct commit **commits,
> +					  int nr_commits)
> +{
> +	struct commit **list = commits;
> +	struct commit **last = commits + nr_commits;
> +	struct commit_list *parent;
> +
> +	while (list < last) {
> +		int num_parents = 0;
> +		for (parent = (*list)->parents; num_parents < 3 && parent;
> +		     parent = parent->next)
> +			num_parents++;
> +
> +		if (num_parents <= 2) {
> +			list++;
> +			continue;
> +		}
> +
> +		for (parent = (*list)->parents; parent; parent = parent->next) {
> +			uint32_t int_id, swap_int_id;
> +			uint32_t last_edge = 0;
> +
> +			if (parent == (*list)->parents)
> +				continue;

Probably better to just initialize "parent = (*list)->parents->next".
Also probably best to add a comment describing why you are doing this
(e.g. "The first parent is already in the main commit table; the large
edges table only contains the second parent onwards").

> +struct packed_commit_list {
> +	struct commit **list;
> +	int num;
> +	int size;
> +};
> +
> +struct packed_oid_list {
> +	struct object_id **list;
> +	int num;
> +	int size;
> +};

What are num and size? If they're nr and alloc, maybe use those names
instead.

> +static int if_packed_commit_add_to_list(const struct object_id *oid,
> +					struct packed_git *pack,
> +					uint32_t pos,
> +					void *data)
> +{
> +	struct packed_oid_list *list = (struct packed_oid_list*)data;
> +	enum object_type type;
> +	unsigned long size;
> +	void *inner_data;
> +	off_t offset = nth_packed_object_offset(pack, pos);
> +	inner_data = unpack_entry(pack, offset, &type, &size);
> +
> +	if (inner_data)
> +		free(inner_data);
> +
> +	if (type != OBJ_COMMIT)
> +		return 0;
> +
> +	ALLOC_GROW(list->list, list->num + 1, list->size);
> +	list->list[list->num] = (struct object_id *)malloc(sizeof(struct object_id));

No need to cast return value of malloc. Also, use xmalloc?

> +struct object_id *construct_commit_graph(const char *pack_dir)
> +{
> +	struct packed_oid_list oids;
> +	struct packed_commit_list commits;
> +	struct commit_graph_header hdr;
> +	struct sha1file *f;
> +	int i, count_distinct = 0;
> +	struct strbuf tmp_file = STRBUF_INIT;
> +	unsigned char final_hash[GIT_MAX_RAWSZ];
> +	char *graph_name;
> +	int fd;
> +	uint32_t chunk_ids[5];
> +	uint64_t chunk_offsets[5];
> +	int num_long_edges;
> +	struct object_id *f_hash;
> +	char *fname;
> +	struct commit_list *parent;
> +
> +	oids.num = 0;
> +	oids.size = 1024;
> +	ALLOC_ARRAY(oids.list, oids.size);
> +	for_each_packed_object(if_packed_commit_add_to_list, &oids, 0);
> +	QSORT(oids.list, oids.num, commit_compare);
> +
> +	count_distinct = 1;
> +	for (i = 1; i < oids.num; i++) {
> +		if (oidcmp(oids.list[i-1], oids.list[i]))
> +			count_distinct++;
> +	}
> +
> +	commits.num = 0;
> +	commits.size = count_distinct;
> +	ALLOC_ARRAY(commits.list, commits.size);
> +
> +	num_long_edges = 0;
> +	for (i = 0; i < oids.num; i++) {
> +		int num_parents = 0;
> +		if (i > 0 && !oidcmp(oids.list[i-1], oids.list[i]))
> +			continue;
> +
> +		commits.list[commits.num] = lookup_commit(oids.list[i]);
> +		parse_commit(commits.list[commits.num]);
> +
> +		for (parent = commits.list[commits.num]->parents;
> +		     parent; parent = parent->next)
> +			num_parents++;
> +
> +		if (num_parents > 2)
> +			num_long_edges += num_parents - 1;
> +
> +		commits.num++;
> +	}
> +
> +	strbuf_addstr(&tmp_file, pack_dir);
> +	strbuf_addstr(&tmp_file, "/tmp_graph_XXXXXX");
> +
> +	fd = git_mkstemp_mode(tmp_file.buf, 0444);
> +	if (fd < 0)
> +		die_errno("unable to create '%s'", tmp_file.buf);
> +
> +	graph_name = strbuf_detach(&tmp_file, NULL);
> +	f = sha1fd(fd, graph_name);
> +
> +	hdr.graph_signature = htonl(GRAPH_SIGNATURE);
> +	hdr.graph_version = GRAPH_VERSION;
> +	hdr.hash_version = GRAPH_OID_VERSION;
> +	hdr.hash_len = GRAPH_OID_LEN;
> +	hdr.num_chunks = 4;
> +
> +	assert(sizeof(hdr) == 8);
> +	sha1write(f, &hdr, sizeof(hdr));

Instead of assembling these into a data structure, could you just use
individual calls to sha1write_be32 and sha1write_u8? Same comment
throughout this function.

> diff --git a/commit-graph.h b/commit-graph.h
> new file mode 100644
> index 0000000000..7b3469a7df
> --- /dev/null
> +++ b/commit-graph.h
> @@ -0,0 +1,20 @@
> +#ifndef COMMIT_GRAPH_H
> +#define COMMIT_GRAPH_H
> +
> +#include "git-compat-util.h"
> +#include "commit.h"
> +
> +extern char* get_commit_graph_filename_hash(const char *pack_dir,
> +					    struct object_id *hash);
> +
> +struct commit_graph_header {
> +	uint32_t graph_signature;
> +	unsigned char graph_version;
> +	unsigned char hash_version;
> +	unsigned char hash_len;
> +	unsigned char num_chunks;
> +};

This seems like it should be an internal detail of commit-graph.c.
(Also, as commented above, this struct might not be necessary at all.)
