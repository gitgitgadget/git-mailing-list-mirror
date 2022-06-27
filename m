Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE6F1C433EF
	for <git@archiver.kernel.org>; Mon, 27 Jun 2022 15:12:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237774AbiF0PMQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jun 2022 11:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237400AbiF0PMN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jun 2022 11:12:13 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B0713F27
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 08:12:11 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id be10so13233511oib.7
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 08:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=/d8FpUczMwWN5XPvC/++rsknSvh37C/1BM8v02LTBu4=;
        b=XGmWsBnbDQdeX6L6y+Oe5Ni2605D+fC0cJMgR5iqM9kJ6JPR+FRM2MAFZTA/asfDJU
         ODWFh1Ernn/+nJSmKrHqhu7ZXZQMPFNrXD3Qwin5hLlg0KmeGMh7nB97awMyivEw6DwG
         R8qr5EwpCM8IVxNQeVuixKlPNjRst5JKlSFnShR1X6RfXdcfPmppxTgQXEPmfML0MD4R
         jSIZtjyDrgLYDjPJOujS3p9Ez4qxfi5Q0Af+U54K6oXJ5wa/sNTeve5JDge9dapFjAl1
         RA6Dr9GpShpIVspaee0rBZJFOsmQkeIFET5MuSKcN3wUk3dOKr6Zj0eLfoNnEWcXP5Mh
         dq9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/d8FpUczMwWN5XPvC/++rsknSvh37C/1BM8v02LTBu4=;
        b=NFrVE6QLKDx5lCay4NnoLJVXscHizDJGLaqMIkYlN5K/bk+HhZvXyDpVRt+xWVnbja
         RCe09129C3uK1Psd/qC5J1kCdIdoZerrUFP83LT5BuFEPfWENUtfDtsLpDDWEF3++d5g
         00EidZOpBvlkMP7yOwCGXGATI5KoM+o3qLD3T90ut7pKOpXau2kXfwPmXd85nsuPN0dF
         BGOqQ1ii5pY7OkLM8gA7nZHVxMGozEgx0i5koO2i8ZYllCdSo/YYDJsnwV5+eykAyfzo
         8CIrt12SrX9vAlBRpDXUMYO9SYxQzU3PD9myp8yusIqmMHY257bKCcoQTKvQ9tZUBQZO
         EGOw==
X-Gm-Message-State: AJIora/dA+wEt2RxHdt/XPplCBSmpKMNGFbClumjN+o0V8htT3Ziv45H
        esDGQMAT0C2sLMbCQz6DlD6h
X-Google-Smtp-Source: AGRyM1suYdWV92DhNrTgznfBpiu6LWReAoUpK9QdyxXzOmSf6Vu0J0HnhLRZolHPSwcD+GbIcrG5Lg==
X-Received: by 2002:aca:b744:0:b0:32f:4c19:cec1 with SMTP id h65-20020acab744000000b0032f4c19cec1mr8223597oif.43.1656342731145;
        Mon, 27 Jun 2022 08:12:11 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:714a:b337:6fac:e704? ([2600:1700:e72:80a0:714a:b337:6fac:e704])
        by smtp.gmail.com with ESMTPSA id z16-20020a4ade50000000b004257b0aa35fsm5940449oot.8.2022.06.27.08.12.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jun 2022 08:12:10 -0700 (PDT)
Message-ID: <cebad3da-5779-5908-15d5-63d4c590c20b@github.com>
Date:   Mon, 27 Jun 2022 11:12:09 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 4/6] pack-bitmap: prepare to read lookup table
 extension
Content-Language: en-US
To:     Abhradeep Chakraborty via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaram <kaartic.sivaraam@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
References: <pull.1266.git.1655728395.gitgitgadget@gmail.com>
 <pull.1266.v2.git.1656249017.gitgitgadget@gmail.com>
 <4fbfcff8a208798146cd561b0185e094a116cf0e.1656249017.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <4fbfcff8a208798146cd561b0185e094a116cf0e.1656249017.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/26/2022 9:10 AM, Abhradeep Chakraborty via GitGitGadget wrote:
> From: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
> 
> Earlier change teaches Git to write bitmap lookup table. But Git
> does not know how to parse them.
> 
> Teach Git to parse the existing bitmap lookup table. The older
> versions of git are not affected by it. Those versions ignore the
> lookup table.
> 
> Signed-off-by: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
> Mentored-by: Taylor Blau <me@ttaylorr.com>
> Co-Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>

