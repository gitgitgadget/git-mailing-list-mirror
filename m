Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795571094;
	b=02IO8fTJBMaH0EPqKHffx4/EzGvNMxRwunxR/X3bq2OQKTmioqVr1sieiZ2j4lqV+AGh
	 oooiNWze6ZByjH6RJvPJ6LN2mTxQ6LT6OB3djBNVIvEazHAejSm3zMnsOSpXdMF9JzpMk
	 lfqy8otd4aalrc9U/51BWBu88fzo6H0Onpbe1RzHAMugJiGdApj03kIrEoTv3DD2c1Nbl
	 tkuLCx5Y3SwjSmi/YZPPGz1ZStlyREYnNw0Nmi79qFiA3lsWSJ8d3rq5H1olyDzlUQHOl
	 39TgVXDgM+VMUCPHgQ34of3NlFUdrg3EYt++OQECSSEP45bjjhOG24KuLtniatn2D1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795571094;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=/1k4GY+ISFlN6y2mzAcBTRTM0d0Jb9N6TJPEmCCMIhY=;
	b=1rNmpAgcwLHQ8fC5/eiXnnR8OLjr/1hzMc5EMvyh1W70CE5g6XOTfSMhUorx3nkixd5r
	 7dX8/6cwz1yrF4HB/EOlpbAfPgmEPowuqQjM8tvnNsJenZYYaF6XGxW8jP9apzEoUdwzG
	 bb3/Qr0Gxt3unjHw+DYcnL069iUDA1tAIk65l2wqRUfvkBORcMaIqZrSPw2QsTD1CSOpH
	 VxAInAaivoFNpAztHF8bxNXTrXfyqFuNc4jY5oNOseCbalelqNoYQMWEQ5fFlKAoQ335/
	 nEIA0Lpj0/0DKt6YHeMW79Dx4OzsOfB9U5eEZj7XKHOZgBYY3eHaSLMUKHf7L1OWL0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="C65DkRO/";
	arc=none smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8CD606A327
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 01:44:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A8CD606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C65DkRO/
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3b4cd193b50so910442a91.1
        for <git@vger.kernel.org>; Tue, 24 Nov 2026 17:44:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795571093; x=1796175893; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/1k4GY+ISFlN6y2mzAcBTRTM0d0Jb9N6TJPEmCCMIhY=;
        b=C65DkRO/rT89I3iEy4XbXDK1UpXTZNS6bDKgsDyLlUTqN17xC2zS9zSB9p2Sc6adVG
         T6hgs7piFKwVi43sXIg7obj6GyVhcq7BPc93Mutcb2g7azf/6AAzcGM9QAjAk+Hhn0Aw
         QqgmxshjF6jCC5vciwhN0nUDxOA93eBXop9K4X4LRx0Ob21dYAgefQBu2Lx2v2fLlu5d
         i0UQVTmxIYwZkt6momAHXGmT5StaGljGEibD2KXl/n+SSIt5xH0gOywUv6NBnwro4e9d
         IYKrIGh8UdLEBqZZXt/gSrUDZU+aDxLxrpNrx6vHw2cE1uDQdNFUT+usbYSpfkI/CLRU
         PTTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795571093; x=1796175893;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/1k4GY+ISFlN6y2mzAcBTRTM0d0Jb9N6TJPEmCCMIhY=;
        b=xsJ/0szHSa9K6dtAOTurLbPMgDUAAwYz1tHpPier5XBAWWLFbCq+4DfSLaaWiG6Vsm
         xPiTGcJy4PkYLn70rFcNVnE25XiH9VnJJgB5npVZOaPFm06XKO9nNtLQAZNPyFHS1A3O
         x8zskbXWHT6t5GC3z/W1uVU7WzuC7mr5W5T/Qo/nma7z8qpaVgDzXA24Wl/mcKTmaX8Y
         V7iO1fYg/KQ0cdQORxbGNBjXwSxmU+i4C+rB3jgOSV+XEAVqbZZxkWlng6MxhdZvWrv1
         qTyMXZK/3lwBdDBoTVckfMU6j/KxqiR0YcNcjNvU/Pk2GEiVDVD5vfmTc4F/WAtuf2M+
         gfIQ==
