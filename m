Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E8D211F404
	for <e@80x24.org>; Mon, 12 Mar 2018 02:29:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932451AbeCLC2Q (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Mar 2018 22:28:16 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34248 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932419AbeCLC2O (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 11 Mar 2018 22:28:14 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 4B82560427;
        Mon, 12 Mar 2018 02:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1520821690;
        bh=AOKJ722bHSwhTKDipu9wRI7o8+nYFXvm+lD7myoxpYo=;
        h=From:To:Cc:Subject:Date:Content-Type:From:Reply-To:Subject:Date:
         To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:
         References:Content-Type:Content-Disposition;
        b=BdMHLwu8MPOcyie3YmRKGQxmFyCgK4g7I71OuVLVfr2xp3OZ62SwbbkzoLsxNPj6B
         ZnFL4FZCGfIxMFegF+AhN/wLH9yoUAQhnrgf2AiEFA8FRa8umXZJGbPSsPw6NwFnCG
         qMiSGfIroQiut+FfrNC3il/YvWN1h5oWHLbi4bgZeRR8Fz3GQq/hxrzMldng3RjtRG
         PfP/RwMubNEocgFgny5wsxeCgn/W1StjZhOEQ4WRJ8RqRhY5oG2WummgHdpPx1Z2m5
         xfV4xIB2M00U3x1sKx2oUND1W//6LemnDv6O5EqSPm6V4FeF1QqeT90vN1Mf29Rb7X
         MLt3JehJCHslmWSRvvJa26+9ndU2p5EPbf5ThLBb+HQCJUihmpZVa/76K/nu6gzYLa
         ef+V4UJd6c5Bg+5Jt5Tof2LRT2hOztN2CfQHFxFkQMzjmlJKBbpWUffU25h50UpSRp
         hYPc5hUPhuPvJr4O3i9HJMWSmaFP7QMtVgYpnRHEjwr8WiKphxp
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Patryk Obara <patryk.obara@gmail.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 00/36] object_id part 12
Date:   Mon, 12 Mar 2018 02:27:20 +0000
Message-Id: <20180312022756.483934-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.16.2.660.g709887971b
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the twelfth in a series of patches to convert various parts of
the code to struct object_id.

Changes from v2:
* Rebase onto master (to fix "typename" → "type_name" changes).
* Replace some uses of hashcpy with memcpy.
* Replace some instances of "20" with references to the_hash_algo.

Changes from v1:
* Rebase onto master.

tbdiff output below.

brian m. carlson (36):
  bulk-checkin: convert index_bulk_checkin to struct object_id
  builtin/write-tree: convert to struct object_id
  cache-tree: convert write_*_as_tree to object_id
  cache-tree: convert remnants to struct object_id
  resolve-undo: convert struct resolve_undo_info to object_id
  tree: convert read_tree_recursive to struct object_id
  ref-filter: convert grab_objectname to struct object_id
  strbuf: convert strbuf_add_unique_abbrev to use struct object_id
  wt-status: convert struct wt_status_state to object_id
  Convert find_unique_abbrev* to struct object_id
  http-walker: convert struct object_request to use struct object_id
  send-pack: convert remaining functions to struct object_id
  replace_object: convert struct replace_object to object_id
  builtin/mktag: convert to struct object_id
  archive: convert write_archive_entry_fn_t to object_id
  archive: convert sha1_file_to_archive to struct object_id
  builtin/index-pack: convert struct ref_delta_entry to object_id
  sha1_file: convert read_loose_object to use struct object_id
  sha1_file: convert check_sha1_signature to struct object_id
  streaming: convert open_istream to use struct object_id
  builtin/mktree: convert to struct object_id
  sha1_file: convert assert_sha1_type to object_id
  sha1_file: convert retry_bad_packed_offset to struct object_id
  packfile: convert unpack_entry to struct object_id
  Convert remaining callers of sha1_object_info_extended to object_id
  sha1_file: convert sha1_object_info* to object_id
  builtin/fmt-merge-msg: convert remaining code to object_id
  builtin/notes: convert static functions to object_id
  tree-walk: convert get_tree_entry_follow_symlinks internals to
    object_id
  streaming: convert istream internals to struct object_id
  tree-walk: convert tree entry functions to object_id
  sha1_file: convert read_object_with_reference to object_id
  sha1_file: convert read_sha1_file to struct object_id
  Convert lookup_replace_object to struct object_id
  sha1_file: introduce a constant for max header length
  convert: convert to struct object_id

 apply.c                  |   4 +-
 archive-tar.c            |  28 ++++----
 archive-zip.c            |  18 ++---
 archive.c                |  32 ++++-----
 archive.h                |  10 +--
 bisect.c                 |   3 +-
 blame.c                  |  18 +++--
 builtin/am.c             |   8 +--
 builtin/blame.c          |   4 +-
 builtin/branch.c         |   2 +-
 builtin/cat-file.c       |  30 +++++----
 builtin/checkout.c       |  12 ++--
 builtin/commit-tree.c    |   2 +-
 builtin/describe.c       |   6 +-
 builtin/difftool.c       |   2 +-
 builtin/fast-export.c    |   8 +--
 builtin/fetch.c          |  10 +--
 builtin/fmt-merge-msg.c  |   4 +-
 builtin/fsck.c           |   4 +-
 builtin/grep.c           |   6 +-
 builtin/index-pack.c     |  43 ++++++------
 builtin/log.c            |   8 +--
 builtin/ls-files.c       |   4 +-
 builtin/ls-tree.c        |   8 +--
 builtin/merge-tree.c     |   5 +-
 builtin/merge.c          |   8 +--
 builtin/mktag.c          |  20 +++---
 builtin/mktree.c         |  24 +++----
 builtin/name-rev.c       |   2 +-
 builtin/notes.c          |  14 ++--
 builtin/pack-objects.c   |  27 ++++----
 builtin/prune.c          |   2 +-
 builtin/receive-pack.c   |   8 +--
 builtin/reflog.c         |   2 +-
 builtin/replace.c        |  10 +--
 builtin/reset.c          |   2 +-
 builtin/rev-list.c       |   2 +-
 builtin/rev-parse.c      |   2 +-
 builtin/rm.c             |   2 +-
 builtin/show-branch.c    |   2 +-
 builtin/show-ref.c       |   4 +-
 builtin/tag.c            |  16 +++--
 builtin/unpack-file.c    |   2 +-
 builtin/unpack-objects.c |   4 +-
 builtin/update-index.c   |   2 +-
 builtin/verify-commit.c  |   2 +-
 builtin/worktree.c       |   4 +-
 builtin/write-tree.c     |   6 +-
 bulk-checkin.c           |  18 ++---
 bulk-checkin.h           |   2 +-
 bundle.c                 |   2 +-
 cache-tree.c             |  39 +++++------
 cache-tree.h             |   4 +-
 cache.h                  |  42 ++++++------
 combine-diff.c           |   6 +-
 commit.c                 |   8 +--
 config.c                 |   2 +-
 convert.c                |  12 ++--
 convert.h                |   2 +-
 diff.c                   |   6 +-
 dir.c                    |   2 +-
 entry.c                  |   4 +-
 fast-import.c            |  31 ++++-----
 fsck.c                   |   2 +-
 grep.c                   |   2 +-
 http-push.c              |   2 +-
 http-walker.c            |  16 ++---
 line-log.c               |   3 +-
 list-objects-filter.c    |   2 +-
 log-tree.c               |  12 ++--
 mailmap.c                |   2 +-
 match-trees.c            |  10 +--
 merge-blobs.c            |   4 +-
 merge-recursive.c        |  20 +++---
 notes-cache.c            |   2 +-
 notes-merge.c            |   2 +-
 notes.c                  |  10 +--
 object.c                 |  12 ++--
 pack-bitmap-write.c      |   3 +-
 pack-check.c             |   4 +-
 packfile.c               |  30 ++++-----
 pretty.c                 |   8 +--
 reachable.c              |   2 +-
 read-cache.c             |   4 +-
 ref-filter.c             |  14 ++--
 refs.c                   |   2 +-
 remote-testsvn.c         |   4 +-
 remote.c                 |   2 +-
 replace_object.c         |  26 ++++----
 rerere.c                 |   4 +-
 resolve-undo.c           |  15 +++--
 resolve-undo.h           |   2 +-
 send-pack.c              |  12 ++--
 sequencer.c              |   9 +--
 sha1_file.c              | 137 +++++++++++++++++++++------------------
 sha1_name.c              |  31 +++++----
 strbuf.c                 |   4 +-
 strbuf.h                 |   8 ++-
 streaming.c              |  18 ++---
 streaming.h              |   2 +-
 submodule-config.c       |   2 +-
 submodule.c              |   6 +-
 tag.c                    |  10 +--
 transport.c              |   6 +-
 tree-walk.c              |  45 +++++++------
 tree-walk.h              |   2 +-
 tree.c                   |  16 ++---
 tree.h                   |   2 +-
 wt-status.c              |  20 +++---
 wt-status.h              |   6 +-
 xdiff-interface.c        |   2 +-
 111 files changed, 600 insertions(+), 585 deletions(-)

git tbdiff output between v2 and v3:

 1: fb5a482ad6 =  1: 034342eba3 bulk-checkin: convert index_bulk_checkin to struct object_id
 2: 6d91ba00b2 =  2: 61e7e3192e builtin/write-tree: convert to struct object_id
 3: 9b7bb4b8de =  3: 934ebd4399 cache-tree: convert write_*_as_tree to object_id
 4: 62cd33ae27 !  4: 4ecefd666a cache-tree: convert remnants to struct object_id
    @@ -86,17 +86,26 @@
      	for (i = 0; i < it->subtree_nr; i++) {
      		struct cache_tree_sub *down = it->down[i];
     @@
    + 	char *ep;
    + 	struct cache_tree *it;
    + 	int i, subtree_nr;
    ++	const unsigned rawsz = the_hash_algo->rawsz;
    + 
    + 	it = NULL;
    + 	/* skip name, but make sure name exists */
    +@@
      		goto free_return;
      	buf++; size--;
      	if (0 <= it->entry_count) {
     -		if (size < 20)
    -+		if (size < the_hash_algo->rawsz)
    ++		if (size < rawsz)
      			goto free_return;
    - 		hashcpy(it->oid.hash, (const unsigned char*)buf);
    +-		hashcpy(it->oid.hash, (const unsigned char*)buf);
     -		buf += 20;
     -		size -= 20;
    -+		buf += the_hash_algo->rawsz;
    -+		size -= the_hash_algo->rawsz;
    ++		memcpy(it->oid.hash, (const unsigned char*)buf, rawsz);
    ++		buf += rawsz;
    ++		size -= rawsz;
      	}
      
      #if DEBUG
 5: ff2f8a8106 !  5: 61c309cfbd resolve-undo: convert struct resolve_undo_info to object_id
    @@ -4,6 +4,9 @@
         
         Convert the sha1 member of this struct to be an array of struct
         object_id instead.  This change is needed to convert find_unique_abbrev.
    +    
    +    Convert some instances of hard-coded constants to use the_hash_algo as
    +    well.
         
         Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
     
    @@ -42,14 +45,29 @@
      	}
      }
     @@
    + 	size_t len;
    + 	char *endptr;
    + 	int i;
    ++	const unsigned rawsz = the_hash_algo->rawsz;
    + 
    + 	resolve_undo = xcalloc(1, sizeof(*resolve_undo));
    + 	resolve_undo->strdup_strings = 1;
    +@@
    + 		for (i = 0; i < 3; i++) {
    + 			if (!ui->mode[i])
      				continue;
    - 			if (size < 20)
    +-			if (size < 20)
    ++			if (size < rawsz)
      				goto error;
     -			hashcpy(ui->sha1[i], (const unsigned char *)data);
    -+			hashcpy(ui->oid[i].hash, (const unsigned char *)data);
    - 			size -= 20;
    - 			data += 20;
    +-			size -= 20;
    +-			data += 20;
    ++			memcpy(ui->oid[i].hash, (const unsigned char *)data, rawsz);
    ++			size -= rawsz;
    ++			data += rawsz;
      		}
    + 	}
    + 	return resolve_undo;
     @@
      		struct cache_entry *nce;
      		if (!ru->mode[i])
 6: 62757785a8 =  6: 6637a7cce4 tree: convert read_tree_recursive to struct object_id
 7: 5f4f67befa =  7: ce96caf197 ref-filter: convert grab_objectname to struct object_id
 8: 9e33fff56c =  8: b9743c9980 strbuf: convert strbuf_add_unique_abbrev to use struct object_id
 9: fee46a7ee4 =  9: 146483c174 wt-status: convert struct wt_status_state to object_id