I didn't check the previous patches, but your sign-off should be the
last line of the message. (You are singing off on all previous content,
and any later content is not covered by your sign-off.)

> +
> +		if (flags & BITMAP_OPT_LOOKUP_TABLE &&
> +			git_env_bool("GIT_TEST_READ_COMMIT_TABLE", 1)) {

nit: This alignment should use four spaces at the end so the second phrase
matches the start of the previous phrase. Like this:

		if (flags & BITMAP_OPT_LOOKUP_TABLE &&
		    git_env_bool("GIT_TEST_READ_COMMIT_TABLE", 1)) {

Perhaps it looked right in your editor because it renders tabs as 4 spaces
instead of 8 spaces.

> +			size_t table_size = 0;
> +			size_t triplet_sz = st_add3(sizeof(uint32_t),    /* commit position */
> +							sizeof(uint64_t),    /* offset */
> +							sizeof(uint32_t));    /* xor offset */

The 4- vs 8-space tab view would also explain the alignment here:

			size_t triplet_sz = st_add3(sizeof(uint32_t),  /* commit position */
						    sizeof(uint64_t),  /* offset */
						    sizeof(uint32_t)); /* xor offset */

(I also modified the comment alignment.)

Of course, since these values are constants and have no risk of overflowing,
perhaps we can drop st_add3() here:


			size_t triplet_sz = sizeof(uint32_t) + /* commit position */
					    sizeof(uint64_t) +  /* offset */
					    sizeof(uint32_t); /* xor offset */

> +			table_size = st_add(table_size,
> +					st_mult(ntohl(header->entry_count),
> +						triplet_sz));

Here, we _do_ want to keep the st_mult(). Is the st_add() still necessary? It
seems this is a leftover from the previous version that had the 4-byte flag
data.

We set table_size to zero above. We could drop that initialization and instead
have this after the "size_t triplet_sz" definition:

			size_t table_size = st_mult(ntohl(header->entry_count),
						    triplet_sz));

> +			if (table_size > index_end - index->map - header_size)
> +				return error("corrupted bitmap index file (too short to fit lookup table)");

Please add "_(...)" around the error message so it can be translated.

> +			index->table_lookup = (void *)(index_end - table_size);
> +			index_end -= table_size;
> +		}

> -	/* a 0 return code means the insertion succeeded with no changes,
> -	 * because the SHA1 already existed on the map. this is bad, there
> -	 * shouldn't be duplicated commits in the index */
> +	/* A 0 return code means the insertion succeeded with no changes,
> +	 * because the SHA1 already existed on the map. If lookup table
> +	 * is NULL, this is bad, there shouldn't be duplicated commits
> +	 * in the index.
> +	 *
> +	 * If table_lookup exists, that means the desired bitmap is already
> +	 * loaded. Either this bitmap has been stored directly or another
> +	 * bitmap has a direct or indirect xor relation with it. */

If we are modifying this multi-line comment, then we should reformat it to
match convention:

	/*
	 * The first sentence starts after the comment start
	 * so it has symmetry with the comment end which is on
	 * its own line.
	 */

