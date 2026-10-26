Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793005632;
	b=4ks+2frTRDW41mBDQ3etA720+bIl8K03IjRPWpaNaDE/Bwn6EL4uQHpzR+Y5bArGA9f5
	 +v7FeN2gXSMZc+lKuj2U2uyGQDSARY55xAbnF9Lh7DUewSfjrIUurSwqX9qp983AbooLM
	 GEwOp6tPo29K09sC5FOvWpr5w86wpBA6qWo+/0aorRtZlpXbUp6ti48NB8Yg1xinTChRG
	 TiQQZUyOb9fKaRGxNnrjPe5SYgBaneUQzrri6muZ1wq9uIU8NvmMiol3KXECqMmGTiRAP
	 jrVVOENpDaGuxNr0cPspUvn+g/4ts3R6/lRVBIkv6EnXwdpPQ/HxoprQ0uxXVPneIig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793005632;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=zVUZZfQoLvm4x9hITBtuC2Sgkn71OusMLg70SZe7t28=;
	b=5AL51HNiZlvFyJiayapW/91oTT2mXt9uZ4fHpulP9lJivD9st4f7DsuMtXQ7OHpP/eEq
	 qiwJ9wcGFbjYOu+e9LwLOHRIOFISU1H0m4VSOMVkSIkCwDqVHR+H9KE2Q758tQ2HmxWLK
	 j4AzkEdEI0ggry/rWDjitIe/+T25aDHclGT3HiKqlH4pDcs/NZLBLFhOdrxx5exXLgQZR
	 Dw7vElBcjOXKaeo3OT1c7L4zf9Ogk+y54o4furH/BwWHkwt1dx9Jr24qLHSZeeKthChUB
	 2Pepo1qTzkxnbY9VOFn8Pp9CxVo6Fmg/PIcgPlBiK4cOiDLualfHdpqb6Mv1OdvYmeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FfXZfIEQ;
	arc=none smtp.remote-ip=209.85.214.181
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92231606A326
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 09:07:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92231606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FfXZfIEQ
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2e987b4a710so18345635ad.1
        for <git@vger.kernel.org>; Mon, 26 Oct 2026 02:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793005627; x=1793610427; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zVUZZfQoLvm4x9hITBtuC2Sgkn71OusMLg70SZe7t28=;
        b=FfXZfIEQAViYshBb3XQpeUTlvyh2dwSAWfiRVXnH5q3QHnzPPPiKlPsBTUnnM5A/D+
         0jFRsC1GNzTymG/NhG1Qq/BhgrbtpTCSMd4G1vegXETNDOF7L3u0GyL1TrrlsJOs1VWe
         p8dlaOwvfqDo7U88o/RaubmAACVhHXZeY1Zs+7Dv8sbL3tGN4ZQXMjaeNsXbon2oxtVr
         CkYvrHaoNJFTJ16buxFi9Y8MXTQKX06v7hKqeyK4HBJ4ihW76qWQ0XXgwfwkxB3UFj4s
         +JWw+pPmfZjNoyBD+GLbgeudnvw6Wsut4KZ4zHuTNwBHgyvXnLtm9fVlcawLZeJHBMAs
         ++zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793005627; x=1793610427;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zVUZZfQoLvm4x9hITBtuC2Sgkn71OusMLg70SZe7t28=;
        b=siC10XHrh5scW0bmyxzKQAl5meUDBv1jY0PtZkfHS7qVBqR+ZZFq/yY6c+oNkMWI5u
         E8Rc0t29GgIeR+Qo+NUR8FwjBaM+lUW8XfvHH5LFogwgmjeqKhv5EjqQhJJ7meYGJly4
         fiJB6epIrGMd+Uhf2VdaDrZd7p/1cPmONoQG88jUtcz/BrwfoXIGgoqPOvf55o2ffiad
         6wzcVz94Szb4jhQkiw2P5wtLd4k0Ci4D0eLaikIigr23mPmHcPEBNYkVi8eCAcjWwuVV
         c4vSiBfkiPj2Om/QyB9gHMDDf+BYDpzAABWv+IzEIEouT2prrGhTvLVVFtupNgvTTJoT
         iR+w==
X-Gm-Message-State: AFq9FYIySMHdHYs8VEW5nCdbecmiLxk2DBraIuTPieRCEPAdP5Rnrz+l
	evgo7NqfNSe28U2J0AIgh+JN3PkU/nNF//Vgfm20Wonyhovc+2KynszBPzyWxpcV