X-Gm-Message-State: APuU4Z8hGfVCbwOPmyCj1RhOZDjbW0ZvW2kgTJ5YIILq2ymUttUEH6LI
	G/13w9fkTQchFU0rpOGlio27m45duLXHW+weqT6yBiWmdga06L2I23KBBIOIJw==
X-Gm-Gg: AZFdTZduUbAF39jyko3bpdAnxN6nQPKC73AC4RGvEcQ/Zbmpde/ieQ3n/AjLkoZCvJb
	VHgvJ1TfoxLjcwXO6tbGMGozVEVaInetisqNb/1bZjSW0GEzAa7/uc7kl6N2isRmBQ5ZSNoN8le
	NSmv4FIEVlja4iAsHmXquAT0MiLpI1ZCDwOJPj8NlWE82d2KMDwk9vQaVr05MqqXj72NCtZEOwt
	eEsj9bytKgD1KzT1A4hRbaDssS21anP/BTjQ+I5izQ357oYGN2jBHwtYiX4QO0SJginXqAWrVAK
	ttmpTkDarxr/Tzrho+/ijPpvLxf7zIXjOKpVH3ZRkK+lG0s3fj0Uy6Nj/NZJqPeFTAXEXE3VUqM
	ASUuH7K0mKL3qy+Omnh17RZ2Mv++UnvXWr86Lz2RpZ+4bk44ZmOW9P8vKw337x8Ug4/XEDwK8BF
	/KPIKPKaL4PAIhaIpwe6VJIb0p8NshtJ5vq4yhjtjJq6RYBufMlpZdeUfz7FG2P3zniHMNdNQMW
	S7jT9mcBqpbRXV64vymCHEORweW0J9J03lLDDUufPCVZCnEh2x205cNjf0dBLoEmkeCbNl+kXE4
	MwusR4N9RB9Kmzw7GT9AHjeNNaA6dA==
X-Received: by 2002:a17:90b:3d92:b0:3b3:b621:4026 with SMTP id 98e67ed59e1d1-3b41c55a4aemr15545356a91.0.1795571093405;
        Tue, 24 Nov 2026 17:44:53 -0800 (PST)
Received: from [127.0.0.1] ([4.242.29.42])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b44b7d36bcsm10485779a91.3.2026.11.24.17.44.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 17:44:52 -0800 (PST)
Message-Id: <4157ce33a1d6c392575cc27fee7c6bd3126e97c6.1795571091.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2314.v2.git.1795571091.gitgitgadget@gmail.com>
References: <pull.2314.git.1794607911.gitgitgadget@gmail.com>
	<pull.2314.v2.git.1795571091.gitgitgadget@gmail.com>
From: "Adithya Chakilam via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 25 Nov 2026 01:44:50 +0000
Subject: [PATCH v2 1/2] repack: add --filter-to-loose to write filtered-out
 objects as loose objects
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
Cc: Martin Fick <mfick@nvidia.com>,
    Christian Couder <christian.couder@gmail.com>,
    Adithya Chakilam <achakilam@nvidia.com>,
    Adithya Chakilam <achakilam@nvidia.com>

From: Adithya Chakilam <achakilam@nvidia.com>

Some external object stores (like key-value) manage and retrieve git
objects individually. Although repack's --filter-to option can separate
objects from the main object store, it writes them into packs. Using
those objects individually then requires an additional unpacking step.

Add --filter-to-loose=<dir> to write filtered-out objects directly as
loose objects into <dir>, treating it as an object directory. Stream
the filtered pack into unpack-objects instead of writing an intermediate
pack file to disk.

The filtered pack is built with --stdin-packs, so this initially handles
only objects already stored in packs. Loose objects in the source
repository are left in place.

Signed-off-by: Adithya Chakilam <achakilam@nvidia.com>
---
 Documentation/git-repack.adoc |  11 ++-
 builtin/repack.c              |  25 ++++-
 repack-filtered.c             |  44 ++++++++-
 repack.h                      |   1 +
 t/t7700-repack.sh             | 172 ++++++++++++++++++++++++++++++++++
 5 files changed, 246 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-repack.adoc b/Documentation/git-repack.adoc
