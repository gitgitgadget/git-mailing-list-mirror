Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921AA38F642
	for <git@vger.kernel.org>; Fri, 21 Aug 2026 06:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787295356; cv=none; b=SrVZ4fWhW2UcWmdkkU+hkUZ8xAJvM6vo6OFgtL+KWjdS+zFM58ijc2K5M9/6Wy+lcRkN0tcc0/vlQzWiOe4qtY9cDQTFONRXRcBkt5y1ZjKNtZ2wLZkqjojuGRKwgvP8MpB0/dSmk9Nk/cjr2sTXt/zyjmOIpSe+9C8HKe1DSJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787295356; c=relaxed/simple;
	bh=vKGPD3c9tfSqd6k7TARy2u1FoPyM+I7Pmypd4jpUc2A=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=COtv8/XPO74HvpHbZLwJ4Gr+kcxihSaXgd/h1WqRerBs3BFkrYPcUsQpuq9udY342Sp4WUbAaEIQgV8Hvqqn7TYaHh5gBc2SC9HCqmmY78ZW9lHSeVMdMXVEdKU+GFd6xKPuFRW9FL+J+dwEaTVxMTCnyLXjexkbjIf2E4T0ZWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dn7VFIYX; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dn7VFIYX"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-38dcbade417so622909a91.1
        for <git@vger.kernel.org>; Thu, 20 Aug 2026 23:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787295354; x=1787900154; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=NRtDWIDCbFpLUzSLH5VTrwUeY+aSClXU1/Mxg0ThSOY=;
        b=Dn7VFIYXfRubMLE0KYK76WmedmhJp45+bF7i4bxgOQCJcmTmSZIkaNyv1WHxshP5sm
         sREWFD87Zf/2duV8ualrsZN5oO4Ea+0U1KM7Z4eKu5UTOsOewHhJ+vxas8f8DFYzq0Ea
         FoVyoXO7gB2fInVUCYWB9eMaUrRwukuZaGKa4xdD91Rrlryr8pihyAL8Of4N+9UnRaAr
         De5zPKQTW587hbswN5IIrKcHNwPja5z8Y/ELbzBfFIRB0EOO1Hm1+loC27VT4ZRCQmh7
         vNRGG7CTwrIE1lqa0ewygg1AdUwS294aCEbd6HVBQ3j7NWsXbXH9SABZ1A+bOL5j6ZkG
         Olfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787295354; x=1787900154;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NRtDWIDCbFpLUzSLH5VTrwUeY+aSClXU1/Mxg0ThSOY=;
        b=fMUf8O9EsGicN3czJ9qRJNfrD6ZXpKO/C5OLywkjpHNv8eMJ3nMRFTZjTlRfqqNI+k
         4wzpenIAG4GnLhr6yVrbHAEU45XCnqWuST9AGcYbzy0yGslZ913CwXTcuj3vhVIBtaxA
         M3YrquulI3F55SUbhQL0XeX8Z8u7uJa0RuIIYCmHVrWoyDjrHnaXdhh8RnAgs7F2OXL8
         5U0sD9eGF5ax/aX4/S4dlF4QQJ1agdwdwCyER/wUkUq72s9R+S9fwGfkkqSPQxu48/xO
         InUSaVxxoBzrp30BvXgRaa1ISkYT0u5hjQ2q6YTFIJ++Okfco4cmRmtd90WAGX9hIS5k
         hGrA==
X-Gm-Message-State: AFuF++kssdQk9IwRU2AcI2CBIiVuIShzH9Lo/mT3Tb+XkxV8d51a0pjz
	i8SaRZzt1Xd2rsVwdrxD6i0+MaGML3iwaGMd+OIQqCcMk8Chwke/bFu7qjpojg==
