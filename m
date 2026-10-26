Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793029570;
	b=QZ9oU0URXbLj/WoQQ9KltSfntU0Rz7WRBm/ZIbTjigV96sCCsKYqasQg57dB10vMFaI7
	 DvHdKfL8RabytT9aABJ850Q5Bdo92rE3tXG5gPoQ9ZvxC+aRz7AU1Gs73xfdNHEm6NHXJ
	 Lwey+SX9tXXpI/IdUvcJv14Kn7NBcjZt9UN9wtjK1CKVpQQj7/G0zaOfCIgYIvYJlZktK
	 6H3MQa5jO4VVYRNfWkUo64ksNPz2vyuTs3MkBp8v5EPdglWwPYPV5gu/1MqNJEAWCcS/5
	 XnfBEnmph2E9LyaZ7YOJPSDBVnSeG+b48Wh/KiekQnk/vzR7Rvyh2HDLO0xfUpNezYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793029570;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=+2iSA3cAcshqqXiw7pMMrFQvPndvyKPd57JV6hbgRDI=;
	b=yLto0z2k3WYgPlchjreVBVl2+5wZKJ3yuENYpNvxX+HBZZ0JLb87aoMbeLwMwBpCVRT+
	 Sqa13ag8CniEJFlXVMzPYVR0RtajFFtkVdN+ukai5sLfpoym7ByEuta8xN5tMcVSb6+Um
	 yHjnsyrsBrd0X1D4rMu8BrgMZbwhAIrnK4MpulKFYEGYEPPMGQYRlOP0P2qWMuZ57ZHnf
	 AhUCH/ZhBvDf9OXakec1BFb4LHygrRr7MICzaGKGPN24KXE+ABtESBD0pOF0m9qiXnitW
	 muXkVJA83qBLwDk55HAU7Vgcs4szqns5kuIPwv1E8icdhiW3RNVlrsavRj76dIH+sZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="Dk/9AvcV";
	arc=none smtp.remote-ip=209.85.210.172
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420D8606A31B
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 15:46:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 420D8606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Dk/9AvcV
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8a06b44bd01so1707922b3a.0
        for <git@vger.kernel.org>; Mon, 26 Oct 2026 08:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793029569; x=1793634369; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+2iSA3cAcshqqXiw7pMMrFQvPndvyKPd57JV6hbgRDI=;
        b=Dk/9AvcVYVXEyQma0zXBScH1lEc3lkUnUm1c1sfDceN4Kvua1feWdBu7GXa9dmJOLD
         1ydH2F/MmQtfkQkyplEmMGCz/LHNl6SjsQ06+QH+CmizmbY2+dcMBkHK/+vFfWcUZPN8
         TQOs86FdD1k+fYGxBOfLcjtaaz7qSoahD5LyTUsoELukym0/MIWxvzqRka1ywnipqvIL
         18D7JXLUx4DXjr6cw/4nMZJGPd4q1co6YFA279jQLB8vd4F0wVLEQimmOGD4NUgu32WF
         E5ZhlG32BtW/Q2R0qGQ7WDBZPmUGE9gJd4v8vUC/HRRfWzamceOhslF6FV/9i3qltCiY
         tv/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793029569; x=1793634369;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+2iSA3cAcshqqXiw7pMMrFQvPndvyKPd57JV6hbgRDI=;
        b=pexBoS16CfKAOJcYWdbuZ0Qa/5dhGFCfKGfH7tPQ4MQIbBjuJtXaEZfYbHn8gja5Wz
         /lj81q5EzsJIXJoXP/zyNBJGsvYhe9wqPrKKuEA/neYErvQyudRPdf5Xg5q65N/or/sV
         54Gs/P536j9Y6F5y+5xkKtTwV1IyQsWoGAX0MRpen4PkgzQrRZR6L+GZ0Nvm9m6aH7N/
         7RXrJ4QCp2ea+N/N13SmK1TuO2uZwiiORL8DrC93sgkio/CSp7MOR9zSNwOXVGyQZqe3
         /oNpSUXfnMkgwCzSZ/96vlpZ3TtJgRHGsaQZtc9aGRZuWkByWpQBsC05morIJovGWhNx
         Qbow==