X-Gm-Gg: AYBFou04DV/93s6CR50g+UMs1F9Ah1fUIWYSIdm6U6pxvueIue8O3omBFRelAGkcl6S
	ujgNxvAkmIf5aC5Qt1DSmzByOZ1JXAnrNC37Uqbg1U+nOuZJvD1KVbwjIE7Wt97nei+q5JnvguX
	j6gjZaPATFwDCZM2pM60oTolF/wiiMdbLYE8P0/Pgw/cibQ4xbiF5RB/dIo27YT+AcELtidu+U2
	1pNf0y1YJhTBZm+EqMdMQBewu3OS5wo6z5qduVzCRF8cbMmiFNoRY3RU/K5SgPELL28GcPfcbQy
	lxiayCFcP4lLGPv+nPpd7NSHX+aueUiMHFHUoDtmmq5jFRR/JzbGtE4lmI/E9cd2JhnqzM5s1eX
	U0JB4wD91LpsEMCATu6RBDiYQ9ezizDhhnVntpMDinXA1Qjn1aUIxIUv0Yv2Qt1cIlEeNVquBTD
	uZpsj/WzdXLd5b8Wuk04WvtiTE6atHeVZRVjQvj5+5SGZ7/D5Dki4RjOAuPgmn/qSDMJLO+mvMR
	OujYVU/yU6fpScnHHJNRmRVpIb0BrQH04zokW6mqvuFanNw2ZRlGl7P
X-Received: by 2002:a17:903:38cd:b0:2e9:46a9:9b56 with SMTP id d9443c01a7336-2ea9c876318mr37312105ad.21.1793005626774;
        Mon, 26 Oct 2026 02:07:06 -0700 (PDT)
Received: from [127.0.0.1] ([20.168.94.86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea9b121538sm14234685ad.12.2026.10.26.02.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 02:07:05 -0700 (PDT)
Message-Id: <001875455bdcca16c32808cc806bf0267f3dc968.1793005620.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2219.v4.git.1793005620.gitgitgadget@gmail.com>
References: <pull.2219.git.1789385483.gitgitgadget@gmail.com>
	<pull.2219.v4.git.1793005620.gitgitgadget@gmail.com>
From: "Qin ShiCheng via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 26 Oct 2026 09:07:00 +0000
Subject: [PATCH v4 3/3] repack: tell pack-objects which packs it may delete
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
index 5d06872d77..8faf7ce2ef 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -457,6 +457,28 @@ int cmd_repack(int argc,
 	existing.repo = repo;
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
@@ -644,6 +666,7 @@ int cmd_repack(int argc,
 		cruft_po_args.quiet = po_args.quiet;
 		cruft_po_args.delta_base_offset = po_args.delta_base_offset;
 		cruft_po_args.pack_kept_objects = 0;
+		cruft_po_args.ignore_pack_keep_from = po_args.ignore_pack_keep_from;
 
 		ret = write_cruft_pack(&opts, cruft_expiration,
 				       combine_cruft_below_size, &names,
diff --git a/repack.c b/repack.c
index 53c34197f3..3af8c7a5f8 100644
--- a/repack.c
+++ b/repack.c
@@ -40,6 +40,9 @@ void prepare_pack_objects(struct child_process *cmd,
 		strvec_push(&cmd->args,  "--delta-base-offset");
 	if (!args->pack_kept_objects)
 		strvec_push(&cmd->args,  "--honor-pack-keep");
+	if (args->ignore_pack_keep_from)
+		strvec_pushf(&cmd->args, "--ignore-pack-keep-from=%s",
+			     args->ignore_pack_keep_from);
 	strvec_push(&cmd->args, out);
 	cmd->git_cmd = 1;
 	cmd->out = -1;
@@ -172,6 +175,29 @@ int existing_packs_has_non_kept(const struct existing_packs *existing)
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
index 61e554e4ed..e3bc840b9a 100644
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
@@ -80,6 +86,12 @@ struct existing_packs {
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
@@ -138,8 +150,6 @@ void pack_geometry_remove_redundant(struct pack_geometry *geometry,
 				    bool wrote_incremental_midx);
 void pack_geometry_release(struct pack_geometry *geometry);
 
-struct tempfile;
-
 enum repack_write_midx_mode {
 	REPACK_WRITE_MIDX_NONE,
 	REPACK_WRITE_MIDX_DEFAULT,
diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index 00fe259767..79fa3189f6 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -941,4 +941,53 @@ test_expect_success 'pending objects are repacked appropriately' '
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