index a1f9e64f66..bcd7c1fe54 100644
--- a/Documentation/git-repack.adoc
+++ b/Documentation/git-repack.adoc
@@ -12,7 +12,7 @@ SYNOPSIS
 'git repack' [-a] [-A] [-d] [-f] [-F] [-l] [-n] [-q] [-b] [-m]
 	[--window=<n>] [--depth=<n>] [--threads=<n>] [--keep-pack=<pack-name>]
 	[--write-midx[=<mode>]] [--name-hash-version=<n>] [--path-walk]
-	[--filter=<filter-spec>] [--drop-filtered [--dry-run]]
+	[--filter=<filter-spec> [--filter-to-loose=<directory>]] [--drop-filtered [--dry-run]]
 
 DESCRIPTION
 -----------
@@ -183,6 +183,15 @@ depth is 4095.
 	`objects` and `objects/info/alternates` sections of
 	linkgit:gitrepository-layout[5].
 
+--filter-to-loose=<directory>::
+	Like `--filter-to`, but treat `<directory>` as an object
+	directory and write the filtered out objects there as loose
+	objects instead of as a pack. The directory must already
+	exist. Cannot be combined with `--filter-to` or
+	`--max-pack-size`. Objects already present in `<directory>` are
+	not rewritten. All objects are written before any existing
+	pack is removed.
+
 --drop-filtered::
 	Delete the local objects that match the `--filter` specification
 	instead of keeping them in a separate packfile, reclaiming the
diff --git a/builtin/repack.c b/builtin/repack.c
index 21835453c6..dc2b4a3ce2 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -1,6 +1,7 @@
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "builtin.h"
+#include "abspath.h"
 #include "config.h"
 #include "environment.h"
 #include "parse-options.h"
@@ -41,7 +42,7 @@ static const char *const git_repack_usage[] = {
 	N_("git repack [-a] [-A] [-d] [-f] [-F] [-l] [-n] [-q] [-b] [-m]\n"
 	   "[--window=<n>] [--depth=<n>] [--threads=<n>] [--keep-pack=<pack-name>]\n"
 	   "[--write-midx[=<mode>]] [--name-hash-version=<n>] [--path-walk]\n"
-	   "[--filter=<filter-spec>] [--drop-filtered [--dry-run]]"),
+	   "[--filter=<filter-spec> [--filter-to-loose=<directory>]] [--drop-filtered [--dry-run]]"),
 	NULL
 };
 
