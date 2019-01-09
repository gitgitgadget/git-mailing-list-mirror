Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40413211B4
	for <e@80x24.org>; Wed,  9 Jan 2019 15:21:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732242AbfAIPVQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Jan 2019 10:21:16 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53983 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731314AbfAIPVQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jan 2019 10:21:16 -0500
Received: by mail-wm1-f65.google.com with SMTP id d15so8046555wmb.3
        for <git@vger.kernel.org>; Wed, 09 Jan 2019 07:21:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:mime-version
         :content-transfer-encoding:fcc:content-transfer-encoding:to:cc;
        bh=X0CyWL9CtgAF1OmCWFQjp6C2fnxC9Ei2El/CdM8FNWE=;
        b=fAsN/zlkGD/NAEvAZzqWsjvTbjmI6ukpQJze4GvE0JDj7mY0FnB7ML03L8k0K1vsvD
         Bkg3ABWtmzpxKuwo+V6/+FGSsnuqWS8e2VASMynDRup0014wIpv/6aUr8t9k44lCpSxa
         uZSNxx6UKvzUCDwNUtOXpHn8Wf/yMzpMRdkqKDOqre5+AuCUovWwAA54gJ1vpRF+FEgp
         XQJZOkr0m4ACMXPoD3jQfMjBmoj28CBEA528yctsqFOv+ouTt3U/tP0xvuhmnECj/40f
         6FM+hX5l/CFmCvN/gSlzpyjHXj232YNBDF8QeNVt1nLR5l7Txg6jI+ky0KYtsBpdco+U
         qKMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:mime-version:content-transfer-encoding:fcc
         :content-transfer-encoding:to:cc;
        bh=X0CyWL9CtgAF1OmCWFQjp6C2fnxC9Ei2El/CdM8FNWE=;
        b=CqqPBMm7m/oQb+l8t285M7hXRcRcmvvxap4MXwqHdb8gNIpTe8t2mpoPgSZl1xcp8p
         daoy2oJQhAmBJSvQ2rUFyKNVhU+y8oHOHsKBTgz0Ouz5gPPcV1tjQbNkXRqPl/f284AX
         9pMvk/fzHc8eSkznaIaOyovxfrdMWK6ipvi640INcrHO+KtuyJeTihUlvnVLOot+fEoF
         DJQdrbjzGBgCq+k9JuSiDSRD28dqzbgOXYzTThTUC6/B//2APINem/eMPhM8Llmo96hH
         awH3g5xPrc0xmneriY/mM0ifqhAKtmDCnQw3hDXIuzXMa26Mx7yoxYRMkBSZnCQRFZfW
         iV9Q==
X-Gm-Message-State: AJcUukdvnbQRlMT15OHsvSQvkfcuk3wZr2O6wshzauthRidsOvmZTUBM
        wncPhtWIgz/Yy+ONwgawIxv/ClMg
X-Google-Smtp-Source: ALg8bN44fQ37sX8aNZ7Wq9JQJoKKAWX5qyF0WonfWsiUAQ9+6ArvlgQulc+MVx+5YNlCxypvEj/Gow==
X-Received: by 2002:a1c:4855:: with SMTP id v82mr6082543wma.15.1547047271027;
        Wed, 09 Jan 2019 07:21:11 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e18sm73905808wrv.88.2019.01.09.07.21.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jan 2019 07:21:10 -0800 (PST)
Date:   Wed, 09 Jan 2019 07:21:10 -0800 (PST)
X-Google-Original-Date: Wed, 09 Jan 2019 15:21:00 GMT
Message-Id: <pull.92.v3.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.92.v2.git.gitgitgadget@gmail.com>
References: <pull.92.v2.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 0/9] Create 'expire' and 'repack' verbs for git-multi-pack-index
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     git@vger.kernel.org
Cc:     sbeller@google.com, peff@peff.net, jrnieder@gmail.com,
        avarab@gmail.com, Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The multi-pack-index provides a fast way to find an object among a large
list of pack-files. It stores a single pack-reference for each object id, so
duplicate objects are ignored. Among a list of pack-files storing the same
object, the most-recently modified one is used.

Create new subcommands for the multi-pack-index builtin.

 * 'git multi-pack-index expire': If we have a pack-file indexed by the
   multi-pack-index, but all objects in that pack are duplicated in
   more-recently modified packs, then delete that pack (and any others like
   it). Delete the reference to that pack in the multi-pack-index.
   
   
 * 'git multi-pack-index repack --batch-size=': Starting from the oldest
   pack-files covered by the multi-pack-index, find those whose on-disk size
   is below the batch size until we have a collection of packs whose sizes
   add up to the batch size. Create a new pack containing all objects that
   the multi-pack-index references to those packs.
   
   

