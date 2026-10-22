Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792712422;
	b=nN+el8z/FkAFQ2X3nbYnICsgROAIlclBpBk5zpC28L7fYSRRzmVZ7tLgUswmAtqOoOQa
	 rSW71EYq8FDmxJGSTMubMUbaKFXzNqPa6XVXueAREHel5e0csKY8Q1YdTQNdP4LK+JC8H
	 ATbruhQv9OCzJkLbIuMYUslkdyzJnpR+OV71UYRuwF2nfBqSs4HHCU1R3hkzDgsd7I15j
	 PGaglJKNjk2ieDIX2lCT/Or8jfsuanWnsJjnWfPwP4AuW910tJ5O86Jazkt5F9x+vFSrC
	 FS4ZGfz5tZl1ctKyy8U45tEXtmicnt2lcLP+uGv3yFT17tgr4+Krg+Alcokn6KQo8FA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792712422;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=6PdxZIcqKYI9kAI7qngqiM9KCM6phWi4aHaZuDGo1BA=;
	b=GAH71tDha9hyJbS4QlZaDc/enJwNHRM5w5mv4CgBB07pbQoDZx+LfGLyXY3MO5sfmbam
	 2KlDF9g2BCg7n00+GOHCRuILE36FWo0oyijkjU7QVG6roC+3lliu2J4WTxC/QEvCV2uiF
	 SGWtATpLfmxTIK0te66hAPzWHBT32y65QnNHyjngjBlWI/eTzxb0KdBpkzec7V0CnEFm+
	 MQdbUvASnn9+tIQqjTfKbukyis1Nkt61qBCJ0ir+qk/qBBlQZKZZPdW5gvrdQOMiF65k7
	 uAtlCaX6z2Cog0bGRBq34u0MZrGBBBG0s2r9iT3HS0BBSGZXC86t8BGQiqVachJiLeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=T2r2XFmC;
	arc=none smtp.remote-ip=209.85.167.170
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D510606A31B
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 23:40:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D510606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=T2r2XFmC
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-53dda625f63so215288b6e.1
        for <git@vger.kernel.org>; Thu, 22 Oct 2026 16:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792712420; x=1793317220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6PdxZIcqKYI9kAI7qngqiM9KCM6phWi4aHaZuDGo1BA=;
        b=T2r2XFmCYj6l32PbFzxoD8ChwjrEjcJzUvKMJ4X/Jk1nzgq4G+LJzLjY7o05JdKt71
         ZCtlaHyBAyOKx7/jFOS8PlDCYwArssui/U/X/hDBNhIyRfGBVGOoevrMrXskQD5wP5ll
         sGs5Rb8ByvNO8R+4FlRLTXxx+85FC8PB3xTAT6CmW0sKb8xzt2cAdhfLIGcVimZZ8yBF
         M31T8aIMRJyU9kJBpluy1JVsFB7aDuPkQNB+Hu1DycTScXQrcgmyCRWROVmyHvmUnI9Q
         x+9EH2DWcqxaKZx1oQCT+fAAVfnRj+LORZTG+P6xEZSOxGayBTMjSW5mIzGxQWQRBBTw
         tR3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792712420; x=1793317220;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6PdxZIcqKYI9kAI7qngqiM9KCM6phWi4aHaZuDGo1BA=;
        b=wGHRCIimdNwK5/jRFhFMHkpezN8SNOEW1eWQQeyiojs8A6if17q78OhborS4a0rCwy
         zrwFoP+mrMuxrP0aMbFj2qQl7szsFoN8XAy2pLuqw7WzMQprn2WsQk/Z1GMORrx4S4hA
         Bt7bCHOl+f75sI+MMMwJoYFOArSh/fe6Bf5sk+QRFuiniGa4GU39Z8GAzrZEXMXiJpA9
         rpEDGQvOotnrRAGUm4Ts8J8ZLUVPWQMzg9ZDWhL2v9n5FIrwQdm8tgJ2xZbsqTFOtsFJ
         nxwu/nUhnX2UO5bMpaupp+G+nNwZw3LlnOAxn4GufBjie8vnmIdv0CDTTqjlxGERCZUt
         Bowg==
X-Gm-Message-State: AFq9FYKWFnpzaHMAxlxijlnZmv6Qf57MR+SntvBcfhJV/SG+MvsGJNks
	epkPefxOPsgbP1gBh71ylGvauN7wOgxv3UodiJheEoh54sYoEa+V0C2iecQN3g==