10: 30a455ac10 ! 10: 5b0a4fc66e Convert find_unique_abbrev* to struct object_id
    @@ -464,7 +464,7 @@
      	advise("  %s %s%s",
     -	       find_unique_abbrev(oid->hash, DEFAULT_ABBREV),
     +	       find_unique_abbrev(oid, DEFAULT_ABBREV),
    - 	       typename(type) ? typename(type) : "unknown type",
    + 	       type_name(type) ? type_name(type) : "unknown type",
      	       desc.buf);
      
     @@
    @@ -532,7 +532,7 @@
      				name_to_report :
     -				find_unique_abbrev(oid->hash, DEFAULT_ABBREV),
     +				find_unique_abbrev(oid, DEFAULT_ABBREV),
    - 				typename(type));
    + 				type_name(type));
      
      	buf = read_sha1_file(oid->hash, &type, &size);
     @@
11: f3b86deb27 = 11: 781ae2e76c http-walker: convert struct object_request to use struct object_id
12: 7dcf103bc0 = 12: 0f4746b4e2 send-pack: convert remaining functions to struct object_id
13: 07abaa5a35 = 13: 884218b4fb replace_object: convert struct replace_object to object_id
14: 891fc02851 = 14: d726dff9e6 builtin/mktag: convert to struct object_id
15: d1bcf86847 = 15: 5b7d02b408 archive: convert write_archive_entry_fn_t to object_id
16: e42d7bc122 = 16: 0c7b33a72b archive: convert sha1_file_to_archive to struct object_id
17: d626f4f65b ! 17: 296eb04a77 builtin/index-pack: convert struct ref_delta_entry to object_id
    @@ -115,7 +115,7 @@
      
     -		if (check_sha1_signature(d->sha1, base_obj->data,
     +		if (check_sha1_signature(d->oid.hash, base_obj->data,
    - 				base_obj->size, typename(type)))
    + 				base_obj->size, type_name(type)))
     -			die(_("local object %s is corrupt"), sha1_to_hex(d->sha1));
     -		base_obj->obj = append_obj_to_pack(f, d->sha1,
     +			die(_("local object %s is corrupt"), oid_to_hex(&d->oid));
18: 351cdb6231 ! 18: 1cf89780db sha1_file: convert read_loose_object to use struct object_id
    @@ -67,7 +67,7 @@
      		}
     -		if (check_sha1_signature(expected_sha1, *contents,
     +		if (check_sha1_signature(expected_oid->hash, *contents,
    - 					 *size, typename(*type))) {
    + 					 *size, type_name(*type))) {
      			error("sha1 mismatch for %s (expected %s)", path,
     -			      sha1_to_hex(expected_sha1));
     +			      oid_to_hex(expected_oid));
19: 59865169a2 ! 19: 20a40e304f sha1_file: convert check_sha1_signature to struct object_id
    @@ -21,8 +21,8 @@
      		buf = read_sha1_file(oid->hash, &type, &size);
      		if (!buf)
      			die ("Could not read blob %s", oid_to_hex(oid));
    --		if (check_sha1_signature(oid->hash, buf, size, typename(type)) < 0)
    -+		if (check_object_signature(oid, buf, size, typename(type)) < 0)
    +-		if (check_sha1_signature(oid->hash, buf, size, type_name(type)) < 0)
    ++		if (check_object_signature(oid, buf, size, type_name(type)) < 0)
      			die("sha1 mismatch in blob %s", oid_to_hex(oid));
      		object = parse_object_buffer(oid, type, size, buf, &eaten);
      	}
    @@ -36,7 +36,7 @@
      
     -		if (check_sha1_signature(d->oid.hash, base_obj->data,
     +		if (check_object_signature(&d->oid, base_obj->data,
    - 				base_obj->size, typename(type)))
    + 				base_obj->size, type_name(type)))
      			die(_("local object %s is corrupt"), oid_to_hex(&d->oid));
      		base_obj->obj = append_obj_to_pack(f, d->oid.hash,
     
    @@ -89,11 +89,11 @@
      
      	buffer = read_sha1_file(oid->hash, &type, &size);
      	if (buffer) {
    --		if (check_sha1_signature(repl, buffer, size, typename(type)) < 0) {
    +-		if (check_sha1_signature(repl, buffer, size, type_name(type)) < 0) {
     +		struct object_id reploid;
     +		hashcpy(reploid.hash, repl);
     +
    -+		if (check_object_signature(&reploid, buffer, size, typename(type)) < 0) {
    ++		if (check_object_signature(&reploid, buffer, size, type_name(type)) < 0) {
      			free(buffer);
      			error("sha1 mismatch %s", sha1_to_hex(repl));
      			return NULL;
    @@ -114,8 +114,8 @@
      			err = error("cannot unpack %s from %s at offset %"PRIuMAX"",
      				    oid_to_hex(entries[i].oid.oid), p->pack_name,
      				    (uintmax_t)entries[i].offset);
    --		else if (check_sha1_signature(entries[i].oid.hash, data, size, typename(type)))
    -+		else if (check_object_signature(entries[i].oid.oid, data, size, typename(type)))
    +-		else if (check_sha1_signature(entries[i].oid.hash, data, size, type_name(type)))
    ++		else if (check_object_signature(entries[i].oid.oid, data, size, type_name(type)))
      			err = error("packed %s from %s is corrupt",
      				    oid_to_hex(entries[i].oid.oid), p->pack_name);
      		else if (fn) {
    @@ -162,6 +162,6 @@
      		}
     -		if (check_sha1_signature(expected_oid->hash, *contents,
     +		if (check_object_signature(expected_oid, *contents,
    - 					 *size, typename(*type))) {
    + 					 *size, type_name(*type))) {
      			error("sha1 mismatch for %s (expected %s)", path,
      			      oid_to_hex(expected_oid));
20: ea0c6804de = 20: 808277ddfd streaming: convert open_istream to use struct object_id
21: b14dd69baf ! 21: 17bb9e5947 builtin/mktree: convert to struct object_id
    @@ -90,8 +90,8 @@
      			 * because the new tree entry will never be correct.
      			 */
      			die("entry '%s' object %s is a %s but specified type was (%s)",
    --				path, sha1_to_hex(sha1), typename(obj_type), typename(mode_type));
    -+				path, oid_to_hex(&oid), typename(obj_type), typename(mode_type));
    +-				path, sha1_to_hex(sha1), type_name(obj_type), type_name(mode_type));
    ++				path, oid_to_hex(&oid), type_name(obj_type), type_name(mode_type));
      		}
      	}
      
22: 8d54506a22 ! 22: 3ac824fdcc sha1_file: convert assert_sha1_type to object_id
    @@ -64,6 +64,6 @@
      	if (type != expect)
     -		die("%s is not a valid '%s' object", sha1_to_hex(sha1),
     +		die("%s is not a valid '%s' object", oid_to_hex(oid),
    - 		    typename(expect));
    + 		    type_name(expect));
      }
      
23: 9e162450c4 = 23: c65ffc3955 sha1_file: convert retry_bad_packed_offset to struct object_id
24: 4f9b84dc45 = 24: c4a4f9a98e packfile: convert unpack_entry to struct object_id
25: c7a2206ff9 = 25: 3d92a7ac4b Convert remaining callers of sha1_object_info_extended to object_id
26: 4f148256d4 ! 26: ae7dbea778 sha1_file: convert sha1_object_info* to object_id
    @@ -79,13 +79,26 @@
      	return 0;
       error_out:
     
    +diff --git a/builtin/blame.c b/builtin/blame.c
    +--- a/builtin/blame.c
    ++++ b/builtin/blame.c
    +@@
    + 
    + 	if (get_oid(name, &oid))
    + 		return 0;
    +-	return OBJ_NONE < sha1_object_info(oid.hash, NULL);
    ++	return OBJ_NONE < oid_object_info(&oid, NULL);
    + }
    + 
    + int cmd_blame(int argc, const char **argv, const char *prefix)
    +
     diff --git a/builtin/cat-file.c b/builtin/cat-file.c
     --- a/builtin/cat-file.c
     +++ b/builtin/cat-file.c
     @@
      	switch (opt) {
      	case 't':
    - 		oi.typename = &sb;
    + 		oi.type_name = &sb;
     -		if (sha1_object_info_extended(oid.hash, &oi, flags) < 0)
     +		if (oid_object_info_extended(&oid, &oi, flags) < 0)
      			die("git cat-file: could not get object info");
    @@ -139,6 +152,19 @@
      		       obj_name ? obj_name : oid_to_hex(&data->oid));
      		fflush(stdout);
     
    +diff --git a/builtin/describe.c b/builtin/describe.c
    +--- a/builtin/describe.c
    ++++ b/builtin/describe.c
    +@@
    + 
    + 	if (cmit)
    + 		describe_commit(&oid, &sb);
    +-	else if (sha1_object_info(oid.hash, NULL) == OBJ_BLOB)
    ++	else if (oid_object_info(&oid, NULL) == OBJ_BLOB)
    + 		describe_blob(oid, &sb);
    + 	else
    + 		die(_("%s is neither a commit nor blob"), arg);
    +
     diff --git a/builtin/fast-export.c b/builtin/fast-export.c
     --- a/builtin/fast-export.c
     +++ b/builtin/fast-export.c
    @@ -268,7 +294,7 @@
     -		enum object_type type = sha1_object_info(oid->hash, NULL);
     +		enum object_type type = oid_object_info(oid, NULL);
      		printf("%s %s\n", oid_to_hex(oid),
    - 		       (type > 0) ? typename(type) : "unknown");
    + 		       (type > 0) ? type_name(type) : "unknown");
      	}
     
     diff --git a/builtin/replace.c b/builtin/replace.c
    @@ -283,8 +309,8 @@
     +			obj_type = oid_object_info(&object, NULL);
     +			repl_type = oid_object_info(oid, NULL);
      
    - 			printf("%s (%s) -> %s (%s)\n", refname, typename(obj_type),
    - 			       oid_to_hex(oid), typename(repl_type));
    + 			printf("%s (%s) -> %s (%s)\n", refname, type_name(obj_type),
    + 			       oid_to_hex(oid), type_name(repl_type));
     @@
      	struct ref_transaction *transaction;
      	struct strbuf err = STRBUF_INIT;
    @@ -297,13 +323,13 @@
      		die("Objects must be of the same type.\n"
      		    "'%s' points to a replaced object of type '%s'\n"
     @@
    - 	if (get_oid(object_ref, &old) < 0)
    + 	if (get_oid(object_ref, &old_oid) < 0)
      		die("Not a valid object name: '%s'", object_ref);
      
    --	type = sha1_object_info(old.hash, NULL);
    -+	type = oid_object_info(&old, NULL);
    +-	type = sha1_object_info(old_oid.hash, NULL);
    ++	type = oid_object_info(&old_oid, NULL);
      	if (type < 0)
    - 		die("unable to get object type for %s", oid_to_hex(&old));
    + 		die("unable to get object type for %s", oid_to_hex(&old_oid));
      
     
     diff --git a/builtin/tag.c b/builtin/tag.c
    @@ -401,7 +427,7 @@
      					S_ISDIR(mode) ?  "Tree" : "Blob",
     @@
      			die("Not a blob (actually a %s): %s",
    - 				typename(oe->type), command_buf.buf);
    + 				type_name(oe->type), command_buf.buf);
      	} else if (!is_null_oid(&oid)) {
     -		enum object_type type = sha1_object_info(oid.hash, NULL);
     +		enum object_type type = oid_object_info(&oid, NULL);
    @@ -539,7 +565,7 @@
     +				enum object_type type = oid_object_info(&oid,
     +									NULL);
      				return error(_("%s: can't cherry-pick a %s"),
    - 					name, typename(type));
    + 					name, type_name(type));
      			}
     
     diff --git a/sha1_file.c b/sha1_file.c
