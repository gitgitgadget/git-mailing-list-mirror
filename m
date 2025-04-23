Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0CE28BAB3
	for <git@vger.kernel.org>; Wed, 23 Apr 2025 17:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745430010; cv=none; b=NBCz5+ttrNNGwD21LvaofyWVVmre5oHETILCFs26c5k+VN1U8p/gLJzwg/YK+foFzu6wmBekD2pXG1Wi43SuivJEJOKGSBOcPVR3cXBPxCaWPblwkYzrSTP2tDdt8wbwlj47arz3qZWb4yyLPZtcPGQJuXBERWPQc0KX/VqJ5cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745430010; c=relaxed/simple;
	bh=uPgSEPUzOOI40RcLlnSeM/Z8edFbJf9aG141sKTFbKo=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=tPRXx5Ex8bqA/H8C8v+Kken9rgd2FvR/PRhk36Zi22+GCAx7FnSl2P3Y4QwSKiymhAlfjA69M5hU6Uow1T5dVINSgL+nPStZm09ypOHq/D5iqUEkVEawyiNGMYOUnpCYfzKKXKhcvw3lopu9BevXxDXcv3V8BqMd7dHpFdacKcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VdgqpgBN; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VdgqpgBN"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43690d4605dso939945e9.0
        for <git@vger.kernel.org>; Wed, 23 Apr 2025 10:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745430006; x=1746034806; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=79eS/VHH+zSRaczXSsd0lXmB3DLAdRxku9qst3Veh7o=;
        b=VdgqpgBND3yI+7T2O3CnjV2/JSiWJysrHSbh8JUJ7mzViHDwVTis7YuWrpnBIo+H0I
         ZXZfKqPAIcwRFytVI1Pe3weAJfYCO1gvTRxdIL/kUhSFxEu1+Bf79oD/MMGinX7YN1oP
         wF6RGPc7EKaE6Jh2PBjCuqe4z98LKzpQ6Rm/1zgt/N8S+PwYzCZkNqBYCPUyww/SeImP
         zvCG59irz14wTfpnihVIGpoUR107WcoUmsqc7YfqIOGGuVm2/kM/AKT+4jzXQSVfH49p
         tAFEjg4Nal5GHPEhwQMxlERuJXTbqfpYwEOidGi91CeEvIgRIvspq8fwPBs0weTDHaBS
         r4DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745430006; x=1746034806;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=79eS/VHH+zSRaczXSsd0lXmB3DLAdRxku9qst3Veh7o=;
        b=CbHXcAQuJJWrvHC4SZgjxMF6sBDiYsfK5zCstpkIwuumD+NhPQUwya9MJ7LynZKKuy
         j//EIrQ2vmcw6tQz0CMsjuEeX4UglTE5WdBCDIL50LaKjVq9Pwc2zgNeRm4SldvhKZww
         gOPbLrln8FDPvu55z62/rRLYbj3YEIl2nMGRmmEU2KGBnhE6vfsiKqKLmnaLir1lBxd5
         IenpZUNr5HWdrvOnoquxpIgL7ZG7lTkSqZifPCrWPsQlyp5Op0wE9b2wcg8l6rv5MZOP
         vFQbKOxrU89zAVGPdxIxN8N8SIzEhEklQYQXIswFiNynEaRFBI6nvdvK+YQ98ib9pSog
         Qc8Q==
X-Gm-Message-State: AOJu0YxcimguQboKzDOQebXKeS0R0vewcHv867mpBx1HjaBjeLg1YzMo
	MyGLwTenoUNWgm/IYRUGAWFwJK8vUCp6HICJvgNLPKAkweuxNgtR0LxvPw==
X-Gm-Gg: ASbGncvX2TfzkNnL1YvCVtUk6r3VrJqgzUZu2dP91/wqy7hwDdnTr9bKrkn6AqQcZjD
	d5kVtJ6otry/DihdxXkJtP9mVcuCKgo/8+5k6lTxm6PuYwLwOM2j8X7Z5QsTWVegV64gP/8xyqJ
	0euNtP8P2ZbfwNjxdGF5ukwjEnUeZBSsbG3B0seNBmK+H4FCxqCdN62wLcEBTFsj2J8/xDHLaSq
	2vBJvfuB3bOtLnVlKFocMTlG3Ucu3S185Yt7gAKiHej663f36DofXzfWLmOspw1LHpYHp6p11Xg
	CW0AJ6vG72WY/2Ye3rV1GO3GE2xACbYi7/g6QQpuGQ==
