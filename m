Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE9032AAA8
	for <git@vger.kernel.org>; Tue, 28 Apr 2026 16:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777393593; cv=none; b=e1U0fPmTvRyVA4c2Wg5CEGDBsxR8lBmHWdUUQq5wDCJP3fr/rdrgePy9w6PQ/sJ1JB8Xtyeybl+NAU6KuIv+cJQQ2aGgoZqhkJcI1i5p23m535Ty5w8IM0gApmyfSpIrwtjfTkk+zyAdj22wSciqfn02XFYB2ZEuY8CzwYnMaO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777393593; c=relaxed/simple;
	bh=pewfZXQySmLP9PgqkybgdC0FHEe4AWZEuRdR7E7OI3Q=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=apcmsuv+juJn8yy3enJAaQ+nLFl7NhC6+1whnXqoa/AUBPipCEGxgPdo5zBYp0eZ8XhomHIoruxQbgWsRK9O/4uidY3FdSSmknWOgIYZxmEzDvPQnkAJ9EWgn93CwyRuyOkWQmgHBytm7kps/6Ww44d2jUjti17IEoMFIsBXgzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eUoRdy0V; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eUoRdy0V"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7dbec19732eso9881007a34.3
        for <git@vger.kernel.org>; Tue, 28 Apr 2026 09:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777393590; x=1777998390; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nZOWmtOiCy+qQAVoehJEJnvyJBE7fdTTfnBA2g8JJnM=;
        b=eUoRdy0V2+GCzOdcuzenlNVSW/EGmKXRkwBJtCMIQmAU4AgH5BglxLizcsxXv8it8x
         a3m2jGCD+P447xcoqxRKTtzy093zPVzlXlOMN6ISKU9+DTiyL6QnwrvfEfnYDDbsPiwD
         YhPeixZRdBBVJq1bsW08e9DE7pB4isS1c1DeevWXTn0nXa0Ouo942NPhU4ZRm2So9Pm2
         26Ppxi/r1cwAFa+tMPL8abTkZzMrsjExdQ4cWB4f1MqfgWmPxzfnGAttfYhjVryHB7Ht
         Rkvxr4YM8mPFzvKuPo+aul+8NY39g4QoJzwZCiAqhWTyV4afYgPUMgQm4IdvevoX3nq8
         Ue/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777393590; x=1777998390;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nZOWmtOiCy+qQAVoehJEJnvyJBE7fdTTfnBA2g8JJnM=;
        b=kP0XOEkrhKieWATi/hbIPd9we1F10G8G7nE8DoJBDm0p0AS6XyAtjhCgJplj/2/61K
         kW46r5yCWBzkeUgWyXAptwmG0eMaViNIUOTaesQa9IqGB18+Ktmh4xcfMVUA8UZnn36a
         X8cdREchKY5Sn4c6Qlwk3njkXDLRFfLBDaiIxsV489ifLeZC9+z+diWtGnKkPQQ+wBSY
         Sk5SsShXsCcWGjJSc+bHs+toOPCIvJEOh07jExqarEeSHUHSXuSN6Gl2K31A8KkevU9w
         +ULrHGZ5NjCZDZHHZNDiss7Xdd1J7y8meKcmE3i2NME/sdpjn+r8/dk0cy0ovLIU8vAg
         SjJQ==
X-Gm-Message-State: AOJu0YwnCq+aL9TT9q3dLPm5lrE30KR1t/VinWJJ3+f1K7YNRKlYcyZP
	NJOunxvc7SFD06TOxHfM3oOq2wPDsaaZaSAtraX3B8Rkvc3yqMsTkcw7bGmKrQ==
