Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795500774;
	b=MTgEJ3dCy9hVGSMViLXnN2p1E3sFLt2o18k+XL/cs27ysIvRgeIyuzxQsgx6z1jhVWBA
	 AE1nNgqmUp3Qg24guPJa2C4wE1jAZPa6qAXJw/lBr3JKSa4Pb9wJ2GYr7SXcqxWMMRZY5
	 7qZ9094MmwTlTudVY0j7sHj5lCrROEL+Fm5LCyhXytB4N3oao5zBYA/HBxbvQwCwRmMj4
	 ia8V7gY7lsNnrx4zL8+u62QPRqmgvcBjqT54RxWRO+x7Usg4FmPs9HU2xztDbMARe9Ert
	 83Cw5AEa0qxOAW2BHighmUEhOn6rSr17RKCZOUj05P8fwRCm+ncwf1bnCrDFqKOewGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795500774;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=h+S9rx/m84p9Fu9s0S9jz2uKEdWp8frdgM7v2LqS02Y=;
	b=su7NDqXbHLuqJGDZfpdYZ8FIbYawd0Jp6PYtZhuDDfO9i6cDl/g3bxFjsjXVtnPP+b+r
	 W++bWN1nlMiG6aKNmzrR3K5KeFydq6qZhBOnfEhywjeXlCoOROY3eOEJL/KWSZEEtwvLG
	 vQRCi49PGuHfXw1OL6Tx3VRPl26x9jbL4gGWNm2jgWQIyNrzOHrl6qWUFvDhFz0Om0TAg
	 yIg1zNi4PAUy749bEocudUuIrvgGe08OrolM/6kBc91n9RxZ+Bb/S0a22a55Bgw5LqV/p
	 CGQnUViU6iDSyJssXvQd79mQqwmman3ajwrG1jc+vvEslfCpXYINnhS7yCbKYmtJ6dg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w8P8F5Dh;
	arc=none smtp.remote-ip=209.85.215.172
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84755606A332
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 06:12:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84755606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w8P8F5Dh
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cd61cef87f1so1727476a12.0
        for <git@vger.kernel.org>; Mon, 23 Nov 2026 22:12:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795500773; x=1796105573; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=h+S9rx/m84p9Fu9s0S9jz2uKEdWp8frdgM7v2LqS02Y=;
        b=w8P8F5DhtW281FykTv49VUkWMfhjMs4B5BMnn8Um1BDm8q4zLSFoIjf4zwlVa+nGRE
         M/pIzpaCbzrkGZ/RnC2QVn8v8YbJCJgcveoXYQs4cSt4n1yROL3dQqxGm+4jum2eS8CK
         Z4396lQs3djxs4XePXgAxQcfOo68IpFJuZgIsBRCtQ50DrMxOtl0/j+KzBlXccKf2kHl
         ir5cNfGhjQ23+HKLQOHQqNHnryFRerQM8+4eLrFkZdt6BvSYX3xYVisT+m8R0o3yzwBq
         +OYfbdLpR6EzrHoPxFYFwLndX4IVWz/a9nWU6llU0vpS90Cdlq+0t3BebS7RN6XG6bhh
         1KvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795500773; x=1796105573;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h+S9rx/m84p9Fu9s0S9jz2uKEdWp8frdgM7v2LqS02Y=;
        b=EVldSD0UNwnRVYhUUCrXKguwhtO9AwE/fk2XoBo63BY1EuzQKi68TVCNhMEh+mr3CW
         bmTgJci+7WcLdHVDLPfNcoL5PpKN5wWLxGI0taW2cgVZoDkoeVjXxVoYGyWp0lvBGJkP
         qZiN9uIwX6KvxfP0V4RT55j8NxlQ9YIQwfAAPhFMdqzUJVi7kx/MHJ0pQArixgXO/mec
         S7OJjIF4Z1ZPqftTmeK0v8laj6dBPb5h1iIYBxq3JlJdMzWKwUjSjyVAH1jmBBfxvOCI
         8xU7bYaRR6kQ54LFurz4F7uzvTTCsO7KL3tonTcFOXo3pFDdVGFZEmrb8bB/IsfamDjc
         Oqcg==
