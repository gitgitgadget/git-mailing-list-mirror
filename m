Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 958FB1F97E
	for <e@80x24.org>; Tue,  9 Oct 2018 19:03:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbeJJCVh (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Oct 2018 22:21:37 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:45022 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726445AbeJJCVh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Oct 2018 22:21:37 -0400
Received: by mail-qt1-f193.google.com with SMTP id c56-v6so2882208qtd.11
        for <git@vger.kernel.org>; Tue, 09 Oct 2018 12:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=U7mGv1uvjdTziil00JEgCQWt7KxpFGTZ2owBNNGjvrg=;
        b=dYB+HflgWMj+UA2Ebw5O+kAHLYiWk1QiezIAY8DNpYI9r+4EfyrfaSyfEjkx95e9z+
         f2zw7eBlZrBEYJ0AvvV7FXeH/Ck7iI5CMV4uMfN+JRBAvUazGhpM9lnxxlzR/Fnm9Vao
         iVtNM9YgW9L2ZbkZ067nkYbw1sYoQrq+l9AemeYuadOav942bOi0lrxt0AFyFhRqwD9x
         SIMNqxAG1dMRSA9nCtMWA2aKIAfsLR3YgsP2KPK86De1BsVVlLQG9vmIeHki9L/4m8vS
         l0YFeieKK1/KcKbVwRdSKzraBwz5XVfTNRXL8M6k8+xYrhkalo7MUcZEXQzl+w+BbA4b
         Z+xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=U7mGv1uvjdTziil00JEgCQWt7KxpFGTZ2owBNNGjvrg=;
        b=HfEOtTawgtPlv4dgpVS6MwN0YwjGLjAL9w+nnrZwrWHDY67IxMoOqcV38ptLZwMiQG
         pSmh4LANqLGwuNe3M1RRCLb0iQBxB5l2wEi2cix271XLSQ5qro6opLgga3eLnokr48Pb
         yXu/ipEd8IrKyEMoq8/QsYj73bim4jF/Z7oMplW4NjZt8dHWN/UX2D1PFVrNqGnsyf1W
         2x+dkHb96DqUm6dmaDp9fdWJhbZ6eI7QCZCUtnimCSF2r/8clN5JeEGMlUxNfUumRGnT
         76pxfUUJzyHjQWOkmjrUTBH9E3rA8lCj9JyHNh4K+ooyySQxaERw3Nk0zLPSoSDiM5hf
         EGUQ==
X-Gm-Message-State: ABuFfogIJUeiKLDcic7weR9xTmdi9kKyc+X197FK+tuIsociq3TJTljC
        CS0okQecmZeICpwdlwOzkkg=
X-Google-Smtp-Source: ACcGV62bphBXsElibzkhVbRqFMuHbSehpjbZw59OvAwDo0lg5UhpmtaFcYDhz7/Z+bTmreC1G3go/A==
X-Received: by 2002:aed:32e4:: with SMTP id z91-v6mr25075698qtd.106.1539111791857;
        Tue, 09 Oct 2018 12:03:11 -0700 (PDT)
Received: from [10.0.1.23] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id u11-v6sm11778790qtk.3.2018.10.09.12.03.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 12:03:10 -0700 (PDT)
Subject: Re: Bloom Filters (was Re: We should add a "git gc --auto" after "git
 clone" due to commit graph)
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>,
        Duy Nguyen <pclouds@gmail.com>
References: <87lg7ehnps.fsf@evledraar.gmail.com>
 <20181003185156.GA20709@sigill.intra.peff.net>
 <a300acae-c7f2-eace-5196-381a99d62c13@gmail.com>
 <20181003191805.GB16666@sigill.intra.peff.net>
 <20181008164141.GZ23446@szeder.dev>
 <a66afe22-0523-c785-91e6-bf545683c67d@gmail.com>
 <20181008181015.GA23446@szeder.dev>
 <9ad5f166-f7c5-de79-0f86-f1f952cd33d2@gmail.com>
 <20181009030803.GA6250@sigill.intra.peff.net>
 <f877020c-3098-e4c4-ad64-cca57f764b91@gmail.com>
 <20181009184647.GA7014@sigill.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <ec3ca377-0434-322e-4ab9-49e27f96f4af@gmail.com>
Date:   Tue, 9 Oct 2018 15:03:08 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181009184647.GA7014@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/9/2018 2:46 PM, Jeff King wrote:
> On Tue, Oct 09, 2018 at 09:48:20AM -0400, Derrick Stolee wrote:
>
>> [I snipped all of the parts about bloom filters that seemed entirely
>>   reasonable to me ;) ]
>>> Imagine we have that list. Is a bloom filter still the best data
>>> structure for each commit? At the point that we have the complete
>>> universe of paths, we could give each commit a bitmap of changed paths.
>>> That lets us ask "did this commit touch these paths" (collect the bits
>>> from the list of paths, then check for 1's), as well as "what paths did
>>> we touch" (collect the 1 bits, and then index the path list).  Those
>>> bitmaps should compress very well via EWAH or similar (most of them
>>> would be huge stretches of 0's punctuated by short runs of 1's).
>> I'm not convinced we would frequently have runs of 1's, and the bitmap would
>> not compress much better than simply listing the positions. For example, a
>> path "foo/bar" that resolves to a tree would only start a run if the next
>> changes are the initial section of entries in that tree (sorted
>> lexicographically) such as "foo/bar/a, foo/bar/b". If we deepen into a tree,
>> then we will break the run of 1's unless we changed every path deeper than
>> that tree.
> Yeah, I doubt we'd really have runs of 1's (by short, I just mean 1 or
> 2). I agree that listing the positions could work, though I sort of
> assumed that was more or less what a decent compressed bitmap would
> turn into. E.g., if bit N is set, we should be able to say "N-1
> zeroes, 1 one" in about the same size as we could say "position N".
>
> EWAH seems pretty awful in that regard. Or at least its serialized
> format is (or maybe it's our implementation that is bad).
>
> The patch below generates a bitmap for each commit in a repository (it
> doesn't output the total list of paths; I've left that as an exercise
> for the reader). On linux.git, the result is 57MB. But when I look at
> the individual bitmap sizes (via GIT_TRACE), they're quite silly.
> Storing a single set bit takes 28 bytes in serialized form!
>
> There are only around 120k unique paths (including prefix trees).
> Naively using run-length encoding and varints, our worst case should be
> something like 18-20 bits to say "120k zeroes, then a 1, then all
> zeroes".  And the average case should be better (you don't even need to
> say "120k", but some smaller number).
>
> I wonder if Roaring does better here.

In these sparse cases, usually Roaring will organize the data as "array 
chunks" which are simply lists of the values. The thing that makes this 
still compressible is that we store two bytes per entry, as the entries 
are grouped by a common most-significant two bytes. SInce you say ~120k 
unique paths, the Roaring bitmap would have two or three chunks per 
bitmap (and those chunks could be empty). The overhead to store the 
chunk positions, types, and lengths does come at a cost, but it's more 
like 32 bytes _per commit_.

> Gzipping the resulting bitmaps drops the total size to about 7.5MB.
> That's not a particularly important number, but I think it shows that
> the built-in ewah compression is far from ideal.
>
> Just listing the positions with a series of varints would generally be
> fine, since we expect sparse bitmaps. I just hoped that a good
> RLE scheme would degrade to roughly that for the sparse case, but also
> perform well for more dense cases.
>
> So at any rate, I do think it would not be out of the question to store
> bitmaps like this. I'm much more worried about the maintenance cost of
> adding new entries incrementally. I think it's only feasible if we give
> up sorting, and then I wonder what other problems that might cause.
The patch below gives me a starting point to try the Bloom filter 
approach and see what the numbers are like. You did all the "git" stuff 
like computing the changed paths, so thanks!
>
> -- >8 --
> diff --git a/Makefile b/Makefile
> index 13e1c52478..f6e823f2d6 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -751,6 +751,7 @@ TEST_PROGRAMS_NEED_X += test-parse-options
>   TEST_PROGRAMS_NEED_X += test-pkt-line
>   TEST_PROGRAMS_NEED_X += test-svn-fe
>   TEST_PROGRAMS_NEED_X += test-tool
> +TEST_PROGRAMS_NEED_X += test-tree-bitmap
>   
>   TEST_PROGRAMS = $(patsubst %,t/helper/%$X,$(TEST_PROGRAMS_NEED_X))
>   
> diff --git a/t/helper/test-tree-bitmap.c b/t/helper/test-tree-bitmap.c
> new file mode 100644
> index 0000000000..bc5cf0e514
> --- /dev/null
> +++ b/t/helper/test-tree-bitmap.c
> @@ -0,0 +1,167 @@
> +#include "cache.h"
> +#include "revision.h"
> +#include "diffcore.h"
> +#include "argv-array.h"
> +#include "ewah/ewok.h"
> +
> +/* map of pathnames to bit positions */
> +struct pathmap_entry {
> +	struct hashmap_entry ent;
> +	unsigned pos;
> +	char path[FLEX_ARRAY];
> +};
> +
> +static int pathmap_entry_hashcmp(const void *unused_cmp_data,
> +				 const void *entry,
> +				 const void *entry_or_key,
> +				 const void *keydata)
> +{
> +	const struct pathmap_entry *a = entry;
> +	const struct pathmap_entry *b = entry_or_key;
> +	const char *key = keydata;
> +
> +	return strcmp(a->path, key ? key : b->path);
> +}
> +
> +static int pathmap_entry_strcmp(const void *va, const void *vb)
> +{
> +	struct pathmap_entry *a = *(struct pathmap_entry **)va;
> +	struct pathmap_entry *b = *(struct pathmap_entry **)vb;
> +	return strcmp(a->path, b->path);
> +}
> +
> +struct walk_paths_data {
> +	struct hashmap *paths;
> +	struct commit *commit;
> +};
> +
> +static void walk_paths(diff_format_fn_t fn, struct hashmap *paths)
> +{
> +	struct argv_array argv = ARGV_ARRAY_INIT;
> +	struct rev_info revs;
> +	struct walk_paths_data data;
> +	struct commit *commit;
> +
> +	argv_array_pushl(&argv, "rev-list",
> +			 "--all", "-t", "--no-renames",
> +			 NULL);
> +	init_revisions(&revs, NULL);
> +	setup_revisions(argv.argc, argv.argv, &revs, NULL);
> +	revs.diffopt.output_format = DIFF_FORMAT_CALLBACK;
> +	revs.diffopt.format_callback = fn;
> +	revs.diffopt.format_callback_data = &data;
> +
> +	data.paths = paths;
> +
> +	prepare_revision_walk(&revs);
> +	while ((commit = get_revision(&revs))) {
> +		data.commit = commit;
> +		diff_tree_combined_merge(commit, 0, &revs);
> +	}
> +
> +	reset_revision_walk();
> +	argv_array_clear(&argv);
> +}
> +
> +static void collect_commit_paths(struct diff_queue_struct *q,
> +				 struct diff_options *opts,
> +				 void *vdata)
> +{
> +	struct walk_paths_data *data = vdata;
> +	int i;
> +
> +	for (i = 0; i < q->nr; i++) {
> +		struct diff_filepair *p = q->queue[i];
> +		const char *path = p->one->path;
> +		struct pathmap_entry *entry;
> +		struct hashmap_entry lookup;
> +
> +		hashmap_entry_init(&lookup, strhash(path));
> +		entry = hashmap_get(data->paths, &lookup, path);
> +		if (entry)
> +			continue; /* already present */
> +
> +		FLEX_ALLOC_STR(entry, path, path);
> +		entry->ent = lookup;
> +		hashmap_put(data->paths, entry);
> +	}
> +}
> +
> +/* assign a bit position to all possible paths */
> +static void collect_paths(struct hashmap *paths)
> +{
> +	struct pathmap_entry **sorted;
> +	size_t i, n;
> +	struct hashmap_iter iter;
> +	struct pathmap_entry *entry;
> +
> +	/* grab all unique paths */
> +	hashmap_init(paths, pathmap_entry_hashcmp, NULL, 0);
> +	walk_paths(collect_commit_paths, paths);
> +
> +	/* and assign them bits in sorted order */
> +	n = hashmap_get_size(paths);
> +	ALLOC_ARRAY(sorted, n);
> +	i = 0;
> +	for (entry = hashmap_iter_first(paths, &iter);
> +	     entry;
> +	     entry = hashmap_iter_next(&iter)) {
> +		assert(i < n);
> +		sorted[i++] = entry;
> +	}
> +	QSORT(sorted, i, pathmap_entry_strcmp);
> +	for (i = 0; i < n; i++)
> +		sorted[i]->pos = i;
> +	free(sorted);
> +}
> +
> +/* generate the bitmap for a single commit */
> +static void generate_bitmap(struct diff_queue_struct *q,
> +			    struct diff_options *opts,
> +			    void *vdata)
> +{
> +	struct walk_paths_data *data = vdata;
> +	struct bitmap *bitmap = bitmap_new();
> +	struct ewah_bitmap *ewah;
> +	struct strbuf out = STRBUF_INIT;
> +	size_t i;
> +
> +	for (i = 0; i < q->nr; i++) {
> +		struct diff_filepair *p = q->queue[i];
> +		const char *path = p->one->path;
> +		struct pathmap_entry *entry;
> +		struct hashmap_entry lookup;
> +
> +		hashmap_entry_init(&lookup, strhash(path));
> +		entry = hashmap_get(data->paths, &lookup, path);
> +		if (!entry)
> +			BUG("mysterious path appeared: %s", path);
> +
> +		bitmap_set(bitmap, entry->pos);
> +	}
> +
> +	ewah = bitmap_to_ewah(bitmap);
> +	ewah_serialize_strbuf(ewah, &out);
> +	fwrite(out.buf, 1, out.len, stdout);
> +
> +	trace_printf("bitmap %s %u %u",
> +		     oid_to_hex(&data->commit->object.oid),
> +		     (unsigned)q->nr,
> +		     (unsigned)out.len);
> +
> +	strbuf_release(&out);
> +	ewah_free(ewah);
> +	bitmap_free(bitmap);
> +}
> +
> +int cmd_main(int argc, const char **argv)
> +{
> +	struct hashmap paths;
> +
> +	setup_git_directory();
> +	collect_paths(&paths);
> +
> +	walk_paths(generate_bitmap, &paths);
> +
> +	return 0;
> +}