X-Gm-Message-State: AFq9FYLvcAs2ptOGJxTnypWSZt5rd4AeuRFZcZvPufFZUE/k6iMVR+8r
	zgfrnYSOC/CsvPthFL2iLoNBhZG9HcuucwOiChZrm5tevy41hcbOTOnXBNIRtkif
X-Gm-Gg: AYBFou1kydwWKX+q2X/153EMBX5fFDokHU3T9rkWAZ3ZuoJzROdYUJN3BT38JzQOkyC
	5bPlqdxHqn5INPLdZr3YndE7K6YfmbXOJHFXvvA5rVB99vcIvTc9k91WB5ol0PNI4Uh91q20T4N
	wU1kKP64CGkxBojSfVlX0RicNMT1TuL88Oap1lnZu8fDOCkiC1wlw9cKUo9R7zfYMoMvPSY5z+c
	deNHqSOUYz405FXDognFc9x9l/u7dq11hAlafBEr6ayPb58iNFz+7kA/sYfqWVJKV5irstIaYhy
	71dBJxPC5T8sIjdWlpQTUwLSZvhBjK/NA1WWqKciMF+vmFrmFfuQ3l2LIOnmPy+fWfm1R/OjZwu
	yPo1XnF7ApjwoOjU1zQrx2JhAv7IwRJepgw1NXnPTCGXK8AntsZ55E4jmSkJ2Y1HWO3W9TotR4q
	HzC9DhOzdxWHZYM7R5ewxFZiWu5YX2+7k4RPx+X77XoATpYbogh3oCIdaPa2vqyyZ+xstrI/WZ/
	O6/dLh6WxuebNQSi0OZVrdJZydRtJBUY6Qw7ZZFvLgmj8ZnzAavEKKICg==
X-Received: by 2002:a05:6a00:440a:b0:881:e266:c3f1 with SMTP id d2e1a72fcca58-8a367633319mr5890407b3a.21.1793029569422;
        Mon, 26 Oct 2026 08:46:09 -0700 (PDT)
Received: from [127.0.0.1] ([20.171.34.166])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a36ada287fsm1521944b3a.10.2026.10.26.08.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 08:46:08 -0700 (PDT)
Message-Id: <02087fc65ca9e2cceb1b738d6dc150c44b10f48b.1793029565.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2281.git.1793029565.gitgitgadget@gmail.com>
References: <pull.2281.git.1793029565.gitgitgadget@gmail.com>
From: "Marc Strapetz via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 26 Oct 2026 15:46:04 +0000
Subject: [PATCH 2/3] pack-objects: inspect selected haves for shared objects
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
Cc: Marc Strapetz <marc.strapetz@syntevo.com>,
    Marc Strapetz <marc.strapetz@syntevo.com>

From: Marc Strapetz <marc.strapetz@syntevo.com>

A receiver-known commit can be excluded from a revision walk without
becoming a boundary commit. Its tree then need not be inspected, so
objects shared with the outgoing history can still be packed.

Accept --inspect-have <commit> lines in --revs input and carry the
selected tips through the object database pack-generation options.
Compare their root trees with the outgoing tips using the existing
sparse tree marking. This identifies additional receiver-known
objects without walking the selected commits' histories and avoids
descending into identical or receiver-only subtrees.

Resolve the selected commits in pack-objects, where replacement refs
are already disabled, so local replacements cannot substitute trees
the receiver does not have. Keep successful bitmap enumeration on its
existing path and skip the optional inspection in partial clones.

Cover identical root trees, shared blobs under different roots,
retained changed objects, subtree pruning, non-commit input, partial
clone fallback and shared objects in earlier outgoing commits.