X-Gm-Message-State: APuU4Z9pRjaQcTFQzzKQxkTlc5sgSufgdxCR3dXKi9asONVyubdPIer7
	HgYZoI79Y4Rq42dc4L6xQwHPqQLOZ+uMiHj14Kn4sP1u+UT4s+qMc2F5lSKhXw==
X-Gm-Gg: AZFdTZfYrKvU4HcRo0ntze/9X6bTt6Jjo3j70ENGA+CEmbrIC9npvaz8CH7b9p5kOfV
	eOazJJgXaQNcOyXue2eh7k4MwgfaEhNHqwCwERkH97PpHoQP/tNMZUPl+bMlqdDUmOYX+M096c6
	jDI4hHRRsR39seo82kuN/fSbkA4csUf43tf5blAZ4+03zUVHwv3IvnTc2fXpGa4FzqMZ82h7ycF
	YUniHwaejjnxLPdZUkwj9oMlUNFcFo+ZkSlh0qtCjILwtz/60tQeXb3KT+zpYYTYNJCLaH5l4zR
	d3CeykYno+6zdAuJzxXbA/nt/8cxGo8bjfRtBE5sm6ONuhBaiIqYZsv2sqiJum3LHXrRRhxr73Q
	aYwCWX3iT61idJvyeaZacFep2PBqBw7HRF8mlGIA93HL8A+tCkFYN4+86W4lkLHCmE++4QZyIya
	MZEG25rKAKZhUn7Azcfhl1Sn3r9Z7S0/ZdNYz3/fARgi4+5vtVgrK1UWHoaLZscYfgWCF3wzpC7
	H7/bP7w0YWBkw6D0FMk/Dl/VqZWXVGWFfWG1KWn/t6zehnP6K+xgLXtmJ/XwB/2enqz8YRTzBNJ
	vSfbIeJ+qItoKHG/QEF/M7lz9VrhIQ==
X-Received: by 2002:a17:90b:388d:b0:3ac:fe93:a731 with SMTP id 98e67ed59e1d1-3b41cb235d6mr12494631a91.56.1795500772727;
        Mon, 23 Nov 2026 22:12:52 -0800 (PST)
Received: from [127.0.0.1] ([57.154.4.118])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b44b7c6513sm9500115a91.4.2026.11.23.22.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 22:12:51 -0800 (PST)
Message-Id: <95c7bcab92fce595df48e85c1f2b645e714eeff2.1795500766.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2219.v5.git.1795500766.gitgitgadget@gmail.com>
References: <pull.2219.git.1789385483.gitgitgadget@gmail.com>
	<pull.2219.v5.git.1795500766.gitgitgadget@gmail.com>
From: "Qin ShiCheng via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 24 Nov 2026 06:12:46 +0000
Subject: [PATCH v5 3/3] repack: tell pack-objects which packs it may delete
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
    Taylor Blau <ttaylorr@openai.com>,
    Junio C Hamano <gitster@pobox.com>,
    Justin Tobler <jltobler@gmail.com>,
    qeesung <qeesung@live.com>,
    Qin ShiCheng <qeesung@live.com>

From: Qin ShiCheng <qeesung@live.com>

repack works out which packs are redundant by looking for ".keep"
files when it starts, then runs pack-objects, which looks for them all
over again when it opens the packs. Two scans of the same directory,
seconds apart, with nothing holding them together.

A ".keep" that turns up in between loses objects. The parent did not
see it, so the pack is on its list to delete. The child does see it,
so it leaves that pack to itself: its objects are not copied into the
new pack, not loosened for "-A", not kept for "-k" or "--cruft". The
parent deletes the pack regardless, as repack_remove_redundant_pack()
passes force_delete, which skips the ".keep" check in
unlink_pack_path(). The objects are gone and repack exits successfully.

