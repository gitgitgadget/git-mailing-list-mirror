Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 66DCD1F406
	for <e@80x24.org>; Wed,  3 Jan 2018 16:37:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751208AbeACQhY (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jan 2018 11:37:24 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37266 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751128AbeACQeZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jan 2018 11:34:25 -0500
Received: by mail-wm0-f65.google.com with SMTP id f140so3631288wmd.2
        for <git@vger.kernel.org>; Wed, 03 Jan 2018 08:34:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LenYpRMwAFi0aVLxdmQVInkKtZW0zj7G6QO3IfpBrE0=;
        b=DGzcalM+G0t5zNYM5GgTeAY4u2jktZYcqYLVCCo6we1kk9ZQlRUOWgI3bwWoyohZOA
         b1HmZiUpHCvFxsXZl4B0BnCo9aPh6zbCM9xeMQzdT3M7h0u4SNEPNzYOETE54/npNQ3R
         MsEY7HotpFgxbwxhu/Qi8BLYYA8oMR+hB13WR3UBIFrQDsBaKio4kK7J0dVVxNhiRQdz
         a2IvlKcfZ1FUEHd8IRW+E1t/VD3jvzO4SWbz/DnVwgyLgW2kMep2RgEjjmZQMV4vlWln
         tcvOfbneGCbwh2jeQ3Ls4akP3QMf6qvhAkNJ1JnJB6+zEa0xURg/A+fTWbdMgPau+G8K
         RI4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LenYpRMwAFi0aVLxdmQVInkKtZW0zj7G6QO3IfpBrE0=;
        b=p3hUhS25t50WqF/ag5j6GS1R4E+wiW6nSAlzubnUhz4FkknNhtOB2olOmYR4G+M/b+
         qzO4q1Ch9e6SJ2RD88YWC81d2AHsRr17UbNGwT+tQE8UTi7Iw69QyHsd23yqPjC1as+E
         DShhlvJ3SeZdNyDlzW463B77ytj9JsHegrAXonRymHrvks9s1D2n5/8SP5+SRGLiLy+E
         c0rGq4D8W2F76z/g2S8dIhohf7KzSxcenGrBDiD4e4CiXjg8qRdOLzAKBEa49lFl+DbJ
         zd8KKr+M9sOs/j23CTlRlRLWTKUD/ACmkT00PLCBKEdNFf00L6aNCmiL/I4Q05HVGizh
         XK4g==
X-Gm-Message-State: AKGB3mKv/ZxSKGkllWY4AqTkYVFK8B+Ot/eMt0rIWop/lfpivby+BY5k
        RIN6FOot//RGAEFgz5tvS8UKT1Pq
X-Google-Smtp-Source: ACJfBovt7oBn0gx2Sh8PsbE2fAcl3copPh9lRgUwAqXFJK1Tr03E/GUUI2z10SLX/5adxEbGEF7gRQ==
X-Received: by 10.28.49.195 with SMTP id x186mr1716066wmx.116.1514997261751;
        Wed, 03 Jan 2018 08:34:21 -0800 (PST)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id s11sm1356384wrb.30.2018.01.03.08.34.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jan 2018 08:34:21 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH 04/40] fsck: introduce promisor objects
Date:   Wed,  3 Jan 2018 17:33:27 +0100
Message-Id: <20180103163403.11303-5-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.16.0.rc0.16.g82191dbc6c.dirty
In-Reply-To: <20180103163403.11303-1-chriscool@tuxfamily.org>
References: <20180103163403.11303-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jonathan Tan <jonathantanmy@google.com>

Currently, Git does not support repos with very large numbers of objects
or repos that wish to minimize manipulation of certain blobs (for
example, because they are very large) very well, even if the user
operates mostly on part of the repo, because Git is designed on the
assumption that every referenced object is available somewhere in the
repo storage. In such an arrangement, the full set of objects is usually
available in remote storage, ready to be lazily downloaded.

Teach fsck about the new state of affairs. In this commit, teach fsck
that missing promisor objects referenced from the reflog are not an
error case; in future commits, fsck will be taught about other cases.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/fsck.c           |  2 +-
 cache.h                  |  3 +-
 packfile.c               | 78 ++++++++++++++++++++++++++++++++++++++++++++--
 packfile.h               | 13 ++++++++
 t/t0410-partial-clone.sh | 81 ++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 172 insertions(+), 5 deletions(-)
 create mode 100755 t/t0410-partial-clone.sh

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 04846d46f9..793d289367 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -398,7 +398,7 @@ static void fsck_handle_reflog_oid(const char *refname, struct object_id *oid,
 					xstrfmt("%s@{%"PRItime"}", refname, timestamp));
 			obj->flags |= USED;
 			mark_object_reachable(obj);
-		} else {
+		} else if (!is_promisor_object(oid)) {
 			error("%s: invalid reflog entry %s", refname, oid_to_hex(oid));
 			errors_found |= ERROR_REACHABLE;
 		}