X-Gm-Gg: AR+sD12WLFqPPujxDTtz5dYVRk3Nz7bmaDz55HBn+TykO+Z1/8FLx63Qo5ZU/o5MxOU
	DW+Rv0yDtf2H7QtAMLoilgLuSCQv4Z7UnSJSM3s7kK+MwmIhYpgfj4OX9lC/oEAo2FPLntZtfqh
	Xq+fnIOKdMBYUF/HCMNNJKBKp2zomuMfCdn8TCfQcYgH1r0lacXXQ8RizsqrEWmtdSlqvLkH4iS
	ccdjmYDaJN+PvTpLMyqNXXfOvEerl6Kq2BZ/5UIgO1B+L4wVUzXvoHoTWSmnjlMhuo8/xkAS16F
	PscASdvxz+B0CS7N6t7aRDmR7TXxrt7t59hScBdbfESUkDYuDu4piq1BLxjYUiOjet9xwxpru/1
	wT94qZlIuVSav1mCvvZ5MtrJU3ABZx3l09eLTOOMoLNOLuVfrCdvc+iz7sMWqTKSF/f34iOvfBO
	feYwWqThNuHNpOBpOLT2xlpsoqf0VSKqwRiOzSsyU8YjWdtvqY9YNl9DN5I7MduMQ=
X-Received: by 2002:a17:90b:3d87:b0:38f:837e:fc5d with SMTP id 98e67ed59e1d1-395c334050emr8239662a91.3.1787295353530;
        Thu, 20 Aug 2026 23:55:53 -0700 (PDT)
Received: from [127.0.0.1] ([52.157.33.132])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395c4be666bsm2004069a91.11.2026.08.20.23.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 23:55:52 -0700 (PDT)
Message-Id: <pull.2208.git.1787295352016.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 21 Aug 2026 06:55:51 +0000
Subject: [PATCH] send-pack: avoid sending the whole tree when pushing from a
 shallow clone
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

When pushing from a shallow clone, even if we only have made a small
one-line change to a tiny file, we often push the entire toplevel tree
of files.  For large repositories, this could be gigabytes instead of
kilobytes.

The reason for this is that the push likely lacks the commits the
receiver has advertised, so it walks back to its shallow grafts.  Since
it doesn't know that the server has anything, it sends the entire tree
for the graft.  It would also send the parents of the shallow graft,
except the shallow clone doesn't have those by construction.  We thus
are forced to assume that the server has the parents of the shallow
graft -- if it doesn't, the server's receive-pack will reject the push.

But that raises the obvious question: if we're going to assume the
server has the parents of the shallow graft, why not just assume the
server has the shallow graft itself -- which this clone almost certainly
received from the server when the shallow clone was created?  As noted
above, receive-pack already has a builtin connectivity check that
predates pushing from a shallow clone by years[*], so even if a client
is pushing to a different server than it cloned from, the worst that
happens is a rejected push.  And by assuming the server has the shallow
graft commits, then for large repositories (those most likely to use
shallow clone) we can avoid transferring (and perhaps re-compressing)
gigabytes of file contents that the server already has.

[*] Compare 5dbd76760181 (receive/send-pack: support pushing from a
    shallow clone, 2013-12-05) and 52fed6e1ce07 (receive-pack: check
    connectivity before concluding "git push", 2011-09-02)

Fix this by finding the shallow grafts behind the history we're pushing
and adding them to the pack boundary as uninteresting (negative) tips,
so the generated pack leaves out everything underneath them.  We only
use grafts that the pushed commits can actually reach; excluding every
graft in the repository would be simpler, but it could drop an object we
really do need to send -- for example, a new blob we're pushing that
also happens to sit under some unrelated shallow root pulled from a
different remote.

We can also stop early at any commit we and the server both have --
one the server advertised, or that push negotiation found in common.
Such a commit already marks the edge of what we need to send, so
there's no reason to keep walking down to a graft below it.  For
deeper clones the server usually has a commit close by, which keeps
this walk short; we only reach a graft when we and the server share no
history that we know about.

One very rare (and non-default) workflow genuinely needs the larger
push: seeding a receiver willing to adopt new shallow roots
(receive.shallowUpdate; see 5dbd76760181 (receive/send-pack: support
pushing from a shallow clone, 2013-12-05) and 0a1bc12b6e40
(receive-pack: allow pushes that update .git/shallow, 2013-12-05)).
When the server sets receive.shallowUpdate, it is willing to accept
pushes despite lacking ancestors of the pushed commits.  But it expects
us to send all tree objects so it can graft a new shallow root.  For
that case, add a sender-side config, push.shallowExcludeBoundary,
defaulting to true (the optimization), while allowing users to set it to
false to restore the previous behavior needed for that rare case.