X-Gm-Gg: AeBDiestvf/rZGqjGZXoe05t5aLf5gDJBjF8LXJBaBGpET+4Q3UMPycvBaYibxeUNZw
	Tqf4ydlze18HQYDgy+DVb4+fONJt8+vlYSKqT1sAN46xh/safkDEYkzh/u/xRLD83MR3mHxz/h8
	p8hVWyTlVkRZmDzR/wuf3KpehTT0Byz/ThJmw9BU8YGrnvy6fhq/ccgjO6HGD9C5iX3z7kPWV/x
	wnGjptzDsZSMpS3OUuYIsNh/54n2QFHRvVIDYlOBFzt+Cx9aXQMbmL7f0mUv3YwRdQnFJUCrjVA
	KENmP1crn5vAVQmdGu/D7vu7WV7vur4IuZngYGewfXgXtDEhDGWFEddhjwlVQ6YKAajhdGJs2f3
	itLiGVIn/fqpZQZSSe8yZmwd17anozJf582yoxM2nAgF4M9A0mDPqZG/9COvzoIL1tRA8Qc6oeZ
	gTO+oO8fnXy2khbPNlhHzF6iwGzKeP+LYlI7XthMc=
X-Received: by 2002:a05:6830:8284:b0:7d9:b58e:55ed with SMTP id 46e09a7af769-7dea6847629mr155418a34.25.1777393589727;
        Tue, 28 Apr 2026 09:26:29 -0700 (PDT)
Received: from [127.0.0.1] ([172.212.163.230])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7de986a6da5sm2081201a34.20.2026.04.28.09.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 09:26:29 -0700 (PDT)
Message-Id: <afa74a3a2b9caf9989055a9311309f590729d6c1.1777393580.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2102.git.1777393580.gitgitgadget@gmail.com>
References: <pull.2102.git.1777393580.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 28 Apr 2026 16:26:19 +0000
Subject: [PATCH 5/6] test-tool: add a helper to synthesize large packfiles
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

To test Git's behavior with very large pack files, we need a way to
generate such files quickly.

A naive approach using only readily-available Git commands would take
over 10 hours for a 4GB pack file, which is prohibitive.

Side-stepping Git's machinery and actual zlib compression by writing
uncompressed content with the appropriate zlib header makes things
much faster. The fastest method using this approach generates many
small, unreachable blob objects and takes about 1.5 minutes for 4GB.
However, this cannot be used because we need to test git clone, which
requires a reachable commit history.

Generating many reachable commits with small, uncompressed blobs takes
about 4 minutes for 4GB. But this approach 1) does not reproduce the
issues we want to fix (which require individual objects larger than
4GB) and 2) is comparatively slow because of the many SHA-1
calculations.

The approach taken here generates a single large blob (filled with NUL
bytes), along with the trees and commits needed to make it reachable.
This takes about 2.5 minutes for 4.5GB, which is the fastest option
that produces a valid, clonable repository with an object large enough
to trigger the bugs we want to test.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Makefile                   |   1 +
 compat/zlib-compat.h       |   2 +
 t/helper/meson.build       |   1 +
 t/helper/test-synthesize.c | 250 +++++++++++++++++++++++++++++++++++++
 t/helper/test-tool.c       |   1 +
 t/helper/test-tool.h       |   1 +
 6 files changed, 256 insertions(+)
 create mode 100644 t/helper/test-synthesize.c

diff --git a/Makefile b/Makefile
index cedc234173..85405cb5b8 100644
--- a/Makefile
+++ b/Makefile
@@ -872,6 +872,7 @@ TEST_BUILTINS_OBJS += test-submodule-config.o
 TEST_BUILTINS_OBJS += test-submodule-nested-repo-config.o
 TEST_BUILTINS_OBJS += test-submodule.o
 TEST_BUILTINS_OBJS += test-subprocess.o
+TEST_BUILTINS_OBJS += test-synthesize.o
 TEST_BUILTINS_OBJS += test-trace2.o
 TEST_BUILTINS_OBJS += test-truncate.o
 TEST_BUILTINS_OBJS += test-userdiff.o
diff --git a/compat/zlib-compat.h b/compat/zlib-compat.h
index ac08276622..5078c5ef6c 100644
--- a/compat/zlib-compat.h
+++ b/compat/zlib-compat.h
@@ -7,6 +7,8 @@
 # define z_stream_s zng_stream_s
 # define gz_header_s zng_gz_header_s
 