diff --git a/cache.h b/cache.h
index 7b27abac35..078607ee91 100644
--- a/cache.h
+++ b/cache.h
@@ -1649,7 +1649,8 @@ extern struct packed_git {
 	unsigned pack_local:1,
 		 pack_keep:1,
 		 freshened:1,
-		 do_not_close:1;
+		 do_not_close:1,
+		 pack_promisor:1;
 	unsigned char sha1[20];
 	struct revindex_entry *revindex;
 	/* something like ".git/objects/pack/xxxxx.pack" */
diff --git a/packfile.c b/packfile.c
index 4a5fe7ab18..aee6c3d674 100644
--- a/packfile.c
+++ b/packfile.c
@@ -8,6 +8,12 @@
 #include "list.h"
 #include "streaming.h"
 #include "sha1-lookup.h"
+#include "commit.h"
+#include "object.h"
+#include "tag.h"
+#include "tree-walk.h"
+#include "tree.h"
+#include "external-odb.h"
 
 char *odb_pack_name(struct strbuf *buf,
 		    const unsigned char *sha1,
@@ -643,10 +649,10 @@ struct packed_git *add_packed_git(const char *path, size_t path_len, int local)
 		return NULL;
 
 	/*
-	 * ".pack" is long enough to hold any suffix we're adding (and
+	 * ".promisor" is long enough to hold any suffix we're adding (and
 	 * the use xsnprintf double-checks that)
 	 */
-	alloc = st_add3(path_len, strlen(".pack"), 1);
+	alloc = st_add3(path_len, strlen(".promisor"), 1);
 	p = alloc_packed_git(alloc);
 	memcpy(p->pack_name, path, path_len);
 
@@ -654,6 +660,10 @@ struct packed_git *add_packed_git(const char *path, size_t path_len, int local)
 	if (!access(p->pack_name, F_OK))
 		p->pack_keep = 1;
 
+	xsnprintf(p->pack_name + path_len, alloc - path_len, ".promisor");
+	if (!access(p->pack_name, F_OK))
+		p->pack_promisor = 1;
+
 	xsnprintf(p->pack_name + path_len, alloc - path_len, ".pack");
 	if (stat(p->pack_name, &st) || !S_ISREG(st.st_mode)) {
 		free(p);
@@ -781,7 +791,8 @@ static void prepare_packed_git_one(char *objdir, int local)
 		if (ends_with(de->d_name, ".idx") ||
 		    ends_with(de->d_name, ".pack") ||
 		    ends_with(de->d_name, ".bitmap") ||
-		    ends_with(de->d_name, ".keep"))
+		    ends_with(de->d_name, ".keep") ||
+		    ends_with(de->d_name, ".promisor"))
 			string_list_append(&garbage, path.buf);
 		else
 			report_garbage(PACKDIR_FILE_GARBAGE, path.buf);
@@ -1889,6 +1900,9 @@ int for_each_packed_object(each_packed_object_fn cb, void *data, unsigned flags)
 	for (p = packed_git; p; p = p->next) {
 		if ((flags & FOR_EACH_OBJECT_LOCAL_ONLY) && !p->pack_local)
 			continue;
+		if ((flags & FOR_EACH_OBJECT_PROMISOR_ONLY) &&
+		    !p->pack_promisor)
+			continue;
 		if (open_pack_index(p)) {
 			pack_errors = 1;
 			continue;
@@ -1899,3 +1913,61 @@ int for_each_packed_object(each_packed_object_fn cb, void *data, unsigned flags)
 	}
 	return r ? r : pack_errors;
 }
+
+static int add_promisor_object(const struct object_id *oid,
+			       struct packed_git *pack,
+			       uint32_t pos,
+			       void *set_)
+{
+	struct oidset *set = set_;
+	struct object *obj = parse_object(oid);
+	if (!obj)
+		return 1;
+
+	oidset_insert(set, oid);
+
+	/*
+	 * If this is a tree, commit, or tag, the objects it refers
+	 * to are also promisor objects. (Blobs refer to no objects.)
+	 */
+	if (obj->type == OBJ_TREE) {
+		struct tree *tree = (struct tree *)obj;
+		struct tree_desc desc;
+		struct name_entry entry;
+		if (init_tree_desc_gently(&desc, tree->buffer, tree->size))
+			/*
+			 * Error messages are given when packs are
+			 * verified, so do not print any here.
+			 */
+			return 0;
+		while (tree_entry_gently(&desc, &entry))
+			oidset_insert(set, entry.oid);
+	} else if (obj->type == OBJ_COMMIT) {
+		struct commit *commit = (struct commit *) obj;
+		struct commit_list *parents = commit->parents;
+
+		oidset_insert(set, &commit->tree->object.oid);
+		for (; parents; parents = parents->next)
+			oidset_insert(set, &parents->item->object.oid);
+	} else if (obj->type == OBJ_TAG) {
+		struct tag *tag = (struct tag *) obj;
+		oidset_insert(set, &tag->tagged->oid);
+	}
+	return 0;
+}
+
+int is_promisor_object(const struct object_id *oid)
+{
+	static struct oidset promisor_objects;
+	static int promisor_objects_prepared;
+
+	if (!promisor_objects_prepared) {
+		if (has_external_odb()) {
+			for_each_packed_object(add_promisor_object,
+					       &promisor_objects,
+					       FOR_EACH_OBJECT_PROMISOR_ONLY);
+		}
+		promisor_objects_prepared = 1;
+	}
+	return oidset_contains(&promisor_objects, oid);
+}
diff --git a/packfile.h b/packfile.h
index 0cdeb54dcd..a7fca598d6 100644
--- a/packfile.h
+++ b/packfile.h
@@ -1,6 +1,8 @@
 #ifndef PACKFILE_H
 #define PACKFILE_H
 
+#include "oidset.h"
+
 /*
  * Generate the filename to be used for a pack file with checksum "sha1" and
  * extension "ext". The result is written into the strbuf "buf", overwriting
@@ -124,6 +126,11 @@ extern int has_sha1_pack(const unsigned char *sha1);
 
 extern int has_pack_index(const unsigned char *sha1);
 
+/*
+ * Only iterate over packs obtained from the promisor remote.
+ */
+#define FOR_EACH_OBJECT_PROMISOR_ONLY 2
+
 /*
  * Iterate over packed objects in both the local
  * repository and any alternates repositories (unless the
@@ -135,4 +142,10 @@ typedef int each_packed_object_fn(const struct object_id *oid,
 				  void *data);
 extern int for_each_packed_object(each_packed_object_fn, void *, unsigned flags);
 
+/*
+ * Return 1 if an object in a promisor packfile is or refers to the given
+ * object, 0 otherwise.
+ */
+extern int is_promisor_object(const struct object_id *oid);
+
 #endif
diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
new file mode 100755
index 0000000000..9257b8c885
--- /dev/null
+++ b/t/t0410-partial-clone.sh
@@ -0,0 +1,81 @@
+#!/bin/sh
+
+test_description='partial clone'
+
+. ./test-lib.sh
+
+delete_object () {
+	rm $1/.git/objects/$(echo $2 | sed -e 's|^..|&/|')
+}
+
+pack_as_from_promisor () {
+	HASH=$(git -C repo pack-objects .git/objects/pack/pack) &&
+	>repo/.git/objects/pack/pack-$HASH.promisor
+}
+
+test_expect_success 'missing reflog object, but promised by a commit, passes fsck' '
+	test_create_repo repo &&
+	test_commit -C repo my_commit &&
+
+	A=$(git -C repo commit-tree -m a HEAD^{tree}) &&
+	C=$(git -C repo commit-tree -m c -p $A HEAD^{tree}) &&
+
+	# Reference $A only from reflog, and delete it
+	git -C repo branch my_branch "$A" &&
+	git -C repo branch -f my_branch my_commit &&
+	delete_object repo "$A" &&
+
+	# State that we got $C, which refers to $A, from promisor
+	printf "$C\n" | pack_as_from_promisor &&
+
+	# Normally, it fails
+	test_must_fail git -C repo fsck &&
+
+	# But with the extension, it succeeds
+	git -C repo config core.repositoryformatversion 1 &&
+	git -C repo config odb.magic.promisorRemote "arbitrary string" &&
+	git -C repo fsck
+'
+
+test_expect_success 'missing reflog object, but promised by a tag, passes fsck' '
+	rm -rf repo &&
+	test_create_repo repo &&
+	test_commit -C repo my_commit &&
+
+	A=$(git -C repo commit-tree -m a HEAD^{tree}) &&
+	git -C repo tag -a -m d my_tag_name $A &&
+	T=$(git -C repo rev-parse my_tag_name) &&
+	git -C repo tag -d my_tag_name &&
+
+	# Reference $A only from reflog, and delete it
+	git -C repo branch my_branch "$A" &&
+	git -C repo branch -f my_branch my_commit &&
+	delete_object repo "$A" &&
+
+	# State that we got $T, which refers to $A, from promisor
+	printf "$T\n" | pack_as_from_promisor &&
+
+	git -C repo config core.repositoryformatversion 1 &&
+	git -C repo config odb.magic.promisorRemote "arbitrary string" &&
+	git -C repo fsck
+'
+
+test_expect_success 'missing reflog object alone fails fsck, even with extension set' '
+	rm -rf repo &&
+	test_create_repo repo &&
+	test_commit -C repo my_commit &&
+
+	A=$(git -C repo commit-tree -m a HEAD^{tree}) &&
+	B=$(git -C repo commit-tree -m b HEAD^{tree}) &&
+
+	# Reference $A only from reflog, and delete it
+	git -C repo branch my_branch "$A" &&
+	git -C repo branch -f my_branch my_commit &&
+	delete_object repo "$A" &&
+
+	git -C repo config core.repositoryformatversion 1 &&
+	git -C repo config odb.magic.promisorRemote "arbitrary string" &&
+	test_must_fail git -C repo fsck
+'
+
+test_done
-- 
2.16.0.rc0.16.g82191dbc6c.dirty