Update the existing shallow-seeding tests in t5538 to set
push.shallowExcludeBoundary=false, since they exercise that
receive.shallowUpdate path.  Add tests for the optimized default and the
opt-out, that a rejected ref does not cause an accepted ref to be
over-excluded, and that a shallowUpdate receiver still rejects a
rootless snapshot by default.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
    send-pack: avoid sending the whole tree when pushing from a shallow
    clone
    
    Maintainer note: The base for this series is
    ps/odb-pluggable-pack-generation; that series' removal of feed_object()
    conflicted with my original version of this patch, so I rebased on that
    series and fixed up the conflict.
    
    Users can work around the problem described in this patch with
    push.negotiate=true, but while we can educate some users to set that,
    trying to get them all to do so is quite unlikely. Let's help users by
    providing sane default behavior.
    
    One alternative I considered here is making the new
    push.shallowExcludeBoundary config a tri-state: true, false, or abort,
    and default to abort. If abort, then when shallow grafts are reached by
    send-pack, simply abort the push on the client side and tell the user to
    set push.shallowExcludeBoundary to either true or false. That'd be the
    more traditional backward compatibility approach of introducing an error
    period before changing the default. But since the "traditional" case
    seems extraordinarily rare to me and already requires additional special
    configuration (receive.shallowUpdate=true on any relevant server), I
    thought the transition period wasn't warranted in this case. Let me know
    if you disagree.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2208%2Fnewren%2Favoid-expensive-shallow-pushes-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2208/newren/avoid-expensive-shallow-pushes-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2208

 Documentation/config/push.adoc |  12 +++
 send-pack.c                    |  95 ++++++++++++++++++++
 t/t5538-push-shallow.sh        | 156 ++++++++++++++++++++++++++++++++-
 3 files changed, 260 insertions(+), 3 deletions(-)

diff --git a/Documentation/config/push.adoc b/Documentation/config/push.adoc
index 28132eedfe..9fd6a956a8 100644
--- a/Documentation/config/push.adoc
+++ b/Documentation/config/push.adoc
@@ -134,6 +134,18 @@ This will result in only b (a and c are cleared).
 	rely solely on the server's ref advertisement to find commits
 	in common.
 
+`push.shallowExcludeBoundary`::
+	When pushing from a shallow repository (see linkgit:git-clone[1]
+	`--depth`), Git normally assumes that the receiving end already
+	has the pushing repository's shallow grafts, and omits those
+	objects from the generated pack rather than resending the full
+	toplevel tree of those grafts. This is safe because the
+	receiving end rejects a push that references objects it does not
+	have. Set this to `false` to send those objects anyway; this is
+	only needed for the highly unusual case of using a push to seed
+	a receiver that adopts new shallow roots (i.e. a receiver that
+	has explicitly set `receive.shallowUpdate`). Default is `true`.
+
 `push.useBitmaps`::
 	If set to `false`, disable use of bitmaps for `git push` even if
 	`pack.useBitmaps` is `true`, without preventing other git operations
diff --git a/send-pack.c b/send-pack.c
index f20460fbf4..9a035d7403 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -14,6 +14,7 @@
 #include "transport.h"
 #include "version.h"
 #include "oid-array.h"
+#include "oidset.h"
 #include "gpg-interface.h"
 #include "shallow.h"
 #include "parse-options.h"
@@ -55,6 +56,86 @@ static void append_negative_object(struct repository *r,
 	oid_array_append(haves, oid);
 }
 
