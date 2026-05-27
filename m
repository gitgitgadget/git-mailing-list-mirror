Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A3B3C1977
	for <git@vger.kernel.org>; Wed, 27 May 2026 23:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779923928; cv=none; b=TOieH0fuB+fgzrPwuibIUVCztr1nmrjycy3r42Z/25rr4QQLj6FtttoQe1hOee0yOMTqZiqgwtFP5rTk4TsmGZ3RZGCiXU/hYp+H7Ermw2S+e7/kYwHhVl02CwX0MTAQJ1IqDyppwPzrWRbHr1e/mS2Fh/uMMOXy1WILxPlDBmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779923928; c=relaxed/simple;
	bh=cPIsBhS7RQ8Iz81A87WZ0+lNR4c+qO8qtEk8URmEQYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J7gAWHj4rh0qK+EWmsJ5joO9JAHdrO0/2h3cVRbDWGaNmidtIc+r6CIin+qvxAQdaPFKCtgBaprNYnicepye5Lqy3LnW48f4nUeyUSp+Lg5EywyRDAsCQkdP6SkoRP1rVhRUcprC67+eR34y6WMBQXtBdRJCeAo7DH8fCPi/+tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=Of11RTPz; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="Of11RTPz"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-7cb343d343fso115612297b3.2
        for <git@vger.kernel.org>; Wed, 27 May 2026 16:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1779923926; x=1780528726; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6kKOU8Pg5Bq5D/GuJyzs+OlaM/yDYNMb5HBwY+mgvhQ=;
        b=Of11RTPzgInNFdqJlIKmfixEvzGO8KfWMPJhVb/HI1dpt9SDVq5pgCq4cc476h0sOq
         wKZMnGm8Ho+EVpcVeXDg5YwEHAN6CV98gxYbc0ly0k/0SLHVxTpF8QPJ2bNk3Xlt/gDq
         i0H4IU1MVjIwWXwt6bjTENj4u4YVF2cXjM36XFSVpj6s98ZF9xQdEaaRUJkryuIXC2uZ
         9L+uzkND7u0EWbEaFH1jCNUJ5J9TMOWPJ1FxJh+Y7cRusOAA/sDuWwwy1mZsFpkxkhUn
         emRoRwEqfTC5GFT3cL7ZNMEKLvSgQ84MEHhMmx4w/9RRA97hNeDRIULhdBsFaDsVipFN
         CcIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779923926; x=1780528726;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6kKOU8Pg5Bq5D/GuJyzs+OlaM/yDYNMb5HBwY+mgvhQ=;
        b=AvUQMc4j6+phKSfCu1fREq+eAanRdNlqmGrzV6iPyTDcKOPb+RNSyT/psnEc0tCzXq
         xZhu3yShAee/VKJIa/+7zY8R1mx+awogQX4ijJOoc1dkxl42YN8k9pgDErFb2YU2Q9iE
         8WuZ9qHtVJZvABbxxLdWSYcc2OGix+1qM7XnZrKmHbgNCw2SC20nv715W+ObQW8YYm0S
         wzbcGuq8BC8WlIHX+fjOqGIMiZTeISr+kx+5+1AjwKF15TixYT4R0w8nY0tQIcWbcPa9
         oRUjLpcy2ZHS9Bz0pC9VTOLgkhkrACsqsmdPmVEpOMFMnoa3ixBO3B6JmLh0O08clb7v
         JAsQ==
X-Gm-Message-State: AOJu0Yzu49htC/3A7EmlHi/+ikUPRoD0hGCAvtcXD6mrDlNEwTv45RLS
	BXdFLsoEhxKpm/nIg4NXg6uSDPQVQ1xdtxuqRirzDyYLXk7F6Bcay82zN4UIehfYeP9H8nCM4FC
	7wOpU
X-Gm-Gg: Acq92OG8ODa58Da0wPzZnUpMZeyqxkIA9Qm51ZzrUR9R55ZTEIZkgoW+c8zuq8rXAiD
	FtKmmvX5BWXB52rDg7SUajbS8N4CdW3rkm1e9auljmGjqLtC08FXzsqpZmnmLKtMWe5bCJJKWNl
	9oxreUDWdYa8uY41dLTaVmSmHI+07dHQAT9GxKQeZT1va9vA9N/DvkpMU2MPznkngFmX8+4yo/F
	oLpAdBjs766UnGWcUZGbtRCdMPqXHqdNY0/tqriXcWY3vbQggiNVk4iUC8f+l4RyeAk/YZcQFI4
	ft+spw0gA2eJo3uk1bqbSY/SnTEtnY95zpNRu2ZWbQNIpeWD5RBYD18j0vNlw746dmLuvz5JN5C
	i1q6j2aI6FuFmBqms8+ox9mHy3+z0jlklXJlMoH1ca49LaY83uRi97OLzWnFfgrkESpLmFRupg3
	3W9X45OhQxK0PnOUwzykvpJAH8HM4ST059K1o750YHcrkvOJL1LBNEmw4KhZWrtVfBVr1aW4Y8A
	Dpjmy978tnWI9uHL2TCxOBkDl+wyQVNEO8WEOmKbVjAjZXATCGrmZUObR+aZjhJ5w6URSq3smDv
	uPTzm6SKaST2WoM3m5a2ZVnbYGI=
X-Received: by 2002:a05:690c:88:b0:7bd:5c77:1aa9 with SMTP id 00721157ae682-7d330de95ebmr276053437b3.0.1779923925784;
        Wed, 27 May 2026 16:18:45 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7d38a21fc52sm81914937b3.21.2026.05.27.16.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 16:18:45 -0700 (PDT)