The gap is easy to land in. index-pack names a pack after its contents
and writes its ".keep" before it renames the packfile into place, so a
"git fetch", or a push being migrated out of its quarantine, that
brings in a pack identical to one we already have puts a ".keep" next
to that pack. Checking for the ".keep" once more right before deleting
would not help: a push holds it for a fraction of a second, and it may
well be gone again by the time pack-objects has finished.

When we may delete packs, that is with "-d" and either "-a", "-A",
"--cruft" or "--geometric", write the names of the packs we may
delete, the non-kept and cruft packs, to a file next to the refs
snapshot we already write for "git multi-pack-index write", and pass it
to every pack-objects we spawn with "--ignore-pack-keep-from".
pack-objects then never treats those packs as kept, whatever appears
on the disk. Every other pack, whether kept when we started or showing
up later, still goes by its ".keep" file, so "--honor-pack-keep"
stays. Otherwise nothing gets deleted and nothing is passed.

The file has one name per line. A name with a newline in it gets split
there, which at worst makes some other pack not count as kept: its
objects may be copied, but none are lost.

Unreachable objects of such a pack are still dropped by "-a -d", or by
"--cruft-expiration" and "--unpack-unreachable" once they are old
enough, as these drop unreachable objects by design, and a pack written
again under the same name does not make them any younger; what changes
is that the objects that are to be kept no longer go with them.

The tests have a ".keep" appear on the pack about to be deleted as
pack-objects starts, through a "git" wrapper found via "--exec-path",
for "-a", "-A", "-k", "--cruft" with and without an expiration,
"--pack-kept-objects", "--filter" and "--geometric".