+static int check_to_send_update(const struct ref *ref, const struct send_pack_args *args);
+
+/*
+ * Add the shallow grafts (nr_parent == -1), which are reachable from the
+ * refs being pushed, to the pack boundary ("haves") as uninteresting
+ * (negative) tips so the generated pack leaves out everything beneath them.
+ *
+ * Walk only from the pushed tips, and only until a graft: using a graft
+ * that does not bound the pushed history could exclude an object we are
+ * genuinely sending (if it is also reachable from that unrelated graft).
+ * Stop early at any commit the peer already has, since it is a negative
+ * the peer can use and the graft beneath it would be redundant.
+ */
+static void append_reachable_shallow_grafts(struct repository *r,
+					    struct ref *refs,
+					    struct oid_array *advertised,
+					    struct oid_array *negotiated,
+					    struct send_pack_args *args,
+					    struct oid_array *haves)
+{
+	struct commit_list *pending = NULL;
+	struct oidset seen = OIDSET_INIT;
+	struct oidset known = OIDSET_INIT;
+	struct ref *ref;
+	size_t i;
+
+	for (i = 0; i < advertised->nr; i++)
+		oidset_insert(&known, &advertised->oid[i]);
+	for (i = 0; i < negotiated->nr; i++)
+		oidset_insert(&known, &negotiated->oid[i]);
+	for (ref = refs; ref; ref = ref->next)
+		if (!is_null_oid(&ref->old_oid))
+			oidset_insert(&known, &ref->old_oid);
+
+	for (ref = refs; ref; ref = ref->next) {
+		struct commit *commit;
+
+		if (is_null_oid(&ref->new_oid))
+			continue;
+		if (check_to_send_update(ref, args))
+			continue;
+		commit = lookup_commit_reference_gently(r, &ref->new_oid, 1);
+		if (commit)
+			commit_list_insert(commit, &pending);
+	}
+
+	while (pending) {
+		struct commit *commit = pop_commit(&pending);
+		const struct object_id *oid = &commit->object.oid;
+		struct commit_graft *graft;
+		struct commit_list *parent;
+
+		if (oidset_insert(&seen, oid))
+			continue;
+
+		/*
+		 * A commit the peer already has bounds the pushed history
+		 * with a negative it can use, so stop here rather than
+		 * descend to a graft that would only be redundant.
+		 */
+		if (oidset_contains(&known, oid) &&
+		    odb_has_object(r->objects, oid, 0))
+			continue;
+
+		graft = lookup_commit_graft(r, oid);
+		if (graft && graft->nr_parent == -1) {
+			append_negative_object(r, haves, oid);
+			continue;
+		}
+
+		if (repo_parse_commit(r, commit))
+			continue;
+		for (parent = commit->parents; parent; parent = parent->next)
+			commit_list_insert(parent->item, &pending);
+	}
+
+	oidset_clear(&seen);
+	oidset_clear(&known);
+}
+
 /*
  * Make a pack stream and spit it out into file descriptor fd
  */