X-Google-Smtp-Source: AGHT+IHLRkGYiR1U0bOhkfk9/rbUw4JC+4Q2zwNgyD3BZ8r+5ycy9fl8pKlNRGC1+31hXQP0XLOHPw==
X-Received: by 2002:a05:600c:1c2a:b0:43c:fb36:d296 with SMTP id 5b1f17b1804b1-4406ac0a9c8mr164801375e9.25.1745430006111;
        Wed, 23 Apr 2025 10:40:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-44092d2edf9sm33031425e9.21.2025.04.23.10.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 10:40:05 -0700 (PDT)
Message-Id: <5d4beb202d6ed842de72928462a10a4f5faa2718.1745430004.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1906.git.1745430004.gitgitgadget@gmail.com>
References: <pull.1906.git.1745430004.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 23 Apr 2025 17:40:02 +0000
Subject: [PATCH 1/3] test-tool: add pack-deltas helper
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
Cc: gitster@pobox.com,
    peff@peff.net,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

When trying to demonstrate certain behavior in tests, it can be helpful
to create packfiles that have specific delta structures. 'git
pack-objects' uses various algorithms to select deltas based on their
compression rates, but that does not always demonstrate all possible
packfile shapes. This becomes especially important when wanting to test
'git index-pack' and its ability to parse certain pack shapes.

We have prior art in t/lib-pack.sh, where certain delta structures are
produced by manually writing certain opaque pack contents. However,
producing these script updates is cumbersome and difficult to do as a
contributor.

Instead, create a new test-tool, 'test-tool pack-deltas', that reads a
list of instructions for which objects to include in a packfile and how
those objects should be written in delta form.

At the moment, this only supports REF_DELTAs as those are the kinds of
deltas needed to exercise a bug in 'git index-pack'.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 Makefile                    |   1 +
 t/helper/meson.build        |   1 +
 t/helper/test-pack-deltas.c | 140 ++++++++++++++++++++++++++++++++++++
 t/helper/test-tool.c        |   1 +
 t/helper/test-tool.h        |   1 +
 5 files changed, 144 insertions(+)
 create mode 100644 t/helper/test-pack-deltas.c

diff --git a/Makefile b/Makefile
index 13f9062a056..c4d21ccd3d1 100644
--- a/Makefile
+++ b/Makefile
@@ -821,6 +821,7 @@ TEST_BUILTINS_OBJS += test-mergesort.o
 TEST_BUILTINS_OBJS += test-mktemp.o
 TEST_BUILTINS_OBJS += test-name-hash.o
 TEST_BUILTINS_OBJS += test-online-cpus.o
+TEST_BUILTINS_OBJS += test-pack-deltas.o
 TEST_BUILTINS_OBJS += test-pack-mtimes.o
 TEST_BUILTINS_OBJS += test-parse-options.o
 TEST_BUILTINS_OBJS += test-parse-pathspec-file.o