Date: Wed, 27 May 2026 19:18:44 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>
Subject: [PATCH 3/3] pack-objects: support `--delta-islands` with
 `--path-walk`
Message-ID: <a642305e3c9d089c539e1c52b89c417ab3dda498.1779923907.git.me@ttaylorr.com>
References: <cover.1779923907.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1779923907.git.me@ttaylorr.com>

Since the inception of `--path-walk`, this option has had a documented
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
option is sufficient: perform the same island side effects from the
path-walk callback rather than doing a second walk.

Recall how delta-islands are computed during a normal repack:

 - `show_commit()` calls `propagate_island_marks()` for each commit,
   which merges the commit's island bitset onto its root tree object and
   onto each of its parent commits.

 - `show_object()` for a tree records the tree's depth derived from the
   slash-separated pathname. Subsequent `resolve_tree_islands()` uses
   that depth to walk trees in increasing-depth order, propagating each
   tree's marks to its children.

 - At delta-search time, `in_same_island()` enforces that a delta
   target's island bitmap is a subset of its base's: every island that
   reaches the target must also reach the base.

Path-walk's enumeration callback is `add_objects_by_path()`. It already
adds objects to `to_pack`, but until now did not perform the
island-related side effects. Two things are needed:

 - For each commit batch, call `propagate_island_marks()` on commits,
   exactly as `show_commit()` does.

   We have to be careful about the order in which we call this function,
   and we must see a commit before its parents in order to have
   island marks to propagate.

   The path-walk batch preserves that order. Path-walk appends commits
   to its `OBJ_COMMIT` batch as they come back from the same
   `get_revision()` loop the regular traversal uses, and
   `add_objects_by_path()` iterates the batch in array order. So every
   commit reaches `propagate_island_marks()` in the same sequence that
   `show_commit()` would have seen it, and the descendant-first chain
   that the algorithm relies on is intact.

   Skip island propagation for excluded commits to match the regular
   traversal, whose `show_commit()` callback is only invoked for
   interesting commits. Boundary commits may still be present in
   path-walk's callback so they can serve as thin-pack bases, but they
   should not contribute island marks.

 - For each tree batch, record the tree's depth from the path. Use the
   `record_tree_depth()` helper from the previous commit so both
   callbacks behave identically, including the max-depth-wins behavior
   when a tree is reached via more than one path. The helper accepts
   both the `show_object()` path shape ("foo", "foo/bar") and the
   path-walk shape with a trailing slash ("foo/", "foo/bar/"), so depths
   recorded from either traversal mode are directly comparable.

   This is implicit in the implementation sketch from Peff above.
   `resolve_tree_islands()` sorts trees by `oe->tree_depth` in
   increasing-depth order before propagating marks down, so that a
   parent tree's marks are finalized before its children inherit them.
   Without recording the depth at path-walk time, every
   path-walk-discovered tree would land at depth 0 in `to_pack`, the
   sort would lose its ordering, and children could inherit marks from
   parents whose own contributions had not yet been merged in.

With those two pieces in place, `resolve_tree_islands()` receives the
same island inputs from path-walk as it would from the regular
traversal, so the existing island checks can be reused unchanged.

Drop the documented incompatibility between `--path-walk` and
`--delta-islands`, and add t5320 coverage for path-walk island repacks
with and without bitmap writing, as well as the same-island case where a
delta remains allowed.

[1]: https://lore.kernel.org/git/9aa2471b-0850-4707-9733-d3b33609f5f2@gmail.com/
[2]: https://lore.kernel.org/git/20240911063203.GA1538586@coredump.intra.peff.net/

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/git-pack-objects.adoc | 14 +++++++-------
 builtin/pack-objects.c              | 22 ++++++++++++++++++----
 t/t5320-delta-islands.sh            | 29 +++++++++++++++++++++++++++++
 3 files changed, 54 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-pack-objects.adoc b/Documentation/git-pack-objects.adoc
index 0adce8961a3..65cd00c152f 100644
--- a/Documentation/git-pack-objects.adoc
+++ b/Documentation/git-pack-objects.adoc
@@ -402,13 +402,13 @@ will be automatically changed to version `1`.
 	of filenames that cause collisions in Git's default name-hash
 	algorithm.
 +
-Incompatible with `--delta-islands`. When `--use-bitmap-index` is
-specified with `--path-walk`, a successful bitmap traversal is used for
-object enumeration, with path-walk remaining as the fallback traversal
-when the bitmap cannot satisfy the request. The `--path-walk` option
-supports the `--filter=<spec>` forms `blob:none`, `blob:limit=<n>`,
-`tree:0`, `object:type=<type>`, and `sparse:<oid>`. These supported filter
-types can be combined with the `combine:<spec>+<spec>` form.
+When `--use-bitmap-index` is specified with `--path-walk`, a successful
+bitmap traversal is used for object enumeration, with path-walk
+remaining as the fallback traversal when the bitmap cannot satisfy the
+request. The `--path-walk` option supports the `--filter=<spec>` forms
+`blob:none`, `blob:limit=<n>`, `tree:0`, `object:type=<type>`, and
+`sparse:<oid>`. These supported filter types can be combined with the
+`combine:<spec>+<spec>` form.
 
 
 DELTA ISLANDS
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index ec02e2b21d2..f48ea7a888b 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -4737,13 +4737,29 @@ static int add_objects_by_path(const char *path,
 
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
 
@@ -5205,8 +5221,6 @@ int cmd_pack_objects(int argc,
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
2.54.0.22.ga642305e3c9