X-Gm-Gg: AYBFou28jNu3OBMwL2s0OfTxiow3c4mnkD02t7eCX5ks0559MAFY/CFWsjcNS7c/kfF
	NXt5cN6n+OCmjIrl7tL3ubIcyaa3aNmkuiJh2al7oyR8eq4+Nk8hnyZJ1n3QP/AO8DWVYy6G4D0
	OPxydmlvmKW10fnpPmVQ9tYTvHusAnvl2fw38G+1M8vcHSSaiPUVCnIdT9YBpJ3HubAW7Ty7Fok
	PzagIKuu39AQFXpmA0e+sekEwQhIazEjtcA9janl8KUxLpCwu+x84V5VejWANUuMg5WV1mrcfew
	c75hxR8mev5I5S9e71av6GBvnMjoAn3EmnnWU/4Z6WoUU5cUSThM7mOLqI5T2BgMHYxLn79eV/X
	DViQbVSEwTjHQcnpMlypAvUthrxx94b/K8hZ3bq89pJZ+6vJ8U2Fx/4D8Qk6HFBv2vJ44pM5hp3
	OzWoDKtiunjgdmo6erLLC9NY5WrTDob1MNcbp60N4ZPGUH2Mzw9M2MFZmh/8/LUpAAgNf+sKP0Y
	RjkeU32FllnuGhiVp3Zwkv1fa4PBheFZue1ZYho+RPy00t9ZZvfQ7RUIvVXjvkYtdghud7mVCk0
	GO96kBEznx0Eqfn2XGI=
X-Received: by 2002:a05:6808:3091:b0:4d6:92d4:c804 with SMTP id 5614622812f47-55be8741801mr425475b6e.60.1792712420421;
        Thu, 22 Oct 2026 16:40:20 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-55be90bf98fsm334039b6e.0.2026.10.22.16.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 16:40:19 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
Subject: [PATCH] tmp-objdir: merge loose object index when migrating tmpdir
Date: Thu, 22 Oct 2026 18:40:07 -0500
Message-ID: <20261022234007.3081825-1-jltobler@gmail.com>
X-Mailer: git-send-email 2.56.0.173.gf57c9a7388
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a repository is configured with a compatibility hash, each loose
object write also records a mapping between the object and its
compatibility hash in a "loose-object-idx" file. This index is located
in the same object database the object is written to. If batch fsync of
loose objects is also enabled, the loose objects and index file are
instead written to a temporary object directory and expected to be
migrated to the primary object directory when the batch transaction
commits.

While migrating the loose objects works, the "loose-object-idx" file is
unable to be migrated if an index already exists in the primary object
directory. This occurs because `finalize_object_file_flags()` expects an
already existing file to have the same contents. Otherwise, the
following error is returned:

  error: files '.git/objects/tmp_objdir-bulk-fsync-XXXXXX/loose-object-idx' and '.git/objects/loose-object-idx' differ in contents
  error: unable to migrate temporary objects

Furthermore, it is not sufficient to just replace the preexisting index
with the new one as the new index only contains mapping entries for the
newly written objects.

Update the temporary directory migration logic to handle
"loose-object-idx" files explicitly by appending new mapping entries to
the primary index.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---

Greetings,

While working on a separate patch series to convert the "files" ODB
transaction to be eagerly created instead of lazily, I encountered this
bug that causes an ODB transaction to fail on commit when a
compatibility hash is also configured. This occurs because the temporary
directory migration code does not know how to handle the loose object
index file.

This patch addresses updating the migration logic to explicitly merge
mapping entries in the transaction by appending them to the primary
loose object index file.

Some other approaches I considered:
  - Storing the uncommitted object mapping entries in the transaction
    without writing a file and only writing on transaction commit. I
    chose to keep writing the temp index into the transaction so that
    child processes that write to the tempdir could still append entries.
  - Also writing mapping entires to the main ODB loose object index.
    This also didn't seem like a good apprach because it write entires
    that may not ultimately get committed.

Thanks for the review,
-Justin

---
 loose.c                       | 72 +++++++++++++++++++++++++++++++++++
 loose.h                       |  2 +
 t/t1016-compatObjectFormat.sh | 27 +++++++++++++
 tmp-objdir.c                  | 11 +++++-
 4 files changed, 111 insertions(+), 1 deletion(-)

diff --git a/loose.c b/loose.c
index d6a2bb5ba3..79d4c256e0 100644
--- a/loose.c
+++ b/loose.c
@@ -265,3 +265,75 @@ void loose_object_map_clear(struct loose_object_map **map)
 	free(m);
 	*map = NULL;
 }