Signed-off-by: Qin ShiCheng <qeesung@live.com>
---
 builtin/repack.c            | 23 +++++++++++++++++
 repack.c                    | 26 ++++++++++++++++++++
 repack.h                    | 14 +++++++++--
 t/t7700-repack.sh           | 49 +++++++++++++++++++++++++++++++++++++
 t/t7703-repack-geometric.sh | 39 +++++++++++++++++++++++++++++
 5 files changed, 149 insertions(+), 2 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 71b3e9f56d..7e866b99b5 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -466,6 +466,28 @@ int cmd_repack(int argc,
 	string_list_sort(&keep_pack_list);
 	existing_packs_collect(&existing, &keep_pack_list);
 
+	/*
+	 * Tell pack-objects which packs we may delete. pack-objects looks
+	 * for ".keep" files on its own, and one that appears on such a
+	 * pack from now on must not make it leave out objects that would
+	 * then be deleted with the pack.
+	 */
+	if (delete_redundant &&
+	    ((pack_everything & ALL_INTO_ONE) || geometry.split_factor) &&
+	    existing_packs_has_non_kept(&existing)) {
+		struct strbuf path = STRBUF_INIT;
+		struct tempfile *non_kept_packs;
+
+		strbuf_addf(&path, "%s/tmp_non_kept_packs_XXXXXX",
+			    repo_get_object_directory(repo));
+
+		non_kept_packs = xmks_tempfile(path.buf);
+		existing_packs_write_non_kept(&existing, non_kept_packs);
+		po_args.ignore_pack_keep_from = get_tempfile_path(non_kept_packs);
+
+		strbuf_release(&path);
+	}
+
 	if (geometry.split_factor) {
 		if (pack_everything)
 			die(_("options '%s' and '%s' cannot be used together"), "--geometric", "-A/-a");
@@ -684,6 +706,7 @@ int cmd_repack(int argc,
 		cruft_po_args.quiet = po_args.quiet;
 		cruft_po_args.delta_base_offset = po_args.delta_base_offset;
 		cruft_po_args.pack_kept_objects = 0;
+		cruft_po_args.ignore_pack_keep_from = po_args.ignore_pack_keep_from;
 
 		ret = write_cruft_pack(&opts, cruft_expiration,
 				       combine_cruft_below_size, &names,
diff --git a/repack.c b/repack.c
index eecc9ce8bf..c94b3b234d 100644
--- a/repack.c
+++ b/repack.c
@@ -39,6 +39,9 @@ void prepare_pack_objects(struct child_process *cmd,
 		strvec_push(&cmd->args,  "--delta-base-offset");
 	if (!args->pack_kept_objects)
 		strvec_push(&cmd->args,  "--honor-pack-keep");
+	if (args->ignore_pack_keep_from)
+		strvec_pushf(&cmd->args, "--ignore-pack-keep-from=%s",
+			     args->ignore_pack_keep_from);
 	strvec_push(&cmd->args, out);
 	cmd->git_cmd = 1;
 	cmd->out = -1;
@@ -166,6 +169,29 @@ int existing_packs_has_non_kept(const struct existing_packs *existing)
 	return existing->non_kept_packs.nr || existing->cruft_packs.nr;
 }
 
+void existing_packs_write_non_kept(const struct existing_packs *existing,
+				   struct tempfile *f)
+{
+	struct string_list_item *item;
+	FILE *out = fdopen_tempfile(f, "w");
+
+	if (!out)
+		die(_("could not open tempfile %s for writing"),
+		    get_tempfile_path(f));
+
+	for_each_string_list_item(item, &existing->non_kept_packs)
+		fprintf(out, "%s.pack\n", item->string);
+	for_each_string_list_item(item, &existing->cruft_packs)
+		fprintf(out, "%s.pack\n", item->string);
+
+	if (close_tempfile_gently(f)) {
+		int save_errno = errno;
+		delete_tempfile(&f);
+		errno = save_errno;
+		die_errno(_("could not close non-kept packs tempfile"));
+	}
+}
+
 static void existing_pack_mark_for_deletion(struct string_list_item *item)
 {
 	item->util = (void*)((uintptr_t)item->util | DELETE_PACK);
diff --git a/repack.h b/repack.h
index 9f95e3a26f..6b9b0ab8fb 100644
--- a/repack.h
+++ b/repack.h
@@ -19,6 +19,11 @@ struct pack_objects_args {
 	int path_walk;
 	int delta_base_offset;
 	int pack_kept_objects;
+	/*
+	 * A file naming the packs this repack may delete, for
+	 * pack-objects' "--ignore-pack-keep-from"; the path is borrowed.
+	 */
+	const char *ignore_pack_keep_from;
 	struct list_objects_filter_options filter_options;
 };
 
@@ -28,6 +33,7 @@ struct pack_objects_args {
 }
 
 struct child_process;
+struct tempfile;
 
 void prepare_pack_objects(struct child_process *cmd,
 			  const struct pack_objects_args *args,
@@ -84,6 +90,12 @@ struct existing_packs {
 void existing_packs_collect(struct existing_packs *existing,
 			    const struct string_list *extra_keep);
 int existing_packs_has_non_kept(const struct existing_packs *existing);
+/*
+ * Write the names of the non-kept and cruft packs, the ones a repack may
+ * delete, to "f", one per line, for pack-objects' "--ignore-pack-keep-from".
+ */
+void existing_packs_write_non_kept(const struct existing_packs *existing,
+				   struct tempfile *f);
 int existing_pack_is_marked_for_deletion(struct string_list_item *item);
 void existing_packs_retain_cruft(struct existing_packs *existing,
 				 struct packed_git *cruft);
@@ -142,8 +154,6 @@ void pack_geometry_remove_redundant(struct pack_geometry *geometry,
 				    bool wrote_incremental_midx);
 void pack_geometry_release(struct pack_geometry *geometry);
 
-struct tempfile;
-
 enum repack_write_midx_mode {
 	REPACK_WRITE_MIDX_NONE,
 	REPACK_WRITE_MIDX_DEFAULT,
diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index 8a6b014c30..1fb7fb7c4c 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -964,4 +964,53 @@ test_expect_success '--path-walk keeps blobs from tagged trees at already visite
 	)
 '
 
+# Put a reachable commit and an unreachable one into a single pack X in a
+# new repository "keep-race", run "git repack" with the given options and
+# have a ".keep" appear on X as pack-objects starts, i.e. after the repack
+# has decided to delete X. The unreachable commit is saved in the file
+# "keep-race/unreachable".
+keep_race_repack () {
+	git init keep-race &&
+	(
+		cd keep-race &&
+		test_commit base &&
+		git commit-tree -m unreachable HEAD^{tree} >unreachable &&
+
+		git rev-list --objects --all $(cat unreachable) >objects &&
+		X=$(git pack-objects .git/objects/pack/pack <objects) &&
+		git prune-packed &&
+
+		mkdir shim &&
+		write_script shim/git <<-EOF &&
+		test "\$1" = "pack-objects" &&
+		>"$(pwd)/.git/objects/pack/pack-$X.keep" &&
+		>"$(pwd)/keep-created"
+		GIT_EXEC_PATH="$GIT_EXEC_PATH" exec "$GIT_EXEC_PATH/git" "\$@"
+		EOF
+
+		git --exec-path="$(pwd)/shim" repack "$@" &&
+		test_path_is_file keep-created &&
+		test_path_is_missing .git/objects/pack/pack-$X.pack &&
+		git fsck
+	)
+}
+
+for args in "-a -d" "-a -d --filter=blob:none"
+do
+	test_expect_success "a .keep that shows up mid-repack loses nothing: $args" '
+		test_when_finished "rm -fr keep-race" &&
+		keep_race_repack $args
+	'
+done
+
+for args in "-A -d" "-A -d --pack-kept-objects" "-a -k -d" "--cruft -d" \
+	    "--cruft --cruft-expiration=1.week.ago -d"
+do
+	test_expect_success "a .keep that shows up mid-repack loses nothing: $args" '
+		test_when_finished "rm -fr keep-race" &&
+		keep_race_repack $args &&
+		git -C keep-race cat-file -e $(cat keep-race/unreachable)
+	'
+done
+
 test_done
diff --git a/t/t7703-repack-geometric.sh b/t/t7703-repack-geometric.sh
index f3a0650cfe..7a5e3b9ada 100755
--- a/t/t7703-repack-geometric.sh
+++ b/t/t7703-repack-geometric.sh
@@ -541,4 +541,43 @@ test_expect_success 'geometric repack works with promisor packs' '
 	)
 '
 
+test_expect_success 'a ".keep" that shows up mid-repack does not lose objects' '
+	test_when_finished "rm -fr race" &&
+	git init race &&
+	(
+		cd race &&
+
+		test_commit kept &&
+		test_commit pack &&
+
+		KEPT=$(git pack-objects --revs $packdir/pack <<-EOF
+		refs/tags/kept
+		EOF
+		) &&
+		git pack-objects --revs $packdir/pack <<-EOF &&
+		refs/tags/pack
+		^refs/tags/kept
+		EOF
+		git prune-packed &&
+
+		# Neither pack is twice the size of the other, so both are
+		# rolled up and deleted. Have a ".keep" appear on one of them
+		# as pack-objects starts, after the repack has decided to
+		# delete it; its objects must still end up in the new pack.
+		mkdir shim &&
+		write_script shim/git <<-EOF &&
+		test "\$1" = "pack-objects" &&
+		>"$(pwd)/$packdir/pack-$KEPT.keep" &&
+		>"$(pwd)/keep-created"
+		GIT_EXEC_PATH="$GIT_EXEC_PATH" exec "$GIT_EXEC_PATH/git" "\$@"
+		EOF
+
+		git --exec-path="$(pwd)/shim" repack --geometric 2 -d &&
+		test_path_is_file keep-created &&
+		test_path_is_missing $packdir/pack-$KEPT.pack &&
+
+		git fsck
+	)
+'
+
 test_done
-- 
gitgitgadget