Assisted-by: GPT-6 Astra, GPT-6.1 Sol
Signed-off-by: Marc Strapetz <marc.strapetz@syntevo.com>
---
 Documentation/git-pack-objects.adoc |   7 ++
 builtin/pack-objects.c              |  81 ++++++++++++++-
 odb.c                               |   1 +
 odb.h                               |   8 ++
 odb/source-files.c                  |   3 +
 t/t5322-pack-objects-sparse.sh      | 148 ++++++++++++++++++++++++++++
 6 files changed, 247 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-pack-objects.adoc b/Documentation/git-pack-objects.adoc
index ccad938c5b..a98d4286fa 100644
--- a/Documentation/git-pack-objects.adoc
+++ b/Documentation/git-pack-objects.adoc
@@ -70,6 +70,13 @@ base-name::
 	outputs.  The objects on the resulting list are packed.
 	Besides revisions, `--not` or `--shallow <SHA-1>` lines are
 	also accepted.
++
+A `--inspect-have <commit>` line supplies the object ID of a commit known
+to the receiver. Before non-bitmap enumeration, its root tree is compared
+with the outgoing tips' root trees to identify additional objects that
+need not be packed, without walking its commit history. Identical
+subtrees and paths found only in the receiver-known trees are skipped.
+This optional inspection is skipped in partial clones.
 
 --unpacked::
 	This implies `--revs`.  When processing the list of
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index ca3a891dfb..9abb4b9fe3 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -4892,12 +4892,76 @@ static int get_object_list_path_walk(struct rev_info *revs)
 	return result;
 }
 
+static void add_have_to_inspect(struct oidset *trees, const char *arg)
+{
+	struct object_id oid;
+	struct commit *commit;
+	struct tree *tree;
+	const char *end;
+
+	if (parse_oid_hex(arg, &oid, &end) || *end)
+		die(_("not an object name '%s'"), arg);
+	if (!odb_has_object(the_repository->objects, &oid, 0))
+		return;
+	commit = lookup_commit_reference_gently(the_repository, &oid, 1);
+	if (!commit)
+		die(_("object %s is not a commit"), arg);
+	tree = repo_get_commit_tree(the_repository, commit);
+	if (tree)
+		oidset_insert(trees, &tree->object.oid);
+}
+
+static void inspect_haves(struct rev_info *revs, struct oidset *trees)
+{
+	struct oidset_iter iter;
+	struct object_id *oid;
+
+	/* Avoid fetching missing trees for this optional optimization. */
+	if (!oidset_size(trees) || repo_has_promisor_remote(revs->repo))
+		return;
+
+	/* Mark receiver-known root trees as uninteresting. */
+	oidset_iter_init(trees, &iter);
+	while ((oid = oidset_iter_next(&iter))) {
+		struct tree *tree = lookup_tree(revs->repo, oid);
+
+		if (tree)
+			tree->object.flags |= UNINTERESTING;
+	}
+
+	/*
+	 * Add outgoing root trees for the same sparse tree marking used by
+	 * mark_edges_uninteresting(). A receiver-known tip on the other side of
+	 * a divergence can be a negative revision without its tree being visited
+	 * by the ordinary walk. Combining its tree with the outgoing trees lets
+	 * us exclude shared objects without walking that tip's commit history.
+	 */
+	for (size_t i = 0; i < revs->pending.nr; i++) {
+		struct object *obj = revs->pending.objects[i].item;
+
+		if (obj->flags & UNINTERESTING)
+			continue;
+		if (obj->type == OBJ_COMMIT) {
+			struct tree *tree = repo_get_commit_tree(revs->repo,
+							(struct commit *)obj);
+
+			if (tree)
+				oidset_insert(trees, &tree->object.oid);
+		} else if (obj->type == OBJ_TREE) {
+			oidset_insert(trees, &obj->oid);
+		}
+	}
+
+	mark_trees_uninteresting_sparse(revs->repo, trees);
+}
+
 static void get_object_list(struct rev_info *revs, struct strvec *argv)
 {
 	struct setup_revision_opt s_r_opt = {
 		.allow_exclude_promisor_objects = 1,
 	};
 	struct repo_config_values *cfg = repo_config_values(the_repository);
+	struct oidset have_trees = OIDSET_INIT;
 	char line[1000];
 	int flags = 0;
 	int save_warning;
@@ -4931,6 +4995,11 @@ static void get_object_list(struct rev_info *revs, struct strvec *argv)
 				use_bitmap_index = 0;
 				continue;
 			}