This allows us to create a new pattern for repacking objects: run 'repack'.
After enough time has passed that all Git commands that started before the
last 'repack' are finished, run 'expire' again. This approach has some
advantages over the existing "repack everything" model:

 1. Incremental. We can repack a small batch of objects at a time, instead
    of repacking all reachable objects. We can also limit ourselves to the
    objects that do not appear in newer pack-files.
    
    
 2. Highly Available. By adding a new pack-file (and not deleting the old
    pack-files) we do not interrupt concurrent Git commands, and do not
    suffer performance degradation. By expiring only pack-files that have no
    referenced objects, we know that Git commands that are doing normal
    object lookups* will not be interrupted.
    
    
 3. Note: if someone concurrently runs a Git command that uses
    get_all_packs(), then that command could try to read the pack-files and
    pack-indexes that we are deleting during an expire command. Such
    commands are usually related to object maintenance (i.e. fsck, gc,
    pack-objects) or are related to less-often-used features (i.e.
    fast-import, http-backend, server-info).
    
    

We plan to use this approach in VFS for Git to do background maintenance of
the "shared object cache" which is a Git alternate directory filled with
packfiles containing commits and trees. We currently download pack-files on
an hourly basis to keep up-to-date with the central server. The cache
servers supply packs on an hourly and daily basis, so most of the hourly
packs become useless after a new daily pack is downloaded. The 'expire'
command would clear out most of those packs, but many will still remain with
fewer than 100 objects remaining. The 'repack' command (with a batch size of
1-3gb, probably) can condense the remaining packs in commands that run for
1-3 min at a time. Since the daily packs range from 100-250mb, we will also
combine and condense those packs.

Updates in V2:

 * Added a method, unlink_pack_path() to remove packfiles, but with the
   additional check for a .keep file. This borrows logic from 
   builtin/repack.c.
   
   
 * Modified documentation and commit messages to replace 'verb' with
   'subcommand'. Simplified the documentation. (I left 'verbs' in the title
   of the cover letter for consistency.)
   
   

Updates in V3:

 * There was a bug in the expire logic when simultaneously removing packs
   and adding uncovered packs, specifically around the pack permutation.
   This was hard to see during review because I was using the 'pack_perm'
   array for multiple purposes. First, I was reducing its length, and then I
   was adding to it and resorting. In V3, I significantly overhauled the
   logic here, which required some extra commits before implementing
   'expire'. The final commit includes a test that would cover this case.

Thanks, -Stolee

Derrick Stolee (9):
  repack: refactor pack deletion for future use
  Docs: rearrange subcommands for multi-pack-index
  multi-pack-index: prepare for 'expire' subcommand
  midx: simplify computation of pack name lengths
  midx: refactor permutation logic and pack sorting
  multi-pack-index: implement 'expire' verb
  multi-pack-index: prepare 'repack' subcommand
  midx: implement midx_repack()
  multi-pack-index: test expire while adding packs

 Documentation/git-multi-pack-index.txt |  26 +-
 builtin/multi-pack-index.c             |  12 +-
 builtin/repack.c                       |  14 +-
 midx.c                                 | 393 ++++++++++++++++++-------
 midx.h                                 |   2 +
 packfile.c                             |  28 ++
 packfile.h                             |   7 +
 t/t5319-multi-pack-index.sh            | 133 +++++++++
 8 files changed, 497 insertions(+), 118 deletions(-)


base-commit: 26aa9fc81d4c7f6c3b456a29da0b7ec72e5c6595
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-92%2Fderrickstolee%2Fmidx-expire%2Fupstream-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-92/derrickstolee/midx-expire/upstream-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/92