diff --git a/t/helper/meson.build b/t/helper/meson.build
index d2cabaa2bcf..d4e8b26df8d 100644
--- a/t/helper/meson.build
+++ b/t/helper/meson.build
@@ -36,6 +36,7 @@ test_tool_sources = [
   'test-mktemp.c',
   'test-name-hash.c',
   'test-online-cpus.c',
+  'test-pack-deltas.c',
   'test-pack-mtimes.c',
   'test-parse-options.c',
   'test-parse-pathspec-file.c',
diff --git a/t/helper/test-pack-deltas.c b/t/helper/test-pack-deltas.c
new file mode 100644
index 00000000000..db7d1c3cd1f
--- /dev/null
+++ b/t/helper/test-pack-deltas.c
@@ -0,0 +1,140 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
+#include "test-tool.h"
+#include "git-compat-util.h"
+#include "delta.h"
+#include "git-zlib.h"
+#include "hash.h"
+#include "hex.h"
+#include "pack.h"
+#include "pack-objects.h"
+#include "setup.h"
+#include "strbuf.h"
+#include "string-list.h"
+
+static const char usage_str[] = "test-tool pack-deltas <n>";
+
+static unsigned long do_compress(void **pptr, unsigned long size)
+{
+	git_zstream stream;
+	void *in, *out;
+	unsigned long maxsize;
+
+	git_deflate_init(&stream, 1);
+	maxsize = git_deflate_bound(&stream, size);
+
+	in = *pptr;
+	out = xmalloc(maxsize);
+	*pptr = out;
+
+	stream.next_in = in;
+	stream.avail_in = size;
+	stream.next_out = out;
+	stream.avail_out = maxsize;
+	while (git_deflate(&stream, Z_FINISH) == Z_OK)
+		; /* nothing */
+	git_deflate_end(&stream);
+
+	free(in);
+	return stream.total_out;
+}
+
+static void write_ref_delta(struct hashfile *f,
+			    struct object_id *oid,
+			    struct object_id *base)
+{
+	unsigned char header[MAX_PACK_OBJECT_HEADER];
+	unsigned long size, base_size, delta_size, compressed_size, hdrlen;
+	enum object_type type;
+	void *base_buf, *delta_buf;
+	void *buf = repo_read_object_file(the_repository,
+					  oid, &type,
+					  &size);
+
+	if (!buf)
+		die("unable to read %s", oid_to_hex(oid));
+
+	base_buf = repo_read_object_file(the_repository,
+					 base, &type,
+					 &base_size);
+
+	if (!base_buf)
+		die("unable to read %s", oid_to_hex(base));
+
+	delta_buf = diff_delta(base_buf, base_size,
+			       buf, size, &delta_size, 0);
+
+	compressed_size = do_compress(&delta_buf, delta_size);
+
+	hdrlen = encode_in_pack_object_header(header, sizeof(header),
+					      OBJ_REF_DELTA, delta_size);
+	hashwrite(f, header, hdrlen);
+	hashwrite(f, base->hash, the_repository->hash_algo->rawsz);
+	hashwrite(f, delta_buf, compressed_size);
+
+	free(buf);
+	free(base_buf);
+	free(delta_buf);
+}
+
+int cmd__pack_deltas(int argc, const char **argv)
+{
+	int N;
+	struct hashfile *f;
+	struct strbuf line = STRBUF_INIT;
+
+	if (argc != 2) {
+		usage(usage_str);
+		return -1;
+	}
+
+	N = atoi(argv[1]);
+
+	setup_git_directory();
+
+	f = hashfd(the_repository->hash_algo, 1, "<stdout>");
+	write_pack_header(f, N);
+
+	/* Read each line from stdin into 'line' */
+	while (strbuf_getline_lf(&line, stdin) != EOF) {
+		const char *type_str, *content_oid_str, *base_oid_str = NULL;
+		struct object_id content_oid, base_oid;
+		struct string_list items = STRING_LIST_INIT_NODUP;
+		/*
+		 * Tokenize into two or three parts:
+		 * 1. REF_DELTA, OFS_DELTA, or FULL.
+		 * 2. The object ID for the content object.
+		 * 3. The object ID for the base object (optional).
+		 */
+		if (string_list_split_in_place(&items, line.buf, " ", 3) < 0)
+			die("invalid input format: %s", line.buf);
+
+		if (items.nr < 2)
+			die("invalid input format: %s", line.buf);
+
+		type_str = items.items[0].string;
+		content_oid_str = items.items[1].string;
+
+		if (get_oid_hex(content_oid_str, &content_oid))
+			die("invalid object: %s", content_oid_str);
+		if (items.nr >= 3) {
+			base_oid_str = items.items[2].string;
+			if (get_oid_hex(base_oid_str, &base_oid))
+				die("invalid object: %s", base_oid_str);
+		}
+
+		if (!strcmp(type_str, "REF_DELTA"))
+			write_ref_delta(f, &content_oid, &base_oid);
+		else if (!strcmp(type_str, "OFS_DELTA"))
+			die("OFS_DELTA not implemented");
+		else if (!strcmp(type_str, "FULL"))
+			die("FULL not implemented");
+		else
+			die("unknown pack type: %s", type_str);
+	}
+
+	finalize_hashfile(f, NULL, FSYNC_COMPONENT_PACK,
+			  CSUM_HASH_IN_STREAM | CSUM_FSYNC | CSUM_CLOSE);
+	strbuf_release(&line);
+	return 0;
+}
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 50dc4dac4ed..74812ed86d3 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -46,6 +46,7 @@ static struct test_cmd cmds[] = {
 	{ "mktemp", cmd__mktemp },
 	{ "name-hash", cmd__name_hash },
 	{ "online-cpus", cmd__online_cpus },
+	{ "pack-deltas", cmd__pack_deltas },
 	{ "pack-mtimes", cmd__pack_mtimes },
 	{ "parse-options", cmd__parse_options },
 	{ "parse-options-flags", cmd__parse_options_flags },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 6d62a5b53d9..2571a3ccfe8 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -39,6 +39,7 @@ int cmd__mergesort(int argc, const char **argv);
 int cmd__mktemp(int argc, const char **argv);
 int cmd__name_hash(int argc, const char **argv);
 int cmd__online_cpus(int argc, const char **argv);
+int cmd__pack_deltas(int argc, const char **argv);
 int cmd__pack_mtimes(int argc, const char **argv);
 int cmd__parse_options(int argc, const char **argv);
 int cmd__parse_options_flags(int argc, const char **argv);
-- 
gitgitgadget