+			if (starts_with(line, "--inspect-have ")) {
+				add_have_to_inspect(&have_trees, line + 15);
+				write_bitmap_index = 0;
+				continue;
+			}
 			die(_("not a rev '%s'"), line);
 		}
 		if (handle_revision_arg(line, revs, flags, REVARG_CANNOT_BE_FILENAME))
@@ -4939,8 +5008,18 @@ static void get_object_list(struct rev_info *revs, struct strvec *argv)
 
 	cfg->warn_on_object_refname_ambiguity = save_warning;
 
-	if (use_bitmap_index && !get_object_list_from_bitmap(revs))
+	if (use_bitmap_index && !get_object_list_from_bitmap(revs)) {
+		oidset_clear(&have_trees);
 		return;
+	}
+
+	/*
+	 * Limit this inspection to non-bitmap enumeration to avoid extra tree
+	 * reads on the bitmap fast path. Boundary bitmap traversal may still
+	 * include receiver-known objects; that tradeoff is intentional.
+	 */
+	inspect_haves(revs, &have_trees);
+	oidset_clear(&have_trees);
 
 	if (use_delta_islands)
 		load_delta_islands(the_repository, progress);
diff --git a/odb.c b/odb.c
index 98c5c862f5..2bb27848ac 100644
--- a/odb.c
+++ b/odb.c
@@ -731,6 +731,7 @@ void odb_generate_pack_options_release(struct odb_generate_pack_options *opts)
 {
 	oid_array_clear(&opts->wants);
 	oid_array_clear(&opts->haves);
+	oid_array_clear(&opts->haves_to_inspect);
 	oid_array_clear(&opts->shallows);
 }
 