+
+int loose_object_idx_merge(struct repository *repo, const char *src,
+			   const char *dst)
+{
+	struct lock_file lock = LOCK_INIT;
+	struct strbuf buf = STRBUF_INIT;
+	struct stat st;
+	FILE *fp;
+	int fd = -1;
+	int ret;
+
+	fp = fopen(src, "r");
+	if (!fp) {
+		ret = error_errno(_("unable to open %s"), src);
+		goto out;
+	}
+	if (strbuf_getwholeline(&buf, fp, '\n') || strcmp(buf.buf, loose_object_header)) {
+		ret = error(_("invalid loose object index %s"), src);
+		goto out;
+	}
+
+	if (repo_hold_lock_file_for_update_timeout(repo, &lock, dst, 0, -1) < 0) {
+		ret = error_errno(_("unable to lock %s"), dst);
+		goto out;
+	}
+
+	fd = open(dst, O_WRONLY | O_CREAT | O_APPEND, 0666);
+	if (fd < 0) {
+		ret = error_errno(_("unable to open %s"), dst);
+		goto out;
+	}
+	if (fstat(fd, &st) < 0) {
+		ret = error_errno(_("unable to stat %s"), dst);
+		goto out;
+	}
+
+	/* Create the loose-object-idx if one does not already exist. */
+	if (!st.st_size && write_in_full(fd, loose_object_header,
+					 strlen(loose_object_header)) < 0) {
+		ret = error_errno(_("failed to write loose object index header"));
+		goto out;
+	}
+
+	while (!strbuf_getwholeline(&buf, fp, '\n')) {
+		if (write_in_full(fd, buf.buf, buf.len) < 0) {
+			ret = error_errno(_("failed to write loose object index %s"),
+					  dst);
+			goto out;
+		}
+	}
+
+	ret = close(fd);
+	fd = -1;
+	if (ret) {
+		ret = error_errno(_("unable to close %s"), dst);
+		goto out;
+	}
+
+	adjust_shared_perm(repo, dst);
+
+	ret = 0;
+
+out:
+	rollback_lock_file(&lock);
+	strbuf_release(&buf);
+	if (fd >= 0)
+		close(fd);
+	if (fp)
+		fclose(fp);
+
+	return ret;
+}
diff --git a/loose.h b/loose.h
index ed663ac550..35b46f4be5 100644
--- a/loose.h
+++ b/loose.h
@@ -23,5 +23,7 @@ int repo_add_loose_object_map(struct odb_source_loose *loose,
 			      const struct object_id *compat_oid);
 int repo_read_loose_object_map(struct repository *repo);
 int repo_write_loose_object_map(struct repository *repo);
+int loose_object_idx_merge(struct repository *repo, const char *src,
+			   const char *dst);
 
 #endif
diff --git a/t/t1016-compatObjectFormat.sh b/t/t1016-compatObjectFormat.sh
index 9cafcee509..bebf71bc29 100755
--- a/t/t1016-compatObjectFormat.sh
+++ b/t/t1016-compatObjectFormat.sh
@@ -305,4 +305,31 @@ compare_oids GPG2 'commit' signedcommit4 "$signedcommit4_sha1_oid" "$signedcommi
 compare_oids GPG2 'tag' signedtag3 "$signedtag3_sha1_oid" "$signedtag3_sha256_oid"
 compare_oids GPG2 'tag' signedtag4 "$signedtag4_sha1_oid" "$signedtag4_sha256_oid"
 
+test_expect_success 'batched fsync migrates loose object index' '
+	test_when_finished "rm -rf batch-fsync" &&
+	git init --object-format=sha1 batch-fsync &&
+	(
+		cd batch-fsync &&
+		git config core.repositoryFormatVersion 1 &&
+		git config extensions.compatObjectFormat sha256 &&
+		git config core.fsync loose-object &&
+		git config core.fsyncMethod batch &&
+
+		# Write object to generate initial loose object index.
+		echo foo >foo &&
+		git add foo &&
+		test_grep "$(git rev-parse :foo)" .git/objects/loose-object-idx &&
+
+		# Write some additional objects and ensure the corresponding
+		# temporary loose object index entries stored in the transaction
+		# are merged into the primary ODB.
+		echo bar >bar &&
+		echo baz >baz &&
+		git add bar baz &&
+		test_grep "$(git rev-parse :foo)" .git/objects/loose-object-idx &&
+		test_grep "$(git rev-parse :bar)" .git/objects/loose-object-idx &&
+		test_grep "$(git rev-parse :baz)" .git/objects/loose-object-idx
+	)
+'
+
 test_done
diff --git a/tmp-objdir.c b/tmp-objdir.c
index 3debb60270..5307717354 100644
--- a/tmp-objdir.c
+++ b/tmp-objdir.c
@@ -4,6 +4,7 @@
 #include "chdir-notify.h"
 #include "dir.h"
 #include "environment.h"
+#include "loose.h"
 #include "object-file.h"
 #include "path.h"
 #include "string-list.h"
@@ -294,6 +295,11 @@ static int is_loose_object_shard(const char *name)
 	return strlen(name) == 2 && isxdigit(name[0]) && isxdigit(name[1]);
 }
 
+static int is_loose_object_idx(const char *name)
+{
+	return !strcmp(name, "loose-object-idx");
+}
+
 static int migrate_paths(struct tmp_objdir *t,
 			 struct strbuf *src, struct strbuf *dst,
 			 enum finalize_object_file_flags flags)
@@ -317,7 +323,10 @@ static int migrate_paths(struct tmp_objdir *t,
 		if (is_loose_object_shard(name))
 			flags_copy |= FOF_SKIP_COLLISION_CHECK;
 
-		ret |= migrate_one(t, src, dst, flags_copy);
+		if (is_loose_object_idx(name))
+			ret |= loose_object_idx_merge(t->repo, src->buf, dst->buf);
+		else
+			ret |= migrate_one(t, src, dst, flags_copy);
 
 		strbuf_setlen(src, src_len);
 		strbuf_setlen(dst, dst_len);

base-commit: 7e34d8174dcda3435d1404c9a30bef46afe6c13e
-- 
2.56.0.173.gf57c9a7388