@@ -88,6 +169,20 @@ static int pack_objects(struct repository *r,
 	for (size_t i = 0; i < negotiated->nr; i++)
 		append_negative_object(r, &opts.haves, &negotiated->oid[i]);
 
+	/*
+	 * When pushing from a shallow repository, avoid re-pushing the
+	 * entire toplevel tree.
+	 */
+	if (is_repository_shallow(r)) {
+		int exclude_boundary = 1;
+		repo_config_get_bool(r, "push.shallowexcludeboundary",
+				     &exclude_boundary);
+		if (exclude_boundary)
+			append_reachable_shallow_grafts(r, refs, advertised,
+							negotiated, args,
+							&opts.haves);
+	}
+
 	while (refs) {
 		if (!is_null_oid(&refs->old_oid))
 			append_negative_object(r, &opts.haves, &refs->old_oid);
diff --git a/t/t5538-push-shallow.sh b/t/t5538-push-shallow.sh
index afab456b32..6b0425bdbc 100755
--- a/t/t5538-push-shallow.sh
+++ b/t/t5538-push-shallow.sh
@@ -64,7 +64,8 @@ EOF
 test_expect_success 'push from shallow clone, with grafted roots' '
 	(
 	cd shallow2 &&
-	test_must_fail git push ../.git +main:refs/remotes/shallow2/main 2>err &&
+	test_must_fail git -c push.shallowExcludeBoundary=false \
+		push ../.git +main:refs/remotes/shallow2/main 2>err &&
 	test_grep "shallow2/main.*shallow update not allowed" err
 	) &&
 	test_must_fail git rev-parse shallow2/main &&
@@ -75,7 +76,8 @@ test_expect_success 'add new shallow root with receive.updateshallow on' '
 	test_config receive.shallowupdate true &&
 	(
 	cd shallow2 &&
-	git push ../.git +main:refs/remotes/shallow2/main
+	git -c push.shallowExcludeBoundary=false \
+		push ../.git +main:refs/remotes/shallow2/main
 	) &&
 	git log --format=%s shallow2/main >actual &&
 	git fsck &&
@@ -90,7 +92,8 @@ test_expect_success 'push from shallow to shallow' '
 	(
 	cd shallow &&
 	git --git-dir=../shallow2/.git config receive.shallowupdate true &&
-	git push ../shallow2/.git +main:refs/remotes/shallow/main &&
+	git -c push.shallowExcludeBoundary=false \
+		push ../shallow2/.git +main:refs/remotes/shallow/main &&
 	git --git-dir=../shallow2/.git config receive.shallowupdate false
 	) &&
 	(
@@ -164,4 +167,151 @@ test_expect_success 'push new commit from shallow clone has good deltas' '
 	test_region pack-objects path-walk config-push.txt
 '
 
+test_expect_success 'shallow push only pushes what is necessary' '
+	git init adv-origin &&
+	# The shallow grafts are intentionally untagged so that no
+	# advertised ref points at them.
+	test_commit --no-tag -C adv-origin a &&
+	test_commit --no-tag -C adv-origin b &&
+
+	git clone --depth=1 "file://$(pwd)/adv-origin" adv-client &&
+
+	# The remote branch advances past the history we have, so its
+	# advertised tip is something we cannot use as a negative tip;
+	# only the shallow graft lets us exclude the full tree.
+	test_commit --no-tag -C adv-origin c &&
+
+	git -C adv-client checkout -b topic &&
+	test_commit --no-tag -C adv-client new &&
+	GIT_PROGRESS_DELAY=0 git -C adv-client push --progress origin topic 2>err &&
+
+	# Only the new commit, its tree, and the new blob are sent; sending
+	# the full tree is avoided by excluding the shallow graft.
+	test_grep "Enumerating objects: 4, done." err
+'
+
+test_expect_success 'push.shallowExcludeBoundary=false sends full tree' '
+	git init adv-origin2 &&
+	test_commit --no-tag -C adv-origin2 a &&
+	test_commit --no-tag -C adv-origin2 b &&
+
+	git clone --depth=1 "file://$(pwd)/adv-origin2" adv-client2 &&
+	test_commit --no-tag -C adv-origin2 c &&
+
+	git -C adv-client2 checkout -b topic &&
+	test_commit --no-tag -C adv-client2 new &&
+	GIT_PROGRESS_DELAY=0 git -C adv-client2 \
+		-c push.shallowExcludeBoundary=false \
+		push --progress origin topic 2>err &&
+
+	# With the optimization disabled and no advertised ref pointing at
+	# the shallow graft, the full snapshot down to the shallow graft is
+	# resent, including its full tree.
+	test_grep "Enumerating objects: 7, done." err
+'
+
+# A rejected ref must not over-exclude objects that another, accepted ref
+# legitimately needs in the pack.  Set up a testcase using two independent
+# shallow roots.
+#
+#   origin: two unrelated histories; only branch A carries blob O (sh=shared)
+#       A:  A0---A1     (A0, A1 trees contain sh=O)
+#       B:  B0---B1     (no "shared" blob)
+#
+#   receiver: seeded from branch B only, under both ref names; lacks blob O
+#       refs/heads/B -> B1
+#       refs/heads/A -> B1     (makes our A push a non-fast-forward)
+#
+#   client: "clone --depth=1 --no-single-branch" gives a graft at each tip
+#           and a copy of blob O under A1   (x = cut parents = shallow graft)
+#           x        x
+#           |        |
+#          A1       B1
+#           |        |
+#          cX     topic=cY     (cY re-adds sh=O, which the receiver lacks)
+#
+#   push "A topic" (non-atomic):
+#     A     -> a non-fast-forward vs receiver A=B1, so its ref update is
+#              rejected locally and never applied.  It still takes part in
+#              the shared pack computation, and the buggy code also walked
+#              back from it to graft A1 (which owns O).
+#     topic -> accepted; cY grafts onto B1 and needs blob O.
+#
+#   Using the shallow graft A1 (an ancestor of A) to trim the pack, even
+#   though our push of A is rejected locally, would omit blob O from topic's
+#   pack -- yet topic needs O.  We want to ensure that when topic is pushed,
+#   O is sent along with it despite A being rejected.
+test_expect_success 'shallow push does not over-exclude for an accepted ref via a rejected one' '
+	# origin
+	git init tworoot-origin &&
+	git -C tworoot-origin checkout -b A &&
+	test_commit -C tworoot-origin --no-tag has-shared sh shared &&
+	test_commit -C tworoot-origin --no-tag A1 &&
+	git -C tworoot-origin switch --orphan B &&
+	test_commit -C tworoot-origin --no-tag B0 &&
+	test_commit -C tworoot-origin --no-tag B1 &&
+
+	# receiver: branch B only, exposed as both B and A
+	git init --bare tworoot-receiver.git &&
+	git -C tworoot-origin push "file://$(pwd)/tworoot-receiver.git" \
+		B:refs/heads/B B:refs/heads/A &&
+
+	# client: a shallow graft at each branch tip
+	git clone --depth=1 --no-single-branch \
+		"file://$(pwd)/tworoot-origin" tworoot-client &&
+
+	# branch A gets commit cX; including A in the push gives us a
+	# locally-rejected ref whose graft A1 the buggy code walked to.  The A
+	# ref update is a non-fast-forward, so it is rejected and never applied.
+	git -C tworoot-client checkout A &&
+	test_commit -C tworoot-client --no-tag cX &&
+
+	# branch topic is what we actually send, reintroducing blob O on B1
+	git -C tworoot-client checkout -b topic B &&
+	test_commit -C tworoot-client --no-tag reintroduce sh shared &&
+
+	# push both in one command: they share a single pack computation, so a
+	# graft reached from the rejected A can strip objects that topic needs.
+	# The A ref update is rejected locally (non-fast-forward); the shared
+	# pack must still contain blob O for topic to land on the receiver.
+	test_must_fail git -C tworoot-client push \
+		"file://$(pwd)/tworoot-receiver.git" A topic &&
+	git --git-dir=tworoot-receiver.git rev-parse --verify topic
+'
+
+# push.shallowExcludeBoundary (default true) omits the shallow boundary
+# snapshot from the pack, since an ordinary receiver already has it.  The
+# exception is a receiver willing to adopt a *new* shallow root
+# (receive.shallowUpdate): it genuinely needs that snapshot, so the default
+# optimization leaves it unable to graft the new root.  Verify the receiver
+# rejects such a push (rather than corrupting itself), and that setting the
+# config to false restores the full snapshot and lets the push succeed.  This
+# is the tradeoff that motivates the config knob.
+test_expect_success 'default push to a shallowUpdate receiver rejects a rootless snapshot' '
+	git init seed-origin &&
+	test_commit -C seed-origin s1 &&
+	test_commit -C seed-origin s2 &&
+	test_commit -C seed-origin s3 &&
+
+	# depth-2: a shallow graft at s2, pushing s3 on top of it
+	git clone --depth=2 "file://$(pwd)/seed-origin" seed-client &&
+
+	git init --bare seed-receiver.git &&
+	git --git-dir=seed-receiver.git config receive.shallowUpdate true &&
+
+	# Default (optimization on): the s2 boundary snapshot is withheld, so
+	# the receiver cannot graft the new root and rejects the push, leaving
+	# the ref uncreated.
+	test_must_fail git -C seed-client push \
+		"file://$(pwd)/seed-receiver.git" HEAD:refs/heads/seeded 2>err &&
+	test_grep "remote rejected" err &&
+	test_must_fail git --git-dir=seed-receiver.git rev-parse --verify seeded &&
+
+	# Opt-out: the full snapshot is sent, so the same push now succeeds and
+	# the new shallow root is grafted.
+	git -C seed-client -c push.shallowExcludeBoundary=false push \
+		"file://$(pwd)/seed-receiver.git" HEAD:refs/heads/seeded &&
+	git --git-dir=seed-receiver.git rev-parse --verify seeded
+'
+
 test_done

base-commit: 96650039a0dff984f3575568aea85af68474f5c3
-- 
gitgitgadget