Range-diff vs v2:

  1:  a697df120c =  1:  62b393b816 repack: refactor pack deletion for future use
  2:  55df6b20ff =  2:  7886785904 Docs: rearrange subcommands for multi-pack-index
  3:  2529afe89e =  3:  f06382b4ae multi-pack-index: prepare for 'expire' subcommand
  4:  0c29a242fe <  -:  ---------- midx: refactor permutation logic
  -:  ---------- >  4:  2a763990ae midx: simplify computation of pack name lengths
  -:  ---------- >  5:  a0d4cc6cb3 midx: refactor permutation logic and pack sorting
  5:  1c4af93f5e !  6:  4dbff40e7a multi-pack-index: implement 'expire' verb
     @@ -26,6 +26,62 @@
       diff --git a/midx.c b/midx.c
       --- a/midx.c
       +++ b/midx.c
     +@@
     + #define MIDX_CHUNK_LARGE_OFFSET_WIDTH (sizeof(uint64_t))
     + #define MIDX_LARGE_OFFSET_NEEDED 0x80000000
     + 
     ++#define PACK_EXPIRED UINT_MAX
     ++
     + static char *get_midx_filename(const char *object_dir)
     + {
     + 	return xstrfmt("%s/pack/multi-pack-index", object_dir);
     +@@
     + 	uint32_t orig_pack_int_id;
     + 	char *pack_name;
     + 	struct packed_git *p;
     ++	unsigned expired : 1;
     + };
     + 
     + static int pack_info_compare(const void *_a, const void *_b)
     +@@
     + 
     + 		packs->info[packs->nr].pack_name = xstrdup(file_name);
     + 		packs->info[packs->nr].orig_pack_int_id = packs->nr;
     ++		packs->info[packs->nr].expired = 0;
     + 		packs->nr++;
     + 	}
     + }
     +@@
     + 	size_t written = 0;
     + 
     + 	for (i = 0; i < num_packs; i++) {
     +-		size_t writelen = strlen(info[i].pack_name) + 1;
     ++		size_t writelen;
     ++
     ++		if (info[i].expired)
     ++			continue;
     + 
     + 		if (i && strcmp(info[i].pack_name, info[i - 1].pack_name) <= 0)
     + 			BUG("incorrect pack-file order: %s before %s",
     + 			    info[i - 1].pack_name,
     + 			    info[i].pack_name);
     + 
     ++		writelen = strlen(info[i].pack_name) + 1;
     + 		hashwrite(f, info[i].pack_name, writelen);
     + 		written += writelen;
     + 	}
     +@@
     + 	for (i = 0; i < nr_objects; i++) {
     + 		struct pack_midx_entry *obj = list++;
     + 
     ++		if (perm[obj->pack_int_id] == PACK_EXPIRED)
     ++			BUG("object %s is in an expired pack with int-id %d",
     ++			    oid_to_hex(&obj->oid),
     ++			    obj->pack_int_id);
     ++
     + 		hashwrite_be32(f, perm[obj->pack_int_id]);
     + 
     + 		if (large_offset_needed && obj->offset >> 31)
      @@
       	return written;
       }
     @@ -37,9 +93,10 @@
       	unsigned char cur_chunk, num_chunks = 0;
       	char *midx_name;
      @@
     - 	uint32_t nr_entries, num_large_offsets = 0;
       	struct pack_midx_entry *entries = NULL;
       	int large_offsets_needed = 0;
     + 	int pack_name_concat_len = 0;
     ++	int dropped_packs = 0;
      +	int result = 0;
       
       	midx_name = get_midx_filename(object_dir);
     @@ -55,49 +112,87 @@
      +		packs.m = load_multi_pack_index(object_dir, 1);
       
       	packs.nr = 0;
     - 	packs.alloc_list = packs.m ? packs.m->num_packs : 16;
     + 	packs.alloc = packs.m ? packs.m->num_packs : 16;
      @@
     - 	ALLOC_ARRAY(packs.perm, packs.alloc_perm);
     - 
     - 	if (packs.m) {
     -+		int drop_index = 0, missing_drops = 0;
     - 		for (i = 0; i < packs.m->num_packs; i++) {
     -+			if (packs_to_drop && drop_index < packs_to_drop->nr) {
     -+				int cmp = strcmp(packs.m->pack_names[i],
     -+						 packs_to_drop->items[drop_index].string);
     -+
     -+				if (!cmp) {
     -+					drop_index++;
     -+					continue;
     -+				} else if (cmp > 0) {
     -+					error(_("did not see pack-file %s to drop"),
     -+					      packs_to_drop->items[drop_index].string);
     -+					drop_index++;
     -+					i--;
     -+					missing_drops++;
     -+					continue;
     -+				}
     -+			}
     -+
     - 			ALLOC_GROW(packs.list, packs.nr + 1, packs.alloc_list);
     - 			ALLOC_GROW(packs.names, packs.nr + 1, packs.alloc_names);
     - 			ALLOC_GROW(packs.perm, packs.nr + 1, packs.alloc_perm);
     -@@
     - 			packs.pack_name_concat_len += strlen(packs.names[packs.nr]) + 1;
     + 			packs.info[packs.nr].orig_pack_int_id = i;
     + 			packs.info[packs.nr].pack_name = xstrdup(packs.m->pack_names[i]);
     + 			packs.info[packs.nr].p = NULL;
     ++			packs.info[packs.nr].expired = 0;
       			packs.nr++;
       		}
     + 	}
     + 
     + 	for_each_file_in_pack_dir(object_dir, add_pack_to_midx, &packs);
     + 
     +-	if (packs.m && packs.nr == packs.m->num_packs)
     ++	if (packs.m && packs.nr == packs.m->num_packs && !packs_to_drop)
     + 		goto cleanup;
     + 
     + 	entries = get_sorted_entries(packs.m, packs.info, packs.nr, &nr_entries);
     +@@
     + 
     + 	QSORT(packs.info, packs.nr, pack_info_compare);
     + 
     ++	if (packs_to_drop && packs_to_drop->nr) {
     ++		int drop_index = 0;
     ++		int missing_drops = 0;
     ++
     ++		for (i = 0; i < packs.nr && drop_index < packs_to_drop->nr; i++) {
     ++			int cmp = strcmp(packs.info[i].pack_name,
     ++					 packs_to_drop->items[drop_index].string);
     ++
     ++			if (!cmp) {
     ++				drop_index++;
     ++				packs.info[i].expired = 1;
     ++			} else if (cmp > 0) {
     ++				error(_("did not see pack-file %s to drop"),
     ++				      packs_to_drop->items[drop_index].string);
     ++				drop_index++;
     ++				missing_drops++;
     ++				i--;
     ++			} else {
     ++				packs.info[i].expired = 0;
     ++			}
     ++		}
      +
     -+		if (packs_to_drop && (drop_index < packs_to_drop->nr || missing_drops)) {
     -+			error(_("did not see all pack-files to drop"));
     ++		if (missing_drops) {
      +			result = 1;
      +			goto cleanup;
     ++		}
     ++	}
     ++
     + 	ALLOC_ARRAY(pack_perm, packs.nr);
     + 	for (i = 0; i < packs.nr; i++) {
     +-		pack_perm[packs.info[i].orig_pack_int_id] = i;
     ++		if (packs.info[i].expired) {
     ++			dropped_packs++;
     ++			pack_perm[packs.info[i].orig_pack_int_id] = PACK_EXPIRED;
     ++		} else {
     ++			pack_perm[packs.info[i].orig_pack_int_id] = i - dropped_packs;
      +		}
       	}
       
     - 	for_each_file_in_pack_dir(object_dir, add_pack_to_midx, &packs);
     +-	for (i = 0; i < packs.nr; i++)
     +-		pack_name_concat_len += strlen(packs.info[i].pack_name) + 1;
     ++	for (i = 0; i < packs.nr; i++) {
     ++		if (!packs.info[i].expired)
     ++			pack_name_concat_len += strlen(packs.info[i].pack_name) + 1;
     ++	}
     + 
     + 	if (pack_name_concat_len % MIDX_CHUNK_ALIGNMENT)
     + 		pack_name_concat_len += MIDX_CHUNK_ALIGNMENT -
     +@@
     + 	cur_chunk = 0;
     + 	num_chunks = large_offsets_needed ? 5 : 4;
     + 
     +-	written = write_midx_header(f, num_chunks, packs.nr);
     ++	written = write_midx_header(f, num_chunks, packs.nr - dropped_packs);
     + 
     + 	chunk_ids[cur_chunk] = MIDX_CHUNKID_PACKNAMES;
     + 	chunk_offsets[cur_chunk] = written + (num_chunks + 1) * MIDX_CHUNKLOOKUP_WIDTH;
      @@
     - 	free(packs.perm);
       	free(entries);
     + 	free(pack_perm);
       	free(midx_name);
      -	return 0;
      +	return result;
     @@ -175,7 +270,10 @@
      +		ls .git/objects/pack | grep -v -e pack-[AB] >expect &&
      +		git multi-pack-index expire &&
      +		ls .git/objects/pack >actual &&
     -+		test_cmp expect actual
     ++		test_cmp expect actual &&
     ++		ls .git/objects/pack/ | grep idx >expect-idx &&
     ++		test-tool read-midx .git/objects | grep idx >actual-midx &&
     ++		test_cmp expect-idx actual-midx
      +	)
      +'
      +
  6:  af08e21c97 =  7:  b39f90ad09 multi-pack-index: prepare 'repack' subcommand
  7:  bef7aa007c =  8:  a4c2d5a8e1 midx: implement midx_repack()
  -:  ---------- >  9:  b97fb35ba9 multi-pack-index: test expire while adding packs

-- 
gitgitgadget