diff --git a/odb.h b/odb.h
index 0ccc47ee73..10629b2044 100644
--- a/odb.h
+++ b/odb.h
@@ -667,6 +667,13 @@ struct odb_generate_pack_options {
 	 */
 	struct oid_array haves;
 
+	/*
+	 * Receiver-known commit tips whose root trees should be examined
+	 * to identify additional objects that need not be packed. This
+	 * optional inspection does not walk their commit histories.
+	 */
+	struct oid_array haves_to_inspect;
+
 	/*
 	 * The shallow boundary that shall be used when computing object
 	 * reachability. When set, any shallow information of the repository
@@ -751,6 +758,7 @@ struct odb_generate_pack_options {
 #define ODB_GENERATE_PACK_OPTIONS_INIT { \
 	.wants = OID_ARRAY_INIT, \
 	.haves = OID_ARRAY_INIT, \
+	.haves_to_inspect = OID_ARRAY_INIT, \
 	.shallows = OID_ARRAY_INIT, \
 	.pack_fd = -1, \
 }
diff --git a/odb/source-files.c b/odb/source-files.c
index 455f409db0..bad9ecde4c 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -1176,6 +1176,9 @@ static int odb_source_files_generate_pack(struct odb_source *source UNUSED,
 	fprintf(in, "--not\n");
 	for (size_t i = 0; i < opts->haves.nr; i++)
 		fprintf(in, "%s\n", oid_to_hex(&opts->haves.oid[i]));
+	for (size_t i = 0; i < opts->haves_to_inspect.nr; i++)
+		fprintf(in, "--inspect-have %s\n",
+			oid_to_hex(&opts->haves_to_inspect.oid[i]));
 	fprintf(in, "\n");
 	fflush(in);
 	if (ferror(in)) {
diff --git a/t/t5322-pack-objects-sparse.sh b/t/t5322-pack-objects-sparse.sh
index d39958c066..0cf48513eb 100755
--- a/t/t5322-pack-objects-sparse.sh
+++ b/t/t5322-pack-objects-sparse.sh
@@ -138,4 +138,152 @@ test_expect_success 'pack.useSparse overridden' '
 	test_cmp required_objects.txt sparse_objects.txt
 '
 
+test_expect_success 'setup inspect-have receiver and outgoing commits' '
+	git checkout -b receiver main &&
+	echo large >large.bin &&
+	echo receiver >f2/f2/data.txt &&
+	git add large.bin f2/f2/data.txt &&
+	test_commit --no-tag receiver file.txt &&
+	git checkout -b outgoing main &&
+	git checkout receiver -- large.bin f2 &&
+	git rm -r f3 &&
+	test_commit --no-tag outgoing file.txt &&
+	receiver_tip=$(git rev-parse receiver) &&
+	cat >packinput.txt <<-EOF
+	outgoing
+	^main
+	^receiver
+	--inspect-have $receiver_tip
+	EOF
+'
+
+test_expect_success 'inspect-have excludes an identical root tree' '
+	tree=$(git rev-parse receiver^{tree}) &&
+	same_tip=$(git commit-tree "$tree" -p main -m "Same tree") &&
+	cat >same-tree-input.txt <<-EOF &&
+	$same_tip
+	^main
+	^receiver
+	--inspect-have $receiver_tip
+	EOF
+	echo "$same_tip" >expect_objects.txt &&
+	git pack-objects --stdout --revs <same-tree-input.txt >inspected.pack &&
+	git index-pack -o inspected.idx inspected.pack &&
+	git show-index <inspected.idx >index &&
+	awk "{print \$2}" index >inspected_objects.txt &&
+	test_cmp_sorted expect_objects.txt inspected_objects.txt
+'
+
+test_expect_success 'inspect-have excludes shared large blob from different root trees' '
+	test_cmp_rev ! receiver^{tree} outgoing^{tree} &&
+	test_cmp_rev receiver:large.bin outgoing:large.bin &&
+	blob=$(git rev-parse receiver:large.bin) &&
+	sed "/^--inspect-have /d" packinput.txt >ordinary-input.txt &&
+	git pack-objects --stdout --revs <ordinary-input.txt >ordinary.pack &&
+	git index-pack -o ordinary.idx ordinary.pack &&
+	git show-index <ordinary.idx >index &&
+	awk "{print \$2}" index >ordinary_objects.txt &&
+	test_grep "$blob" ordinary_objects.txt &&
+	git rev-parse outgoing outgoing^{tree} outgoing:file.txt >expect_objects.txt &&
+	git pack-objects --stdout --revs <packinput.txt >inspected.pack &&
+	git index-pack -o inspected.idx inspected.pack &&
+	git show-index <inspected.idx >index &&
+	awk "{print \$2}" index >inspected_objects.txt &&
+	test_cmp_sorted expect_objects.txt inspected_objects.txt
+'
+
+test_expect_success 'inspect-have keeps changed blobs and trees' '
+	git checkout -b outgoing-changed outgoing &&
+	test_commit changed f2/f2/data.txt &&
+	sed "s/^outgoing$/outgoing-changed/" packinput.txt >changed-input.txt &&
+	git rev-parse \
+		outgoing \
+		outgoing^{tree} \
+		outgoing:file.txt \
+		outgoing-changed \
+		outgoing-changed^{tree} \
+		outgoing-changed:f2 \
+		outgoing-changed:f2/f2 \
+		outgoing-changed:f2/f2/data.txt >changed_objects.txt &&
+	git pack-objects --stdout --revs <changed-input.txt >inspected.pack &&
+	git index-pack -o inspected.idx inspected.pack &&
+	git show-index <inspected.idx >index &&
+	awk "{print \$2}" index >inspected_objects.txt &&
+	test_cmp_sorted changed_objects.txt inspected_objects.txt
+'
+
+test_expect_success 'inspect-have skips unchanged and receiver-only subtrees' '
+	git rev-parse receiver:f2 receiver:f3 >trees &&
+	git pack-objects --stdout --window=0 <trees >trees.pack &&
+	git index-pack --stdin <trees.pack &&
+	while read oid
+	do
+		path=$(test_oid_to_path "$oid") &&
+		rm ".git/objects/$path" || return 1
+	done <trees &&
+	>pack-access &&
+	GIT_TRACE_PACK_ACCESS="$(pwd)/pack-access" \
+	git pack-objects --stdout --revs <packinput.txt >inspected.pack &&
+	test_must_be_empty pack-access &&
+	git rev-parse outgoing outgoing^{tree} outgoing:file.txt >expect_objects.txt &&
+	git index-pack -o inspected.idx inspected.pack &&
+	git show-index <inspected.idx >index &&
+	awk "{print \$2}" index >inspected_objects.txt &&
+	test_cmp_sorted expect_objects.txt inspected_objects.txt
+'
+
+test_expect_success 'inspect-have rejects non-commit objects' '
+	blob=$(git rev-parse receiver:f2/f2/data.txt) &&
+	echo "--inspect-have $blob" >invalid-input.txt &&
+	test_must_fail git pack-objects --stdout --revs \
+		<invalid-input.txt >invalid.pack 2>err &&
+	test_grep "is not a commit" err
+'
+
+test_expect_success 'inspect-have is ignored in partial clones' '
+	test_config remote.missing.url "$(pwd)/missing" &&
+	test_config remote.missing.promisor true &&
+	sed "/^--inspect-have /d" packinput.txt >partial-input.txt &&
+	git pack-objects --stdout --revs --thin --window=0 \
+		<partial-input.txt >ordinary.pack 2>err &&
+	test_must_be_empty err &&
+	git pack-objects --stdout --revs --thin --window=0 \
+		<packinput.txt >inspected.pack 2>err &&
+	test_must_be_empty err &&
+	git index-pack -o ordinary.idx ordinary.pack &&
+	git show-index <ordinary.idx >index &&
+	awk "{print \$2}" index >ordinary_objects.txt &&
+	git index-pack -o inspected.idx inspected.pack &&
+	git show-index <inspected.idx >index &&
+	awk "{print \$2}" index >inspected_objects.txt &&
+	test_cmp ordinary_objects.txt inspected_objects.txt
+'
+
+test_expect_success 'inspect-have excludes shared blobs from earlier outgoing commits' '
+	git checkout -b receiver-extra receiver &&
+	test_commit --no-tag extra f2/f2/small &&
+	git checkout -b outgoing-extra outgoing &&
+	test_commit --no-tag extra f2/f2/small &&
+	receiver_extra_tip=$(git rev-parse receiver-extra) &&
+	cat >tip-input.txt <<-EOF &&
+	outgoing-extra
+	^main
+	^receiver-extra
+	--inspect-have $receiver_extra_tip
+	EOF
+	git rev-parse \
+		outgoing \
+		outgoing^{tree} \
+		outgoing:f2 \
+		outgoing:f2/f2 \
+		outgoing:file.txt \
+		outgoing-extra \
+		outgoing-extra^{tree} >expect_objects.txt &&
+	git pack-objects --stdout --revs <tip-input.txt >inspected.pack &&
+	git index-pack -o inspected.idx inspected.pack &&
+	git show-index <inspected.idx >index &&
+	awk "{print \$2}" index >inspected_objects.txt &&
+	test_cmp_sorted expect_objects.txt inspected_objects.txt
+'
+
 test_done
-- 
gitgitgadget

