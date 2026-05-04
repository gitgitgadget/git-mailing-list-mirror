Received: from mail-yw1-f195.google.com (mail-yw1-f195.google.com [209.85.128.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9B8BA3D
	for <git@vger.kernel.org>; Mon,  4 May 2026 00:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777853498; cv=none; b=EZ7kSXKakPSP3L5JZG8KRaRSNZYDVGT1ZNjL656p6dHe1TyfCPpSjawJAJHUtvjWDotI0ZqnVpTNpK2zJ+eexmkvQGyHvKhxuHC93+5f1tF3zZufcbLuH95Ni3nq84cCcEi+BNHZs9rPqi6aezbN+aigYnPS5tghvgalhQQajkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777853498; c=relaxed/simple;
	bh=tAMjYdwkcx067n4cUSw1xpy8560B8tZ0BZBFhV7gEU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HgNOxqfwfh3jWHF9Z5rVx/6L7gxEWFO/nZ8FDKl8xiwo8fqMaG9et/F2svFGQGMvEoEKV2FLThJne5hOo8r3Jip9cNyc+k1zRba0lQFuwfcNMBeueI1BzJam6H9F+lnb3a4Uehxta+bZgMiaO/WV1LhcSaP5YuiAA3o9JY7r/pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=dH5Uw7qc; arc=none smtp.client-ip=209.85.128.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="dH5Uw7qc"
Received: by mail-yw1-f195.google.com with SMTP id 00721157ae682-79ab3e26cceso30733677b3.3
        for <git@vger.kernel.org>; Sun, 03 May 2026 17:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1777853496; x=1778458296; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HHJjxr4afZGOpd1TbZt6NutFDZCVAnnSgtinWo1bJuc=;
        b=dH5Uw7qcb7tIMB6s+ah880OkKRLqVfo65vER4PI4nb75FosLngNSmQiGxoYH9JcliP
         M83vEAN5311Ktn6GjlzksqNyO9YuoI4nQoLUoYwgSsqniU/AGnOM4HiflvF29g8tFOc2
         CXMV3RIXAXFq5mBVzGfIzgqfBNK6LAUB04zND/Xbj+2bINvvuEfh2qcf6X10HKLhemWo
         1ca4win4EJjNa1GCn1/dKSgdUGfADrOz6vO1hb77L7wgq501CwgT1bGPBmtq3Cup6mG6
         OXQVUivHLAY6sB2OjsMWYpjSkwXeLUStMH2AwH/bL0QCvkukiu/RZFBpzcyP//Mbye7V
         h47Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777853496; x=1778458296;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HHJjxr4afZGOpd1TbZt6NutFDZCVAnnSgtinWo1bJuc=;
        b=LfQYJ9IPyvz9hg7JwN5/9kGw9P7JANIF9/AtkdxfHwH3xVJ/vrSTZIK/RHUK1Cckc7
         qpQSQU0fZVneyjZTWdpzwXX0ok4UaDOraguzIyC+tL60a6pmz/dvXBvUjxIkrupyEGPm
         5XuVTfTBH7LGpVaJ8WuIDDsyGHHeoJikrS9KeD6JXp0zwjavkCtc6QZZ92xmE1fPuemj
         QJ46f+uA6EKt9git9Oz7r4BGllTUDW2C+nbXIjNKJK95685wek2TAVoGWnvGpLcGiKCh
         8sNP+Hbhosjfk+Mh9qOViEBB6Ws5SjKohn3NjHrbIYnoMQqwc0VCj30a6pS44DGPIQEN
         o6mA==
X-Gm-Message-State: AOJu0Yw5FEGIjTDgeUH/dQXjSYc3wcBDnA5ZwATaizSM6pTLncCwjjBh
	80AQicwEETbzsCgxsU8ZkNjo34/OawtYOj5xLphCCx2/QVqx+4nTXLC+Gv82YaaCn9paNTKa1rA
	gYrtd75OgOG1W
X-Gm-Gg: AeBDieux1tmYqMML5gQ/Y4geVWICg/hSMTv6pMdPRBZMf3GltzhuVxXfBMk7+v9/8r+
	7wDo/bZEPuu1w5K7xXLkIxfsVfEkRloXFI1j+6ZQ8s8gQ2on/Ovsc+P/0fOinGMGsFh1+mmMTYS
	NdLooRxMPdnYtfjTTF+5HXc+A/eLACRGCBkWMGv9OPWvax0hWGGMyeTGDNhB6tMKZ0hRNh5wexU
	FyIXoAFuGldq6luh7ECpnU5/R8fdyrmJrWWW+rthSZqf3Gf6Wogyba/vN6dMXLS8BSWfcbf3aV3
	WLK6qY0thVv3mN/DuOdm3JaAy9TuJExlyLcfJnGHNWhVbCz1ikETW1IHIVaTO9/jHrtwhXFwE16
	V+cSiHeK9b4KlrZ+U9PXT2BK7N/v+ACumxxrjczJhHvCbdNJ9RYzS65l3TFN33GCR4UQxnpZ+9S
	fmDS+S2GT4516tYE6s43d+hZodDeloDLECi3oNZ8GoNw4xn+Io/C6jEtp9nPiFLrLd0AR+KdTDc
	su2IX57qA1ry5Ay6PW86nzek/P3PjAM6yrKO/qWVYO5bOSTu1iqJr8/ohH3iPjNx3aXof5nr7Ow
	3GD/cEkqjhqF7SRhfM4jVhxDsJo=
X-Received: by 2002:a05:690c:3181:b0:7a2:80a9:93d1 with SMTP id 00721157ae682-7bd770dac5dmr80354537b3.25.1777853496019;
        Sun, 03 May 2026 17:11:36 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd6685d37fsm42126017b3.36.2026.05.03.17.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 17:11:35 -0700 (PDT)
Date: Sun, 3 May 2026 20:11:34 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Derrick Stolee <stolee@gmail.com>,
	Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>
Subject: [RFC PATCH 7/7] pack-objects: support `--delta-islands` with
 `--path-walk`
Message-ID: <0a1a9ed1e3c8f883587800c232e504937d706bc0.1777853408.git.me@ttaylorr.com>
References: <cover.1777853408.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1777853408.git.me@ttaylorr.com>

Since the inception of `--path-walk`, this option has a documented
incompatibility with `--delta-islands`.

When discussing those original patches on the list, a message from
Stolee in [1] noted the following:

    this could be remedied by [...] doing a separate walk to identify
    islands using the normal method

In a related portion of the thread, Peff explains[2]:

    The delta islands code already does its own tree walk to propagate
    the bits down (it does rely on the base walk's show_commit() to
    propagate through the commits).

    Once each object has its island bitmaps, I think however you
    choose to come up with delta candidates [...] you should be able
    to use it. It's fundamentally just answering the question of "am
    I allowed to delta between these two objects".

That is similar to what this patch does, and it turns out the cheaper
option (do the side-effects inside the path-walk callback rather than
via a second walk) is sufficient.

Recall how delta-islands are computed during a normal repack:

 - `show_commit()` calls `propagate_island_marks()` for each commit,
   which merges the commit's island bitset onto its root tree object and
   onto each of its parent commits.

 - `show_object()` for a tree records the tree's depth derived from the
   slash-separated pathname. Subsequent `resolve_tree_islands()` uses
   that depth to walk trees in increasing-depth order, propagating each
   tree's marks to its children.

 - At delta-search time, `in_same_island()` enforces that a delta
   target's island bitmap is a subset of its base's: every island
   that reaches the target must also reach the base.

Path-walk's enumeration callback is `add_objects_by_path()`. It already
adds objects to `to_pack', but until now did not perform any of the
island-related side effects. Two things are needed:

 - For each commit batch, call `propagate_island_marks()` on the commit,
   exactly as show_commit() does.

   Order matters here. `mark_remote_island_1()` only seeds marks on
   tip commits, so a non-tip commit has marks in the `island_marks` map
   only after some descendant has already had `propagate_island_marks()`
   run on it. If we see a commit before its descendants, its
   `island_marks` entry would still be empty, the call would be a no-op,
   and that commit's root tree would never receive any marks at all.

   As a consequence, `resolve_tree_islands()` would later look up the
   tree, find nothing, and propagate nothing. The traversal must visit
   children before parents.

   The path-walk batch preserves that order mechanically. Path-walk
   appends commits to its `OBJ_COMMIT` batch as they come back from the
   same `get_revision()` loop the regular traversal uses, and
   `add_objects_by_path()` iterates the batch in array order. So every
   commit reaches `propagate_island_marks()` in the same sequence that
   `show_commit()` would have seen it, and the descendant-first chain
   that the algorithm relies on is intact.

   Skip the call for boundary commits to match `show_commit()`, which is
   only invoked for interesting commits (this call is a no-op anyway for
   boundary commits since they are not in 'island_marks', but matching
   `show_commit()` exactly keeps the two enumeration modes tidy).

 - For each tree batch, record the tree's depth from the path. Use the
   `record_tree_depth()` helper from the previous commit so both
   callbacks behave identically, including the "max-depth-wins" behavior
   when a tree is reached via more than one path. The helper accepts
   both the show_object() path shape ("foo", "foo/bar") and the
   path-walk shape with a trailing '/' ("foo/", "foo/bar/"), so depths
   recorded from either traversal mode are directly comparable.

   This is implicit in the implementation sketch from Peff above.
   `resolve_tree_islands()` sorts trees by `oe->tree_depth` (ascending)
   before propagating marks down, so that a parent tree's marks are
   finalized before its children inherit them. Without recording the
   depth at path-walk time, every path-walk-discovered tree would land
   at depth 0 in `to_pack`, the sort would lose its ordering, and
   children could inherit marks from parents whose own contributions had
   not yet been merged in.

With those two pieces in place, `resolve_tree_islands()` receives
identical input to a normal traversal, so the existing correctness
argument carries over verbatim: depth-ordered processing guarantees that
a parent tree's marks are propagated to a child only after the parent
itself has been finalized, and the "is-this-a-subset" check at delta
time is the same regardless of how the marks got there.

Coverage in t5320 exercises both repack flavors (with and without '-b'),
confirms that cross-island deltas remain forbidden, and that
intra-island deltas are still allowed.

[1]: https://lore.kernel.org/git/9aa2471b-0850-4707-9733-d3b33609f5f2@gmail.com/
[2]: https://lore.kernel.org/git/20240911063203.GA1538586@coredump.intra.peff.net/

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/git-pack-objects.adoc | 15 +++++++--------
 builtin/pack-objects.c              | 22 ++++++++++++++++++----
 t/t5320-delta-islands.sh            | 29 +++++++++++++++++++++++++++++
 3 files changed, 54 insertions(+), 12 deletions(-)

diff --git a/Documentation/git-pack-objects.adoc b/Documentation/git-pack-objects.adoc
index 60e594c7bc4..aa7a9721203 100644
--- a/Documentation/git-pack-objects.adoc
+++ b/Documentation/git-pack-objects.adoc
@@ -402,14 +402,13 @@ will be automatically changed to version `1`.
 	of filenames that cause collisions in Git's default name-hash
 	algorithm.
 +
-Incompatible with `--delta-islands`. Path-walk supports
-the `--filter=<spec>` forms `blob:none`, `blob:limit=<n>`,
-`sparse:oid=<blob>`, `tree:0`, `object:type=<type>`, and `combine:`
-over any of those. Other filter forms fall back to the regular object
-traversal. When `--use-bitmap-index` is specified with `--path-walk`, a
-successful bitmap traversal is used for object enumeration, with
-path-walk remaining as the fallback traversal when the bitmap cannot
-satisfy the request.
+Path-walk supports the `--filter=<spec>` forms `blob:none`,
+`blob:limit=<n>`, `sparse:oid=<blob>`, `tree:0`, `object:type=<type>`,
+and `combine:` over any of those. Other filter forms fall back to the
+regular object traversal. When `--use-bitmap-index` is specified with
+`--path-walk`, a successful bitmap traversal is used for object
+enumeration, with path-walk remaining as the fallback traversal when
+the bitmap cannot satisfy the request.
 
 
 DELTA ISLANDS
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 842d1fcac29..d79366db3de 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -4739,13 +4739,29 @@ static int add_objects_by_path(const char *path,
 
 		add_object_entry(oid, type, path, exclude);
 
-		if (type == OBJ_COMMIT && write_bitmap_index) {
+		if (type == OBJ_COMMIT) {
 			struct commit *commit;
 
+			if (!write_bitmap_index && !use_delta_islands)
+				continue;
+
 			commit = lookup_commit(the_repository, oid);
 			if (!commit)
 				die(_("could not find commit %s"), oid_to_hex(oid));
-			index_commit_for_bitmap(commit);
+			if (write_bitmap_index)
+				index_commit_for_bitmap(commit);
+			/*
+			 * Skip island propagation for boundary commits.
+			 * The regular traversal's show_commit() is only
+			 * called for interesting commits; matching that
+			 * here keeps path-walk from doing extra work that
+			 * would only be a no-op anyway (boundary commits
+			 * are not in island_marks).
+			 */
+			if (use_delta_islands && !exclude)
+				propagate_island_marks(the_repository, commit);
+		} else if (type == OBJ_TREE && use_delta_islands) {
+			record_tree_depth(oid, path);
 		}
 	}
 
@@ -5196,8 +5212,6 @@ int cmd_pack_objects(int argc,
 		const char *option = NULL;
 		if (!path_walk_filter_compatible(&filter_options))
 			option = "--filter";
-		else if (use_delta_islands)
-			option = "--delta-islands";
 
 		if (option) {
 			warning(_("cannot use %s with %s"),
diff --git a/t/t5320-delta-islands.sh b/t/t5320-delta-islands.sh
index 2c961c70963..9b28344a0a3 100755
--- a/t/t5320-delta-islands.sh
+++ b/t/t5320-delta-islands.sh
@@ -53,6 +53,35 @@ test_expect_success 'separate islands disallows delta' '
 	! is_delta_base $two $one
 '
 
+test_expect_success 'path-walk island repack respects islands' '
+	GIT_TRACE2_EVENT="$(pwd)/trace.path-walk-islands" \
+		git -c "pack.island=refs/heads/(.*)" repack -adfi \
+		--path-walk 2>err &&
+	test_region pack-objects path-walk trace.path-walk-islands &&
+	test_grep ! "cannot use --delta-islands with --path-walk" err &&
+	! is_delta_base $one $two &&
+	! is_delta_base $two $one
+'
+
+test_expect_success 'path-walk island bitmap repack respects islands' '
+	GIT_TRACE2_EVENT="$(pwd)/trace.path-walk-island-bitmap" \
+		git -c "pack.island=refs/heads/(.*)" repack -a -d -f -i -b \
+		--path-walk 2>err &&
+	test_region pack-objects path-walk trace.path-walk-island-bitmap &&
+	test_path_is_file .git/objects/pack/*.bitmap &&
+	git rev-list --test-bitmap --use-bitmap-index one &&
+	test_grep ! "cannot use --delta-islands with --path-walk" err &&
+	! is_delta_base $one $two &&
+	! is_delta_base $two $one
+'
+
+test_expect_success 'path-walk same island allows delta' '
+	GIT_TRACE2_EVENT="$(pwd)/trace.path-walk-same-island" \
+		git -c "pack.island=refs/heads" repack -adfi --path-walk &&
+	test_region pack-objects path-walk trace.path-walk-same-island &&
+	is_delta_base $one $two
+'
+
 test_expect_success 'same island allows delta' '
 	git -c "pack.island=refs/heads" repack -adfi &&
 	is_delta_base $one $two
-- 
2.54.0.4.g6aa0d38a4ec