>  	if (ret == 0) {
> -		error("Duplicate entry in bitmap index: %s", oid_to_hex(oid));
> -		return NULL;
> +		if (!index->table_lookup) {
> +			error("Duplicate entry in bitmap index: %s", oid_to_hex(oid));

Errors start with lowercase letters. Please add translation markers "_(...)"

> +static uint32_t triplet_get_xor_pos(const void *triplet)
> +{
> +	const void *p = (unsigned char*) triplet + st_add(sizeof(uint32_t), sizeof(uint64_t));

This st_add() is not necessary since the constants will not overflow.

> +	return get_be32(p);
> +}
> +
> +static int triplet_cmp(const void *va, const void *vb)
> +{
> +	int result = 0;
> +	uint32_t *a = (uint32_t *) va;
> +	uint32_t b = get_be32(vb);
> +	if (*a > b)
> +		result = 1;
> +	else if (*a < b)
> +		result = -1;
> +	else
> +		result = 0;
> +
> +	return result;
> +}
> +
> +static uint32_t bsearch_pos(struct bitmap_index *bitmap_git, struct object_id *oid,
> +						uint32_t *result)

Strange wrapping. Perhaps

static uint32_t bsearch_pos(struct bitmap_index *bitmap_git,
			    struct object_id *oid,
			    uint32_t *result)

> +{
> +	int found;
> +
> +	if (bitmap_git->midx)
> +		found = bsearch_midx(oid, bitmap_git->midx, result);
> +	else
> +		found = bsearch_pack(oid, bitmap_git->pack, result);
> +
> +	return found;

Here, we are doing a binary search on the entire list of packed objects, which could
use quite a few more hops than a binary search on the bitmapped commits.

> +static struct stored_bitmap *lazy_bitmap_for_commit(struct bitmap_index *bitmap_git,
> +					  struct commit *commit)
...
> +	int found = bsearch_pos(bitmap_git, oid, &commit_pos);
> +
> +	if (!found)
> +		return NULL;
> +
> +	triplet = bsearch(&commit_pos, bitmap_git->table_lookup, bitmap_git->entry_count,
> +						triplet_sz, triplet_cmp);

But I see, you are searching the pack-index for the position in the index, and _then_
searching the bitmap lookup table based on that position value.

I expected something different: binary search on the triplets where the comparison is
made by looking up the OID from the [multi-]pack-index and comparing that OID to the
commit OID we are looking for.

I'm not convinced that the binary search I had in mind is meaningfully faster than
what you've implemented here, so I'm happy to leave it as you have it. We can investigate
if that full search on the pack-index matters at all (it probably doesn't).

> +	if (!triplet)
> +		return NULL;
> +
> +	offset = triplet_get_offset(triplet);
> +	xor_pos = triplet_get_xor_pos(triplet);
> +
> +	if (xor_pos != 0xffffffff) {
> +		int xor_flags;
> +		uint64_t offset_xor;
> +		uint32_t *xor_positions;
> +		struct object_id xor_oid;
> +		size_t size = 0;
> +
> +		ALLOC_ARRAY(xor_positions, bitmap_git->entry_count);

While there is potential that this is wasteful, it's probably not that huge,
so we can start with the "maximum XOR depth" and then reconsider a smaller
allocation in the future.

> +		while (xor_pos != 0xffffffff) {

We should consider ensuring that also "size < bitmap_git->entry_count".
Better yet, create an xor_positions_alloc variable that is initialized
to the entry_count value.

"size" should probably be xor_positions_nr.

> +			xor_positions[size++] = xor_pos;
> +			triplet = bitmap_get_triplet(bitmap_git, xor_pos);
> +			xor_pos = triplet_get_xor_pos(triplet);
> +		}

(at this point, "if (xor_positions_nr >= xor_positions_alloc)", then error
out since the file must be malformed with an XOR loop.)

> +		while (size){

nit: ") {"

> +			xor_pos = xor_positions[size - 1];
> +			triplet = bitmap_get_triplet(bitmap_git, xor_pos);
> +			commit_pos = get_be32(triplet);
> +			offset_xor = triplet_get_offset(triplet);
> +
> +			if (nth_bitmap_object_oid(bitmap_git, &xor_oid, commit_pos) < 0) {
> +				free(xor_positions);
> +				return NULL;
> +			}
> +
> +			bitmap_git->map_pos = offset_xor + sizeof(uint32_t) + sizeof(uint8_t);
> +			xor_flags = read_u8(bitmap_git->map, &bitmap_git->map_pos);
> +			bitmap = read_bitmap_1(bitmap_git);
> +
> +			if (!bitmap){

nit: ") {"

> +				free(xor_positions);
> +				return NULL;
> +			}
> +
> +			xor_bitmap = store_bitmap(bitmap_git, bitmap, &xor_oid, xor_bitmap, xor_flags);

Since we are storing the bitmap here as we "pop" the stack, should we be
looking for a stored bitmap while pushing to the stack in the previous loop?
That would save time when using multiple bitmaps with common XOR bases.

(Of course, we want to be careful that we do not create a recursive loop,
but instead _only_ look at the in-memory bitmaps that already exist.)

> +			size--;
> +		}
> +
> +		free(xor_positions);
> +	}
> +
> +	bitmap_git->map_pos = offset + sizeof(uint32_t) + sizeof(uint8_t);
> +	flags = read_u8(bitmap_git->map, &bitmap_git->map_pos);
> +	bitmap = read_bitmap_1(bitmap_git);
> +
> +	if (!bitmap)
> +		return NULL;
> +
> +	return store_bitmap(bitmap_git, bitmap, oid, xor_bitmap, flags);
> +}
> +

I'm happy with the structure of this iterative algorithm!

I'll pause my review here for now.

Thanks,
-Stolee