27: a2c063aac7 = 27: 7621154915 builtin/fmt-merge-msg: convert remaining code to object_id
28: 981277d812 = 28: a7245b9137 builtin/notes: convert static functions to object_id
29: b856198f19 = 29: 1bd6edfaa4 tree-walk: convert get_tree_entry_follow_symlinks internals to object_id
30: bf15b40528 = 30: 5107f04efe streaming: convert istream internals to struct object_id
31: 1f3a02f2ef = 31: f616bf9ce1 tree-walk: convert tree entry functions to object_id
32: 55f95e2765 = 32: 093f6e92f9 sha1_file: convert read_object_with_reference to object_id
33: 09e4ac139e ! 33: e0e0f888c6 sha1_file: convert read_sha1_file to struct object_id
    @@ -189,7 +189,7 @@
     +		buf = read_object_file(oid, &type, &size);
      		if (!buf)
      			die ("Could not read blob %s", oid_to_hex(oid));
    - 		if (check_object_signature(oid, buf, size, typename(type)) < 0)
    + 		if (check_object_signature(oid, buf, size, type_name(type)) < 0)
     @@
      		return;
      	}
    @@ -585,10 +585,10 @@
      static void *read_blob_entry(const struct cache_entry *ce, unsigned long *size)
      {
      	enum object_type type;
    --	void *new = read_sha1_file(ce->oid.hash, &type, size);
    -+	void *new = read_object_file(&ce->oid, &type, size);
    - 
    - 	if (new) {
    +-	void *blob_data = read_sha1_file(ce->oid.hash, &type, size);
    ++	void *blob_data = read_object_file(&ce->oid, &type, size);
    + 
    + 	if (blob_data) {
      		if (type == OBJ_BLOB)
     
     diff --git a/fast-import.c b/fast-import.c
    @@ -657,7 +657,7 @@
      
     -	unpacked = read_sha1_file(request->obj->oid.hash, &type, &len);
     +	unpacked = read_object_file(&request->obj->oid, &type, &len);
    - 	hdrlen = xsnprintf(hdr, sizeof(hdr), "%s %lu", typename(type), len) + 1;
    + 	hdrlen = xsnprintf(hdr, sizeof(hdr), "%s %lu", type_name(type), len) + 1;
      
      	/* Set it up */
     
    @@ -973,7 +973,7 @@
     +++ b/tag.c
     @@
      				find_unique_abbrev(oid, DEFAULT_ABBREV),
    - 				typename(type));
    + 				type_name(type));
      
     -	buf = read_sha1_file(oid->hash, &type, &size);
     +	buf = read_object_file(oid, &type, &size);
34: d5f315fd57 ! 34: 42aef22217 Convert lookup_replace_object to struct object_id
    @@ -88,8 +88,8 @@
     -		struct object_id reploid;
     -		hashcpy(reploid.hash, repl);
     -
    --		if (check_object_signature(&reploid, buffer, size, typename(type)) < 0) {
    -+		if (check_object_signature(repl, buffer, size, typename(type)) < 0) {
    +-		if (check_object_signature(&reploid, buffer, size, type_name(type)) < 0) {
    ++		if (check_object_signature(repl, buffer, size, type_name(type)) < 0) {
      			free(buffer);
     -			error("sha1 mismatch %s", sha1_to_hex(repl));
     +			error("sha1 mismatch %s", oid_to_hex(repl));
    @@ -147,14 +147,14 @@
     -	const unsigned char *real = (flags & OBJECT_INFO_LOOKUP_REPLACE) ?
     -				    lookup_replace_object(oid->hash) :
     -				    oid->hash;
    -+	const struct object_id *real = (flags & OBJECT_INFO_LOOKUP_REPLACE) ?
    -+				       lookup_replace_object(oid) :
    -+				       oid;
    ++	const struct object_id *real = oid;
      	int already_retried = 0;
     -	struct object_id realoid;
    --
    + 
     -	hashcpy(realoid.hash, real);
    --
    ++	if (flags & OBJECT_INFO_LOOKUP_REPLACE)
    ++		real = lookup_replace_object(oid);
    + 
     -	if (is_null_sha1(real))
     +	if (is_null_oid(real))
      		return -1;
35: c7db0519ee = 35: 3cc49890bd sha1_file: introduce a constant for max header length
36: 2c6a3f6d11 = 36: 919dba36a5 convert: convert to struct object_id