+# define adler32(adler, buf, len) zng_adler32(adler, buf, len)
+
 # define crc32(crc, buf, len) zng_crc32(crc, buf, len)
 
 # define inflate(strm, bits) zng_inflate(strm, bits)
diff --git a/t/helper/meson.build b/t/helper/meson.build
index 675e64c010..3235f10ab8 100644
--- a/t/helper/meson.build
+++ b/t/helper/meson.build
@@ -69,6 +69,7 @@ test_tool_sources = [
   'test-submodule-nested-repo-config.c',
   'test-submodule.c',
   'test-subprocess.c',
+  'test-synthesize.c',
   'test-tool.c',
   'test-trace2.c',
   'test-truncate.c',
diff --git a/t/helper/test-synthesize.c b/t/helper/test-synthesize.c
new file mode 100644
index 0000000000..3ce7078078
--- /dev/null
+++ b/t/helper/test-synthesize.c
@@ -0,0 +1,250 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
+#include "test-tool.h"
+#include "git-compat-util.h"
+#include "git-zlib.h"
+#include "hash.h"
+#include "hex.h"
+#include "object-file.h"
+#include "object.h"
+#include "pack.h"
+#include "parse-options.h"
+#include "parse.h"
+#include "repository.h"
+#include "setup.h"
+#include "strbuf.h"
+#include "write-or-die.h"
+
+#define BLOCK_SIZE 0xffff
+static const unsigned char zeros[BLOCK_SIZE];
+
+/*
+ * Write data as an uncompressed zlib stream.
+ * For data larger than 64KB, writes multiple uncompressed blocks.
+ * If data is NULL, writes zeros.
+ * Updates the pack checksum context.
+ */
+static void write_uncompressed_zlib(FILE *f, struct git_hash_ctx *pack_ctx,
+				    const void *data, size_t len,
+				    const struct git_hash_algo *algo)
+{
+	unsigned char zlib_header[2] = { 0x78, 0x01 }; /* CMF, FLG */
+	unsigned char block_header[5];
+	const unsigned char *p = data;
+	size_t remaining = len;
+	uint32_t adler = 1L; /* adler32 initial value */
+	unsigned char adler_buf[4];
+
+	/* Write zlib header */
+	fwrite_or_die(f, zlib_header, sizeof(zlib_header));
+	algo->update_fn(pack_ctx, zlib_header, 2);
+
+	/* Write uncompressed blocks (max 64KB each) */
+	do {
+		size_t block_len = remaining > BLOCK_SIZE ? BLOCK_SIZE : remaining;
+		int is_final = (block_len == remaining);
+		const unsigned char *block_data = data ? p : zeros;
+
+		block_header[0] = is_final ? 0x01 : 0x00;
+		block_header[1] = block_len & 0xff;
+		block_header[2] = (block_len >> 8) & 0xff;
+		block_header[3] = block_header[1] ^ 0xff;
+		block_header[4] = block_header[2] ^ 0xff;
+
+		fwrite_or_die(f, block_header, sizeof(block_header));
+		algo->update_fn(pack_ctx, block_header, 5);
+
+		if (block_len) {
+			fwrite_or_die(f, block_data, block_len);
+			algo->update_fn(pack_ctx, block_data, block_len);
+			adler = adler32(adler, block_data, block_len);
+		}
+
+		if (data)
+			p += block_len;
+		remaining -= block_len;
+	} while (remaining > 0);
+
+	/* Write adler32 checksum */
+	put_be32(adler_buf, adler);
+	fwrite_or_die(f, adler_buf, sizeof(adler_buf));
+	algo->update_fn(pack_ctx, adler_buf, 4);
+}
+
+/*
+ * Write an uncompressed object to the pack file.
+ * If `data == NULL`, it is treated like a buffer to NUL bytes.
+ * Updates the pack checksum context.
+ */
+static void write_pack_object(FILE *f, struct git_hash_ctx *pack_ctx,
+			      enum object_type type,
+			      const void *data, size_t len,
+			      struct object_id *oid,
+			      const struct git_hash_algo *algo)
+{
+	unsigned char pack_header[MAX_PACK_OBJECT_HEADER];
+	char object_header[32];
+	int pack_header_len, object_header_len;
+	struct git_hash_ctx ctx;
+
+	/* Write pack object header */
+	pack_header_len = encode_in_pack_object_header(pack_header,
+						       sizeof(pack_header),
+						       type, len);
+	fwrite_or_die(f, pack_header, pack_header_len);
+	algo->update_fn(pack_ctx, pack_header, pack_header_len);
+
+	/* Write the data as uncompressed zlib */
+	write_uncompressed_zlib(f, pack_ctx, data, len, algo);
+
+	algo->init_fn(&ctx);
+	object_header_len = format_object_header(object_header,
+						 sizeof(object_header),
+						 type, len);
+	algo->update_fn(&ctx, object_header, object_header_len);
+	if (data)
+		algo->update_fn(&ctx, data, len);
+	else {
+		for (size_t i = len / BLOCK_SIZE; i; i--)
+			algo->update_fn(&ctx, zeros, BLOCK_SIZE);
+		algo->update_fn(&ctx, zeros, len % BLOCK_SIZE);
+	}
+	algo->final_oid_fn(oid, &ctx);
+}
+
+/*
+ * Generate a pack file with a single large (>4GB) reachable object.
+ *
+ * Creates:
+ *   1. A large blob (all NUL bytes)
+ *   2. A tree containing that blob as "file"
+ *   3. A commit using that tree
+ *   4. The empty tree
+ *   5. A child commit using the empty tree
+ *
+ * This is useful for testing that Git can handle objects larger than 4GB.
+ */
+static int generate_pack_with_large_object(const char *path, size_t blob_size,
+					   const struct git_hash_algo *algo)
+{
+	FILE *f = xfopen(path, "wb");
+	struct git_hash_ctx pack_ctx;
+	unsigned char pack_hash[GIT_MAX_RAWSZ];
+	struct object_id blob_oid, tree_oid, commit_oid, empty_tree_oid, final_commit_oid;
+	struct strbuf buf = STRBUF_INIT;
+	const uint32_t object_count = 5;
+	struct pack_header pack_header = {
+		.hdr_signature = htonl(PACK_SIGNATURE),
+		.hdr_version = htonl(PACK_VERSION),
+		.hdr_entries = htonl(object_count),
+	};
+
+	algo->init_fn(&pack_ctx);
+
+	/* Write pack header */
+	fwrite_or_die(f, &pack_header, sizeof(pack_header));
+	algo->update_fn(&pack_ctx, &pack_header, sizeof(pack_header));
+
+	/* 1. Write the large blob */
+	write_pack_object(f, &pack_ctx, OBJ_BLOB, NULL, blob_size, &blob_oid, algo);
+
+	/* 2. Write tree containing the blob as "file" */
+	strbuf_addf(&buf, "100644 file%c", '\0');
+	strbuf_add(&buf, blob_oid.hash, algo->rawsz);
+	write_pack_object(f, &pack_ctx, OBJ_TREE, buf.buf, buf.len, &tree_oid, algo);
+
+	/* 3. Write commit using that tree */
+	strbuf_reset(&buf);
+	strbuf_addf(&buf,
+		    "tree %s\n"
+		    "author A U Thor <author@example.com> 1234567890 +0000\n"
+		    "committer C O Mitter <committer@example.com> 1234567890 +0000\n"
+		    "\n"
+		    "Large blob commit\n",
+		    oid_to_hex(&tree_oid));
+	write_pack_object(f, &pack_ctx, OBJ_COMMIT, buf.buf, buf.len, &commit_oid, algo);
+
+	/* 4. Write the empty tree */
+	write_pack_object(f, &pack_ctx, OBJ_TREE, "", 0, &empty_tree_oid, algo);
+
+	/* 5. Write final commit using empty tree, with previous commit as parent */
+	strbuf_reset(&buf);
+	strbuf_addf(&buf,
+		    "tree %s\n"
+		    "parent %s\n"
+		    "author A U Thor <author@example.com> 1234567890 +0000\n"
+		    "committer C O Mitter <committer@example.com> 1234567890 +0000\n"
+		    "\n"
+		    "Empty tree commit\n",
+		    oid_to_hex(&empty_tree_oid),
+		    oid_to_hex(&commit_oid));
+	write_pack_object(f, &pack_ctx, OBJ_COMMIT, buf.buf, buf.len, &final_commit_oid, algo);
+
+	/* Write pack trailer (checksum) */
+	algo->final_fn(pack_hash, &pack_ctx);
+	fwrite_or_die(f, pack_hash, algo->rawsz);
+	if (fclose(f))
+		die_errno(_("could not close '%s'"), path);
+
+	strbuf_release(&buf);
+
+	/* Print the final commit OID so caller can set up refs */
+	printf("%s\n", oid_to_hex(&final_commit_oid));
+
+	return 0;
+}
+
+static int cmd__synthesize__pack(int argc, const char **argv,
+				 const char *prefix UNUSED,
+				 struct repository *repo)
+{
+	int non_git;
+	int reachable_large = 0;
+	const struct git_hash_algo *algo;
+	size_t blob_size;
+	uintmax_t blob_size_u;
+	const char *path;
+	const char * const usage[] = {
+		"test-tool synthesize pack "
+		"--reachable-large <blob-size> <filename>",
+		NULL
+	};
+	struct option options[] = {
+		OPT_BOOL(0, "reachable-large", &reachable_large,
+			 N_("write a pack with a single reachable large blob")),
+		OPT_END()
+	};
+
+	setup_git_directory_gently(&non_git);
+	repo = the_repository;
+	algo = repo->hash_algo;
+
+	argc = parse_options(argc, argv, NULL, options, usage,
+			     PARSE_OPT_KEEP_ARGV0);
+	if (argc != 3 || !reachable_large)
+		usage_with_options(usage, options);
+
+	if (!git_parse_unsigned(argv[1], &blob_size_u,
+				maximum_unsigned_value_of_type(size_t)))
+		die(_("'%s' is not a valid blob size"), argv[1]);
+	blob_size = blob_size_u;
+	path = argv[2];
+
+	return !!generate_pack_with_large_object(path, blob_size, algo);
+}
+
+int cmd__synthesize(int argc, const char **argv)
+{
+	const char *prefix = NULL;
+	char const * const synthesize_usage[] = {
+		"test-tool synthesize pack <options>",
+		NULL,
+	};
+	parse_opt_subcommand_fn *fn = NULL;
+	struct option options[] = {
+		OPT_SUBCOMMAND("pack", &fn, cmd__synthesize__pack),
+		OPT_END()
+	};
+	argc = parse_options(argc, argv, prefix, options, synthesize_usage, 0);
+	return !!fn(argc, argv, prefix, NULL);
+}
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index a7abc618b3..b71a22b43b 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -82,6 +82,7 @@ static struct test_cmd cmds[] = {
 	{ "submodule-config", cmd__submodule_config },
 	{ "submodule-nested-repo-config", cmd__submodule_nested_repo_config },
 	{ "subprocess", cmd__subprocess },
+	{ "synthesize", cmd__synthesize },
 	{ "trace2", cmd__trace2 },
 	{ "truncate", cmd__truncate },
 	{ "userdiff", cmd__userdiff },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 7f150fa1eb..f2885b33d5 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -75,6 +75,7 @@ int cmd__submodule(int argc, const char **argv);
 int cmd__submodule_config(int argc, const char **argv);
 int cmd__submodule_nested_repo_config(int argc, const char **argv);
 int cmd__subprocess(int argc, const char **argv);
+int cmd__synthesize(int argc, const char **argv);
 int cmd__trace2(int argc, const char **argv);
 int cmd__truncate(int argc, const char **argv);
 int cmd__userdiff(int argc, const char **argv);
-- 
gitgitgadget