@@ -182,6 +183,7 @@ int cmd_repack(int argc,
 	const char *cruft_expiration = NULL;
 	const char *expire_to = NULL;
 	const char *filter_to = NULL;
+	const char *filter_to_loose = NULL;
 	const char *opt_window = NULL;
 	const char *opt_window_memory = NULL;
 	const char *opt_depth = NULL;
@@ -257,6 +259,8 @@ int cmd_repack(int argc,
 			   N_("pack prefix to store a pack containing pruned objects")),
 		OPT_STRING(0, "filter-to", &filter_to, N_("dir"),
 			   N_("pack prefix to store a pack containing filtered out objects")),
+		OPT_FILENAME(0, "filter-to-loose", &filter_to_loose,
+			   N_("object directory to write filtered out objects into as loose objects")),
 		OPT_BOOL(0, "drop-filtered", &drop_filtered,
 				N_("delete filtered out objects (requires --filter)")),
 		OPT_BOOL(0, "dry-run", &dry_run,
@@ -282,8 +286,19 @@ int cmd_repack(int argc,
 	po_args.depth = xstrdup_or_null(opt_depth);
 	po_args.threads = xstrdup_or_null(opt_threads);
 
-	die_for_incompatible_opt2(drop_filtered, "--drop-filtered",
-		!!filter_to, "--filter-to");
+	die_for_incompatible_opt3(drop_filtered, "--drop-filtered",
+			!!filter_to, "--filter-to",
+			!!filter_to_loose, "--filter-to-loose");
+	die_for_incompatible_opt2(!!filter_to, "--filter-to",
+			!!filter_to_loose, "--filter-to-loose");
+	die_for_incompatible_opt2(!!filter_to_loose, "--filter-to-loose",
+			!!po_args.max_pack_size, "--max-pack-size");
+
+	if (filter_to_loose) {
+		if (!is_directory(filter_to_loose))
+			die(_("'%s' is not a directory"), filter_to_loose);
+		filter_to = filter_to_loose;
+	}
 
 	if (dry_run && !drop_filtered)
 		die(_("--dry-run only takes effect with --drop-filtered"));
@@ -553,7 +568,8 @@ int cmd_repack(int argc,
 		strvec_pushf(&cmd.args, "--filter=%s",
 			     expand_list_objects_filter_spec(&po_args.filter_options));
 	else if (filter_to)
-		die(_("option '%s' can only be used along with '%s'"), "--filter-to", "--filter");
+		die(_("option '%s' can only be used along with '%s'"),
+		    filter_to_loose ? "--filter-to-loose" : "--filter-to", "--filter");
 
 	if (geometry.split_factor)
 		cmd.in = -1;
@@ -698,6 +714,7 @@ int cmd_repack(int argc,
 		struct write_pack_opts opts = {
 			.po_args = &po_args,
 			.destination = filter_to,
+			.loose = !!filter_to_loose,
 			.packdir = packdir,
 			.packtmp = packtmp,
 		};
diff --git a/repack-filtered.c b/repack-filtered.c
index 869b9fc6e3..b33274b5b8 100644
--- a/repack-filtered.c
+++ b/repack-filtered.c
@@ -9,19 +9,40 @@
 #include "list-objects-filter.h"
 #include "odb.h"
 #include "promisor-remote.h"
+#include "sigchain.h"
+
+static void start_unpack_objects(struct child_process *unpack,
+				 const char *objdir)
+{
+	strvec_push(&unpack->args, "unpack-objects");
+	strvec_push(&unpack->args, "-q");
+	strvec_pushf(&unpack->env, "GIT_OBJECT_DIRECTORY=%s", objdir);
+	strvec_push(&unpack->env, "GIT_ALTERNATE_OBJECT_DIRECTORIES");
+	unpack->git_cmd = 1;
+	unpack->in = -1;
+	if (start_command(unpack))
+		die(_("could not start unpack-objects for '%s'"), objdir);
+}
 
 int write_filtered_pack(const struct write_pack_opts *opts,
 			struct existing_packs *existing,
 			struct string_list *names)
 {
 	struct child_process cmd = CHILD_PROCESS_INIT;
+	struct child_process unpack = CHILD_PROCESS_INIT;
 	struct string_list_item *item;
 	FILE *in;
 	int ret;
 	const char *caret;
 	const char *pack_prefix = write_pack_opts_pack_prefix(opts);
 
-	prepare_pack_objects(&cmd, opts->po_args, opts->destination);
+	if (opts->loose) {
+		sigchain_push(SIGPIPE, SIG_IGN);
+		start_unpack_objects(&unpack, opts->destination);
+		prepare_pack_objects(&cmd, opts->po_args, "--stdout");
+	} else {
+		prepare_pack_objects(&cmd, opts->po_args, opts->destination);
+	}
 
 	strvec_push(&cmd.args, "--stdin-packs");
 
@@ -29,10 +50,18 @@ int write_filtered_pack(const struct write_pack_opts *opts,
 		strvec_pushf(&cmd.args, "--keep-pack=%s", item->string);
 
 	cmd.in = -1;
+	if (opts->loose)
+		cmd.out = unpack.in;
 
 	ret = start_command(&cmd);
-	if (ret)
+	if (ret) {
+		if (opts->loose) {
+			/* start_command() already closed cmd.out, i.e. unpack.in */
+			finish_command(&unpack);
+			sigchain_pop(SIGPIPE);
+		}
 		return ret;
+	}
 
 	/*
 	 * Here 'names' contains only the pack(s) that were just
@@ -52,6 +81,17 @@ int write_filtered_pack(const struct write_pack_opts *opts,
 		fprintf(in, "%s%s.pack\n", caret, item->string);
 	fclose(in);
 
+	if (opts->loose) {
+		ret = finish_command(&cmd);
+		if (finish_command(&unpack))
+			ret = -1;
+		sigchain_pop(SIGPIPE);
+		if (ret)
+			ret = error(_("failed to write filtered out objects to '%s'"),
+				    opts->destination);
+		return ret;
+	}
+
 	return finish_pack_objects_cmd(existing->repo->hash_algo, opts, &cmd,
 				       names);
 }
diff --git a/repack.h b/repack.h
index 61e554e4ed..d5528745ec 100644
--- a/repack.h
+++ b/repack.h
@@ -41,6 +41,7 @@ void repack_remove_redundant_pack(struct repository *repo, const char *dir_name,
 struct write_pack_opts {
 	struct pack_objects_args *po_args;
 	const char *destination;
+	bool loose;
 	const char *packdir;
 	const char *packtmp;
 };
diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index f0a390e3c6..1b74d40551 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -489,6 +489,178 @@ test_expect_success '--filter-to stores filtered out objects' '
 	test "$blob_content" = "content1"
 '
 
+test_expect_success '--filter-to-loose writes filtered out objects loose' '
+	rm -rf loose-work loose-src.git loose-dst.git &&
+	git init --bare loose-dst.git &&
+	git init loose-work &&
+	test_commit -C loose-work base file1 content1 &&
+	git clone --bare loose-work loose-src.git &&
+	git -C loose-src.git repack -a -d &&
+
+	blob=$(git -C loose-src.git rev-parse HEAD:file1) &&
+	git -C loose-src.git -c repack.writebitmaps=false repack -a -d \
+		--filter=blob:none --filter-to-loose=../loose-dst.git/objects &&
+
+	test_path_is_file loose-dst.git/objects/$(test_oid_to_path $blob) &&
+	find loose-dst.git/objects/pack -name "*.pack" >actual-packs &&
+	test_must_be_empty actual-packs &&
+	test_must_fail git -C loose-src.git cat-file -e $blob &&
+
+	echo $(pwd)/loose-dst.git/objects >loose-src.git/objects/info/alternates &&
+	echo content1 >expect &&
+	git -C loose-src.git cat-file blob $blob >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '--filter-to-loose writes objects that also exist in the source' '
+	rm -rf loose-work loose-src.git loose-dst.git &&
+	git init --bare loose-dst.git &&
+	git init loose-work &&
+	test_commit -C loose-work base file1 content1 &&
+	git clone --bare loose-work loose-src.git &&
+	git -C loose-src.git repack -a -d &&
+
+	blob=$(git -C loose-src.git rev-parse HEAD:file1) &&
+	git -C loose-src.git -c repack.writebitmaps=false repack -a -d \
+		--filter=blob:none --filter-to-loose=../loose-dst.git/objects &&
+
+	test_path_is_file loose-dst.git/objects/$(test_oid_to_path $blob)
+'
+
+# Create loose-work/loose-src.git/loose-dst.git; $big is a 2k blob on
+# refs/heads/big in loose-src.git, packed unless $1 is "loose".
+setup_loose_src () {
+	rm -rf loose-work loose-src.git loose-dst.git &&
+	git init --bare loose-dst.git &&
+	git init loose-work &&
+	test_commit -C loose-work base small small &&
+	git clone --bare loose-work loose-src.git &&
+
+	big=$(test-tool genrandom big 2k | git -C loose-src.git hash-object -w --stdin) &&
+	tree=$(printf "100644 blob %s\tbig\n" $big | git -C loose-src.git mktree) &&
+	commit=$(git -C loose-src.git commit-tree -m big $tree) &&
+	git -C loose-src.git update-ref refs/heads/big $commit &&
+
+	if test "$1" != loose
+	then
+		git -C loose-src.git repack -a -d
+	fi
+}
+
+test_expect_success '--filter-to-loose requires an existing directory' '
+	setup_loose_src &&
+
+	ls loose-src.git/objects/pack/*.pack >packs-before &&
+	test_must_fail git -C loose-src.git -c repack.writebitmaps=false \
+		repack -a -d --filter=blob:limit=1k \
+		--filter-to-loose=../no-such-dir 2>err &&
+	test_grep "no-such-dir.*is not a directory" err &&
+	test_path_is_missing no-such-dir &&
+
+	ls loose-src.git/objects/pack/*.pack >packs-after &&
+	test_cmp packs-before packs-after &&
+	git -C loose-src.git cat-file -e $big
+'
+
+test_expect_success POSIXPERM,SANITY '--filter-to-loose failure to write leaves the source intact' '
+	setup_loose_src &&
+	mkdir read-only &&
+	chmod a-w read-only &&
+	test_when_finished "chmod u+w read-only" &&
+
+	ls loose-src.git/objects/pack/*.pack >packs-before &&
+	test_must_fail git -C loose-src.git -c repack.writebitmaps=false \
+		repack -a -d --filter=blob:limit=1k \
+		--filter-to-loose=../read-only &&
+
+	ls loose-src.git/objects/pack/*.pack >packs-after &&
+	test_cmp packs-before packs-after &&
+
+	find loose-src.git/objects/pack -name ".tmp-*" >tmp-leftovers &&
+	test_must_be_empty tmp-leftovers &&
+	git -C loose-src.git cat-file -e $big
+'
+
+test_expect_success '--filter-to-loose resolves a relative path from a subdirectory' '
+	rm -rf sub-work extra-loose-objects &&
+	git init sub-work &&
+	test-tool genrandom big 2k >sub-work/big &&
+	git -C sub-work add big &&
+	test_tick &&
+	git -C sub-work commit -m big &&
+	big=$(git -C sub-work rev-parse HEAD:big) &&
+	# objects in the index are never filtered out
+	git -C sub-work update-index --force-remove big &&
+	git -C sub-work repack -a -d &&
+
+	mkdir extra-loose-objects &&
+	mkdir -p sub-work/sub/dir &&
+	(
+		cd sub-work/sub/dir &&
+		git -c repack.writebitmaps=false repack -a -d \
+			--filter=blob:limit=1k \
+			--filter-to-loose=../../../extra-loose-objects
+	) &&
+
+	test_path_is_file extra-loose-objects/$(test_oid_to_path $big)
+'
+
+test_expect_success '--filter-to-loose does not move objects from kept packs' '
+	setup_loose_src &&
+
+	for p in loose-src.git/objects/pack/pack-*.pack
+	do
+		>${p%.pack}.keep || return 1
+	done &&
+
+	git -C loose-src.git -c repack.writebitmaps=false repack -a -d \
+		--filter=blob:limit=1k --filter-to-loose=../loose-dst.git/objects &&
+
+	test_path_is_missing loose-dst.git/objects/$(test_oid_to_path $big) &&
+	git -C loose-src.git cat-file -e $big
+'
+
+test_expect_success '--filter-to-loose leaves unreachable objects in cruft packs alone' '
+	setup_loose_src loose &&
+	git -C loose-src.git update-ref -d refs/heads/big &&
+	git -C loose-src.git repack --cruft -d &&
+
+	git -C loose-src.git -c repack.writebitmaps=false repack -a -d --cruft \
+		--filter=blob:limit=1k --filter-to-loose=../loose-dst.git/objects &&
+
+	test_path_is_missing loose-dst.git/objects/$(test_oid_to_path $big) &&
+	git -C loose-src.git cat-file -e $big
+'
+
+test_expect_success '--filter-to-loose output survives gc and prune of the source' '
+	setup_loose_src &&
+
+	git -C loose-src.git -c repack.writebitmaps=false repack -a -d \
+		--filter=blob:limit=1k --filter-to-loose=../loose-dst.git/objects &&
+
+	echo $(pwd)/loose-dst.git/objects >loose-src.git/objects/info/alternates &&
+	git -C loose-src.git gc --prune=now &&
+	git -C loose-src.git prune --expire=now &&
+
+	git -C loose-src.git fsck &&
+	git -C loose-src.git cat-file -e $big &&
+	test_path_is_file loose-dst.git/objects/$(test_oid_to_path $big)
+'
+
+test_expect_success '--filter-to-loose requires --filter, rejects --filter-to and --max-pack-size' '
+	mkdir -p x y &&
+	test_must_fail git -C bare.git repack -a --filter-to-loose=../x 2>err &&
+	test_grep "can only be used along with" err &&
+
+	test_must_fail git -C bare.git repack -a --filter=blob:none \
+		--filter-to=../y --filter-to-loose=../x 2>err &&
+	test_grep "cannot be used together" err &&
+
+	test_must_fail git -C bare.git repack -a --filter=blob:none \
+		--filter-to-loose=../x --max-pack-size=1M 2>err &&
+	test_grep "cannot be used together" err
+'
+
 test_expect_success '--filter works with --max-pack-size' '
 	rm -rf filtered.git &&
 	git init --bare filtered.git &&
-- 
gitgitgadget

